Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F78B6067BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJTSFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJTSFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:05:06 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349B23881;
        Thu, 20 Oct 2022 11:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1666289105; x=1697825105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=kGtPfs8nWQlTCrBnDS0pyf6RVUAdKKSo43QpwKLl6Vc=;
  b=V5n6H+3qbx/INy/EWRp3nm0djCOcsdCZm0JKmzN+i4Sz0RfNDBNOd9eK
   2T+mZAYhMzd5DtyVYnM1n9zlBumjFw2DHvXfVugjkwIbbL/2xPAwCqg9k
   zkUJMT3PO95TqxcAEJrzsUxkqb5/cB0SlnjrBjwo+pE6tsinIm1fKM2Ld
   Q=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 20 Oct 2022 11:05:02 -0700
X-QCInternal: smtphost
Received: from unknown (HELO nasanex01a.na.qualcomm.com) ([10.52.223.231])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 11:05:02 -0700
Received: from asutoshd-linux1.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Thu, 20 Oct 2022 11:05:01 -0700
From:   Asutosh Das <quic_asutoshd@quicinc.com>
To:     <quic_cang@quicinc.com>, <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <quic_nguyenb@quicinc.com>, <quic_xiaosenh@quicinc.com>,
        <stanley.chu@mediatek.com>, <eddie.huang@mediatek.com>,
        <daejun7.park@samsung.com>, <bvanassche@acm.org>,
        <avri.altman@wdc.com>, <mani@kernel.org>, <beanhuo@micron.com>,
        <quic_richardp@quicinc.com>,
        "Asutosh Das" <quic_asutoshd@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "open list" <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/17] ufs: core: Optimize duplicate code to read extended feature
Date:   Thu, 20 Oct 2022 11:03:31 -0700
Message-ID: <5997d1d2ceaab9baab13b8a11f6643d0d5905e19.1666288432.git.quic_asutoshd@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1666288432.git.quic_asutoshd@quicinc.com>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code to parse the extended feature is duplicated more then 2
times in the ufs core. Replace the duplicated code with the
function.

Signed-off-by: Asutosh Das <quic_asutoshd@quicinc.com>
---
 drivers/ufs/core/ufshcd.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 80f01d0..e2be3f4 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -7605,13 +7605,7 @@ static void ufshcd_wb_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	     (hba->dev_quirks & UFS_DEVICE_QUIRK_SUPPORT_EXTENDED_FEATURES)))
 		goto wb_disabled;
 
-	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
-	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
-		goto wb_disabled;
-
-	ext_ufs_feature = get_unaligned_be32(desc_buf +
-					DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
-
+	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
 	if (!(ext_ufs_feature & UFS_DEV_WRITE_BOOSTER_SUP))
 		goto wb_disabled;
 
@@ -7665,7 +7659,7 @@ static void ufshcd_temp_notif_probe(struct ufs_hba *hba, const u8 *desc_buf)
 	if (!(hba->caps & UFSHCD_CAP_TEMP_NOTIF) || dev_info->wspecversion < 0x300)
 		return;
 
-	ext_ufs_feature = get_unaligned_be32(desc_buf + DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
+	ext_ufs_feature = ufs_get_ext_ufs_feature(hba, desc_buf);
 
 	if (ext_ufs_feature & UFS_DEV_LOW_TEMP_NOTIF)
 		mask |= MASK_EE_TOO_LOW_TEMP;
-- 
2.7.4

