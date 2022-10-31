Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907F2613D0F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbiJaSFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbiJaSET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:04:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD2313E0E
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:04:18 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id h2so11367255pgp.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcGYZZ4IatcAF8AJIOp/3hmvo2iIimpjADZP7Jg0G+Q=;
        b=D5dBZnhZe6DUySFjnbf93OShH5vvNpcUk7dbkYFI/9SGqfaCTZ4Rkp0Edx97sxFA3Y
         7GxwwYlKf6BZM4cIl+dt6cWLFoO0wMlDcFiyoGvS/d9cxPXWKzAOz0L7yR6Frthwg0bN
         wMWfjIJGhjUDQ2OzbwDOJLkfapGJ/ih+rKfkBPmfJFZydZ15IvL0hAkCGoQirYD6qy3+
         tO/FE+pLZWAT7X8YILnePQBDJgdhMK6Ihpk94/j0HWDdYfjUiL+4f66bTV8Vy/VpzMEG
         GQqHD2RZ6fNBgcK6YWlx4bpU9Tw0ZDRA2Qp9abSe7gPTaPXRBFeq0aqoIm9NtU60lvq6
         AG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vcGYZZ4IatcAF8AJIOp/3hmvo2iIimpjADZP7Jg0G+Q=;
        b=LrE9+3jrfyj8TIBNLOBu+rpkelP/ad3GP2HM8YD+7tlPdcx0RmZ2XUjLqeI9Aktduo
         zVIvcvpexiIw8AxdxaNjDMwAw96BwZYAbiYmMgrjJlk7Gt29aWsnuwFCbaicvKuzEmqJ
         1F6j+Y+1Jc7phzZUZP5551+vjts8WRGregbd22pBogYfFpxmrhgmv2y9hfA7bD6KfBVT
         dxquM45nTDPQtAZ+jTYEvg+QMF57pV6XoRMI65BLtbTBrA8tEz+BLaQ3NzNaH62rySBO
         E1gJnJu/a9tHP+F0WMhGy4ghpfvKsZr2Gkv8yxjMETs9PxuKwPlwMjKb0WGBlbFdQk27
         DeSQ==
X-Gm-Message-State: ACrzQf1Ra9P5QzRr6yBbrvZJESXdmdQxYg8y3Z3C5w0iGMJNnMnqLH3Q
        xdNOHkIwj4CoGIzuRqZL0gcc
X-Google-Smtp-Source: AMsMyM4aDq/tMQ3zInAZrDzw487GBW7QgdEEgKfyMP/pEU+B81Elhn+1+cuPdk/FuuEaW4m7y1VNYA==
X-Received: by 2002:a05:6a02:207:b0:46f:1a92:9474 with SMTP id bh7-20020a056a02020700b0046f1a929474mr13142706pgb.344.1667239458584;
        Mon, 31 Oct 2022 11:04:18 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.221])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b00186c6d2e7e3sm4742224plb.26.2022.10.31.11.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:04:17 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        quic_cang@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 14/15] scsi: ufs: ufs-qcom: Add support for finding HS gear on new UFS versions
Date:   Mon, 31 Oct 2022 23:32:16 +0530
Message-Id: <20221031180217.32512-15-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
References: <20221031180217.32512-1-manivannan.sadhasivam@linaro.org>
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
UFS device's max gear can be read from the "max-device-gear" devicetree
property.

The UFS PHY also needs to be configured with the decided gear using the
phy_set_mode_ext() API.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 31 ++++++++++++++++++++++++++++---
 drivers/ufs/host/ufs-qcom.h |  4 ++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index c93d2d38b43e..ca60a5b0292b 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -281,6 +281,9 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+	struct device *dev = hba->dev;
+	u32 max_device_gear, max_hcd_gear, reg;
+	int ret;
 
 	if (host->hw_ver.major == 0x1) {
 		/*
@@ -292,8 +295,29 @@ static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba, u32 hs_gear)
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
+		ret = of_property_read_u32(dev->of_node, "max-device-gear", &max_device_gear);
+		if (ret)
+			goto err_out;
+
+		/* Next get the max gear supported by the UFS controller */
+		reg = ufshcd_readl(hba, REG_UFS_PARAM0);
+		max_hcd_gear = UFS_QCOM_MAX_GEAR(reg);
+
+		/* Now return the minimum of both gears */
+		return min(max_device_gear, max_hcd_gear);
 	}
 
+err_out:
 	/* Default is HS-G3 */
 	return UFS_HS_G3;
 }
@@ -303,7 +327,7 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct phy *phy = host->generic_phy;
 	int ret;
-	bool is_rate_B = UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B;
+	u32 hs_gear;
 
 	/* Reset UFS Host Controller and PHY */
 	ret = ufs_qcom_host_reset(hba);
@@ -311,8 +335,9 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
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
index 7fe928b82753..751ded3e3531 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -94,6 +94,10 @@ enum {
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

