Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F23D35B2F3F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 08:46:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbiIIGqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 02:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbiIIGqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 02:46:11 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFE9B113C7F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 23:46:08 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 73E231E80D5E;
        Fri,  9 Sep 2022 14:44:37 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id KCJdTlgd51AI; Fri,  9 Sep 2022 14:44:34 +0800 (CST)
Received: from localhost.localdomain (unknown [180.167.10.98])
        (Authenticated sender: yuzhe@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4EE7A1E80D06;
        Fri,  9 Sep 2022 14:44:34 +0800 (CST)
From:   Yu Zhe <yuzhe@nfschina.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, Yu Zhe <yuzhe@nfschina.com>
Subject: [PATCH] ASoC: mediatek: mt6359: fix platform_get_irq error checking
Date:   Fri,  9 Sep 2022 14:45:11 +0800
Message-Id: <20220909064511.22343-1-yuzhe@nfschina.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq() function returns negative error codes on error,
fix the checking.

Signed-off-by: Yu Zhe <yuzhe@nfschina.com>
---
 sound/soc/codecs/mt6359-accdet.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/mt6359-accdet.c b/sound/soc/codecs/mt6359-accdet.c
index c190628e2905..b70aac5075ad 100644
--- a/sound/soc/codecs/mt6359-accdet.c
+++ b/sound/soc/codecs/mt6359-accdet.c
@@ -965,7 +965,7 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
 	mutex_init(&priv->res_lock);
 
 	priv->accdet_irq = platform_get_irq(pdev, 0);
-	if (priv->accdet_irq) {
+	if (priv->accdet_irq > 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, priv->accdet_irq,
 						NULL, mt6359_accdet_irq,
 						IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
@@ -979,7 +979,7 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
 
 	if (priv->caps & ACCDET_PMIC_EINT0) {
 		priv->accdet_eint0 = platform_get_irq(pdev, 1);
-		if (priv->accdet_eint0) {
+		if (priv->accdet_eint0 > 0) {
 			ret = devm_request_threaded_irq(&pdev->dev,
 							priv->accdet_eint0,
 							NULL, mt6359_accdet_irq,
@@ -994,7 +994,7 @@ static int mt6359_accdet_probe(struct platform_device *pdev)
 		}
 	} else if (priv->caps & ACCDET_PMIC_EINT1) {
 		priv->accdet_eint1 = platform_get_irq(pdev, 2);
-		if (priv->accdet_eint1) {
+		if (priv->accdet_eint1 > 0) {
 			ret = devm_request_threaded_irq(&pdev->dev,
 							priv->accdet_eint1,
 							NULL, mt6359_accdet_irq,
-- 
2.11.0

