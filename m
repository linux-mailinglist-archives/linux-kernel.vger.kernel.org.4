Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0079E5EE101
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 17:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbiI1P4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 11:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbiI1Pzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 11:55:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEEA90190
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 08:55:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 285F161F0C
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 15:55:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CC5C433D7;
        Wed, 28 Sep 2022 15:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664380532;
        bh=l7UiBfO3UBUpJjyUbjigXJWcDJxBC47DwLgzoIjb9LE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VhJyaPwmhuiLzXMKUZYdCtsE01Tzi1rUzGRAt/TpvtkdOg4dESYEYnp6CXS+jM1bA
         +aQOoKv8Srf5vbqctuqXDvOmccgCcKJoDVSHdzSKenLXJOs862wKyfVWlyYoVGUOBi
         Cg0061wCbSGGNilC2RUUgo2EsaOkhtElYDXLG+TIB8t7R6Qej/g9hZe7Ap6wWyciYs
         9YLRcKMPs7r2IcsTc8f/w6naFrazDPhFU0lv/RS5rkG9BcwS5OVKbUv1O8NrxiZ3Tz
         NCzEHB8dC9su112IuP8yyYbpqHsaYJMSxAWxGsFDiHoE6rOd9xDu8ZLMfL5+CoOtVi
         rXIbAj4NRpu9w==
From:   matthias.bgg@kernel.org
To:     roger.lu@mediatek.com, jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 2/8] soc: mediatek: mtk-svs: improve readability of platform_probe
Date:   Wed, 28 Sep 2022 17:55:13 +0200
Message-Id: <20220928155519.31977-3-matthias.bgg@kernel.org>
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

If a compatible misses a match data entry, then something is wrong in
the development phase, we don't need to check for that at runtime.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---

 drivers/soc/mediatek/mtk-svs.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index fd0f636e8644..52bb4f8bbe6d 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -2332,10 +2332,6 @@ static struct svs_platform *svs_platform_probe(struct platform_device *pdev)
 	int ret;
 
 	svsp_data = of_device_get_match_data(&pdev->dev);
-	if (!svsp_data) {
-		dev_err(&pdev->dev, "no svs platform data?\n");
-		return ERR_PTR(-EPERM);
-	}
 
 	svsp = devm_kzalloc(&pdev->dev, sizeof(*svsp), GFP_KERNEL);
 	if (!svsp)
-- 
2.37.3

