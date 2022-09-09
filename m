Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6AC5B3242
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 10:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbiIIIxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 04:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiIIIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 04:52:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF2112FB93;
        Fri,  9 Sep 2022 01:52:42 -0700 (PDT)
Date:   Fri, 09 Sep 2022 08:52:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662713561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqkjW98DMRYChszoVmaWu3Cc2pxnJYkUSMHWIMQTJoE=;
        b=XrBoVfiid554fT+XYRRy6YMlQTA/W+spllG90rZp/zPDyM48aHEhz0hJ+zwIG+vetdUxfr
        ThubDw+xNKWWYVlDU2pG6SbrucmFQK01ar7BVlZxUsLGOp1AVnZ2nHpqKxGnrr5kY3feQp
        eQJ2A6utK5zJyWXLb6Crp+8aCrUrVMYJ2rLXjp9F3Bzeq4DncLtUPNUAKz22ulWqhpM/vr
        tRyseAdieTvxR5EJD1737+jfPeXC9Mu46UVSkdw60+WoxRtjmiEvAcWz7tCYap1ss7IJcH
        /Agpu+INJMapRHmbxH8ZCMElGzcGbdEnsaYqVqTkct0CPpGcq3APsVn2lSNUCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662713561;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gqkjW98DMRYChszoVmaWu3Cc2pxnJYkUSMHWIMQTJoE=;
        b=MXsUKXf2c3ZMnHmguZ4SEIA0mnJ0pUjGfi0XKjQDVGDCTPJRdFBW8jSv6NPY5qCrQrcn47
        ey2Pg1ppHH4FYZAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Change x86_pmu::limit_period signature
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220829101321.573713839@infradead.org>
References: <20220829101321.573713839@infradead.org>
MIME-Version: 1.0
Message-ID: <166271355975.401.1487336464504025509.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     28f0f3c44b5c35be657a4f922dcdfb48285f4373
Gitweb:        https://git.kernel.org/tip/28f0f3c44b5c35be657a4f922dcdfb48285f4373
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 10 May 2022 21:28:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:54:02 +02:00

perf/x86: Change x86_pmu::limit_period signature

In preparation for making it a static_call, change the signature.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20220829101321.573713839@infradead.org
---
 arch/x86/events/amd/core.c   |  8 +++-----
 arch/x86/events/core.c       | 13 ++++++++-----
 arch/x86/events/intel/core.c | 19 ++++++++-----------
 arch/x86/events/perf_event.h |  2 +-
 4 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index bd99d2a..8b70237 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1224,16 +1224,14 @@ static ssize_t amd_event_sysfs_show(char *page, u64 config)
 	return x86_event_sysfs_show(page, config, event);
 }
 
-static u64 amd_pmu_limit_period(struct perf_event *event, u64 left)
+static void amd_pmu_limit_period(struct perf_event *event, s64 *left)
 {
 	/*
 	 * Decrease period by the depth of the BRS feature to get the last N
 	 * taken branches and approximate the desired period
 	 */
-	if (has_branch_stack(event) && left > x86_pmu.lbr_nr)
-		left -= x86_pmu.lbr_nr;
-
-	return left;
+	if (has_branch_stack(event) && *left > x86_pmu.lbr_nr)
+		*left -= x86_pmu.lbr_nr;
 }
 
 static __initconst const struct x86_pmu amd_pmu = {
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index b074e71..1e90bc7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -621,8 +621,9 @@ int x86_pmu_hw_config(struct perf_event *event)
 		event->hw.config |= event->attr.config & X86_RAW_EVENT_MASK;
 
 	if (event->attr.sample_period && x86_pmu.limit_period) {
-		if (x86_pmu.limit_period(event, event->attr.sample_period) >
-				event->attr.sample_period)
+		s64 left = event->attr.sample_period;
+		x86_pmu.limit_period(event, &left);
+		if (left > event->attr.sample_period)
 			return -EINVAL;
 	}
 
@@ -1396,9 +1397,9 @@ int x86_perf_event_set_period(struct perf_event *event)
 		left = x86_pmu.max_period;
 
 	if (x86_pmu.limit_period)
-		left = x86_pmu.limit_period(event, left);
+		x86_pmu.limit_period(event, &left);
 
-	per_cpu(pmc_prev_left[idx], smp_processor_id()) = left;
+	this_cpu_write(pmc_prev_left[idx], left);
 
 	/*
 	 * The hw event starts counting from this event offset,
@@ -2677,7 +2678,9 @@ static int x86_pmu_check_period(struct perf_event *event, u64 value)
 		return -EINVAL;
 
 	if (value && x86_pmu.limit_period) {
-		if (x86_pmu.limit_period(event, value) > value)
+		s64 left = value;
+		x86_pmu.limit_period(event, &left);
+		if (left > value)
 			return -EINVAL;
 	}
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index feed732..92cc390 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4344,28 +4344,25 @@ static u8 adl_get_hybrid_cpu_type(void)
  * Therefore the effective (average) period matches the requested period,
  * despite coarser hardware granularity.
  */
-static u64 bdw_limit_period(struct perf_event *event, u64 left)
+static void bdw_limit_period(struct perf_event *event, s64 *left)
 {
 	if ((event->hw.config & INTEL_ARCH_EVENT_MASK) ==
 			X86_CONFIG(.event=0xc0, .umask=0x01)) {
-		if (left < 128)
-			left = 128;
-		left &= ~0x3fULL;
+		if (*left < 128)
+			*left = 128;
+		*left &= ~0x3fULL;
 	}
-	return left;
 }
 
-static u64 nhm_limit_period(struct perf_event *event, u64 left)
+static void nhm_limit_period(struct perf_event *event, s64 *left)
 {
-	return max(left, 32ULL);
+	*left = max(*left, 32LL);
 }
 
-static u64 spr_limit_period(struct perf_event *event, u64 left)
+static void spr_limit_period(struct perf_event *event, s64 *left)
 {
 	if (event->attr.precise_ip == 3)
-		return max(left, 128ULL);
-
-	return left;
+		*left = max(*left, 128LL);
 }
 
 PMU_FORMAT_ATTR(event,	"config:0-7"	);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 7ae1a6c..e82d2d2 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -781,7 +781,7 @@ struct x86_pmu {
 	struct event_constraint *event_constraints;
 	struct x86_pmu_quirk *quirks;
 	int		perfctr_second_write;
-	u64		(*limit_period)(struct perf_event *event, u64 l);
+	void		(*limit_period)(struct perf_event *event, s64 *l);
 
 	/* PMI handler bits */
 	unsigned int	late_ack		:1,
