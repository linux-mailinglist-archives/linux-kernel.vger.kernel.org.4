Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28465A48D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 14:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbiLaNIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 08:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbiLaNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 08:08:06 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A4263E9
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:08:04 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id 20so11028907plo.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 05:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0IXPVtq9K1twOTm6NDDEYDtsm5gy6I4CxkJN0usls4=;
        b=NPUExoCXn3bv8cVrXHBiUZJGue0soQHb0G96tLN0n+eLz1Y50SDNQycB5NyZt/PrWK
         I5k3uGeMmYGPn1HASohpdtr4BCdHvND+EgsZkkoIajo6b7Ztmme+b2k2ill/YfPT5Vgq
         EfCjIyK+VBql5cb4wXG3/pVmg0ymjASCkQQ4M1ZtolzRnpmqpwFzt+5hsu/as449mZEO
         6qQBkj9ToM7FtoEqQNAjSDdGT50UpqLY6z4xjbUuCGrcJKQXYbz7IBEcFYKsCMp4Yl+Y
         bT6BjZrOhtvlvJSlellsMcOE9bf4raX5DDV3/RIxUwn00hSGiHO/ZbLvDHkPGHNR9dTB
         ShOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0IXPVtq9K1twOTm6NDDEYDtsm5gy6I4CxkJN0usls4=;
        b=OHJp/yH6NhVRcQrg5aByplmTnwvVZwo5yLG4wOB0UgNo3t/CdnbbFlnbr9mN7NQvfs
         F3Hdm2pdze9A44Wv9UfZAqvSYQ9h4f1i/x/nsWIfjKQkOHnYEZyDOWJ+PPjURkAozL7K
         93l3vWePS1xGy5zM1m6POLIrKibDVRMDbSFcxAT0vfsvlj2ZaigbcwuvzKB08nIGyQs8
         d5y130NZsZbUDxMvnHsuffHBj7grjWf4QSbGtLmLZwz3XJZLtFLPY7bOA40duFb0EtDt
         bXwmJJT88JHYfyP0xD9f63w3qqM9b/vNUKo947gbd2Hxc+LYsuLOETyNsZ9yObJhTOPb
         EdQw==
X-Gm-Message-State: AFqh2kpvTLIBhs/QkWoU6/kidGTxVT13n1idJLH/lMMNeRf6c0HFxkPl
        RuwaTg/WHotPHNZpNVV90pnu9A==
X-Google-Smtp-Source: AMrXdXuqJjc0Lfay/2Vg+JTsADhCB4qlilRKlTowJFlv2eMMxqzXbSnqX9K3pDAVuk7FzJ9S2PurLg==
X-Received: by 2002:a17:90a:1bc7:b0:223:b680:d78b with SMTP id r7-20020a17090a1bc700b00223b680d78bmr36330841pjr.37.1672492083968;
        Sat, 31 Dec 2022 05:08:03 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:1c5e:e3b5:c341:16de:ce17:b857])
        by smtp.gmail.com with ESMTPSA id d7-20020a17090ab30700b0021904307a53sm14568161pjr.19.2022.12.31.05.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Dec 2022 05:08:03 -0800 (PST)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_schowdhu@quicinc.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org
Subject: [PATCH 2/2] usb: misc: eud: Add driver support for SM6115 / SM4250
Date:   Sat, 31 Dec 2022 18:37:43 +0530
Message-Id: <20221231130743.3285664-3-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221231130743.3285664-1-bhupesh.sharma@linaro.org>
References: <20221231130743.3285664-1-bhupesh.sharma@linaro.org>
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
 drivers/usb/misc/qcom_eud.c | 49 ++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

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

