Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE0662BD2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 13:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiKPMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 07:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiKPMHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 07:07:43 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F4418374
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:13 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso2930708wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUtf3C2ksBbvfzIaOIaKX58DNV9jeGzhpCM3Ny/zr3U=;
        b=e5n4nBklX5Iiqsx6kpUPhyZxhS00j53WfDrZBv2hrpk2TmMXA9iRGk5CDY8OV4Dcrg
         9l1ErAfJqCw4CO3OTt+T7CTu+wjKIRWpfnLq0WnaN8vm5OerwTjir0+Hc4FNMjZvh5oS
         hqIiQhzOGFUU9CqqncfVUbMJuXA12xf3aKcbRxufTlOmFgN38mqoGbqkQyiCplZoRt32
         EALfIC3ONCa4HUEm8B0BiY4OXBCesDymm3vJ0RaxKmQr1YduJHXgPgvUg8hzPm+xrYQq
         ofeQ6VZJJXrHD8ey36lF1gKUuRMGqbHOZAHNAYeiV2S/QSAayJMymSUB70d1fcogYDUb
         7Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fUtf3C2ksBbvfzIaOIaKX58DNV9jeGzhpCM3Ny/zr3U=;
        b=cuKD2J9yUStW++0C2j/gEbO5tBbnwgeBc47wPgFFJdBUCS/vOT6kySfGybN1n1IaE/
         pZFaONEdgkQVoFDq+BcX975y5OHErQbKSJsDIo7OWe9IbXtLOxr9rCyRIcR301OU0bGI
         JAZE0E/d16JE2bVhCGhsheaSicynLVgs6OYf23h/NsWuDaFI5/n2mYvnrLglZNkfF/ao
         M/i5i9to/lehEiw+g2tqK1MxGCVd3iNofc4kzUD7BsuSEaospLWdsGVfZx0W9n3QgBW5
         0XFAZDVXdEJKLQqh8+kIAfYhgXHVkly01+C3KBahNjlT8WVeFV/VDjfxScPgd647Xahm
         qtDA==
X-Gm-Message-State: ANoB5pmf+cfkSAx/bQ22nyAfBA3fWzmUA8lIH7J3gUvhNpZmseGuSj1Y
        BYNWg+5RV0Mp4rY5geKp4mi9OOe+42pO1g==
X-Google-Smtp-Source: AA0mqf4meWqOJc601nNZH4xS8Bsb3vR2BsVZXEudb+jRGR88kf8EdA1OeUJzvCsCNOBn9lD3OBTv/w==
X-Received: by 2002:a05:600c:2e51:b0:3cf:6e9b:21f1 with SMTP id q17-20020a05600c2e5100b003cf6e9b21f1mr1893472wmf.90.1668600133083;
        Wed, 16 Nov 2022 04:02:13 -0800 (PST)
Received: from localhost.localdomain ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id r8-20020a056000014800b002206203ed3dsm15120109wrx.29.2022.11.16.04.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 04:02:12 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 10/10] phy: qualcomm: phy-qcom-snps-eusb2: Add support for eUSB2 repeater
Date:   Wed, 16 Nov 2022 14:01:57 +0200
Message-Id: <20221116120157.2706810-11-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221116120157.2706810-1-abel.vesa@linaro.org>
References: <20221116120157.2706810-1-abel.vesa@linaro.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

For USB 2.0 compliance, eUSB2 needs a repeater. The PHY needs to
initialize and reset it. So add repeater support

Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 39 ++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
index 1bb42ec14703..921502ffc55b 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
@@ -16,6 +16,8 @@
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
+#include <linux/usb/repeater.h>
+
 
 #define USB_PHY_UTMI_CTRL0		(0x3c)
 #define SLEEPM				BIT(0)
@@ -135,6 +137,8 @@ struct qcom_snps_eusb2_hsphy {
 	struct regulator_bulk_data vregs[EUSB2_NUM_VREGS];
 
 	enum phy_mode mode;
+
+	struct usb_repeater *repeater;
 };
 
 static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int submode)
@@ -231,6 +235,28 @@ static int qcom_eusb2_ref_clk_init(struct qcom_snps_eusb2_hsphy *phy)
 	return 0;
 }
 
+static int qcom_snps_eusb2_hsphy_repeater_reset_and_init(struct qcom_snps_eusb2_hsphy *phy)
+{
+	struct device *dev = &phy->phy->dev;
+	int ret;
+
+	/* TOFIX set mode, default to device */
+
+	ret = usb_repeater_power_on(phy->repeater);
+	if (ret)
+		dev_err(dev, "repeater power on failed.\n");
+
+	ret = usb_repeater_reset(phy->repeater, true);
+	if (ret)
+		dev_err(dev, "repeater reset failed.\n");
+
+	ret = usb_repeater_init(phy->repeater);
+	if (ret)
+		dev_err(dev, "repeater init failed.\n");
+
+	return ret;
+}
+
 static int qcom_snps_eusb2_hsphy_init(struct phy *p)
 {
 	struct qcom_snps_eusb2_hsphy *phy = phy_get_drvdata(p);
@@ -240,6 +266,11 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
 	if (ret)
 		return ret;
 
+	/* Bring eUSB2 repeater out of reset and initialized before eUSB2 PHY */
+	ret = qcom_snps_eusb2_hsphy_repeater_reset_and_init(phy);
+	if (ret)
+		goto disable_vreg;
+
 	ret = clk_prepare_enable(phy->ref_clk);
 	if (ret) {
 		dev_err(&p->dev, "failed to enable ref clock, %d\n", ret);
@@ -347,6 +378,8 @@ static int qcom_snps_eusb2_hsphy_exit(struct phy *p)
 
 	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
 
+	usb_repeater_power_off(phy->repeater);
+
 	return 0;
 }
 
@@ -391,6 +424,12 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "failed to get regulator supplies\n");
+
+	phy->repeater = devm_usb_get_repeater_by_phandle(dev, "usb-repeater", 0);
+	if (IS_ERR(phy->repeater))
+		return dev_err_probe(dev, PTR_ERR(phy->repeater),
+				     "failed to get repeater\n");
+
 	generic_phy = devm_phy_create(dev, NULL, &qcom_snps_eusb2_hsphy_ops);
 	if (IS_ERR(generic_phy)) {
 		dev_err(dev, "failed to create phy %d\n", ret);
-- 
2.34.1

