Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED226C1B73
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbjCTQZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbjCTQZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:12 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682C51C59D;
        Mon, 20 Mar 2023 09:18:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso7864943wmq.5;
        Mon, 20 Mar 2023 09:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0hlvvdbeDEIm7xJGhHSHeJnLpm+LhG9OICPA4xVqkE=;
        b=ZjkeFXGjsRQIvdNHSzZ/3NcDXHbhoo+S8Q5qf5U40py94NAlqpdyKPS2+Az1tu+Zeq
         eVgI9w+8xyQyx3PGSjbvIrWQfkwASGyRiqJkNcHQQgal+iV2lEGW4RhTGwOCnyk/YqYJ
         xSwg//LklZ88Ud+sfW5cewgNGHII6PIVSP/1zzROOpsmmbce0XqhOS8x8/xTKj+vdRHg
         5dWyTFxgQGG4zlqxJaqhG8V9KkbU0TIrNs6iD9V0L7PsQ2ww8kGT+R0ZqV0fHVyN0mYR
         NAehuHsPaavvpQak+q4SwBhzSwTocIKmW43jQqqdNlFwQu5gzEG+N9eCvcCiQqn4mdZH
         N0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0hlvvdbeDEIm7xJGhHSHeJnLpm+LhG9OICPA4xVqkE=;
        b=t0+XFwqjyW5QXJljLp9vrP2Zy+2WvU/BEeZWCaWShlY9CnGOUp+B5kNl3ndFlZVNEI
         eaUG36uBI1uPdDI4McukgsHhqffua3xD1kZTeTJfyDBoZVOhrWjQQ4lqDlBslTwsPKuD
         pLs4u4nkBNEOWa1PCRbQTUx4A7ymTBOT83ZSWgywIf11qduZJDh2kUJB7/n5hris+rRN
         OyULu1Yn+40cLgHwL4s54b8BUfY8kKx+w5w8pCQZM0vH0P0T+US2i5OXW+7QmbR5SMpA
         cmXUG7Fx8V4/QLYZcolgTV9zUSqy7yTPMqe3J6DmyKKvJerTLlvN/eTViBR4mnT5n8gN
         g4qg==
X-Gm-Message-State: AO0yUKWw+yiLJrzFJDu5C4rwYXwekg64tAWfu+1+gjlwpLwjKTxqnlrF
        8EHwQHAEy13PjowCBzASDeDdFahVfY0=
X-Google-Smtp-Source: AK7set/2my2SqABVT0psW4NVRkXTVBSpP7tiBTtC3ZjXC8Gh3yQ5bC3nwkc7Jtwc5or5RIz2HMwxNA==
X-Received: by 2002:a7b:c5d4:0:b0:3ed:2606:d236 with SMTP id n20-20020a7bc5d4000000b003ed2606d236mr9232wmk.38.1679329115420;
        Mon, 20 Mar 2023 09:18:35 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm847776wmb.36.2023.03.20.09.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:18:35 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH 05/10] mips: ralink: rt3883: remove clock related code
Date:   Mon, 20 Mar 2023 17:18:18 +0100
Message-Id: <20230320161823.1424278-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A properly clock driver for ralink SoCs has been added. Hence there is no
need to have clock related code in 'arch/mips/ralink' folder anymore.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 arch/mips/include/asm/mach-ralink/rt3883.h |  8 ----
 arch/mips/ralink/rt3883.c                  | 44 ----------------------
 2 files changed, 52 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt3883.h b/arch/mips/include/asm/mach-ralink/rt3883.h
index ad25d5e8d2dc..4a835b178925 100644
--- a/arch/mips/include/asm/mach-ralink/rt3883.h
+++ b/arch/mips/include/asm/mach-ralink/rt3883.h
@@ -92,14 +92,6 @@
 #define RT3883_REVID_VER_ID_SHIFT	8
 #define RT3883_REVID_ECO_ID_MASK	0x0f
 
-#define RT3883_SYSCFG0_DRAM_TYPE_DDR2	BIT(17)
-#define RT3883_SYSCFG0_CPUCLK_SHIFT	8
-#define RT3883_SYSCFG0_CPUCLK_MASK	0x3
-#define RT3883_SYSCFG0_CPUCLK_250	0x0
-#define RT3883_SYSCFG0_CPUCLK_384	0x1
-#define RT3883_SYSCFG0_CPUCLK_480	0x2
-#define RT3883_SYSCFG0_CPUCLK_500	0x3
-
 #define RT3883_SYSCFG1_USB0_HOST_MODE	BIT(10)
 #define RT3883_SYSCFG1_PCIE_RC_MODE	BIT(8)
 #define RT3883_SYSCFG1_PCI_HOST_MODE	BIT(7)
diff --git a/arch/mips/ralink/rt3883.c b/arch/mips/ralink/rt3883.c
index cca887af378f..14c56993611a 100644
--- a/arch/mips/ralink/rt3883.c
+++ b/arch/mips/ralink/rt3883.c
@@ -21,50 +21,6 @@
 
 static struct ralink_soc_info *soc_info_ptr;
 
-void __init ralink_clk_init(void)
-{
-	unsigned long cpu_rate, sys_rate;
-	u32 syscfg0;
-	u32 clksel;
-	u32 ddr2;
-
-	syscfg0 = rt_sysc_r32(RT3883_SYSC_REG_SYSCFG0);
-	clksel = ((syscfg0 >> RT3883_SYSCFG0_CPUCLK_SHIFT) &
-		RT3883_SYSCFG0_CPUCLK_MASK);
-	ddr2 = syscfg0 & RT3883_SYSCFG0_DRAM_TYPE_DDR2;
-
-	switch (clksel) {
-	case RT3883_SYSCFG0_CPUCLK_250:
-		cpu_rate = 250000000;
-		sys_rate = (ddr2) ? 125000000 : 83000000;
-		break;
-	case RT3883_SYSCFG0_CPUCLK_384:
-		cpu_rate = 384000000;
-		sys_rate = (ddr2) ? 128000000 : 96000000;
-		break;
-	case RT3883_SYSCFG0_CPUCLK_480:
-		cpu_rate = 480000000;
-		sys_rate = (ddr2) ? 160000000 : 120000000;
-		break;
-	case RT3883_SYSCFG0_CPUCLK_500:
-		cpu_rate = 500000000;
-		sys_rate = (ddr2) ? 166000000 : 125000000;
-		break;
-	}
-
-	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("10000100.timer", sys_rate);
-	ralink_clk_add("10000120.watchdog", sys_rate);
-	ralink_clk_add("10000500.uart", 40000000);
-	ralink_clk_add("10000900.i2c", 40000000);
-	ralink_clk_add("10000a00.i2s", 40000000);
-	ralink_clk_add("10000b00.spi", sys_rate);
-	ralink_clk_add("10000b40.spi", sys_rate);
-	ralink_clk_add("10000c00.uartlite", 40000000);
-	ralink_clk_add("10100000.ethernet", sys_rate);
-	ralink_clk_add("10180000.wmac", 40000000);
-}
-
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,rt3883-sysc");
-- 
2.25.1

