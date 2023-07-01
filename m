Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833F8744908
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjGAMpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 08:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGAMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 08:45:03 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BB03C07;
        Sat,  1 Jul 2023 05:45:01 -0700 (PDT)
X-UUID: 1376190c180d11eeb20a276fd37b9834-20230701
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=iMf+GJc87C5Hnnat9BjteQm2geXRCU6Mvkwfdrb8zco=;
        b=HWkqraTaQAgmmMy6qRluNvi5Pp3NqYCBHvdGQuV1Pu1i/SpNVm+JANnzkn40OAjg1my5TS3NMyHt8gSidUpOZ/YggoZAyEt7h7/Bm+YYNUqME17D+TGI52xZtlEUXpf8xSgN5+4NEX5f4Ii/cENlOFlBI4Q7odrT5ie1ROdyLWs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:bed59244-35f2-438b-9cca-392104b748ce,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:d5e981da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 1376190c180d11eeb20a276fd37b9834-20230701
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <powen.kao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2121563953; Sat, 01 Jul 2023 20:44:53 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Sat, 1 Jul 2023 20:44:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Sat, 1 Jul 2023 20:44:52 +0800
From:   Po-Wen Kao <powen.kao@mediatek.com>
To:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     <wsd_upstream@mediatek.com>, <peter.wang@mediatek.com>,
        <powen.kao@mediatek.com>, <alice.chao@mediatek.com>,
        <naomi.chu@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <cc.chou@mediatek.com>, <eddie.huang@mediatek.com>
Subject: [PATCH v5 2/2] scsi: ufs: ufs-mediatek: Add MCQ support for MTK platform
Date:   Sat, 1 Jul 2023 20:44:41 +0800
Message-ID: <20230701124442.10489-3-powen.kao@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230701124442.10489-1-powen.kao@mediatek.com>
References: <20230701124442.10489-1-powen.kao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add UFS MCQ vops and irq handler for MediaTek platform.
PM flow is fixed accordingly.

Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/ufs/host/ufs-mediatek.c | 174 +++++++++++++++++++++++++++++++-
 drivers/ufs/host/ufs-mediatek.h |  33 ++++++
 2 files changed, 205 insertions(+), 2 deletions(-)

diff --git a/drivers/ufs/host/ufs-mediatek.c b/drivers/ufs/host/ufs-mediatek.c
index e68b05976f9e..786b1469eb52 100644
--- a/drivers/ufs/host/ufs-mediatek.c
+++ b/drivers/ufs/host/ufs-mediatek.c
@@ -27,8 +27,14 @@
 #include <ufs/unipro.h>
 #include "ufs-mediatek.h"
 
+static int  ufs_mtk_config_mcq(struct ufs_hba *hba, bool irq);
+
 #define CREATE_TRACE_POINTS
 #include "ufs-mediatek-trace.h"
+#undef CREATE_TRACE_POINTS
+
+#define MAX_SUPP_MAC 64
+#define MCQ_QUEUE_OFFSET(c) ((((c) >> 16) & 0xFF) * 0x200)
 
 static const struct ufs_dev_quirk ufs_mtk_dev_fixups[] = {
 	{ .wmanufacturerid = UFS_ANY_VENDOR,
@@ -840,6 +846,38 @@ static void ufs_mtk_vreg_fix_vccqx(struct ufs_hba *hba)
 	}
 }
 
+static void ufs_mtk_init_mcq_irq(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
+	struct platform_device *pdev;
+	int i;
+	int irq;
+
+	host->mcq_nr_intr = UFSHCD_MAX_Q_NR;
+	pdev = container_of(hba->dev, struct platform_device, dev);
+
+	for (i = 0; i < host->mcq_nr_intr; i++) {
+		/* irq index 0 is legacy irq, sq/cq irq start from index 1 */
+		irq = platform_get_irq(pdev, i + 1);
+		if (irq < 0) {
+			host->mcq_intr_info[i].irq = MTK_MCQ_INVALID_IRQ;
+			dev_err(hba->dev, "get platform mcq irq fail: %d\n", i);
+			goto failed;
+		}
+		host->mcq_intr_info[i].hba = hba;
+		host->mcq_intr_info[i].irq = irq;
+		dev_info(hba->dev, "get platform mcq irq: %d, %d\n", i, irq);
+	}
+
+	return;
+failed:
+       /* invalidate irq info */
+	for (i = 0; i < host->mcq_nr_intr; i++)
+		host->mcq_intr_info[i].irq = MTK_MCQ_INVALID_IRQ;
+
+	host->mcq_nr_intr = 0;
+}
+
 /**
  * ufs_mtk_init - find other essential mmio bases
  * @hba: host controller instance
@@ -876,6 +914,8 @@ static int ufs_mtk_init(struct ufs_hba *hba)
 	/* Initialize host capability */
 	ufs_mtk_init_host_caps(hba);
 
+	ufs_mtk_init_mcq_irq(hba);
+
 	err = ufs_mtk_bind_mphy(hba);
 	if (err)
 		goto out_variant_clear;
@@ -1173,7 +1213,17 @@ static int ufs_mtk_link_set_hpm(struct ufs_hba *hba)
 	else
 		return err;
 
-	err = ufshcd_make_hba_operational(hba);
+	if (!hba->mcq_enabled) {
+		err = ufshcd_make_hba_operational(hba);
+	} else {
+		ufs_mtk_config_mcq(hba, false);
+		ufshcd_mcq_make_queues_operational(hba);
+		ufshcd_mcq_config_mac(hba, hba->nutrs);
+		/* Enable MCQ mode */
+		ufshcd_writel(hba, ufshcd_readl(hba, REG_UFS_MEM_CFG) | 0x1,
+			      REG_UFS_MEM_CFG);
+	}
+
 	if (err)
 		return err;
 
@@ -1497,6 +1547,121 @@ static int ufs_mtk_clk_scale_notify(struct ufs_hba *hba, bool scale_up,
 	return 0;
 }
 
+static int ufs_mtk_get_hba_mac(struct ufs_hba *hba)
+{
+	return MAX_SUPP_MAC;
+}
+
+static int ufs_mtk_op_runtime_config(struct ufs_hba *hba)
+{
+	struct ufshcd_mcq_opr_info_t *opr;
+	int i;
+
+	hba->mcq_opr[OPR_SQD].offset = REG_UFS_MTK_SQD;
+	hba->mcq_opr[OPR_SQIS].offset = REG_UFS_MTK_SQIS;
+	hba->mcq_opr[OPR_CQD].offset = REG_UFS_MTK_CQD;
+	hba->mcq_opr[OPR_CQIS].offset = REG_UFS_MTK_CQIS;
+
+	for (i = 0; i < OPR_MAX; i++) {
+		opr = &hba->mcq_opr[i];
+		opr->stride = REG_UFS_MCQ_STRIDE;
+		opr->base = hba->mmio_base + opr->offset;
+	}
+
+	return 0;
+}
+
+static int ufs_mtk_mcq_config_resource(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
+
+	/* fail mcq initialization if interrupt is not filled properly */
+	if (!host->mcq_nr_intr) {
+		dev_info(hba->dev, "IRQs not ready. MCQ disabled.");
+		return -EINVAL;
+	}
+
+	hba->mcq_base = hba->mmio_base + MCQ_QUEUE_OFFSET(hba->mcq_capabilities);
+	return 0;
+}
+
+static irqreturn_t ufs_mtk_mcq_intr(int irq, void *__intr_info)
+{
+	struct ufs_mtk_mcq_intr_info *mcq_intr_info = __intr_info;
+	struct ufs_hba *hba = mcq_intr_info->hba;
+	struct ufs_hw_queue *hwq;
+	u32 events;
+	int qid = mcq_intr_info->qid;
+
+	hwq = &hba->uhq[qid];
+
+	events = ufshcd_mcq_read_cqis(hba, qid);
+	if (events)
+		ufshcd_mcq_write_cqis(hba, events, qid);
+
+	if (events & UFSHCD_MCQ_CQIS_TAIL_ENT_PUSH_STS)
+		ufshcd_mcq_poll_cqe_lock(hba, hwq);
+
+	return IRQ_HANDLED;
+}
+
+static int ufs_mtk_config_mcq_irq(struct ufs_hba *hba)
+{
+	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
+	u32 irq, i;
+	int ret;
+
+	for (i = 0; i < host->mcq_nr_intr; i++) {
+		irq = host->mcq_intr_info[i].irq;
+		if (irq == MTK_MCQ_INVALID_IRQ) {
+			dev_err(hba->dev, "invalid irq. %d\n", i);
+			return -ENOPARAM;
+		}
+
+		host->mcq_intr_info[i].qid = i;
+		ret = devm_request_irq(hba->dev, irq, ufs_mtk_mcq_intr, 0, UFSHCD,
+				       &host->mcq_intr_info[i]);
+
+		dev_dbg(hba->dev, "request irq %d intr %s\n", irq, ret ? "failed" : "");
+
+		if (ret) {
+			dev_err(hba->dev, "Cannot request irq %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int ufs_mtk_config_mcq(struct ufs_hba *hba, bool irq)
+{
+	struct ufs_mtk_host *host = ufshcd_get_variant(hba);
+	int ret = 0;
+
+	if (!host->mcq_set_intr) {
+		/* Disable irq option register */
+		ufshcd_rmwl(hba, MCQ_INTR_EN_MSK, 0, REG_UFS_MMIO_OPT_CTRL_0);
+
+		if (irq) {
+			ret = ufs_mtk_config_mcq_irq(hba);
+			if (ret)
+				return ret;
+		}
+
+		host->mcq_set_intr = true;
+	}
+
+	ufshcd_rmwl(hba, MCQ_AH8, MCQ_AH8, REG_UFS_MMIO_OPT_CTRL_0);
+	ufshcd_rmwl(hba, MCQ_INTR_EN_MSK, MCQ_MULTI_INTR_EN, REG_UFS_MMIO_OPT_CTRL_0);
+
+	return 0;
+}
+
+static int ufs_mtk_config_esi(struct ufs_hba *hba)
+{
+	return ufs_mtk_config_mcq(hba, true);
+}
+
 /*
  * struct ufs_hba_mtk_vops - UFS MTK specific variant operations
  *
@@ -1520,6 +1685,11 @@ static const struct ufs_hba_variant_ops ufs_hba_mtk_vops = {
 	.event_notify        = ufs_mtk_event_notify,
 	.config_scaling_param = ufs_mtk_config_scaling_param,
 	.clk_scale_notify    = ufs_mtk_clk_scale_notify,
+	/* mcq vops */
+	.get_hba_mac         = ufs_mtk_get_hba_mac,
+	.op_runtime_config   = ufs_mtk_op_runtime_config,
+	.mcq_config_resource = ufs_mtk_mcq_config_resource,
+	.config_esi          = ufs_mtk_config_esi,
 };
 
 /**
@@ -1566,7 +1736,7 @@ static int ufs_mtk_probe(struct platform_device *pdev)
 
 out:
 	if (err)
-		dev_info(dev, "probe failed %d\n", err);
+		dev_err(dev, "probe failed %d\n", err);
 
 	of_node_put(reset_node);
 	return err;
diff --git a/drivers/ufs/host/ufs-mediatek.h b/drivers/ufs/host/ufs-mediatek.h
index 2fc6d7b87694..f76e80d91729 100644
--- a/drivers/ufs/host/ufs-mediatek.h
+++ b/drivers/ufs/host/ufs-mediatek.h
@@ -10,11 +10,27 @@
 #include <linux/pm_qos.h>
 #include <linux/soc/mediatek/mtk_sip_svc.h>
 
+/*
+ * MCQ define and struct
+ */
+#define UFSHCD_MAX_Q_NR 8
+#define MTK_MCQ_INVALID_IRQ	0xFFFF
+
+/* REG_UFS_MMIO_OPT_CTRL_0 160h */
+#define EHS_EN                  BIT(0)
+#define PFM_IMPV                BIT(1)
+#define MCQ_MULTI_INTR_EN       BIT(2)
+#define MCQ_CMB_INTR_EN         BIT(3)
+#define MCQ_AH8                 BIT(4)
+
+#define MCQ_INTR_EN_MSK         (MCQ_MULTI_INTR_EN | MCQ_CMB_INTR_EN)
+
 /*
  * Vendor specific UFSHCI Registers
  */
 #define REG_UFS_XOUFS_CTRL          0x140
 #define REG_UFS_REFCLK_CTRL         0x144
+#define REG_UFS_MMIO_OPT_CTRL_0     0x160
 #define REG_UFS_EXTREG              0x2100
 #define REG_UFS_MPHYCTRL            0x2200
 #define REG_UFS_MTK_IP_VER          0x2240
@@ -26,6 +42,13 @@
 #define REG_UFS_DEBUG_SEL_B2        0x22D8
 #define REG_UFS_DEBUG_SEL_B3        0x22DC
 
+#define REG_UFS_MTK_SQD             0x2800
+#define REG_UFS_MTK_SQIS            0x2814
+#define REG_UFS_MTK_CQD             0x281C
+#define REG_UFS_MTK_CQIS            0x2824
+
+#define REG_UFS_MCQ_STRIDE          0x30
+
 /*
  * Ref-clk control
  *
@@ -136,6 +159,12 @@ struct ufs_mtk_hw_ver {
 	u8 major;
 };
 
+struct ufs_mtk_mcq_intr_info {
+	struct ufs_hba *hba;
+	u32 irq;
+	u8 qid;
+};
+
 struct ufs_mtk_host {
 	struct phy *mphy;
 	struct pm_qos_request pm_qos_req;
@@ -155,6 +184,10 @@ struct ufs_mtk_host {
 	u16 ref_clk_ungating_wait_us;
 	u16 ref_clk_gating_wait_us;
 	u32 ip_ver;
+
+	bool mcq_set_intr;
+	int mcq_nr_intr;
+	struct ufs_mtk_mcq_intr_info mcq_intr_info[UFSHCD_MAX_Q_NR];
 };
 
 /*
-- 
2.18.0

