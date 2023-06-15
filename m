Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ABB7318E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241245AbjFOMXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 08:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344404AbjFOMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 08:22:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD36297C;
        Thu, 15 Jun 2023 05:21:10 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 66FB36606F6E;
        Thu, 15 Jun 2023 13:21:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686831669;
        bh=vpOgvT6yygDmgfAiQqASqbcSsnVHPhA2AtXGuQCWxfk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YMuyc0yb8fxIW6zoWi+1oHJMnciKLwwSzP+XQXbUMZ85AwWoloC8MY5PiQLE2GWtn
         xS9zWDy4wuxIIGsgz8aMVjziOj/2nyHoe3TscpJrakY0t+o74owZNgw/OnwsojCb+y
         XoYI+6tCzyTaSCiIR/zcegZMGNBt3ohBvgXet5qRPFGjF96Glh4MEPPdAOdq0ulUyA
         urK5G5Mo3BEoZEC3myqd96yH0J3NYVAOZu7tvUO7bDh+a+g2Vz9u76t0pgWzBgbKPq
         nMq0qC1n3OioHZY4qaFlIKmuHZ28t/4+2FOsXAQs3DPiWMLHjf7XnUXXgoEQQmlqpl
         /iWSFZNhRdN4A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, msp@baylibre.com,
        miles.chen@mediatek.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH 3/3] clk: mediatek: clk-mt8173-apmixedsys: Fix iomap not released issue
Date:   Thu, 15 Jun 2023 14:20:51 +0200
Message-Id: <20230615122051.546985-4-angelogioacchino.delregno@collabora.com>
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

In case of error after of_ioremap() the resource must be released:
call iounmap() where appropriate to fix that.

Fixes: 41138fbf876c ("clk: mediatek: mt8173: Migrate to platform driver and common probe")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
index ba1386e70a24..1bbb21ab1786 100644
--- a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -151,8 +151,10 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (IS_ERR_OR_NULL(clk_data))
+	if (IS_ERR_OR_NULL(clk_data)) {
+		iounmap(base);
 		return -ENOMEM;
+	}
 
 	fhctl_parse_dt(fhctl_node, pllfhs, ARRAY_SIZE(pllfhs));
 	r = mtk_clk_register_pllfhs(node, plls, ARRAY_SIZE(plls),
@@ -186,6 +188,7 @@ static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
 				  ARRAY_SIZE(pllfhs), clk_data);
 free_clk_data:
 	mtk_free_clk_data(clk_data);
+	iounmap(base);
 	return r;
 }
 
-- 
2.40.1

