Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9369968F7B3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjBHTCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:02:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjBHTCN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:02:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E435456F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:02:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id z13so6570027wmp.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShO1VuIPcxLsmNvvc1MJjr+D91aZx/r3YaXr8Ck2/Xw=;
        b=Pffd+NUYTrdBf6OS/zrimTzpSsxUK9Oa4UsLrjTAjpf2uuOj4L+VNOJ4/ijSQWN8YT
         6ZGlL1km2QAkS6w4WGxlpWv0o6s50r+tgNT/eBm+1BL3LStetLpt5yQnw8CoEuiD2WvL
         SgdsjBkan4mfH/dMfRjfWu2oK2xJqFNtmEACqA8cT2jp18UqiVd0fW/Prnm1FtO/Ppcn
         2KMk2nFNlBTIeYxn+Hc/VTZMx6BFmYDMXv8Szhbk9E3kUYlN1s/pV7QhrcsNU2Q24bIO
         hrBFAiXAKO/0BbX/lcxsI2AA4w7D/7pbQZvW3z4cf9PufZXfOEjlVP8hszR5BzM6i6QJ
         HIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ShO1VuIPcxLsmNvvc1MJjr+D91aZx/r3YaXr8Ck2/Xw=;
        b=CFpa6ki2xp9LS7gvnCupmp5swzsjNx1MvUF2g1MShonxRK+jr4baIGBd01AJNokVeR
         jM8WhYJuJ/46Nc66ftDHDKjFiu7m8Pekn/ggAwu5vLFxlYAmkHG0OjTwMlMt/9mooQla
         arF7T38HcLTDktdjyFiGbP4Cz4bYICB5jApD/BAROFUwu6S5rf9sC8+3b9k7CIE+He2+
         ZyEMS6VP0EZmdjxoU9VXP/NlFLBWn7p7hmLf8tROtOMGfX3VuKWFzC0PnJKCVa/YR7ZG
         NKi/p6SGJ20Fm40Z1jqOPdld4SNt+Bp7ylWsfN65kXOd9Pz0o1XtdX7xbLsI/5sFqJYA
         GPWw==
X-Gm-Message-State: AO0yUKUeFnbEhr2yA0+ORMGDwPYFG3VMFaMJN1SiLigRV/feMsn5FFLk
        rJ9CnJAxcizjnP7uGz0hD4QOFw==
X-Google-Smtp-Source: AK7set8TMXWqK2emgHpNgwZVvuPtioeiotnNbzEk64A7LpqsiUOM53RVUUxR5LeWNdGd7EZdt4p8Xw==
X-Received: by 2002:a05:600c:2b46:b0:3df:12ac:7cc9 with SMTP id e6-20020a05600c2b4600b003df12ac7cc9mr7718676wmf.15.1675882931691;
        Wed, 08 Feb 2023 11:02:11 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id n16-20020a1c7210000000b003dc1d668866sm2650327wmc.10.2023.02.08.11.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 11:02:11 -0800 (PST)
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
Subject: [PATCH v5 5/7] phy: qcom: phy-qcom-snps-eusb2: Add support for eUSB2 repeater
Date:   Wed,  8 Feb 2023 21:01:58 +0200
Message-Id: <20230208190200.2966723-6-abel.vesa@linaro.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

For USB 2.0 compliance, eUSB2 needs a repeater. The PHY needs to
initialize and reset it. So add repeater support

Co-developed-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---

The v4 is here:
https://lore.kernel.org/all/20230207135551.1418637-6-abel.vesa@linaro.org/

Changes since v4:
 * none

Changes since v3:
 * none

 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
index 40a421cf3dd9..ca1cfa53d90d 100644
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
@@ -234,6 +236,12 @@ static int qcom_snps_eusb2_hsphy_init(struct phy *p)
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
@@ -341,6 +349,8 @@ static int qcom_snps_eusb2_hsphy_exit(struct phy *p)
 
 	regulator_bulk_disable(ARRAY_SIZE(phy->vregs), phy->vregs);
 
+	phy_exit(phy->repeater);
+
 	return 0;
 }
 
@@ -354,6 +364,7 @@ static const struct phy_ops qcom_snps_eusb2_hsphy_ops = {
 static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
 	struct qcom_snps_eusb2_hsphy *phy;
 	struct phy_provider *phy_provider;
 	struct phy *generic_phy;
@@ -385,6 +396,12 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
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

