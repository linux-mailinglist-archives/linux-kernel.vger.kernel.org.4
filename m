Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98C7F6CBA4F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjC1JQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:16:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbjC1JP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:15:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A3A6A66
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:15:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph5QG-0005Lq-3H; Tue, 28 Mar 2023 11:15:20 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph5QF-007H1d-1o; Tue, 28 Mar 2023 11:15:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ph5QE-008e9J-DZ; Tue, 28 Mar 2023 11:15:18 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource/drivers/imx-gpt: Use only a single name for functions
Date:   Tue, 28 Mar 2023 11:15:14 +0200
Message-Id: <20230328091514.874724-1-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3594; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=53amSp2Eq/JD11qdBCGvjY/Mn1hzyuYI/XNzDi9Z0yg=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBkIrAhcgU45Zra3QxQ0TUTqP/MKJmF1S/LTUVS1 YoqCmSbJVOJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZCKwIQAKCRCPgPtYfRL+ TkelCACO9Smf4Ab1b27Km6cPgYDZ2MRP3RjpUYgicueE/rQ0zzExeJJu0I41bqwvf4fYNiheRII j3t4aFlYeYh/r4bTHZSj7Yl2Nveqs/CrleEF7SxrKN2MpWKtA6cmFrtkKXu+7OSih7M5J6r/FF7 2cMQXz89nEBTl9NNYM3uR97BzQIBf8vEj7p/E06DTCZnvVbP/6/zl9M73Y+WAgynH3qA2zHW7eI r/Q889eTr6ChDnigG12tWDkxue83NTRowLh4FVel+TQeJNLKUpG9n7NaWDIkRu5FPvG9JoIGNu0 W2HbTfMhOmTgs5UpsVJ5zdlANtuDB7TqyMNMP8GSJQPzC3BP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When looking at the data structs defining the different behaviours of
the GPT blocks in different SoCs it's not helpful that the same
functions are used with different names.

So drop the cpp defines and use the original names.

This commit was generated using:

	perl -i -e 'my %m; while (<>) { if (/^#define (imx[a-zA-Z0-6_]*)\s(imx[a-zA-Z0-6_]*)/) {$m{$1} = $2; } else { foreach my $f (keys %m) {s/$f/$m{$f}/; } print; } }' drivers/clocksource/timer-imx-gpt.c

This patch has no effect on the generated code.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/clocksource/timer-imx-gpt.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/clocksource/timer-imx-gpt.c b/drivers/clocksource/timer-imx-gpt.c
index 7b2c70f2f353..8ad0bda42029 100644
--- a/drivers/clocksource/timer-imx-gpt.c
+++ b/drivers/clocksource/timer-imx-gpt.c
@@ -93,13 +93,11 @@ static void imx1_gpt_irq_disable(struct imx_timer *imxtm)
 	tmp = readl_relaxed(imxtm->base + MXC_TCTL);
 	writel_relaxed(tmp & ~MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_irq_disable imx1_gpt_irq_disable
 
 static void imx31_gpt_irq_disable(struct imx_timer *imxtm)
 {
 	writel_relaxed(0, imxtm->base + V2_IR);
 }
-#define imx6dl_gpt_irq_disable imx31_gpt_irq_disable
 
 static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
 {
@@ -108,13 +106,11 @@ static void imx1_gpt_irq_enable(struct imx_timer *imxtm)
 	tmp = readl_relaxed(imxtm->base + MXC_TCTL);
 	writel_relaxed(tmp | MX1_2_TCTL_IRQEN, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_irq_enable imx1_gpt_irq_enable
 
 static void imx31_gpt_irq_enable(struct imx_timer *imxtm)
 {
 	writel_relaxed(1<<0, imxtm->base + V2_IR);
 }
-#define imx6dl_gpt_irq_enable imx31_gpt_irq_enable
 
 static void imx1_gpt_irq_acknowledge(struct imx_timer *imxtm)
 {
@@ -131,7 +127,6 @@ static void imx31_gpt_irq_acknowledge(struct imx_timer *imxtm)
 {
 	writel_relaxed(V2_TSTAT_OF1, imxtm->base + V2_TSTAT);
 }
-#define imx6dl_gpt_irq_acknowledge imx31_gpt_irq_acknowledge
 
 static void __iomem *sched_clock_reg;
 
@@ -296,7 +291,6 @@ static void imx1_gpt_setup_tctl(struct imx_timer *imxtm)
 	tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
 	writel_relaxed(tctl_val, imxtm->base + MXC_TCTL);
 }
-#define imx21_gpt_setup_tctl imx1_gpt_setup_tctl
 
 static void imx31_gpt_setup_tctl(struct imx_timer *imxtm)
 {
@@ -343,10 +337,10 @@ static const struct imx_gpt_data imx21_gpt_data = {
 	.reg_tstat = MX1_2_TSTAT,
 	.reg_tcn = MX1_2_TCN,
 	.reg_tcmp = MX1_2_TCMP,
-	.gpt_irq_enable = imx21_gpt_irq_enable,
-	.gpt_irq_disable = imx21_gpt_irq_disable,
+	.gpt_irq_enable = imx1_gpt_irq_enable,
+	.gpt_irq_disable = imx1_gpt_irq_disable,
 	.gpt_irq_acknowledge = imx21_gpt_irq_acknowledge,
-	.gpt_setup_tctl = imx21_gpt_setup_tctl,
+	.gpt_setup_tctl = imx1_gpt_setup_tctl,
 	.set_next_event = mx1_2_set_next_event,
 };
 
@@ -365,9 +359,9 @@ static const struct imx_gpt_data imx6dl_gpt_data = {
 	.reg_tstat = V2_TSTAT,
 	.reg_tcn = V2_TCN,
 	.reg_tcmp = V2_TCMP,
-	.gpt_irq_enable = imx6dl_gpt_irq_enable,
-	.gpt_irq_disable = imx6dl_gpt_irq_disable,
-	.gpt_irq_acknowledge = imx6dl_gpt_irq_acknowledge,
+	.gpt_irq_enable = imx31_gpt_irq_enable,
+	.gpt_irq_disable = imx31_gpt_irq_disable,
+	.gpt_irq_acknowledge = imx31_gpt_irq_acknowledge,
 	.gpt_setup_tctl = imx6dl_gpt_setup_tctl,
 	.set_next_event = v2_set_next_event,
 };

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

