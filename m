Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48720609EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiJXKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiJXKXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:23:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC99758174;
        Mon, 24 Oct 2022 03:23:29 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D707F6602822;
        Mon, 24 Oct 2022 11:23:27 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666607008;
        bh=Ygu3QqLW7f5YrNuA3sNdeVICDbkntoh3fZrkeLdv9+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ox+QFEDY6gpFHKCYLMQjcDS3gHpDSUqEIB0prKjvzRWzaT1/6Yg+e2zEKleaQcb0R
         ZrZlZhhfstKW/qOssTg7PxQDzCYE+Ij6OPJ5djBQAxGZ5PJuiro9pHdXvl3tdGme3G
         pJKWmSlCXtLbvJZP4jRnTWPML/hvMCVcKcf9DfI8TpZH8yPRenUKyzrq+vBRa2npgo
         8zpj4buuaknxjhlnOECVrV6SUqfMxoAk+3fKfY5U2EcKP9kf9hYC0pInq6bczKVmQZ
         eTN3JWXs8NHXh+x7lhjOsF45rS+4FFe5IAgoj4cDj4QQNB/zu1LZFi39h5mW98vkDl
         qXDix2KIqRdiQ==
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
Subject: [PATCH 03/10] clk: mediatek: mt8183: Compress top_divs array entries
Date:   Mon, 24 Oct 2022 12:23:00 +0200
Message-Id: <20221024102307.33722-4-angelogioacchino.delregno@collabora.com>
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

There's no need to split each FACTOR entry in two lines, as each of
them does fit in one line just fine.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8183.c | 216 ++++++++++--------------------
 1 file changed, 72 insertions(+), 144 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 1860a35a723a..c3a39db524be 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -31,150 +31,78 @@ static const struct mtk_fixed_factor top_early_divs[] = {
 };
 
 static const struct mtk_fixed_factor top_divs[] = {
-	FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1,
-		2),
-	FACTOR(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1,
-		1),
-	FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1,
-		2),
-	FACTOR(CLK_TOP_SYSPLL_D2_D2, "syspll_d2_d2", "syspll_d2", 1,
-		2),
-	FACTOR(CLK_TOP_SYSPLL_D2_D4, "syspll_d2_d4", "syspll_d2", 1,
-		4),
-	FACTOR(CLK_TOP_SYSPLL_D2_D8, "syspll_d2_d8", "syspll_d2", 1,
-		8),
-	FACTOR(CLK_TOP_SYSPLL_D2_D16, "syspll_d2_d16", "syspll_d2", 1,
-		16),
-	FACTOR(CLK_TOP_SYSPLL_D3, "syspll_d3", "mainpll", 1,
-		3),
-	FACTOR(CLK_TOP_SYSPLL_D3_D2, "syspll_d3_d2", "syspll_d3", 1,
-		2),
-	FACTOR(CLK_TOP_SYSPLL_D3_D4, "syspll_d3_d4", "syspll_d3", 1,
-		4),
-	FACTOR(CLK_TOP_SYSPLL_D3_D8, "syspll_d3_d8", "syspll_d3", 1,
-		8),
-	FACTOR(CLK_TOP_SYSPLL_D5, "syspll_d5", "mainpll", 1,
-		5),
-	FACTOR(CLK_TOP_SYSPLL_D5_D2, "syspll_d5_d2", "syspll_d5", 1,
-		2),
-	FACTOR(CLK_TOP_SYSPLL_D5_D4, "syspll_d5_d4", "syspll_d5", 1,
-		4),
-	FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", "mainpll", 1,
-		7),
-	FACTOR(CLK_TOP_SYSPLL_D7_D2, "syspll_d7_d2", "syspll_d7", 1,
-		2),
-	FACTOR(CLK_TOP_SYSPLL_D7_D4, "syspll_d7_d4", "syspll_d7", 1,
-		4),
-	FACTOR(CLK_TOP_UNIVPLL_CK, "univpll_ck", "univpll", 1,
-		1),
-	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll_ck", 1,
-		2),
-	FACTOR(CLK_TOP_UNIVPLL_D2_D2, "univpll_d2_d2", "univpll_d2", 1,
-		2),
-	FACTOR(CLK_TOP_UNIVPLL_D2_D4, "univpll_d2_d4", "univpll_d2", 1,
-		4),
-	FACTOR(CLK_TOP_UNIVPLL_D2_D8, "univpll_d2_d8", "univpll_d2", 1,
-		8),
-	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1,
-		3),
-	FACTOR(CLK_TOP_UNIVPLL_D3_D2, "univpll_d3_d2", "univpll_d3", 1,
-		2),
-	FACTOR(CLK_TOP_UNIVPLL_D3_D4, "univpll_d3_d4", "univpll_d3", 1,
-		4),
-	FACTOR(CLK_TOP_UNIVPLL_D3_D8, "univpll_d3_d8", "univpll_d3", 1,
-		8),
-	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1,
-		5),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll_d5", 1,
-		2),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll_d5", 1,
-		4),
-	FACTOR(CLK_TOP_UNIVPLL_D5_D8, "univpll_d5_d8", "univpll_d5", 1,
-		8),
-	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1,
-		7),
-	FACTOR(CLK_TOP_UNIVP_192M_CK, "univ_192m_ck", "univpll_192m", 1,
-		1),
-	FACTOR(CLK_TOP_UNIVP_192M_D2, "univ_192m_d2", "univ_192m_ck", 1,
-		2),
-	FACTOR(CLK_TOP_UNIVP_192M_D4, "univ_192m_d4", "univ_192m_ck", 1,
-		4),
-	FACTOR(CLK_TOP_UNIVP_192M_D8, "univ_192m_d8", "univ_192m_ck", 1,
-		8),
-	FACTOR(CLK_TOP_UNIVP_192M_D16, "univ_192m_d16", "univ_192m_ck", 1,
-		16),
-	FACTOR(CLK_TOP_UNIVP_192M_D32, "univ_192m_d32", "univ_192m_ck", 1,
-		32),
-	FACTOR(CLK_TOP_APLL1_CK, "apll1_ck", "apll1", 1,
-		1),
-	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", "apll1", 1,
-		2),
-	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1", 1,
-		4),
-	FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", "apll1", 1,
-		8),
-	FACTOR(CLK_TOP_APLL2_CK, "apll2_ck", "apll2", 1,
-		1),
-	FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", "apll2", 1,
-		2),
-	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "apll2", 1,
-		4),
-	FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", "apll2", 1,
-		8),
-	FACTOR(CLK_TOP_TVDPLL_CK, "tvdpll_ck", "tvdpll", 1,
-		1),
-	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_ck", 1,
-		2),
-	FACTOR(CLK_TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll", 1,
-		4),
-	FACTOR(CLK_TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll", 1,
-		8),
-	FACTOR(CLK_TOP_TVDPLL_D16, "tvdpll_d16", "tvdpll", 1,
-		16),
-	FACTOR(CLK_TOP_MMPLL_CK, "mmpll_ck", "mmpll", 1,
-		1),
-	FACTOR(CLK_TOP_MMPLL_D4, "mmpll_d4", "mmpll", 1,
-		4),
-	FACTOR(CLK_TOP_MMPLL_D4_D2, "mmpll_d4_d2", "mmpll_d4", 1,
-		2),
-	FACTOR(CLK_TOP_MMPLL_D4_D4, "mmpll_d4_d4", "mmpll_d4", 1,
-		4),
-	FACTOR(CLK_TOP_MMPLL_D5, "mmpll_d5", "mmpll", 1,
-		5),
-	FACTOR(CLK_TOP_MMPLL_D5_D2, "mmpll_d5_d2", "mmpll_d5", 1,
-		2),
-	FACTOR(CLK_TOP_MMPLL_D5_D4, "mmpll_d5_d4", "mmpll_d5", 1,
-		4),
-	FACTOR(CLK_TOP_MMPLL_D6, "mmpll_d6", "mmpll", 1,
-		6),
-	FACTOR(CLK_TOP_MMPLL_D7, "mmpll_d7", "mmpll", 1,
-		7),
-	FACTOR(CLK_TOP_MFGPLL_CK, "mfgpll_ck", "mfgpll", 1,
-		1),
-	FACTOR(CLK_TOP_MSDCPLL_CK, "msdcpll_ck", "msdcpll", 1,
-		1),
-	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1,
-		2),
-	FACTOR(CLK_TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1,
-		4),
-	FACTOR(CLK_TOP_MSDCPLL_D8, "msdcpll_d8", "msdcpll", 1,
-		8),
-	FACTOR(CLK_TOP_MSDCPLL_D16, "msdcpll_d16", "msdcpll", 1,
-		16),
-	FACTOR(CLK_TOP_AD_OSC_CK, "ad_osc_ck", "osc", 1,
-		1),
-	FACTOR(CLK_TOP_OSC_D2, "osc_d2", "osc", 1,
-		2),
-	FACTOR(CLK_TOP_OSC_D4, "osc_d4", "osc", 1,
-		4),
-	FACTOR(CLK_TOP_OSC_D8, "osc_d8", "osc", 1,
-		8),
-	FACTOR(CLK_TOP_OSC_D16, "osc_d16", "osc", 1,
-		16),
-	FACTOR(CLK_TOP_UNIVPLL, "univpll", "univ2pll", 1,
-		2),
-	FACTOR(CLK_TOP_UNIVPLL_D3_D16, "univpll_d3_d16", "univpll_d3", 1,
-		16),
+	FACTOR(CLK_TOP_F26M_CK_D2, "csw_f26m_ck_d2", "clk26m", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL_CK, "syspll_ck", "mainpll", 1, 1),
+	FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", "syspll_ck", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL_D2_D2, "syspll_d2_d2", "syspll_d2", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL_D2_D4, "syspll_d2_d4", "syspll_d2", 1, 4),
+	FACTOR(CLK_TOP_SYSPLL_D2_D8, "syspll_d2_d8", "syspll_d2", 1, 8),
+	FACTOR(CLK_TOP_SYSPLL_D2_D16, "syspll_d2_d16", "syspll_d2", 1, 16),
+	FACTOR(CLK_TOP_SYSPLL_D3, "syspll_d3", "mainpll", 1, 3),
+	FACTOR(CLK_TOP_SYSPLL_D3_D2, "syspll_d3_d2", "syspll_d3", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL_D3_D4, "syspll_d3_d4", "syspll_d3", 1, 4),
+	FACTOR(CLK_TOP_SYSPLL_D3_D8, "syspll_d3_d8", "syspll_d3", 1, 8),
+	FACTOR(CLK_TOP_SYSPLL_D5, "syspll_d5", "mainpll", 1, 5),
+	FACTOR(CLK_TOP_SYSPLL_D5_D2, "syspll_d5_d2", "syspll_d5", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL_D5_D4, "syspll_d5_d4", "syspll_d5", 1, 4),
+	FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", "mainpll", 1, 7),
+	FACTOR(CLK_TOP_SYSPLL_D7_D2, "syspll_d7_d2", "syspll_d7", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL_D7_D4, "syspll_d7_d4", "syspll_d7", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_CK, "univpll_ck", "univpll", 1, 1),
+	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll_ck", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D2_D2, "univpll_d2_d2", "univpll_d2", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D2_D4, "univpll_d2_d4", "univpll_d2", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D2_D8, "univpll_d2_d8", "univpll_d2", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
+	FACTOR(CLK_TOP_UNIVPLL_D3_D2, "univpll_d3_d2", "univpll_d3", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D3_D4, "univpll_d3_d4", "univpll_d3", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D3_D8, "univpll_d3_d8", "univpll_d3", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D2, "univpll_d5_d2", "univpll_d5", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D4, "univpll_d5_d4", "univpll_d5", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL_D5_D8, "univpll_d5_d8", "univpll_d5", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univpll", 1, 7),
+	FACTOR(CLK_TOP_UNIVP_192M_CK, "univ_192m_ck", "univpll_192m", 1, 1),
+	FACTOR(CLK_TOP_UNIVP_192M_D2, "univ_192m_d2", "univ_192m_ck", 1, 2),
+	FACTOR(CLK_TOP_UNIVP_192M_D4, "univ_192m_d4", "univ_192m_ck", 1, 4),
+	FACTOR(CLK_TOP_UNIVP_192M_D8, "univ_192m_d8", "univ_192m_ck", 1, 8),
+	FACTOR(CLK_TOP_UNIVP_192M_D16, "univ_192m_d16", "univ_192m_ck", 1, 16),
+	FACTOR(CLK_TOP_UNIVP_192M_D32, "univ_192m_d32", "univ_192m_ck", 1, 32),
+	FACTOR(CLK_TOP_APLL1_CK, "apll1_ck", "apll1", 1, 1),
+	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", "apll1", 1, 2),
+	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1", 1, 4),
+	FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", "apll1", 1, 8),
+	FACTOR(CLK_TOP_APLL2_CK, "apll2_ck", "apll2", 1, 1),
+	FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", "apll2", 1, 2),
+	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "apll2", 1, 4),
+	FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", "apll2", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL_CK, "tvdpll_ck", "tvdpll", 1, 1),
+	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_ck", 1, 2),
+	FACTOR(CLK_TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll", 1, 4),
+	FACTOR(CLK_TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL_D16, "tvdpll_d16", "tvdpll", 1, 16),
+	FACTOR(CLK_TOP_MMPLL_CK, "mmpll_ck", "mmpll", 1, 1),
+	FACTOR(CLK_TOP_MMPLL_D4, "mmpll_d4", "mmpll", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D4_D2, "mmpll_d4_d2", "mmpll_d4", 1, 2),
+	FACTOR(CLK_TOP_MMPLL_D4_D4, "mmpll_d4_d4", "mmpll_d4", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D5, "mmpll_d5", "mmpll", 1, 5),
+	FACTOR(CLK_TOP_MMPLL_D5_D2, "mmpll_d5_d2", "mmpll_d5", 1, 2),
+	FACTOR(CLK_TOP_MMPLL_D5_D4, "mmpll_d5_d4", "mmpll_d5", 1, 4),
+	FACTOR(CLK_TOP_MMPLL_D6, "mmpll_d6", "mmpll", 1, 6),
+	FACTOR(CLK_TOP_MMPLL_D7, "mmpll_d7", "mmpll", 1, 7),
+	FACTOR(CLK_TOP_MFGPLL_CK, "mfgpll_ck", "mfgpll", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL_CK, "msdcpll_ck", "msdcpll", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(CLK_TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
+	FACTOR(CLK_TOP_MSDCPLL_D8, "msdcpll_d8", "msdcpll", 1, 8),
+	FACTOR(CLK_TOP_MSDCPLL_D16, "msdcpll_d16", "msdcpll", 1, 16),
+	FACTOR(CLK_TOP_AD_OSC_CK, "ad_osc_ck", "osc", 1, 1),
+	FACTOR(CLK_TOP_OSC_D2, "osc_d2", "osc", 1, 2),
+	FACTOR(CLK_TOP_OSC_D4, "osc_d4", "osc", 1, 4),
+	FACTOR(CLK_TOP_OSC_D8, "osc_d8", "osc", 1, 8),
+	FACTOR(CLK_TOP_OSC_D16, "osc_d16", "osc", 1, 16),
+	FACTOR(CLK_TOP_UNIVPLL, "univpll", "univ2pll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D3_D16, "univpll_d3_d16", "univpll_d3", 1, 16),
 };
 
 static const char * const axi_parents[] = {
-- 
2.37.2

