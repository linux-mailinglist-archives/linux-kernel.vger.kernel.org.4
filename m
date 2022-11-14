Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3FC627C17
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236484AbiKNLTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiKNLRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:31 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6245585;
        Mon, 14 Nov 2022 03:15:35 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id A781C60015;
        Mon, 14 Nov 2022 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668424534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rv0zLQImLa4WkJ4GwDBS+qU7R6NBbI82C3pfv4/EYHA=;
        b=oRxEg/Pwf9nu/cfmv5rnPFTPBTNLajBKT1eMW6J6TI4BH2ENRLtc+cVN/RDq5eUDgPT2u/
        aNHw+ZpXRRunkrWCwiVLjjcF2xeKYsKFiSpg9Q6rXhs2pJmp4/ww2LrIyILkPJk7g9DbdE
        OK8OZRGP2EgfWlYaF0Hr7hS/68sG/WIA+uRUv08Ucn31S+2UPo5reLxfaf29pO9uziaJvJ
        33eVxqbUDNRZm34t3phTTgcNk2bJYiRs4UrIFCa2cFlpVKFXGCwSHNXEarM2jPrCbOSNkN
        byBLAsGOYRYqT87X34hO/xG6K2+WUByrdMsegqk7OPVwy4RGHLSq35djikkaUQ==
From:   Herve Codina <herve.codina@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>
Cc:     linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 3/7] soc: renesas: r9a06g032-sysctrl: Handle h2mode device-tree property
Date:   Mon, 14 Nov 2022 12:15:09 +0100
Message-Id: <20221114111513.1436165-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221114111513.1436165-1-herve.codina@bootlin.com>
References: <20221114111513.1436165-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle the h2mode property and forces the CFG_USB[H2MODE] bit
accordingly.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 9ee056498714..7a5a96c0d082 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -946,6 +946,7 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	struct clk *mclk;
 	unsigned int i;
 	u16 uart_group_sel[2];
+	u32 usb, h2mode;
 	int error;
 
 	clocks = devm_kzalloc(dev, sizeof(*clocks), GFP_KERNEL);
@@ -966,6 +967,26 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	clocks->reg = of_iomap(np, 0);
 	if (WARN_ON(!clocks->reg))
 		return -ENOMEM;
+
+	error = of_property_read_u32(np, "renesas,h2mode", &h2mode);
+	if (!error) {
+		usb = readl(clocks->reg + R9A06G032_SYSCTRL_USB);
+		switch (h2mode) {
+		case 0:
+			/* 1 host, 1 device */
+			usb &= ~R9A06G032_SYSCTRL_USB_H2MODE;
+			break;
+		case 1:
+			/* 2 hosts */
+			usb |= R9A06G032_SYSCTRL_USB_H2MODE;
+			break;
+		default:
+			dev_err(dev, "invalid h2mode %d\n", h2mode);
+			return -EINVAL;
+		}
+		writel(usb, clocks->reg + R9A06G032_SYSCTRL_USB);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(r9a06g032_clocks); ++i) {
 		const struct r9a06g032_clkdesc *d = &r9a06g032_clocks[i];
 		const char *parent_name = d->source ?
-- 
2.38.1

