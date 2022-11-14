Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F448627C11
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234803AbiKNLSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:18:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236966AbiKNLR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:17:27 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9E321E15;
        Mon, 14 Nov 2022 03:15:28 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPA id 79CDA60010;
        Mon, 14 Nov 2022 11:15:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1668424527;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9cWUMqDjvAHZdUQxoiw0zECZSqsjwWcZqSuQI2RSbWA=;
        b=ZybhulNlYT1pNvqmEey2XL1wO+TYkEWwGd+yGtJuqzYNp79OeRp7b9Plcn1uLKsv+cEsqW
        IGb0QgNytpqoA3fJ9buEWJkQLTaxooraYKXIlHyDSHKaxgGiDGTAsQ7N6phHBwOG54bJgS
        c7MTZUZ2+sw1OVr/cueK8OsKzWJb3B4ZsgqjOndC7iM8+IADPL+1sQpJmNKIpGOQ1zNqXB
        VFljSe76rWgPjja+giwJJJCLa/zwwJWoQV4+amHSXRXWnr/YGicLahr7Rl9QmmnxVwETSo
        Gc9SRryQbHsFEJUH+9y2m9hvgipmz6l9YTmSKTgRIjdEjwjXDaFPQ5WrvtSMkg==
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
Subject: [PATCH v2 1/7] soc: renesas: r9a06g032-sysctrl: Export function to get the usb role
Date:   Mon, 14 Nov 2022 12:15:07 +0100
Message-Id: <20221114111513.1436165-2-herve.codina@bootlin.com>
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

The usb role retrieved is determined from the CFG_USB[H2MODE]
value. The CFG_USB register is located within the system
controller.

We need a helper to get the usb role based on H2MODE value from
the CFG_USB register without syscon.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 drivers/clk/renesas/r9a06g032-clocks.c        | 18 ++++++++++++++++++
 include/linux/soc/renesas/r9a06g032-sysctrl.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/drivers/clk/renesas/r9a06g032-clocks.c b/drivers/clk/renesas/r9a06g032-clocks.c
index 1488c9d6e639..9ee056498714 100644
--- a/drivers/clk/renesas/r9a06g032-clocks.c
+++ b/drivers/clk/renesas/r9a06g032-clocks.c
@@ -23,8 +23,11 @@
 #include <linux/slab.h>
 #include <linux/soc/renesas/r9a06g032-sysctrl.h>
 #include <linux/spinlock.h>
+#include <linux/usb/role.h>
 #include <dt-bindings/clock/r9a06g032-sysctrl.h>
 
+#define R9A06G032_SYSCTRL_USB    0x00
+#define R9A06G032_SYSCTRL_USB_H2MODE  (1<<1)
 #define R9A06G032_SYSCTRL_DMAMUX 0xA0
 
 struct r9a06g032_gate {
@@ -341,6 +344,21 @@ int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val)
 }
 EXPORT_SYMBOL_GPL(r9a06g032_sysctrl_set_dmamux);
 
+
+/* Exported helper to get the H2MODE bit from USB register */
+int r9a06g032_sysctrl_get_usb_role(void)
+{
+	u32 usb;
+
+	if (!sysctrl_priv)
+		return -EPROBE_DEFER;
+
+	usb = readl(sysctrl_priv->reg + R9A06G032_SYSCTRL_USB);
+	return (usb & R9A06G032_SYSCTRL_USB_H2MODE) ?
+		USB_ROLE_HOST : USB_ROLE_DEVICE;
+}
+EXPORT_SYMBOL_GPL(r9a06g032_sysctrl_get_usb_role);
+
 /* register/bit pairs are encoded as an uint16_t */
 static void
 clk_rdesc_set(struct r9a06g032_priv *clocks,
diff --git a/include/linux/soc/renesas/r9a06g032-sysctrl.h b/include/linux/soc/renesas/r9a06g032-sysctrl.h
index 066dfb15cbdd..fc18d013a498 100644
--- a/include/linux/soc/renesas/r9a06g032-sysctrl.h
+++ b/include/linux/soc/renesas/r9a06g032-sysctrl.h
@@ -4,8 +4,10 @@
 
 #ifdef CONFIG_CLK_R9A06G032
 int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val);
+int r9a06g032_sysctrl_get_usb_role(void);
 #else
 static inline int r9a06g032_sysctrl_set_dmamux(u32 mask, u32 val) { return -ENODEV; }
+static inline int r9a06g032_sysctrl_get_usb_role(void) { return -ENODEV; }
 #endif
 
 #endif /* __LINUX_SOC_RENESAS_R9A06G032_SYSCTRL_H__ */
-- 
2.38.1

