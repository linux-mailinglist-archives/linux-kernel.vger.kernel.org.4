Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E7A739763
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 08:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbjFVGXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 02:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjFVGX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 02:23:27 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3298A19BF;
        Wed, 21 Jun 2023 23:23:18 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35M6JKSg004026;
        Thu, 22 Jun 2023 06:22:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=qcppdkim1;
 bh=OkghX4PaWLr8oY6wbqwH9fm7aS+dFM1JGv4PB64p+ys=;
 b=Tac2AhwYr50zqyEsd6KqeVuEoPJWVIWqstiUiG+Mq3jjYg2K1E1sOQqJS0YMf7rel/A5
 yMdUdpEV/QZBVnBtT3f899PqMTTW++kzAbCwY57Z+hc4VyuDAP1PQQco71nFTVagHt71
 r6bezsC/WAA6zUavVLjbALYBOiXIyddCpDt+Wex9hUeSM6/S2yAIOqn9i48nB7gRV4fV
 nQNuLxHBHdmWXcLYEATp65sTQY0YweLx6lzbSqqX/XNP9zK7zLf9geXqvEFRrCl1S3hJ
 jOUBTCl+ci6QRYLSnQHvDZ5bigjzFYGx8u5R++BkSy1BkNS1WidSfmQMKVgK1ajt1SL0 Dg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rbqjbb3b7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 06:22:53 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35M6MqBa016714
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 06:22:52 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Wed, 21 Jun 2023 23:22:45 -0700
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <vkoul@kernel.org>,
        <kishon@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <p.zabel@pengutronix.de>, <arnd@arndb.de>,
        <geert+renesas@glider.be>, <neil.armstrong@linaro.org>,
        <nfraprado@collabora.com>, <broonie@kernel.org>,
        <rafal@milecki.pl>, <quic_srichara@quicinc.com>,
        <quic_varada@quicinc.org>, <quic_wcheng@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC:     Varadarajan Narayanan <quic_varada@quicinc.com>
Subject: [PATCH v2 3/6] phy: qcom-m31: Introduce qcom,m31 USB phy driver
Date:   Thu, 22 Jun 2023 11:52:10 +0530
Message-ID: <51c2d17bc73d1b5ddd62f4022966ff48a511d6ab.1687414716.git.quic_varada@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1687414716.git.quic_varada@quicinc.com>
References: <cover.1687414716.git.quic_varada@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -JD1OmDMBkthTLCdM_XWtD4WlEjogXYr
X-Proofpoint-GUID: -JD1OmDMBkthTLCdM_XWtD4WlEjogXYr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306220052
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the M31 USB2 phy driver.

Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
---
v1:
	Combine driver, makefile and kconfig into 1 patch
	Remove 'qscratch' region and its usage. The controller driver takes care
	of those settings
	Use compatible/data to handle ipq5332 init
	Drop the default case
	Get resources by index instead of name as there is only one resource
	Add clock
	Fix other review comments in the driver
---
 drivers/phy/qualcomm/Kconfig        |  11 ++
 drivers/phy/qualcomm/Makefile       |   1 +
 drivers/phy/qualcomm/phy-qcom-m31.c | 256 ++++++++++++++++++++++++++++++++++++
 3 files changed, 268 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-m31.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 67a45d9..8a363dd 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -188,3 +188,14 @@ config PHY_QCOM_IPQ806X_USB
 	  This option enables support for the Synopsis PHYs present inside the
 	  Qualcomm USB3.0 DWC3 controller on ipq806x SoC. This driver supports
 	  both HS and SS PHY controllers.
+
+config PHY_QCOM_M31_USB
+	tristate "Qualcomm M31 HS PHY driver support"
+	depends on (USB || USB_GADGET) && ARCH_QCOM
+	select USB_PHY
+	help
+	  Enable this to support M31 HS PHY transceivers on Qualcomm chips
+	  with DWC3 USB core. It handles PHY initialization, clock
+	  management required after resetting the hardware and power
+	  management. This driver is required even for peripheral only or
+	  host only mode configurations.
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index de3dc9c..79a6e75 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
 obj-$(CONFIG_PHY_QCOM_USB_SS)		+= phy-qcom-usb-ss.o
 obj-$(CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2)+= phy-qcom-snps-femto-v2.o
 obj-$(CONFIG_PHY_QCOM_IPQ806X_USB)		+= phy-qcom-ipq806x-usb.o
+obj-$(CONFIG_PHY_QCOM_M31_USB)		+= phy-qcom-m31.o
diff --git a/drivers/phy/qualcomm/phy-qcom-m31.c b/drivers/phy/qualcomm/phy-qcom-m31.c
new file mode 100644
index 0000000..8700728
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-m31.c
@@ -0,0 +1,256 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2014-2016, 2020, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+#include <linux/usb/of.h>
+#include <linux/usb/phy.h>
+
+enum clk_reset_action {
+	CLK_RESET_DEASSERT	= 0,
+	CLK_RESET_ASSERT	= 1
+};
+
+
+#define USB2PHY_PORT_UTMI_CTRL1		0x40
+
+#define USB2PHY_PORT_UTMI_CTRL2		0x44
+ #define UTMI_ULPI_SEL			BIT(7)
+ #define UTMI_TEST_MUX_SEL		BIT(6)
+
+#define HS_PHY_CTRL_REG			0x10
+ #define UTMI_OTG_VBUS_VALID		BIT(20)
+ #define SW_SESSVLD_SEL			BIT(28)
+
+#define USB_PHY_UTMI_CTRL0		0x3c
+
+#define USB_PHY_UTMI_CTRL5		0x50
+ #define POR_EN				BIT(1)
+ #define ATERESET			~BIT(0)
+
+#define USB_PHY_HS_PHY_CTRL_COMMON0	0x54
+ #define COMMONONN			BIT(7)
+ #define FSEL				BIT(4)
+ #define RETENABLEN			BIT(3)
+ #define FREQ_24MHZ			(5 << 4)
+
+#define USB_PHY_HS_PHY_CTRL2		0x64
+ #define USB2_SUSPEND_N_SEL		BIT(3)
+ #define USB2_SUSPEND_N			BIT(2)
+ #define USB2_UTMI_CLK_EN		BIT(1)
+
+#define USB_PHY_CFG0			0x94
+ #define UTMI_PHY_OVERRIDE_EN		BIT(1)
+
+#define USB_PHY_REFCLK_CTRL		0xa0
+ #define CLKCORE			BIT(1)
+
+#define USB2PHY_PORT_POWERDOWN		0xa4
+ #define POWER_UP			BIT(0)
+ #define POWER_DOWN			0
+
+#define USB_PHY_FSEL_SEL		0xb8
+ #define FREQ_SEL			BIT(0)
+
+#define USB2PHY_USB_PHY_M31_XCFGI_1	0xbc
+ #define USB2_0_TX_ENABLE		BIT(2)
+
+#define USB2PHY_USB_PHY_M31_XCFGI_4	0xc8
+ #define HSTX_SLEW_RATE_565PS		GENMASK(1, 0)
+ #define PLL_CHARGING_PUMP_CURRENT_35UA	GENMASK(4, 3)
+ #define ODT_VALUE_38_02_OHM		GENMASK(7, 6)
+
+#define USB2PHY_USB_PHY_M31_XCFGI_5	0xcc
+ #define ODT_VALUE_45_02_OHM		BIT(2)
+ #define HSTX_PRE_EMPHASIS_LEVEL_0_55MA	BIT(0)
+
+#define USB2PHY_USB_PHY_M31_XCFGI_11	0xe4
+ #define XCFG_COARSE_TUNE_NUM		BIT(1)
+ #define XCFG_FINE_TUNE_NUM		BIT(3)
+
+struct m31_phy_regs {
+	u32 off;
+	u32 val;
+	u32 delay;
+};
+
+struct m31_priv_data {
+	bool				ulpi_mode;
+	const struct m31_phy_regs	*regs;
+};
+
+#define M31_REG(__o, __v, __d)	\
+	{ .off = __o, .val = __v, .delay = __d }
+
+#define M31_REG_INVALID			0xffffffffu
+
+struct m31_phy_regs m31_ipq5332_regs[] = {
+	M31_REG(USB_PHY_CFG0, UTMI_PHY_OVERRIDE_EN, 0),
+	M31_REG(USB_PHY_UTMI_CTRL5, POR_EN, 15),
+	M31_REG(USB_PHY_FSEL_SEL, FREQ_SEL, 0),
+	M31_REG(USB_PHY_HS_PHY_CTRL_COMMON0,
+		COMMONONN | FREQ_24MHZ | RETENABLEN, 0),
+	M31_REG(USB_PHY_UTMI_CTRL5, POR_EN & ATERESET, 0),
+	M31_REG(USB_PHY_HS_PHY_CTRL2,
+		USB2_SUSPEND_N_SEL | USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0),
+	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_11,
+		XCFG_COARSE_TUNE_NUM  | XCFG_FINE_TUNE_NUM, 0),
+	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_4,
+		HSTX_SLEW_RATE_565PS | PLL_CHARGING_PUMP_CURRENT_35UA |
+		ODT_VALUE_38_02_OHM, 0),
+	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_1, USB2_0_TX_ENABLE, 0),
+	M31_REG(USB2PHY_USB_PHY_M31_XCFGI_5,
+		ODT_VALUE_45_02_OHM | HSTX_PRE_EMPHASIS_LEVEL_0_55MA, 4),
+	M31_REG(USB_PHY_UTMI_CTRL5, 0x0, 0),
+	M31_REG(USB_PHY_HS_PHY_CTRL2, USB2_SUSPEND_N | USB2_UTMI_CLK_EN, 0),
+	M31_REG(M31_REG_INVALID, 0, 0),
+};
+
+struct m31usb_phy {
+	struct usb_phy			phy;
+	void __iomem			*base;
+	const struct m31_phy_regs	*regs;
+
+	struct clk			*cfg_ahb_clk;
+	struct reset_control		*phy_reset;
+
+	bool				cable_connected;
+	bool				suspended;
+	bool				ulpi_mode;
+};
+
+static void m31usb_phy_enable_clock(struct m31usb_phy *qphy)
+{
+	const struct m31_phy_regs *regs = qphy->regs;
+
+	for (; regs->off != M31_REG_INVALID; regs++) {
+		writel(regs->val, qphy->base + regs->off);
+		if (regs->delay)
+			udelay(regs->delay);
+	}
+}
+
+static int m31usb_phy_init(struct usb_phy *phy)
+{
+	int ret;
+	struct m31usb_phy *qphy = container_of(phy, struct m31usb_phy, phy);
+
+	ret = clk_prepare_enable(qphy->cfg_ahb_clk);
+	if (ret) {
+		dev_err(phy->dev, "failed to enable cfg ahb clock, %d\n", ret);
+		return ret;
+	}
+
+	/* Perform phy reset */
+	reset_control_assert(qphy->phy_reset);
+	udelay(5);
+	reset_control_deassert(qphy->phy_reset);
+
+	/* configure for ULPI mode if requested */
+	if (qphy->ulpi_mode)
+		writel(0x0, qphy->base + USB2PHY_PORT_UTMI_CTRL2);
+
+	/* Enable the PHY */
+	writel(POWER_UP, qphy->base + USB2PHY_PORT_POWERDOWN);
+
+	/* Make sure above write completed */
+	wmb();
+
+	/* Turn on phy ref clock */
+	m31usb_phy_enable_clock(qphy);
+
+	return 0;
+}
+
+static void m31usb_phy_shutdown(struct usb_phy *phy)
+{
+	struct m31usb_phy *qphy = container_of(phy, struct m31usb_phy, phy);
+
+	/* Disable the PHY */
+	writel_relaxed(POWER_DOWN, qphy->base + USB2PHY_PORT_POWERDOWN);
+	/* Make sure above write completed */
+	wmb();
+
+	clk_disable_unprepare(qphy->cfg_ahb_clk);
+}
+
+static int m31usb_phy_probe(struct platform_device *pdev)
+{
+	const struct m31_priv_data *data;
+	struct device *dev = &pdev->dev;
+	struct m31usb_phy *qphy;
+	int ret;
+
+	qphy = devm_kzalloc(dev, sizeof(*qphy), GFP_KERNEL);
+	if (!qphy)
+		return -ENOMEM;
+
+	qphy->phy.dev = dev;
+
+	qphy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(qphy->base))
+		return PTR_ERR(qphy->base);
+
+	qphy->phy_reset = devm_reset_control_get_exclusive_by_index(dev, 0);
+	if (IS_ERR(qphy->phy_reset))
+		return PTR_ERR(qphy->phy_reset);
+
+	qphy->cfg_ahb_clk = devm_clk_get(dev, "cfg_ahb");
+	platform_set_drvdata(pdev, qphy);
+
+	data = of_device_get_match_data(dev);
+	qphy->regs = data->regs;
+	qphy->ulpi_mode = data->ulpi_mode;
+
+	qphy->phy.label			= "m31-usb-phy";
+	qphy->phy.init			= m31usb_phy_init;
+	qphy->phy.shutdown		= m31usb_phy_shutdown;
+	qphy->phy.type			= USB_PHY_TYPE_USB2;
+
+	ret = usb_add_phy_dev(&qphy->phy);
+
+	return ret;
+}
+
+static void m31usb_phy_remove(struct platform_device *pdev)
+{
+	struct m31usb_phy *qphy = platform_get_drvdata(pdev);
+
+	usb_remove_phy(&qphy->phy);
+}
+
+struct m31_priv_data m31_ipq5332_data = {
+	.ulpi_mode = false,
+	.regs = m31_ipq5332_regs,
+};
+
+static const struct of_device_id m31usb_phy_id_table[] = {
+	{ .compatible = "qcom,ipq5332-usb-hsphy", .data = &m31_ipq5332_data },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, m31usb_phy_id_table);
+
+static struct platform_driver m31usb_phy_driver = {
+	.probe		= m31usb_phy_probe,
+	.remove_new	= m31usb_phy_remove,
+	.driver = {
+		.name	= "qcom-m31usb-phy",
+		.of_match_table = m31usb_phy_id_table,
+	},
+};
+
+module_platform_driver(m31usb_phy_driver);
+
+MODULE_DESCRIPTION("USB2 Qualcomm M31 HSPHY driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

