Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8148264D741
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbiLOH2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLOH2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:28:23 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B951209B0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:28:18 -0800 (PST)
X-UUID: c9128817d22c425a8e491a5990120b89-20221215
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=F0IkclvlLIjnR4XOpv2u+KAvfbq0vy1p7zBiIsdhSZ0=;
        b=BMIUaroAXMmxQlpIr9AIakhCkymplVXS07FJlRjHpjzS5pqTvXRZHI1PhXr9P0cDbZ7YVgakwZJUHA9qoElv02QsBWB0rCYzL3cFKLRuLGqr+o7J7RKZqf9x6k7/+RJxCZDQPJCrE5dgxtLQ0IqnejkTnnsrG4PkKJC+eowr90I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:63fd3d51-b385-403c-a8d3-7a19a051cab0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:1,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:1
X-CID-META: VersionHash:dcaaed0,CLOUDID:5a72a9b4-d2e2-434d-b6d3-aeae88dfcc78,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: c9128817d22c425a8e491a5990120b89-20221215
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1868163669; Thu, 15 Dec 2022 15:28:12 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 15 Dec 2022 15:28:10 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs13n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 15 Dec 2022 15:28:10 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v11, 2/4] mailbox: mtk-cmdq: add gce software ddr enable private data
Date:   Thu, 15 Dec 2022 15:28:04 +0800
Message-ID: <20221215072806.10224-3-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221215072806.10224-1-yongqiang.niu@mediatek.com>
References: <20221215072806.10224-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
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

0x48[2:0] means control by software
0x48[18:16] means ddr enable
0x48[2:0] is pre-condition of 0x48[18:16].
if we want set 0x48[18:16] ddr enable, 0x48[2:0] must be set at same
time.
and only these bits is useful, other bits is useless bits

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index c3cb24f51699..d2363c6b8b7a 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -39,6 +39,7 @@
 
 #define GCE_GCTL_VALUE			0x48
 #define GCE_CTRL_BY_SW				GENMASK(2, 0)
+#define GCE_DDR_EN				GENMASK(18, 16)
 
 #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
 #define CMDQ_THR_ENABLED		0x1
@@ -81,6 +82,7 @@ struct cmdq {
 	bool			suspended;
 	u8			shift_pa;
 	bool			control_by_sw;
+	bool			sw_ddr_en;
 	u32			gce_num;
 };
 
@@ -88,6 +90,7 @@ struct gce_plat {
 	u32 thread_nr;
 	u8 shift;
 	bool control_by_sw;
+	bool sw_ddr_en;
 	u32 gce_num;
 };
 
@@ -127,10 +130,16 @@ static void cmdq_thread_resume(struct cmdq_thread *thread)
 static void cmdq_init(struct cmdq *cmdq)
 {
 	int i;
+	u32 gctl_regval = 0;
 
 	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
 	if (cmdq->control_by_sw)
-		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
+		gctl_regval = GCE_CTRL_BY_SW;
+	if (cmdq->sw_ddr_en)
+		gctl_regval |= GCE_DDR_EN;
+
+	if (gctl_regval)
+		writel(gctl_regval, cmdq->base + GCE_GCTL_VALUE);
 
 	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
 	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
@@ -545,6 +554,7 @@ static int cmdq_probe(struct platform_device *pdev)
 	cmdq->thread_nr = plat_data->thread_nr;
 	cmdq->shift_pa = plat_data->shift;
 	cmdq->control_by_sw = plat_data->control_by_sw;
+	cmdq->sw_ddr_en = plat_data->sw_ddr_en;
 	cmdq->gce_num = plat_data->gce_num;
 	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
 	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,
-- 
2.25.1

