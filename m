Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6886CBD1A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjC1LH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231365AbjC1LHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461057D93
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=ChQJJCdcacurj6PDeiSczxM1Ai8HwF4oJqBp0TPIkNE=; b=cIB8rYocU95kjDFWxHwMBhIwpF
        vDNY2Gp8+ReobdmgwEegEa/lJA2YS/solY8Tw48Z26ONoNBrXS/heKRSkZ9bzz7KcQ+TbVekoRCpk
        axsUCEO3k+9B5bY5uhyU9C3oLzu1tyDkefSFYISJEU5C4Le+en5Xcq3Wvr5OTfu0hkYQS00GwbtpW
        4yAqtpICPcMdeH/9GqumGWi4gVqLY5oGDlg4GKWEGGJztVcoipObDgdSju489RK2c3vye9QQDRhMc
        4L18p3CJkDaVw2uNIEsBr7ewyL8VOYhQ3i8vyo6f1PgGr7j1jqjRMdSr/rp/uwHuLICtD/zl3G2RX
        Fj0W0AdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph79m-008MDH-A0; Tue, 28 Mar 2023 11:06:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 682B2302ECC;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E41D82CB8D7A6; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110354.426388922@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:34 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 12/17] sched/debug: Rename min_granularity to base_slice
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c |    4 ++--
 kernel/sched/fair.c  |   10 +++++-----
 kernel/sched/sched.h |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -308,7 +308,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
 
-	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
+	debugfs_create_u32("base_slice_ns", 0644, debugfs_sched, &sysctl_sched_base_slice);
 
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
 	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
@@ -816,7 +816,7 @@ static void sched_debug_header(struct se
 	SEQ_printf(m, "  .%-40s: %Ld\n", #x, (long long)(x))
 #define PN(x) \
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
-	PN(sysctl_sched_min_granularity);
+	PN(sysctl_sched_base_slice);
 	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
 #undef PN
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -75,8 +75,8 @@ unsigned int sysctl_sched_tunable_scalin
  *
  * (default: 0.75 msec * (1 + ilog(ncpus)), units: nanoseconds)
  */
-unsigned int sysctl_sched_min_granularity			= 750000ULL;
-static unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
+unsigned int sysctl_sched_base_slice			= 750000ULL;
+static unsigned int normalized_sysctl_sched_base_slice	= 750000ULL;
 
 /*
  * After fork, child runs first. If set to 0 (default) then
@@ -237,7 +237,7 @@ static void update_sysctl(void)
 
 #define SET_SYSCTL(name) \
 	(sysctl_##name = (factor) * normalized_sysctl_##name)
-	SET_SYSCTL(sched_min_granularity);
+	SET_SYSCTL(sched_base_slice);
 #undef SET_SYSCTL
 }
 
@@ -882,7 +882,7 @@ int sched_update_scaling(void)
 
 #define WRT_SYSCTL(name) \
 	(normalized_sysctl_##name = sysctl_##name / (factor))
-	WRT_SYSCTL(sched_min_granularity);
+	WRT_SYSCTL(sched_base_slice);
 #undef WRT_SYSCTL
 
 	return 0;
@@ -892,7 +892,7 @@ int sched_update_scaling(void)
 long calc_latency_offset(int prio)
 {
 	u32 weight = sched_prio_to_weight[prio];
-	u64 base = sysctl_sched_min_granularity;
+	u64 base = sysctl_sched_base_slice;
 
 	return div_u64(base << SCHED_FIXEDPOINT_SHIFT, weight);
 }
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2464,7 +2464,7 @@ extern const_debug unsigned int sysctl_s
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
 #ifdef CONFIG_SCHED_DEBUG
-extern unsigned int sysctl_sched_min_granularity;
+extern unsigned int sysctl_sched_base_slice;
 extern int sysctl_resched_latency_warn_ms;
 extern int sysctl_resched_latency_warn_once;
 


