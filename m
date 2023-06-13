Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA5472EDCA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjFMVSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235998AbjFMVSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:18:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34A8131;
        Tue, 13 Jun 2023 14:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B550632AF;
        Tue, 13 Jun 2023 21:18:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FDABC433C8;
        Tue, 13 Jun 2023 21:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686691087;
        bh=SaIMM8OrJIOq7RBIH4G8hJ1Vzm0EeepKr004O6wkm5I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+kbv0FrOgliTIq0ULeBR9/b6cyioXjaCteErIc8l8znMXVPiIIwK+d/vScRwA+RP
         i233vbEhMz+3wKMhlzn5EL0TG/+/EU+5s3ln0Ze4knDO6h421knEqYgvOISnjGA1tj
         ZKZWzg3eWtp42EeK9xqCOjMuarkjVrw9lkzAEzuVB3IwGL+ddmbRH1PwPKnz4fy/nS
         kzwbfZ1xtjvHxvwNAkcYjp4aa1ei96l+ymXCkm1crYu0scc2DGlcqb6kKbcZpz3x4+
         rqJtUMNIhX91hhQrGEp5bfXtRuaiA1o0680Vm/WpRRYHGi5pYUXnjZ6X86cVLcLlSs
         gtM37tAgGJajw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 607BC40692; Tue, 13 Jun 2023 18:18:04 -0300 (-03)
Date:   Tue, 13 Jun 2023 18:18:04 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>, mingo@redhat.com,
        peterz@infradead.org, namhyung@kernel.org, jolsa@kernel.org,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com, ahmad.yasin@intel.com
Subject: Re: [PATCH 2/8] perf evsel: Fix the annotation for hardware events
 on hybrid
Message-ID: <ZIjdDFJHYuK7rdmD@kernel.org>
References: <20230607162700.3234712-1-kan.liang@linux.intel.com>
 <20230607162700.3234712-3-kan.liang@linux.intel.com>
 <CAP-5=fVz1zgwdJVs1V7putUdp9wf-QKWH1Ky-heLoHWgnJu6dg@mail.gmail.com>
 <7487eff9-5769-1701-ea1b-45dd5ab67c85@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7487eff9-5769-1701-ea1b-45dd5ab67c85@linux.intel.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jun 13, 2023 at 04:06:59PM -0400, Liang, Kan escreveu:
> 
> 
> On 2023-06-13 3:35 p.m., Ian Rogers wrote:
> > On Wed, Jun 7, 2023 at 9:27 AM <kan.liang@linux.intel.com> wrote:
> >>
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> The annotation for hardware events is wrong on hybrid. For example,
> >>
> >>  # ./perf stat -a sleep 1
> >>
> >>  Performance counter stats for 'system wide':
> >>
> >>          32,148.85 msec cpu-clock                        #   32.000 CPUs utilized
> >>                374      context-switches                 #   11.633 /sec
> >>                 33      cpu-migrations                   #    1.026 /sec
> >>                295      page-faults                      #    9.176 /sec
> >>         18,979,960      cpu_core/cycles/                 #  590.378 K/sec
> >>        261,230,783      cpu_atom/cycles/                 #    8.126 M/sec                       (54.21%)
> >>         17,019,732      cpu_core/instructions/           #  529.404 K/sec
> >>         38,020,470      cpu_atom/instructions/           #    1.183 M/sec                       (63.36%)
> >>          3,296,743      cpu_core/branches/               #  102.546 K/sec
> >>          6,692,338      cpu_atom/branches/               #  208.167 K/sec                       (63.40%)
> >>             96,421      cpu_core/branch-misses/          #    2.999 K/sec
> >>          1,016,336      cpu_atom/branch-misses/          #   31.613 K/sec                       (63.38%)
> >>
> >> The hardware events have extended type on hybrid, but the evsel__match()
> >> doesn't take it into account.
> >>
> >> Add a mask to filter the extended type on hybrid when checking the config.
> >>
> >> With the patch,
> >>
> >>  # ./perf stat -a sleep 1
> >>
> >>  Performance counter stats for 'system wide':
> >>
> >>          32,139.90 msec cpu-clock                        #   32.003 CPUs utilized
> >>                343      context-switches                 #   10.672 /sec
> >>                 32      cpu-migrations                   #    0.996 /sec
> >>                 73      page-faults                      #    2.271 /sec
> >>         13,712,841      cpu_core/cycles/                 #    0.000 GHz
> >>        258,301,691      cpu_atom/cycles/                 #    0.008 GHz                         (54.20%)
> >>         12,428,163      cpu_core/instructions/           #    0.91  insn per cycle
> >>         37,786,557      cpu_atom/instructions/           #    2.76  insn per cycle              (63.35%)
> >>          2,418,826      cpu_core/branches/               #   75.259 K/sec
> >>          6,965,962      cpu_atom/branches/               #  216.739 K/sec                       (63.38%)
> >>             72,150      cpu_core/branch-misses/          #    2.98% of all branches
> >>          1,032,746      cpu_atom/branch-misses/          #   42.70% of all branches             (63.35%)
> >>
> >> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> >> ---
> >>  tools/perf/util/evsel.h       | 12 ++++++-----
> >>  tools/perf/util/stat-shadow.c | 39 +++++++++++++++++++----------------
> >>  2 files changed, 28 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> >> index b365b449c6ea..36a32e4ca168 100644
> >> --- a/tools/perf/util/evsel.h
> >> +++ b/tools/perf/util/evsel.h
> >> @@ -350,9 +350,11 @@ u64 format_field__intval(struct tep_format_field *field, struct perf_sample *sam
> >>
> >>  struct tep_format_field *evsel__field(struct evsel *evsel, const char *name);
> >>
> >> -#define evsel__match(evsel, t, c)              \
> >> +#define EVSEL_EVENT_MASK                       (~0ULL)
> >> +
> >> +#define evsel__match(evsel, t, c, m)                   \
> >>         (evsel->core.attr.type == PERF_TYPE_##t &&      \
> >> -        evsel->core.attr.config == PERF_COUNT_##c)
> >> +        (evsel->core.attr.config & m) == PERF_COUNT_##c)
> > 
> > The EVSEL_EVENT_MASK here isn't very intention revealing, perhaps we
> > can remove it and do something like:
> > 
> > static inline bool __evsel__match(const struct evsel *evsel, u32 type,
> > u64 config)
> > {
> >   if ((type == PERF_TYPE_HARDWARE || type ==PERF_TYPE_HW_CACHE)  &&
> > perf_pmus__supports_extended_type())
> >      return (evsel->core.attr.config & PERF_HW_EVENT_MASK) == config;
> > 
> >   return evsel->core.attr.config == config;
> > }
> > #define evsel__match(evsel, t, c) __evsel__match(evsel, PERF_TYPE_##t,
> > PERF_COUNT_##c)
> 
> Yes, the above code looks better. I will apply it in V2.

Please base v2 on tmp.perf-tools-next, tests are running and that branch
will become perf-tools-next.

Some patches from your series were cherry-picked there.

- Arnaldo
