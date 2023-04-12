Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4061F6DFDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 20:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDLSum (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 14:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjDLSuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 14:50:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6159F5FF3;
        Wed, 12 Apr 2023 11:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E907663299;
        Wed, 12 Apr 2023 18:50:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2594CC433EF;
        Wed, 12 Apr 2023 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681325434;
        bh=/2jxq4xHTjD+8o2PeFbxUdVaRtfvmDoNrOeBLFUH2FQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qg7yIpsRPo219fDyijQMSKq3CmuCzb14lU00KlXwZFN2oed50JFEtjoo69siP7NI5
         sTOiqmc9clNmdNZgMw4Egh1I+AclwlqtFwnNVuBhaWSJH20RK8z+1OoVIU89VqHJxo
         MlMalIP42mxokR62OOJPrOkQzH7zsQgX7xSA3k2xzy1Ner+uWFLIcIYJtvHv2OZAwW
         xysFvrR1HcvenfNgeKA6FDd7fWPPoLopXcyLZuks5H88J7X+6M5oqUiofZ44XlQE7U
         LPFTSfMUdx7/I+JW+ZqWZ5w+u5Ux9UgiWHlFxZ6y0R6pJmQEFcKHfqvA7ACQHT3zg2
         RvcV2vkPdklCQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33A9140080; Wed, 12 Apr 2023 15:50:31 -0300 (-03)
Date:   Wed, 12 Apr 2023 15:50:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        James Clark <james.clark@arm.com>,
        John Garry <john.g.garry@oracle.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Hao Luo <haoluo@google.com>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH v7 2/5] perf cpumap: Add reference count checking
Message-ID: <ZDb9dycHQ11UIXwx@kernel.org>
References: <20230407230405.2931830-1-irogers@google.com>
 <20230407230405.2931830-3-irogers@google.com>
 <ZDWkmmj/UvuiXSWX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDWkmmj/UvuiXSWX@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Apr 11, 2023 at 03:19:06PM -0300, Arnaldo Carvalho de Melo escreveu:
> I think this should be further split into self contained patches as it
> does:
 
> These should be in a separate patchset using a new perf_cpu_map__set_nr() macro:
> 
> > +     RC_CHK_ACCESS(unmatched_cpus)->nr = unmatched_nr;
> > +     RC_CHK_ACCESS(matched_cpus)->nr = matched_nr;

One more:


From bd346e2074d07031d28b34a56a43fe848f7445ca Mon Sep 17 00:00:00 2001
From: Arnaldo Carvalho de Melo <acme@redhat.com>
Date: Wed, 12 Apr 2023 14:56:28 -0300
Subject: [PATCH 1/1] perf pmu: Use perf_cpu_map__set_nr() in
 perf_pmu__cpus_match() to allow for refcnt checking

One more step to allow for checking reference counting, user after free,
etc.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
Cc: Dmitriy Vyukov <dvyukov@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Riccardo Mancini <rickyman7@gmail.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>
Link: https://lore.kernel.org/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 561e2616861f8bd9..760c848c9fa27728 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -2020,8 +2020,8 @@ int perf_pmu__cpus_match(struct perf_pmu *pmu, struct perf_cpu_map *cpus,
 			matched_cpus->map[matched_nr++] = cpu;
 	}
 
-	unmatched_cpus->nr = unmatched_nr;
-	matched_cpus->nr = matched_nr;
+	perf_cpu_map__set_nr(unmatched_cpus, unmatched_nr);
+	perf_cpu_map__set_nr(matched_cpus, matched_nr);
 	*mcpus_ptr = matched_cpus;
 	*ucpus_ptr = unmatched_cpus;
 	return 0;
-- 
2.39.2

