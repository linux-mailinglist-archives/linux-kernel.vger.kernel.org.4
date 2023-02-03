Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B475689FC6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 17:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbjBCQ4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 11:56:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233628AbjBCQ4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 11:56:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16716A8A09;
        Fri,  3 Feb 2023 08:56:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99BE0B82B5F;
        Fri,  3 Feb 2023 16:56:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92F2C4339C;
        Fri,  3 Feb 2023 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675443392;
        bh=h7/viEQOihIqILr+s/nTh73JPYHxsBqSaGRcETP5tcc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WfZv1S4za0O8S3xKBAkzhmkDpjjZ5oMqlrzwy1eL1z0Jm58kGxDHxDlxOhtb1hnXR
         hCTWoVCsZtuRXqIGYrcEG/YZn1c6u+7K9wxU1h4DsqhD0Bxf7clbr94+M5BnLM4l38
         fD8c3ajfVnCwOqWCi7qlkAP1Vwe5/cfogMlFwkdQKmmoaekXC2n+PgLCp7f2wFzhqI
         WOmwdh0YG4lOxcEQlhhKDW45HxHbtLnetEj29k/r4ezpHUErFZMfjP57XRUXkVQjCC
         jaNlj/nIqFmsjWXpNXckrtCZQilOvm8SYQIqqnG2tVkaEUNtLp0TLxBgqmyLbfuV0+
         jR7bn63bl+pWQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 99CD8405BE; Fri,  3 Feb 2023 13:56:28 -0300 (-03)
Date:   Fri, 3 Feb 2023 13:56:28 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Rob Herring <robh@kernel.org>,
        Kang Minchul <tegongkang@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sandipan Das <sandipan.das@amd.com>,
        Jing Zhang <renyu.zj@linux.alibaba.com>,
        linuxppc-dev@lists.ozlabs.org, Kajol Jain <kjain@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Caleb Biggers <caleb.biggers@intel.com>
Subject: Re: [PATCH v1] perf pmu: Fix aarch64 build
Message-ID: <Y908vNzJp7cVM8gN@kernel.org>
References: <20230203014014.75720-1-irogers@google.com>
 <CAP-5=fX0ohsCUspm7NowDy2bmSr2cJfp=iaStK4EAdVy7zBHGA@mail.gmail.com>
 <Y90XgtX9uv26UAQa@kernel.org>
 <Y90bsM4DGL+WV8m0@kernel.org>
 <Y90b7shHtOCQL3ma@kernel.org>
 <Y90di+N7TODkFvMV@kernel.org>
 <Y90rtA95mWW5Othk@kernel.org>
 <Y90v+jTe6z1dSFE0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y90v+jTe6z1dSFE0@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Feb 03, 2023 at 01:02:02PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Fri, Feb 03, 2023 at 12:43:48PM -0300, Arnaldo Carvalho de Melo escreveu:
> > I tried bisecting, but at this cset:
> > 
> > acme@roc-rk3399-pc:~/git/perf$ git log --oneline -1
> > d22e569cd33d (HEAD) perf pmu-events: Separate the metrics from events for no jevents
> > acme@roc-rk3399-pc:~/git/perf$
> > 
> > I'm getting this:
> > 
> >   CC      /tmp/build/perf/pmu-events/pmu-events.o
> > pmu-events/pmu-events.c:3637:32: error: no previous prototype for ‘perf_pmu__find_table’ [-Werror=missing-prototypes]
> >  3637 | const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
> >       |                                ^~~~~~~~~~~~~~~~~~~~
> >   CC      /tmp/build/perf/builtin-ftrace.o
> >   CC      /tmp/build/perf/builtin-help.o
> >   CC      /tmp/build/perf/builtin-buildid-list.o
> > cc1: all warnings being treated as errors
> > make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/build/perf/pmu-events/pmu-events.o] Error 1
> > make[2]: *** [Makefile.perf:676: /tmp/build/perf/pmu-events/pmu-events-in.o] Error 2
> > make[2]: *** Waiting for unfinished jobs....
> >   CC      /tmp/build/perf/builtin-buildid-cache.o
> > 
> > <SNIP>
> > 
> >   CC      /tmp/build/perf/tests/attr.o
> > arch/arm64/util/pmu.c: In function ‘pmu_events_table__find’:
> > arch/arm64/util/pmu.c:35:24: error: implicit declaration of function ‘perf_pmu__find_table’; did you mean ‘perf_pmu__find_by_type’? [-Werror=implicit-function-declaration]
> >    35 |                 return perf_pmu__find_table(pmu);
> >       |                        ^~~~~~~~~~~~~~~~~~~~
> >       |                        perf_pmu__find_by_type
> > arch/arm64/util/pmu.c:35:24: error: returning ‘int’ from a function with return type ‘const struct pmu_events_table *’ makes pointer from integer without a cast [-Werror=int-conversion]
> >    35 |                 return perf_pmu__find_table(pmu);
> >       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~
> > cc1: all warnings being treated as errors
> > make[6]: *** [/home/acme/git/perf/tools/build/Makefile.build:97: /tmp/build/perf/arch/arm64/util/pmu.o] Error 1
> > make[5]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: util] Error 2
> > make[4]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: arm64] Error 2
> > make[3]: *** [/home/acme/git/perf/tools/build/Makefile.build:139: arch] Error 2
> > make[3]: *** Waiting for unfinished jobs....
> >   CC      /tmp/build/perf/tests/vmlinux-kallsyms.o
> > 
> > -----
> > 
> > I'm building with:
> 
> So:
> 
> acme@roc-rk3399-pc:~/git/perf$ find tools/perf/ -name "*.[ch]" | xargs grep -w perf_pmu__find_table
> tools/perf/arch/arm64/util/pmu.c:		return perf_pmu__find_table(pmu);
> tools/perf/pmu-events/pmu-events.c:const struct pmu_events_table *perf_pmu__find_table(struct perf_pmu *pmu)
> acme@roc-rk3399-pc:~/git/perf$
> acme@roc-rk3399-pc:~/git/perf$ git log --oneline -1
> d22e569cd33d (HEAD) perf pmu-events: Separate the metrics from events for no jevents
> acme@roc-rk3399-pc:~/git/perf$
> 
> Tring to fix...

tools/perf/pmu-events/pmu-events.c was a leftover from a previous build,
strange as I build using O=, not to clutter the source dir, so perhaps
handling that is missing, I'll check.

Fixed aarch64 specific one with:

diff --git a/tools/perf/arch/arm64/util/pmu.c b/tools/perf/arch/arm64/util/pmu.c
index 801bf52e2ea6..b4eaf00ec5a8 100644
--- a/tools/perf/arch/arm64/util/pmu.c
+++ b/tools/perf/arch/arm64/util/pmu.c
@@ -32,7 +32,7 @@ const struct pmu_events_table *pmu_events_table__find(void)
 	struct perf_pmu *pmu = pmu__find_core_pmu();
 
 	if (pmu)
-		return perf_pmu__find_table(pmu);
+		return perf_pmu__find_events_table(pmu);
 
 	return NULL;
 }


---

Continuing...
