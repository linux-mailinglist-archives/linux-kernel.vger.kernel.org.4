Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A3A6045B8
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbiJSMsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 08:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiJSMri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 08:47:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A365191D40
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:39 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c24so17085891pls.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 05:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OSeVek4DWAXpR4R90owtFBiMLKu023iutKikpjmU0co=;
        b=3H54g9C37A6stfEGM0FnJt1/rtt6dcPlNNRW1AVTeKPZ94o4gIE5RB45VtI9EQHmAy
         B+/sOk9RlFHKETZx2kWSA3hdU1cuLsa7kK79UlEDJ3sa+hPObyMIll4sUcHM3EMN42+v
         1C5zszRoNCaekZgIimEr1Zv6z1xBa/aEnqxlhr8Ytu3t0zbyq9WIHqEgs19tX2xbO+U8
         lT3QhnZSeow8f81cfv925yFiz4JcxOntqsPEYT+cNHgggo72A81lqJEKRN1s1eW8Elj/
         CAeECSunQhYtzqHqLTqkt0tFVyPnWgtRhSqQZTzXBs94d3lJNcgmr9ZKeOI9IJiSoo21
         j/Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSeVek4DWAXpR4R90owtFBiMLKu023iutKikpjmU0co=;
        b=BSTaOqeWEERdM1A5FmW7rno1hNR4Y+jpkw/0yuEeoEtBqAd6bqdAtht3f06rSAppxT
         Hq1+FwxDindH5DGRDR2RYez2MnK9BONlzGML398wSIs+0cF36hX1ACV6WDYTVP48VdOP
         orYIgb2y+LHRA6uL9jLfuEhKWQp+MMV8qq74f9MIc1ZtTqoJ4f3IPEuLAwf+R96gD0CI
         +aQlvsfn79emGPHi73VXw2lQbOjEzrCjeI//4eukunzvc0/EDFY77JzMIm5npoyHBsx0
         ny0RNayHA4D/Q5dBBE10d74g79rkmdljvU+M28rwTC69rW+MMa6WFMYG9wAJajKQuq0B
         79tQ==
X-Gm-Message-State: ACrzQf0Kc4x2a1LhsX1kWfi+MBmLUq3/12WJVvnhu6jizGB+FbVbePVX
        si7+Qfb7WR+iFgmfN/aSNDpEoA==
X-Google-Smtp-Source: AMsMyM4CsKMqNz500jBLg5msRQWaeDUN5gKupA91GG3TA1qrpTBmF7XO/gJIdnDHCZvzqrlKqMFrWw==
X-Received: by 2002:a17:90a:db0f:b0:20a:7294:638d with SMTP id g15-20020a17090adb0f00b0020a7294638dmr43710507pjv.228.1666182582643;
        Wed, 19 Oct 2022 05:29:42 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id c21-20020a63da15000000b00439c6a4e1ccsm9881825pgh.62.2022.10.19.05.29.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Oct 2022 05:29:42 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v6 2/4] sched/fair: Ignore SIS_UTIL when has_idle_core
Date:   Wed, 19 Oct 2022 20:28:57 +0800
Message-Id: <20221019122859.18399-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221019122859.18399-1-wuyun.abel@bytedance.com>
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SIS_UTIL is enabled, SIS domain scan will be skipped if the
LLC is overloaded even the has_idle_core hint is true. Since idle
load balancing is triggered at tick boundary, the idle cores can
stay cold for the whole tick period wasting time meanwhile some
of other cpus might be overloaded.

Give it a chance to scan for idle cores if the hint implies a
worthy effort.

Benchmark
=========

All of the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled, and test machines are:

A) A dual socket machine modeled Intel Xeon(R) Platinum 8260 with SNC
disabled, so there are 2 NUMA nodes each of which has 24C/48T. Each
NUMA shares an LLC.

B) A dual socket machine modeled AMD EPYC 7Y83 64-Core Processor with
NPS1 enabled, so there are 2 NUMA nodes each of which has 64C/128T.
Each NUMA node contains several LLCs sized of 16 cpus.

Based on tip sched/core fb04563d1cae (v5.19.0).

Results
=======

hackbench-process-pipes
 (A)			 vanilla		patched
Amean     1        0.2767 (   0.00%)      0.2540 (   8.19%)
Amean     4        0.6080 (   0.00%)      0.6220 (  -2.30%)
Amean     7        0.7923 (   0.00%)      0.8020 (  -1.22%)
Amean     12       1.3917 (   0.00%)      1.1823 (  15.04%)
Amean     21       3.6747 (   0.00%)      2.7717 (  24.57%)
Amean     30       6.7070 (   0.00%)      5.1200 *  23.66%*
Amean     48       9.3537 (   0.00%)      8.5890 *   8.18%*
Amean     79      11.6627 (   0.00%)     11.2580 (   3.47%)
Amean     110     13.4473 (   0.00%)     13.1283 (   2.37%)
Amean     141     16.4747 (   0.00%)     15.5967 *   5.33%*
Amean     172     19.0000 (   0.00%)     18.1153 *   4.66%*
Amean     203     21.4200 (   0.00%)     21.1340 (   1.34%)
Amean     234     24.2250 (   0.00%)     23.8227 (   1.66%)
Amean     265     27.2400 (   0.00%)     26.8293 (   1.51%)
Amean     296     30.6937 (   0.00%)     29.5800 *   3.63%*
 (B)
Amean     1        0.3543 (   0.00%)      0.3650 (  -3.01%)
Amean     4        0.4623 (   0.00%)      0.4837 (  -4.61%)
Amean     7        0.5117 (   0.00%)      0.4997 (   2.35%)
Amean     12       0.5707 (   0.00%)      0.5863 (  -2.75%)
Amean     21       0.9717 (   0.00%)      0.8930 *   8.10%*
Amean     30       1.4423 (   0.00%)      1.2530 (  13.13%)
Amean     48       2.3520 (   0.00%)      1.9743 *  16.06%*
Amean     79       5.7193 (   0.00%)      3.4933 *  38.92%*
Amean     110      6.9893 (   0.00%)      5.5963 *  19.93%*
Amean     141      9.1103 (   0.00%)      7.6550 (  15.97%)
Amean     172     10.2490 (   0.00%)      8.8323 *  13.82%*
Amean     203     11.3727 (   0.00%)     10.8683 (   4.43%)
Amean     234     12.7627 (   0.00%)     11.8683 (   7.01%)
Amean     265     13.8947 (   0.00%)     13.4717 (   3.04%)
Amean     296     14.1093 (   0.00%)     13.8130 (   2.10%)

The results can approximately divided into 3 sections:
 - busy, e.g. <12 groups on A and <21 groups on B
 - overloaded, e.g. 12~48 groups on A and 21~172 groups on B
 - saturated, the rest part

For the busy part the result is neutral with slight wins or loss.
It is probably because there are still idle cpus not hard to be find
so the effort we paid for locating an idle core will bring limited
benefit which can be negated by the cost of full scan easily.

While for the overloaded but not saturated part, great improvement
can be seen due to exploiting the cpu resources by more actively
kicking idle cores working. But once all cpus are totally saturated,
scanning for idle cores doesn't help much.

One concern of the full scan is that the cost gets bigger in larger
LLCs, but the test result seems still positive. One possible reason
is due to the low SIS success rate (<2%), so the paid effort will
indeed trade for efficiency.

tbench4 Throughput
 (A)			 vanilla		patched
Hmean     1        275.61 (   0.00%)      280.53 *   1.78%*
Hmean     2        541.28 (   0.00%)      561.94 *   3.82%*
Hmean     4       1102.62 (   0.00%)     1109.14 *   0.59%*
Hmean     8       2149.58 (   0.00%)     2229.39 *   3.71%*
Hmean     16      4305.40 (   0.00%)     4383.06 *   1.80%*
Hmean     32      7088.36 (   0.00%)     7124.14 *   0.50%*
Hmean     64      8609.16 (   0.00%)     8815.41 *   2.40%*
Hmean     128    19304.92 (   0.00%)    19519.35 *   1.11%*
Hmean     256    19147.04 (   0.00%)    19392.24 *   1.28%*
Hmean     384    18970.86 (   0.00%)    19201.07 *   1.21%*
 (B)
Hmean     1         519.62 (   0.00%)      515.98 *  -0.70%*
Hmean     2        1042.92 (   0.00%)     1031.54 *  -1.09%*
Hmean     4        1959.10 (   0.00%)     1953.44 *  -0.29%*
Hmean     8        3842.82 (   0.00%)     3622.52 *  -5.73%*
Hmean     16       6768.50 (   0.00%)     6545.82 *  -3.29%*
Hmean     32      12589.50 (   0.00%)    13697.73 *   8.80%*
Hmean     64      24797.23 (   0.00%)    25589.59 *   3.20%*
Hmean     128     38036.66 (   0.00%)    35667.64 *  -6.23%*
Hmean     256     65069.93 (   0.00%)    65215.85 *   0.22%*
Hmean     512     61147.99 (   0.00%)    66035.57 *   7.99%*
Hmean     1024    48542.73 (   0.00%)    53391.64 *   9.99%*

The tbench4 test has a ~40% success rate on used target, prev or
recent cpus, and ~45% of total success rate. And the core scan is
also not very frequent, so the benefit this patch brings is limited
while still some gains can be seen.

netperf

The netperf has an almost 100% success rate on used target, prev or
recent cpus, so the domain scan is generally not performed and not
affected by this patch.

Conclusion
==========

Taking full scan for idle cores is generally good for making better
use of the cpu resources.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Tested-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/fair.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e7f82fa92c5b..7b668e16812e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6436,7 +6436,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		time = cpu_clock(this);
 	}
 
-	if (sched_feat(SIS_UTIL)) {
+	if (sched_feat(SIS_UTIL) && !has_idle_core) {
 		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
 		if (sd_share) {
 			/* because !--nr is the condition to stop scan */
-- 
2.37.3

