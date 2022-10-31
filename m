Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A9F613C91
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiJaRv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231869AbiJaRvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:51:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573526395;
        Mon, 31 Oct 2022 10:51:09 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-157-181.ewe-ip-backbone.de [95.33.157.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 96F81660294A;
        Mon, 31 Oct 2022 17:51:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667238663;
        bh=mmOg3UNf/CnF3T7qAVz0/2Xn81sEvijvbTuLKyVGdyE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouibv5MO3HsYKkVySowPliR0orZS92TmWtTD8swqgXj5l8AhKWeZQ7Qwe0pWJ1mAk
         JnmB6dOTf6oQ1EiP4Wm5zMquYx3MV3YVI/Ipp4V301P5rwift6GtllrSEtGI6Iktgs
         IMV1z+/1l+g9RJzIzC1oH/sistcpmH36mOIH+PDk/FPtjMWzOrsr/1PdcPIKogu854
         tUXYa2Sd9CSEmO15DZ5eyqZ1g+ZOY77Haqw3MfU5eKeYdp5xWuEUaNz62Dv82A1T2q
         5MMZ/Wo4KDJfbLIVuXgXhRID8CC571591zNIK6Iu4AuTQeG7lyRozKasn91DFTvJRP
         FUm9DVtNMd/pg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 577A04801D3; Mon, 31 Oct 2022 18:50:59 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Finley Xiao <finley.xiao@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6/7] thermal: rockchip: Support RK3588 SoC in the thermal driver
Date:   Mon, 31 Oct 2022 18:50:57 +0100
Message-Id: <20221031175058.175698-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221031175058.175698-1-sebastian.reichel@collabora.com>
References: <20221031175058.175698-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finley Xiao <finley.xiao@rock-chips.com>

The RK3588 SoC has seven temperature sensor ADC channels:

- Chip Center
- CPU Cluster 1 (Dual A76 "Big" Cores)
- CPU Cluster 2 (Dual A76 "Big" Cores)
- CPU Cluster 0 (Quad A55 "Little" Cores)
- Power Domain Center
- Graphics Processing Unit
- Neural Processing Unit

Signed-off-by: Finley Xiao <finley.xiao@rock-chips.com>
[rebase, squash fixes]
Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 177 +++++++++++++++++++++++++++++
 1 file changed, 177 insertions(+)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index c9d04b58a1e5..48e40c3b3de6 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -165,29 +165,49 @@ struct rockchip_thermal_data {
 #define TSADCV2_AUTO_CON			0x04
 #define TSADCV2_INT_EN				0x08
 #define TSADCV2_INT_PD				0x0c
+#define TSADCV3_AUTO_SRC_CON			0x0c
+#define TSADCV3_HT_INT_EN			0x14
+#define TSADCV3_HSHUT_GPIO_INT_EN		0x18
+#define TSADCV3_HSHUT_CRU_INT_EN		0x1c
+#define TSADCV3_INT_PD				0x24
+#define TSADCV3_HSHUT_PD			0x28
 #define TSADCV2_DATA(chn)			(0x20 + (chn) * 0x04)
 #define TSADCV2_COMP_INT(chn)		        (0x30 + (chn) * 0x04)
 #define TSADCV2_COMP_SHUT(chn)		        (0x40 + (chn) * 0x04)
+#define TSADCV3_DATA(chn)			(0x2c + (chn) * 0x04)
+#define TSADCV3_COMP_INT(chn)		        (0x6c + (chn) * 0x04)
+#define TSADCV3_COMP_SHUT(chn)		        (0x10c + (chn) * 0x04)
 #define TSADCV2_HIGHT_INT_DEBOUNCE		0x60
 #define TSADCV2_HIGHT_TSHUT_DEBOUNCE		0x64
+#define TSADCV3_HIGHT_INT_DEBOUNCE		0x14c
+#define TSADCV3_HIGHT_TSHUT_DEBOUNCE		0x150
 #define TSADCV2_AUTO_PERIOD			0x68
 #define TSADCV2_AUTO_PERIOD_HT			0x6c
+#define TSADCV3_AUTO_PERIOD			0x154
+#define TSADCV3_AUTO_PERIOD_HT			0x158
 
 #define TSADCV2_AUTO_EN				BIT(0)
+#define TSADCV2_AUTO_EN_MASK			BIT(16)
 #define TSADCV2_AUTO_SRC_EN(chn)		BIT(4 + (chn))
+#define TSADCV3_AUTO_SRC_EN(chn)		BIT(chn)
+#define TSADCV3_AUTO_SRC_EN_MASK(chn)		BIT(16 + chn)
 #define TSADCV2_AUTO_TSHUT_POLARITY_HIGH	BIT(8)
+#define TSADCV2_AUTO_TSHUT_POLARITY_MASK	BIT(24)
 
 #define TSADCV3_AUTO_Q_SEL_EN			BIT(1)
 
 #define TSADCV2_INT_SRC_EN(chn)			BIT(chn)
+#define TSADCV2_INT_SRC_EN_MASK(chn)		BIT(16 + (chn))
 #define TSADCV2_SHUT_2GPIO_SRC_EN(chn)		BIT(4 + (chn))
 #define TSADCV2_SHUT_2CRU_SRC_EN(chn)		BIT(8 + (chn))
 
 #define TSADCV2_INT_PD_CLEAR_MASK		~BIT(8)
 #define TSADCV3_INT_PD_CLEAR_MASK		~BIT(16)
+#define TSADCV4_INT_PD_CLEAR_MASK		0xffffffff
 
 #define TSADCV2_DATA_MASK			0xfff
 #define TSADCV3_DATA_MASK			0x3ff
+#define TSADCV4_DATA_MASK			0x1ff
 
 #define TSADCV2_HIGHT_INT_DEBOUNCE_COUNT	4
 #define TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT	4
@@ -198,6 +218,8 @@ struct rockchip_thermal_data {
 
 #define TSADCV5_AUTO_PERIOD_TIME		1622 /* 2.5ms */
 #define TSADCV5_AUTO_PERIOD_HT_TIME		1622 /* 2.5ms */
+#define TSADCV6_AUTO_PERIOD_TIME		5000 /* 2.5ms */
+#define TSADCV6_AUTO_PERIOD_HT_TIME		5000 /* 2.5ms */
 
 #define TSADCV2_USER_INTER_PD_SOC		0x340 /* 13 clocks */
 #define TSADCV5_USER_INTER_PD_SOC		0xfc0 /* 97us, at least 90us */
@@ -214,6 +236,12 @@ struct rockchip_thermal_data {
 #define RK3568_GRF_TSADC_ANA_REG2		(0x10001 << 2)
 #define RK3568_GRF_TSADC_TSEN			(0x10001 << 8)
 
+#define RK3588_GRF0_TSADC_CON			0x0100
+
+#define RK3588_GRF0_TSADC_TRM			(0xff0077 << 0)
+#define RK3588_GRF0_TSADC_SHUT_2CRU		(0x30003 << 10)
+#define RK3588_GRF0_TSADC_SHUT_2GPIO		(0x70007 << 12)
+
 #define GRF_SARADC_TESTBIT_ON			(0x10001 << 2)
 #define GRF_TSADC_TESTBIT_H_ON			(0x10001 << 2)
 #define GRF_TSADC_VCM_EN_L			(0x10001 << 7)
@@ -508,6 +536,15 @@ static const struct tsadc_table rk3568_code_table[] = {
 	{TSADCV2_DATA_MASK, 125000},
 };
 
+static const struct tsadc_table rk3588_code_table[] = {
+	{0, -40000},
+	{215, -40000},
+	{285, 25000},
+	{350, 85000},
+	{395, 125000},
+	{TSADCV4_DATA_MASK, 125000},
+};
+
 static u32 rk_tsadcv2_temp_to_code(const struct chip_tsadc_table *table,
 				   int temp)
 {
@@ -778,6 +815,25 @@ static void rk_tsadcv7_initialize(struct regmap *grf, void __iomem *regs,
 	}
 }
 
+static void rk_tsadcv8_initialize(struct regmap *grf, void __iomem *regs,
+				  enum tshut_polarity tshut_polarity)
+{
+	writel_relaxed(TSADCV6_AUTO_PERIOD_TIME, regs + TSADCV3_AUTO_PERIOD);
+	writel_relaxed(TSADCV6_AUTO_PERIOD_HT_TIME,
+		       regs + TSADCV3_AUTO_PERIOD_HT);
+	writel_relaxed(TSADCV2_HIGHT_INT_DEBOUNCE_COUNT,
+		       regs + TSADCV3_HIGHT_INT_DEBOUNCE);
+	writel_relaxed(TSADCV2_HIGHT_TSHUT_DEBOUNCE_COUNT,
+		       regs + TSADCV3_HIGHT_TSHUT_DEBOUNCE);
+	if (tshut_polarity == TSHUT_HIGH_ACTIVE)
+		writel_relaxed(TSADCV2_AUTO_TSHUT_POLARITY_HIGH |
+			       TSADCV2_AUTO_TSHUT_POLARITY_MASK,
+			       regs + TSADCV2_AUTO_CON);
+	else
+		writel_relaxed(TSADCV2_AUTO_TSHUT_POLARITY_MASK,
+			       regs + TSADCV2_AUTO_CON);
+}
+
 static void rk_tsadcv2_irq_ack(void __iomem *regs)
 {
 	u32 val;
@@ -794,6 +850,17 @@ static void rk_tsadcv3_irq_ack(void __iomem *regs)
 	writel_relaxed(val & TSADCV3_INT_PD_CLEAR_MASK, regs + TSADCV2_INT_PD);
 }
 
+static void rk_tsadcv4_irq_ack(void __iomem *regs)
+{
+	u32 val;
+
+	val = readl_relaxed(regs + TSADCV3_INT_PD);
+	writel_relaxed(val & TSADCV4_INT_PD_CLEAR_MASK, regs + TSADCV3_INT_PD);
+	val = readl_relaxed(regs + TSADCV3_HSHUT_PD);
+	writel_relaxed(val & TSADCV3_INT_PD_CLEAR_MASK,
+		       regs + TSADCV3_HSHUT_PD);
+}
+
 static void rk_tsadcv2_control(void __iomem *regs, bool enable)
 {
 	u32 val;
@@ -829,6 +896,18 @@ static void rk_tsadcv3_control(void __iomem *regs, bool enable)
 	writel_relaxed(val, regs + TSADCV2_AUTO_CON);
 }
 
+static void rk_tsadcv4_control(void __iomem *regs, bool enable)
+{
+	u32 val;
+
+	if (enable)
+		val = TSADCV2_AUTO_EN | TSADCV2_AUTO_EN_MASK;
+	else
+		val = TSADCV2_AUTO_EN_MASK;
+
+	writel_relaxed(val, regs + TSADCV2_AUTO_CON);
+}
+
 static int rk_tsadcv2_get_temp(const struct chip_tsadc_table *table,
 			       int chn, void __iomem *regs, int *temp)
 {
@@ -839,6 +918,16 @@ static int rk_tsadcv2_get_temp(const struct chip_tsadc_table *table,
 	return rk_tsadcv2_code_to_temp(table, val, temp);
 }
 
+static int rk_tsadcv4_get_temp(const struct chip_tsadc_table *table,
+			       int chn, void __iomem *regs, int *temp)
+{
+	u32 val;
+
+	val = readl_relaxed(regs + TSADCV3_DATA(chn));
+
+	return rk_tsadcv2_code_to_temp(table, val, temp);
+}
+
 static int rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
 				 int chn, void __iomem *regs, int temp)
 {
@@ -873,6 +962,33 @@ static int rk_tsadcv2_alarm_temp(const struct chip_tsadc_table *table,
 	return 0;
 }
 
+static int rk_tsadcv3_alarm_temp(const struct chip_tsadc_table *table,
+				 int chn, void __iomem *regs, int temp)
+{
+	u32 alarm_value;
+
+	/*
+	 * In some cases, some sensors didn't need the trip points, the
+	 * set_trips will pass {-INT_MAX, INT_MAX} to trigger tsadc alarm
+	 * in the end, ignore this case and disable the high temperature
+	 * interrupt.
+	 */
+	if (temp == INT_MAX) {
+		writel_relaxed(TSADCV2_INT_SRC_EN_MASK(chn),
+			       regs + TSADCV3_HT_INT_EN);
+		return 0;
+	}
+	/* Make sure the value is valid */
+	alarm_value = rk_tsadcv2_temp_to_code(table, temp);
+	if (alarm_value == table->data_mask)
+		return -ERANGE;
+	writel_relaxed(alarm_value & table->data_mask,
+		       regs + TSADCV3_COMP_INT(chn));
+	writel_relaxed(TSADCV2_INT_SRC_EN(chn) | TSADCV2_INT_SRC_EN_MASK(chn),
+		       regs + TSADCV3_HT_INT_EN);
+	return 0;
+}
+
 static int rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
 				 int chn, void __iomem *regs, int temp)
 {
@@ -892,6 +1008,25 @@ static int rk_tsadcv2_tshut_temp(const struct chip_tsadc_table *table,
 	return 0;
 }
 
+static int rk_tsadcv3_tshut_temp(const struct chip_tsadc_table *table,
+				 int chn, void __iomem *regs, int temp)
+{
+	u32 tshut_value;
+
+	/* Make sure the value is valid */
+	tshut_value = rk_tsadcv2_temp_to_code(table, temp);
+	if (tshut_value == table->data_mask)
+		return -ERANGE;
+
+	writel_relaxed(tshut_value, regs + TSADCV3_COMP_SHUT(chn));
+
+	/* TSHUT will be valid */
+	writel_relaxed(TSADCV3_AUTO_SRC_EN(chn) | TSADCV3_AUTO_SRC_EN_MASK(chn),
+		       regs + TSADCV3_AUTO_SRC_CON);
+
+	return 0;
+}
+
 static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 				  enum tshut_mode mode)
 {
@@ -909,6 +1044,22 @@ static void rk_tsadcv2_tshut_mode(int chn, void __iomem *regs,
 	writel_relaxed(val, regs + TSADCV2_INT_EN);
 }
 
+static void rk_tsadcv3_tshut_mode(int chn, void __iomem *regs,
+				  enum tshut_mode mode)
+{
+	u32 val_gpio, val_cru;
+
+	if (mode == TSHUT_MODE_GPIO) {
+		val_gpio = TSADCV2_INT_SRC_EN(chn) | TSADCV2_INT_SRC_EN_MASK(chn);
+		val_cru = TSADCV2_INT_SRC_EN_MASK(chn);
+	} else {
+		val_cru = TSADCV2_INT_SRC_EN(chn) | TSADCV2_INT_SRC_EN_MASK(chn);
+		val_gpio = TSADCV2_INT_SRC_EN_MASK(chn);
+	}
+	writel_relaxed(val_gpio, regs + TSADCV3_HSHUT_GPIO_INT_EN);
+	writel_relaxed(val_cru, regs + TSADCV3_HSHUT_CRU_INT_EN);
+}
+
 static const struct rockchip_tsadc_chip px30_tsadc_data = {
 	/* cpu, gpu */
 	.chn_offset = 0,
@@ -1132,6 +1283,28 @@ static const struct rockchip_tsadc_chip rk3568_tsadc_data = {
 	},
 };
 
+static const struct rockchip_tsadc_chip rk3588_tsadc_data = {
+	/* top, big_core0, big_core1, little_core, center, gpu, npu */
+	.chn_offset = 0,
+	.chn_num = 7, /* seven channels for tsadc */
+	.tshut_mode = TSHUT_MODE_GPIO, /* default TSHUT via GPIO give PMIC */
+	.tshut_polarity = TSHUT_LOW_ACTIVE, /* default TSHUT LOW ACTIVE */
+	.tshut_temp = 95000,
+	.initialize = rk_tsadcv8_initialize,
+	.irq_ack = rk_tsadcv4_irq_ack,
+	.control = rk_tsadcv4_control,
+	.get_temp = rk_tsadcv4_get_temp,
+	.set_alarm_temp = rk_tsadcv3_alarm_temp,
+	.set_tshut_temp = rk_tsadcv3_tshut_temp,
+	.set_tshut_mode = rk_tsadcv3_tshut_mode,
+	.table = {
+		.id = rk3588_code_table,
+		.length = ARRAY_SIZE(rk3588_code_table),
+		.data_mask = TSADCV4_DATA_MASK,
+		.mode = ADC_INCREMENT,
+	},
+};
+
 static const struct of_device_id of_rockchip_thermal_match[] = {
 	{	.compatible = "rockchip,px30-tsadc",
 		.data = (void *)&px30_tsadc_data,
@@ -1168,6 +1341,10 @@ static const struct of_device_id of_rockchip_thermal_match[] = {
 		.compatible = "rockchip,rk3568-tsadc",
 		.data = (void *)&rk3568_tsadc_data,
 	},
+	{
+		.compatible = "rockchip,rk3588-tsadc",
+		.data = (void *)&rk3588_tsadc_data,
+	},
 	{ /* end */ },
 };
 MODULE_DEVICE_TABLE(of, of_rockchip_thermal_match);
-- 
2.35.1

