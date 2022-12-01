Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813D263ED10
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbiLAJ5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbiLAJ4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:56:55 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7389AD6;
        Thu,  1 Dec 2022 01:56:54 -0800 (PST)
Received: from desky.lan (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A5450FA0;
        Thu,  1 Dec 2022 10:56:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669888612;
        bh=jZMMAkwHmA8cFqejXcAfGZM3yGnMV2WaN4/bqekHQPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OXtEiXs2bWb8TWu10ZYyA5GbIDL5t2t0ZpGLJCP/HnHZVM2gV6pA2UTAQKSHq7h5W
         eWcdIU0U0KPbK2MFomWKm6QnqFHckCK22Axn0S1rrLI25g0U+3xbiP6R9Z0EXNY0QC
         SfmnxPpVS1k4QWLzt+VmIU6wZoleKvXFu6YyDBP8=
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
Subject: [PATCH v5 3/7] clk: renesas: r8a779g0: Add display related clocks
Date:   Thu,  1 Dec 2022 11:56:27 +0200
Message-Id: <20221201095631.89448-4-tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221201095631.89448-1-tomi.valkeinen+renesas@ideasonboard.com>
References: <20221201095631.89448-1-tomi.valkeinen+renesas@ideasonboard.com>
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
 drivers/clk/renesas/r8a779g0-cpg-mssr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/renesas/r8a779g0-cpg-mssr.c b/drivers/clk/renesas/r8a779g0-cpg-mssr.c
index c6337a408e5e..d898ca391e6f 100644
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
@@ -161,6 +163,11 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("avb0",		211,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("avb1",		212,	R8A779G0_CLK_S0D4_HSC),
 	DEF_MOD("avb2",		213,	R8A779G0_CLK_S0D4_HSC),
+	DEF_MOD("dis0",		411,	R8A779G0_CLK_VIOBUSD2),
+	DEF_MOD("dsitxlink0",	415,	R8A779G0_CLK_VIOBUSD2),
+	DEF_MOD("dsitxlink1",	416,	R8A779G0_CLK_VIOBUSD2),
+	DEF_MOD("fcpvd0",	508,	R8A779G0_CLK_VIOBUSD2),
+	DEF_MOD("fcpvd1",	509,	R8A779G0_CLK_VIOBUSD2),
 	DEF_MOD("hscif0",	514,	R8A779G0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif1",	515,	R8A779G0_CLK_SASYNCPERD1),
 	DEF_MOD("hscif2",	516,	R8A779G0_CLK_SASYNCPERD1),
@@ -193,6 +200,8 @@ static const struct mssr_mod_clk r8a779g0_mod_clks[] __initconst = {
 	DEF_MOD("tmu3",		716,	R8A779G0_CLK_SASYNCPERD2),
 	DEF_MOD("tmu4",		717,	R8A779G0_CLK_SASYNCPERD2),
 	DEF_MOD("tpu0",		718,	R8A779G0_CLK_SASYNCPERD4),
+	DEF_MOD("vspd0",	830,	R8A779G0_CLK_VIOBUSD2),
+	DEF_MOD("vspd1",	831,	R8A779G0_CLK_VIOBUSD2),
 	DEF_MOD("wdt1:wdt0",	907,	R8A779G0_CLK_R),
 	DEF_MOD("cmt0",		910,	R8A779G0_CLK_R),
 	DEF_MOD("cmt1",		911,	R8A779G0_CLK_R),
-- 
2.34.1

