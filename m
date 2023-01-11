Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 149F5665576
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 08:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236136AbjAKHrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 02:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbjAKHpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 02:45:47 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1650D11838;
        Tue, 10 Jan 2023 23:45:43 -0800 (PST)
X-UUID: ed6cdf30918311eda06fc9ecc4dadd91-20230111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=E7JOiwSOEFumewXbPXzCtjLpJhE2onK4s/UM3OcOq0g=;
        b=BYhn1Cga7+Zedw82kA7Dc0VpPWur0omTqNWfnDbXeu2VrBCSxJXYOyIpElJLcoAu1ZKG/+eaNdhK0HuhnlLfAUr5fwh6gITWNY0seXBjHsx1VIG0QypOl8veTfazGj5KSMJZuOKleMkGoHT3KF5/P3jn39ZGSgYFPZc/b5aEAiQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.17,REQID:3fb7ae9f-79cd-4537-a794-3c6890a6dc43,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:543e81c,CLOUDID:c599ee8b-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0
X-UUID: ed6cdf30918311eda06fc9ecc4dadd91-20230111
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 563853188; Wed, 11 Jan 2023 15:45:32 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 11 Jan 2023 15:45:31 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 11 Jan 2023 15:45:31 +0800
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
Subject: [PATCH v4 13/14] soc: mediatek: mtk-svs: use common function to disable restore voltages
Date:   Wed, 11 Jan 2023 15:45:27 +0800
Message-ID: <20230111074528.29354-14-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230111074528.29354-1-roger.lu@mediatek.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
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

The timing of disabling SVS bank and restore default voltage is more
than one place. Therefore, add a common function to use for removing
the superfluous codes.

Signed-off-by: Roger Lu <roger.lu@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/soc/mediatek/mtk-svs.c | 54 ++++++++++++++--------------------
 1 file changed, 22 insertions(+), 32 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index a7f0a6f02d52..89117807e85d 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -648,6 +648,25 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
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
 #ifdef CONFIG_DEBUG_FS
 static int svs_dump_debug_show(struct seq_file *m, void *p)
 {
@@ -724,7 +743,6 @@ static ssize_t svs_enable_debug_write(struct file *filp,
 {
 	struct svs_bank *svsb = file_inode(filp)->i_private;
 	struct svs_platform *svsp = dev_get_drvdata(svsb->dev);
-	unsigned long flags;
 	int enabled, ret;
 	char *buf = NULL;
 
@@ -740,16 +758,8 @@ static ssize_t svs_enable_debug_write(struct file *filp,
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
@@ -1532,16 +1542,7 @@ static int svs_init02(struct svs_platform *svsp)
 out_of_init02:
 	for (idx = 0; idx < svsp->bank_max; idx++) {
 		svsb = &svsp->banks[idx];
-
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
 
 	return ret;
@@ -1587,7 +1588,6 @@ static int svs_suspend(struct device *dev)
 {
 	struct svs_platform *svsp = dev_get_drvdata(dev);
 	struct svs_bank *svsb;
-	unsigned long flags;
 	int ret;
 	u32 idx;
 
@@ -1599,17 +1599,7 @@ static int svs_suspend(struct device *dev)
 
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

