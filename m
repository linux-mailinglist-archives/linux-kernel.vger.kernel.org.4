Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5B07216EC
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjFDM1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFDM1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:27:22 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD049187;
        Sun,  4 Jun 2023 05:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685881627;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ItyejJVAd6OmifZFydELiYIvaMkIzY4VNO5Z5lE6lpY=;
        b=pCOt4FSLUZ9o/qBct4J+gDN7wJ1Clrg08+OKw1ufTb5i+korp0e/tiFSgeUtir2Eju5mfK
        G0BXuWpmI6FUqV3DKjLj9XZONbtSwNufnglQRub1jwspbt7uFkKmQJjUe6Y8FhygwgIphA
        oYBIVwxme48hxM6f3RNMYVcEWGHHmx0=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Paul Burton <paulburton@kernel.org>,
        Siarhei Volkau <lis8215@gmail.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, list@opendingux.net,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 3/4] mips: ingenic: Enable EXT/2 divider on JZ4750/55/60 if EXT is 24 MHz
Date:   Sun,  4 Jun 2023 14:26:54 +0200
Message-Id: <20230604122655.69698-3-paul@crapouillou.net>
In-Reply-To: <20230604122655.69698-1-paul@crapouillou.net>
References: <20230604122655.69698-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JZ4750, JZ4755 and JZ4760 (non-B version) support using a 24 MHz
external crystal oscillator instead of the typical 12 MHz one.

However, most of the SoC's IP blocks only work with a 12 MHz clock.
Thanksfully, there is a /2 divider we can enable when a 24 MHz external
crystal is present.

Force-enable this /2 divider when the oscillator is 24 MHz, so that the
SoC always uses a 12 MHz clock internally.

It is done here, and not in the clocks driver, because we need the EXT
clock to be 12 MHz for the early console to work, and the clocks driver
probes way too late.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 arch/mips/generic/board-ingenic.c | 57 +++++++++++++++++++++++++++++++
 1 file changed, 57 insertions(+)

diff --git a/arch/mips/generic/board-ingenic.c b/arch/mips/generic/board-ingenic.c
index 7a4fce06875d..1f4906875e7b 100644
--- a/arch/mips/generic/board-ingenic.c
+++ b/arch/mips/generic/board-ingenic.c
@@ -17,6 +17,7 @@
 #include <linux/types.h>
 
 #include <asm/bootinfo.h>
+#include <asm/io.h>
 #include <asm/machine.h>
 #include <asm/reboot.h>
 
@@ -60,6 +61,50 @@ static __init char *ingenic_get_system_type(unsigned long machtype)
 	}
 }
 
+#define INGENIC_CGU_BASE	0x10000000
+#define JZ4750_CGU_CPCCR_ECS	BIT(30)
+#define JZ4760_CGU_CPCCR_ECS	BIT(31)
+
+static __init void ingenic_force_12M_ext(const void *fdt, unsigned int mask)
+{
+	const __be32 *prop;
+	unsigned int cpccr;
+	void __iomem *cgu;
+	bool use_div;
+	int offset;
+
+	offset = fdt_path_offset(fdt, "/ext");
+	if (offset < 0)
+		return;
+
+	prop = fdt_getprop(fdt, offset, "clock-frequency", NULL);
+	if (!prop)
+		return;
+
+	/*
+	 * If the external oscillator is 24 MHz, enable the /2 divider to
+	 * drive it down to 12 MHz, since this is what the hardware can work
+	 * with.
+	 * The 16 MHz cutoff value is arbitrary; setting it to 12 MHz would not
+	 * work as the crystal frequency (as reported in the Device Tree) might
+	 * be slightly above this value.
+	 */
+	use_div = be32_to_cpup(prop) >= 16000000;
+
+	cgu = ioremap(INGENIC_CGU_BASE, 0x4);
+	if (!cgu)
+		return;
+
+	cpccr = ioread32(cgu);
+	if (use_div)
+		cpccr |= mask;
+	else
+		cpccr &= ~mask;
+	iowrite32(cpccr, cgu);
+
+	iounmap(cgu);
+}
+
 static __init const void *ingenic_fixup_fdt(const void *fdt, const void *match_data)
 {
 	/*
@@ -73,6 +118,18 @@ static __init const void *ingenic_fixup_fdt(const void *fdt, const void *match_d
 	mips_machtype = (unsigned long)match_data;
 	system_type = ingenic_get_system_type(mips_machtype);
 
+	switch (mips_machtype) {
+	case MACH_INGENIC_JZ4750:
+	case MACH_INGENIC_JZ4755:
+		ingenic_force_12M_ext(fdt, JZ4750_CGU_CPCCR_ECS);
+		break;
+	case MACH_INGENIC_JZ4760:
+		ingenic_force_12M_ext(fdt, JZ4760_CGU_CPCCR_ECS);
+		break;
+	default:
+		break;
+	}
+
 	return fdt;
 }
 
-- 
2.39.2

