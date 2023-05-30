Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DE37153B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 04:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjE3CdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 22:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjE3Ccx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 22:32:53 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFECC7;
        Mon, 29 May 2023 19:32:47 -0700 (PDT)
X-UUID: 401595dafe9211edb20a276fd37b9834-20230530
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=PBqFsa/weq3PHtNfIX6O/WeVTFrbyH6+RaXkW1b0lxc=;
        b=ghg51iciJmRSC3j6TbankfeCmXE7I/ogVlzIGE5WRXldRHappxXldB21iIljT1ZcSPeMcEABqMdP4wQywIJ/wIdaqLTMCzwIjDnOJ7b5lEpVOD0+FcdLarUEa5sLcGX+Xdd/zM0sOGQmTak5BjS+4DYynDudbKrEogPwbdQf+Fo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:afdd3814-e46e-49a3-a46e-9f5428d2b191,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACT
        ION:release,TS:75
X-CID-INFO: VERSION:1.1.25,REQID:afdd3814-e46e-49a3-a46e-9f5428d2b191,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACT
        ION:quarantine,TS:75
X-CID-META: VersionHash:d5b0ae3,CLOUDID:8584646d-2f20-4998-991c-3b78627e4938,B
        ulkID:230530103242OHM7VIXJ,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|38,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 401595dafe9211edb20a276fd37b9834-20230530
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1170194461; Tue, 30 May 2023 10:32:41 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 30 May 2023 10:32:40 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 30 May 2023 10:32:39 +0800
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
Subject: [PATCH v2 1/3] scsi: ufs: core: Introduce mcq ops to config cqid
Date:   Tue, 30 May 2023 10:32:25 +0800
Message-ID: <20230530023227.16653-2-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230530023227.16653-1-powen.kao@mediatek.com>
References: <20230530023227.16653-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Wang <peter.wang@mediatek.com>

MCQ sq/cq mapping is not just one for one, could many for one.
This patch allow host driver to change the mapping, assign cqid
for each hw queue.

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Signed-off-by: Peter Wang <peter.wang@mediatek.com>
---
 drivers/ufs/core/ufs-mcq.c     |  2 +-
 drivers/ufs/core/ufshcd-priv.h |  8 ++++++++
 drivers/ufs/core/ufshcd.c      | 11 +++++++++++
 include/ufs/ufshcd.h           |  3 +++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
index 51b3c6ae781d..1ba9c395c6b0 100644
--- a/drivers/ufs/core/ufs-mcq.c
+++ b/drivers/ufs/core/ufs-mcq.c
@@ -368,7 +368,7 @@ void ufshcd_mcq_make_queues_operational(struct ufs_hba *hba)
 		 * Submission Queue Attribute
 		 */
 		ufsmcq_writel(hba, (1 << QUEUE_EN_OFFSET) | qsize |
-			      (i << QUEUE_ID_OFFSET),
+			      (hwq->cqid << QUEUE_ID_OFFSET),
 			      MCQ_CFG_n(REG_SQATTR, i));
 	}
 }
diff --git a/drivers/ufs/core/ufshcd-priv.h b/drivers/ufs/core/ufshcd-priv.h
index d53b93c21a0c..2de068b96c71 100644
--- a/drivers/ufs/core/ufshcd-priv.h
+++ b/drivers/ufs/core/ufshcd-priv.h
@@ -287,6 +287,14 @@ static inline int ufshcd_mcq_vops_config_esi(struct ufs_hba *hba)
 	return -EOPNOTSUPP;
 }
 
+static inline int ufshcd_mcq_vops_config_cqid(struct ufs_hba *hba)
+{
+	if (hba->vops && hba->vops->config_cqid)
+		return hba->vops->config_cqid(hba);
+
+	return -EOPNOTSUPP;
+}
+
 extern const struct ufs_pm_lvl_states ufs_pm_lvl_states[];
 
 /**
diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
index 4ec8dacb447c..fad9ff4469b0 100644
--- a/drivers/ufs/core/ufshcd.c
+++ b/drivers/ufs/core/ufshcd.c
@@ -8488,11 +8488,22 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
 static void ufshcd_config_mcq(struct ufs_hba *hba)
 {
 	int ret;
+	struct ufs_hw_queue *hwq;
+	int i;
 
 	ret = ufshcd_mcq_vops_config_esi(hba);
 	dev_info(hba->dev, "ESI %sconfigured\n", ret ? "is not " : "");
 
 	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
+
+	ret = ufshcd_mcq_vops_config_cqid(hba);
+	if (ret) {
+		for (i = 0; i < hba->nr_hw_queues; i++) {
+			hwq = &hba->uhq[i];
+			hwq->cqid = i;
+		}
+	}
+
 	ufshcd_mcq_make_queues_operational(hba);
 	ufshcd_mcq_config_mac(hba, hba->nutrs);
 
diff --git a/include/ufs/ufshcd.h b/include/ufs/ufshcd.h
index df1d04f7a542..d5b16f968d7f 100644
--- a/include/ufs/ufshcd.h
+++ b/include/ufs/ufshcd.h
@@ -307,6 +307,7 @@ struct ufs_pwr_mode_info {
  * @op_runtime_config: called to config Operation and runtime regs Pointers
  * @get_outstanding_cqs: called to get outstanding completion queues
  * @config_esi: called to config Event Specific Interrupt
+ * @config_cqid: called to config cqid for each sq
  */
 struct ufs_hba_variant_ops {
 	const char *name;
@@ -352,6 +353,7 @@ struct ufs_hba_variant_ops {
 	int	(*get_outstanding_cqs)(struct ufs_hba *hba,
 				       unsigned long *ocqs);
 	int	(*config_esi)(struct ufs_hba *hba);
+	int	(*config_cqid)(struct ufs_hba *hba);
 };
 
 /* clock gating state  */
@@ -1100,6 +1102,7 @@ struct ufs_hw_queue {
 	dma_addr_t cqe_dma_addr;
 	u32 max_entries;
 	u32 id;
+	u32 cqid;
 	u32 sq_tail_slot;
 	spinlock_t sq_lock;
 	u32 cq_tail_slot;
-- 
2.18.0

