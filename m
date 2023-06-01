Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC071F4A1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjFAV1f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 1 Jun 2023 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjFAV1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:27:32 -0400
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEBA1AD;
        Thu,  1 Jun 2023 14:27:05 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-ba8a0500f4aso1391204276.3;
        Thu, 01 Jun 2023 14:27:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685654820; x=1688246820;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s7BlAT0XK/AtMafGWsfobLfm9HS0ZOQE6Db3Cxf2q5g=;
        b=efqDcQpn/FiF5Rl0iE8Uoe8SPVHW7/oU9gv4hWMqL9sqJ+HGjAEWz5uTWbmYp5AS3S
         NDg3XLMK+4whW1y0jRZ+uPkoiWjnK6/1e09BUNSRerCPIcwgw/yxMwqbIvlmjOdCw2PH
         qKccFxMUtd61buLIhKoGIb0e1DFCr+0ifmcs9IlXaqnVBVCud2sUtd495Hss/jv776kv
         Dr8YuwRi2s2c3BaGMayinyJYboxZnffIHaUTf1K2mu3Ivbh01XG2m2Lf5fQOEtO/ODfX
         OlcYXNJYo4OyT+AlDAKBKqPKs8itqZrN/BoCeH1rZTEsJYE2+jJMEYXObSD7XqB/Tiql
         jiJg==
X-Gm-Message-State: AC+VfDz+ixecUAvwV8cywKWgyVIpaG1EGxcyXmLkPo0FwlVwqw1yoeq/
        aqA6mITsLf0zL/JDl45S5GM2xqYyGh2v0PJ9cQg=
X-Google-Smtp-Source: ACHHUZ4F6+pbmUZJXEiyJPxLNZkwZV8qw39QVhLcdYiDjelDEhi/eFIpY1GGz26MDT7Havv95lFG6lD7yEHB7NRDpPY=
X-Received: by 2002:a25:378b:0:b0:ba8:98ec:1223 with SMTP id
 e133-20020a25378b000000b00ba898ec1223mr1092507yba.33.1685654819968; Thu, 01
 Jun 2023 14:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230531115014.161454-1-asavkov@redhat.com> <20230531115014.161454-3-asavkov@redhat.com>
In-Reply-To: <20230531115014.161454-3-asavkov@redhat.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 1 Jun 2023 14:26:48 -0700
Message-ID: <CAM9d7ci6h_f8WsRu3cyYPQJO8nuAXcsMX_T_+aLy_0t5_33tMA@mail.gmail.com>
Subject: Re: [PATCH 2/2] perf tools: allow running annotation browser from c2c-report
To:     Artem Savkov <asavkov@redhat.com>
Cc:     linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, May 31, 2023 at 4:50 AM Artem Savkov <asavkov@redhat.com> wrote:
>
> Add a shortcut to run annotation browser for selected symbol from
> c2c report TUI.
>
> Signed-off-by: Artem Savkov <asavkov@redhat.com>
> ---
>  tools/perf/builtin-c2c.c | 76 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 71 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
> index 05dfd98af170b..96e66289c2576 100644
> --- a/tools/perf/builtin-c2c.c
> +++ b/tools/perf/builtin-c2c.c
> @@ -19,11 +19,13 @@
>  #include <linux/zalloc.h>
>  #include <asm/bug.h>
>  #include <sys/param.h>
> +#include <sys/ttydefaults.h>
>  #include "debug.h"
>  #include "builtin.h"
>  #include <perf/cpumap.h>
>  #include <subcmd/pager.h>
>  #include <subcmd/parse-options.h>
> +#include "map.h"
>  #include "map_symbol.h"
>  #include "mem-events.h"
>  #include "session.h"
> @@ -43,6 +45,8 @@
>  #include "ui/progress.h"
>  #include "pmus.h"
>  #include "string2.h"
> +#include "util/annotate.h"
> +#include "util/dso.h"
>  #include "util/util.h"
>
>  struct c2c_hists {
> @@ -79,6 +83,7 @@ struct c2c_hist_entry {
>          * because of its callchain dynamic entry
>          */
>         struct hist_entry       he;
> +       struct evsel            *evsel;

I'm not sure if it's needed.  It seems c2c command doesn't collect
samples per evsel.  It uses c2c.hists.hists for all evsels.  Then it
might not be worth keeping an evsel in a c2c_hist_entry and
just use a random evsel in the evlist.


>  };
>
>  static char const *coalesce_default = "iaddr";
> @@ -111,6 +116,8 @@ struct perf_c2c {
>         char                    *cl_sort;
>         char                    *cl_resort;
>         char                    *cl_output;
> +
> +       struct annotation_options annotation_opts;
>  };
>
>  enum {
> @@ -326,7 +333,12 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
>         c2c_he__set_cpu(c2c_he, sample);
>         c2c_he__set_node(c2c_he, sample);
>
> +       c2c_he->evsel = evsel;
> +
>         hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
> +       if (use_browser == 1 && al.map != NULL && al.sym != NULL) {
> +               hist_entry__inc_addr_samples(he, sample, c2c_he->evsel, al.addr);
> +       }
>         ret = hist_entry__append_callchain(he, sample);
>
>         if (!ret) {
> @@ -363,7 +375,12 @@ static int process_sample_event(struct perf_tool *tool __maybe_unused,
>                 c2c_he__set_cpu(c2c_he, sample);
>                 c2c_he__set_node(c2c_he, sample);
>
> +               c2c_he->evsel = evsel;
> +
>                 hists__inc_nr_samples(&c2c_hists->hists, he->filtered);
> +               if (use_browser == 1 && al.map != NULL && al.sym != NULL) {
> +                       hist_entry__inc_addr_samples(he, sample, c2c_he->evsel, al.addr);
> +               }
>                 ret = hist_entry__append_callchain(he, sample);
>         }
>
> @@ -2618,9 +2635,12 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>         struct c2c_hists *c2c_hists;
>         struct c2c_cacheline_browser *cl_browser;
>         struct hist_browser *browser;
> +       struct map_symbol ms = { NULL, NULL, NULL };
> +       int err = 0;
>         int key = -1;
>         static const char help[] =
>         " ENTER         Toggle callchains (if present) \n"
> +       " a             Annotate current symbol\n"
>         " n             Toggle Node details info \n"
>         " s             Toggle full length of symbol and source line columns \n"
>         " q             Return back to cacheline list \n";
> @@ -2650,6 +2670,44 @@ static int perf_c2c__browse_cacheline(struct hist_entry *he)
>                 key = hist_browser__run(browser, "? - help", true, 0);
>
>                 switch (key) {
> +               case 'a':

I think it's better to factor this code out to a function.


> +                       if (!browser->selection ||
> +                           !browser->selection->map ||
> +                           !browser->selection->map->dso ||
> +                           browser->selection->map->dso->annotate_warned) {
> +                               continue;
> +                       }
> +
> +                       ms.map = browser->selection->map;
> +
> +                       if (!browser->selection->sym) {
> +                               if (!browser->he_selection)
> +                                       continue;
> +
> +                               ms.sym = symbol__new_unresolved(browser->he_selection->ip,
> +                                                               browser->selection->map);
> +
> +                               if (!ms.sym)
> +                                       continue;
> +                       } else {
> +                               if (symbol__annotation(browser->selection->sym)->src == NULL) {
> +                                       ui_browser__warning(&browser->b, 0,
> +                                               "No samples for the \"%s\" symbol.\n\n",
> +                                               browser->selection->sym->name);
> +                                       continue;
> +                               }
> +                               ms.sym = browser->selection->sym;
> +                       }
> +
> +                       err = map_symbol__tui_annotate(&ms, c2c_he->evsel, browser->hbt, &c2c.annotation_opts);
> +
> +                       ui_browser__update_nr_entries(&browser->b, browser->hists->nr_entries);

c2c_browser__update_nr_entries() ?

> +                       if ((err == 'q' || err == CTRL('c')) && browser->he_selection->branch_info)

Why check branch_info?

> +                                       continue;
> +                       if (err)
> +                               ui_browser__handle_resize(&browser->b);
> +
> +                       continue;

It'd be natural to use 'break' instead of 'continue' here.

>                 case 's':
>                         c2c.symbol_full = !c2c.symbol_full;
>                         break;
> @@ -3045,6 +3103,10 @@ static int perf_c2c__report(int argc, const char **argv)
>         int err = 0;
>         const char *output_str, *sort_str = NULL;
>
> +       annotation_options__init(&c2c.annotation_opts);
> +
> +       hists__init();
> +
>         argc = parse_options(argc, argv, options, report_c2c_usage,
>                              PARSE_OPT_STOP_AT_NON_OPTION);
>         if (argc)
> @@ -3118,6 +3180,14 @@ static int perf_c2c__report(int argc, const char **argv)
>         if (err)
>                 goto out_mem2node;
>
> +       if (c2c.use_stdio) {
> +               use_browser = 0;
> +       } else {
> +               use_browser = 1;
> +               symbol__annotation_init();
> +               annotation_config__init(&c2c.annotation_opts);
> +       }
> +
>         if (symbol__init(&session->header.env) < 0)
>                 goto out_mem2node;
>
> @@ -3127,11 +3197,6 @@ static int perf_c2c__report(int argc, const char **argv)
>                 goto out_mem2node;
>         }
>
> -       if (c2c.use_stdio)
> -               use_browser = 0;
> -       else
> -               use_browser = 1;
> -
>         setup_browser(false);
>
>         err = perf_session__process_events(session);
> @@ -3202,6 +3267,7 @@ static int perf_c2c__report(int argc, const char **argv)
>  out_session:
>         perf_session__delete(session);
>  out:
> +       annotation_options__init(&c2c.annotation_opts);

__exit() ?

Thanks,
Namhyung


>         return err;
>  }
>
> --
> 2.40.1
>
