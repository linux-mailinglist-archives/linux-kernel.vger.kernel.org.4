Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8069B6542A9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 15:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiLVOPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 09:15:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiLVOOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 09:14:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134C531350
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:12:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id b2so2118608pld.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Dec 2022 06:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SPN6MvsLleyjqtpg7glkpxk2Wcr9bYRBKaDcXVrkxao=;
        b=vSlLDPBkg+X0ZBxJOz0DTSh8gbGqwFDw8UyYr/ADDQaA8R0hwaZRRaMpkOy6O4o0sp
         JGqUgdcaT1m6ws2nPfO2XNoFBQ14GrEDWqdYaVwKauZGyoTePtC/skYEx0T71dwuCFi2
         Hnr3gUVFPrG8fdACGv8bvmF3Oap3mjD8CIvt/XZM7TWFXQnszK3IDSrDHj6NIZ7XZDJh
         +rNo8mmnfwme1AQ+x7iJanAPi2bj/RikfdCgKVauk+geNc3jTLWTfH0Znkhi/yoGkg2K
         sHahEJ0OTclZuxC6X6J46uAV8ATkrebW6Qw2QQnUFLCWkP+gG8NF4vEtRYtVWNs1UKpK
         4DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SPN6MvsLleyjqtpg7glkpxk2Wcr9bYRBKaDcXVrkxao=;
        b=vBVlkMb8iXPtb5Cj3qiS3MUap45/Knp1fcw1IgroFfYn6hAPWLqkluj8EJAMfBgtEH
         1wme8M4Ff7r2LMWxjvGmfP+2Bx9a5d/aO2wZk02bn7oRytfhNj/bUK8+RUkFtke2c9Uh
         LEQkDWH110xprni0ct5Xf0+1mEPx9dYcOqmqHRCk7UQh1njNq3mk5ljzRz9uv7eOJhod
         0AhuZcq8geJZ7ivbnzPNEpKyvZiZpkLbyZlGf5TFXagV/AYMzLqL4tGZgKfjeejg35AW
         SHpb4V7PhH9JLOKOSzGtxd12LyygIHLhbnAW7xwht2+cmZQnQkeUwJTVxnICFUx3l/YW
         o2LA==
X-Gm-Message-State: AFqh2kpaWuUKA1CkKkyr/5V/ogvoSXR5u20EpgwZQL/f/GayQNIPL5l5
        lozw9HH4vwkWJY3CuT3Tyocy
X-Google-Smtp-Source: AMrXdXu/KaxPoteqxf49QCt4/X1HqUCw83tcdIDod5MMlfpjrw38HLDXkcil1XByhafZ+tCJCx8c6Q==
X-Received: by 2002:a05:6a20:d695:b0:a2:c1f4:3c70 with SMTP id it21-20020a056a20d69500b000a2c1f43c70mr7254391pzb.8.1671718359483;
        Thu, 22 Dec 2022 06:12:39 -0800 (PST)
Received: from localhost.localdomain ([117.217.177.177])
        by smtp.gmail.com with ESMTPSA id f8-20020a655908000000b0047829d1b8eesm832031pgu.31.2022.12.22.06.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 06:12:38 -0800 (PST)
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
Subject: [PATCH v5 20/23] scsi: ufs: ufs-qcom: Factor out the logic finding the HS Gear
Date:   Thu, 22 Dec 2022 19:39:58 +0530
Message-Id: <20221222141001.54849-21-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
References: <20221222141001.54849-1-manivannan.sadhasivam@linaro.org>
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
Tested-by: Andrew Halaney <ahalaney@redhat.com> # Qdrive3/sa8540p-ride
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

