Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4935168D9F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:57:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbjBGN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbjBGN4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:56:44 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AD43A856
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:56:17 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o18so13638736wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:56:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5nP2A5i34h6FhI1PmIGZwHqThelkL340fyNZ8uWjSxo=;
        b=VdzEKUA+I7BR/04OKzVJQzQLbpCpYeLoYwT+7MbmJwBzCXC8/Wz9dBXpicw1nu5t7K
         wPcXLo7jpe4VQnBgW6nM+ByBemVBAgt747KHH8XpV1yCtZedPB9s2ntVMAlVkvVOzGWJ
         bVhhWQkLCxPhB3zAJgXi57guzJWqe/gdNWLZsd5Ar9hLs6L+4zD4vJZmPsiJL4YvGWNq
         UgeGd21VezuELwjDjCuqUxM+GVIdrj1AOeIq5D98I4RmPqJ50zwKPFC9dqlitzTy/ZlT
         QHieExN+/CjvvdfwBMdpxpLH12Cu9I8mf7kbPFi47Px4LXJSY89ahz2E/hl6kkUiGyUl
         JyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nP2A5i34h6FhI1PmIGZwHqThelkL340fyNZ8uWjSxo=;
        b=qpfHA9XTOUkpBbNIVo8taDdKrTu2JSBi+r4vrhJCZTIAEdNDy2AfEikNl88DzRfXTn
         jPzECSRETorpkocR7qj6tjko1lZOIAsp9yvfzOzUUthvJFdmnXaDCI/INx8MrM4+6ekv
         OiqpuKRjUuccs0D+c/BajbhRtE0m5bIanLmXTRSNpqfMwz8aoL2yYeGlMoWOT00WqpU3
         m9N2TlLhWd8AV6/yiQSkKAaiJXkAh31BdEj5zS/Rfk+N0HQSZK7KK7DKeXMNW4AC14Gu
         agGuQIacfPRcsiTS4V8pe2BFhAb6fOrB+z+0NYtPlu8xSjt3lPQG5Eu1J8Sq/bbKUPIP
         ht1w==
X-Gm-Message-State: AO0yUKXER8+At+G6+UBquyzOiz1CmaK3LNYLA+6v5tb64FmdKmyrSxwZ
        3w6BV+ujY6NT8CXXbDl72IJmNA==
X-Google-Smtp-Source: AK7set+L3zQVDlpG8ELGNddTYFVEar45muQRLY/0lkqS/38deLKHfGuV5eXNxsjES2KHz4jIs6x/Zg==
X-Received: by 2002:adf:f3cc:0:b0:2c3:ea59:a8b with SMTP id g12-20020adff3cc000000b002c3ea590a8bmr2878259wrp.24.1675778161731;
        Tue, 07 Feb 2023 05:56:01 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a5d59aa000000b002be5401ef5fsm11611312wrr.39.2023.02.07.05.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:56:01 -0800 (PST)
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
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v4 5/7] phy: qcom: phy-qcom-snps-eusb2: Add support for eUSB2 repeater
Date:   Tue,  7 Feb 2023 15:55:49 +0200
Message-Id: <20230207135551.1418637-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230207135551.1418637-1-abel.vesa@linaro.org>
References: <20230207135551.1418637-1-abel.vesa@linaro.org>
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

The v3 (rfc) is here:
https://lore.kernel.org/all/20230202133816.4026990-6-abel.vesa@linaro.org/

Changes since v3:
 * none

 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
index 23ec162cc3bd..703e2f23ea00 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
@@ -128,6 +128,8 @@ struct qcom_snps_eusb2_hsphy {
 	struct regulator_bulk_data vregs[EUSB2_NUM_VREGS];
 
 	enum phy_mode mode;
+
+	struct phy *repeater;
 };
 
 static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int submode)
@@ -136,7 +138,7 @@ static int qcom_snps_eusb2_hsphy_set_mode(struct phy *p, enum phy_mode mode, int
 
 	phy->mode = mode;
 
-	return 0;
+	return phy_set_mode_ext(phy->repeater, mode, submode);
 }
 
 static void qcom_snps_eusb2_hsphy_write_mask(void __iomem *base, u32 offset,
@@ -235,6 +237,12 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
 	if (ret)
 		return ret;
 
+	ret = phy_init(phy->repeater);
+	if (ret) {
+		dev_err(&p->dev, "repeater init failed. %d\n", ret);
+		goto disable_vreg;
+	}
+
 	ret = clk_prepare_enable(phy->ref_clk);
 	if (ret) {
 		dev_err(&p->dev, "failed to enable ref clock, %d\n", ret);
@@ -342,6 +350,8 @@ static int qcom_snps_eusb2_hsphy_exit(struct phy *p)
 
 	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
 
+	phy_exit(phy->repeater);
+
 	return 0;
 }
 
@@ -355,6 +365,7 @@ static const struct phy_ops qcom_snps_eusb2_hsphy_ops = {
 static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct qcom_snps_eusb2_hsphy *phy;
 	struct phy_provider *phy_provider;
 	struct phy *generic_phy;
@@ -386,6 +397,12 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "failed to get regulator supplies\n");
+
+	phy->repeater = devm_of_phy_get_by_index(dev, np, 0);
+	if (IS_ERR(phy->repeater))
+		return dev_err_probe(dev, PTR_ERR(phy->repeater),
+				     "failed to get repeater\n");
+
 	generic_phy = devm_phy_create(dev, NULL, &qcom_snps_eusb2_hsphy_ops);
 	if (IS_ERR(generic_phy)) {
 		dev_err(dev, "failed to create phy %d\n", ret);
-- 
2.34.1

