Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D702A6C296B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 06:01:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjCUFBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 01:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjCUFAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 01:00:54 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D5922C92;
        Mon, 20 Mar 2023 22:00:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id w11so7721614wmo.2;
        Mon, 20 Mar 2023 22:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679374842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAgPAF+zjeuI/E9IUlDFcsX7pn0c4FT4mD/fF6VQFeU=;
        b=H5BQH52gxlOxex7Y4rkPSbwY5RYn4+4utbWHsJ6JshrbtjbUxNOAPT4Bbe6+DdouQt
         Um/aoqBOdcsmCsxddYMuMXVCLkV7Sl0ojbmwwmFjYV0sPW4K+3dE4rAe8CERrB32z0x1
         nf+W4aLDxPBvTbOi6q+h3VYQCb9xlsRzYRCQd4Pjpncdk2Sra4nr7Vd8Z2NRMTlDLgS7
         H/0Egls/HYTb5VHeKrt0Yb5CfQMJbLUnxUCAmFDdRDmEwi/ZXmLcE7sVUcW+Sb2lhziZ
         99mwMazK+M96Ebb3PznihVlLhBxzjUS71jdYzkF6kwn98FfBbEyg70ZFyMKC7NFFUUTg
         Du9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679374842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAgPAF+zjeuI/E9IUlDFcsX7pn0c4FT4mD/fF6VQFeU=;
        b=lueVCwo2lCE0OaMeSdJR+muUI1OeVsI8+78YBX8eIKEzo213ZSWU7CxBXQOCn5PWCC
         nErfzZ9LPSo5vAoo2/JOEp6bqldFyE85XNYe4urA+BAsvq4fvAkSHZjVFh89rgOFxqw1
         GHMv+TF1KQ447quRdjwRKnsm58JAK6uFIQvlgiGRQ4iSOzRYB8d5ghHcHbiwl96n39pT
         cCjIOnPcygulzmJIFVGAfLupn5apPoud5ZQakHGEh6cEZHYfqXffXBqPBNiVRN/8jCzh
         cvnhlDohz5f6dgtbq6qhV6KVxeHApGLK2aoZSLXdHAQhwdqvyolIqq85tOxL7BcrTMLl
         jXEw==
X-Gm-Message-State: AO0yUKXt8x1H7SgBm2xOzut5FWSXEAE3kB3JR9MwxqiWi93boRTJ6d2t
        omOn9juWdPPMcDf7v+cXUWj+6f9xIlM=
X-Google-Smtp-Source: AK7set+qxd2EA9t88qvZhoSP1ihBo1ui9U2AALkpgXOrmGkMvDa4kY+pd1SCylzWZFxPaowIhAA2bA==
X-Received: by 2002:a05:600c:3649:b0:3ea:f6c4:5f3d with SMTP id y9-20020a05600c364900b003eaf6c45f3dmr1337119wmq.2.1679374842548;
        Mon, 20 Mar 2023 22:00:42 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c020300b003eddefd8792sm6238432wmi.14.2023.03.20.22.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 22:00:42 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH v2 4/9] mips: ralink: rt305x: remove clock related code
Date:   Tue, 21 Mar 2023 06:00:29 +0100
Message-Id: <20230321050034.1431379-5-sergio.paracuellos@gmail.com>
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
 arch/mips/include/asm/mach-ralink/rt305x.h | 21 ------
 arch/mips/ralink/rt305x.c                  | 78 ----------------------
 2 files changed, 99 deletions(-)

diff --git a/arch/mips/include/asm/mach-ralink/rt305x.h b/arch/mips/include/asm/mach-ralink/rt305x.h
index ef58f7bff957..4fc5c279cd75 100644
--- a/arch/mips/include/asm/mach-ralink/rt305x.h
+++ b/arch/mips/include/asm/mach-ralink/rt305x.h
@@ -67,26 +67,9 @@ static inline int soc_is_rt5350(void)
 #define CHIP_ID_ID_SHIFT		8
 #define CHIP_ID_REV_MASK		0xff
 
-#define RT305X_SYSCFG_CPUCLK_SHIFT		18
-#define RT305X_SYSCFG_CPUCLK_MASK		0x1
-#define RT305X_SYSCFG_CPUCLK_LOW		0x0
-#define RT305X_SYSCFG_CPUCLK_HIGH		0x1
-
 #define RT305X_SYSCFG_SRAM_CS0_MODE_SHIFT	2
-#define RT305X_SYSCFG_CPUCLK_MASK		0x1
 #define RT305X_SYSCFG_SRAM_CS0_MODE_WDT		0x1
 
-#define RT3352_SYSCFG0_CPUCLK_SHIFT	8
-#define RT3352_SYSCFG0_CPUCLK_MASK	0x1
-#define RT3352_SYSCFG0_CPUCLK_LOW	0x0
-#define RT3352_SYSCFG0_CPUCLK_HIGH	0x1
-
-#define RT5350_SYSCFG0_CPUCLK_SHIFT	8
-#define RT5350_SYSCFG0_CPUCLK_MASK	0x3
-#define RT5350_SYSCFG0_CPUCLK_360	0x0
-#define RT5350_SYSCFG0_CPUCLK_320	0x2
-#define RT5350_SYSCFG0_CPUCLK_300	0x3
-
 #define RT5350_SYSCFG0_DRAM_SIZE_SHIFT  12
 #define RT5350_SYSCFG0_DRAM_SIZE_MASK   7
 #define RT5350_SYSCFG0_DRAM_SIZE_2M     0
@@ -117,13 +100,9 @@ static inline int soc_is_rt5350(void)
 
 #define RT3352_SYSC_REG_SYSCFG0		0x010
 #define RT3352_SYSC_REG_SYSCFG1         0x014
-#define RT3352_SYSC_REG_CLKCFG1         0x030
 #define RT3352_SYSC_REG_RSTCTRL         0x034
 #define RT3352_SYSC_REG_USB_PS          0x05c
 
-#define RT3352_CLKCFG0_XTAL_SEL		BIT(20)
-#define RT3352_CLKCFG1_UPHY0_CLK_EN	BIT(18)
-#define RT3352_CLKCFG1_UPHY1_CLK_EN	BIT(20)
 #define RT3352_RSTCTRL_UHST		BIT(22)
 #define RT3352_RSTCTRL_UDEV		BIT(25)
 #define RT3352_SYSCFG1_USB0_HOST_MODE	BIT(10)
diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
index d8dcc5cc66cc..9cffe69dd11d 100644
--- a/arch/mips/ralink/rt305x.c
+++ b/arch/mips/ralink/rt305x.c
@@ -56,84 +56,6 @@ static unsigned long rt5350_get_mem_size(void)
 	return ret;
 }
 
-void __init ralink_clk_init(void)
-{
-	unsigned long cpu_rate, sys_rate, wdt_rate, uart_rate;
-	unsigned long wmac_rate = 40000000;
-
-	u32 t = rt_sysc_r32(SYSC_REG_SYSTEM_CONFIG);
-
-	if (soc_is_rt305x() || soc_is_rt3350()) {
-		t = (t >> RT305X_SYSCFG_CPUCLK_SHIFT) &
-		     RT305X_SYSCFG_CPUCLK_MASK;
-		switch (t) {
-		case RT305X_SYSCFG_CPUCLK_LOW:
-			cpu_rate = 320000000;
-			break;
-		case RT305X_SYSCFG_CPUCLK_HIGH:
-			cpu_rate = 384000000;
-			break;
-		}
-		sys_rate = uart_rate = wdt_rate = cpu_rate / 3;
-	} else if (soc_is_rt3352()) {
-		t = (t >> RT3352_SYSCFG0_CPUCLK_SHIFT) &
-		     RT3352_SYSCFG0_CPUCLK_MASK;
-		switch (t) {
-		case RT3352_SYSCFG0_CPUCLK_LOW:
-			cpu_rate = 384000000;
-			break;
-		case RT3352_SYSCFG0_CPUCLK_HIGH:
-			cpu_rate = 400000000;
-			break;
-		}
-		sys_rate = wdt_rate = cpu_rate / 3;
-		uart_rate = 40000000;
-	} else if (soc_is_rt5350()) {
-		t = (t >> RT5350_SYSCFG0_CPUCLK_SHIFT) &
-		     RT5350_SYSCFG0_CPUCLK_MASK;
-		switch (t) {
-		case RT5350_SYSCFG0_CPUCLK_360:
-			cpu_rate = 360000000;
-			sys_rate = cpu_rate / 3;
-			break;
-		case RT5350_SYSCFG0_CPUCLK_320:
-			cpu_rate = 320000000;
-			sys_rate = cpu_rate / 4;
-			break;
-		case RT5350_SYSCFG0_CPUCLK_300:
-			cpu_rate = 300000000;
-			sys_rate = cpu_rate / 3;
-			break;
-		default:
-			BUG();
-		}
-		uart_rate = 40000000;
-		wdt_rate = sys_rate;
-	} else {
-		BUG();
-	}
-
-	if (soc_is_rt3352() || soc_is_rt5350()) {
-		u32 val = rt_sysc_r32(RT3352_SYSC_REG_SYSCFG0);
-
-		if (!(val & RT3352_CLKCFG0_XTAL_SEL))
-			wmac_rate = 20000000;
-	}
-
-	ralink_clk_add("cpu", cpu_rate);
-	ralink_clk_add("sys", sys_rate);
-	ralink_clk_add("10000900.i2c", uart_rate);
-	ralink_clk_add("10000a00.i2s", uart_rate);
-	ralink_clk_add("10000b00.spi", sys_rate);
-	ralink_clk_add("10000b40.spi", sys_rate);
-	ralink_clk_add("10000100.timer", wdt_rate);
-	ralink_clk_add("10000120.watchdog", wdt_rate);
-	ralink_clk_add("10000500.uart", uart_rate);
-	ralink_clk_add("10000c00.uartlite", uart_rate);
-	ralink_clk_add("10100000.ethernet", sys_rate);
-	ralink_clk_add("10180000.wmac", wmac_rate);
-}
-
 void __init ralink_of_remap(void)
 {
 	rt_sysc_membase = plat_of_remap_node("ralink,rt3050-sysc");
-- 
2.25.1

