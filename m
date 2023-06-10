Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A2F72A842
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjFJCQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232978AbjFJCQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:16:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF5835A9;
        Fri,  9 Jun 2023 19:16:18 -0700 (PDT)
X-UUID: c4ef305e073411ee9cb5633481061a41-20230610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=sCxAcNnH3QcIRCLgXdJamvKspR+Phxrk1vSpBGRWR/g=;
        b=HPcFvG8M9MxWT0JjbJNmJcJk8dLSzIOQJH+DeRbAwQ4sB5sFgJKnbfffDmsKdPnIKcmJXaqaYlUOknH4w2Zh49DFSuULKbLDx8IcSmFkOednQggEAYjc9NMHVkFiRAS2lIvVXs9vnZ4/n5ICwePyzmzT803mC96zyn+n21IBAvE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:7c90982d-ed70-4ea4-911f-307f4fba8542,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.26,REQID:7c90982d-ed70-4ea4-911f-307f4fba8542,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:cb9a4e1,CLOUDID:a889f93d-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:230610101614DV7GZJ00,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,
        TF_CID_SPAM_SDM
X-UUID: c4ef305e073411ee9cb5633481061a41-20230610
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1327504782; Sat, 10 Jun 2023 10:16:11 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 10 Jun 2023 10:16:10 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 10 Jun 2023 10:16:10 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>
Subject: [PATCH v2 1/2] scsi: ufs: mcq: Fix the incorrect OCS value for the device command
Date:   Sat, 10 Jun 2023 10:15:51 +0800
Message-ID: <20230610021553.1213-2-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230610021553.1213-1-powen.kao@mediatek.com>
References: <20230610021553.1213-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Stanley Chu <stanley.chu@mediatek.com>

In MCQ mode, when a device command uses a hardware queue shared
with other commands, a race condition may occur in the following scenario:

1. A device command is completed in CQx with CQE entry "e".
2. The interrupt handler copies the "cqe" pointer to "hba->dev_cmd.cqe"
   and completes "hba->dev_cmd.complete".
3. The "ufshcd_wait_for_dev_cmd()" function is awakened and retrieves
   the OCS value from "hba->dev_cmd.cqe".

However, there is a possibility that the CQE entry "e" will be overwritten
by newly completed commands in CQx, resulting in an incorrect OCS value
being received by "ufshcd_wait_for_dev_cmd()".

To avoid this race condition, the OCS value should be immediately copied
to the struct "lrb" of the device command. Then "ufshcd_wait_for_dev_cmd()"
can retrieve the OCS value from the struct "lrb".

Fixes: b5167638ec82 ("scsi: ufs: core: mcq: Add support to allocate multiple queues")
Suggested-by: Can Guo <quic_cang@quicinc.com>
Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
Tested-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 drivers/ufs/core/ufshcd.c | 10 +++++++---
 include/ufs/ufshcd.h      |  1 -
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 5da62248ebc4..593790fa4837 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -3086,7 +3086,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
 		 * not trigger any race conditions.
 		 */
 		hba->dev_cmd.complete = NULL;
-		err = ufshcd_get_tr_ocs(lrbp, hba->dev_cmd.cqe);
+		err = ufshcd_get_tr_ocs(lrbp, NULL);
 		if (!err)
 			err = ufshcd_dev_cmd_completion(hba, lrbp);
 	} else {
@@ -3182,7 +3182,6 @@ static int ufshcd_exec_dev_cmd(struct ufs_hba *hba,
 		goto out;
 
 	hba->dev_cmd.complete = &wait;
-	hba->dev_cmd.cqe = NULL;
 
 	ufshcd_add_query_upiu_trace(hba, UFS_QUERY_SEND, lrbp->ucd_req_ptr);
 
@@ -5431,6 +5430,7 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 {
 	struct ufshcd_lrb *lrbp;
 	struct scsi_cmnd *cmd;
+	enum utp_ocs ocs;
 
 	lrbp = &hba->lrb[task_tag];
 	lrbp->compl_time_stamp = ktime_get();
@@ -5446,7 +5446,11 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 	} else if (lrbp->command_type == UTP_CMD_TYPE_DEV_MANAGE ||
 		   lrbp->command_type == UTP_CMD_TYPE_UFS_STORAGE) {
 		if (hba->dev_cmd.complete) {
-			hba->dev_cmd.cqe = cqe;
+			if (cqe) {
+				ocs = le32_to_cpu(cqe->status) & MASK_OCS;
+				lrbp->utr_descriptor_ptr->header.dword_2 =
+					cpu_to_le32(ocs);
+			}
 			complete(hba->dev_cmd.complete);
 			ufshcd_clk_scaling_update_busy(hba);
 		}
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index 9b2d1859f885..602615e6d1bf 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -225,7 +225,6 @@ struct ufs_dev_cmd {
 	struct mutex lock;
 	struct completion *complete;
 	struct ufs_query query;
-	struct cq_entry *cqe;
 };
 
 /**
-- 
2.18.0

