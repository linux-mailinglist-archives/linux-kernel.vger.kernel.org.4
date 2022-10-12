Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405575FC937
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 18:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiJLQ04 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 12 Oct 2022 12:26:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiJLQ0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 12:26:52 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFD7C4C02;
        Wed, 12 Oct 2022 09:26:51 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id w74so11416887oie.0;
        Wed, 12 Oct 2022 09:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CRibgT5Dmw4z67CdffpIL4Rm+ku+qTFjtnJtl5/U7nE=;
        b=dEZnLZoFH+v6RQ/nymMlNPWQ7EAbGQuHcOIs/ByqE5wdIe/7cOkeaEgv2jGQnGiAFz
         6Z6pyN2MdvIRI5LvEUd0A2q5YlgJ9VaIYhzPS11vsBrmP+d3OPIR/MmPdS6JQgX9XApv
         e0nwzKVh5aWBhFy6UysXnXDLoPua7yeL/YHEHsABIZmPr71zu1OtilsGPA3sbM+EVLW5
         1HyjLAXVhyUM8xkB+tCeXLxx5SDZ+WB+lxyG4aUjj14ou+/s3buU1CjXo4m1onnkbsRe
         h3W21AyWOVEbG/WCKKn1WnuMjzTzp6k3dGf1Eym3G8Jk8XY4eX84c42omDYHTj+zZLsi
         In8A==
X-Gm-Message-State: ACrzQf2JGxWU9SdKdLb0Si7iqwn9wjMZ2gM0EYic/N6diMvlvEj4+wE5
        L99ZBJsrBk7xZGF+4QM0QDsPeCm1BR7PDa2Opk8=
X-Google-Smtp-Source: AMsMyM6TAYrpOXihFuKjCXctnQA4ap+PbLDyKtHvRwnSnwmGdpk2R88IWDHg5YY4uTG2lEu5rNIV2DKIUCS/o/DF2cA=
X-Received: by 2002:a05:6808:181e:b0:350:e92a:9ab1 with SMTP id
 bh30-20020a056808181e00b00350e92a9ab1mr2414404oib.209.1665592010318; Wed, 12
 Oct 2022 09:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20221010053600.272854-1-namhyung@kernel.org> <20221010053600.272854-20-namhyung@kernel.org>
 <Y0Z9nsgz7A5nWRN2@krava>
In-Reply-To: <Y0Z9nsgz7A5nWRN2@krava>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 12 Oct 2022 09:26:38 -0700
Message-ID: <CAM9d7cjnAPhOPont3GHSwa9BhAsAFVvqAhFPsyAfQBR8ajrvag@mail.gmail.com>
Subject: Re: [PATCH 19/19] perf stat: Remove unused perf_counts.aggr field
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wed, Oct 12, 2022 at 1:41 AM Jiri Olsa <olsajiri@gmail.com> wrote:
>
> On Sun, Oct 09, 2022 at 10:36:00PM -0700, Namhyung Kim wrote:
> > The aggr field in the struct perf_counts is to keep the aggregated value
> > in the AGGR_GLOBAL for the old code.  But it's not used anymore.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > ---
> >  tools/perf/util/counts.c |  1 -
> >  tools/perf/util/counts.h |  1 -
> >  tools/perf/util/stat.c   | 35 ++---------------------------------
> >  3 files changed, 2 insertions(+), 35 deletions(-)
> >
> > diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
> > index 7a447d918458..11cd85b278a6 100644
> > --- a/tools/perf/util/counts.c
> > +++ b/tools/perf/util/counts.c
> > @@ -48,7 +48,6 @@ void perf_counts__reset(struct perf_counts *counts)
> >  {
> >       xyarray__reset(counts->loaded);
> >       xyarray__reset(counts->values);
> > -     memset(&counts->aggr, 0, sizeof(struct perf_counts_values));
> >  }
> >
> >  void evsel__reset_counts(struct evsel *evsel)
> > diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
> > index 5de275194f2b..42760242e0df 100644
> > --- a/tools/perf/util/counts.h
> > +++ b/tools/perf/util/counts.h
> > @@ -11,7 +11,6 @@ struct evsel;
> >
> >  struct perf_counts {
> >       s8                        scaled;
> > -     struct perf_counts_values aggr;
> >       struct xyarray            *values;
> >       struct xyarray            *loaded;
> >  };
> > diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
> > index 1652586a4925..0dccfa273fa7 100644
> > --- a/tools/perf/util/stat.c
> > +++ b/tools/perf/util/stat.c
> > @@ -307,8 +307,6 @@ static void evsel__copy_prev_raw_counts(struct evsel *evsel)
> >                               *perf_counts(evsel->prev_raw_counts, idx, thread);
> >               }
> >       }
> > -
> > -     evsel->counts->aggr = evsel->prev_raw_counts->aggr;
> >  }
> >
> >  void evlist__copy_prev_raw_counts(struct evlist *evlist)
> > @@ -319,26 +317,6 @@ void evlist__copy_prev_raw_counts(struct evlist *evlist)
> >               evsel__copy_prev_raw_counts(evsel);
> >  }
> >
> > -void evlist__save_aggr_prev_raw_counts(struct evlist *evlist)
> > -{
> > -     struct evsel *evsel;
> > -
> > -     /*
> > -      * To collect the overall statistics for interval mode,
> > -      * we copy the counts from evsel->prev_raw_counts to
> > -      * evsel->counts. The perf_stat_process_counter creates
> > -      * aggr values from per cpu values, but the per cpu values
> > -      * are 0 for AGGR_GLOBAL. So we use a trick that saves the
> > -      * previous aggr value to the first member of perf_counts,
> > -      * then aggr calculation in process_counter_values can work
> > -      * correctly.
> > -      */
> > -     evlist__for_each_entry(evlist, evsel) {
> > -             *perf_counts(evsel->prev_raw_counts, 0, 0) =
> > -                     evsel->prev_raw_counts->aggr;
> > -     }
> > -}
> > -
> >  static size_t pkg_id_hash(const void *__key, void *ctx __maybe_unused)
> >  {
> >       uint64_t *key = (uint64_t *) __key;
> > @@ -422,7 +400,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >                      int cpu_map_idx, int thread,
> >                      struct perf_counts_values *count)
> >  {
> > -     struct perf_counts_values *aggr = &evsel->counts->aggr;
> >       struct perf_stat_evsel *ps = evsel->stats;
> >       static struct perf_counts_values zero;
> >       bool skip = false;
> > @@ -491,12 +468,6 @@ process_counter_values(struct perf_stat_config *config, struct evsel *evsel,
> >               }
> >       }
> >
> > -     if (config->aggr_mode == AGGR_GLOBAL) {
> > -             aggr->val += count->val;
> > -             aggr->ena += count->ena;
> > -             aggr->run += count->run;
> > -     }
> > -
> >       return 0;
> >  }
> >
> > @@ -521,13 +492,10 @@ static int process_counter_maps(struct perf_stat_config *config,
> >  int perf_stat_process_counter(struct perf_stat_config *config,
> >                             struct evsel *counter)
> >  {
> > -     struct perf_counts_values *aggr = &counter->counts->aggr;
> >       struct perf_stat_evsel *ps = counter->stats;
> > -     u64 *count = counter->counts->aggr.values;
> > +     u64 *count;
> >       int ret;
> >
> > -     aggr->val = aggr->ena = aggr->run = 0;
> > -
> >       if (counter->per_pkg)
> >               evsel__zero_per_pkg(counter);
> >
> > @@ -538,6 +506,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
> >       if (config->aggr_mode != AGGR_GLOBAL)
> >               return 0;
> >
> > +     count = ps->aggr[0].counts.values;
> >       update_stats(&ps->res_stats, *count);
>
> hi,
> for some reason 'count' could be NULL, I'm getting crash in here:

Ouch, will check.  Thanks for the test!

Thanks,
Namhyung


>
>         $ ./perf stat record -o krava.data true
>         ...
>
>         $ gdb ./perf
>
>         (gdb) r stat report -i krava.data
>         Starting program: /home/jolsa/kernel/linux-perf/tools/perf/perf stat report -i krava.data
>         [Thread debugging using libthread_db enabled]
>         Using host libthread_db library "/lib64/libthread_db.so.1".
>
>         Program received signal SIGSEGV, Segmentation fault.
>         0x00000000005ae90b in perf_stat_process_counter (config=0xe18d60 <stat_config>, counter=0xecfd00) at util/stat.c:510
>         510             update_stats(&ps->res_stats, *count);
>         Missing separate debuginfos, use: dnf debuginfo-install bzip2-libs-1.0.8-11.fc36.x86_64 cyrus-sasl-lib-2.1.27-18.fc36.x86_64 elfutils-debuginfod-client-0.187-4.fc36.x86_64 elfutils-libelf-0.187-4.fc36.x86_64 elfutils-libs-0.187-4.fc36.x86_64 glibc-2.35-15.fc36.x86_64 glibc-2.35-17.fc36.x86_64 keyutils-libs-1.6.1-4.fc36.x86_64 krb5-libs-1.19.2-11.fc36.x86_64 libbrotli-1.0.9-7.fc36.x86_64 libcap-2.48-4.fc36.x86_64 libcom_err-1.46.5-2.fc36.x86_64 libcurl-7.82.0-8.fc36.x86_64 libevent-2.1.12-6.fc36.x86_64 libgcc-12.2.1-2.fc36.x86_64 libidn2-2.3.3-1.fc36.x86_64 libnghttp2-1.46.0-2.fc36.x86_64 libpsl-0.21.1-5.fc36.x86_64 libselinux-3.3-4.fc36.x86_64 libssh-0.9.6-4.fc36.x86_64 libunistring-1.0-1.fc36.x86_64 libunwind-1.6.2-2.fc36.x86_64 libxcrypt-4.4.28-1.fc36.x86_64 libzstd-1.5.2-2.fc36.x86_64 numactl-libs-2.0.14-5.fc36.x86_64 openldap-2.6.3-1.fc36.x86_64 openssl-libs-3.0.5-1.fc36.x86_64 perl-libs-5.34.1-486.fc36.x86_64 python3-libs-3.10.7-1.fc36.x86_64 slang-2.3.2-11.fc36.x86_64 xz-libs-5.2.5-9.fc36.x86_64 zlib-1.2.11-33.fc36.x86_64
>         (gdb) bt
>         #0  0x00000000005ae90b in perf_stat_process_counter (config=0xe18d60 <stat_config>, counter=0xecfd00) at util/stat.c:510
>         #1  0x000000000043b716 in process_counters () at builtin-stat.c:485
>         #2  0x000000000043f2bf in process_stat_round_event (session=0xec84f0, event=0x7ffff7ffaba8) at builtin-stat.c:2099
>         #3  0x000000000056c7b6 in perf_session__process_user_event (session=0xec84f0, event=0x7ffff7ffaba8, file_offset=2984, file_path=0xecf220 "krava.data")
>             at util/session.c:1714
>         #4  0x000000000056cea5 in perf_session__process_event (session=0xec84f0, event=0x7ffff7ffaba8, file_offset=2984, file_path=0xecf220 "krava.data")
>             at util/session.c:1857
>         #5  0x000000000056e4fa in process_simple (session=0xec84f0, event=0x7ffff7ffaba8, file_offset=2984, file_path=0xecf220 "krava.data") at util/session.c:2432
>         #6  0x000000000056e1b9 in reader__read_event (rd=0x7fffffffb6c0, session=0xec84f0, prog=0x7fffffffb690) at util/session.c:2361
>         #7  0x000000000056e3ae in reader__process_events (rd=0x7fffffffb6c0, session=0xec84f0, prog=0x7fffffffb690) at util/session.c:2410
>         #8  0x000000000056e652 in __perf_session__process_events (session=0xec84f0) at util/session.c:2457
>         #9  0x000000000056eff8 in perf_session__process_events (session=0xec84f0) at util/session.c:2623
>         #10 0x000000000043fa53 in __cmd_report (argc=0, argv=0x7fffffffdf70) at builtin-stat.c:2265
>         #11 0x000000000043fd94 in cmd_stat (argc=3, argv=0x7fffffffdf70) at builtin-stat.c:2346
>         #12 0x00000000004ef495 in run_builtin (p=0xe2f930 <commands+336>, argc=4, argv=0x7fffffffdf70) at perf.c:322
>         #13 0x00000000004ef709 in handle_internal_command (argc=4, argv=0x7fffffffdf70) at perf.c:376
>         #14 0x00000000004ef858 in run_argv (argcp=0x7fffffffdd9c, argv=0x7fffffffdd90) at perf.c:420
>         #15 0x00000000004efc1f in main (argc=4, argv=0x7fffffffdf70) at perf.c:550
>         (gdb) p count
>         $1 = (u64 *) 0x0
>
> jirka
>
> >
> >       if (verbose > 0) {
> > --
> > 2.38.0.rc1.362.ged0d419d3c-goog
> >
