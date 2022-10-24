Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E38609EF8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiJXKX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiJXKXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:23:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D53B57E00;
        Mon, 24 Oct 2022 03:23:35 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 29AA76602825;
        Mon, 24 Oct 2022 11:23:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666607014;
        bh=GMJijgNiAZLeq7dXgG4lF50M6AzHRWg3gZL99T1+GXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mDya23qhtp3JCzkQbOsz81RiqV3fkbebi3wNex8SLjT5PZqDAPufn0AEu28i5Jtfm
         Ko8bZK6pjOQ7t9espXJ0VNQoafw5E47veQLjs/hVOp2GAYCsnzNtfr47h2p/arpX/B
         Uqyc+5/wfWxD7ViOyxtAd5rQNOmAnBroAGjFPM1g/bTURvnDJDnbodhHuUWzkk25ti
         fyxLUwgcUMobUtJx7YLfGe9qr1Y5F9BLh7XD2RLurFeaZ0h2EFpGqVknhqrOxn5Je3
         HK2wcYjGcoDVa5Do7iTKQpSi821KzxlYLtvbD/qnbpMv1YK0xfy5+kgXT7KhMGDwmu
         viUJBYTjPencw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        miles.chen@mediatek.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, chun-jie.chen@mediatek.com,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        msp@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] clk: mediatek: mt8195-topckgen: Drop flags for main/univpll fixed factors
Date:   Mon, 24 Oct 2022 12:23:05 +0200
Message-Id: <20221024102307.33722-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
References: <20221024102307.33722-1-angelogioacchino.delregno@collabora.com>
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

The main/univpll clocks are used as clock sources for multiple
peripherals of different kind, some of which are critical (like AXIs);
a rate change on any of these two will produce a rate change on many
devices and that's likely to produce system instability if not done
correctly: this is the reason why we have (a lot of) "fixed factor"
main/univpll divider clocks, used by MUX clocks to provide different
rates based on PLL output dividers.

Following what was done on clk-mt8186-topckgen and also preventing the
same GPU DVFS issue, drop CLK_SET_RATE_PARENT from the aforementioned
clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 78 +++++++++++-----------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 1e016329c1d2..93e96419da66 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -35,45 +35,45 @@ static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_IN_DGI_D4, "in_dgi_d4", "in_dgi", 1, 4),
 	FACTOR(CLK_TOP_IN_DGI_D6, "in_dgi_d6", "in_dgi", 1, 6),
 	FACTOR(CLK_TOP_IN_DGI_D8, "in_dgi_d8", "in_dgi", 1, 8),
-	FACTOR(CLK_TOP_MAINPLL_D3, "mainpll_d3", "mainpll", 1, 3),
-	FACTOR(CLK_TOP_MAINPLL_D4, "mainpll_d4", "mainpll", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D4_D2, "mainpll_d4_d2", "mainpll_d4", 1, 2),
-	FACTOR(CLK_TOP_MAINPLL_D4_D4, "mainpll_d4_d4", "mainpll_d4", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D4_D8, "mainpll_d4_d8", "mainpll_d4", 1, 8),
-	FACTOR(CLK_TOP_MAINPLL_D5, "mainpll_d5", "mainpll", 1, 5),
-	FACTOR(CLK_TOP_MAINPLL_D5_D2, "mainpll_d5_d2", "mainpll_d5", 1, 2),
-	FACTOR(CLK_TOP_MAINPLL_D5_D4, "mainpll_d5_d4", "mainpll_d5", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D5_D8, "mainpll_d5_d8", "mainpll_d5", 1, 8),
-	FACTOR(CLK_TOP_MAINPLL_D6, "mainpll_d6", "mainpll", 1, 6),
-	FACTOR(CLK_TOP_MAINPLL_D6_D2, "mainpll_d6_d2", "mainpll_d6", 1, 2),
-	FACTOR(CLK_TOP_MAINPLL_D6_D4, "mainpll_d6_d4", "mainpll_d6", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D6_D8, "mainpll_d6_d8", "mainpll_d6", 1, 8),
-	FACTOR(CLK_TOP_MAINPLL_D7, "mainpll_d7", "mainpll", 1, 7),
-	FACTOR(CLK_TOP_MAINPLL_D7_D2, "mainpll_d7_d2", "mainpll_d7", 1, 2),
-	FACTOR(CLK_TOP_MAINPLL_D7_D4, "mainpll_d7_d4", "mainpll_d7", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D7_D8, "mainpll_d7_d8", "mainpll_d7", 1, 8),
-	FACTOR(CLK_TOP_MAINPLL_D9, "mainpll_d9", "mainpll", 1, 9),
-	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
-	FACTOR(CLK_TOP_UNIVPLL_D4, "univpll_d4", "univpll", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_D4_D2, "univpll_d4_d2", "univpll_d4", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D4_D4, "univpll_d4_d4", "univpll_d4", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_D4_D8, "univpll_d4_d8", "univpll_d4", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll_d5", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll_d5", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D8, "univpll_d5_d8", "univpll_d5", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D6, "univpll_d6", "univpll", 1, 6),
-	FACTOR(CLK_TOP_UNIVPLL_D6_D2, "univpll_d6_d2", "univpll_d6", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D6_D4, "univpll_d6_d4", "univpll_d6", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_D6_D8, "univpll_d6_d8", "univpll_d6", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D6_D16, "univpll_d6_d16", "univpll_d6", 1, 16),
-	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1, 7),
-	FACTOR(CLK_TOP_UNIVPLL_192M, "univpll_192m", "univpll", 1, 13),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D4, "univpll_192m_d4", "univpll_192m", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D8, "univpll_192m_d8", "univpll_192m", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D16, "univpll_192m_d16", "univpll_192m", 1, 16),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D32, "univpll_192m_d32", "univpll_192m", 1, 32),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D3, "mainpll_d3", "mainpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4, "mainpll_d4", "mainpll", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4_D2, "mainpll_d4_d2", "mainpll_d4", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4_D4, "mainpll_d4_d4", "mainpll_d4", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4_D8, "mainpll_d4_d8", "mainpll_d4", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D5, "mainpll_d5", "mainpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D5_D2, "mainpll_d5_d2", "mainpll_d5", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D5_D4, "mainpll_d5_d4", "mainpll_d5", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D5_D8, "mainpll_d5_d8", "mainpll_d5", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D6, "mainpll_d6", "mainpll", 1, 6, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D6_D2, "mainpll_d6_d2", "mainpll_d6", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D6_D4, "mainpll_d6_d4", "mainpll_d6", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D6_D8, "mainpll_d6_d8", "mainpll_d6", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D7, "mainpll_d7", "mainpll", 1, 7, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D7_D2, "mainpll_d7_d2", "mainpll_d7", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D7_D4, "mainpll_d7_d4", "mainpll_d7", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D7_D8, "mainpll_d7_d8", "mainpll_d7", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D9, "mainpll_d9", "mainpll", 1, 9, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D4, "univpll_d4", "univpll", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D4_D2, "univpll_d4_d2", "univpll_d4", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D4_D4, "univpll_d4_d4", "univpll_d4", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D4_D8, "univpll_d4_d8", "univpll_d4", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll_d5", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll_d5", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5_D8, "univpll_d5_d8", "univpll_d5", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D6, "univpll_d6", "univpll", 1, 6, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D6_D2, "univpll_d6_d2", "univpll_d6", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D6_D4, "univpll_d6_d4", "univpll_d6", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D6_D8, "univpll_d6_d8", "univpll_d6", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D6_D16, "univpll_d6_d16", "univpll_d6", 1, 16, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1, 7, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M, "univpll_192m", "univpll", 1, 13, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D4, "univpll_192m_d4", "univpll_192m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D8, "univpll_192m_d8", "univpll_192m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D16, "univpll_192m_d16", "univpll_192m", 1, 16, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D32, "univpll_192m_d32", "univpll_192m", 1, 32, 0),
 	FACTOR(CLK_TOP_APLL1_D3, "apll1_d3", "apll1", 1, 3),
 	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1", 1, 4),
 	FACTOR(CLK_TOP_APLL2_D3, "apll2_d3", "apll2", 1, 3),
-- 
2.37.2

