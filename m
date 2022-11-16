Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090EF62BDF3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238910AbiKPMbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:31:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238925AbiKPMbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:31:03 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A5101EC
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:30:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l14so29678671wrw.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giz1O34wJy7wAaesQ+FF9P4d8dC3HL0qQyzf5aCfDtI=;
        b=f629j43mafTaOsWIuSAx2miVnTB7i3LJ4zxycA8qlKgosC41Di6RVChbXNnhQ6zpLk
         CkylExavPLU0yzIZi6p9QV5xdTc8x3OBqWRKGM3yXzkvmz/+V+OKPyag10pzQBq7FxQl
         pzm1+iG7natxVG/vrjkQYvUlt03U8VkrZ7WtjRO8xuwsUHrhQvBwnmEp3Lf3Hqrbz8NH
         Ie+VikfwnaeJpb/1x89S9pGE4Uo4dFXU8m+V7P36iHWnle2khpHtN4tNROZZasCtyFju
         NzEpnyavk4UvkFFEuxuQ5XxEZ7/0NbXMrMv4V+j5jqwxq71AQiyuM8ZMuXDkEqLoIMoK
         ClQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=giz1O34wJy7wAaesQ+FF9P4d8dC3HL0qQyzf5aCfDtI=;
        b=CbIbAMUve5uNoUkmsWaxs7QD78kMDgXAx3XpXUherZrBWbUeWUkb2StCELdAfPEeS7
         Im7BzKvFJqBgVVW+/vXBPYYuLozG3n0FQp1zb2EybJTmzw4UJZcfVku+9ZRqTnyQbPh8
         gevqcGYvXMz3nmlp2dMPpU6rdRAHSh9kW/mKEq9HPzAul6NfgwNoL68087B2vCMZQ7Sp
         KZEYeGtppNYFJqlKgYhL11Hkp2VkR9XJRclM8nWfX9k7mSjk5riasZaVXR/EqeoGdvYu
         CsEDup297KhmxUNWmBZ9q9C4fPJ43sR3km2JcuV4aRa0jgEOTmwqBz4TvSMwzSlnjlMF
         fd0A==
X-Gm-Message-State: ANoB5pleTeG+xiaGrPpWpL+3aMwHY4Q6h5TfaFR6HrWSIRsvvIUP61g+
        sSrAAh6d42k5YSw1HeeMYXIk3w==
X-Google-Smtp-Source: AA0mqf6uMeRIj4E2S0KLJgtKri2ZHqr04fidakEuU8TfyVjypeu/CWYCHR1kRZY8YCx/wmWIwy9yyg==
X-Received: by 2002:a05:6000:12cf:b0:236:6e75:dc37 with SMTP id l15-20020a05600012cf00b002366e75dc37mr12858672wrx.504.1668601838129;
        Wed, 16 Nov 2022 04:30:38 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id l42-20020a05600c1d2a00b003cf4eac8e80sm2870991wms.23.2022.11.16.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:30:37 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH 3/3] usb: repeater: Add Qualcomm PMIC eUSB2 driver
Date:   Wed, 16 Nov 2022 14:30:19 +0200
Message-Id: <20221116123019.2753230-4-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116123019.2753230-1-abel.vesa@linaro.org>
References: <20221116123019.2753230-1-abel.vesa@linaro.org>
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
SM8550 USB 2.0 compliant.

Add a platform specific repeater driver. It implements ops for init,
reset and power on/off. On init, there is a configuration table that
needs to be written to the repeater's registers.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 drivers/usb/repeater/Kconfig                  |  11 +
 drivers/usb/repeater/Makefile                 |   1 +
 .../usb/repeater/repeater-qcom-pmic-eusb2.c   | 251 ++++++++++++++++++
 3 files changed, 263 insertions(+)
 create mode 100644 drivers/usb/repeater/repeater-qcom-pmic-eusb2.c

diff --git a/drivers/usb/repeater/Kconfig b/drivers/usb/repeater/Kconfig
index e12cd22c0adb..20baeb8f950c 100644
--- a/drivers/usb/repeater/Kconfig
+++ b/drivers/usb/repeater/Kconfig
@@ -7,3 +7,14 @@ config USB_REPEATER
 	  driver to bind together and to provide the USB driver ways to perform
 	  set of operations with repeater for USB2 functionality using PHY and
 	  controller driver.
+
+config QCOM_PMIC_EUSB2_REPEATER
+	tristate "USB eUSB2 Repeater driver"
+	select USB_REPEATER
+	help
+	  Enable this to support the USB eUSB2 repeater on Qualcomm PMIC chips.
+	  This driver provides support to reset, initialize, power up and configure
+	  the eUSB2 repeater for USB HS/FS/LS functionality where eUSB2 repeater
+	  is used.
+
+	  To compile the driver as a module, choose M here.
diff --git a/drivers/usb/repeater/Makefile b/drivers/usb/repeater/Makefile
index 2d1b5f348976..fed128407315 100644
--- a/drivers/usb/repeater/Makefile
+++ b/drivers/usb/repeater/Makefile
@@ -4,3 +4,4 @@
 #
 
 obj-$(CONFIG_USB_REPEATER)		+= repeater.o
+obj-$(CONFIG_QCOM_PMIC_EUSB2_REPEATER)	+= repeater-qcom-pmic-eusb2.o
diff --git a/drivers/usb/repeater/repeater-qcom-pmic-eusb2.c b/drivers/usb/repeater/repeater-qcom-pmic-eusb2.c
new file mode 100644
index 000000000000..1b6d46c28da4
--- /dev/null
+++ b/drivers/usb/repeater/repeater-qcom-pmic-eusb2.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <linux/regmap.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+
+#include <linux/usb/repeater.h>
+
+/* eUSB2 status registers */
+#define EUSB2_RPTR_STATUS		0x08
+#define	RPTR_OK				BIT(7)
+
+/* eUSB2 control registers */
+#define EUSB2_EN_CTL1			0x46
+#define EUSB2_RPTR_EN			BIT(7)
+
+#define PHY_HOST_MODE			BIT(0)
+#define EUSB2_FORCE_EN_5		0xE8
+#define F_CLK_19P2M_EN			BIT(6)
+#define F_CLK_19P2M_EN_SHIFT		6
+
+#define EUSB2_FORCE_VAL_5		0xED
+#define V_CLK_19P2M_EN			BIT(6)
+#define V_CLK_19P2M_EN_SHIFT		6
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
+#define to_qcom_eusb2_repeater(x) \
+	container_of((x), struct qcom_eusb2_repeater, repeater)
+
+struct qcom_eusb2_repeater_init_tbl {
+	unsigned int offset;
+	unsigned int val;
+};
+
+struct qcom_eusb2_repeater {
+	struct usb_repeater	repeater;
+	struct regmap		*regmap;
+	u16			base;
+	struct regulator_bulk_data *vregs;
+	const struct qcom_eusb2_repeater_cfg *cfg;
+};
+
+struct qcom_eusb2_repeater_cfg {
+	const struct qcom_eusb2_repeater_init_tbl *init_tbl;
+	int init_tbl_num;
+	/* regulators to be requested */
+	const char * const *vreg_list;
+	int num_vregs;
+};
+
+static const char * const pm8550b_vreg_l[] = {
+	"vdd18", "vdd3",
+};
+
+static const struct qcom_eusb2_repeater_init_tbl pm8550b_init_tbl[] = {
+	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_IUSB2, 0x8),
+	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_SQUELCH_U, 0x3),
+	QCOM_EUSB2_REPEATER_INIT_CFG(EUSB2_TUNE_USB2_PREEM, 0x5),
+};
+
+static const struct qcom_eusb2_repeater_cfg pm8550b_eusb2_cfg = {
+	.init_tbl	= pm8550b_init_tbl,
+	.init_tbl_num	= ARRAY_SIZE(pm8550b_init_tbl),
+	.vreg_list	= pm8550b_vreg_l,
+	.num_vregs	= ARRAY_SIZE(pm8550b_vreg_l),
+};
+
+static int qcom_eusb2_repeater_init_vregs(struct qcom_eusb2_repeater *rptr)
+{
+	int num = rptr->cfg->num_vregs;
+	struct device *dev = rptr->repeater.dev;
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
+static int qcom_eusb2_repeater_cfg_init(struct qcom_eusb2_repeater *rptr)
+{
+	const struct qcom_eusb2_repeater_init_tbl *init_tbl = rptr->cfg->init_tbl;
+	int num = rptr->cfg->init_tbl_num;
+	int i;
+
+	for (i = 0; i < num; i++)
+		regmap_update_bits(rptr->regmap, rptr->base + init_tbl[i].offset,
+					init_tbl[i].val, init_tbl[i].val);
+	return 0;
+}
+
+static int qcom_eusb2_repeater_init(struct usb_repeater *r)
+{
+	struct qcom_eusb2_repeater *rptr = to_qcom_eusb2_repeater(r);
+	int ret = 0;
+	u32 val;
+
+	qcom_eusb2_repeater_cfg_init(rptr);
+
+	if (r->flags & PHY_HOST_MODE) {
+		/*
+		 * CM.Lx is prohibited when repeater is already into Lx state as
+		 * per eUSB 1.2 Spec. Below implement software workaround until
+		 * PHY and controller is fixing seen observation.
+		 */
+		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_EN_5,
+				F_CLK_19P2M_EN, F_CLK_19P2M_EN);
+		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_VAL_5,
+				V_CLK_19P2M_EN, V_CLK_19P2M_EN);
+	} else {
+		/*
+		 * In device mode clear host mode related workaround as there
+		 * is no repeater reset available, and enable/disable of
+		 * repeater doesn't clear previous value due to shared
+		 * regulators (say host <-> device mode switch).
+		 */
+		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_EN_5,
+				F_CLK_19P2M_EN, 0);
+		regmap_update_bits(rptr->regmap, rptr->base + EUSB2_FORCE_VAL_5,
+				V_CLK_19P2M_EN, 0);
+	}
+
+	ret = regmap_read_poll_timeout(rptr->regmap, rptr->base + EUSB2_RPTR_STATUS, val,
+					val & RPTR_OK, 10, 5);
+	if (ret)
+		dev_err(r->dev, "initialization timed-out\n");
+
+	return ret;
+}
+
+static int qcom_eusb2_repeater_reset(struct usb_repeater *r, bool assert)
+{
+	struct qcom_eusb2_repeater *rptr = to_qcom_eusb2_repeater(r);
+
+	return regmap_update_bits(rptr->regmap, rptr->base + EUSB2_EN_CTL1,
+				EUSB2_RPTR_EN, assert ? EUSB2_RPTR_EN : 0x0);
+}
+
+static int qcom_eusb2_repeater_power_on(struct usb_repeater *r)
+{
+	struct qcom_eusb2_repeater *rptr = to_qcom_eusb2_repeater(r);
+
+	return regulator_bulk_enable(rptr->cfg->num_vregs, rptr->vregs);
+}
+
+static int qcom_eusb2_repeater_power_off(struct usb_repeater *r)
+{
+	struct qcom_eusb2_repeater *rptr = to_qcom_eusb2_repeater(r);
+
+	return regulator_bulk_disable(rptr->cfg->num_vregs, rptr->vregs);
+}
+
+static int qcom_eusb2_repeater_probe(struct platform_device *pdev)
+{
+	struct qcom_eusb2_repeater *rptr;
+	struct device *dev = &pdev->dev;
+	struct device_node *node;
+	u32 res;
+	int ret;
+
+	node = dev->of_node;
+
+	rptr = devm_kzalloc(dev, sizeof(*rptr), GFP_KERNEL);
+	if (!rptr)
+		return -ENOMEM;
+
+	rptr->repeater.dev = dev;
+	dev_set_drvdata(dev, rptr);
+
+	/* Get the specific init parameters of QMP phy */
+	rptr->cfg = of_device_get_match_data(dev);
+	if (!rptr->cfg)
+		return -EINVAL;
+
+	rptr->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!rptr->regmap)
+		return -ENXIO;
+
+	ret = of_property_read_u32(node, "reg", &res);
+	if (ret < 0)
+		return ret;
+
+	rptr->base = res;
+
+	ret = qcom_eusb2_repeater_init_vregs(rptr);
+	if (ret < 0) {
+		dev_err(dev, "unable to get supplies\n");
+		return ret;
+	}
+
+	rptr->repeater.init		= qcom_eusb2_repeater_init;
+	rptr->repeater.reset		= qcom_eusb2_repeater_reset;
+	rptr->repeater.power_on		= qcom_eusb2_repeater_power_on;
+	rptr->repeater.power_off	= qcom_eusb2_repeater_power_off;
+
+	return usb_add_repeater_dev(&rptr->repeater);
+}
+
+static int qcom_eusb2_repeater_remove(struct platform_device *pdev)
+{
+	struct qcom_eusb2_repeater *rptr = platform_get_drvdata(pdev);
+
+	if (!rptr)
+		return 0;
+
+	usb_remove_repeater_dev(&rptr->repeater);
+	qcom_eusb2_repeater_power_off(&rptr->repeater);
+	return 0;
+}
+
+static const struct of_device_id qcom_eusb2_repeater_id_table[] = {
+	{
+		.compatible = "qcom,pm8550b-eusb2-repeater",
+		.data = &pm8550b_eusb2_cfg,
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, qcom_eusb2_repeater_id_table);
+
+static struct platform_driver qcom_eusb2_repeater_driver = {
+	.probe		= qcom_eusb2_repeater_probe,
+	.remove		= qcom_eusb2_repeater_remove,
+	.driver = {
+		.name	= "qcom-pmic-eusb2-repeater",
+		.of_match_table = of_match_ptr(qcom_eusb2_repeater_id_table),
+	},
+};
+
+module_platform_driver(qcom_eusb2_repeater_driver);
+MODULE_DESCRIPTION("Qualcomm PMIC eUSB2 repeater driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

