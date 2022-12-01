Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83D1463F6BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiLARsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:48:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbiLARrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:47:47 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01068BB036
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:46:04 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id g10so2312471plo.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HfEJwN0vYVybfZ9YyTm6eBmcGL9HtCjfrKAQuwx/Vlk=;
        b=ITIGZHCi9cPswRmdxDZ6T83A0c6HKJ0ts/3XspYsfh/mGdC16YCB8MvDu0jwqM3zkl
         BV6SzOWQTIOFHKEBzEaaIfIXnsVezdtUlvrLVX1N2+t7ogMRlGN6pphE0PM3YO+ecZw/
         DT8ZtU/76aNYNBXhTZ6uB5KZyU0GmYPrDNuy8IAqa/fBF9exALPccbhvJeE2Wm1/k7ch
         I9Zm45bnFKXsjPUDD3paMA0DW/6yy8FmLlKGv0vPwkXZY7VUjrMqapJcj6tdpY/eB2Vi
         WOJP6lx4eyunsLWU3AJzFr16BGTwaZ0YoPeE7VBRO8fAFC11590Sj2nRA7RJXD6hNQzG
         e+WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HfEJwN0vYVybfZ9YyTm6eBmcGL9HtCjfrKAQuwx/Vlk=;
        b=YtFa5zYLAAIcKEmZPEkJzeKgwmwnyM2DuHhp36S3NnPtt0ba/SG9gnwshVT/kD+pU0
         S3d07jiRMetMOyMnFIBicAlOamUJiEVj7Ipez6NKZNMl+CIgAYhMdZ9vANzzF0/lAaaD
         GLPB52K6EHel56LE8hTXnqrV4zgYEgqJcd8/XUDLpa9hS6Tp1LLD+/VKavG/iQ5q1nP0
         Zp3sQsJ4RYDyhuVtjs+Q2J+lHP/sepwQGp3F35Nme041qUcdzHRBdED8cmJoe9RjRsYE
         63brC1NjObz1FU6l5A0trGO6AZc3rRprMS3TiFV3HEd324CPAQF98Ec9uYwHYqiHtx+D
         QFXQ==
X-Gm-Message-State: ANoB5plf8fmyRCN1kWK53Q0eXI/YSezBcr+aGKkFOlvKnnNjCeI1XWPE
        FrfRDEMUa5ePQvKaP+73kfeV
X-Google-Smtp-Source: AA0mqf7X2y4uCqcQwAP/5lxkylBmUsvwLff+iLprcgKo90LT16Br3DakEIn/3PQ6YtvSo/pznOihhQ==
X-Received: by 2002:a17:902:dacd:b0:189:6889:c309 with SMTP id q13-20020a170902dacd00b001896889c309mr32201361plx.3.1669916764269;
        Thu, 01 Dec 2022 09:46:04 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:46:03 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 21/23] scsi: ufs: ufs-qcom: Add support for reinitializing the UFS device
Date:   Thu,  1 Dec 2022 23:13:26 +0530
Message-Id: <20221201174328.870152-22-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
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

Starting from Qualcomm UFS version 4, the UFS device needs to be
reinitialized after switching to maximum gear by the UFS core. Hence, add
support for it by enabling the UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH
quirk, implementing reinit_notify() callback and using the agreed gear
speed for setting the PHY mode.

Suggested-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 26 ++++++++++++++++++++++----
 drivers/ufs/host/ufs-qcom.h |  2 ++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 919b6eae439d..3efef2f36e69 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -302,7 +302,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
 	struct phy *phy = host->generic_phy;
 	int ret;
-	bool is_rate_B = UFS_QCOM_LIMIT_HS_RATE == PA_HS_MODE_B;
 
 	/* Reset UFS Host Controller and PHY */
 	ret = ufs_qcom_host_reset(hba);
@@ -310,9 +309,6 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		dev_warn(hba->dev, "%s: host reset returned %d\n",
 				  __func__, ret);
 
-	if (is_rate_B)
-		phy_set_mode(phy, PHY_MODE_UFS_HS_B);
-
 	/* phy initialization - calibrate the phy */
 	ret = phy_init(phy);
 	if (ret) {
@@ -321,6 +317,8 @@ static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 		return ret;
 	}
 
+	phy_set_mode_ext(phy, PHY_MODE_UFS_HS_B, host->hs_gear);
+
 	/* power on phy - start serdes and phy's power and clocks */
 	ret = phy_power_on(phy);
 	if (ret) {
@@ -723,6 +721,9 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 			return ret;
 		}
 
+		/* Use the agreed gear */
+		host->hs_gear = dev_req_params->gear_tx;
+
 		/* enable the device ref clock before changing to HS mode */
 		if (!ufshcd_is_hs_mode(&hba->pwr_info) &&
 			ufshcd_is_hs_mode(dev_req_params))
@@ -836,6 +837,9 @@ static void ufs_qcom_advertise_quirks(struct ufs_hba *hba)
 				| UFSHCD_QUIRK_DME_PEER_ACCESS_AUTO_MODE
 				| UFSHCD_QUIRK_BROKEN_PA_RXHSUNTERMCAP);
 	}
+
+	if (host->hw_ver.major > 0x3)
+		hba->quirks |= UFSHCD_QUIRK_REINIT_AFTER_MAX_GEAR_SWITCH;
 }
 
 static void ufs_qcom_set_caps(struct ufs_hba *hba)
@@ -1044,6 +1048,12 @@ static int ufs_qcom_init(struct ufs_hba *hba)
 		dev_warn(dev, "%s: failed to configure the testbus %d\n",
 				__func__, err);
 
+	/*
+	 * Power up the PHY using the minimum supported gear (UFS_HS_G2).
+	 * Switching to max gear will be performed during reinit if supported.
+	 */
+	host->hs_gear = UFS_HS_G2;
+
 	return 0;
 
 out_variant_clear:
@@ -1410,6 +1420,13 @@ static void ufs_qcom_config_scaling_param(struct ufs_hba *hba,
 }
 #endif
 
+static void ufs_qcom_reinit_notify(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	phy_power_off(host->generic_phy);
+}
+
 /*
  * struct ufs_hba_qcom_vops - UFS QCOM specific variant operations
  *
@@ -1433,6 +1450,7 @@ static const struct ufs_hba_variant_ops ufs_hba_qcom_vops = {
 	.device_reset		= ufs_qcom_device_reset,
 	.config_scaling_param = ufs_qcom_config_scaling_param,
 	.program_key		= ufs_qcom_ice_program_key,
+	.reinit_notify		= ufs_qcom_reinit_notify,
 };
 
 /**
diff --git a/drivers/ufs/host/ufs-qcom.h b/drivers/ufs/host/ufs-qcom.h
index 7fe928b82753..4b00c67e9d7f 100644
--- a/drivers/ufs/host/ufs-qcom.h
+++ b/drivers/ufs/host/ufs-qcom.h
@@ -217,6 +217,8 @@ struct ufs_qcom_host {
 	struct reset_controller_dev rcdev;
 
 	struct gpio_desc *device_reset;
+
+	u32 hs_gear;
 };
 
 static inline u32
-- 
2.25.1

