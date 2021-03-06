#' Plot new infection events by sex.
#'
#'
#' @param dat tracking.inf as provided as output from the CWD model functions
#'
#' @return a plot of infection events by sex-based transmission category
#'
#' @import ggplot2
#' @import dplyr
#' @importFrom magrittr %>%
#' @importFrom forcats fct_recode fct_reorder
#' @examples
#' params <- list(fawn.an.sur = 0.6, juv.an.sur = 0.8, ad.an.f.sur = 0.95, 
#' ad.an.m.sur = 0.9, fawn.repro = 0, juv.repro = 0.6, ad.repro = 1, 
#' hunt.mort.fawn = 0.01, hunt.mort.juv.f = 0.1, hunt.mort.juv.m = 0.1,
#' hunt.mort.ad.f = 0.2, hunt.mort.ad.m = 0.2, ini.fawn.prev = 0.02,
#' ini.juv.prev = 0.03, ini.ad.f.prev = 0.04,  ini.ad.m.prev = 0.04,
#' n.age.cats = 12,  p = 0.43, env.foi = 0,  beta.ff = 0.08, 
#' gamma.mm = 1, gamma.mf = 1, gamma.fm = 1.5,
#' theta = 1, n0 = 2000, n.years = 15, rel.risk = 1.0)
#' 
#' out <- cwd_det_model_wiw_tracking(params)
#' plot_track_sex(out$tracking.inf)
#' 
#' @export
plot_track_sex <- function (dat) {
  if(missing(dat)==TRUE) warning("missing data to plot")
  
  dat %>% 
    filter(category == "new.f.inf"|
             category == "new.m.inf") %>% 
    mutate(year = floor(year)) %>% 
    group_by(category, year) %>% 
    summarise(population = sum(population)) %>% 
    ggplot(aes(year, population, color = category)) +
    geom_line() +
    scale_color_discrete(name = "New Infections of", 
                         labels = c("Females", "Males")) +
    labs(y = "Infection Events",
         x = "Year") +
    theme_classic()
}