Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971E765C2B2
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 16:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237920AbjACPFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 10:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237944AbjACPEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 10:04:51 -0500
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F2E11A0C
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 07:04:50 -0800 (PST)
Received: by mail-pl1-x62b.google.com with SMTP id y19so13806048plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N13vpL6q9P0WudTM1gFfahAVjoJ4UnTdBTjpXvHDPN4=;
        b=fAhuk6kMp791OWqVdI0FD/kqqSvppMpzbLNlO8XgrHygfFi+VOJiX6JfcTBC4UZ9dG
         kPCbEGi9xotF2PfePRt9GR7ZsNe43J0DY6xqF2dzRgmBcNqbX/dsH3bj1iN8VbBLXy69
         nE0WwAn/6EC0ht2IPyIE+L+JG+KYmyhqcDAdiW773VASGgZAVEw8mIECSZm7/DY9lby1
         Y4f1Ao0hfkuMOGK+YSGKvn+aNqoKQoQ1bv+SvAWrW+On4kH5MSTbbWhRGDc/RVs3eMqm
         EVxBaTsX0n+YptQmI7YtFUH4dOK8EN1O/kxzz8bLw40cdNAYI+Pd6hQ7SEnRAzQnFkZA
         tffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N13vpL6q9P0WudTM1gFfahAVjoJ4UnTdBTjpXvHDPN4=;
        b=duGGmO8vbQYTZSVqEYb/OamYCk3l8qBneqJNxnUNOuB2T4W9f3p5XB7Hg+CxKr7/QM
         XAzJa5lOX12Vsvuympb+Qo3/BjpzEUSWuWpkLDDmfLuaM1AHNUauEqCYsS7NnNvRP31c
         qYcX5sjvkO689SD7vNJkhR6/4SSd9UWP9UF+BBj/nU54MGzcPrah8HZyu5BemZqKTgpE
         EV5LFE5q3e++Xk6JQLJNk5XPV3cEadM3N3q5sHTS5clCUWS6IvayCUE4BA24xBOsIv7N
         cYWGWjLHnQzyX4DyAIli1ElmH6ITwPyi5AXZe90d2WNEXGh3bIx6zS8LiDrim/JszLOC
         lCbA==
X-Gm-Message-State: AFqh2kq43iZgmQMTuqpvhKFWuQFRJ1XDAZMc9GEyG1kSxOs95SZz67SH
        Ev0w5nvi4G+QsxXjji/9Z/xtpw==
X-Google-Smtp-Source: AMrXdXu/v7kZRf/c0WyJrK50QNP+TUaXV7Kd2o6twyvDsRq1+UHAWhoNwU9BGEPmL6OajdvAk7vVlg==
X-Received: by 2002:a17:90a:8a08:b0:223:3642:f74f with SMTP id w8-20020a17090a8a0800b002233642f74fmr53242910pjn.0.1672758289750;
        Tue, 03 Jan 2023 07:04:49 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a0f0800b0021952b5e9bcsm20952300pjy.53.2023.01.03.07.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 07:04:49 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: [PATCH v2 2/2] usb: misc: eud: Add driver support for SM6115 / SM4250
Date:   Tue,  3 Jan 2023 20:34:19 +0530
Message-Id: <20230103150419.3923421-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230103150419.3923421-1-bhupesh.sharma@linaro.org>
References: <20230103150419.3923421-1-bhupesh.sharma@linaro.org>
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

Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.

On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
needs to be accessed only via the secure world (through 'scm'
calls).

Also, the enable bit inside 'tcsr_check_reg' needs to be set
first to set the eud in 'enable' mode on these SoCs.

Cc: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/usb/misc/Kconfig    |  1 +
 drivers/usb/misc/qcom_eud.c | 49 ++++++++++++++++++++++++++++++++++---
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
index a5f7652db7da1..ed4ae32ff1577 100644
--- a/drivers/usb/misc/Kconfig
+++ b/drivers/usb/misc/Kconfig
@@ -140,6 +140,7 @@ config USB_APPLEDISPLAY
 config USB_QCOM_EUD
 	tristate "QCOM Embedded USB Debugger(EUD) Driver"
 	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	select USB_ROLE_SWITCH
 	help
 	  This module enables support for Qualcomm Technologies, Inc.
diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
index b7f13df007646..a96ca28a4899b 100644
--- a/drivers/usb/misc/qcom_eud.c
+++ b/drivers/usb/misc/qcom_eud.c
@@ -11,7 +11,9 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/qcom_scm.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
 #include <linux/usb/role.h>
@@ -30,15 +32,24 @@
 #define EUD_INT_SAFE_MODE	BIT(4)
 #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
 
+struct eud_soc_data {
+	bool secure_eud_en;
+	bool tcsr_check_enable;
+};
+
 struct eud_chip {
 	struct device			*dev;
 	struct usb_role_switch		*role_sw;
+	const struct eud_soc_data	*eud_data;
 	void __iomem			*base;
 	void __iomem			*mode_mgr;
 	unsigned int			int_status;
 	int				irq;
 	bool				enabled;
 	bool				usb_attached;
+	phys_addr_t			mode_mgr_phys_base;
+	phys_addr_t			tcsr_check_phys_base;
+
 };
 
 static int enable_eud(struct eud_chip *priv)
@@ -46,7 +57,11 @@ static int enable_eud(struct eud_chip *priv)
 	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
 	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
 			priv->base + EUD_REG_INT1_EN_MASK);
-	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	if (priv->eud_data->secure_eud_en)
+		qcom_scm_io_writel(priv->mode_mgr_phys_base + EUD_REG_EUD_EN2, BIT(0));
+	else
+		writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
 
 	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
 }
@@ -54,7 +69,11 @@ static int enable_eud(struct eud_chip *priv)
 static void disable_eud(struct eud_chip *priv)
 {
 	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
-	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
+
+	if (priv->eud_data->secure_eud_en)
+		qcom_scm_io_writel(priv->mode_mgr_phys_base + EUD_REG_EUD_EN2, 0);
+	else
+		writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
 }
 
 static ssize_t enable_show(struct device *dev,
@@ -178,12 +197,15 @@ static void eud_role_switch_release(void *data)
 static int eud_probe(struct platform_device *pdev)
 {
 	struct eud_chip *chip;
+	struct resource *res;
 	int ret;
 
 	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
 	if (!chip)
 		return -ENOMEM;
 
+	chip->eud_data = of_device_get_match_data(&pdev->dev);
+
 	chip->dev = &pdev->dev;
 
 	chip->role_sw = usb_role_switch_get(&pdev->dev);
@@ -200,10 +222,25 @@ static int eud_probe(struct platform_device *pdev)
 	if (IS_ERR(chip->base))
 		return PTR_ERR(chip->base);
 
-	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
+	chip->mode_mgr = devm_platform_get_and_ioremap_resource(pdev, 1, &res);
 	if (IS_ERR(chip->mode_mgr))
 		return PTR_ERR(chip->mode_mgr);
 
+	if (chip->eud_data->secure_eud_en)
+		chip->mode_mgr_phys_base = res->start;
+
+	if (chip->eud_data->tcsr_check_enable) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		if (!res)
+			return dev_err_probe(chip->dev, -ENODEV, "failed to get tcsr reg base\n");
+
+		chip->tcsr_check_phys_base = res->start;
+
+		ret = qcom_scm_io_writel(chip->tcsr_check_phys_base, BIT(0));
+		if (ret)
+			return dev_err_probe(chip->dev, ret, "failed to write tcsr check reg\n");
+	}
+
 	chip->irq = platform_get_irq(pdev, 0);
 	ret = devm_request_threaded_irq(&pdev->dev, chip->irq, handle_eud_irq,
 			handle_eud_irq_thread, IRQF_ONESHOT, NULL, chip);
@@ -230,8 +267,14 @@ static int eud_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct eud_soc_data sm6115_eud_data = {
+	.secure_eud_en = true,
+	.tcsr_check_enable = true,
+};
+
 static const struct of_device_id eud_dt_match[] = {
 	{ .compatible = "qcom,sc7280-eud" },
+	{ .compatible = "qcom,sm6115-eud", .data = &sm6115_eud_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, eud_dt_match);
-- 
2.38.1

