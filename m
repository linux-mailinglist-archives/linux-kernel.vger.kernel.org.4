Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A164B646
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 14:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235615AbiLMNdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 08:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235241AbiLMNdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 08:33:22 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA4F6193EF;
        Tue, 13 Dec 2022 05:33:19 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 3B7CB4000D;
        Tue, 13 Dec 2022 13:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670938398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kfby1OwZl0OHnCM18YaCKMdt/L5z3K6H9OIAZWHFNTI=;
        b=idiGN2Jdl53oA8HQx1F1ah9iJKvUUMaxsJ2p6PFmp2zkKNFM0bNuC9UyiM7IBEEWm36tZV
        8R9OgwC1PZp9CDl1kHXkFGj1xQY4059tP/OFDxFKxQKXPVv9jMppaIPleRX5L/4lEYpouL
        FcXEHGtCIW8wGDCtEF1zt64cCCjh0d2drWP0jxwXhMLNT1kmJ6EbxBwYovez/eDz78U2Nx
        J5P4EFR5HDcDXe5eD9UkOiYw5+EIoyXk2CEabqO7mH06v43EEJIJRJURH9t7EATb0qhS8h
        uoQ8B9XGFQg21Z7YehJXf6HFTYJvdkr0EkDaEHEnI7s2ExOnRrgSZoRuVnc3qA==
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
Subject: [PATCH v4 2/5] soc: renesas: r9a06g032-sysctrl: Handle h2mode setting based on USBF presence
Date:   Tue, 13 Dec 2022 14:32:59 +0100
Message-Id: <20221213133302.218955-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221213133302.218955-1-herve.codina@bootlin.com>
References: <20221213133302.218955-1-herve.codina@bootlin.com>
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

The CFG_USB[H2MODE] allows to switch the USB configuration. The
configuration supported are:
  - One host and one device
or
  - Two hosts

Set CFG_USB[H2MODE] based on the USBF controller (USB device)
availability.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/renesas/r9a06g032-clocks.c | 28 ++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 1488c9d6e639..8a09ba79b97f 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -25,6 +25,8 @@
 #include <linux/spinlock.h>
 #include <dt-bindings/clock/r9a06g032-sysctrl.h>
 
+#define R9A06G032_SYSCTRL_USB    0x00
+#define R9A06G032_SYSCTRL_USB_H2MODE  (1<<1)
 #define R9A06G032_SYSCTRL_DMAMUX 0xA0
 
 struct r9a06g032_gate {
@@ -919,6 +921,29 @@ static void r9a06g032_clocks_del_clk_provider(void *data)
 	of_clk_del_provider(data);
 }
 
+static void __init r9a06g032_init_h2mode(struct r9a06g032_priv *clocks)
+{
+	struct device_node *usbf_np = NULL;
+	u32 usb;
+
+	while ((usbf_np = of_find_compatible_node(usbf_np, NULL,
+						  "renesas,rzn1-usbf"))) {
+		if (of_device_is_available(usbf_np))
+			break;
+	}
+
+	usb = readl(clocks->reg + R9A06G032_SYSCTRL_USB);
+	if (usbf_np) {
+		/* 1 host and 1 device mode */
+		usb &= ~R9A06G032_SYSCTRL_USB_H2MODE;
+		of_node_put(usbf_np);
+	} else {
+		/* 2 hosts mode */
+		usb |= R9A06G032_SYSCTRL_USB_H2MODE;
+	}
+	writel(usb, clocks->reg + R9A06G032_SYSCTRL_USB);
+}
+
 static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -948,6 +973,9 @@ static int __init r9a06g032_clocks_probe(struct platform_device *pdev)
 	clocks->reg = of_iomap(np, 0);
 	if (WARN_ON(!clocks->reg))
 		return -ENOMEM;
+
+	r9a06g032_init_h2mode(clocks);
+
 	for (i = 0; i < ARRAY_SIZE(r9a06g032_clocks); ++i) {
 		const struct r9a06g032_clkdesc *d = &r9a06g032_clocks[i];
 		const char *parent_name = d->source ?
-- 
2.38.1

