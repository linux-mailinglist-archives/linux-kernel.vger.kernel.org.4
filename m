Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC61E6F7C51
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjEEFVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEEFVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:21:33 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B911B7A;
        Thu,  4 May 2023 22:21:31 -0700 (PDT)
Received: (Authenticated sender: me@crly.cz)
        by mail.gandi.net (Postfix) with ESMTPSA id 1156A1BF206;
        Fri,  5 May 2023 05:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crly.cz; s=gm1;
        t=1683264089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTishZVtaZFYmhTS+E1QiU0pRfLyhtvgErYcS+oT66w=;
        b=GVdpRfQ/+vgBYi++UmvBh4Y77lLLjV4XQnUR02Wa1uGtdEboJRUvP2SlRJqgIndYgUV7bf
        A2HTns2I7UbKS8wBlemmnZEVKfAQDxFLWchJe5CBss/g2qHVcGZjEtFngnl/tApm5H8A7l
        fMbdVIExXmZwm74jiCf44UO/+ppvgyZWEhUYttjca9+sE05nsLhCUAX/tChhhoMZSOUlmk
        LoG9YlW1mwJ9vQ4thicJrxVG/+NP+VBSlzEwpgc9VNK0+58Wfufl+OGVUnyzqIysybzLW5
        0ddVdLLGX5DO5ASd1DlaX3OvGdxNMjBUEteikOQ/aIIu5ZpKtgOV0NtS3LVIqQ==
From:   Roman Beranek <me@crly.cz>
To:     Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] clk: sunxi-ng: a64: force select PLL_MIPI in TCON0 mux
Date:   Fri,  5 May 2023 07:21:07 +0200
Message-Id: <20230505052110.67514-2-me@crly.cz>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20230505052110.67514-1-me@crly.cz>
References: <20230505052110.67514-1-me@crly.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TCON0's source clock can be fed from either PLL_MIPI, or PLL_VIDEO0(2X),
however MIPI DSI output only seems to work when PLL_MIPI is selected and
thus the choice must be hardcoded in.

Currently, this driver can't propagate rate change from N-K-M clocks
(such as PLL_MIPI) upwards. This prevents PLL_VIDEO0 from participating
in setting of the TCON0 data clock rate, limiting the precision with
which a target pixel clock can be matched.

For outputs with fixed TCON0 divider, that is DSI and LVDS, the dotclock
can deviate up to 8% off target.

Signed-off-by: Roman Beranek <me@crly.cz>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 41519185600a..eb36f8f77d55 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -528,11 +528,18 @@ static SUNXI_CCU_M_WITH_MUX_GATE(de_clk, "de", de_parents,
 				 0x104, 0, 4, 24, 3, BIT(31),
 				 CLK_SET_RATE_PARENT);
 
+/*
+ * DSI output seems to work only when PLL_MIPI selected. Set it and prevent
+ * the mux from reparenting.
+ */
+#define SUN50I_A64_TCON0_CLK_REG	0x118
+
 static const char * const tcon0_parents[] = { "pll-mipi", "pll-video0-2x" };
 static const u8 tcon0_table[] = { 0, 2, };
 static SUNXI_CCU_MUX_TABLE_WITH_GATE(tcon0_clk, "tcon0", tcon0_parents,
 				     tcon0_table, 0x118, 24, 3, BIT(31),
-				     CLK_SET_RATE_PARENT);
+				     CLK_SET_RATE_PARENT |
+				     CLK_SET_RATE_NO_REPARENT);
 
 static const char * const tcon1_parents[] = { "pll-video0", "pll-video1" };
 static const u8 tcon1_table[] = { 0, 2, };
@@ -953,6 +960,11 @@ static int sun50i_a64_ccu_probe(struct platform_device *pdev)
 
 	writel(0x515, reg + SUN50I_A64_PLL_MIPI_REG);
 
+	/* Set PLL MIPI as parent for TCON0 */
+	val = readl(reg + SUN50I_A64_TCON0_CLK_REG);
+	val &= ~GENMASK(26, 24);
+	writel(val | (0 << 24), reg + SUN50I_A64_TCON0_CLK_REG);
+
 	ret = devm_sunxi_ccu_probe(&pdev->dev, reg, &sun50i_a64_ccu_desc);
 	if (ret)
 		return ret;
-- 
2.32.0 (Apple Git-132)

