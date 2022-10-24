Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94F8609EF9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiJXKXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJXKXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:23:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1834058E82;
        Mon, 24 Oct 2022 03:23:34 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1999E6602827;
        Mon, 24 Oct 2022 11:23:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666607013;
        bh=Mq9twGbY6UZGP7eQ93JIXnpDsfHgHcgSIK4smKa1rSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JVPSwK9b+GyreNN73BJxPoJ40mLsqXJMqLzhzvc6KLsWLdXhyA0lkXqIEpD1YvSiQ
         fYw5jhzpEOHDFXFYezdq/EtWNMjFlJISS6hzx2SOx+g945Uo+YoODbb5daZ5H6CxzK
         tGi+omsVS13g6sDfpLDrE3d6KJQ0w7iDkvXpQOKjv8wGbrkdqK6+G2pXJcjeFSrn7l
         Rno7sYmAUCsnwkLhzaehO8I+6wtWfh2uIiVqHOm5ReCjOfSByRHTQcBv8g/LphrBCO
         0WE2+FicR8qaLMfvbQEJn1cGCyBErxsk0Gv0eebzXIqcg+k+dnk1xf42OGhsELVXBd
         Tjc3BvSj4Ua4g==
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
Subject: [PATCH 07/10] clk: mediatek: mt8192: Drop flags for main/univpll fixed factors
Date:   Mon, 24 Oct 2022 12:23:04 +0200
Message-Id: <20221024102307.33722-8-angelogioacchino.delregno@collabora.com>
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
 drivers/clk/mediatek/clk-mt8192.c | 76 +++++++++++++++----------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index d0f226931070..0e88588b2c49 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -31,38 +31,38 @@ static const struct mtk_fixed_factor top_early_divs[] = {
 };
 
 static const struct mtk_fixed_factor top_divs[] = {
-	FACTOR(CLK_TOP_MAINPLL_D3, "mainpll_d3", "mainpll", 1, 3),
-	FACTOR(CLK_TOP_MAINPLL_D4, "mainpll_d4", "mainpll", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D4_D2, "mainpll_d4_d2", "mainpll_d4", 1, 2),
-	FACTOR(CLK_TOP_MAINPLL_D4_D4, "mainpll_d4_d4", "mainpll_d4", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D4_D8, "mainpll_d4_d8", "mainpll_d4", 1, 8),
-	FACTOR(CLK_TOP_MAINPLL_D4_D16, "mainpll_d4_d16", "mainpll_d4", 1, 16),
-	FACTOR(CLK_TOP_MAINPLL_D5, "mainpll_d5", "mainpll", 1, 5),
-	FACTOR(CLK_TOP_MAINPLL_D5_D2, "mainpll_d5_d2", "mainpll_d5", 1, 2),
-	FACTOR(CLK_TOP_MAINPLL_D5_D4, "mainpll_d5_d4", "mainpll_d5", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D5_D8, "mainpll_d5_d8", "mainpll_d5", 1, 8),
-	FACTOR(CLK_TOP_MAINPLL_D6, "mainpll_d6", "mainpll", 1, 6),
-	FACTOR(CLK_TOP_MAINPLL_D6_D2, "mainpll_d6_d2", "mainpll_d6", 1, 2),
-	FACTOR(CLK_TOP_MAINPLL_D6_D4, "mainpll_d6_d4", "mainpll_d6", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D7, "mainpll_d7", "mainpll", 1, 7),
-	FACTOR(CLK_TOP_MAINPLL_D7_D2, "mainpll_d7_d2", "mainpll_d7", 1, 2),
-	FACTOR(CLK_TOP_MAINPLL_D7_D4, "mainpll_d7_d4", "mainpll_d7", 1, 4),
-	FACTOR(CLK_TOP_MAINPLL_D7_D8, "mainpll_d7_d8", "mainpll_d7", 1, 8),
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
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D3, "mainpll_d3", "mainpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4, "mainpll_d4", "mainpll", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4_D2, "mainpll_d4_d2", "mainpll_d4", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4_D4, "mainpll_d4_d4", "mainpll_d4", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4_D8, "mainpll_d4_d8", "mainpll_d4", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D4_D16, "mainpll_d4_d16", "mainpll_d4", 1, 16, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D5, "mainpll_d5", "mainpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D5_D2, "mainpll_d5_d2", "mainpll_d5", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D5_D4, "mainpll_d5_d4", "mainpll_d5", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D5_D8, "mainpll_d5_d8", "mainpll_d5", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D6, "mainpll_d6", "mainpll", 1, 6, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D6_D2, "mainpll_d6_d2", "mainpll_d6", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D6_D4, "mainpll_d6_d4", "mainpll_d6", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D7, "mainpll_d7", "mainpll", 1, 7, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D7_D2, "mainpll_d7_d2", "mainpll_d7", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D7_D4, "mainpll_d7_d4", "mainpll_d7", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_MAINPLL_D7_D8, "mainpll_d7_d8", "mainpll_d7", 1, 8, 0),
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
 	FACTOR(CLK_TOP_APLL1, "apll1_ck", "apll1", 1, 1),
 	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", "apll1", 1, 2),
 	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1", 1, 4),
@@ -96,12 +96,12 @@ static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_OSC_D16, "osc_d16", "ulposc", 1, 16),
 	FACTOR(CLK_TOP_OSC_D20, "osc_d20", "ulposc", 1, 20),
 	FACTOR(CLK_TOP_ADSPPLL, "adsppll_ck", "adsppll", 1, 1),
-	FACTOR(CLK_TOP_UNIVPLL_192M, "univpll_192m", "univpll", 1, 13),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D2, "univpll_192m_d2", "univpll_192m", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D4, "univpll_192m_d4", "univpll_192m", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D8, "univpll_192m_d8", "univpll_192m", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D16, "univpll_192m_d16", "univpll_192m", 1, 16),
-	FACTOR(CLK_TOP_UNIVPLL_192M_D32, "univpll_192m_d32", "univpll_192m", 1, 32),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M, "univpll_192m", "univpll", 1, 13, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D2, "univpll_192m_d2", "univpll_192m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D4, "univpll_192m_d4", "univpll_192m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D8, "univpll_192m_d8", "univpll_192m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D16, "univpll_192m_d16", "univpll_192m", 1, 16, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_192M_D32, "univpll_192m_d32", "univpll_192m", 1, 32, 0),
 };
 
 static const char * const axi_parents[] = {
-- 
2.37.2

