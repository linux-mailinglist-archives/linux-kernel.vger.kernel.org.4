Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521F61F4CD
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiKGN7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiKGN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:59:49 -0500
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADBF0323;
        Mon,  7 Nov 2022 05:59:47 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id D8C0F4000E;
        Mon,  7 Nov 2022 13:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667829586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/XeTPzP6Y4Gj/XYPtWuOUx4qjJonbX3OpxaDrJOsO+A=;
        b=dTtruHqgtHo0yJwdj/3+/6gCE5AcGDWgU2GOXru8I0N+fjzQgeb+YRyrzU77vhyr5SXuos
        TOhievX5VWnLOXY4rWR2RIM5WNb+tw0nFVHuix5epDgypJhkX9LKkn0Xh/Rz4AtjqQRr9W
        EZ/ik5F+HcfdN9XuHb2yXynjCAm6NCHP4tn6Mh51JqvKQkxWPtmhdN4nnvYEyQRgW6pNS7
        0LMtC2uoshsDrefWXK17HXaBY0Epw9PedkeT9aBQTuuEFljufc3Pi0rshqBKXGhv9Q5Tm6
        f0JzH8WGNuNXtRtNkOXbqbE9IaXMWbjE5H413nAxeP7HP1QqYa8g8SgYlMRjdw==
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
Subject: [PATCH 1/7] soc: renesas: r9a06g032-sysctrl: Export function to get H2MODE from CFG_USB register
Date:   Mon,  7 Nov 2022 14:58:19 +0100
Message-Id: <20221107135825.583877-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107135825.583877-1-herve.codina@bootlin.com>
References: <20221107135825.583877-1-herve.codina@bootlin.com>
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

The CFG_USB register is located within the system controller.

We need a helper to get the H2MODE value from the CFG_USB register
without syscon.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c        | 18 ++++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 1488c9d6e639..c07131c47a9f 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -25,6 +25,8 @@
 #include <linux/spinlock.h>
 #include <dt-bindings/clock/r9a06g032-sysctrl.h>
 
+#define R9A06G032_SYSCTRL_USB    0x00
+#define R9A06G032_SYSCTRL_USB_H2MODE  (1<<1)
 #define R9A06G032_SYSCTRL_DMAMUX 0xA0
 
 struct r9a06g032_gate {
@@ -341,6 +343,22 @@ int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val)
 }
 EXPORT_SYMBOL_GPL(r9a06g032_sysctrl_set_dmamux);
 
+
+/* Exported helper to get the H2MODE bit from USB register */
+int r9a06g032_sysctrl_get_usb_h2mode(bool *h2mode)
+{
+	u32 usb;
+
+	if (!sysctrl_priv)
+		return -EPROBE_DEFER;
+
+	usb = readl(sysctrl_priv->reg + R9A06G032_SYSCTRL_USB);
+	*h2mode = (usb & R9A06G032_SYSCTRL_USB_H2MODE) ? true : false;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(r9a06g032_sysctrl_get_usb_h2mode);
+
 /* register/bit pairs are encoded as an uint16_t */
 static void
 clk_rdesc_set(struct r9a06g032_priv *clocks,
diff --git a/include/linux/soc/renesas/r9a06g032-sysctrl.h b/include/linux/soc/renesas/r9a06g032-sysctrl.h
index 066dfb15cbdd..095e00f27309 100644
--- a/include/linux/soc/renesas/r9a06g032-sysctrl.h
+++ b/include/linux/soc/renesas/r9a06g032-sysctrl.h
@@ -4,8 +4,10 @@
 
 #ifdef CONFIG_CLK_R9A06G032
 int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val);
+int r9a06g032_sysctrl_get_usb_h2mode(bool *h2mode);
 #else
 static inline int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val) { return -ENODEV; }
+static inline int r9a06g032_sysctrl_get_usb_h2mode(bool *h2mode) { return -ENODEV; }
 #endif
 
 #endif /* __LINUX_SOC_RENESAS_R9A06G032_SYSCTRL_H__ */
-- 
2.37.3

