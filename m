Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28C373DAF8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 11:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229745AbjFZJNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 05:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjFZJNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 05:13:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840EACF;
        Mon, 26 Jun 2023 02:11:38 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:11:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687770697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLrCfUj1gz6XJZCy8ciEXBruwvjRQGfrNcCNYAk8+q4=;
        b=dRpxAWOH4NEi9SmvL8Nabc5XMPw//0m8faocx3mHUksEYa9XNjgOaCr3ij52MXg59x43v9
        gkV3Kvvhl4Ca4Z32Ii0oI9yDPXR0k4k77ptqKMjaNE1pEDL7kGGoBqhgmuj/8d6tawmbrc
        jXjYgUIFXnuN0MwUjxmP17Yxfz9ex7zFrZzUmM7bj6QsNSP0qTkKRvNmE831YQ0DrThVU8
        BQVudyEhltfafmUmO2NBP29lw9iU6RZKdxLg9uqkprCaiHcuqGCQgZyvLBr8AVv/a6wMIp
        sZIaZ6wY1vZcKGnLVdIcf47a219O3s3rKiw7oY6fr7W7YdBb/l0CG4iyfn5x0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687770697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tLrCfUj1gz6XJZCy8ciEXBruwvjRQGfrNcCNYAk8+q4=;
        b=qjJvgkZVnK+RTdBf1NE6BdmnOOQuM75FkEhKWI63tsfq8Y9+qMjX4LAEulMb7k1ddLTqYt
        2mLNT1Kt1s9y1HDg==
From:   "tip-bot2 for Michael Kelley" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/hyper-v: Rework clocksource
 and sched clock setup
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1687201360-16003-1-git-send-email-mikelley@microsoft.com>
References: <1687201360-16003-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Message-ID: <168777069659.404.15925051070119865399.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e5313f1c540434b18ea57927633b1584c534b14a
Gitweb:        https://git.kernel.org/tip/e5313f1c540434b18ea57927633b1584c534b14a
Author:        Michael Kelley <mikelley@microsoft.com>
AuthorDate:    Mon, 19 Jun 2023 12:02:40 -07:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 23 Jun 2023 09:33:43 +02:00

clocksource/drivers/hyper-v: Rework clocksource and sched clock setup

Current code assigns either the Hyper-V TSC page or MSR-based ref counter
as the sched clock. This may be sub-optimal in two cases. First, if there
is hardware support to ensure consistent TSC frequency across live
migrations and Hyper-V is using that support, the raw TSC is a faster
source of time than the Hyper-V TSC page.  Second, the MSR-based ref
counter is relatively slow because reads require a trap to the hypervisor.
As such, it should never be used as the sched clock. The native sched
clock based on the raw TSC or jiffies is much better.

Rework the sched clock setup so it is set to the TSC page only if
Hyper-V indicates that the TSC may have inconsistent frequency across
live migrations. Also, remove the code that sets the sched clock to
the MSR-based ref counter. In the cases where it is not set, the sched
clock will then be the native sched clock.

As part of the rework, always enable both the TSC page clocksource and
the MSR-based ref counter clocksource. Set the ratings so the TSC page
clocksource is preferred. While the MSR-based ref counter clocksource
is unlikely to ever be the default, having it available for manual
selection is convenient for development purposes.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1687201360-16003-1-git-send-email-mikelley@microsoft.com
---
 drivers/clocksource/hyperv_timer.c | 54 ++++++++++++-----------------
 1 file changed, 23 insertions(+), 31 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index bcd9042..9fc008c 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -475,15 +475,9 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
 	return read_hv_clock_msr();
 }
 
-static u64 notrace read_hv_sched_clock_msr(void)
-{
-	return (read_hv_clock_msr() - hv_sched_clock_offset) *
-		(NSEC_PER_SEC / HV_CLOCK_HZ);
-}
-
 static struct clocksource hyperv_cs_msr = {
 	.name	= "hyperv_clocksource_msr",
-	.rating	= 500,
+	.rating	= 495,
 	.read	= read_hv_clock_msr_cs,
 	.mask	= CLOCKSOURCE_MASK(64),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
@@ -513,7 +507,7 @@ static __always_inline void hv_setup_sched_clock(void *sched_clock)
 static __always_inline void hv_setup_sched_clock(void *sched_clock) {}
 #endif /* CONFIG_GENERIC_SCHED_CLOCK */
 
-static bool __init hv_init_tsc_clocksource(void)
+static void __init hv_init_tsc_clocksource(void)
 {
 	union hv_reference_tsc_msr tsc_msr;
 
@@ -524,17 +518,14 @@ static bool __init hv_init_tsc_clocksource(void)
 	 * Hyper-V Reference TSC rating, causing the generic TSC to be used.
 	 * TSC_INVARIANT is not offered on ARM64, so the Hyper-V Reference
 	 * TSC will be preferred over the virtualized ARM64 arch counter.
-	 * While the Hyper-V MSR clocksource won't be used since the
-	 * Reference TSC clocksource is present, change its rating as
-	 * well for consistency.
 	 */
 	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
 		hyperv_cs_tsc.rating = 250;
-		hyperv_cs_msr.rating = 250;
+		hyperv_cs_msr.rating = 245;
 	}
 
 	if (!(ms_hyperv.features & HV_MSR_REFERENCE_TSC_AVAILABLE))
-		return false;
+		return;
 
 	hv_read_reference_counter = read_hv_clock_tsc;
 
@@ -565,33 +556,34 @@ static bool __init hv_init_tsc_clocksource(void)
 
 	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
 
-	hv_sched_clock_offset = hv_read_reference_counter();
-	hv_setup_sched_clock(read_hv_sched_clock_tsc);
-
-	return true;
+	/*
+	 * If TSC is invariant, then let it stay as the sched clock since it
+	 * will be faster than reading the TSC page. But if not invariant, use
+	 * the TSC page so that live migrations across hosts with different
+	 * frequencies is handled correctly.
+	 */
+	if (!(ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)) {
+		hv_sched_clock_offset = hv_read_reference_counter();
+		hv_setup_sched_clock(read_hv_sched_clock_tsc);
+	}
 }
 
 void __init hv_init_clocksource(void)
 {
 	/*
-	 * Try to set up the TSC page clocksource. If it succeeds, we're
-	 * done. Otherwise, set up the MSR clocksource.  At least one of
-	 * these will always be available except on very old versions of
-	 * Hyper-V on x86.  In that case we won't have a Hyper-V
+	 * Try to set up the TSC page clocksource, then the MSR clocksource.
+	 * At least one of these will always be available except on very old
+	 * versions of Hyper-V on x86.  In that case we won't have a Hyper-V
 	 * clocksource, but Linux will still run with a clocksource based
 	 * on the emulated PIT or LAPIC timer.
+	 *
+	 * Never use the MSR clocksource as sched clock.  It's too slow.
+	 * Better to use the native sched clock as the fallback.
 	 */
-	if (hv_init_tsc_clocksource())
-		return;
-
-	if (!(ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE))
-		return;
-
-	hv_read_reference_counter = read_hv_clock_msr;
-	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
+	hv_init_tsc_clocksource();
 
-	hv_sched_clock_offset = hv_read_reference_counter();
-	hv_setup_sched_clock(read_hv_sched_clock_msr);
+	if (ms_hyperv.features & HV_MSR_TIME_REF_COUNT_AVAILABLE)
+		clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
 }
 
 void __init hv_remap_tsc_clocksource(void)
