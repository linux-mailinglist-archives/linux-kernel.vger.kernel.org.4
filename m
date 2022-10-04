Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6D45F3FAB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiJDJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiJDJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D9211C19;
        Tue,  4 Oct 2022 02:27:25 -0700 (PDT)
Date:   Tue, 04 Oct 2022 09:27:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664875644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKuPUeFuYMZzPKZVe0xo1qowjMQpHKeXejjhSBXjyBg=;
        b=JeGJDoxWUimiLeNkGTTDbwdA4uWEgrFx5qil5t5MZp7wM1Tr+GWQYHI4CNLz5pRMnQElSC
        YET06+EyeoSxCHiKI6mYgtU7fwU7ChZkztvHBbJNG7Vm9o5A3wqU3Rrt47se2J2z2LSOfy
        E5CVmSLiKH5g+sqdmWowFylM8/hyJS2VKXAt5PX7qEMSieB8txbMBT08jDU4KNA66ciqn4
        LevuE7vCIOy0zc/fyQ1b8hrR5brJ70Snbec2LgrEY2Xz3xZAq8DIIiQSqAT26Wi2Ee/zig
        z2SmRrdmoQGvLL08wstMjNq8NYcu+YfOpMQxoxBP4V49dGQPg8cU5dz2g2EKyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664875644;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LKuPUeFuYMZzPKZVe0xo1qowjMQpHKeXejjhSBXjyBg=;
        b=k7MJT62bD8AsNRm6pEUJjQE/4nyfyCumbtTON8oAp0cS/R3WXopSnsbLq/ei0clnEQYHT9
        xta4rzTvu01p3+Dw==
From:   "tip-bot2 for Vincent Whitchurch" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/exynos_mct: Support frc-shared
 property
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220609112738.359385-3-vincent.whitchurch@axis.com>
References: <20220609112738.359385-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Message-ID: <166487564281.401.7789863630231982917.tip-bot2@tip-bot2>
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

Commit-ID:     e8550f0e7bde9bd31697e3c534d386f7f3b5787b
Gitweb:        https://git.kernel.org/tip/e8550f0e7bde9bd31697e3c534d386f7f3b5787b
Author:        Vincent Whitchurch <vincent.whitchurch@axis.com>
AuthorDate:    Thu, 09 Jun 2022 13:27:36 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 20 Sep 2022 10:49:45 +02:00

clocksource/drivers/exynos_mct: Support frc-shared property

When the FRC is shared with another main processor, the other processor
is assumed to have started it and this processor should not write to the
global registers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Link: https://lore.kernel.org/r/20220609112738.359385-3-vincent.whitchurch@axis.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/exynos_mct.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index f29c812..1202383 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -233,9 +233,16 @@ static cycles_t exynos4_read_current_timer(void)
 }
 #endif
 
-static int __init exynos4_clocksource_init(void)
+static int __init exynos4_clocksource_init(bool frc_shared)
 {
-	exynos4_mct_frc_start();
+	/*
+	 * When the frc is shared, the main processer should have already
+	 * turned it on and we shouldn't be writing to TCON.
+	 */
+	if (frc_shared)
+		mct_frc.resume = NULL;
+	else
+		exynos4_mct_frc_start();
 
 #if defined(CONFIG_ARM)
 	exynos4_delay_timer.read_current_timer = &exynos4_read_current_timer;
@@ -605,6 +612,7 @@ out_irq:
 
 static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 {
+	bool frc_shared = of_property_read_bool(np, "samsung,frc-shared");
 	int ret;
 
 	ret = exynos4_timer_resources(np);
@@ -615,10 +623,17 @@ static int __init mct_init_dt(struct device_node *np, unsigned int int_type)
 	if (ret)
 		return ret;
 
-	ret = exynos4_clocksource_init();
+	ret = exynos4_clocksource_init(frc_shared);
 	if (ret)
 		return ret;
 
+	/*
+	 * When the FRC is shared with a main processor, this secondary
+	 * processor cannot use the global comparator.
+	 */
+	if (frc_shared)
+		return ret;
+
 	return exynos4_clockevent_init();
 }
 
