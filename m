Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94DDB609EF6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbiJXKXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJXKXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:23:32 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5816058DC1;
        Mon, 24 Oct 2022 03:23:31 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E1D306602823;
        Mon, 24 Oct 2022 11:23:28 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666607009;
        bh=HJKRfPEokO3fEPoEdcjIjEuvPiIooT5R8la1dbxAxaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M2olirON2kaZKyRzZ2CLZr3tA9QIDqQhyOKcQRuMd+aFW8wlRsxu2ntRkRLJDmm7+
         vKJDxuuPFoEHytpEyivXKPSzVkmXuKWgz2ek4Fxywuv1XhtOWY+w7Vkhcz6E7qglbd
         jnqH7/WOKTRCHqMA+dHxNBTvE+Keaj1kGVEqppmbzQUPKKVXdNhU3P+EROm+bAJpwP
         roaZs0f0LaqerBS7/xFgesx0aTLH8gE2v3Rv7ay2xICVEm5ViV3L8+Kn8pBpl/blwo
         sKHvpfKPVHwOJTqIo4YJVSBrD6u++fsf5E1UdadsTKhdMHazRJaWKXFE/1mf506N/C
         PX6CHbLEyaHzg==
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
Subject: [PATCH 04/10] clk: mediatek: mt8183: Drop flags for sys/univpll fixed factors
Date:   Mon, 24 Oct 2022 12:23:01 +0200
Message-Id: <20221024102307.33722-5-angelogioacchino.delregno@collabora.com>
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

The syspll and univpll clocks are used as clock sources for multiple
peripherals of different kind, some of which are critical (like AXIs);
a rate change on any of these two will produce a rate change on many
devices and that's likely to produce system instability if not done
correctly: this is the reason why we have (a lot of) "fixed factor"
sys/univpll divider clocks, used by MUX clocks to provide different
rates based on PLL output dividers.

Following what was done on clk-mt8186-topckgen and also solving the
same GPU DVFS issue, drop CLK_SET_RATE_PARENT from the aforementioned
clocks.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 76 +++++++++++++++----------------
 1 file changed, 38 insertions(+), 38 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index c3a39db524be..23afc9584638 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -32,42 +32,42 @@ static const struct mtk_fixed_factor top_early_divs[] = {
 
 static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1, 1),
-	FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL_D2_D2, "syspll_d2_d2", "syspll_d2", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL_D2_D4, "syspll_d2_d4", "syspll_d2", 1, 4),
-	FACTOR(CLK_TOP_SYSPLL_D2_D8, "syspll_d2_d8", "syspll_d2", 1, 8),
-	FACTOR(CLK_TOP_SYSPLL_D2_D16, "syspll_d2_d16", "syspll_d2", 1, 16),
-	FACTOR(CLK_TOP_SYSPLL_D3, "syspll_d3", "mainpll", 1, 3),
-	FACTOR(CLK_TOP_SYSPLL_D3_D2, "syspll_d3_d2", "syspll_d3", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL_D3_D4, "syspll_d3_d4", "syspll_d3", 1, 4),
-	FACTOR(CLK_TOP_SYSPLL_D3_D8, "syspll_d3_d8", "syspll_d3", 1, 8),
-	FACTOR(CLK_TOP_SYSPLL_D5, "syspll_d5", "mainpll", 1, 5),
-	FACTOR(CLK_TOP_SYSPLL_D5_D2, "syspll_d5_d2", "syspll_d5", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL_D5_D4, "syspll_d5_d4", "syspll_d5", 1, 4),
-	FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", "mainpll", 1, 7),
-	FACTOR(CLK_TOP_SYSPLL_D7_D2, "syspll_d7_d2", "syspll_d7", 1, 2),
-	FACTOR(CLK_TOP_SYSPLL_D7_D4, "syspll_d7_d4", "syspll_d7", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_CK, "univpll_ck", "univpll", 1, 1),
-	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll_ck", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D2_D2, "univpll_d2_d2", "univpll_d2", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D2_D4, "univpll_d2_d4", "univpll_d2", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_D2_D8, "univpll_d2_d8", "univpll_d2", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
-	FACTOR(CLK_TOP_UNIVPLL_D3_D2, "univpll_d3_d2", "univpll_d3", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D3_D4, "univpll_d3_d4", "univpll_d3", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_D3_D8, "univpll_d3_d8", "univpll_d3", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll_d5", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll_d5", 1, 4),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D8, "univpll_d5_d8", "univpll_d5", 1, 8),
-	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1, 7),
-	FACTOR(CLK_TOP_UNIVP_192M_CK, "univ_192m_ck", "univpll_192m", 1, 1),
-	FACTOR(CLK_TOP_UNIVP_192M_D2, "univ_192m_d2", "univ_192m_ck", 1, 2),
-	FACTOR(CLK_TOP_UNIVP_192M_D4, "univ_192m_d4", "univ_192m_ck", 1, 4),
-	FACTOR(CLK_TOP_UNIVP_192M_D8, "univ_192m_d8", "univ_192m_ck", 1, 8),
-	FACTOR(CLK_TOP_UNIVP_192M_D16, "univ_192m_d16", "univ_192m_ck", 1, 16),
-	FACTOR(CLK_TOP_UNIVP_192M_D32, "univ_192m_d32", "univ_192m_ck", 1, 32),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2_D2, "syspll_d2_d2", "syspll_d2", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2_D4, "syspll_d2_d4", "syspll_d2", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2_D8, "syspll_d2_d8", "syspll_d2", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2_D16, "syspll_d2_d16", "syspll_d2", 1, 16, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D3, "syspll_d3", "mainpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D3_D2, "syspll_d3_d2", "syspll_d3", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D3_D4, "syspll_d3_d4", "syspll_d3", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D3_D8, "syspll_d3_d8", "syspll_d3", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D5, "syspll_d5", "mainpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D5_D2, "syspll_d5_d2", "syspll_d5", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D5_D4, "syspll_d5_d4", "syspll_d5", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D7, "syspll_d7", "mainpll", 1, 7, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D7_D2, "syspll_d7_d2", "syspll_d7", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D7_D4, "syspll_d7_d4", "syspll_d7", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_CK, "univpll_ck", "univpll", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll_ck", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D2_D2, "univpll_d2_d2", "univpll_d2", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D2_D4, "univpll_d2_d4", "univpll_d2", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D2_D8, "univpll_d2_d8", "univpll_d2", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3_D2, "univpll_d3_d2", "univpll_d3", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3_D4, "univpll_d3_d4", "univpll_d3", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3_D8, "univpll_d3_d8", "univpll_d3", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll_d5", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll_d5", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5_D8, "univpll_d5_d8", "univpll_d5", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1, 7, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVP_192M_CK, "univ_192m_ck", "univpll_192m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVP_192M_D2, "univ_192m_d2", "univ_192m_ck", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVP_192M_D4, "univ_192m_d4", "univ_192m_ck", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVP_192M_D8, "univ_192m_d8", "univ_192m_ck", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVP_192M_D16, "univ_192m_d16", "univ_192m_ck", 1, 16, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVP_192M_D32, "univ_192m_d32", "univ_192m_ck", 1, 32, 0),
 	FACTOR(CLK_TOP_APLL1_CK, "apll1_ck", "apll1", 1, 1),
 	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", "apll1", 1, 2),
 	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1", 1, 4),
@@ -101,8 +101,8 @@ static const struct mtk_fixed_factor top_divs[] = {
 	FACTOR(CLK_TOP_OSC_D4, "osc_d4", "osc", 1, 4),
 	FACTOR(CLK_TOP_OSC_D8, "osc_d8", "osc", 1, 8),
 	FACTOR(CLK_TOP_OSC_D16, "osc_d16", "osc", 1, 16),
-	FACTOR(CLK_TOP_UNIVPLL, "univpll", "univ2pll", 1, 2),
-	FACTOR(CLK_TOP_UNIVPLL_D3_D16, "univpll_d3_d16", "univpll_d3", 1, 16),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL, "univpll", "univ2pll", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3_D16, "univpll_d3_d16", "univpll_d3", 1, 16, 0),
 };
 
 static const char * const axi_parents[] = {
-- 
2.37.2

