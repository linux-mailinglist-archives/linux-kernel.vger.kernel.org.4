Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63DE263F6BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiLARsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiLARrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:47:23 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BA1BB025
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 09:45:57 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id l127so1922416pfl.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 09:45:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQW21UMpMMT39kQGkUZ44Bi2KAiI76Uffz4R9s7ZIY4=;
        b=uPM5610zPQIlWnYvAfYxvFUjx4KyncZ1u+j8V48Bet9cviXPz+FW5b59cfhaUrklwy
         qi7GFEGjV+XP3FvXov0aDZWRXMokj5ir4KXHzo2R+VWfpEQ+xx8u6VmdTQ69Lv2+rpOR
         GwdyzbX9oI7KIXYTAO8+hXGM3f7u0W+fOk9bYGrpGZgaXt9AHuOK3jIpZiXsF9ygfekU
         Jae9G1erq/N6M7yMsLhO4dIkjg8U05n8Hq7AvsTRset77kX4Oqbvyi2mJqfQ3GfdAX3/
         RVrT6fmssC6ACB0clRYB1jXckqSrkLY8rJlRrjKRNdrsljV3NDwVrc4jN5MvtmOcBoZX
         tZ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQW21UMpMMT39kQGkUZ44Bi2KAiI76Uffz4R9s7ZIY4=;
        b=cO3JaupwdH16b3nTg37T0XVhrrAlYmhqommACb/XsmMWlnuKhk/YgGhJhmNc6pKVX2
         XYiSur+EUZjJYV1fAPSEdWJ751PQ75zrvcVoXec02VsmEIOEyXOrwR5DvjGKD5PqlL2f
         HtDth2+a6d4WzX+mW6uJrHvRAvYoWdxRay+FxDkDWOXxMJd3NoCe7YyDp9bl1VFTfP39
         gmt3hVjAMXKPlJ6XEv8UV+gLWhWgKPlKtHgXcQ5IqTdwEsh5Kx3/OkCv7eI/8ZGtlNzk
         13gtcLDX+nZoRtcZHdcX1XGNnADQUg+3h9YkDHwQNYNR7samGOXeIzM881W+fftBw80+
         0fbw==
X-Gm-Message-State: ANoB5pmxRSmDWUs0Op45PSCtHll1fB0L2EZyMfWV7iNqxX9sIRB6Ajvj
        IoKuXKHGnaLbUEf0USzRO2XY
X-Google-Smtp-Source: AA0mqf6SLdlPX+AwZRZI4w6lpTEftQnEJu8OEE6j/XM/e2If+9aXa1pvNUTp+srNEjewU9++T9h7Rw==
X-Received: by 2002:a63:e712:0:b0:477:7f69:2749 with SMTP id b18-20020a63e712000000b004777f692749mr42680821pgi.372.1669916756874;
        Thu, 01 Dec 2022 09:45:56 -0800 (PST)
Received: from localhost.localdomain ([220.158.159.39])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016d9b101413sm3898743pll.200.2022.12.01.09.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:45:56 -0800 (PST)
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
Subject: [PATCH v4 20/23] scsi: ufs: ufs-qcom: Factor out the logic finding the HS Gear
Date:   Thu,  1 Dec 2022 23:13:25 +0530
Message-Id: <20221201174328.870152-21-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
References: <20221201174328.870152-1-manivannan.sadhasivam@linaro.org>
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

