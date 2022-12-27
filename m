Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AFB0656A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 13:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbiL0MKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 07:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiL0MJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 07:09:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED80C62;
        Tue, 27 Dec 2022 04:09:28 -0800 (PST)
X-UUID: 24e74497a84841978850b89131bf5e0f-20221227
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=tZCJkM2jLlHHVNBnvCfLwUO1eph79cbGiblmSJiL3t8=;
        b=oBVIOBaRIV1GTTjiZTUUvYpU0Zc5mvF8GGxZl5pnbAKDjREfKgXMJOVP03eiTEqkGQM94bfxHtbEFiFKV6PFONsrHORodHhKCwaGigN5sTkQNTfSO2tpStKJ1R/BqaclvISxxmmMHR1OS7eX/FQl24gDzJ2nN6kyVbtwhaLcPeU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:0b1f189b-6e8b-4f1b-87fa-1b9bf0783154,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:0b1f189b-6e8b-4f1b-87fa-1b9bf0783154,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:cc94898a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:221227200922RO0PBLKX,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 24e74497a84841978850b89131bf5e0f-20221227
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2013555273; Tue, 27 Dec 2022 20:09:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 27 Dec 2022 20:09:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 27 Dec 2022 20:09:18 +0800
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
Subject: [PATCH v2 10/13] soc: mediatek: mtk-svs: use common function to disable restore voltages
Date:   Tue, 27 Dec 2022 20:09:11 +0800
Message-ID: <20221227120914.11346-11-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221227120914.11346-1-roger.lu@mediatek.com>
References: <20221227120914.11346-1-roger.lu@mediatek.com>
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

The timing of disabling SVS bank and restore default voltage is more than
one place. Therefore, add a common function to use for removing the superfluous
codes.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 44 +++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index ee663cfd4483..6cda1e93c77a 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -651,6 +651,26 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
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
@@ -726,7 +746,6 @@ static ssize_t svs_enable_debug_write(struct file *filp,
 {
 	struct svs_bank *svsb = file_inode(filp)->i_private;
 	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
-	unsigned long flags;
 	int enabled, ret;
 	char *buf = NULL;
 
@@ -742,16 +761,8 @@ static ssize_t svs_enable_debug_write(struct file *filp,
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
@@ -1568,7 +1579,6 @@ static int svs_suspend(struct device *dev)
 {
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	struct svs_bank *svsb;
-	unsigned long flags;
 	int ret;
 	u32 idx;
 
@@ -1580,17 +1590,7 @@ static int svs_suspend(struct device *dev)
 
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

