Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFA6C297F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCUFBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjCUFAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:00:54 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22481222FB;
        Mon, 20 Mar 2023 22:00:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id i10-20020a05600c354a00b003ee0da1132eso2119653wmq.4;
        Mon, 20 Mar 2023 22:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=MLPqUxiI0uWIUdugjRzr3dNrSneLqvgOAmhnwHmIDcfxdFr8x71ScAAzfMma8XymSd
         vBuxMULp0lzCfyIfdCUnXgpUws1bRC3Fy/7O4uUvPLsAZhVb/n/y7W6d4n45aGArkhfo
         JgJS9X4PIG5fH1LRKSzXjTqWm1l2bvypdgmqazNtehaUqbogBhfkB48S+nr90ROXolma
         Y5899PalaMlpKC4svnyl6vhDJPhu5+lzeFr4w65xCYJL2oEzeO/4p7nEvNyV/36WfC+Q
         /bmHUSdlJKVGpgAgQWGqTgyFAElBroNQkJm/R8t8niBx7tHxpFOkyU05MONNNfVuDmDP
         vmpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=E12C+IS7ZU2gE+TFk1CXkylT4ueDQf4EBIyksGCuE37XLlfZG9mbwaBQAt2dU6IRa3
         puIyGJIOviHtleoTVvnBQMcHZEtoydjsGFWvLsvQI5k21umcBxjk6qDvM/70CBtzZFFW
         fc9K4cbRthJdxWelAYdGH0CLCPwgeysJoEoF5ZGPgdyUyzKlr+SK1yWTjtyc1Vb1iX42
         zCZMU9e8aMSs2KErWqsVsMWMH8YtHiH5tZDg1VEaxdQQXFs7oMZm1f46HHfY8HnoOLio
         3PlfoDB7vBjcV4vY3QSHr7d6Zbkoe0hYClKi4x8mSATZ+pcD0lrJt7bwtIGNpQG7za8y
         vjHQ==
X-Gm-Message-State: AO0yUKViJd3F3g4ITEvD3o1ybnjoByqA5awefeufLYEPNZZN1ts5LnbA
        9HEY8TBh1Bp9GaDUvKhtkLIjDeSXq4U=
X-Google-Smtp-Source: AK7set83wAWAlxyTbfpQvY1H3WG+F+7sqcFny0owK40s5qZeVOCe8vckTgGqmcc0kjMDKu8RljCh4w==
X-Received: by 2002:a7b:c841:0:b0:3ee:392:3a00 with SMTP id c1-20020a7bc841000000b003ee03923a00mr1486183wml.16.1679374841344;
        Mon, 20 Mar 2023 22:00:41 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003eddefd8792sm6238432wmi.14.2023.03.20.22.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:00:40 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v2 3/9] mips: ralink: rt288x: remove clock related code
Date:   Tue, 21 Mar 2023 06:00:28 +0100
Message-Id: <20230321050034.1431379-4-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
References: <20230321050034.1431379-1-sergio.paracuellos@gmail.com>
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
 arch/mips/include/asm/mach-ralink/rt288x.h | 10 -------
 arch/mips/ralink/rt288x.c                  | 31 ----------------------
 2 files changed, 41 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt288x.h b/arch/mips/include/asm/mach-ralink/rt288x.h
index 66a999cd1d80..66d190358e3a 100644
--- a/arch/mips/include/asm/mach-ralink/rt288x.h
+++ b/arch/mips/include/asm/mach-ralink/rt288x.h
@@ -18,7 +18,6 @@
 #define SYSC_REG_CHIP_NAME1		0x04
 #define SYSC_REG_CHIP_ID		0x0c
 #define SYSC_REG_SYSTEM_CONFIG		0x10
-#define SYSC_REG_CLKCFG			0x30
 
 #define RT2880_CHIP_NAME0		0x38325452
 #define RT2880_CHIP_NAME1		0x20203038
@@ -27,15 +26,6 @@
 #define CHIP_ID_ID_SHIFT		8
 #define CHIP_ID_REV_MASK		0xff
 
-#define SYSTEM_CONFIG_CPUCLK_SHIFT	20
-#define SYSTEM_CONFIG_CPUCLK_MASK	0x3
-#define SYSTEM_CONFIG_CPUCLK_250	0x0
-#define SYSTEM_CONFIG_CPUCLK_266	0x1
-#define SYSTEM_CONFIG_CPUCLK_280	0x2
-#define SYSTEM_CONFIG_CPUCLK_300	0x3
-
-#define CLKCFG_SRAM_CS_N_WDT		BIT(9)
-
 #define RT2880_SDRAM_BASE		0x08000000
 #define RT2880_MEM_SIZE_MIN		2
 #define RT2880_MEM_SIZE_MAX		128
diff --git a/arch/mips/ralink/rt288x.c b/arch/mips/ralink/rt288x.c
index 456ba0b2599e..0c6a87452dd1 100644
--- a/arch/mips/ralink/rt288x.c
+++ b/arch/mips/ralink/rt288x.c
@@ -21,37 +21,6 @@
 
 static struct ralink_soc_info *soc_info_ptr;
 
-void __init ralink_clk_init(void)
-{
-	unsigned long cpu_rate, wmac_rate = 40000000;
-	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
-	t = ((t >> SYSTEM_CONFIG_CPUCLK_SHIFT) & SYSTEM_CONFIG_CPUCLK_MASK);
-
-	switch (t) {
-	case SYSTEM_CONFIG_CPUCLK_250:
-		cpu_rate = 250000000;
-		break;
-	case SYSTEM_CONFIG_CPUCLK_266:
-		cpu_rate = 266666667;
-		break;
-	case SYSTEM_CONFIG_CPUCLK_280:
-		cpu_rate = 280000000;
-		break;
-	case SYSTEM_CONFIG_CPUCLK_300:
-		cpu_rate = 300000000;
-		break;
-	}
-
-	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("300100.timer", cpu_rate / 2);
-	ralink_clk_add("300120.watchdog", cpu_rate / 2);
-	ralink_clk_add("300500.uart", cpu_rate / 2);
-	ralink_clk_add("300900.i2c", cpu_rate / 2);
-	ralink_clk_add("300c00.uartlite", cpu_rate / 2);
-	ralink_clk_add("400000.ethernet", cpu_rate / 2);
-	ralink_clk_add("480000.wmac", wmac_rate);
-}
-
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,rt2880-sysc");
-- 
2.25.1

