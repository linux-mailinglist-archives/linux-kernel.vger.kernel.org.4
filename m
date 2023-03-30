Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1C626CF8B7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 03:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjC3B3f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 21:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjC3B3d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 21:29:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569552132;
        Wed, 29 Mar 2023 18:29:27 -0700 (PDT)
X-UUID: 4be679f6ce9a11eda9a90f0bb45854f4-20230330
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=L/zOEaXONDhNZMFsIvxL84Y1YKRJDDGZ4D6js3PM4uA=;
        b=AmLytvkUWxoEVModBDthdG5gBMWbfK9BYUx2L1VAAzBEAhvN026CyV4PeHm8ovq09hG6jgBaEKXJ1fkFY2cWPe2Rf6i1F10Ey9iYBuhsE+kWwirqB9BEHWyl+qyre8p4vOHEvwrbI1RWU08kDsiMHki4J2LhSEdwLXhY3pH5+Nk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:71fa2093-0352-4f26-bcc1-181654c7ab3d,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:120426c,CLOUDID:ac2bc8b4-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 4be679f6ce9a11eda9a90f0bb45854f4-20230330
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 759130459; Thu, 30 Mar 2023 09:29:21 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Thu, 30 Mar 2023 09:29:20 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Thu, 30 Mar 2023 09:29:20 +0800
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin.petersen@oracle.com>, <avri.altman@wdc.com>,
        <alim.akhtar@samsung.com>, <jejb@linux.ibm.com>,
        <bvanassche@acm.org>
CC:     <stanley.chu@mediatek.com>
Subject: [PATCH v1] scsi: core: Cleanup struct ufs_saved_pwr_info
Date:   Thu, 30 Mar 2023 09:29:18 +0800
Message-ID: <20230330012918.13748-1-stanley.chu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "is_valid" field of the struct ufs_saved_pwr_info is no
longer used, and this struct can be replaced by struct
ufs_pa_layer_attr, without any changes to the functionality.

Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 7 +++----
 include/ufs/ufshcd.h      | 7 +------
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index c32a927ac5d1..97eb28a3006d 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -1269,7 +1269,7 @@ static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
 	struct ufs_pa_layer_attr new_pwr_info;
 
 	if (scale_up) {
-		memcpy(&new_pwr_info, &hba->clk_scaling.saved_pwr_info.info,
+		memcpy(&new_pwr_info, &hba->clk_scaling.saved_pwr_info,
 		       sizeof(struct ufs_pa_layer_attr));
 	} else {
 		memcpy(&new_pwr_info, &hba->pwr_info,
@@ -1278,7 +1278,7 @@ static int ufshcd_scale_gear(struct ufs_hba *hba, bool scale_up)
 		if (hba->pwr_info.gear_tx > hba->clk_scaling.min_gear ||
 		    hba->pwr_info.gear_rx > hba->clk_scaling.min_gear) {
 			/* save the current power mode */
-			memcpy(&hba->clk_scaling.saved_pwr_info.info,
+			memcpy(&hba->clk_scaling.saved_pwr_info,
 				&hba->pwr_info,
 				sizeof(struct ufs_pa_layer_attr));
 
@@ -8424,10 +8424,9 @@ static int ufshcd_add_lus(struct ufs_hba *hba)
 
 	/* Initialize devfreq after UFS device is detected */
 	if (ufshcd_is_clkscaling_supported(hba)) {
-		memcpy(&hba->clk_scaling.saved_pwr_info.info,
+		memcpy(&hba->clk_scaling.saved_pwr_info,
 			&hba->pwr_info,
 			sizeof(struct ufs_pa_layer_attr));
-		hba->clk_scaling.saved_pwr_info.is_valid = true;
 		hba->clk_scaling.is_allowed = true;
 
 		ret = ufshcd_devfreq_init(hba);
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 431c3afb2ce0..2845fe7f45cd 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -394,11 +394,6 @@ struct ufs_clk_gating {
 	struct workqueue_struct *clk_gating_workq;
 };
 
-struct ufs_saved_pwr_info {
-	struct ufs_pa_layer_attr info;
-	bool is_valid;
-};
-
 /**
  * struct ufs_clk_scaling - UFS clock scaling related data
  * @active_reqs: number of requests that are pending. If this is zero when
@@ -428,7 +423,7 @@ struct ufs_clk_scaling {
 	ktime_t window_start_t;
 	ktime_t busy_start_t;
 	struct device_attribute enable_attr;
-	struct ufs_saved_pwr_info saved_pwr_info;
+	struct ufs_pa_layer_attr saved_pwr_info;
 	struct workqueue_struct *workq;
 	struct work_struct suspend_work;
 	struct work_struct resume_work;
-- 
2.18.0

