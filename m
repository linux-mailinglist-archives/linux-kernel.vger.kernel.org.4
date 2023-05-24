Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5190E70F10E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 10:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240423AbjEXIeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 04:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbjEXIdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 04:33:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91576E54
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 01:32:45 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1q1jua-0002nD-Jx; Wed, 24 May 2023 10:32:00 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juZ-002RaE-JW; Wed, 24 May 2023 10:31:59 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1q1juX-009jJ8-CX; Wed, 24 May 2023 10:31:57 +0200
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
        Sascha Hauer <s.hauer@pengutronix.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v5 18/25] PM / devfreq: rockchip-dfi: account for multiple DDRMON_CTRL registers
Date:   Wed, 24 May 2023 10:31:46 +0200
Message-Id: <20230524083153.2046084-19-s.hauer@pengutronix.de>
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

The currently supported RK3399 has a set of registers per channel, but
it has only a single DDRMON_CTRL register. With upcoming RK3588 this
will be different, the RK3588 has a DDRMON_CTRL register per channel.

Instead of expecting a single DDRMON_CTRL register, loop over the
channels and write the channel specific DDRMON_CTRL register. Break
out early out of the loop when there is only a single DDRMON_CTRL
register like on the RK3399.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 72 ++++++++++++++++++----------
 1 file changed, 48 insertions(+), 24 deletions(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index a872550a7caf5..23d66fe737975 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -113,12 +113,13 @@ struct rockchip_dfi {
 	int burst_len;
 	int buswidth[DMC_MAX_CHANNELS];
 	int ddrmon_stride;
+	bool ddrmon_ctrl_single;
 };
 
 static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 {
 	void __iomem *dfi_regs = dfi->regs;
-	int ret = 0;
+	int i, ret = 0;
 
 	mutex_lock(&dfi->mutex);
 
@@ -132,29 +133,41 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 		goto out;
 	}
 
-	/* clear DDRMON_CTRL setting */
-	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN | DDRMON_CTRL_SOFTWARE_EN |
-		       DDRMON_CTRL_HARDWARE_EN), dfi_regs + DDRMON_CTRL);
+	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
+		u32 ctrl = 0;
 
-	/* set ddr type to dfi */
-	switch (dfi->ddr_type) {
-	case ROCKCHIP_DDRTYPE_LPDDR2:
-	case ROCKCHIP_DDRTYPE_LPDDR3:
-		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR23, DDRMON_CTRL_DDR_TYPE_MASK),
-			       dfi_regs + DDRMON_CTRL);
-		break;
-	case ROCKCHIP_DDRTYPE_LPDDR4:
-	case ROCKCHIP_DDRTYPE_LPDDR4X:
-		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_LPDDR4, DDRMON_CTRL_DDR_TYPE_MASK),
-			       dfi_regs + DDRMON_CTRL);
-		break;
-	default:
-		break;
-	}
+		if (!(dfi->channel_mask & BIT(i)))
+			continue;
 
-	/* enable count, use software mode */
-	writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTWARE_EN),
-		       dfi_regs + DDRMON_CTRL);
+		/* clear DDRMON_CTRL setting */
+		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_TIMER_CNT_EN |
+			       DDRMON_CTRL_SOFTWARE_EN | DDRMON_CTRL_HARDWARE_EN),
+			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+
+		/* set ddr type to dfi */
+		switch (dfi->ddr_type) {
+		case ROCKCHIP_DDRTYPE_LPDDR2:
+		case ROCKCHIP_DDRTYPE_LPDDR3:
+			ctrl = DDRMON_CTRL_LPDDR23;
+			break;
+		case ROCKCHIP_DDRTYPE_LPDDR4:
+		case ROCKCHIP_DDRTYPE_LPDDR4X:
+			ctrl = DDRMON_CTRL_LPDDR4;
+			break;
+		default:
+			break;
+		}
+
+		writel_relaxed(HIWORD_UPDATE(ctrl, DDRMON_CTRL_DDR_TYPE_MASK),
+			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+
+		/* enable count, use software mode */
+		writel_relaxed(HIWORD_UPDATE(DDRMON_CTRL_SOFTWARE_EN, DDRMON_CTRL_SOFTWARE_EN),
+			       dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+
+		if (dfi->ddrmon_ctrl_single)
+			break;
+	}
 out:
 	mutex_unlock(&dfi->mutex);
 
@@ -164,6 +177,7 @@ static int rockchip_dfi_enable(struct rockchip_dfi *dfi)
 static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 {
 	void __iomem *dfi_regs = dfi->regs;
+	int i;
 
 	mutex_lock(&dfi->mutex);
 
@@ -174,8 +188,17 @@ static void rockchip_dfi_disable(struct rockchip_dfi *dfi)
 	if (dfi->usecount > 0)
 		goto out;
 
-	writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
-		       dfi_regs + DDRMON_CTRL);
+	for (i = 0; i < DMC_MAX_CHANNELS; i++) {
+		if (!(dfi->channel_mask & BIT(i)))
+			continue;
+
+		writel_relaxed(HIWORD_UPDATE(0, DDRMON_CTRL_SOFTWARE_EN),
+			      dfi_regs + i * dfi->ddrmon_stride + DDRMON_CTRL);
+
+		if (dfi->ddrmon_ctrl_single)
+			break;
+	}
+
 	clk_disable_unprepare(dfi->clk);
 out:
 	mutex_unlock(&dfi->mutex);
@@ -663,6 +686,7 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 	dfi->buswidth[1] = FIELD_GET(RK3399_PMUGRF_OS_REG2_BW_CH1, val) == 0 ? 4 : 2;
 
 	dfi->ddrmon_stride = 0x14;
+	dfi->ddrmon_ctrl_single = true;
 
 	return 0;
 };
-- 
2.39.2

