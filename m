Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 672B869ED3A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 04:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBVDFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 22:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjBVDEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 22:04:53 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91E32313B;
        Tue, 21 Feb 2023 19:04:49 -0800 (PST)
X-UUID: a6d0ecceb25d11eda06fc9ecc4dadd91-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=nQ1FI+tZAutpfgYwGq8uJe/0tKi1xigqaET55cH0i18=;
        b=n7L0jHbvXc6KR79OOT0ES2APw3aba7Fa0oA7e59H4ATGvXV9bo1kFdGKcD50mYap7B6GlmDBUIMQjj8axa3T9Y9o6VPz9+pMEFG67fd+Q/kgeVJBwtTh+XuJoKj4EwLuDuC8rmZhG8/gJ+U646tIVa/CowEpgC0qBup/wEGIlQw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:a43d1e02-80e8-4257-b57d-52f4a73d6184,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:25b5999,CLOUDID:d5452fb1-beed-4dfc-bd9c-e1b22fa6ccc4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-UUID: a6d0ecceb25d11eda06fc9ecc4dadd91-20230222
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1563489553; Wed, 22 Feb 2023 11:04:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 22 Feb 2023 11:04:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 11:04:40 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <stanley.chu@mediatek.com>, <powen.kao@mediatek.com>,
        <alice.chao@mediatek.com>, <naomi.chu@mediatek.com>,
        <chun-hung.wu@mediatek.com>, <cc.chou@mediatek.com>,
        <eddie.huang@mediatek.com>, <mason.zhang@mediatek.com>,
        <chaotian.jing@mediatek.com>, <jiajie.hao@mediatek.com>
Subject: [PATCH v2 4/7] scsi: ufs: core: Add hwq print for debug
Date:   Wed, 22 Feb 2023 11:04:21 +0800
Message-ID: <20230222030427.957-5-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230222030427.957-1-powen.kao@mediatek.com>
References: <20230222030427.957-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce hwq printing function for debug purpose.
- ufshcd_mcq_print_hwqs()

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c     | 32 +++++++++++++++++++++++++++++++-
 drivers/ufs/core/ufshcd-priv.h |  9 +++++++++
 drivers/ufs/core/ufshcd.c      | 18 +++++++++++-------
 include/ufs/ufshci.h           | 12 ++++++++++++
 4 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 5d5bc0bc6e88..d1ff3ccd2085 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -23,7 +23,6 @@
 
 #define MAX_DEV_CMD_ENTRIES	2
 #define MCQ_CFG_MAC_MASK	GENMASK(16, 8)
-#define MCQ_QCFG_SIZE		0x40
 #define MCQ_ENTRY_SIZE_IN_DWORD	8
 #define CQE_UCD_BA GENMASK_ULL(63, 7)
 
@@ -75,6 +74,13 @@ module_param_cb(poll_queues, &poll_queue_count_ops, &poll_queues, 0644);
 MODULE_PARM_DESC(poll_queues,
 		 "Number of poll queues used for r/w. Default value is 1");
 
+static const int mcq_opr_size[] = {
+	MCQ_SQD_SIZE,
+	MCQ_SQIS_SIZE,
+	MCQ_CQD_SIZE,
+	MCQ_CQIS_SIZE,
+};
+
 /**
  * ufshcd_mcq_config_mac - Set the #Max Activ Cmds.
  * @hba: per adapter instance
@@ -237,6 +243,30 @@ static void __iomem *mcq_opr_base(struct ufs_hba *hba,
 	return opr->base + opr->stride * i;
 }
 
+void ufshcd_mcq_print_hwqs(struct ufs_hba *hba, unsigned long bitmap)
+{
+	int id, i;
+	char prefix[15];
+
+	if (!is_mcq_enabled(hba))
+		return;
+
+	for_each_set_bit(id, &bitmap, hba->nr_hw_queues) {
+		snprintf(prefix, sizeof(prefix), "q%d SQCFG: ", id);
+		ufshcd_hex_dump(prefix,
+			hba->mcq_base + MCQ_QCFG_SIZE * id, MCQ_QCFG_SQ_SIZE);
+
+		snprintf(prefix, sizeof(prefix), "q%d CQCFG: ", id);
+		ufshcd_hex_dump(prefix,
+			hba->mcq_base + MCQ_QCFG_SIZE * id + MCQ_QCFG_SQ_SIZE, MCQ_QCFG_CQ_SIZE);
+
+		for (i = 0; i < OPR_MAX ; i++) {
+			snprintf(prefix, sizeof(prefix), "q%d OPR%d: ", id, i);
+			ufshcd_hex_dump(prefix, mcq_opr_base(hba, i, id), mcq_opr_size[i]);
+		}
+	}
+}
+
 u32 ufshcd_mcq_read_cqis(struct ufs_hba *hba, int i)
 {
 	return readl(mcq_opr_base(hba, OPR_CQIS, i) + REG_CQIS);
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index 529f8507a5e4..13534a9a6d0a 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -6,6 +6,14 @@
 #include <linux/pm_runtime.h>
 #include <ufs/ufshcd.h>
 
+#define ufshcd_hex_dump(prefix_str, buf, len) do {                       \
+	size_t __len = (len);                                            \
+	print_hex_dump(KERN_ERR, prefix_str,                             \
+		       __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,\
+		       16, 4, buf, __len, false);                        \
+} while (0)
+
+
 static inline bool ufshcd_is_user_access_allowed(struct ufs_hba *hba)
 {
 	return !hba->shutting_down;
@@ -65,6 +73,7 @@ void ufshcd_compl_one_cqe(struct ufs_hba *hba, int task_tag,
 			  struct cq_entry *cqe);
 int ufshcd_mcq_init(struct ufs_hba *hba);
 int ufshcd_mcq_decide_queue_depth(struct ufs_hba *hba);
+void ufshcd_mcq_print_hwqs(struct ufs_hba *hba, unsigned long bitmap);
 int ufshcd_mcq_memory_alloc(struct ufs_hba *hba);
 void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba);
 void ufshcd_mcq_config_mac(struct ufs_hba *hba, u32 max_active_cmds);
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 81c9f07ebfc8..a15a5a78160c 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -135,13 +135,6 @@ MODULE_PARM_DESC(use_mcq_mode, "Control MCQ mode for controllers starting from U
 		_ret;                                                   \
 	})
 
-#define ufshcd_hex_dump(prefix_str, buf, len) do {                       \
-	size_t __len = (len);                                            \
-	print_hex_dump(KERN_ERR, prefix_str,                             \
-		       __len > 4 ? DUMP_PREFIX_OFFSET : DUMP_PREFIX_NONE,\
-		       16, 4, buf, __len, false);                        \
-} while (0)
-
 int ufshcd_dump_regs(struct ufs_hba *hba, size_t offset, size_t len,
 		     const char *prefix)
 {
@@ -536,6 +529,8 @@ static
 void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 {
 	const struct ufshcd_lrb *lrbp;
+	struct ufs_hw_queue *hwq;
+	struct scsi_cmnd *cmd;
 	int prdt_length;
 	int tag;
 
@@ -574,7 +569,16 @@ void ufshcd_print_trs(struct ufs_hba *hba, unsigned long bitmap, bool pr_prdt)
 		if (pr_prdt)
 			ufshcd_hex_dump("UPIU PRDT: ", lrbp->ucd_prdt_ptr,
 				ufshcd_sg_entry_size(hba) * prdt_length);
+
+		if (is_mcq_enabled(hba)) {
+			cmd = lrbp->cmd;
+			if (!cmd)
+				return;
+			hwq = ufshcd_mcq_req_to_hwq(hba, scsi_cmd_to_rq(cmd));
+			ufshcd_mcq_print_hwqs(hba, 1 << hwq->id);
+		}
 	}
+
 }
 
 static void ufshcd_print_tmrs(struct ufs_hba *hba, unsigned long bitmap)
diff --git a/include/ufs/ufshci.h b/include/ufs/ufshci.h
index 11424bb03814..027a2e884f89 100644
--- a/include/ufs/ufshci.h
+++ b/include/ufs/ufshci.h
@@ -185,6 +185,18 @@ static inline u32 ufshci_version(u32 major, u32 minor)
 				CRYPTO_ENGINE_FATAL_ERROR |\
 				UIC_LINK_LOST)
 
+/* MCQ size */
+#define MCQ_QCFG_SIZE			0x40
+#define MCQ_QCFG_SQ_SIZE		0x20
+#define MCQ_QCFG_CQ_SIZE		0x20
+
+enum {
+	MCQ_SQD_SIZE		= 0x14,
+	MCQ_SQIS_SIZE		= 0x08,
+	MCQ_CQD_SIZE		= 0x08,
+	MCQ_CQIS_SIZE		= 0x0C,
+};
+
 /* HCS - Host Controller Status 30h */
 #define DEVICE_PRESENT				0x1
 #define UTP_TRANSFER_REQ_LIST_READY		0x2
-- 
2.18.0

