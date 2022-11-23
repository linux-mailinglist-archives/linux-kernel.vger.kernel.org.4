Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BE0635184
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236399AbiKWHwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbiKWHvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:51:23 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6AAFAE90
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:50:16 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id io19so15926490plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 23:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQW21UMpMMT39kQGkUZ44Bi2KAiI76Uffz4R9s7ZIY4=;
        b=Q4uifVNUG8xLZiw0nKZzqWhlsFQVjN7R7zmwgdRS/fTSn0Pz18mv37YJD39o+JlZ+U
         YX50U9RmFIiBE5gaK+qWmu8dehcTfKoU1BOe+NxgY/P8qv4PehJ3qfZDfW4HwQ/uSNLF
         SO5irDbKFTLjuwkrCMMdtgUjo/xb1StQ14ri1Bxv1UkA/bIwjVqyt+gMUVpvegQ+Peff
         qG4EAibX1FxdFxy8A92f6uSiv92YFS5FM3PH+5SGqa7OLIVqu/yGOPBW3106ZA1Dj0nN
         or6T2UMyGk7jCA89uhNo+9K4YwS8Q70+I2BoLGhEhoS19d02r0QG25cSU+dfJA25+76c
         lyFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQW21UMpMMT39kQGkUZ44Bi2KAiI76Uffz4R9s7ZIY4=;
        b=XawdXNDNiiIuX+ymI08p49Quae3LrqBEpi+0xzqrXWHD4BuMxnL2hdOWumuGEbN1tn
         yFGCgV+L88JDQIJRq/wZofa6hfKN9XrYdj7Mj1ujLUn26yr1yRWYhScPe9idg2I0CRiU
         fnJJ3Y7mpY9eW7lmRm5HUaYKYfB3esGlioyVPQfqxt1axwa555MIFbRqycBLnvt6ICE6
         xgytyCv6NwwyVAsDDa/gAvVYpw7OCuwhvoOGXHHozKgrGnayKToa36Asorw5CxYgjU9v
         dvKZ3o5xkxr+aV15WjZfnrWKE0BN2moUReTVm7PjkPFqZMIiVtLp2Wbgr2EY6EtJZWT6
         fgpA==
X-Gm-Message-State: ANoB5plDxj6R0rIP0SCKQWI5DKaSeXDyRuxSPiWIKJ/zkcul+3ERHK4G
        SsHylPh/KcBlI+cLhVyt73an
X-Google-Smtp-Source: AA0mqf5ljrSPGVNBRtykID1TL3/cGOrewa2yjiZmVTTVZrWsBIkuV1+BoJ27rIUb9wyuYvjPhd49vw==
X-Received: by 2002:a17:90a:d811:b0:213:aa8:dda with SMTP id a17-20020a17090ad81100b002130aa80ddamr30077911pjv.111.1669189815878;
        Tue, 22 Nov 2022 23:50:15 -0800 (PST)
Received: from localhost.localdomain ([117.202.191.0])
        by smtp.gmail.com with ESMTPSA id s16-20020a170902a51000b001869f2120a5sm13334059plq.34.2022.11.22.23.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 23:50:15 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     martin.petersen@oracle.com, jejb@linux.ibm.com,
        andersson@kernel.org, vkoul@kernel.org
Cc:     quic_cang@quicinc.com, quic_asutoshd@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-scsi@vger.kernel.org,
        dmitry.baryshkov@linaro.org, ahalaney@redhat.com,
        abel.vesa@linaro.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 17/20] scsi: ufs: ufs-qcom: Factor out the logic finding the HS Gear
Date:   Wed, 23 Nov 2022 13:18:23 +0530
Message-Id: <20221123074826.95369-18-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
References: <20221123074826.95369-1-manivannan.sadhasivam@linaro.org>
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

In the preparation of adding support for new gears, let's move the
logic that finds the gear for each platform to a new function. This helps
with code readability and also allows the logic to be used in other places
of the driver in future.

While at it, let's make it clear that this driver only supports symmetric
gear setting (hs_tx_gear == hs_rx_gear).

Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/ufs/host/ufs-qcom.c | 34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/host/ufs-qcom.c b/drivers/ufs/host/ufs-qcom.c
index 38e2ed749d75..919b6eae439d 100644
--- a/drivers/ufs/host/ufs-qcom.c
+++ b/drivers/ufs/host/ufs-qcom.c
@@ -278,6 +278,25 @@ static int ufs_qcom_host_reset(struct ufs_hba *hba)
 	return 0;
 }
 
+static u32 ufs_qcom_get_hs_gear(struct ufs_hba *hba)
+{
+	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
+
+	if (host->hw_ver.major == 0x1) {
+		/*
+		 * HS-G3 operations may not reliably work on legacy QCOM
+		 * UFS host controller hardware even though capability
+		 * exchange during link startup phase may end up
+		 * negotiating maximum supported gear as G3.
+		 * Hence downgrade the maximum supported gear to HS-G2.
+		 */
+		return UFS_HS_G2;
+	}
+
+	/* Default is HS-G3 */
+	return UFS_HS_G3;
+}
+
 static int ufs_qcom_power_up_sequence(struct ufs_hba *hba)
 {
 	struct ufs_qcom_host *host = ufshcd_get_variant(hba);
@@ -692,19 +711,8 @@ static int ufs_qcom_pwr_change_notify(struct ufs_hba *hba,
 		ufshcd_init_pwr_dev_param(&ufs_qcom_cap);
 		ufs_qcom_cap.hs_rate = UFS_QCOM_LIMIT_HS_RATE;
 
-		if (host->hw_ver.major == 0x1) {
-			/*
-			 * HS-G3 operations may not reliably work on legacy QCOM
-			 * UFS host controller hardware even though capability
-			 * exchange during link startup phase may end up
-			 * negotiating maximum supported gear as G3.
-			 * Hence downgrade the maximum supported gear to HS-G2.
-			 */
-			if (ufs_qcom_cap.hs_tx_gear > UFS_HS_G2)
-				ufs_qcom_cap.hs_tx_gear = UFS_HS_G2;
-			if (ufs_qcom_cap.hs_rx_gear > UFS_HS_G2)
-				ufs_qcom_cap.hs_rx_gear = UFS_HS_G2;
-		}
+		/* This driver only supports symmetic gear setting i.e., hs_tx_gear == hs_rx_gear */
+		ufs_qcom_cap.hs_tx_gear = ufs_qcom_cap.hs_rx_gear = ufs_qcom_get_hs_gear(hba);
 
 		ret = ufshcd_get_pwr_dev_param(&ufs_qcom_cap,
 					       dev_max_params,
-- 
2.25.1

