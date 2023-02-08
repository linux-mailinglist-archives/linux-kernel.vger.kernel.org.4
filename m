Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DBE68F6F8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjBHSev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbjBHSel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:34:41 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822BD4F851
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:34:38 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y1so17730225wru.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnxCgsidA3pJsf3grWiAFsJGamFbYvOfxrwCvWruQWY=;
        b=MJsINtXzaf85yZM4fsxUGf+kdk+OPU1voGndr3AixunCamgVN9lwWDQEHMKaF5JYdo
         eVTeCMIZdpwa/NjzAs8vyyPA58ODyp7jMkpTzlTRSfFJotbpRVSSrZ8RMlzqPdhaah4r
         97j7MSBD5FH2EaGpUsA/8Z744oTgWxLMhlsIjnx2FwWlHPqtZ18qGIMNoawWXti3xg7f
         9AX7BAmRKYm4uruA58JC5VQ3GilGoYdH7YdlLj2Mm0KVZTlnQefWEoNRdFwoQU/jiBgW
         sOfJ/t+TX5PB9SayP5gn8G7HsQfj8rBszIL9V6czYrfqzjGvmTvNlR4Q7Xx/D3omC703
         bZ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnxCgsidA3pJsf3grWiAFsJGamFbYvOfxrwCvWruQWY=;
        b=JQmFovYru/RYdHJsZ6y2rcH8rirs9xzR96+Eo4jGj2A7OvcHGdu9XODyO16koPPTYH
         Nj1XtI2TNoZAZeeI4R0tKcBD0SC7Xo1OhJfa0BNkEtVrWUX2q14nYL32gdzjnQwunRY/
         4Ao60Xu0XTH9x4QEr9uZ84+RrP6frgJuJTBnO1DLhuwyT9XW99DptPdCkQcd5fdPQIhD
         9/H0RNGcPImJrnEc4uxMBjRe+se/46R56PzCVqRhISomvwR8y+kJb1n10W+wDa5E0jFL
         04f08kl4UuuXPvdOWiipLtu36ifCgjomsgTftpCQH/oABjqQ1G9ek1taCxU1syWPBLgz
         iRow==
X-Gm-Message-State: AO0yUKVKheNZRZ0Vr3zkhgu8WNCFZnQOSYtebGsoqp4Dze+glpptdjRP
        wP9cCgCuOq22b7KKFNWLLgBGAg==
X-Google-Smtp-Source: AK7set/CAPTaqkHwaUuVMDhDDt15vCVeWjX9MnS9IxaXzn+NcJaoIkqllSczF6gEqggEY3MhQI3Zzg==
X-Received: by 2002:adf:e481:0:b0:2c3:f188:23c3 with SMTP id i1-20020adfe481000000b002c3f18823c3mr7142089wrm.62.1675881276980;
        Wed, 08 Feb 2023 10:34:36 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v1-20020adf8b41000000b002be505ab59asm14591304wra.97.2023.02.08.10.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:34:36 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org
Subject: [PATCH v6 2/6] phy: qcom: Add QCOM SNPS eUSB2 driver
Date:   Wed,  8 Feb 2023 20:34:17 +0200
Message-Id: <20230208183421.2874423-3-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208183421.2874423-1-abel.vesa@linaro.org>
References: <20230208183421.2874423-1-abel.vesa@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SM8550 SoC uses Synopsis eUSB2 PHY for USB 2.0.
Add a new driver for it.

The driver is based on a downstream implementation.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v5 version of this patch was here:
https://lore.kernel.org/all/20230207114024.944314-3-abel.vesa@linaro.org/

Changes since v5:
 * fixed checkpatch indentation warning for ref_clk_freq argument on
   "unsupported ref_clk_freq" error

Changes since v4:
 * none

Changes since v3:
 * none

Changes since v2:
 * this time actually dropped the qcom_snps_, which I missed in the v2
 * this time actually added the new lines after break in switch clause,
   as Vinod suggested, which I missed in the v2

Changes since v1:
 * replaced qualcomm with qcom in subject line
 * dropped all unnecessary includes
 * dropped qcom_snps prefix from qcom_snps_eusb2_hsphy_vreg_names
 * properly aligned the arguments for qcom_snps_eusb2_hsphy_write_mask
 * added empty lines after break in switch clause, like Vinod suggested

 drivers/phy/qualcomm/Kconfig               |   9 +
 drivers/phy/qualcomm/Makefile              |   1 +
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 422 +++++++++++++++++++++
 3 files changed, 432 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 62cf51aab1b8..513322cdf83c 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -112,6 +112,15 @@ config PHY_QCOM_QUSB2
 	  PHY which is usually paired with either the ChipIdea or Synopsys DWC3
 	  USB IPs on MSM SOCs.
 
+config PHY_QCOM_SNPS_EUSB2
+	tristate "Qualcomm SNPS eUSB2 PHY Driver"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable support for the USB high-speed SNPS eUSB2 phy on Qualcomm
+	  chipsets. The PHY is paired with a Synopsys DWC3 USB controller
+	  on Qualcomm SOCs.
+
 config PHY_QCOM_USB_HS
 	tristate "Qualcomm USB HS PHY module"
 	depends on USB_ULPI_BUS
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index 79dd4e507961..b2c01665622b 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_PHY_QCOM_QMP_UFS)		+= phy-qcom-qmp-ufs.o
 obj-$(CONFIG_PHY_QCOM_QMP_USB)		+= phy-qcom-qmp-usb.o
 
 obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
+obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)	+= phy-qcom-snps-eusb2.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
new file mode 100644
index 000000000000..40a421cf3dd9
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
@@ -0,0 +1,422 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/phy/phy.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/reset.h>
+
+#define USB_PHY_UTMI_CTRL0		(0x3c)
+#define SLEEPM				BIT(0)
+#define OPMODE_MASK			GENMASK(4, 3)
+#define OPMODE_NONDRIVING		BIT(3)
+
+#define USB_PHY_UTMI_CTRL5		(0x50)
+#define POR				BIT(1)
+
+#define USB_PHY_HS_PHY_CTRL_COMMON0	(0x54)
+#define PHY_ENABLE			BIT(0)
+#define SIDDQ_SEL			BIT(1)
+#define SIDDQ				BIT(2)
+#define RETENABLEN			BIT(3)
+#define FSEL_MASK			GENMASK(6, 4)
+#define FSEL_19_2_MHZ_VAL		(0x0)
+#define FSEL_38_4_MHZ_VAL		(0x4)
+
+#define USB_PHY_CFG_CTRL_1		(0x58)
+#define PHY_CFG_PLL_CPBIAS_CNTRL_MASK	GENMASK(7, 1)
+
+#define USB_PHY_CFG_CTRL_2		(0x5c)
+#define PHY_CFG_PLL_FB_DIV_7_0_MASK	GENMASK(7, 0)
+#define DIV_7_0_19_2_MHZ_VAL		(0x90)
+#define DIV_7_0_38_4_MHZ_VAL		(0xc8)
+
+#define USB_PHY_CFG_CTRL_3		(0x60)
+#define PHY_CFG_PLL_FB_DIV_11_8_MASK	GENMASK(3, 0)
+#define DIV_11_8_19_2_MHZ_VAL		(0x1)
+#define DIV_11_8_38_4_MHZ_VAL		(0x0)
+
+#define PHY_CFG_PLL_REF_DIV		GENMASK(7, 4)
+#define PLL_REF_DIV_VAL			(0x0)
+
+#define USB_PHY_HS_PHY_CTRL2		(0x64)
+#define VBUSVLDEXT0			BIT(0)
+#define USB2_SUSPEND_N			BIT(2)
+#define USB2_SUSPEND_N_SEL		BIT(3)
+#define VBUS_DET_EXT_SEL		BIT(4)
+
+#define USB_PHY_CFG_CTRL_4		(0x68)
+#define PHY_CFG_PLL_GMP_CNTRL_MASK	GENMASK(1, 0)
+#define PHY_CFG_PLL_INT_CNTRL_MASK	GENMASK(7, 2)
+
+#define USB_PHY_CFG_CTRL_5		(0x6c)
+#define PHY_CFG_PLL_PROP_CNTRL_MASK	GENMASK(4, 0)
+#define PHY_CFG_PLL_VREF_TUNE_MASK	GENMASK(7, 6)
+
+#define USB_PHY_CFG_CTRL_6		(0x70)
+#define PHY_CFG_PLL_VCO_CNTRL_MASK	GENMASK(2, 0)
+
+#define USB_PHY_CFG_CTRL_7		(0x74)
+
+#define USB_PHY_CFG_CTRL_8		(0x78)
+#define PHY_CFG_TX_FSLS_VREF_TUNE_MASK	GENMASK(1, 0)
+#define PHY_CFG_TX_FSLS_VREG_BYPASS	BIT(2)
+#define PHY_CFG_TX_HS_VREF_TUNE_MASK	GENMASK(5, 3)
+#define PHY_CFG_TX_HS_XV_TUNE_MASK	GENMASK(7, 6)
+
+#define USB_PHY_CFG_CTRL_9		(0x7c)
+#define PHY_CFG_TX_PREEMP_TUNE_MASK	GENMASK(2, 0)
+#define PHY_CFG_TX_RES_TUNE_MASK	GENMASK(4, 3)
+#define PHY_CFG_TX_RISE_TUNE_MASK	GENMASK(6, 5)
+#define PHY_CFG_RCAL_BYPASS		BIT(7)
+
+#define USB_PHY_CFG_CTRL_10		(0x80)
+
+#define USB_PHY_CFG0			(0x94)
+#define DATAPATH_CTRL_OVERRIDE_EN	BIT(0)
+#define CMN_CTRL_OVERRIDE_EN		BIT(1)
+
+#define UTMI_PHY_CMN_CTRL0		(0x98)
+#define TESTBURNIN			BIT(6)
+
+#define USB_PHY_FSEL_SEL		(0xb8)
+#define FSEL_SEL			BIT(0)
+
+#define USB_PHY_APB_ACCESS_CMD		(0x130)
+#define RW_ACCESS			BIT(0)
+#define APB_START_CMD			BIT(1)
+#define APB_LOGIC_RESET			BIT(2)
+
+#define USB_PHY_APB_ACCESS_STATUS	(0x134)
+#define ACCESS_DONE			BIT(0)
+#define TIMED_OUT			BIT(1)
+#define ACCESS_ERROR			BIT(2)
+#define ACCESS_IN_PROGRESS		BIT(3)
+
+#define USB_PHY_APB_ADDRESS		(0x138)
+#define APB_REG_ADDR_MASK		GENMASK(7, 0)
+
+#define USB_PHY_APB_WRDATA_LSB		(0x13c)
+#define APB_REG_WRDATA_7_0_MASK		GENMASK(3, 0)
+
+#define USB_PHY_APB_WRDATA_MSB		(0x140)
+#define APB_REG_WRDATA_15_8_MASK	GENMASK(7, 4)
+
+#define USB_PHY_APB_RDDATA_LSB		(0x144)
+#define APB_REG_RDDATA_7_0_MASK		GENMASK(3, 0)
+
+#define USB_PHY_APB_RDDATA_MSB		(0x148)
+#define APB_REG_RDDATA_15_8_MASK	GENMASK(7, 4)
+
+static const char * const eusb2_hsphy_vreg_names[] = {
+	"vdd", "vdda12",
+};
+
+#define EUSB2_NUM_VREGS		ARRAY_SIZE(eusb2_hsphy_vreg_names)
+
+struct qcom_snps_eusb2_hsphy {
+	struct phy *phy;
+	void __iomem *base;
+
+	struct clk *ref_clk;
+	struct reset_control *phy_reset;
+
+	struct regulator_bulk_data vregs[EUSB2_NUM_VREGS];
+
+	enum phy_mode mode;
+};
+
+static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int submode)
+{
+	struct qcom_snps_eusb2_hsphy *phy = phy_get_drvdata(p);
+
+	phy->mode = mode;
+
+	return 0;
+}
+
+static void qcom_snps_eusb2_hsphy_write_mask(void __iomem *base, u32 offset,
+					     u32 mask, u32 val)
+{
+	u32 reg;
+
+	reg = readl_relaxed(base + offset);
+	reg &= ~mask;
+	reg |= val & mask;
+	writel_relaxed(reg, base + offset);
+
+	/* Ensure above write is completed */
+	readl_relaxed(base + offset);
+}
+
+static void qcom_eusb2_default_parameters(struct qcom_snps_eusb2_hsphy *phy)
+{
+	/* default parameters: tx pre-emphasis */
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_9,
+					 PHY_CFG_TX_PREEMP_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_PREEMP_TUNE_MASK, 0));
+
+	/* tx rise/fall time */
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_9,
+					 PHY_CFG_TX_RISE_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_RISE_TUNE_MASK, 0x2));
+
+	/* source impedance adjustment */
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_9,
+					 PHY_CFG_TX_RES_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_RES_TUNE_MASK, 0x1));
+
+	/* dc voltage level adjustement */
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_8,
+					 PHY_CFG_TX_HS_VREF_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_HS_VREF_TUNE_MASK, 0x3));
+
+	/* transmitter HS crossover adjustement */
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_8,
+					 PHY_CFG_TX_HS_XV_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_TX_HS_XV_TUNE_MASK, 0x0));
+}
+
+static int qcom_eusb2_ref_clk_init(struct qcom_snps_eusb2_hsphy *phy)
+{
+	unsigned long ref_clk_freq = clk_get_rate(phy->ref_clk);
+
+	switch (ref_clk_freq) {
+	case 19200000:
+		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+						 FSEL_MASK,
+						 FIELD_PREP(FSEL_MASK, FSEL_19_2_MHZ_VAL));
+
+		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_2,
+						 PHY_CFG_PLL_FB_DIV_7_0_MASK,
+						 DIV_7_0_19_2_MHZ_VAL);
+
+		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_3,
+						 PHY_CFG_PLL_FB_DIV_11_8_MASK,
+						 DIV_11_8_19_2_MHZ_VAL);
+		break;
+
+	case 38400000:
+		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+						 FSEL_MASK,
+						 FIELD_PREP(FSEL_MASK, FSEL_38_4_MHZ_VAL));
+
+		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_2,
+						 PHY_CFG_PLL_FB_DIV_7_0_MASK,
+						 DIV_7_0_38_4_MHZ_VAL);
+
+		qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_3,
+						 PHY_CFG_PLL_FB_DIV_11_8_MASK,
+						 DIV_11_8_38_4_MHZ_VAL);
+		break;
+
+	default:
+		dev_err(&phy->phy->dev, "unsupported ref_clk_freq:%lu\n", ref_clk_freq);
+		return -EINVAL;
+	}
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_3,
+					 PHY_CFG_PLL_REF_DIV, PLL_REF_DIV_VAL);
+
+	return 0;
+}
+
+static int qcom_snps_eusb2_hsphy_init(struct phy *p)
+{
+	struct qcom_snps_eusb2_hsphy *phy = phy_get_drvdata(p);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(phy->vregs), phy->vregs);
+	if (ret)
+		return ret;
+
+	ret = clk_prepare_enable(phy->ref_clk);
+	if (ret) {
+		dev_err(&p->dev, "failed to enable ref clock, %d\n", ret);
+		goto disable_vreg;
+	}
+
+	ret = reset_control_assert(phy->phy_reset);
+	if (ret) {
+		dev_err(&p->dev, "failed to assert phy_reset, %d\n", ret);
+		goto disable_ref_clk;
+	}
+
+	usleep_range(100, 150);
+
+	ret = reset_control_deassert(phy->phy_reset);
+	if (ret) {
+		dev_err(&p->dev, "failed to de-assert phy_reset, %d\n", ret);
+		goto disable_ref_clk;
+	}
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG0,
+					 CMN_CTRL_OVERRIDE_EN, CMN_CTRL_OVERRIDE_EN);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_UTMI_CTRL5, POR, POR);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+					 PHY_ENABLE | RETENABLEN, PHY_ENABLE | RETENABLEN);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_APB_ACCESS_CMD,
+					 APB_LOGIC_RESET, APB_LOGIC_RESET);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, UTMI_PHY_CMN_CTRL0, TESTBURNIN, 0);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_FSEL_SEL,
+					 FSEL_SEL, FSEL_SEL);
+
+	/* update ref_clk related registers */
+	ret = qcom_eusb2_ref_clk_init(phy);
+	if (ret)
+		goto disable_ref_clk;
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_1,
+					 PHY_CFG_PLL_CPBIAS_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_CPBIAS_CNTRL_MASK, 0x1));
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_4,
+					 PHY_CFG_PLL_INT_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_INT_CNTRL_MASK, 0x8));
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_4,
+					 PHY_CFG_PLL_GMP_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_GMP_CNTRL_MASK, 0x1));
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_5,
+					 PHY_CFG_PLL_PROP_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_PROP_CNTRL_MASK, 0x10));
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_6,
+					 PHY_CFG_PLL_VCO_CNTRL_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_VCO_CNTRL_MASK, 0x0));
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_CFG_CTRL_5,
+					 PHY_CFG_PLL_VREF_TUNE_MASK,
+					 FIELD_PREP(PHY_CFG_PLL_VREF_TUNE_MASK, 0x1));
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL2,
+					 VBUS_DET_EXT_SEL, VBUS_DET_EXT_SEL);
+
+	/* set default parameters */
+	qcom_eusb2_default_parameters(phy);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL2,
+					 USB2_SUSPEND_N_SEL | USB2_SUSPEND_N,
+					 USB2_SUSPEND_N_SEL | USB2_SUSPEND_N);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_UTMI_CTRL0, SLEEPM, SLEEPM);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+					 SIDDQ_SEL, SIDDQ_SEL);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL_COMMON0,
+					 SIDDQ, 0);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_UTMI_CTRL5, POR, 0);
+
+	qcom_snps_eusb2_hsphy_write_mask(phy->base, USB_PHY_HS_PHY_CTRL2,
+					 USB2_SUSPEND_N_SEL, 0);
+
+	return 0;
+
+disable_ref_clk:
+	clk_disable_unprepare(phy->ref_clk);
+
+disable_vreg:
+	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
+
+	return ret;
+}
+
+static int qcom_snps_eusb2_hsphy_exit(struct phy *p)
+{
+	struct qcom_snps_eusb2_hsphy *phy = phy_get_drvdata(p);
+
+	clk_disable_unprepare(phy->ref_clk);
+
+	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
+
+	return 0;
+}
+
+static const struct phy_ops qcom_snps_eusb2_hsphy_ops = {
+	.init		= qcom_snps_eusb2_hsphy_init,
+	.exit		= qcom_snps_eusb2_hsphy_exit,
+	.set_mode	= qcom_snps_eusb2_hsphy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct qcom_snps_eusb2_hsphy *phy;
+	struct phy_provider *phy_provider;
+	struct phy *generic_phy;
+	int ret, i;
+	int num;
+
+	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
+	if (!phy)
+		return -ENOMEM;
+
+	phy->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(phy->base))
+		return PTR_ERR(phy->base);
+
+	phy->phy_reset = devm_reset_control_get_exclusive(dev, NULL);
+	if (IS_ERR(phy->phy_reset))
+		return PTR_ERR(phy->phy_reset);
+
+	phy->ref_clk = devm_clk_get(dev, "ref");
+	if (IS_ERR(phy->ref_clk))
+		return dev_err_probe(dev, PTR_ERR(phy->ref_clk),
+				     "failed to get ref clk\n");
+
+	num = ARRAY_SIZE(phy->vregs);
+	for (i = 0; i < num; i++)
+		phy->vregs[i].supply = eusb2_hsphy_vreg_names[i];
+
+	ret = devm_regulator_bulk_get(dev, num, phy->vregs);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to get regulator supplies\n");
+	generic_phy = devm_phy_create(dev, NULL, &qcom_snps_eusb2_hsphy_ops);
+	if (IS_ERR(generic_phy)) {
+		dev_err(dev, "failed to create phy %d\n", ret);
+		return PTR_ERR(generic_phy);
+	}
+
+	dev_set_drvdata(dev, phy);
+	phy_set_drvdata(generic_phy, phy);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	dev_info(dev, "Registered Qcom-eUSB2 phy\n");
+
+	return 0;
+}
+
+static const struct of_device_id qcom_snps_eusb2_hsphy_of_match_table[] = {
+	{ .compatible = "qcom,sm8550-snps-eusb2-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_snps_eusb2_hsphy_of_match_table);
+
+static struct platform_driver qcom_snps_eusb2_hsphy_driver = {
+	.probe		= qcom_snps_eusb2_hsphy_probe,
+	.driver = {
+		.name	= "qcom-snps-eusb2-hsphy",
+		.of_match_table = qcom_snps_eusb2_hsphy_of_match_table,
+	},
+};
+
+module_platform_driver(qcom_snps_eusb2_hsphy_driver);
+MODULE_DESCRIPTION("Qualcomm SNPS eUSB2 HS PHY driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

