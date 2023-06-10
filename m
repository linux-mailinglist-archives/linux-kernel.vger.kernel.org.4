Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC972A83E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 04:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbjFJCQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 22:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232420AbjFJCQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 22:16:22 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808973AB2;
        Fri,  9 Jun 2023 19:16:17 -0700 (PDT)
X-UUID: c58da48c073411eeb20a276fd37b9834-20230610
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Rcchvgi5FyJDy4RQmyxS89mms7Xhq6X/n+rOq2jBeHc=;
        b=UCI20abDPl2DlkPPBDirGTBng7RuPyEnTbNFb+lQmf37FNiJdq/jff8vryoJCEsaUd3t7GnB6eeB8Fg3eBuYj7TeNDYSaLRJ8EzwqKX3WakNgf0oNpNw3KFxgdx/drP3vQ8ylgfflZwC6eomCDN7jNYvOoz6axG2xbn29ZUaho0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:248f6987-6bf5-4805-b3a1-9ebcd79f6600,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:b85c2a3e-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: c58da48c073411eeb20a276fd37b9834-20230610
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 279201731; Sat, 10 Jun 2023 10:16:12 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 10 Jun 2023 10:16:11 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 10 Jun 2023 10:16:11 +0800
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
Subject: [PATCH v2 2/2] scsi: ufs: core: Remove dedicated hwq for dev command
Date:   Sat, 10 Jun 2023 10:15:52 +0800
Message-ID: <20230610021553.1213-3-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230610021553.1213-1-powen.kao@mediatek.com>
References: <20230610021553.1213-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch depends on patch
"scsi: ufs: mcq: Fix the incorrect OCS value for the device command"
which take care of OCS value of dev commands under mcq mode.

We are safe to share first hwq for dev commnad and IO request here.

Tested-by: Po-Wen Kao <powen.kao@mediatek.com>
Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c     | 14 ++++----------
 drivers/ufs/core/ufshcd-priv.h |  1 -
 drivers/ufs/core/ufshcd.c      |  4 ++--
 3 files changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 785fc9762cad..9f70abbaa4ad 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -20,12 +20,10 @@
 #define MAX_QUEUE_SUP GENMASK(7, 0)
 #define UFS_MCQ_MIN_RW_QUEUES 2
 #define UFS_MCQ_MIN_READ_QUEUES 0
-#define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
 #define UFS_MCQ_MIN_POLL_QUEUES 0
 #define QUEUE_EN_OFFSET 31
 #define QUEUE_ID_OFFSET 16
 
-#define MAX_DEV_CMD_ENTRIES	2
 #define MCQ_CFG_MAC_MASK	GENMASK(16, 8)
 #define MCQ_QCFG_SIZE		0x40
 #define MCQ_ENTRY_SIZE_IN_DWORD	8
@@ -115,8 +113,7 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 	u32 utag = blk_mq_unique_tag(req);
 	u32 hwq = blk_mq_unique_tag_to_hwq(utag);
 
-	/* uhq[0] is used to serve device commands */
-	return &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+	return &hba->uhq[hwq];
 }
 
 /**
@@ -160,8 +157,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 	/* maxq is 0 based value */
 	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1;
 
-	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
-			rw_queues;
+	tot_queues = read_queues + poll_queues + rw_queues;
 
 	if (hba_maxq < tot_queues) {
 		dev_err(hba->dev, "Total queues (%d) exceeds HC capacity (%d)\n",
@@ -169,7 +165,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 		return -EOPNOTSUPP;
 	}
 
-	rem = hba_maxq - UFS_MCQ_NUM_DEV_CMD_QUEUES;
+	rem = hba_maxq;
 
 	if (rw_queues) {
 		hba->nr_queues[HCTX_TYPE_DEFAULT] = rw_queues;
@@ -195,7 +191,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 	for (i = 0; i < HCTX_MAX_TYPES; i++)
 		host->nr_hw_queues += hba->nr_queues[i];
 
-	hba->nr_hw_queues = host->nr_hw_queues + UFS_MCQ_NUM_DEV_CMD_QUEUES;
+	hba->nr_hw_queues = host->nr_hw_queues;
 	return 0;
 }
 
@@ -445,8 +441,6 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 
 	/* The very first HW queue serves device commands */
 	hba->dev_cmd_queue = &hba->uhq[0];
-	/* Give dev_cmd_queue the minimal number of entries */
-	hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
 
 	host->host_tagset = 1;
 	return 0;
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index aa88e60ea1f6..9566a95aeed9 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -84,7 +84,6 @@ int ufshcd_try_to_abort_task(struct ufs_hba *hba, int tag);
 void ufshcd_release_scsi_cmd(struct ufs_hba *hba,
 			     struct ufshcd_lrb *lrbp);
 
-#define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
 #define SD_RAW false
 int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 593790fa4837..f10318b7cbc1 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5503,7 +5503,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	struct ufs_hw_queue *hwq;
 
 	if (is_mcq_enabled(hba)) {
-		hwq = &hba->uhq[queue_num + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+		hwq = &hba->uhq[queue_num];
 
 		return ufshcd_mcq_poll_cqe_lock(hba, hwq);
 	}
@@ -5557,7 +5557,7 @@ static void ufshcd_mcq_compl_pending_transfer(struct ufs_hba *hba,
 
 		utag = blk_mq_unique_tag(scsi_cmd_to_rq(cmd));
 		hwq_num = blk_mq_unique_tag_to_hwq(utag);
-		hwq = &hba->uhq[hwq_num + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+		hwq = &hba->uhq[hwq_num];
 
 		if (force_compl) {
 			ufshcd_mcq_compl_all_cqes_lock(hba, hwq);
-- 
2.18.0

