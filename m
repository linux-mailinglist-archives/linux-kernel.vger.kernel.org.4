Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEF468A36F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 21:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbjBCUPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 15:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjBCUPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 15:15:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8891882;
        Fri,  3 Feb 2023 12:15:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F6B6B82BB2;
        Fri,  3 Feb 2023 20:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB01AC433D2;
        Fri,  3 Feb 2023 20:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675455332;
        bh=3wRIsEkcYgnxR1oUaUKFTnjvlPLYKjDerxB/b+desAU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNrPSl5X5PzDmjlWqVQxEf/PMr/4ad/lJjFiZ6RNo5iwLeo+5hLoltqMLjhtHFFw6
         qQQlqqvcLDoIoDCaBqkP6r9mhyYAH3LHCraBq0fiARVl8x5oRUEL3YpoAOoAR04XF4
         hpCOTi2f+OgVUr3mHrZIl5vInJdziv28q6CYJdz/AdSq+jlUlFLQ0O0WWwUFWHYugQ
         erEHNa7QPVdrTZHJSa72QYsUV/SvJYa3dOE7lY45VVXMOoSvKudhFEzc8SFH0oz/0x
         anhhPBjyETEGVTuu/MXVpxJbSSBJs8F/BYYaEwtoUtLewLzX7phfFxmnaSYa5M9FOC
         JgDZ9BCDXyt+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 35877405BE; Fri,  3 Feb 2023 17:15:29 -0300 (-03)
Date:   Fri, 3 Feb 2023 17:15:29 -0300
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
Subject: Re: [PATCH v5 15/15] perf jevents: Run metric_test.py at compile-time
Message-ID: <Y91rYT5eBOFUHsJK@kernel.org>
References: <20230126233645.200509-1-irogers@google.com>
 <20230126233645.200509-16-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126233645.200509-16-irogers@google.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jan 26, 2023 at 03:36:45PM -0800, Ian Rogers escreveu:
> Add a target that generates a log file for running metric_test.py and
> make this a dependency on generating pmu-events.c. The log output is
> displayed if the test fails like (the test was modified to make it
> fail):
> 
> ```
>   TEST    /tmp/perf/pmu-events/metric_test.log
> F......
> ======================================================================
> FAIL: test_Brackets (__main__.TestMetricExpressions)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>   File "tools/perf/pmu-events/metric_test.py", line 33, in test_Brackets
>     self.assertEqual((a * b + c).ToPerfJson(), 'a * b + d')
> AssertionError: 'a * b + c' != 'a * b + d'
> - a * b + c
> ?         ^
> + a * b + d

Added this:

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 05806ecfc33c12a1..f533e76fb48002b7 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -38,6 +38,7 @@ arch/*/include/generated/
 trace/beauty/generated/
 pmu-events/pmu-events.c
 pmu-events/jevents
+pmu-events/metric_test.log
 feature/
 libapi/
 libbpf/
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index b7d9c42062300d04..bac9272682b759e9 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1103,6 +1103,7 @@ clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(
 		$(OUTPUT)util/intel-pt-decoder/inat-tables.c \
 		$(OUTPUT)tests/llvm-src-{base,kbuild,prologue,relocation}.c \
 		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)$(fadvise_advice_array) \
 		$(OUTPUT)$(fsconfig_arrays) \
 		$(OUTPUT)$(fsmount_arrays) \
