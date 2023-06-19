Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEFC8734AFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 06:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjFSEKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 00:10:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjFSEJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 00:09:53 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7B91BB;
        Sun, 18 Jun 2023 21:09:52 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f9b37cd548so577235e9.1;
        Sun, 18 Jun 2023 21:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687147791; x=1689739791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+0hlvvdbeDEIm7xJGhHSHeJnLpm+LhG9OICPA4xVqkE=;
        b=T6PnuXtvlmJ8X35VMQfsXXVgzjzF/wPB4uygOFjQCBZTgcEAwrYnIv/nVnJnBQV+/Y
         v2ErdExRM8yfjmU7d4aGadcO9t/Fl+ZvEbMDJz3Vi0/jC1jqUrm80MudeyvLCFo7D5NH
         l9SUKHQAX5TLeBpGlNWuJXMHLfM5AavehKjWF9Qx+Ym2xEhQcWoTUQNYIlAncFP/e3/n
         rq8ZJB04LletzT/PeUnp8F7xptzn0VN6k1r89uxoP1UHIkieWLNYHIzz8netnSqgkb/U
         GrnEDwf/MP3vZOtK0YW4cbWbYmuOy/w4S4IP2a/vEtTY8cEz3vnZV/W+pMxz5xO0z6l/
         OAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687147791; x=1689739791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+0hlvvdbeDEIm7xJGhHSHeJnLpm+LhG9OICPA4xVqkE=;
        b=WvwkPihWFXHW2U6BaAZOJ2fHIHX1kchaewHuGNfAJ7aH8HDg/BxnXF/r/us2QqR6Nz
         ov5F393AXYoy3iS9oa5hdy29RCywHUW+HnbO/qKFksg8j+Ye+2fokyzyY9hDlfrJ/PYF
         1BHuo4QbFOFuDk+rJT+OcWaDOBfVS6+EV+xdHqMMkmdT+RdMhBEVGohzsx2FR5yLPB44
         q0fSoZ+tYtGmB41k8Vk7yMd8B35nfS+Wuw8nFaSbgikFtfnL7gwtUvhsKb8gGpTYawY0
         FuhalSBNUHg7KSXvQREaQqLxcodw/nbBoiOkRJPjnlzVqVgzKc6mJRYJanSO7Fo3aUxc
         b/vA==
X-Gm-Message-State: AC+VfDy7bSOKF+o04dktND4lnXz9z2qeuaYcwkL3a7VJbryXaOauitaD
        AG3uU4nxbo82QcLNsgv9V1xaGViAOBQ=
X-Google-Smtp-Source: ACHHUZ583zA1is+LsC5m/Y8aXb9nA3jB77t2BDydPW8rPFQkjFdUVmdgJdEt5siL9eP5toVwfgpChw==
X-Received: by 2002:a5d:628d:0:b0:30a:f3f6:2712 with SMTP id k13-20020a5d628d000000b0030af3f62712mr7895148wru.60.1687147790778;
        Sun, 18 Jun 2023 21:09:50 -0700 (PDT)
Received: from localhost.localdomain (61.red-88-10-54.dynamicip.rima-tde.net. [88.10.54.61])
        by smtp.gmail.com with ESMTPSA id h14-20020a5d6e0e000000b003078354f774sm30004052wrz.36.2023.06.18.21.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 21:09:50 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        john@phrozen.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de, mturquette@baylibre.com, sboyd@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        arinc.unal@arinc9.com, yangshiji66@outlook.com
Subject: [PATCH v5 5/9] mips: ralink: rt3883: remove clock related code
Date:   Mon, 19 Jun 2023 06:09:37 +0200
Message-Id: <20230619040941.1340372-6-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
References: <20230619040941.1340372-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

