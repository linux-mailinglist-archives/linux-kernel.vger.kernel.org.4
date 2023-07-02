Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1C5744F87
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 19:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjGBR4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 13:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjGBR4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 13:56:01 -0400
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050:0:465::102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE96E67;
        Sun,  2 Jul 2023 10:56:00 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4QvGv30QhXz9sbm;
        Sun,  2 Jul 2023 19:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
        s=MBO0001; t=1688320559;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=05TpVB802qVXSW1gPTBeMS94czD58kHBof/XOWCW1Cs=;
        b=kj3eZyPWodwYgfYKNr14Nci5mhsXcWgQ04CfPu8XIFU7cyRpWI+61p2Onwl1RDxwP6X6PR
        ugBTP6pmuj2hAvm86HSibUMeT+YNFuLjr6yp42YKlFOvKik2ZSgfInuNCK8kWWrn5gm6CE
        gBGkW4O/5BGpm2QbsfmEhfn9SnedHhYNj13QJ7cllOz7jxPPzdtw2NDDyLZpEZkZyTMRh7
        /nQboXmNpRYOElc5iwuWRxr/ChqiHmVVzjopTvVEvAJXWibmg8YCbxkNc9bEteDHen1LoF
        12wAM+v2NZMbkg5mdHAC7V9TIZUVjPOUMtAgvaeZGHJxdjhdgD1brecUSVHrcw==
From:   Frank Oltmanns <frank@oltmanns.dev>
Date:   Sun, 02 Jul 2023 19:55:27 +0200
Subject: [PATCH v3 8/8] clk: sunxi-ng: a64: select closest rate for
 pll-video0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230702-pll-mipi_set_rate_parent-v3-8-46dcb8aa9cbc@oltmanns.dev>
References: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
In-Reply-To: <20230702-pll-mipi_set_rate_parent-v3-0-46dcb8aa9cbc@oltmanns.dev>
To:     Maxime Ripard <maxime@cerno.tech>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Roman Beranek <me@crly.cz>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Frank Oltmanns <frank@oltmanns.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=3899; i=frank@oltmanns.dev;
 h=from:subject:message-id; bh=197LnJF+mxqJfrEMx97C1MbnPBlm/s49NUyIjbbLA7Y=;
 b=owEB7QES/pANAwAIAZppogiUStPHAcsmYgBkobocAcoKsagwzSb+TESv5+jJ5hL5vFRkXaIz0
 0LDdil9I8qJAbMEAAEIAB0WIQQC/SV7f5DmuaVET5aaaaIIlErTxwUCZKG6HAAKCRCaaaIIlErT
 x8woC/9KvSYyv+ISWgVej+ZAx4vm4YPRhLI7QKFc5BwLhASffMU3Z/in+P8BNB/R7d6qSJa5KDH
 rLztcWXkfww2Rmk8x02bMj0fSGedSadr5DDKQTblJ351qB4ayDz01hRO3ahxxgArYTTC/YpEKJP
 4AIZLW4pIIGChLt/QopvUPFJ8wXSgmCnADXLPmdOHgrym2xoVfIU2CRACFXBsrFcdaOMNQ7YfAH
 sFHR3KmRnsQNIfK4+MdQIAA8xvm5KsYZfBXL5HPnB1D1fCe+liMwcW3SQXF6wKVCNnFFp21silu
 p1ZFMVLrinGZrO47MEfVWFEYme0N3mBkJzjJPzaKhzu8ARe4Nu9u0Hbh0jmS4Gj0d2dJ5Ica+tC
 epfxxjTulS7QTtaTQwVav3JTAfj5vyH4IJSyqFYH+Qkysrc8jji5FcMpxIjvfwifcHIdWmY+XlB
 9e4SkdYsI8zONOE+9N5sn/5eIEVnQ9LWBLRXFxoHc378pgHcLHZebe7UwTg9UR9d85D18=
X-Developer-Key: i=frank@oltmanns.dev; a=openpgp;
 fpr=02FD257B7F90E6B9A5444F969A69A208944AD3C7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Selecting the closest rate for pll-video0 instead of the closest rate
that is less than the requested rate has no downside for this clock,
while allowing for selecting a more suitable rate, e.g. for the
connected panels.

Furthermore, the algorithm that sets an NKM clock's parent benefits from
the closest rate. Without it, the NKM clock's rate might drift away from
the requested rate in the multiple successive calls to
ccu_nkm_determine_rate that the clk framework performs when setting a
clock rate.

Therefore, configure pll-video0 and, in consequence, all of its
descendents to select the closest rate.

Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index ebfab1fdbb96..016432ff3bde 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -81,7 +81,7 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX(pll_video0_clk, "pll-video0",
 						BIT(31),	/* gate */
 						BIT(28),	/* lock */
 						CLK_SET_RATE_UNGATE,
-						0);		/* features */
+						CCU_FEATURE_CLOSEST_RATE);
 
 static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
 					"osc24M", 0x018,
@@ -183,6 +183,7 @@ static struct ccu_nkm pll_mipi_clk = {
 		.hw.init	= CLK_HW_INIT("pll-mipi", "pll-video0",
 					      &ccu_nkm_ops,
 					      CLK_SET_RATE_UNGATE | CLK_SET_RATE_PARENT),
+		.features	= CCU_FEATURE_CLOSEST_RATE,
 	},
 };
 
@@ -533,7 +534,7 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
 
 static const char * const tcon0_parents[] = { "pll-mipi", "pll-video0-2x" };
 static const u8 tcon0_table[] = { 0, 2, };
-static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
+static SUNXI_CCU_MUX_TABLE_WITH_GATE_CLOSEST(tcon0_clk, "tcon0", tcon0_parents,
 				     tcon0_table, 0x118, 24, 3, BIT(31),
 				     CLK_SET_RATE_PARENT);
 
@@ -541,7 +542,7 @@ static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
 static const u8 tcon1_table[] = { 0, 2, };
 static struct ccu_div tcon1_clk = {
 	.enable		= BIT(31),
-	.div		= _SUNXI_CCU_DIV(0, 4),
+	.div		= _SUNXI_CCU_DIV_FLAGS(0, 4, CLK_DIVIDER_ROUND_CLOSEST),
 	.mux		= _SUNXI_CCU_MUX_TABLE(24, 2, tcon1_table),
 	.common		= {
 		.reg		= 0x11c,
@@ -549,6 +550,7 @@ static struct ccu_div tcon1_clk = {
 						      tcon1_parents,
 						      &ccu_div_ops,
 						      CLK_SET_RATE_PARENT),
+		.features	= CCU_FEATURE_CLOSEST_RATE,
 	},
 };
 
@@ -580,8 +582,8 @@ static SUNXI_CCU_GATE(avs_clk,		"avs",		"osc24M",
 		      0x144, BIT(31), 0);
 
 static const char * const hdmi_parents[] = { "pll-video0", "pll-video1" };
-static SUNXI_CCU_M_WITH_MUX_GATE(hdmi_clk, "hdmi", hdmi_parents,
-				 0x150, 0, 4, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_MUX_GATE_CLOSEST(hdmi_clk, "hdmi", hdmi_parents,
+					 0x150, 0, 4, 24, 2, BIT(31), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_GATE(hdmi_ddc_clk,	"hdmi-ddc",	"osc24M",
 		      0x154, BIT(31), 0);
@@ -593,9 +595,9 @@ static SUNXI_CCU_M_WITH_MUX_GATE(mbus_clk, "mbus", mbus_parents,
 
 static const char * const dsi_dphy_parents[] = { "pll-video0", "pll-periph0" };
 static const u8 dsi_dphy_table[] = { 0, 2, };
-static SUNXI_CCU_M_WITH_MUX_TABLE_GATE(dsi_dphy_clk, "dsi-dphy",
-				       dsi_dphy_parents, dsi_dphy_table,
-				       0x168, 0, 4, 8, 2, BIT(15), CLK_SET_RATE_PARENT);
+static SUNXI_CCU_M_WITH_MUX_TABLE_GATE_CLOSEST(dsi_dphy_clk, "dsi-dphy",
+					       dsi_dphy_parents, dsi_dphy_table,
+					       0x168, 0, 4, 8, 2, BIT(15), CLK_SET_RATE_PARENT);
 
 static SUNXI_CCU_M_WITH_GATE(gpu_clk, "gpu", "pll-gpu",
 			     0x1a0, 0, 3, BIT(31), CLK_SET_RATE_PARENT);

-- 
2.41.0

