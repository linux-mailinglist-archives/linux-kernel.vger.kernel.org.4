Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6F70F10B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbjEXIeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240242AbjEXIc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:32:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4B0198
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:32:37 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juZ-0002lJ-C6; Wed, 24 May 2023 10:31:59 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juY-002RZr-G1; Wed, 24 May 2023 10:31:58 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juW-009j8K-GM; Wed, 24 May 2023 10:31:56 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-rockchip@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, kernel@pengutronix.de,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Legoll <vincent.legoll@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v5 09/25] PM / devfreq: rockchip-dfi: Clean up DDR type register defines
Date:   Wed, 24 May 2023 10:31:37 +0200
Message-Id: <20230524083153.2046084-10-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230524083153.2046084-1-s.hauer@pengutronix.de>
References: <20230524083153.2046084-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the HIWORD_UPDATE() define known from other rockchip drivers to
make the defines look less odd to the readers who've seen other
rockchip drivers.

The HIWORD registers have their functional bits in the lower 16 bits
whereas the upper 16 bits contain a mask. Only the functional bits that
have the corresponding mask bit set are modified during a write. Although
the register writes look different, the end result should be the same,
at least there's no functional change intended with this patch.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c | 33 ++++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 6bccb6fbcfc0c..6b3ef97b3be09 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -26,15 +26,19 @@
 
 #define DMC_MAX_CHANNELS	2
 
+#define HIWORD_UPDATE(val, mask)	((val) | (mask) << 16)
+
 /* DDRMON_CTRL */
 #define DDRMON_CTRL	0x04
-#define CLR_DDRMON_CTRL	(0x1f0000 << 0)
-#define LPDDR4_EN	(0x10001 << 4)
-#define HARDWARE_EN	(0x10001 << 3)
-#define LPDDR3_EN	(0x10001 << 2)
-#define SOFTWARE_EN	(0x10001 << 1)
-#define SOFTWARE_DIS	(0x10000 << 1)
-#define TIME_CNT_EN	(0x10001 << 0)
+#define DDRMON_CTRL_DDR4		BIT(5)
+#define DDRMON_CTRL_LPDDR4		BIT(4)
+#define DDRMON_CTRL_HARDWARE_EN		BIT(3)
+#define DDRMON_CTRL_LPDDR23		BIT(2)
+#define DDRMON_CTRL_SOFTWARE_EN		BIT(1)
+#define DDRMON_CTRL_TIMER_CNT_EN	BIT(0)
+#define DDRMON_CTRL_DDR_TYPE_MASK	(DDRMON_CTRL_DDR4 | \
+					 DDRMON_CTRL_LPDDR4 | \
+					 DDRMON_CTRL_LPDDR23)
 
 #define DDRMON_CH0_COUNT_NUM		0x28
 #define DDRMON_CH0_DFI_ACCESS_NUM	0x2c
@@ -73,16 +77,20 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 	void __iomem *dfi_regs = dfi->regs;
 
 	/* clear DDRMON_CTRL setting */
-	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
+	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN | DDRMON_CTRL_SOFTWARE_EN |
+		       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
 
 	/* set ddr type to dfi */
 	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR3)
-		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
+		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE_MASK),
+			       dfi_regs + DDRMON_CTRL);
 	else if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR4)
-		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
+		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4, DDRMON_CTRL_DDR_TYPE_MASK),
+			       dfi_regs + DDRMON_CTRL);
 
 	/* enable count, use software mode */
-	writel_relaxed(SOFTWARE_EN, dfi_regs + DDRMON_CTRL);
+	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTWARE_EN),
+		       dfi_regs + DDRMON_CTRL);
 }
 
 static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev *edev)
@@ -90,7 +98,8 @@ static void rockchip_dfi_stop_hardware_counter(struct devfreq_event_dev *edev)
 	struct rockchip_dfi *dfi = devfreq_event_get_drvdata(edev);
 	void __iomem *dfi_regs = dfi->regs;
 
-	writel_relaxed(SOFTWARE_DIS, dfi_regs + DDRMON_CTRL);
+	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
+		       dfi_regs + DDRMON_CTRL);
 }
 
 static void rockchip_dfi_read_counters(struct devfreq_event_dev *edev, struct dmc_count *count)
-- 
2.39.2

