Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D93A45E7A38
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiIWMKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbiIWMIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:08:19 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC5CF74;
        Fri, 23 Sep 2022 05:06:19 -0700 (PDT)
X-UUID: 264136e66f2b406f8ef8146d0b0b3c22-20220923
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=3eoJEqs9uN/ymOxu3OixLr1KvHOF0+k3IvPCigt2k00=;
        b=fds5X9dIYc7ZOqbYSHDSE8jeFtSMAb8TYlxjTcfzob0e8cIUtEMNCcOeyVJBvLz7NLa0n2ZsFESEVdc2QioiDJ94vXOdf0a9M2xu+iUlwRPfm1ECD+DY82q7CSpb6kyUMieFEAoafEAzbknb1W0M/u9Jk0Yq710o8ldFwDO6FCU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:23f7f23c-ff0e-4966-89b4-a7040202ed5b,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:6a0304e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 264136e66f2b406f8ef8146d0b0b3c22-20220923
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <xinlei.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 442688223; Fri, 23 Sep 2022 20:06:15 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 23 Sep 2022 20:06:14 +0800
Received: from mszsdaap41.gcn.mediatek.inc (10.16.6.141) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 23 Sep 2022 20:06:13 +0800
From:   <xinlei.lee@mediatek.com>
To:     <thierry.reding@gmail.com>, <u.kleine-koenig@pengutronix.de>,
        <matthias.bgg@gmail.com>
CC:     <linux-pwm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <jitao.shi@mediatek.com>, xinlei lee <xinlei.lee@mediatek.com>
Subject: [PATCH,v2] pwm: mtk-disp: Fix the parameters calculated by the enabled flag of disp_pwm
Date:   Fri, 23 Sep 2022 20:06:11 +0800
Message-ID: <1663934771-15152-1-git-send-email-xinlei.lee@mediatek.com>
X-Mailer: git-send-email 2.6.4
MIME-Version: 1.0
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

From: xinlei lee <xinlei.lee@mediatek.com>

In the original mtk_disp_pwm_get_state() function, the result of reading
con0 & BIT(0) is enabled as disp_pwm.
In order to conform to the register table, we should use the disp_pwm
base address as the enabled judgment.

Fixes: 3f2b16734914 ("pwm: mtk-disp: Implement atomic API .get_state()")

Signed-off-by: xinlei lee <xinlei.lee@mediatek.com>
---
Base on the branch of Linux-next/master.

change since v1:
1. Modify the way to set disp_pwm enbale.
---
---
 drivers/pwm/pwm-mtk-disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-mtk-disp.c b/drivers/pwm/pwm-mtk-disp.c
index c605013..1a9880d 100644
--- a/drivers/pwm/pwm-mtk-disp.c
+++ b/drivers/pwm/pwm-mtk-disp.c
@@ -197,7 +197,7 @@ static void mtk_disp_pwm_get_state(struct pwm_chip *chip,
 	rate = clk_get_rate(mdp->clk_main);
 	con0 = readl(mdp->base + mdp->data->con0);
 	con1 = readl(mdp->base + mdp->data->con1);
-	state->enabled = !!(con0 & BIT(0));
+	state->enabled = !!(readl(mdp->base + DISP_PWM_EN) & BIT(0));
 	clk_div = FIELD_GET(PWM_CLKDIV_MASK, con0);
 	period = FIELD_GET(PWM_PERIOD_MASK, con1);
 	/*
-- 
2.6.4

