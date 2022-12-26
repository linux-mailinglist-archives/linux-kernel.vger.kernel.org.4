Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2795C65619F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231924AbiLZJn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiLZJnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:43:02 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DE22AFE;
        Mon, 26 Dec 2022 01:43:00 -0800 (PST)
X-UUID: 19d9ebc4727a42e797aa831be272ea92-20221226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=vtCKAvgOH7YCRiMu7xIibkp/Q/B1FQFivE3rK/uTDPY=;
        b=hNIuabCz3qy8eFoiuwFSSyrIlKQBYk0SLUCv1HoXdByWM5omLJQvFt8Dn8UmxnhkrFwjjMqqNHzXMKW7tyYXkWaICBpo47+B+8zqQ0xoEyqvwzqppaXTJmjPrz4mnHeUhYdc8TMCnQ3yg2PBNoFwyjM7ZeX4Dr2fRahI+rhdPq8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:e5afde90-b07d-4f44-b244-bc41ef850630,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:e5afde90-b07d-4f44-b244-bc41ef850630,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:d80fcf52-dd49-462e-a4be-2143a3ddc739,B
        ulkID:2212261742535GIVWI8Q,BulkQuantity:1,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:43,QS:nil,BEC:nil,COL:0
X-UUID: 19d9ebc4727a42e797aa831be272ea92-20221226
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1358665904; Mon, 26 Dec 2022 17:42:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 26 Dec 2022 17:42:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 26 Dec 2022 17:42:50 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
CC:     Fan Chen <fan.chen@mediatek.com>, Roger Lu <roger.lu@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 09/13] soc: mediatek: mtk-svs: use common function to disable restore voltages
Date:   Mon, 26 Dec 2022 17:42:44 +0800
Message-ID: <20221226094248.4506-10-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221226094248.4506-1-roger.lu@mediatek.com>
References: <20221226094248.4506-1-roger.lu@mediatek.com>
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

The timing of disabling/restoring SVS bank is more than one place.
Therefore, add a common function to use for removing the superfluous codes.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 934e7ea976b0..c4b36c908eda 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -623,6 +623,26 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
 	return ret;
 }
 
+static void svs_bank_disable_and_restore_default_volts(struct svs_platform *svsp,
+						       struct svs_bank *svsb)
+{
+	unsigned long flags;
+
+	if (svsb->mode_support == SVSB_MODE_ALL_DISABLE)
+		return;
+
+	/* This spinlock might wait for svs_isr() process */
+	spin_lock_irqsave(&svs_lock, flags);
+	svsp->pbank = svsb;
+	svs_switch_bank(svsp);
+	svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
+	svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
+	spin_unlock_irqrestore(&svs_lock, flags);
+
+	svsb->phase = SVSB_PHASE_ERROR;
+	svs_adjust_pm_opp_volts(svsb);
+}
+
 static int svs_dump_debug_show(struct seq_file *m, void *p)
 {
 	struct svs_platform *svsp = (struct svs_platform *)m->private;
@@ -698,7 +718,6 @@ static ssize_t svs_enable_debug_write(struct file *filp,
 {
 	struct svs_bank *svsb = file_inode(filp)->i_private;
 	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
-	unsigned long flags;
 	int enabled, ret;
 	char *buf = NULL;
 
@@ -714,16 +733,8 @@ static ssize_t svs_enable_debug_write(struct file *filp,
 		return ret;
 
 	if (!enabled) {
-		spin_lock_irqsave(&svs_lock, flags);
-		svsp->pbank = svsb;
+		svs_bank_disable_and_restore_default_volts(svsp, svsb);
 		svsb->mode_support = SVSB_MODE_ALL_DISABLE;
-		svs_switch_bank(svsp);
-		svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
-		svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
-		spin_unlock_irqrestore(&svs_lock, flags);
-
-		svsb->phase = SVSB_PHASE_ERROR;
-		svs_adjust_pm_opp_volts(svsb);
 	}
 
 	kfree(buf);
@@ -1540,7 +1551,6 @@ static int svs_suspend(struct device *dev)
 {
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	struct svs_bank *svsb;
-	unsigned long flags;
 	int ret;
 	u32 idx;
 
@@ -1549,17 +1559,7 @@ static int svs_suspend(struct device *dev)
 
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
-
-		/* This might wait for svs_isr() process */
-		spin_lock_irqsave(&svs_lock, flags);
-		svsp->pbank = svsb;
-		svs_switch_bank(svsp);
-		svs_writel_relaxed(svsp, SVSB_PTPEN_OFF, SVSEN);
-		svs_writel_relaxed(svsp, SVSB_INTSTS_VAL_CLEAN, INTSTS);
-		spin_unlock_irqrestore(&svs_lock, flags);
-
-		svsb->phase = SVSB_PHASE_ERROR;
-		svs_adjust_pm_opp_volts(svsb);
+		svs_bank_disable_and_restore_default_volts(svsp, svsb);
 	}
 
 	ret = reset_control_assert(svsp->rst);
-- 
2.18.0

