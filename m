Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9C6542AC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiLVOPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:15:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiLVOOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:14:49 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B323E87
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:12:47 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m4so2134789pls.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aBn3zEFmIV6MhSJTCqVfJoKippEJn3UVUNP6V0+D++w=;
        b=wUEp+NmpgcRSpWDAl5gCZLjGhtZOUkb6nH0n9cqBjo1QjAmnGSD7tz6SDlueRbPqU7
         Pg58jvzpbEa5o9H4QDHwvb+xubArD7c4VsVqyoewLiLlPIu9zYu8umlPz6bY+qbSBIKB
         GDEDwBvoMAWXMY87a8AS3OemBzeDMf+zwDx1Ez9qW5ya4vxTB4+8ImILjJyoOxImdKaX
         BjK//SJQUjz4knoV54gc8pC3pwQlKYSVM6w0uFkWeHnXlNNpRiMIK/JH68QdlKIiUcfp
         Z1YOqDt8BL4jrYcv6CQNRYAs+VPHtZS4ff9BvD50/froZGoTp+7WhIjv5+U38QLMGbqn
         1AkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aBn3zEFmIV6MhSJTCqVfJoKippEJn3UVUNP6V0+D++w=;
        b=cfJIPNIy3aMqs/uDx33uYVWfAZI0NaUxZDUjpp3z1NDjILmdMqcU5zZ5BydGL58+gG
         GHmSuH3QiDoWU5VGWXMusr+ZaI2E0YKPiSqfumCmktuya8OkeTJtMkvzxVmmOUSTGyrX
         phckIjTH8iHEPWf3i5GCOGPYn5gtSRcCEkxWkRi0wsy3LyJqVS8eqhHrJZjqFeAI+Zq0
         tAxyRS4xyxyuLh3SoYB2OPQcIzB9fD4OYwxKBmaNArwK0qXmxuMJ5UP+rrg9wy/d/F00
         kceWpg/pu/pRjHjXpkrXa91TRC9raC1v/TDchCxPYOIdhTdjtDgKjPp72w5nW0pkZP1H
         5CQA==
X-Gm-Message-State: AFqh2krosK5ZCQKJ8z2bAFDpB4uFY1DxRfIjC8zyFP5cQ40+0YRwtjjD
        P1EvZn7moYanf5kW5Osa2DlC
X-Google-Smtp-Source: AMrXdXtmutM2RQ/lU4e/I/kqUw5HOoB1HQclleoi8/H3D+yG44Gbrwy7yofMNVMYL9R5pI1N2pY2Nw==
X-Received: by 2002:a05:6a20:c112:b0:ad:e904:f247 with SMTP id bh18-20020a056a20c11200b000ade904f247mr6784083pzb.29.1671718367062;
        Thu, 22 Dec 2022 06:12:47 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:12:46 -0800 (PST)
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
Subject: [PATCH v5 21/23] scsi: ufs: ufs-qcom: Add support for reinitializing the UFS device
Date:   Thu, 22 Dec 2022 19:39:59 +0530
Message-Id: <20221222141001.54849-22-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
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
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
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

