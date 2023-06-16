Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D73732775
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 08:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjFPGXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 02:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240269AbjFPGWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 02:22:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB3622710
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 23:22:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2qA-0006ss-4I; Fri, 16 Jun 2023 08:21:46 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2q9-007kyk-Ab; Fri, 16 Jun 2023 08:21:45 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <sha@pengutronix.de>)
        id 1qA2q4-003FUW-O9; Fri, 16 Jun 2023 08:21:40 +0200
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
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH v6 08/26] PM / devfreq: rk3399_dmc,dfi: generalize DDRTYPE defines
Date:   Fri, 16 Jun 2023 08:20:43 +0200
Message-Id: <20230616062101.601837-9-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616062101.601837-1-s.hauer@pengutronix.de>
References: <20230616062101.601837-1-s.hauer@pengutronix.de>
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

The DDRTYPE defines are named to be RK3399 specific, but they can be
used for other Rockchip SoCs as well, so replace the RK3399_PMUGRF_
prefix with ROCKCHIP_. They are defined in a SoC specific header
file, so when generalizing the prefix also move the new defines to
a SoC agnostic header file. While at it use GENMASK to define the
DDRTYPE bitfield and give it a name including the full register name.

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Link: https://lore.kernel.org/r/20230524083153.2046084-9-s.hauer@pengutronix.de
Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/devfreq/event/rockchip-dfi.c |  9 +++++----
 drivers/devfreq/rk3399_dmc.c         | 10 +++++-----
 include/soc/rockchip/rk3399_grf.h    |  7 +------
 include/soc/rockchip/rockchip_grf.h  | 17 +++++++++++++++++
 4 files changed, 28 insertions(+), 15 deletions(-)
 create mode 100644 include/soc/rockchip/rockchip_grf.h

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 82de24a027579..6bccb6fbcfc0c 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -18,8 +18,10 @@
 #include <linux/list.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 
+#include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
 
 #define DMC_MAX_CHANNELS	2
@@ -74,9 +76,9 @@ static void rockchip_dfi_start_hardware_counter(struct devfreq_event_dev *edev)
 	writel_relaxed(CLR_DDRMON_CTRL, dfi_regs + DDRMON_CTRL);
 
 	/* set ddr type to dfi */
-	if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR3)
+	if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR3)
 		writel_relaxed(LPDDR3_EN, dfi_regs + DDRMON_CTRL);
-	else if (dfi->ddr_type == RK3399_PMUGRF_DDRTYPE_LPDDR4)
+	else if (dfi->ddr_type == ROCKCHIP_DDRTYPE_LPDDR4)
 		writel_relaxed(LPDDR4_EN, dfi_regs + DDRMON_CTRL);
 
 	/* enable count, use software mode */
@@ -191,8 +193,7 @@ static int rk3399_dfi_init(struct rockchip_dfi *dfi)
 
 	/* get ddr type */
 	regmap_read(regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
-	dfi->ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
-			RK3399_PMUGRF_DDRTYPE_MASK;
+	dfi->ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
 
 	dfi->channel_mask = GENMASK(1, 0);
 
diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index daff407026157..fd2c5ffedf41e 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -22,6 +22,7 @@
 #include <linux/suspend.h>
 
 #include <soc/rockchip/pm_domains.h>
+#include <soc/rockchip/rockchip_grf.h>
 #include <soc/rockchip/rk3399_grf.h>
 #include <soc/rockchip/rockchip_sip.h>
 
@@ -381,17 +382,16 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 	}
 
 	regmap_read(data->regmap_pmu, RK3399_PMUGRF_OS_REG2, &val);
-	ddr_type = (val >> RK3399_PMUGRF_DDRTYPE_SHIFT) &
-		    RK3399_PMUGRF_DDRTYPE_MASK;
+	ddr_type = FIELD_GET(RK3399_PMUGRF_OS_REG2_DDRTYPE, val);
 
 	switch (ddr_type) {
-	case RK3399_PMUGRF_DDRTYPE_DDR3:
+	case ROCKCHIP_DDRTYPE_DDR3:
 		data->odt_dis_freq = data->ddr3_odt_dis_freq;
 		break;
-	case RK3399_PMUGRF_DDRTYPE_LPDDR3:
+	case ROCKCHIP_DDRTYPE_LPDDR3:
 		data->odt_dis_freq = data->lpddr3_odt_dis_freq;
 		break;
-	case RK3399_PMUGRF_DDRTYPE_LPDDR4:
+	case ROCKCHIP_DDRTYPE_LPDDR4:
 		data->odt_dis_freq = data->lpddr4_odt_dis_freq;
 		break;
 	default:
diff --git a/include/soc/rockchip/rk3399_grf.h b/include/soc/rockchip/rk3399_grf.h
index 3eebabcb28123..775f8444bea8d 100644
--- a/include/soc/rockchip/rk3399_grf.h
+++ b/include/soc/rockchip/rk3399_grf.h
@@ -11,11 +11,6 @@
 
 /* PMU GRF Registers */
 #define RK3399_PMUGRF_OS_REG2		0x308
-#define RK3399_PMUGRF_DDRTYPE_SHIFT	13
-#define RK3399_PMUGRF_DDRTYPE_MASK	7
-#define RK3399_PMUGRF_DDRTYPE_DDR3	3
-#define RK3399_PMUGRF_DDRTYPE_LPDDR2	5
-#define RK3399_PMUGRF_DDRTYPE_LPDDR3	6
-#define RK3399_PMUGRF_DDRTYPE_LPDDR4	7
+#define RK3399_PMUGRF_OS_REG2_DDRTYPE		GENMASK(15, 13)
 
 #endif
diff --git a/include/soc/rockchip/rockchip_grf.h b/include/soc/rockchip/rockchip_grf.h
new file mode 100644
index 0000000000000..dde1a9796ccb5
--- /dev/null
+++ b/include/soc/rockchip/rockchip_grf.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Rockchip General Register Files definitions
+ */
+
+#ifndef __SOC_ROCKCHIP_GRF_H
+#define __SOC_ROCKCHIP_GRF_H
+
+/* Rockchip DDRTYPE defines */
+enum {
+	ROCKCHIP_DDRTYPE_DDR3	= 3,
+	ROCKCHIP_DDRTYPE_LPDDR2	= 5,
+	ROCKCHIP_DDRTYPE_LPDDR3	= 6,
+	ROCKCHIP_DDRTYPE_LPDDR4	= 7,
+};
+
+#endif /* __SOC_ROCKCHIP_GRF_H */
-- 
2.39.2

