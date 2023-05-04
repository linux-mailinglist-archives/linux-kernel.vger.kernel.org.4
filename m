Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4A66F677E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 10:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEDIal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 04:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjEDIaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 04:30:16 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086A86E9B
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 01:27:24 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-64115eef620so10641744b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683188843; x=1685780843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rC05tB6gG1w1yHT13tBk32ihblOOEZ5SfiKYI/IbjjQ=;
        b=IMfqygJFmeRRkLOeYT3j4HwKWtg+uVHGhi0RkKgfN0VDrkSrXNjAiMzxyNuxT7lRk3
         omG09lUyaFV8SHmUiIOjrpQOAQMFNeNinaLTneF5Tw4YAaORj6y18i8k2jOuAErzPNWX
         dRaBdX1Eu/gfwFymXJAFiruM3QVXLjslziE7B+8LTJ3dBMdxPAs43RuPWsuJDAy6Heb2
         Y9Nf639F72TqM2HzgLuzGoSWCmug7LLNzjCc6DwH+gi/OxM7KP3+JVLBfMSsjpGGAKnK
         iZb8kEGNRY6oTRF6e0UVq1LfJO+BXk3t+JWcJ5Q7GMtWmQmqAyFBYEZv3Hv/rxlMCB5V
         2UuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683188843; x=1685780843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rC05tB6gG1w1yHT13tBk32ihblOOEZ5SfiKYI/IbjjQ=;
        b=RfpZW1hnt+9ZkY+W8vEZtQHA5WfZUi8UfYo8XF75x6PQAk3KMdl6oMKmnDtI++OPsl
         jEHBbdx7S5H9t/fDaGn/AuzlOjh0eSlTW6k1DDVTIgpzSoGQh4C84fsDGvm0Wi3G2ZY9
         3lvYLtLCQ9yNNQmpQtkE1PMg1GUr3+DGyXUGnioWAeh3fSEmxWu5tA0HXPw5zHVZi+Lj
         kp66xMRQBPfjhGaffDiywhzZoYh31ZNDonA51xv/TMtVnelBiU3Drb99ZiW/uVouFw7b
         GkMiiHy7VMrCdBdaPzyi3Ka9EOeqDFqvu86PRYf/HeJDO0+Q7Q8mmQ2FowrAg7y+ih/6
         Jy6w==
X-Gm-Message-State: AC+VfDyiGSDqXE3X1wfps7tNui0aKR7VTWN3IH5ENePXIUvUThNq5opo
        Yct3X/FiWP3GnrIAIk2LXFwCtg==
X-Google-Smtp-Source: ACHHUZ4F+kqfr1zKvpCEgCXJESza+wXfDvl+Yo+sRVO2JxmTYIPLQXY41NZICDe7b7xHg+kFk7aAAg==
X-Received: by 2002:a05:6a00:4186:b0:62d:bf69:e9e0 with SMTP id ca6-20020a056a00418600b0062dbf69e9e0mr1406319pfb.17.1683188843143;
        Thu, 04 May 2023 01:27:23 -0700 (PDT)
Received: from localhost.localdomain ([223.233.65.180])
        by smtp.gmail.com with ESMTPSA id s1-20020a056a00178100b00625d84a0194sm24913973pfg.107.2023.05.04.01.27.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 01:27:22 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org
Subject: [PATCH v3 3/5] usb: misc: eud: Add driver support for SM6115 / SM4250
Date:   Thu,  4 May 2023 13:56:42 +0530
Message-Id: <20230504082644.1461582-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
References: <20230504082644.1461582-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.

On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
needs to be accessed only via the secure world (through 'scm'
calls).

Also, the enable bit inside 'tcsr_check_reg' needs to be set
first to set the eud in 'enable' mode on these SoCs.

Since this difference comes from how the firmware is configured, so
the driver now relies on the presence of an extra boolean DT property
to identify if secure access is needed.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/usb/misc/Kconfig    |  1 +
 drivers/usb/misc/qcom_eud.c | 66 ++++++++++++++++++++++++++++++++++---
 2 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index 99b15b77dfd5..fe1b5fec1dfc 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -147,6 +147,7 @@ config USB_APPLEDISPLAY
 config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	select USB_ROLE_SWITCH
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index b7f13df00764..b4736edcc64c 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -5,12 +5,14 @@
 
 #include <linux/bitops.h>
 #include <linux/err.h>
+#include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -30,15 +32,22 @@
 #define EUD_INT_SAFE_MODE	BIT(4)
 #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
 
+struct eud_soc_cfg {
+	u32 tcsr_check_offset;
+};
+
 struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
+	const struct eud_soc_cfg	*eud_cfg;
 	void __iomem			*base;
 	void __iomem			*mode_mgr;
 	unsigned int			int_status;
 	int				irq;
 	bool				enabled;
 	bool				usb_attached;
+	bool				secure_mode_enable;
+	phys_addr_t			secure_mode_mgr;
 };
 
 static int enable_eud(struct eud_chip *priv)
@@ -46,7 +55,11 @@ static int enable_eud(struct eud_chip *priv)
 	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
 	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
 			priv->base + EUD_REG_INT1_EN_MASK);
-	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	if (priv->secure_mode_mgr)
+		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, BIT(0));
+	else
+		writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
 
 	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
 }
@@ -54,7 +67,11 @@ static int enable_eud(struct eud_chip *priv)
 static void disable_eud(struct eud_chip *priv)
 {
 	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
-	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	if (priv->secure_mode_mgr)
+		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, 0);
+	else
+		writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
 }
 
 static ssize_t enable_show(struct device *dev,
@@ -178,12 +195,15 @@ static void eud_role_switch_release(void *data)
 static int eud_probe(struct platform_device *pdev)
 {
 	struct eud_chip *chip;
+	struct resource *res;
+	phys_addr_t tcsr_base, tcsr_check;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
+
 	chip->dev = &pdev->dev;
 
 	chip->role_sw = usb_role_switch_get(&pdev->dev);
@@ -200,9 +220,40 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
-	if (IS_ERR(chip->mode_mgr))
-		return PTR_ERR(chip->mode_mgr);
+	chip->secure_mode_enable = of_property_read_bool(chip->dev->of_node,
+						"qcom,secure-mode-enable");
+	/*
+	 * EUD block on a few Qualcomm SoCs need secure register access.
+	 * Check for the same.
+	 */
+	if (chip->secure_mode_enable) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res)
+			return dev_err_probe(chip->dev, -ENODEV,
+					     "failed to get secure_mode_mgr reg base\n");
+
+		chip->secure_mode_mgr = res->start;
+	} else {
+		chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
+		if (IS_ERR(chip->mode_mgr))
+			return PTR_ERR(chip->mode_mgr);
+	}
+
+	/* Check for any SoC specific config data */
+	chip->eud_cfg = of_device_get_match_data(&pdev->dev);
+	if (chip->eud_cfg) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		if (!res)
+			return dev_err_probe(chip->dev, -ENODEV,
+					     "failed to get tcsr reg base\n");
+
+		tcsr_base = res->start;
+		tcsr_check = tcsr_base + chip->eud_cfg->tcsr_check_offset;
+
+		ret = qcom_scm_io_writel(tcsr_check, BIT(0));
+		if (ret)
+			return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
+	}
 
 	chip->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
@@ -230,8 +281,13 @@ static int eud_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct eud_soc_cfg sm6115_eud_cfg = {
+	.tcsr_check_offset = 0x25018,
+};
+
 static const struct of_device_id eud_dt_match[] = {
 	{ .compatible = "qcom,sc7280-eud" },
+	{ .compatible = "qcom,sm6115-eud", .data = &sm6115_eud_cfg },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, eud_dt_match);
-- 
2.38.1

