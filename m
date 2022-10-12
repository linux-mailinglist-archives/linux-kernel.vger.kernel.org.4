Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D485FC956
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiJLQby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiJLQbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:31:52 -0400
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADC6BE31;
        Wed, 12 Oct 2022 09:31:51 -0700 (PDT)
Received: by mail-oo1-f52.google.com with SMTP id u19-20020a4a9e93000000b004757198549cso12528850ook.0;
        Wed, 12 Oct 2022 09:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B+sJcvXCW23zgMMTxvLx9gcuNc7Tz4vevgE0c+dxI1s=;
        b=ERl/jxTT0VFg/ALsIA131G1eaIso0UGY5Oha9A0LqL+77dzc6KS1w1c0/Zow7Gwdsv
         DhYCa7U/sR0faSrpup83UbVFO3sZ6jcgThYeBNUXBAF7m8mGmk7pLJHC6slh/osH38Bu
         tNFRBtVLT1xh7j32X5XU7u97VK2CS6Gdx1dsIyJN2oi25+omuBoH1a3ziS6rFRnrHX5v
         S7MP+Ltu5iR0ityxh864aG6DCOl8Glu/Jd3DQ8UsG8oJF/vk83+K/6ZcxUUFAANoKIC0
         u/OzcjiP/Gyw6Y/jWIY2iaqqarRZU03/a+JdT6eOP2YEr4SAoFWB8heQ1zjz9/ZOvjbX
         ECYQ==
X-Gm-Message-State: ACrzQf2F4cBR9tcI0K5OdlZ2HpMFUoO8V1HZFWpmSgOd5CgyKJGYXD8q
        83yeIxi1ISZ7rzg0/KJsMrDkkDPbHWaLQQT3q6I=
X-Google-Smtp-Source: AMsMyM6yXX7lvJ8EDToeyHwMU7dFC00T56x5wr8m04AHWzThFtTOE0THwWXjM3hpP2HtWYwLItxswDchF1+yjOb4jPw=
X-Received: by 2002:a9d:6848:0:b0:661:a608:cbc3 with SMTP id
 c8-20020a9d6848000000b00661a608cbc3mr5702293oto.206.1665592310829; Wed, 12
 Oct 2022 09:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-5-namhyung@kernel.org>
 <Y0adOTUulE/HnLU3@krava>
In-Reply-To: <Y0adOTUulE/HnLU3@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:31:39 -0700
Message-ID: <CAM9d7ciypq2uOGcoCPoYktz2eLpApsG_vCVHZ5snZt_F87J9qQ@mail.gmail.com>
Subject: Re: [PATCH 04/19] perf stat: Add aggr id for global mode
To:     Jiri Olsa <olsajiri@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        James Clark <james.clark@arm.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 12, 2022 at 3:56 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sun, Oct 09, 2022 at 10:35:45PM -0700, Namhyung Kim wrote:
> > To make the code simpler, I'd like to use the same aggregation code for
> > the global mode.  We can simply add an id function to return cpu 0 and
> > use print_aggr().
> >
> > No functional change intended.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/builtin-stat.c      | 39 ++++++++++++++++++++++++++++++++--
> >  tools/perf/util/cpumap.c       | 10 +++++++++
> >  tools/perf/util/cpumap.h       |  6 +++++-
> >  tools/perf/util/stat-display.c |  9 ++------
> >  4 files changed, 54 insertions(+), 10 deletions(-)
> >
>
> SNIP
>
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 4113aa86772f..1d8e585df4ad 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -1477,13 +1477,8 @@ void evlist__print_counters(struct evlist *evlist, struct perf_stat_config *conf
> >               if (config->iostat_run)
> >                       iostat_print_counters(evlist, config, ts, prefix = buf,
> >                                             print_counter_aggr);
> > -             else {
> > -                     evlist__for_each_entry(evlist, counter) {
> > -                             print_counter_aggr(config, counter, prefix);
> > -                     }
> > -                     if (metric_only)
> > -                             fputc('\n', config->output);
> > -             }
> > +             else
> > +                     print_aggr(config, evlist, prefix);
>
> this seems to break output for:
>
> before:
>         # ./perf stat -M ipc -I 1000 --metric-only
>         #           time                  IPC
>              1.000674320                 0.61
>              2.001700284                 0.66
>              3.003677500                 0.67
>              4.005583140                 0.64
>
> after:
>         # ./perf stat -M ipc -I 1000 --metric-only
>         #           time                  IPC
>              1.001004048                 0.94
>
>              2.003120471                 0.69
>
>              3.005030405                 0.65
>
>              4.006788766                 0.64
>
>              5.008004052                 0.68
>
>
> also should this hunk be in separate patch?

Yeah, looks like so.  Probably slipped into during rebase.  Will check.

Thanks,
Namhyung


>
> >               break;
> >       case AGGR_NONE:
> >               if (metric_only)
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
