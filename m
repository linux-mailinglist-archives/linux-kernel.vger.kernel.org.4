Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA105F6026
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 06:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJFEf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 00:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJFEfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 00:35:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BCF733E1D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 21:35:05 -0700 (PDT)
X-UUID: 66c3dbb9af434f24ae32bfb86ecd6600-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=U/TQbV5m104HfRcT9S9HCCZ0p5prmyu9kaPPLbaRReM=;
        b=ORKzjQc3lUBmt1dwt0lVvyeLPzGA83TML3T762iU+iGFMiQZWmhNTdgaJ9O4+H2QY7AQE6P2hk/Zh8sLAYYAq8RbLGXnwZIinJvOPKmhN2zFOIJTQEpUTuHbiHqgg4xnttVxj3aMNjTkbVSV2SXVt2nEmtgPGDfjqY6YeH4BSKI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:1f5adf4c-3bd9-4e16-abf5-18289f5e42a0,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:65e1ab85-5312-4339-9a65-dc27c4b243b8,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 66c3dbb9af434f24ae32bfb86ecd6600-20221006
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 184232541; Thu, 06 Oct 2022 12:35:02 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 6 Oct 2022 12:35:00 +0800
Received: from localhost.localdomain (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 6 Oct 2022 12:35:00 +0800
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
Subject: [PATCH v9, 3/4] mailbox: mtk-cmdq: add gce ddr enable support flow
Date:   Thu, 6 Oct 2022 12:34:55 +0800
Message-ID: <20221006043456.8754-4-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006043456.8754-1-yongqiang.niu@mediatek.com>
References: <20221006043456.8754-1-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add gce ddr enable control flow when gce suspend/resume

when all cmdq instruction task has been processed done,
we need set this gce ddr enable to disable status to tell
cmdq hardware gce there is none task need process, and the hardware
can go into idle mode and no access ddr anymore, then the spm can go
into suspend.

the original issue is gce still access ddr when cmdq suspend function
call, but there is no task run.
so, we need control gce access ddr with this flow.
when cmdq suspend function, there is no task need process, we can
disable gce access ddr, to make sure system go into suspend success.

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/mailbox/mtk-cmdq-mailbox.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
index 04eb44d89119..2db82ff838ed 100644
--- a/drivers/mailbox/mtk-cmdq-mailbox.c
+++ b/drivers/mailbox/mtk-cmdq-mailbox.c
@@ -94,6 +94,18 @@ struct gce_plat {
 	u32 gce_num;
 };
 
+static void cmdq_sw_ddr_enable(struct cmdq *cmdq, bool enable)
+{
+	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
+
+	if (enable)
+		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
+	else
+		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
+
+	clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
+}
+
 u8 cmdq_get_shift_pa(struct mbox_chan *chan)
 {
 	struct cmdq *cmdq = container_of(chan->mbox, struct cmdq, mbox);
@@ -319,6 +331,9 @@ static int cmdq_suspend(struct device *dev)
 	if (task_running)
 		dev_warn(dev, "exist running task(s) in suspend\n");
 
+	if (cmdq->sw_ddr_en)
+		cmdq_sw_ddr_enable(cmdq, false);
+
 	clk_bulk_unprepare(cmdq->gce_num, cmdq->clocks);
 
 	return 0;
@@ -330,6 +345,10 @@ static int cmdq_resume(struct device *dev)
 
 	WARN_ON(clk_bulk_prepare(cmdq->gce_num, cmdq->clocks));
 	cmdq->suspended = false;
+
+	if (cmdq->sw_ddr_en)
+		cmdq_sw_ddr_enable(cmdq, true);
+
 	return 0;
 }
 
@@ -337,6 +356,9 @@ static int cmdq_remove(struct platform_device *pdev)
 {
 	struct cmdq *cmdq = platform_get_drvdata(pdev);
 
+	if (cmdq->sw_ddr_en)
+		cmdq_sw_ddr_enable(cmdq, false);
+
 	clk_bulk_unprepare(cmdq->gce_num, cmdq->clocks);
 	return 0;
 }
-- 
2.25.1

