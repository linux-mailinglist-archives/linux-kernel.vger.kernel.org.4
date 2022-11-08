Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8852A621ED9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 23:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiKHWIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 17:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiKHWH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 17:07:56 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720B16317B;
        Tue,  8 Nov 2022 14:07:51 -0800 (PST)
Received: by mail-oi1-f181.google.com with SMTP id v81so16998802oie.5;
        Tue, 08 Nov 2022 14:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hc+pFzeni5c3FOxhO6gVInX/MV2dGrMGFiE5k1b00W4=;
        b=pUARpJpPypKkIHi7vfr9GtmuFfW79+qox7cczZ5SPLhVUS75/S6mH87WrZsFuitl1l
         Fw9prWDOikJI9eM1V3wPMQsIrI4imrm2o/UaVBzkhBydu6IeyL5iT5hDqWt6bcRRu+ND
         YxorYKRVEtB00/CJ54K8EfC87W/JlVVxWyuyrGhppLURtbWjSe5OiVPkzuSXMU4OqaKu
         ZVOHosmyHdYPMk7+mmphtcsKWflUZlBTY7TvpljPyEiBl61dJkb9AN9dAt4Ibn3TlP9y
         V+7sGeV55LHq6nm0az9/G1cjJxK18VWeWE/YPWI70XqG8ZxVlRZQKHiyl4yvuM/MjHP0
         vwVg==
X-Gm-Message-State: ACrzQf0+iEdNDs4O+5G69JND8fd5SbOFCOisyiwFs3I9uqFkxoO3ctQL
        mq7UC2/h850fCzwTg4jLx7NzlIRZIX/hL/WQrDg=
X-Google-Smtp-Source: AMsMyM53NDwHQRXcGZbkw/oYYH09GXawLDVqcVUJ1RfguMAps5EL1CH5g0vd3CTOccBdtU+pEc9UdjrO3E6ChBygfEk=
X-Received: by 2002:aca:2b0a:0:b0:35a:d72:5504 with SMTP id
 i10-20020aca2b0a000000b0035a0d725504mr713590oik.209.1667945270621; Tue, 08
 Nov 2022 14:07:50 -0800 (PST)
MIME-Version: 1.0
References: <20221107213314.3239159-1-namhyung@kernel.org> <20221107213314.3239159-6-namhyung@kernel.org>
 <Y2q/0LNDCspN0Tm8@kernel.org>
In-Reply-To: <Y2q/0LNDCspN0Tm8@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 8 Nov 2022 14:07:39 -0800
Message-ID: <CAM9d7chsOAQ_y3Z8ZUPzmcAFfS5x8E2s7eH68Nu792TG-ZnzdA@mail.gmail.com>
Subject: Re: [PATCH 5/9] perf stat: Fix --metric-only --json output
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Tue, Nov 8, 2022 at 12:45 PM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Nov 07, 2022 at 01:33:10PM -0800, Namhyung Kim escreveu:
> > Currently it prints all metric headers for JSON output.  But actually it
> > skips some metrics with valid_only_metric().  So the output looks like:
> >
> >   $ perf stat --metric-only --json true
> >   {"unit" : "CPUs utilized", "unit" : "/sec", "unit" : "/sec", "unit" : "/sec", "unit" : "GHz", "unit" : "insn per cycle", "unit" : "/sec", "unit" : "branch-misses of all branches"}
> >   {"metric-value" : "3.861"}{"metric-value" : "0.79"}{"metric-value" : "3.04"}
> >
> > As you can see there are 8 units in the header but only 3 metric-values
> > are there.  It should skip the unused headers as well.  Also each unit
> > should be printed as a separate object like metric values.
> >
> > With this patch:
> >
> >   $ perf stat --metric-only --json true
> >   {"unit" : "GHz"}{"unit" : "insn per cycle"}{"unit" : "branch-misses of all branches"}
> >   {"metric-value" : "4.166"}{"metric-value" : "0.73"}{"metric-value" : "2.96"}
>
> Can we get a Fixes tag for this one?

I think this is it:

df936cadfb58 ("perf stat: Add JSON output option")

But this also depends on patch 4.  Do you want me to rebase
this not to depend on it?

Thanks,
Namhyung

>
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/stat-display.c | 22 +++-------------------
> >  1 file changed, 3 insertions(+), 19 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 115477461224..515fb6db3d67 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -430,12 +430,12 @@ static void print_metric_header(struct perf_stat_config *config,
> >           os->evsel->priv != os->evsel->evlist->selected->priv)
> >               return;
> >
> > -     if (!valid_only_metric(unit) && !config->json_output)
> > +     if (!valid_only_metric(unit))
> >               return;
> >       unit = fixunit(tbuf, os->evsel, unit);
> >
> >       if (config->json_output)
> > -             fprintf(os->fh, "\"unit\" : \"%s\"", unit);
> > +             fprintf(os->fh, "{\"unit\" : \"%s\"}", unit);
> >       else if (config->csv_output)
> >               fprintf(os->fh, "%s%s", unit, config->csv_sep);
> >       else
> > @@ -847,10 +847,6 @@ static void print_metric_headers(struct perf_stat_config *config,
> >               .new_line = new_line_metric,
> >               .force_header = true,
> >       };
> > -     bool first = true;
> > -
> > -     if (config->json_output && !config->interval)
> > -             fprintf(config->output, "{");
> >
> >       if (prefix && !config->json_output)
> >               fprintf(config->output, "%s", prefix);
> > @@ -871,18 +867,12 @@ static void print_metric_headers(struct perf_stat_config *config,
> >       evlist__for_each_entry(evlist, counter) {
> >               os.evsel = counter;
> >
> > -             if (!first && config->json_output)
> > -                     fprintf(config->output, ", ");
> > -             first = false;
> > -
> >               perf_stat__print_shadow_stats(config, counter, 0,
> >                                             0,
> >                                             &out,
> >                                             &config->metric_events,
> >                                             &rt_stat);
> >       }
> > -     if (config->json_output)
> > -             fprintf(config->output, "}");
> >       fputc('\n', config->output);
> >  }
> >
> > @@ -954,14 +944,8 @@ static void print_interval(struct perf_stat_config *config,
> >               }
> >       }
> >
> > -     if ((num_print_interval == 0 || config->interval_clear)
> > -                      && metric_only && !config->json_output)
> > +     if ((num_print_interval == 0 || config->interval_clear) && metric_only)
> >               print_metric_headers(config, evlist, " ", true);
> > -     if ((num_print_interval == 0 || config->interval_clear)
> > -                      && metric_only && config->json_output) {
> > -             fprintf(output, "{");
> > -             print_metric_headers(config, evlist, " ", true);
> > -     }
> >       if (++num_print_interval == 25)
> >               num_print_interval = 0;
> >  }
> > --
> > 2.38.1.431.g37b22c650d-goog
>
> --
>
> - Arnaldo
