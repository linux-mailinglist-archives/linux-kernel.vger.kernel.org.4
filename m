Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D505EE102
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiI1P4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiI1Pzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:55:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3247F8C034
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C0B661F11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136FEC433C1;
        Wed, 28 Sep 2022 15:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380535;
        bh=a1LAVlDHkces/5MDyjvZevj2YKY09OrPDHZaF2N9pnk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjSVvQHG6b9D4itNHwL1SG4xfd79oh//JrtvpPK1D3kaUsuXKvEQurdibHWlezXB8
         LBlRnzdmzrQ1OhrvK7xmRIGoADyLNdbwSWP83T/p6Siy7Tdq+i+K88yB9vJV+C/fCy
         v4d94YYSn+VI3i3nCiIpIi/MSW791yjNUVr97BX/2iq4xoCewz+4knHzmxQxlxsGt1
         zIxvZrUPWZ3TN0sgZ/Ojv52KiF4aPvkorkdiFcFc2p4SlPlOwA44HuDOZsqZdXyQw1
         FU8fGA5G3S2gyvTOXem8BS3XpySetdvePLMdV81VfqD17xEGfv4x4Upa+01bW4RJeL
         FE2UwX/8guwVQ==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 3/8] soc: mediatek: mtk-svs: move svs_platform_probe into probe
Date:   Wed, 28 Sep 2022 17:55:14 +0200
Message-Id: <20220928155519.31977-4-matthias.bgg@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220928155519.31977-1-matthias.bgg@kernel.org>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Brugger <matthias.bgg@gmail.com>

Moving svs_platform_probe into driver probe function will allow us to
reduce svs_platform members. This will be done in a follow-up patch.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/soc/mediatek/mtk-svs.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 52bb4f8bbe6d..8342627f8dea 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2325,17 +2325,17 @@ static const struct of_device_id svs_of_match[] = {
 	},
 };
 
-static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
+static int svs_probe(struct platform_device *pdev)
 {
 	struct svs_platform *svsp;
 	const struct svs_platform_data *svsp_data;
-	int ret;
+	int ret, svsp_irq;
 
 	svsp_data = of_device_get_match_data(&pdev->dev);
 
 	svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
 	if (!svsp)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 
 	svsp->dev = &pdev->dev;
 	svsp->name = svsp_data->name;
@@ -2346,19 +2346,7 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
 
 	ret = svsp_data->probe(svsp);
 	if (ret)
-		return ERR_PTR(ret);
-
-	return svsp;
-}
-
-static int svs_probe(struct platform_device *pdev)
-{
-	struct svs_platform *svsp;
-	int svsp_irq, ret;
-
-	svsp = svs_platform_probe(pdev);
-	if (IS_ERR(svsp))
-		return PTR_ERR(svsp);
+		return ret;
 
 	if (!svs_is_efuse_data_correct(svsp)) {
 		dev_notice(svsp->dev, "efuse data isn't correct\n");
-- 
2.37.3

