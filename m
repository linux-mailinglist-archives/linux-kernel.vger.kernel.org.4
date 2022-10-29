Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483F56123CF
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 16:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiJ2OTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 10:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJ2OTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 10:19:10 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA3E606B9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:17:58 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id 4so7238579pli.0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA1mdQkW8ZFv3N05jSZ2baoyd62Af6cc4kAWConR55k=;
        b=uVOTT/IfQPHX18OKK/tWoh/nW0c3SJwcF4q5KyQwK31c6nbH4FI1Xh3UrcSzU4dqmT
         PluskZ9hsbmVJaD17yX8SyUrwWG7Xuy2CY+6GP4w/m3/y4MoFoP2XjOVhB4PSQdd0usC
         xGvcfcJnVhHsFXuexudY3C6DkrDs9Fae0NlctauNlSC/+ORmpu4YXDxTf5ZGc390C6s9
         6yR5JJbT8zhY0PRd5AZIz/D4+qdXPrPdsJWKYmo50APoUfnPPR8RywD0LqH6dMBNVC3I
         M/DhpBd95GIxDanOjM/O/4cGKgT3NzWNoQXvqVR/PFEGfGQnbHlx/mWCHr1wfjmOntfM
         mMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UA1mdQkW8ZFv3N05jSZ2baoyd62Af6cc4kAWConR55k=;
        b=rOssC97LHTxImij9iblcB9WXw4Q9XcC6FsROHRnkpW/6h74mg3EVT1SdRPBhGy/2qn
         KwGaRsqETJtaHCRnVEIkLdgpXkyqaVD9xrbE0LGb44OVJaJcQhDc7s4l2XPmvmcBjV8M
         mLafxmu4JfLLXa3epy9yTYbtfJjmjhNc2VINUbaWP5LtdhnQ9yN2BfM3Ew728IxYBVA9
         UknzfIANJk9nUFJfPotAmzKpyVdS24DWQWFsNHFscl7jQYYdkpMR0Gyiskw87Dwwi2/H
         be31AQGjY0lA7WLRRLrfpc+xU1UpEyHSGwSP2jxoFaOMjaYv+MMMLu3BFUZxfVuS6jQ8
         lr8A==
X-Gm-Message-State: ACrzQf2d0XpeajdVJDvyDrjULVdgNifa7lbBejfYYhn7HdwDupjpbBDh
        /jZgy6WqS30syQ9d+8rSm2je
X-Google-Smtp-Source: AMsMyM6sHijl68AyyAlPRXWdU9gGp0tnoQyErmyddcFZ6odh5m2JCptMlgcFostaj4rjj+APxfAQoA==
X-Received: by 2002:a17:902:e8c4:b0:186:6d63:7e with SMTP id v4-20020a170902e8c400b001866d63007emr4688354plg.122.1667053077585;
        Sat, 29 Oct 2022 07:17:57 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.18])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001866049ddb1sm1370157plf.161.2022.10.29.07.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 07:17:56 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 14/15] scsi: ufs: ufs-qcom: Add support for finding HS gear on new UFS versions
Date:   Sat, 29 Oct 2022 19:46:32 +0530
Message-Id: <20221029141633.295650-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
References: <20221029141633.295650-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
controller/PHY can be configured to run in two gear speeds). But that
requires an agreement between the UFS controller and the UFS device.
This commit finds the max gear supported by both controller and device
then decides which one to use.

UFS controller's max gear can be read from the REG_UFS_PARAM0 register and
UFS device's max gear can be read from the "max-gear" devicetree property.

The UFS PHY also needs to be configured with the decided gear using the
phy_set_mode_ext() API.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 35 ++++++++++++++++++++++++++++++++---
 drivers/ufs/host/ufs-qcom.h |  4 ++++
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index f952cc76919f..268463e92d67 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -281,6 +281,9 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct device *dev = hba->dev;
+	u32 max_gear, hcd_max_gear, reg;
+	int ret;
 
 	if (host->hw_ver.major == 0x1) {
 		/*
@@ -292,8 +295,33 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
 		 */
 		if (hs_gear > UFS_HS_G2)
 			return UFS_HS_G2;
+	} else if (host->hw_ver.major > 0x3) {
+		/*
+		 * Starting from UFS controller v4, Qcom supports dual gear mode (i.e., the
+		 * controller/PHY can be configured to run in two gear speeds). But that
+		 * requires an agreement between the UFS controller and the device. Below
+		 * code tries to find the max gear of both and decides which gear to use.
+		 *
+		 * First get the max gear supported by the UFS device if available.
+		 * If the property is not defined in devicetree, then use the default gear.
+		 */
+		ret = of_property_read_u32(dev->of_node, "max-gear", &max_gear);
+		if (ret)
+			goto err_out;
+
+		/* Next get the max gear supported by the UFS controller */
+		reg = ufshcd_readl(hba, REG_UFS_PARAM0);
+		hcd_max_gear = UFS_QCOM_MAX_GEAR(reg);
+
+		/*
+		 * Now compare both the gears. If the max gear supported by the UFS device
+		 * is compatible with UFS controller, then use the UFS device's max gear
+		 * speed. Otherwise, use the UFS controller supported max gear speed.
+		 */
+		return (max_gear <= hcd_max_gear) ? max_gear : hcd_max_gear;
 	}
 
+err_out:
 	/* Default is HS-G3 */
 	return UFS_HS_G3;
 }
@@ -303,7 +331,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct phy *phy = host->generic_phy;
 	int ret;
-	bool is_rate_B = UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B;
+	u32 hs_gear;
 
 	/* Reset UFS Host Controller and PHY */
 	ret = ufs_qcom_host_reset(hba);
@@ -311,8 +339,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		dev_warn(hba->dev, "%s: host reset returned %d\n",
 				  __func__, ret);
 
-	if (is_rate_B)
-		phy_set_mode(phy, PHY_MODE_UFS_HS_B);
+	/* UFS_HS_G2 is used here since that's the least gear supported by legacy Qcom platforms */
+	hs_gear = ufs_qcom_get_hs_gear(hba, UFS_HS_G2);
+	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, hs_gear);
 
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 214ea50acab9..c93bc52ea848 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -89,6 +89,10 @@ enum {
 #define TMRLUT_HW_CGC_EN	BIT(6)
 #define OCSC_HW_CGC_EN		BIT(7)
 
+/* bit definitions for REG_UFS_PARAM0 */
+#define MAX_HS_GEAR_MASK	GENMASK(6, 4)
+#define UFS_QCOM_MAX_GEAR(x)	FIELD_GET(MAX_HS_GEAR_MASK, (x))
+
 /* bit definition for UFS_UFS_TEST_BUS_CTRL_n */
 #define TEST_BUS_SUB_SEL_MASK	GENMASK(4, 0)  /* All XXX_SEL fields are 5 bits wide */
 
-- 
2.25.1

