Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC87691DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjBJLKU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:10:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjBJLKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:10:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4431B71018;
        Fri, 10 Feb 2023 03:10:12 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id rm7-20020a17090b3ec700b0022c05558d22so5167573pjb.5;
        Fri, 10 Feb 2023 03:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mg+Lezo/UluuzY/CQgV39sLNfOJ9ZHhdDTuSYUasXFg=;
        b=qOMjJN0yAoYucwzDuzlOK+CeG72O+1lswmk/pKjljUvpEcu4fyNh/+0n32iS98ijYP
         +ICIrd5uAwpJO8/RJxYJ8Y5Qy4pddCSlFdVtoBHERpQd63Paxz4+azDij7IYfGWZRUPr
         RSNuR+4MdT/IzZ3vsnyEKc+Vbo3O23WKzj//iCPMgCfOCibC2LWUYj83iWWujwNMkOiK
         afmO+fRbVk7mvEk/XH0q5lxNGqRntjXWVL/9A43lXGTOCLezAkAzVXPFvleETA5sJZXs
         8WS2NU2DJosR9IewVDJIPyAaPVoQJ2WGJJc5f4c1Z1g/M7+SsbGrwLGNz4W5u1brYbD+
         cz5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mg+Lezo/UluuzY/CQgV39sLNfOJ9ZHhdDTuSYUasXFg=;
        b=6nB9p2CQZqzy1CftuBNHeBMsOZNUCcYWM6oLIbqG076M9+7JBM6xwgGO6JDUvJUmMK
         vfE/2FLaxWk7Pxx45G07pOSpIZirHj1roDqFpWooVzCknOp8TB1otYw249muecEi2NMV
         SzPlrvgeMrqbiww53Uu6wRPXWi43qFhq5vcSvVQjeqJBSJqI+xh9jh6wP1glUYaUgxtR
         Fh/OIhyhNdoxiVWt3vmL8lRVtUwT3nozfCGLq1IXFZKbRlBzfLNUzZf03KnnE3+cR4/k
         zi8rED/LNibIjW5bIrfkGkqm+nzgwZZBda88LaJQ+MARA+GCPRxhw0F13VgTKSsUEuKb
         iong==
X-Gm-Message-State: AO0yUKUYtyPxRJaLV79SLYlY0LR9guifCFH4S55ba+IzWUKPN/Uxe12I
        djWN6AHuHrmfSyB6B6R057HNC2aszCUAbg==
X-Google-Smtp-Source: AK7set9eP40cF5oQ2gyuZ9lgHH7wj2QLFyKLxnKtg6E4Z8Er1idp0R8Rz36dM/eA3Y3z8LKKr2ufhg==
X-Received: by 2002:a17:902:e30a:b0:19a:6acc:1de2 with SMTP id q10-20020a170902e30a00b0019a6acc1de2mr2856106plc.35.1676027411453;
        Fri, 10 Feb 2023 03:10:11 -0800 (PST)
Received: from kelvin-ThinkPad-L14-Gen-1.. (ec2-18-163-35-77.ap-east-1.compute.amazonaws.com. [18.163.35.77])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b00198df32b41csm3152267plb.29.2023.02.10.03.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 03:10:10 -0800 (PST)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH] MIPS: loongson32: Drop obsolete cpufreq platform device
Date:   Fri, 10 Feb 2023 19:09:34 +0800
Message-Id: <20230210110934.1379482-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The obsolete cpufreq driver was removed, drop the platform device
and data accordingly.

Link: https://lore.kernel.org/all/20230112135342.3927338-1-keguang.zhang@gmail.com
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 .../mips/include/asm/mach-loongson32/cpufreq.h | 18 ------------------
 .../include/asm/mach-loongson32/platform.h     |  1 -
 arch/mips/loongson32/common/platform.c         | 16 ----------------
 arch/mips/loongson32/ls1b/board.c              |  1 -
 4 files changed, 36 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/cpufreq.h

diff --git a/arch/mips/include/asm/mach-loongson32/cpufreq.h b/arch/mips/include/asm/mach-loongson32/cpufreq.h
deleted file mode 100644
index e422a32883ae..000000000000
--- a/arch/mips/include/asm/mach-loongson32/cpufreq.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 CPUFreq platform support.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_CPUFREQ_H
-#define __ASM_MACH_LOONGSON32_CPUFREQ_H
-
-struct plat_ls1x_cpufreq {
-	const char	*clk_name;	/* CPU clk */
-	const char	*osc_clk_name;	/* OSC clk */
-	unsigned int	max_freq;	/* in kHz */
-	unsigned int	min_freq;	/* in kHz */
-};
-
-#endif /* __ASM_MACH_LOONGSON32_CPUFREQ_H */
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index e3fe93ba1bdb..2cdcfb5f6012 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -12,7 +12,6 @@
 #include <nand.h>
 
 extern struct platform_device ls1x_uart_pdev;
-extern struct platform_device ls1x_cpufreq_pdev;
 extern struct platform_device ls1x_eth0_pdev;
 extern struct platform_device ls1x_eth1_pdev;
 extern struct platform_device ls1x_ehci_pdev;
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 311dc1580bbd..64d7979394e6 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -15,7 +15,6 @@
 
 #include <platform.h>
 #include <loongson1.h>
-#include <cpufreq.h>
 #include <dma.h>
 #include <nand.h>
 
@@ -62,21 +61,6 @@ void __init ls1x_serial_set_uartclk(struct platform_device *pdev)
 		p->uartclk = clk_get_rate(clk);
 }
 
-/* CPUFreq */
-static struct plat_ls1x_cpufreq ls1x_cpufreq_pdata = {
-	.clk_name	= "cpu_clk",
-	.osc_clk_name	= "osc_clk",
-	.max_freq	= 266 * 1000,
-	.min_freq	= 33 * 1000,
-};
-
-struct platform_device ls1x_cpufreq_pdev = {
-	.name		= "ls1x-cpufreq",
-	.dev		= {
-		.platform_data = &ls1x_cpufreq_pdata,
-	},
-};
-
 /* Synopsys Ethernet GMAC */
 static struct stmmac_mdio_bus_data ls1x_mdio_bus_data = {
 	.phy_mask	= 0,
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index 727e06718dab..fed8d432ef20 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -35,7 +35,6 @@ static const struct gpio_led_platform_data ls1x_led_pdata __initconst = {
 
 static struct platform_device *ls1b_platform_devices[] __initdata = {
 	&ls1x_uart_pdev,
-	&ls1x_cpufreq_pdev,
 	&ls1x_eth0_pdev,
 	&ls1x_eth1_pdev,
 	&ls1x_ehci_pdev,

base-commit: 159c610af8cdf2b3c915e59162fc867b557cbe7e
prerequisite-patch-id: a73e24e76a88f519d85fdeb7230e93d53c61434a
-- 
2.34.1

