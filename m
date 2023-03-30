Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FD76D02FA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjC3LVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3LVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:21:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42DE449A;
        Thu, 30 Mar 2023 04:21:05 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l7so16910555pjg.5;
        Thu, 30 Mar 2023 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680175265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qPjPY4rOaOWxQnpPT7yX4J8p0DxvMIyZ19Ti3CrP8k=;
        b=Gasiho6ufA0o9VzpPzQe+TrZ455lvy7seyjfpT/NUjkVtNNlQ1ZNWxxziHbsOPOHmo
         Zi7nsNzSrsuTY0j7RIX58ajMmQDIb9UzrMAvcbEBjN0biMqeEhh7HN9eAjxIewrwad+L
         qlvQqLNgYDHhU7WrMWvz42RMnrAEPUEu6MByulFfhhDS24t0GaZM8o4KEo9Xx/GT7QtW
         inqiL/JXFL+jADh3W5ce20xeqLzH0RWY6R1VMBn1cVR2hYub5umw+/0XfJE2dI9OyFUY
         qo1f5P2K+wwC+pwaRKjgjc5d+0isfVtmzF6IMEyN9iEzT+5Jc8Cpwd83TZsqQzPkKFRs
         eOsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qPjPY4rOaOWxQnpPT7yX4J8p0DxvMIyZ19Ti3CrP8k=;
        b=suGly7g5TKGyaIbo6VMHTqQs9Aqt3jRieLY1JjuOdm/v3N1HqNUlEyXtXBrQ812I3e
         OCBOGOTKXDbRM5NAdargZsgheA5nmWAONeKDPj4NAWPSp5dV4o16qRCoZRk+NOd1/GTW
         Ux4qXRDPdN4v2qvS86AZukCBe/weU6MECNrAUsSlyP1h2WhagzMvR2bDsBHHD7hfKJbM
         7vPpNf7jQVKDxaWvbcgidnSFkgcTXWFVRfhQRiZrK01fvtqDyC/6swr7fsNwgobVgwvh
         K6fkZvcoBcAB2jvwY871hXGdsor/cxXJBqV+84605mHC2s3hFwvZxIOJDLunODk/F063
         nxlA==
X-Gm-Message-State: AAQBX9ec0qj7tyzM/odzCQ3BQCDxV1cLVkSHFjqKANuTNJxCRzbfqIYF
        BCiOMa31hq2V0rGsg3MwkGEqxtWjCMhIog==
X-Google-Smtp-Source: AKy350YgchrV5Du27KSVXfAc0YfE8zkjThtjpFHfLMjv53HgSDO9D949xZfLWl4NpVoJRYGjScA8tQ==
X-Received: by 2002:a17:902:e545:b0:1a1:bede:5e4a with SMTP id n5-20020a170902e54500b001a1bede5e4amr29179635plf.49.1680175264796;
        Thu, 30 Mar 2023 04:21:04 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902ee8d00b0019f11a68c42sm24444851pld.297.2023.03.30.04.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:21:04 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH v2 1/2] MIPS: Loongson32: Remove reset.c
Date:   Thu, 30 Mar 2023 19:20:50 +0800
Message-Id: <20230330112051.551648-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330112051.551648-1-keguang.zhang@gmail.com>
References: <20230330112051.551648-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Loongson-1 restart handler will be moved to watchdog driver,
then _machine_restart is no longer needed.
The _machine_halt and pm_power_off are also unnecessary,
which contain no hardware operations.

Therefore, remove the entire reset.c and related header file.
Update the Makefile accordingly.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
V1 -> V2: Remove the reference to regs-wdt.h
---
 .../include/asm/mach-loongson32/loongson1.h   |  1 -
 .../include/asm/mach-loongson32/regs-wdt.h    | 15 ------
 arch/mips/loongson32/common/Makefile          |  2 +-
 arch/mips/loongson32/common/reset.c           | 51 -------------------
 4 files changed, 1 insertion(+), 68 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
 delete mode 100644 arch/mips/loongson32/common/reset.c

diff --git a/arch/mips/include/asm/mach-loongson32/loongson1.h b/arch/mips/include/asm/mach-loongson32/loongson1.h
index eb3ddbec1752..50358f1a6181 100644
--- a/arch/mips/include/asm/mach-loongson32/loongson1.h
+++ b/arch/mips/include/asm/mach-loongson32/loongson1.h
@@ -49,6 +49,5 @@
 #include <regs-mux.h>
 #include <regs-pwm.h>
 #include <regs-rtc.h>
-#include <regs-wdt.h>
 
 #endif /* __ASM_MACH_LOONGSON32_LOONGSON1_H */
diff --git a/arch/mips/include/asm/mach-loongson32/regs-wdt.h b/arch/mips/include/asm/mach-loongson32/regs-wdt.h
deleted file mode 100644
index c6d345fe13f2..000000000000
--- a/arch/mips/include/asm/mach-loongson32/regs-wdt.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 Watchdog Register Definitions.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_REGS_WDT_H
-#define __ASM_MACH_LOONGSON32_REGS_WDT_H
-
-#define WDT_EN			0x0
-#define WDT_TIMER		0x4
-#define WDT_SET			0x8
-
-#endif /* __ASM_MACH_LOONGSON32_REGS_WDT_H */
diff --git a/arch/mips/loongson32/common/Makefile b/arch/mips/loongson32/common/Makefile
index 7b49c8260706..f3950d308187 100644
--- a/arch/mips/loongson32/common/Makefile
+++ b/arch/mips/loongson32/common/Makefile
@@ -3,4 +3,4 @@
 # Makefile for common code of loongson1 based machines.
 #
 
-obj-y	+= time.o irq.o platform.o prom.o reset.o setup.o
+obj-y	+= time.o irq.o platform.o prom.o setup.o
diff --git a/arch/mips/loongson32/common/reset.c b/arch/mips/loongson32/common/reset.c
deleted file mode 100644
index 0c7399b303fb..000000000000
--- a/arch/mips/loongson32/common/reset.c
+++ /dev/null
@@ -1,51 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/io.h>
-#include <linux/pm.h>
-#include <linux/sizes.h>
-#include <asm/idle.h>
-#include <asm/reboot.h>
-
-#include <loongson1.h>
-
-static void __iomem *wdt_reg_base;
-
-static void ls1x_halt(void)
-{
-	while (1) {
-		if (cpu_wait)
-			cpu_wait();
-	}
-}
-
-static void ls1x_restart(char *command)
-{
-	__raw_writel(0x1, wdt_reg_base + WDT_EN);
-	__raw_writel(0x1, wdt_reg_base + WDT_TIMER);
-	__raw_writel(0x1, wdt_reg_base + WDT_SET);
-
-	ls1x_halt();
-}
-
-static void ls1x_power_off(void)
-{
-	ls1x_halt();
-}
-
-static int __init ls1x_reboot_setup(void)
-{
-	wdt_reg_base = ioremap(LS1X_WDT_BASE, (SZ_4 + SZ_8));
-	if (!wdt_reg_base)
-		panic("Failed to remap watchdog registers");
-
-	_machine_restart = ls1x_restart;
-	_machine_halt = ls1x_halt;
-	pm_power_off = ls1x_power_off;
-
-	return 0;
-}
-
-arch_initcall(ls1x_reboot_setup);
-- 
2.34.1

