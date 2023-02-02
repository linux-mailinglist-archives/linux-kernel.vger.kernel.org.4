Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392C1687EE0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 14:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjBBNiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 08:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232528AbjBBNik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 08:38:40 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781DC8BDEB
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 05:38:34 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso1405344wmq.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 05:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Muj0r5cS4dp6xC+TSUuMKKW1WBd70kMvR15aSo0LNU=;
        b=GuFGabF19GTVDUCzru/UnbKSvOS9B/ICt6k9ACww5VSGO3p0hFqaTrHma6/TGzYSoN
         NYiaq9tSFPdR9ThkGaW4oVbEVxekMtXvSDApd4/FFjMJh2b+FhR+M1BINi/SkWKb6rTb
         GmDUxS9r7WTuunBrDRWhQ2bzAsaznuZO36UZahYbZpexZyfWnasIOdmx6YaG6a5qFb+r
         xREZc3YRSB1vhAz2fyZpLG6yMgBnxgEUUlvEkG/xguXU2a1LCffINx5jEbRYWHl7mvsF
         YhpcSYiKOsBKpDNubjWgVPgGlLczGa9iDzFVTNWgdHjNUFKdP5QLAkUz5QMk61ApNb1T
         SWvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Muj0r5cS4dp6xC+TSUuMKKW1WBd70kMvR15aSo0LNU=;
        b=cQ5pbbmnmZLsbXHb6SNUJNYLeQACVUFuAZ5Loxb0YnIg0OeoSSYUOau+ya7wOpGVf1
         UhvaSVCjB2WahMbhcA1vNnptquvCVrhPKHwhErr1ZgLvSvcEHwgfW8suSdV+v2t+Irkk
         V3GkUM6ByMJY928g4xMT/vJBMg5a6m952to4mKUq3wC2ZXplfg+pWH45J+ocQO4ORv4P
         5CSVWtemiA8Y1u+1UP/7gO1pkNApfqDOcBpHIe0BgVTl4s6RaXfU3lHFCvZg63yKeXTI
         3DuDemQ4W1OWUN+YHKZFpzSD0PbeIsw2+7SWIjoAbxVk6KpZoIko+TSkhrGf5SIaRKyW
         LMAg==
X-Gm-Message-State: AO0yUKUedJjsmEZWR00ywspaAjwBT0pYY1OlZUPSnwV8qtfsSBaQIt4a
        0DvsUCadYwwffdqUDPLUM768vQ==
X-Google-Smtp-Source: AK7set8R4MkWRBydiDyX6RpsFozs0TBOeL0BRfzRO4g6tMz1cuywexaGfc1xJsDWiBomfrRoXqdnBA==
X-Received: by 2002:a05:600c:6018:b0:3dc:1ad6:55fd with SMTP id az24-20020a05600c601800b003dc1ad655fdmr5936251wmb.32.1675345112971;
        Thu, 02 Feb 2023 05:38:32 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id y10-20020a05600c364a00b003daf7721bb3sm4672657wmq.12.2023.02.02.05.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 05:38:32 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-phy@lists.infradead.org,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [RFC v3 5/7] phy: qcom: phy-qcom-snps-eusb2: Add support for eUSB2 repeater
Date:   Thu,  2 Feb 2023 15:38:14 +0200
Message-Id: <20230202133816.4026990-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230202133816.4026990-1-abel.vesa@linaro.org>
References: <20230202133816.4026990-1-abel.vesa@linaro.org>
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
 drivers/phy/qualcomm/phy-qcom-snps-eusb2.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c b/drivers/phy/qualcomm/phy-qcom-snps-eusb2.c
index 23ec162cc3bd..8d972d49732b 100644
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
 
@@ -386,6 +396,12 @@ static int qcom_snps_eusb2_hsphy_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "failed to get regulator supplies\n");
+
+	phy->repeater = devm_phy_get(dev, "eusb2-repeater");
+	if (IS_ERR(phy->repeater))
+		return dev_err_probe(dev, PTR_ERR(phy->repeater),
+				     "failed to get repeater\n");
+
 	generic_phy = devm_phy_create(dev, NULL, &qcom_snps_eusb2_hsphy_ops);
 	if (IS_ERR(generic_phy)) {
 		dev_err(dev, "failed to create phy %d\n", ret);
-- 
2.34.1

