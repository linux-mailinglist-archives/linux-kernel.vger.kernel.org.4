Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B349F6350D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 08:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236228AbiKWHAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 02:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236189AbiKWHAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 02:00:30 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3C882BC0;
        Tue, 22 Nov 2022 23:00:29 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 81584FEF;
        Wed, 23 Nov 2022 08:00:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669186827;
        bh=hyKIAc12RaYs4yCe88LmLek9pzeApWhl2iL75JyuReY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FEX4oTGsugTncQYkV4+IB/zkl1cR1LnWsPci48j8hcgl657PRQOTXfRhzGUrAE4iI
         +cQTShnNJQXh/Whb59yaFHmx6w7OZacNhyhTLSflNZ+zCqvKg/FF41Zzx74bNXmdUo
         e5+HSCW5DHC3MTf16C5s/Q6YHc/b/WMbF2ovaGRs=
From:   Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH v2 3/7] clk: renesas: r8a779g0: Add display related clocks
Date:   Wed, 23 Nov 2022 08:59:42 +0200
Message-Id: <20221123065946.40415-4-tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clocks related to display which are needed to get the DSI output
working.

Extracted from Renesas BSP tree.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index c6337a408e5e..6937f1aee677 100644
--- a/drivers/clk/renesas/r8a779g0-cpg-mssr.c
+++ b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
@@ -145,6 +145,8 @@ static const struct cpg_core_clk r8a779g0_core_clks[] __initconst = {
 	DEF_FIXED("viobusd2",	R8A779G0_CLK_VIOBUSD2,	CLK_VIO,	2, 1),
 	DEF_FIXED("vcbus",	R8A779G0_CLK_VCBUS,	CLK_VC,		1, 1),
 	DEF_FIXED("vcbusd2",	R8A779G0_CLK_VCBUSD2,	CLK_VC,		2, 1),
+	DEF_FIXED("dsiref",	R8A779G0_CLK_DSIREF,	CLK_PLL5_DIV4,	48, 1),
+	DEF_DIV6P1("dsiext",	R8A779G0_CLK_DSIEXT,	CLK_PLL5_DIV4,	0x884),
 
 	DEF_GEN4_SDH("sd0h",	R8A779G0_CLK_SD0H,	CLK_SDSRC,	   0x870),
 	DEF_GEN4_SD("sd0",	R8A779G0_CLK_SD0,	R8A779G0_CLK_SD0H, 0x870),
@@ -161,6 +163,14 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("avb0",		211,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("avb1",		212,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("avb2",		213,	R8A779G0_CLK_S0D4_HSC),
+
+	DEF_MOD("dis0",			411,	R8A779G0_CLK_S0D3),
+	DEF_MOD("dsitxlink0",		415,	R8A779G0_CLK_DSIREF),
+	DEF_MOD("dsitxlink1",		416,	R8A779G0_CLK_DSIREF),
+
+	DEF_MOD("fcpvd0",		508,	R8A779G0_CLK_S0D3),
+	DEF_MOD("fcpvd1",		509,	R8A779G0_CLK_S0D3),
+
 	DEF_MOD("hscif0",	514,	R8A779G0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif1",	515,	R8A779G0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif2",	516,	R8A779G0_CLK_SASYNCPERD1),
@@ -193,6 +203,10 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("tmu3",		716,	R8A779G0_CLK_SASYNCPERD2),
 	DEF_MOD("tmu4",		717,	R8A779G0_CLK_SASYNCPERD2),
 	DEF_MOD("tpu0",		718,	R8A779G0_CLK_SASYNCPERD4),
+
+	DEF_MOD("vspd0",		830,	R8A779G0_CLK_S0D1_VIO),
+	DEF_MOD("vspd1",		831,	R8A779G0_CLK_S0D1_VIO),
+
 	DEF_MOD("wdt1:wdt0",	907,	R8A779G0_CLK_R),
 	DEF_MOD("cmt0",		910,	R8A779G0_CLK_R),
 	DEF_MOD("cmt1",		911,	R8A779G0_CLK_R),
-- 
2.34.1

