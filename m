Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53396C1B76
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjCTQ0D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbjCTQZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:25:13 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A22EB57;
        Mon, 20 Mar 2023 09:18:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id p34so2879646wms.3;
        Mon, 20 Mar 2023 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679329112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=CPl//VH6ANqTFiUSxKiBevR2ZXdKb3Q/YYQiZRnepSo26fkEx/1OTMxfdlU4XawKDd
         Qr/pvGqSxNumjXltk0Gp5pB21SuGQgWEIc/JhWWTQvp75uLK6wO6Ug9DEaqgrczp4Ab3
         0zvyaYYJyiWbW+FtUa8iTjEZPnFzyZZTMw1W4jm2YpBojGa6H9s6xCzWtpcxdbOXXitw
         kLvi1I34Jr4H6Xn+R+n4H+jzUhc1P9G2QZ+Hw7E9h8B5fc/wB5BACHnJn1/x2zz2Kh9Q
         HOXDwhem9Tb/GMHazu/3ydgvIa2dWFqh0o4S10APWpljHsl8L8Al164bVs0Qig/JKk5J
         YHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n/vu+BfaX9/nXtP9I6CrmyWiA7s/9ryNRPNRydMSfbw=;
        b=AOJkUn1VywYB+OAAYiBDq8Ns87bn3RBxPDs1D7r+yyR2FVjC55qOgk76odPKxjjOFr
         GlgR9vZb9cr3zTg3vh9HNl0k8l7YWQv/bROEcC4yZpTmFh8UWFwFuMZT1Kzpm6bpvyhU
         1sggWKBhPf6NbNX6GrSV8xTI1WmKnN0SLIwnGjeSPf7m3NAX/RFeeUYwmW3rdg7NBCqg
         k2jODGLuUllauKNvBfb65FeaGAc/4++ao+ZmH8NmLqY3wnll7WH4XdHMCSV4mhhSd8X0
         GR1a31l6eHNK5LaLnz6gyhJ2m2goxXAThE8NNMBNm4EnltJbhoD2lW7bgxnrNj4RYl7o
         AgZg==
X-Gm-Message-State: AO0yUKXGYU7Lp85kHqUiAXdYtFUVtx06mso6pgpW0U1d4HzSGHi9gUki
        YTO4HIuc4fLdrfORoCLsxAMBLL/4IG0=
X-Google-Smtp-Source: AK7set/7xX5IVEvQF2ZRUFL6RmDaw30sVS3I+jEnTQ/ZoMaabwmMI7xaT8Oo96xfDvij20r2qBSf/A==
X-Received: by 2002:a1c:7910:0:b0:3ed:2105:9abc with SMTP id l16-20020a1c7910000000b003ed21059abcmr70221wme.14.1679329111682;
        Mon, 20 Mar 2023 09:18:31 -0700 (PDT)
Received: from localhost.localdomain (106.red-88-13-29.dynamicip.rima-tde.net. [88.13.29.106])
        by smtp.gmail.com with ESMTPSA id iv16-20020a05600c549000b003ee1acdaf95sm847776wmb.36.2023.03.20.09.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 09:18:31 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com
Subject: [PATCH 03/10] mips: ralink: rt288x: remove clock related code
Date:   Mon, 20 Mar 2023 17:18:16 +0100
Message-Id: <20230320161823.1424278-4-sergio.paracuellos@gmail.com>
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

