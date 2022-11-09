Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30395623289
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 19:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKISeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 13:34:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiKISeO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 13:34:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20013CC7;
        Wed,  9 Nov 2022 10:33:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6680EB81F8F;
        Wed,  9 Nov 2022 18:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA235C433D6;
        Wed,  9 Nov 2022 18:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668018832;
        bh=1NlJ0Cb9DDuBdKZM1kCO/SoFwcQXtKDYxi8lugqUymk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XBYwW2UIi570upRgrDi3H+eWtCnh8yyhY/cSNYmkZ0gVhAAXOQlRU84zaqvAgQxLt
         KmoI+7eFh6aTwAqAndoBS4vr8PgZ/oDPbI87LOD54CCfH/+pL7dWsOBSVbsJYKZ7EF
         wuzlQX/cBhlSk5RvL1i41H6R2cgTl0F3CZ9QTQQTSm2aHIucln6IW7QO8ZqTkdgrca
         +0cYtb3L/n9+yNQJ3N8f49qaul8Tdy5as4AIwyqUeDgYIevFrza0DMmz+ZsMT0vuTj
         RQvS9ecOwl+rtqPZ0JyoC6pkfXDh40Y3Rkx9XwTnUsJ5vF+5DyzJejpshXiZnj9JUa
         MRVuLqnpox5iQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 89A824034E; Wed,  9 Nov 2022 15:33:49 -0300 (-03)
Date:   Wed, 9 Nov 2022 15:33:49 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Subject: Re: [PATCH 5/9] perf stat: Fix --metric-only --json output
Message-ID: <Y2vyjUx6OeWFGIeH@kernel.org>
References: <20221107213314.3239159-1-namhyung@kernel.org>
 <20221107213314.3239159-6-namhyung@kernel.org>
 <Y2q/0LNDCspN0Tm8@kernel.org>
 <CAM9d7chsOAQ_y3Z8ZUPzmcAFfS5x8E2s7eH68Nu792TG-ZnzdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7chsOAQ_y3Z8ZUPzmcAFfS5x8E2s7eH68Nu792TG-ZnzdA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Nov 08, 2022 at 02:07:39PM -0800, Namhyung Kim escreveu:
> Hi Arnaldo,
> 
> On Tue, Nov 8, 2022 at 12:45 PM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Mon, Nov 07, 2022 at 01:33:10PM -0800, Namhyung Kim escreveu:
> > > Currently it prints all metric headers for JSON output.  But actually it
> > > skips some metrics with valid_only_metric().  So the output looks like:
> > >
> > >   $ perf stat --metric-only --json true
> > >   {"unit" : "CPUs utilized", "unit" : "/sec", "unit" : "/sec", "unit" : "/sec", "unit" : "GHz", "unit" : "insn per cycle", "unit" : "/sec", "unit" : "branch-misses of all branches"}
> > >   {"metric-value" : "3.861"}{"metric-value" : "0.79"}{"metric-value" : "3.04"}
> > >
> > > As you can see there are 8 units in the header but only 3 metric-values
> > > are there.  It should skip the unused headers as well.  Also each unit
> > > should be printed as a separate object like metric values.
> > >
> > > With this patch:
> > >
> > >   $ perf stat --metric-only --json true
> > >   {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
> > >   {"metric-value" : "4.166"}{"metric-value" : "0.73"}{"metric-value" : "2.96"}
> >
> > Can we get a Fixes tag for this one?
> 
> I think this is it:
> 
> df936cadfb58 ("perf stat: Add JSON output option")

I'll add it
 
> But this also depends on patch 4.  Do you want me to rebase
> this not to depend on it?

Nope, I put the first one on perf/urgent, 2- on perf/core,

- Arnaldo
 
> Thanks,
> Namhyung
> 
> >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/stat-display.c | 22 +++-------------------
> > >  1 file changed, 3 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > > index 115477461224..515fb6db3d67 100644
> > > --- a/tools/perf/util/stat-display.c
> > > +++ b/tools/perf/util/stat-display.c
> > > @@ -430,12 +430,12 @@ static void print_metric_header(struct perf_stat_config *config,
> > >           os->evsel->priv != os->evsel->evlist->selected->priv)
> > >               return;
> > >
> > > -     if (!valid_only_metric(unit) && !config->json_output)
> > > +     if (!valid_only_metric(unit))
> > >               return;
> > >       unit = fixunit(tbuf, os->evsel, unit);
> > >
> > >       if (config->json_output)
> > > -             fprintf(os->fh, "\"unit\" : \"%s\"", unit);
> > > +             fprintf(os->fh, "{\"unit\" : \"%s\"}", unit);
> > >       else if (config->csv_output)
> > >               fprintf(os->fh, "%s%s", unit, config->csv_sep);
> > >       else
> > > @@ -847,10 +847,6 @@ static void print_metric_headers(struct perf_stat_config *config,
> > >               .new_line = new_line_metric,
> > >               .force_header = true,
> > >       };
> > > -     bool first = true;
> > > -
> > > -     if (config->json_output && !config->interval)
> > > -             fprintf(config->output, "{");
> > >
> > >       if (prefix && !config->json_output)
> > >               fprintf(config->output, "%s", prefix);
> > > @@ -871,18 +867,12 @@ static void print_metric_headers(struct perf_stat_config *config,
> > >       evlist__for_each_entry(evlist, counter) {
> > >               os.evsel = counter;
> > >
> > > -             if (!first && config->json_output)
> > > -                     fprintf(config->output, ", ");
> > > -             first = false;
> > > -
> > >               perf_stat__print_shadow_stats(config, counter, 0,
> > >                                             0,
> > >                                             &out,
> > >                                             &config->metric_events,
> > >                                             &rt_stat);
> > >       }
> > > -     if (config->json_output)
> > > -             fprintf(config->output, "}");
> > >       fputc('\n', config->output);
> > >  }
> > >
> > > @@ -954,14 +944,8 @@ static void print_interval(struct perf_stat_config *config,
> > >               }
> > >       }
> > >
> > > -     if ((num_print_interval == 0 || config->interval_clear)
> > > -                      && metric_only && !config->json_output)
> > > +     if ((num_print_interval == 0 || config->interval_clear) && metric_only)
> > >               print_metric_headers(config, evlist, " ", true);
> > > -     if ((num_print_interval == 0 || config->interval_clear)
> > > -                      && metric_only && config->json_output) {
> > > -             fprintf(output, "{");
> > > -             print_metric_headers(config, evlist, " ", true);
> > > -     }
> > >       if (++num_print_interval == 25)
> > >               num_print_interval = 0;
> > >  }
> > > --
> > > 2.38.1.431.g37b22c650d-goog
> >
> > --
> >
> > - Arnaldo

-- 

- Arnaldo
