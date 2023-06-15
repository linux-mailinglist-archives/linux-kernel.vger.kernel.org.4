Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCABB7318E6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbjFOMWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344402AbjFOMWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:22:07 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A42C2976;
        Thu, 15 Jun 2023 05:21:09 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 76D1A6606F6A;
        Thu, 15 Jun 2023 13:21:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686831668;
        bh=hSYDHRQZFg61OZRhqwBnz/BlpiaeFapUIjvjpav/ea8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KEtD9OqsW7lISwZrho68MiM8bf3s3nGT8DNIEW7ilAGpkszs1uR6kHuY4lbMxwkHx
         vv3Axz4B7shUPazZfsjXfyfPlowcg66gDiGAGS6rrDdLzwhCD4gtjgETdUzsYLPCSt
         C/yMzpi1f/FYTOjIfuukG5gUGNpZ/nfaULMRl1f+uJbIbp9ED5TT/pxHiO4Drac+f/
         4LgcTtGsqLMMkVL33z/6E6rdYyvNB2iEZxuv80YJs/GG1w241ZLyjgZef/XJ4crUdR
         ZV71jwlP/B8BDkNgjggdkazg0w2b+ms/vGe8MqrgwtH6HeXVGy/ejDw8T5HoMqd6tf
         CZsmvjoSESgsA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 2/3] clk: mediatek: clk-mt8173-apmixedsys: Fix return value for of_iomap() error
Date:   Thu, 15 Jun 2023 14:20:50 +0200
Message-Id: <20230615122051.546985-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com>
References: <20230615122051.546985-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_iomap() function returns NULL in case of error so usage of
PTR_ERR() is wrong!
Change that to return -ENOMEM in case of failure.

Fixes: 41138fbf876c ("clk: mediatek: mt8173: Migrate to platform driver and common probe")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index daa2856d1ab7..ba1386e70a24 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -148,7 +148,7 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 
 	base = of_iomap(node, 0);
 	if (!base)
-		return PTR_ERR(base);
+		return -ENOMEM;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
 	if (IS_ERR_OR_NULL(clk_data))
-- 
2.40.1

