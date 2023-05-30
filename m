Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0627153BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjE3Cfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjE3Cfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:35:42 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F682A8;
        Mon, 29 May 2023 19:35:40 -0700 (PDT)
X-UUID: a78ac122fe9211edb20a276fd37b9834-20230530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=tSaSwwJtyoBK8YovNl2njVmz4eBCrNqFoZbYD4m2NVc=;
        b=mDXDvTkQO/w2wEPm0QTiRzKYnkHaYKy5T3oqJ524ZH46AU8L1YHn/jj/lxwlMiW/LlpSWsg7t460ox1lqOM4dpVJMpeRD/hjvSvRUqcqejEoC2+CMhdXaHgiGj6ZtkY8f1WgsDd5grwJ5W0KroINuNmM3Dsb2QPV6Rt9WdnWqlY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:ef1563fb-14d8-41d2-b53f-94d513ece48a,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:d5b0ae3,CLOUDID:78a0646d-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: a78ac122fe9211edb20a276fd37b9834-20230530
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2128892758; Tue, 30 May 2023 10:35:34 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 10:35:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 10:35:33 +0800
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
Subject: [PATCH v2 1/1] scsi: ufs: core: Make UFS_MCQ_NUM_DEV_CMD_QUEUES a module parameter
Date:   Tue, 30 May 2023 10:35:17 +0800
Message-ID: <20230530023518.16965-1-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
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

A dedicated queue for dev commands is not mandatory, hence let
UFS_MCQ_NUM_DEV_CMD_QUEUES become module parameter `dev_cmd_queues`
to allow sharing first hw queue for dev commands.

When `dev_cmd_queues` is set to 0, the hwq 0 will be shared for I/O
requests and dev commands. In the same hwq, commands are processed based
on submission order hence might take longer to dispatch dev command
under heavy traffic. For the host with dedicated hwq for dev commands
can benefit in such scenario.

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c     | 35 +++++++++++++++++++++++++++-------
 drivers/ufs/core/ufshcd-priv.h |  2 +-
 drivers/ufs/core/ufshcd.c      |  2 +-
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 51b3c6ae781d..4ef48c84e62f 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -16,7 +16,8 @@
 #define MAX_QUEUE_SUP GENMASK(7, 0)
 #define UFS_MCQ_MIN_RW_QUEUES 2
 #define UFS_MCQ_MIN_READ_QUEUES 0
-#define UFS_MCQ_NUM_DEV_CMD_QUEUES 1
+#define UFS_MCQ_MAX_DEV_CMD_QUEUES 1
+#define UFS_MCQ_MIN_DEV_CMD_QUEUES 0
 #define UFS_MCQ_MIN_POLL_QUEUES 0
 #define QUEUE_EN_OFFSET 31
 #define QUEUE_ID_OFFSET 16
@@ -75,6 +76,23 @@ module_param_cb(poll_queues, &poll_queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues,
 		 "Number of poll queues used for r/w. Default value is 1");
 
+static int dev_cmd_queue_count_set(const char *val, const struct kernel_param *kp)
+{
+	return param_set_uint_minmax(val, kp,
+				     UFS_MCQ_MIN_DEV_CMD_QUEUES,
+				     UFS_MCQ_MAX_DEV_CMD_QUEUES);
+}
+
+static const struct kernel_param_ops dev_cmd_queue_count_ops = {
+	.set = dev_cmd_queue_count_set,
+	.get = param_get_uint,
+};
+
+unsigned int dev_cmd_queues = 1;
+module_param_cb(dev_cmd_queues, &dev_cmd_queue_count_ops, &dev_cmd_queues, 0644);
+MODULE_PARM_DESC(dev_cmd_queues,
+		 "Number of queues used for dev command. Default value is 1");
+
 /**
  * ufshcd_mcq_config_mac - Set the #Max Activ Cmds.
  * @hba: per adapter instance
@@ -109,7 +127,7 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 	u32 hwq = blk_mq_unique_tag_to_hwq(utag);
 
 	/* uhq[0] is used to serve device commands */
-	return &hba->uhq[hwq + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+	return &hba->uhq[hwq + dev_cmd_queues];
 }
 
 /**
@@ -153,7 +171,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 	/* maxq is 0 based value */
 	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1;
 
-	tot_queues = UFS_MCQ_NUM_DEV_CMD_QUEUES + read_queues + poll_queues +
+	tot_queues = dev_cmd_queues + read_queues + poll_queues +
 			rw_queues;
 
 	if (hba_maxq < tot_queues) {
@@ -162,7 +180,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 		return -EOPNOTSUPP;
 	}
 
-	rem = hba_maxq - UFS_MCQ_NUM_DEV_CMD_QUEUES;
+	rem = hba_maxq - dev_cmd_queues;
 
 	if (rw_queues) {
 		hba->nr_queues[HCTX_TYPE_DEFAULT] = rw_queues;
@@ -188,7 +206,7 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
 	for (i = 0; i < HCTX_MAX_TYPES; i++)
 		host->nr_hw_queues += hba->nr_queues[i];
 
-	hba->nr_hw_queues = host->nr_hw_queues + UFS_MCQ_NUM_DEV_CMD_QUEUES;
+	hba->nr_hw_queues = host->nr_hw_queues + dev_cmd_queues;
 	return 0;
 }
 
@@ -424,8 +442,11 @@ int ufshcd_mcq_init(struct ufs_hba *hba)
 
 	/* The very first HW queue serves device commands */
 	hba->dev_cmd_queue = &hba->uhq[0];
-	/* Give dev_cmd_queue the minimal number of entries */
-	hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
+	if (dev_cmd_queues) {
+		/* Give dedicated dev_cmd_queue the minimal number of entries */
+		hba->dev_cmd_queue->max_entries = MAX_DEV_CMD_ENTRIES;
+	}
+
 
 	host->host_tagset = 1;
 	return 0;
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d53b93c21a0c..b490d645f12c 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -78,7 +78,6 @@ struct ufs_hw_queue *ufshcd_mcq_req_to_hwq(struct ufs_hba *hba,
 unsigned long ufshcd_mcq_poll_cqe_lock(struct ufs_hba *hba,
 				       struct ufs_hw_queue *hwq);
 
-#define UFSHCD_MCQ_IO_QUEUE_OFFSET	1
 #define SD_ASCII_STD true
 #define SD_RAW false
 int ufshcd_read_string_desc(struct ufs_hba *hba, u8 desc_index,
@@ -287,6 +286,7 @@ static inline int ufshcd_mcq_vops_config_esi(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+extern unsigned int dev_cmd_queues;
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4ec8dacb447c..6361e21ca1c5 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -5493,7 +5493,7 @@ static int ufshcd_poll(struct Scsi_Host *shost, unsigned int queue_num)
 	struct ufs_hw_queue *hwq;
 
 	if (is_mcq_enabled(hba)) {
-		hwq = &hba->uhq[queue_num + UFSHCD_MCQ_IO_QUEUE_OFFSET];
+		hwq = &hba->uhq[queue_num + dev_cmd_queues];
 
 		return ufshcd_mcq_poll_cqe_lock(hba, hwq);
 	}
-- 
2.18.0

