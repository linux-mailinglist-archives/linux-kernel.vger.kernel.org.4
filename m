Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E119869D032
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbjBTPFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjBTPEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:04:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884E7EC3;
        Mon, 20 Feb 2023 07:02:55 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 78B23660216A;
        Mon, 20 Feb 2023 15:02:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905350;
        bh=xEzNnjlrGCa8nDnkjYmWB7XHA1caeWO11UfF0hFXRg4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWovtCCRi06sL5fIm5639Dw16mBs8mH8fSte1LynwbJu4Tad7oP/fmdgnf2z6avWX
         SAGCGk3ty7SU7tjwb/1mYJ7HAwhyVvWLRAFvjFTwxyKrHVxgUpOsLMSjUmr5Wvj4SJ
         28eHvUTS/SHrH9MnPRN79btSbmdoLuXmyriVR+Li2ZD3EhAEYAbqEgf6bQyd2pE/Pc
         IndX9wVzPM8QaG4vkdxoysmsbbNnAbrcvKO7RObtt1f+3hvw2hy8u5pwN+ZtWEEe/8
         lkBFyaqjhwlB1SrPX6mPQA3s6M+GtaPJ6kr3H9OE7eWrcpjC4ig/M86PMkFUBq/KcN
         89IA7XYACZ4CQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 53/55] clk: mediatek: mt8135: Join root_clk_alias and top_divs arrays
Date:   Mon, 20 Feb 2023 16:01:09 +0100
Message-Id: <20230220150111.77897-54-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for converting this driver to the common simple probe
mechanism, join the root_clk_alias and top_divs mtk_fixed_factor
arrays.

This commit brings no functional change.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8135.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 1c76c0003f99..8785d58cb3a5 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -2,8 +2,6 @@
 /*
  * Copyright (c) 2014 MediaTek Inc.
  * Author: James Liao <jamesjj.liao@mediatek.com>
- * Copyright (c) 2023 Collabora, Ltd.
- *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #include <linux/clk.h>
@@ -19,14 +17,12 @@
 
 static DEFINE_SPINLOCK(mt8135_clk_lock);
 
-static const struct mtk_fixed_factor root_clk_alias[] __initconst = {
+static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_DSI0_LNTC_DSICLK, "dsi0_lntc_dsiclk", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_HDMITX_CLKDIG_CTS, "hdmitx_clkdig_cts", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_CLKPH_MCK, "clkph_mck", "clk_null", 1, 1),
 	FACTOR(CLK_TOP_CPUM_TCK_IN, "cpum_tck_in", "clk_null", 1, 1),
-};
 
-static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_MAINPLL_806M, "mainpll_806m", "mainpll", 1, 2),
 	FACTOR(CLK_TOP_MAINPLL_537P3M, "mainpll_537p3m", "mainpll", 1, 3),
 	FACTOR(CLK_TOP_MAINPLL_322P4M, "mainpll_322p4m", "mainpll", 1, 5),
@@ -534,7 +530,6 @@ static void __init mtk_topckgen_init(struct device_node *node)
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
 
-	mtk_clk_register_factors(root_clk_alias, ARRAY_SIZE(root_clk_alias), clk_data);
 	mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
 	mtk_clk_register_composites(NULL, top_muxes,
 				    ARRAY_SIZE(top_muxes), base,
-- 
2.39.1

