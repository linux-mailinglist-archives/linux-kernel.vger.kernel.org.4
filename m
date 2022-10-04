Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691F25F3FBD
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiJDJbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F7A11176;
        Tue,  4 Oct 2022 02:27:24 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875643;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6i+DxbJm/doHi/BHp8YQeKiqR1C8kCGmcZdL7hAEQK8=;
        b=vsKJA24qxoxw0p2vj4ca/WrnDTRcFYyD5rgdK/mHbh0QUBaTtdIiph4NDCWhSkhHQLYLxn
        F5OR8u9dh+B0zyjE4T8+uXsknIChEQ9L5uNK3O6KBMcecpUOoXfrTPb+BgGUsI9PyE5exE
        aUvAGFCzOrYBso/6EC1nsjyGKVnppcRFyUXNG9RaLDPJVM/eoryWuv4FwrsS+olT/fvJvg
        ExW0FZf/AkpklNOV9U4PXLIB10Sar+8YiDJoGjF8KzM1masDkifoyDN0yk7w5FU3FOEcip
        v7EpAsUkGu46fNaGn+/79USeXeQU9jDJ+SxYZsEBC2q9vGX9oppgI2ONAsxenw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875643;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6i+DxbJm/doHi/BHp8YQeKiqR1C8kCGmcZdL7hAEQK8=;
        b=Pryac6F4Tq8b2K3oe6CnDq63sSe5tUrvpi8f1xk47BGsOhSV80LYcEnKajqvUglYT3KxOP
        NmMsklYwn3f1YHCQ==
From:   "tip-bot2 for Vincent Whitchurch" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Support
 local-timers property
Cc:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220609112738.359385-4-vincent.whitchurch@axis.com>
References: <20220609112738.359385-4-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Message-ID: <166487564166.401.1467190955976259089.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     47dbe4eb9822208be2b7ec901c7e0c15536f9c92
Gitweb:        https://git.kernel.org/tip/47dbe4eb9822208be2b7ec901c7e0c15536f9c92
Author:        Vincent Whitchurch <vincent.whitchurch@axis.com>
AuthorDate:    Thu, 09 Jun 2022 13:27:37 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/exynos_mct: Support local-timers property

If the device tree indicates that the hardware requires that the
processor only use certain local timers, respect that.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20220609112738.359385-4-vincent.whitchurch@axis.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 62 ++++++++++++++++++++++++++++---
 1 file changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index 1202383..bfd6009 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -33,7 +33,7 @@
 #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
 #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
 #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
-#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
+#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
 #define EXYNOS4_MCT_L_MASK		(0xffffff00)
 
 #define MCT_L_TCNTB_OFFSET		(0x00)
@@ -66,6 +66,8 @@
 #define MCT_L0_IRQ	4
 /* Max number of IRQ as per DT binding document */
 #define MCT_NR_IRQS	20
+/* Max number of local timers */
+#define MCT_NR_LOCAL	(MCT_NR_IRQS - MCT_L0_IRQ)
 
 enum {
 	MCT_INT_SPI,
@@ -456,7 +458,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
 		per_cpu_ptr(&percpu_mct_tick, cpu);
 	struct clock_event_device *evt = &mevt->evt;
 
-	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
 	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
 
 	evt->name = mevt->name;
@@ -527,8 +528,17 @@ static int __init exynos4_timer_resources(struct device_node *np)
 	return 0;
 }
 
+/**
+ * exynos4_timer_interrupts - initialize MCT interrupts
+ * @np: device node for MCT
+ * @int_type: interrupt type, MCT_INT_PPI or MCT_INT_SPI
+ * @local_idx: array mapping CPU numbers to local timer indices
+ * @nr_local: size of @local_idx array
+ */
 static int __init exynos4_timer_interrupts(struct device_node *np,
-					   unsigned int int_type)
+					   unsigned int int_type,
+					   const u32 *local_idx,
+					   size_t nr_local)
 {
 	int nr_irqs, i, err, cpu;
 
@@ -561,13 +571,21 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 	} else {
 		for_each_possible_cpu(cpu) {
 			int mct_irq;
+			unsigned int irq_idx;
 			struct mct_clock_event_device *pcpu_mevt =
 				per_cpu_ptr(&percpu_mct_tick, cpu);
 
+			if (cpu >= nr_local) {
+				err = -EINVAL;
+				goto out_irq;
+			}
+
+			irq_idx = MCT_L0_IRQ + local_idx[cpu];
+
 			pcpu_mevt->evt.irq = -1;
-			if (MCT_L0_IRQ + cpu >= ARRAY_SIZE(mct_irqs))
+			if (irq_idx >= ARRAY_SIZE(mct_irqs))
 				break;
-			mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
+			mct_irq = mct_irqs[irq_idx];
 
 			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
 			if (request_irq(mct_irq,
@@ -583,6 +601,17 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
 		}
 	}
 
+	for_each_possible_cpu(cpu) {
+		struct mct_clock_event_device *mevt = per_cpu_ptr(&percpu_mct_tick, cpu);
+
+		if (cpu >= nr_local) {
+			err = -EINVAL;
+			goto out_irq;
+		}
+
+		mevt->base = EXYNOS4_MCT_L_BASE(local_idx[cpu]);
+	}
+
 	/* Install hotplug callbacks which configure the timer on this CPU */
 	err = cpuhp_setup_state(CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 				"clockevents/exynos4/mct_timer:starting",
@@ -613,13 +642,34 @@ out_irq:
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
 	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
+	u32 local_idx[MCT_NR_LOCAL] = {0};
+	int nr_local;
 	int ret;
 
+	nr_local = of_property_count_u32_elems(np, "samsung,local-timers");
+	if (nr_local == 0)
+		return -EINVAL;
+	if (nr_local > 0) {
+		if (nr_local > ARRAY_SIZE(local_idx))
+			return -EINVAL;
+
+		ret = of_property_read_u32_array(np, "samsung,local-timers",
+						 local_idx, nr_local);
+		if (ret)
+			return ret;
+	} else {
+		int i;
+
+		nr_local = ARRAY_SIZE(local_idx);
+		for (i = 0; i < nr_local; i++)
+			local_idx[i] = i;
+	}
+
 	ret = exynos4_timer_resources(np);
 	if (ret)
 		return ret;
 
-	ret = exynos4_timer_interrupts(np, int_type);
+	ret = exynos4_timer_interrupts(np, int_type, local_idx, nr_local);
 	if (ret)
 		return ret;
 
