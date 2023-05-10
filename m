Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AAC16FE357
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbjEJRkJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:40:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235768AbjEJRjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:39:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63A03ABA;
        Wed, 10 May 2023 10:39:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FC2F649C9;
        Wed, 10 May 2023 17:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E89CC433D2;
        Wed, 10 May 2023 17:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683740391;
        bh=L3QJRNGmXorOk4+D2bi74+pF6hHWPHZgyaNTHM83eTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fohov/Oh2SFwh26blqbfeQghhlrVcSiPP2cTXcjuw4PkIe9o3mhAHaVEYKOzqFaDE
         X/6TV/42xXKoYE4KIS45fxySEnjXu6uQnXdL2ndjy6ZGKSrQqhD7hX1uray/pn4NgA
         vcPJG6/Dgcog8bbstNS6NnKR/FXgrp9jqhgY16QG44BkmL+H4zW0srEjY37mLGnHso
         UmQvpXGrKeGSHK+jgD+GpwvFlsihOup2O+vMnTHHVuw8KJDE4DQsyeKdeipqftNdbm
         2KFSf/fqGXSr69S9Y3PsZowDSO+ct62qFZkPwf16fK8ySv3pcaUaY/IOuXexhZJohl
         8LEKaBBG5236Q==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id F2543403B5; Wed, 10 May 2023 14:39:48 -0300 (-03)
Date:   Wed, 10 May 2023 14:39:48 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: arm64: Fix build with refcount checking
Message-ID: <ZFvW5A6C9ZD+bVBU@kernel.org>
References: <20230504160845.2065510-1-james.clark@arm.com>
 <CAP-5=fX+PB9_UVPxwpHwcesupu_8f2c8bp5KOHrG9WAFH4VBpw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX+PB9_UVPxwpHwcesupu_8f2c8bp5KOHrG9WAFH4VBpw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 04, 2023 at 09:28:21AM -0700, Ian Rogers escreveu:
> On Thu, May 4, 2023 at 9:09 AM James Clark <james.clark@arm.com> wrote:
> >
> > With EXTRA_CFLAGS=-DREFCNT_CHECKING=1 and build-test, some unwrapped
> > map accesses appear. Wrap it in the new accessor to fix the error:
> >
> >   error: 'struct perf_cpu_map' has no member named 'map'
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> 
> Thanks James and sorry for the breakage!
> Acked-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> Ian
> 
> > ---
> >  tools/perf/arch/arm64/util/header.c | 4 ++--
> >  tools/perf/arch/arm64/util/pmu.c    | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm64/util/header.c b/tools/perf/arch/arm64/util/header.c
> > index d730666ab95d..80b9f6287fe2 100644
> > --- a/tools/perf/arch/arm64/util/header.c
> > +++ b/tools/perf/arch/arm64/util/header.c
> > @@ -29,8 +29,8 @@ static int _get_cpuid(char *buf, size_t sz, struct perf_cpu_map *cpus)
> >                 char path[PATH_MAX];
> >                 FILE *file;
> >
> > -               scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d"MIDR,
> > -                               sysfs, cpus->map[cpu]);
> > +               scnprintf(path, PATH_MAX, "%s/devices/system/cpu/cpu%d" MIDR,
> > +                         sysfs, RC_CHK_ACCESS(cpus)->map[cpu].cpu);
> >
> >                 file = fopen(path, "r");
> >                 if (!file) {
> > diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
> > index fa143acb4c8d..ef1ed645097c 100644
> > --- a/tools/perf/arch/arm64/util/pmu.c
> > +++ b/tools/perf/arch/arm64/util/pmu.c
> > @@ -18,7 +18,7 @@ static struct perf_pmu *pmu__find_core_pmu(void)
> >                  * The cpumap should cover all CPUs. Otherwise, some CPUs may
> >                  * not support some events or have different event IDs.
> >                  */
> > -               if (pmu->cpus->nr != cpu__max_cpu().cpu)
> > +               if (RC_CHK_ACCESS(pmu->cpus)->nr != cpu__max_cpu().cpu)
> >                         return NULL;
> >
> >                 return pmu;
> > --
> > 2.34.1
> >

-- 

- Arnaldo
