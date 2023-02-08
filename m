Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E0268F7B1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbjBHTC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjBHTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:02:13 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B590553E69
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:02:11 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id hn2-20020a05600ca38200b003dc5cb96d46so2187609wmb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VFb0j1iNnby6pqy0hFVH2kKNe/PHf2EHoECIMHT6ro4=;
        b=PBFsdr6W+r2kBQJWmZOrM2n97oSoAcFGe+DnxQ96q3DLzg99LtCGjZDKiQLpAsXV/n
         biTv/9JqnSClI46TcC3EqA/A1XgfVav3FEwtV6tq7+27DAPuQn1+tI1xyQf64Ir0N2HX
         DjLtFCe/j6sBQlVwwmCOeeS+/qRZ6yed/qeSGv6wQsZ/32DTUGZ8eKGIo2yZ8Ct6dkbc
         +4eQFsPEK36dbGKRI9yS1s8s95RefRTkOf/B1qLmYogi4cvv0l4Jw62Qe3Fw17NGeLuQ
         Vr0PE1EfyDxqgOa2N/HcqLeeNjULs34eEvfvImMFeUSMZHqnFiHuAFrLsYHaMocaZzFm
         YiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VFb0j1iNnby6pqy0hFVH2kKNe/PHf2EHoECIMHT6ro4=;
        b=VxDHdk69kMcgZVblm0Kcav0SUTv5uZVecEZkIbe/BOBgeR8B6lpFIa6JqXpowkdmuv
         uPbcDDZIL+N6t4t/kFLKp5DpqxUjI3cOokYe6gOeAzCRw7CLkjHROaDj/2UUD5OIWgUk
         xmLHOauaeZKCCmC3hEv3hVcjy/IP3/JfXfuxv02V/RbmFvLizkha3PHHCNbQvlFh1Y36
         iTkL96Xrov/rvZBCC+XqK4QAS3Rk2ogNn568HFyDpi54uC7i00ZZhGqLVj6ySW7TPbui
         sAnPjiLLJ3GK40DSCrByd4kmh3DMOGlYU3gnxcLqEt6sBWe/9YIZEMPXnucRZ+qKgbrh
         Yocw==
X-Gm-Message-State: AO0yUKWQJP6CGAEXovMv+aFqL8LT73T6lUCoy/BXNqT3hosulRVpovE8
        /hBiFD8l2e4ctIgG3Hyu6y7Zzw==
X-Google-Smtp-Source: AK7set8cxh70IH9n74WqfPTkt9+gdAZuXTM4l65kEEiNYqIdtdKl4Z5fL7YwpaL06fibq1hNUbD/0Q==
X-Received: by 2002:a05:600c:3416:b0:3df:57aa:db52 with SMTP id y22-20020a05600c341600b003df57aadb52mr7261209wmp.4.1675882930224;
        Wed, 08 Feb 2023 11:02:10 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003dc1d668866sm2650327wmc.10.2023.02.08.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:02:09 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/7] phy: qcom: Add QCOM SNPS eUSB2 repeater driver
Date:   Wed,  8 Feb 2023 21:01:57 +0200
Message-Id: <20230208190200.2966723-5-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230208190200.2966723-1-abel.vesa@linaro.org>
References: <20230208190200.2966723-1-abel.vesa@linaro.org>
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

PM8550B contains a eUSB2 repeater used for making the eUSB2 from
SM8550 USB 2.0 compliant. This can be modelled SW-wise as a Phy.
So add a new phy driver for it.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---

The v4 is here:
https://lore.kernel.org/all/20230207135551.1418637-5-abel.vesa@linaro.org/

Changes since v4:
 * none

Changes since v3:
 * fixed all indentation issues and dropped a few blank lines to pass
   checkpatch
 * dropped shift defines as they were not used
 * dropped the repeater_mode as it was not used
 * dropped the of_node_get and of_node_put for of_node
 * dropped the comment related to regulators in eusb2_repeater_cfg, like
   Vinod suggested
 * dropped the initialization of ret in eusb2_repeater_init

 drivers/phy/qualcomm/Kconfig                  |   9 +
 drivers/phy/qualcomm/Makefile                 |   1 +
 .../phy/qualcomm/phy-qcom-eusb2-repeater.c    | 259 ++++++++++++++++++
 3 files changed, 269 insertions(+)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c

diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
index 513322cdf83c..4850d48f31fa 100644
--- a/drivers/phy/qualcomm/Kconfig
+++ b/drivers/phy/qualcomm/Kconfig
@@ -121,6 +121,15 @@ config PHY_QCOM_SNPS_EUSB2
 	  chipsets. The PHY is paired with a Synopsys DWC3 USB controller
 	  on Qualcomm SOCs.
 
+config PHY_QCOM_EUSB2_REPEATER
+	tristate "Qualcomm SNPS eUSB2 Repeater Driver"
+	depends on OF && (ARCH_QCOM || COMPILE_TEST)
+	select GENERIC_PHY
+	help
+	  Enable support for the USB high-speed SNPS eUSB2 repeater on Qualcomm
+	  PMICs. The repeater is paired with a Synopsys eUSB2 Phy
+	  on Qualcomm SOCs.
+
 config PHY_QCOM_USB_HS
 	tristate "Qualcomm USB HS PHY module"
 	depends on USB_ULPI_BUS
diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
index b2c01665622b..de3dc9ccf067 100644
--- a/drivers/phy/qualcomm/Makefile
+++ b/drivers/phy/qualcomm/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PHY_QCOM_QMP_USB)		+= phy-qcom-qmp-usb.o
 
 obj-$(CONFIG_PHY_QCOM_QUSB2)		+= phy-qcom-qusb2.o
 obj-$(CONFIG_PHY_QCOM_SNPS_EUSB2)	+= phy-qcom-snps-eusb2.o
+obj-$(CONFIG_PHY_QCOM_EUSB2_REPEATER)	+= phy-qcom-eusb2-repeater.o
 obj-$(CONFIG_PHY_QCOM_USB_HS) 		+= phy-qcom-usb-hs.o
 obj-$(CONFIG_PHY_QCOM_USB_HSIC) 	+= phy-qcom-usb-hsic.o
 obj-$(CONFIG_PHY_QCOM_USB_HS_28NM)	+= phy-qcom-usb-hs-28nm.o
diff --git a/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
new file mode 100644
index 000000000000..3f265ac2df20
--- /dev/null
+++ b/drivers/phy/qualcomm/phy-qcom-eusb2-repeater.c
@@ -0,0 +1,259 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+
+/* eUSB2 status registers */
+#define EUSB2_RPTR_STATUS		0x08
+#define	RPTR_OK				BIT(7)
+
+/* eUSB2 control registers */
+#define EUSB2_EN_CTL1			0x46
+#define EUSB2_RPTR_EN			BIT(7)
+
+#define EUSB2_FORCE_EN_5		0xe8
+#define F_CLK_19P2M_EN			BIT(6)
+
+#define EUSB2_FORCE_VAL_5		0xeD
+#define V_CLK_19P2M_EN			BIT(6)
+
+#define EUSB2_TUNE_IUSB2		0x51
+#define EUSB2_TUNE_SQUELCH_U		0x54
+#define EUSB2_TUNE_USB2_PREEM		0x57
+
+#define QCOM_EUSB2_REPEATER_INIT_CFG(o, v)	\
+	{					\
+		.offset = o,			\
+		.val = v,			\
+	}
+
+struct eusb2_repeater_init_tbl {
+	unsigned int offset;
+	unsigned int val;
+};
+
+struct eusb2_repeater_cfg {
+	const struct eusb2_repeater_init_tbl *init_tbl;
+	int init_tbl_num;
+	const char * const *vreg_list;
+	int num_vregs;
+};
+
+struct eusb2_repeater {
+	struct device *dev;
+	struct regmap *regmap;
+	struct phy *phy;
+	struct regulator_bulk_data *vregs;
+	const struct eusb2_repeater_cfg *cfg;
+	u16 base;
+	enum phy_mode mode;
+};
+
+static const char * const pm8550b_vreg_l[] = {
+	"vdd18", "vdd3",
+};
+
+static const struct eusb2_repeater_init_tbl pm8550b_init_tbl[] = {
+	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_IUSB2, 0x8),
+	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_SQUELCH_U, 0x3),
+	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_USB2_PREEM, 0x5),
+};
+
+static const struct eusb2_repeater_cfg pm8550b_eusb2_cfg = {
+	.init_tbl	= pm8550b_init_tbl,
+	.init_tbl_num	= ARRAY_SIZE(pm8550b_init_tbl),
+	.vreg_list	= pm8550b_vreg_l,
+	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
+};
+
+static int eusb2_repeater_init_vregs(struct eusb2_repeater *rptr)
+{
+	int num = rptr->cfg->num_vregs;
+	struct device *dev = rptr->dev;
+	int i;
+
+	rptr->vregs = devm_kcalloc(dev, num, sizeof(*rptr->vregs), GFP_KERNEL);
+	if (!rptr->vregs)
+		return -ENOMEM;
+
+	for (i = 0; i < num; i++)
+		rptr->vregs[i].supply = rptr->cfg->vreg_list[i];
+
+	return devm_regulator_bulk_get(dev, num, rptr->vregs);
+}
+
+static int eusb2_repeater_init(struct phy *phy)
+{
+	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
+	const struct eusb2_repeater_init_tbl *init_tbl = rptr->cfg->init_tbl;
+	int num = rptr->cfg->init_tbl_num;
+	u32 val;
+	int ret;
+	int i;
+
+	ret = regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(rptr->regmap, rptr->base + EUSB2_EN_CTL1,
+			   EUSB2_RPTR_EN, EUSB2_RPTR_EN);
+
+	for (i = 0; i < num; i++)
+		regmap_update_bits(rptr->regmap,
+				   rptr->base + init_tbl[i].offset,
+				   init_tbl[i].val, init_tbl[i].val);
+
+	ret = regmap_read_poll_timeout(rptr->regmap,
+				       rptr->base + EUSB2_RPTR_STATUS, val,
+				       val & RPTR_OK, 10, 5);
+	if (ret)
+		dev_err(rptr->dev, "initialization timed-out\n");
+
+	return ret;
+}
+
+static int eusb2_repeater_set_mode(struct phy *phy,
+				   enum phy_mode mode, int submode)
+{
+	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
+
+	switch (mode) {
+	case PHY_MODE_USB_HOST:
+		/*
+		 * CM.Lx is prohibited when repeater is already into Lx state as
+		 * per eUSB 1.2 Spec. Below implement software workaround until
+		 * PHY and controller is fixing seen observation.
+		 */
+		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_EN_5,
+				   F_CLK_19P2M_EN, F_CLK_19P2M_EN);
+		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_VAL_5,
+				   V_CLK_19P2M_EN, V_CLK_19P2M_EN);
+		break;
+	case PHY_MODE_USB_DEVICE:
+		/*
+		 * In device mode clear host mode related workaround as there
+		 * is no repeater reset available, and enable/disable of
+		 * repeater doesn't clear previous value due to shared
+		 * regulators (say host <-> device mode switch).
+		 */
+		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_EN_5,
+				   F_CLK_19P2M_EN, 0);
+		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_VAL_5,
+				   V_CLK_19P2M_EN, 0);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int eusb2_repeater_exit(struct phy *phy)
+{
+	struct eusb2_repeater *rptr = phy_get_drvdata(phy);
+
+	return regulator_bulk_disable(rptr->cfg->num_vregs, rptr->vregs);
+}
+
+static const struct phy_ops eusb2_repeater_ops = {
+	.init		= eusb2_repeater_init,
+	.exit		= eusb2_repeater_exit,
+	.set_mode	= eusb2_repeater_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static int eusb2_repeater_probe(struct platform_device *pdev)
+{
+	struct eusb2_repeater *rptr;
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct device_node *np = dev->of_node;
+	u32 res;
+	int ret;
+
+	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
+	if (!rptr)
+		return -ENOMEM;
+
+	rptr->dev = dev;
+	dev_set_drvdata(dev, rptr);
+
+	rptr->cfg = of_device_get_match_data(dev);
+	if (!rptr->cfg)
+		return -EINVAL;
+
+	rptr->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!rptr->regmap)
+		return -ENODEV;
+
+	ret = of_property_read_u32(np, "reg", &res);
+	if (ret < 0)
+		return ret;
+
+	rptr->base = res;
+
+	ret = eusb2_repeater_init_vregs(rptr);
+	if (ret < 0) {
+		dev_err(dev, "unable to get supplies\n");
+		return ret;
+	}
+
+	rptr->phy = devm_phy_create(dev, np, &eusb2_repeater_ops);
+	if (IS_ERR(rptr->phy)) {
+		dev_err(dev, "failed to create PHY: %d\n", ret);
+		return PTR_ERR(rptr->phy);
+	}
+
+	phy_set_drvdata(rptr->phy, rptr);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	dev_info(dev, "Registered Qcom-eUSB2 repeater\n");
+
+	return 0;
+}
+
+static int eusb2_repeater_remove(struct platform_device *pdev)
+{
+	struct eusb2_repeater *rptr = platform_get_drvdata(pdev);
+
+	if (!rptr)
+		return 0;
+
+	eusb2_repeater_exit(rptr->phy);
+
+	return 0;
+}
+
+static const struct of_device_id eusb2_repeater_of_match_table[] = {
+	{
+		.compatible = "qcom,pm8550b-eusb2-repeater",
+		.data = &pm8550b_eusb2_cfg,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, eusb2_repeater_of_match_table);
+
+static struct platform_driver eusb2_repeater_driver = {
+	.probe		= eusb2_repeater_probe,
+	.remove		= eusb2_repeater_remove,
+	.driver = {
+		.name	= "qcom-eusb2-repeater",
+		.of_match_table = eusb2_repeater_of_match_table,
+	},
+};
+
+module_platform_driver(eusb2_repeater_driver);
+
+MODULE_DESCRIPTION("Qualcomm PMIC eUSB2 Repeater driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

