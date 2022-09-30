Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7735F081B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiI3J7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbiI3J7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:59:24 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A217F57B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 02:59:23 -0700 (PDT)
X-UUID: 6e73177e5cdb4429a5db4e4511c8a504-20220930
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=OPkDtzEKMc44Gee321IZuVadohuiA7avmD+GueB2S78=;
        b=igWghUbfGFwIsiTVFXR6YSxxSBy/neK59Jsh62JPDmu/+3fjh1MqzTu5iv3ZY2kGAw8FfDZpx2b8FL5CrpuMGrvm83vhrzTatGf0GYF0CZybTbc/oLL92ZVLcXXaLKYj9kT+iD9iy2vRW+8ziUFGsXeTEKTKS7aSY5c2V2V4sRk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:f60a730e-7118-4276-a92e-710e5a0f6acc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-INFO: VERSION:1.1.11,REQID:f60a730e-7118-4276-a92e-710e5a0f6acc,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:100
X-CID-META: VersionHash:39a5ff1,CLOUDID:cb0f9307-1cee-4c38-b21b-a45f9682fdc0,B
        ulkID:220930175919TZ4JGI2Z,BulkQuantity:1,Recheck:0,SF:38|28|17|19|48|823|
        824,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:43,QS:nil,BEC:nil,C
        OL:0
X-UUID: 6e73177e5cdb4429a5db4e4511c8a504-20220930
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 346731513; Fri, 30 Sep 2022 17:59:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Sep 2022 17:59:18 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 30 Sep 2022 17:59:17 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v7, 1/3] mailbox: mtk-cmdq: add gce software ddr enable private data
Date:   Fri, 30 Sep 2022 17:59:13 +0800
Message-ID: <20220930095915.13684-2-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220930095915.13684-1-yongqiang.niu@mediatek.com>
References: <20220930095915.13684-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if gce work control by software, we need set software enable
for MT8186 Soc

there is a handshake flow between gce and ddr hardware,
if not set ddr enable flag of gce, ddr will fall into idle
mode, then gce instructions will not process done.
we need set this flag of gce to tell ddr when gce is idle or busy
controlled by software flow.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 9465f9081515..04eb44d89119 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -38,6 +38,8 @@
 #define CMDQ_THR_PRIORITY		0x40
 
 #define GCE_GCTL_VALUE			0x48
+#define GCE_CTRL_BY_SW				GENMASK(2, 0)
+#define GCE_DDR_EN				GENMASK(18, 16)
 
 #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
 #define CMDQ_THR_ENABLED		0x1
@@ -80,6 +82,7 @@ struct cmdq {
 	bool			suspended;
 	u8			shift_pa;
 	bool			control_by_sw;
+	bool			sw_ddr_en;
 	u32			gce_num;
 };
 
@@ -87,6 +90,7 @@ struct gce_plat {
 	u32 thread_nr;
 	u8 shift;
 	bool control_by_sw;
+	bool sw_ddr_en;
 	u32 gce_num;
 };
 
@@ -129,7 +133,11 @@ static void cmdq_init(struct cmdq *cmdq)
 
 	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
 	if (cmdq->control_by_sw)
-		writel(0x7, cmdq->base + GCE_GCTL_VALUE);
+		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
+
+	if (cmdq->sw_ddr_en)
+		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
+
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
 	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
 		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
@@ -543,6 +551,7 @@ static int cmdq_probe(struct platform_device *pdev)
 	cmdq->thread_nr = plat_data->thread_nr;
 	cmdq->shift_pa = plat_data->shift;
 	cmdq->control_by_sw = plat_data->control_by_sw;
+	cmdq->sw_ddr_en = plat_data->sw_ddr_en;
 	cmdq->gce_num = plat_data->gce_num;
 	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
 	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
-- 
2.25.1

