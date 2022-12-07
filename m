Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97C6645ECE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 17:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLGQZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 11:25:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiLGQZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 11:25:00 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B6266C96;
        Wed,  7 Dec 2022 08:24:56 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 8507840006;
        Wed,  7 Dec 2022 16:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670430295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHU0aD1tbBdA8rWIMWA9fVO3ryqaSawRTAzH+m73la0=;
        b=HDim3kUSIZzhrx35P/B82PmcbWhVElumWfFO2GVmRyvUjJK61FAyp9vVU9VeYIxHSLq4Zv
        0dJa+VF3gZ7vmh/j4A6OfjwAznqaZqAgYgUzlmdahgO7wNl+Nv59HDfKWgF93yHs8wEXI0
        qZs20lPadclrnVqzNtACyxir5UVDVZIjlxHBgfPotVwYgu+E9jfqpv+WtU7E1SaPLNh+7z
        5/TwZ/WUYhhn3vPgUU3kLFEFa0DybBDEkR4yfs5A16FpOI2WRjLdL8YmUdk5nwR8S3nc4O
        HCuX/nRzAXT7U6wolbjBRyW+H4LQZr4rD7KcWCCqIg42evLgA8+m7fruRc+2Vg==
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
Subject: [PATCH v3 6/9] soc: renesas: r9a06g032-sysctrl: Handle h2mode setting based on USBF presence
Date:   Wed,  7 Dec 2022 17:24:32 +0100
Message-Id: <20221207162435.1001782-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207162435.1001782-1-herve.codina@bootlin.com>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
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

The CFG_USB[H2MODE] allows to switch the USB configuration. The
configuration supported are:
  - One host and one device
or
  - Two hosts

Set CFG_USB[H2MODE] based on the USBF controller (USB device)
availability.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
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

