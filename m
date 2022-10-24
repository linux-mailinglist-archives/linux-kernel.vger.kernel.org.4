Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1456609EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiJXKXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJXKXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:23:33 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 045E258DE0;
        Mon, 24 Oct 2022 03:23:32 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F06D16602824;
        Mon, 24 Oct 2022 11:23:29 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666607010;
        bh=Dh97L7JvjfiBu8V6B+2CA5mLksRChUmKRFgxrGoQYBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvbvH7xeK4iqIydRWHhJqnRO+zIQjaQhBMCL/scRSAUk66+J5M/mEl28MBNqbEEfc
         xyLH9KMiCfacPshXsncBxdE5JSuoZ2Y/ZRL35LyGEdpms8htxvbf1YfXG+E6Q73HRa
         hhPmB4Whi0JaBBwapXiq6Ykav3ahCOvkMZwpXH0PafoYAx6pPVPAFudrevDCJr0ovB
         V4GNN+q8G8SnCULI3PFoFRAsat5ccJQhSsq0P6oQAI2HJS4NJI4taSaKyr8Pd8SpJN
         Nik0B44QPlnQpRlTppu+py3djaWi0LfbLXKKPt8OuHb8eubNkMOmTjEIbCGTre63BD
         bKEUgKQLNppeA==
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
Subject: [PATCH 05/10] clk: mediatek: mt8173: Drop flags for main/sys/univpll fixed factors
Date:   Mon, 24 Oct 2022 12:23:02 +0200
Message-Id: <20221024102307.33722-6-angelogioacchino.delregno@collabora.com>
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

The main/sys/univpll clocks are used as clock sources for multiple
peripherals of different kind, some of which are critical (like AXIs);
a rate change on any of these two will produce a rate change on many
devices and that's likely to produce system instability if not done
correctly: this is the reason why we have (a lot of) "fixed factor"
main/sys/univpll divider clocks, used by MUX clocks to provide
different rates based on PLL output dividers.

Following what was done on clk-mt8186-topckgen and also preventing the
same GPU DVFS issue, drop CLK_SET_RATE_PARENT from the aforementioned
clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8173.c | 76 +++++++++++++++----------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173.c
index b8529ee7199d..b57e33cda7a5 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173.c
@@ -37,19 +37,19 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_ARMCA7PLL_754M, "armca7pll_754m", "armca7pll", 1, 2),
 	FACTOR(CLK_TOP_ARMCA7PLL_502M, "armca7pll_502m", "armca7pll", 1, 3),
 
-	FACTOR(CLK_TOP_MAIN_H546M, "main_h546m", "mainpll", 1, 2),
-	FACTOR(CLK_TOP_MAIN_H364M, "main_h364m", "mainpll", 1, 3),
-	FACTOR(CLK_TOP_MAIN_H218P4M, "main_h218p4m", "mainpll", 1, 5),
-	FACTOR(CLK_TOP_MAIN_H156M, "main_h156m", "mainpll", 1, 7),
+	FACTOR_FLAGS(CLK_TOP_MAIN_H546M, "main_h546m", "mainpll", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAIN_H364M, "main_h364m", "mainpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_MAIN_H218P4M, "main_h218p4m", "mainpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_MAIN_H156M, "main_h156m", "mainpll", 1, 7, 0),
 
 	FACTOR(CLK_TOP_TVDPLL_445P5M, "tvdpll_445p5m", "tvdpll", 1, 4),
 	FACTOR(CLK_TOP_TVDPLL_594M, "tvdpll_594m", "tvdpll", 1, 3),
 
-	FACTOR(CLK_TOP_UNIV_624M, "univ_624m", "univpll", 1, 2),
-	FACTOR(CLK_TOP_UNIV_416M, "univ_416m", "univpll", 1, 3),
-	FACTOR(CLK_TOP_UNIV_249P6M, "univ_249p6m", "univpll", 1, 5),
-	FACTOR(CLK_TOP_UNIV_178P3M, "univ_178p3m", "univpll", 1, 7),
-	FACTOR(CLK_TOP_UNIV_48M, "univ_48m", "univpll", 1, 26),
+	FACTOR_FLAGS(CLK_TOP_UNIV_624M, "univ_624m", "univpll", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIV_416M, "univ_416m", "univpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIV_249P6M, "univ_249p6m", "univpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIV_178P3M, "univ_178p3m", "univpll", 1, 7, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIV_48M, "univ_48m", "univpll", 1, 26, 0),
 
 	FACTOR(CLK_TOP_CLKRTC_EXT, "clkrtc_ext", "clk32k", 1, 1),
 	FACTOR(CLK_TOP_CLKRTC_INT, "clkrtc_int", "clk26m", 1, 793),
@@ -84,20 +84,20 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_MSDCPLL2_D2, "msdcpll2_d2", "msdcpll2", 1, 2),
 	FACTOR(CLK_TOP_MSDCPLL2_D4, "msdcpll2_d4", "msdcpll2", 1, 4),
 
-	FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", "main_h546m", 1, 1),
-	FACTOR(CLK_TOP_SYSPLL1_D2, "syspll1_d2", "main_h546m", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL1_D4, "syspll1_d4", "main_h546m", 1, 4),
-	FACTOR(CLK_TOP_SYSPLL1_D8, "syspll1_d8", "main_h546m", 1, 8),
-	FACTOR(CLK_TOP_SYSPLL1_D16, "syspll1_d16", "main_h546m", 1, 16),
-	FACTOR(CLK_TOP_SYSPLL_D3, "syspll_d3", "main_h364m", 1, 1),
-	FACTOR(CLK_TOP_SYSPLL2_D2, "syspll2_d2", "main_h364m", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL2_D4, "syspll2_d4", "main_h364m", 1, 4),
-	FACTOR(CLK_TOP_SYSPLL_D5, "syspll_d5", "main_h218p4m", 1, 1),
-	FACTOR(CLK_TOP_SYSPLL3_D2, "syspll3_d2", "main_h218p4m", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL3_D4, "syspll3_d4", "main_h218p4m", 1, 4),
-	FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", "main_h156m", 1, 1),
-	FACTOR(CLK_TOP_SYSPLL4_D2, "syspll4_d2", "main_h156m", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL4_D4, "syspll4_d4", "main_h156m", 1, 4),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "main_h546m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D2, "syspll1_d2", "main_h546m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D4, "syspll1_d4", "main_h546m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D8, "syspll1_d8", "main_h546m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D16, "syspll1_d16", "main_h546m", 1, 16, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D3, "syspll_d3", "main_h364m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL2_D2, "syspll2_d2", "main_h364m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL2_D4, "syspll2_d4", "main_h364m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D5, "syspll_d5", "main_h218p4m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL3_D2, "syspll3_d2", "main_h218p4m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL3_D4, "syspll3_d4", "main_h218p4m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D7, "syspll_d7", "main_h156m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL4_D2, "syspll4_d2", "main_h156m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL4_D4, "syspll4_d4", "main_h156m", 1, 4, 0),
 
 	FACTOR(CLK_TOP_TVDPLL, "tvdpll_ck", "tvdpll_594m", 1, 1),
 	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_594m", 1, 2),
@@ -105,21 +105,21 @@ static const struct mtk_fixed_factor top_divs[] __initconst = {
 	FACTOR(CLK_TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll_594m", 1, 8),
 	FACTOR(CLK_TOP_TVDPLL_D16, "tvdpll_d16", "tvdpll_594m", 1, 16),
 
-	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univ_624m", 1, 1),
-	FACTOR(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", "univ_624m", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", "univ_624m", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL1_D8, "univpll1_d8", "univ_624m", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univ_416m", 1, 1),
-	FACTOR(CLK_TOP_UNIVPLL2_D2, "univpll2_d2", "univ_416m", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL2_D4, "univpll2_d4", "univ_416m", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL2_D8, "univpll2_d8", "univ_416m", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univ_249p6m", 1, 1),
-	FACTOR(CLK_TOP_UNIVPLL3_D2, "univpll3_d2", "univ_249p6m", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", "univ_249p6m", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL3_D8, "univpll3_d8", "univ_249p6m", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univ_178p3m", 1, 1),
-	FACTOR(CLK_TOP_UNIVPLL_D26, "univpll_d26", "univ_48m", 1, 1),
-	FACTOR(CLK_TOP_UNIVPLL_D52, "univpll_d52", "univ_48m", 1, 2),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univ_624m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", "univ_624m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", "univ_624m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D8, "univpll1_d8", "univ_624m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univ_416m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D2, "univpll2_d2", "univ_416m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D4, "univpll2_d4", "univ_416m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D8, "univpll2_d8", "univ_416m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univ_249p6m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D2, "univpll3_d2", "univ_249p6m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", "univ_249p6m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D8, "univpll3_d8", "univ_249p6m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univ_178p3m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D26, "univpll_d26", "univ_48m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D52, "univpll_d52", "univ_48m", 1, 2, 0),
 
 	FACTOR(CLK_TOP_VCODECPLL, "vcodecpll_ck", "vcodecpll", 1, 3),
 	FACTOR(CLK_TOP_VCODECPLL_370P5, "vcodecpll_370p5", "vcodecpll", 1, 4),
-- 
2.37.2

