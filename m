Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC24161F4D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 15:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbiKGOAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 09:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiKGN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:59:59 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD01B1E;
        Mon,  7 Nov 2022 05:59:57 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 5077340014;
        Mon,  7 Nov 2022 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667829596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YKoaAUgQsPPuJwz9X1D+0C6IS4Z6KPB6+tN/gbl8R74=;
        b=X7yGRTRfOv99RzqCWD0z75L907GGwaEL0pl/yBFaaJFBkBW7hxUDPdqZfkzYld4E6wTLpl
        Iw9rwkgI9Yj79dJGAqWNihgIXzfqTDbt0UXmop5QshNd4U4s2HCp4PwfwcAFaaIpkdjqlP
        9wZHIGliMI3Aw5aRmbt82b3uYsXg9GjeAJbnl0i/UzzjvFQ4/TpZInwWFUwc+rMlaT8HsY
        RyT9bLsniJjhqUhyIknszB2k1AR3aQ1IriR9b9m0MBhCaQ8zTRKprae7ylQFTH3CWPKgZi
        g+kb6fld1f8IgpgDJOiqxcwxTNAKwcDOj3Dq+EB+A8C1D8c6hMFDJliUdasFdw==
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
Subject: [PATCH 3/7] soc: renesas: r9a06g032-sysctrl: Handle h2mode device-tree property
Date:   Mon,  7 Nov 2022 14:58:21 +0100
Message-Id: <20221107135825.583877-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107135825.583877-1-herve.codina@bootlin.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index c07131c47a9f..562c2aba910b 100644
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
2.37.3

