Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95826D0106
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjC3KUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjC3KUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:20:30 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D794883DC;
        Thu, 30 Mar 2023 03:20:27 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so21445940pjp.1;
        Thu, 30 Mar 2023 03:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680171627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFmD8juz64pz2Fx6Di+zQy61w/UCoeWm05OPcNPURFQ=;
        b=J+a0NK1uj2q9AMXEBlejl6GbxZzT9Zw3M49iZrHJvCD8cv5qHsrPgq2MtpFQAKOgIk
         BwzcuvUM50SlDeTtsVWdNO0wK+T/rFnZkwhUsu4kO6LVAFsAlXL7lR1jEPag1pCplEIT
         SO/u5R7S6jMdL1XixOCzkX03cLlQl9yOgYQhJ67lbiWiGEWq1XwtJg9Rw82v1qZKHdT4
         3gYKzVtBESiJ3wm8BiUKoYxkZDM0sgW9xnCyDbUev5/OOez/EdoRM83destY7rgs8Tgd
         KeAmYK7AfwXblSDcIOGrr6ufIZ+/eFERjK/oMNCry/Kj9JRRJHj4r8KKC6QVE6jBJuwb
         qXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFmD8juz64pz2Fx6Di+zQy61w/UCoeWm05OPcNPURFQ=;
        b=eIaokoVJBcsF40FT+i/CgV2Xfdu7nqFbC+nK16BhvhIdnXvVBD9g9NlmyoJfSx471t
         Gx+GAjnqQMaTjnh6K+b0rnGoBGnFEDuBHu5aBfm2rgVB/Zznahz7bnNrGz0vxXd8wtrm
         uhPaeFoTd2xzJhl8BR1XWHIy/VK632vqB7rd4gks7NUEE/7cYwF5USgaxnz70XahR2AI
         OyLl4fFKiJQWviUZfMD2e+PzH42fUrOApC8qPHnmu0XHBx96rZvA6jEkDKJ+hI+friQc
         nSa7W78ygnuyWcJUewI75qq4f687KmcSc+GiyTs8TaS06GSXtzqf0HD9w1ykVwPBwGi+
         cQjA==
X-Gm-Message-State: AAQBX9dWfUcvkqsdt1tCB9kHRsW2G8G/qdly8RPHHlbu8hsWUvOgZixJ
        XxQ/lAfVJGK8joSmSsAtboZDyg/iMUu9Bw==
X-Google-Smtp-Source: AKy350Zm8wyk0Ov+v3137EA87wVGWVR9Vm4iZAPaPqQI7KruwmAQEp3kDp+tw0FpRT2W9DxyXTfpxw==
X-Received: by 2002:a17:90b:1d01:b0:23f:dd27:169b with SMTP id on1-20020a17090b1d0100b0023fdd27169bmr24922536pjb.2.1680171626821;
        Thu, 30 Mar 2023 03:20:26 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. (94.130.220.35.bc.googleusercontent.com. [35.220.130.94])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090abb8800b002376d85844dsm2860416pjr.51.2023.03.30.03.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 03:20:26 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-watchdog@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Yang Ling <gnaygnil@gmail.com>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 1/2] MIPS: Loongson32: Remove reset.c
Date:   Thu, 30 Mar 2023 18:20:12 +0800
Message-Id: <20230330102013.545588-2-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230330102013.545588-1-keguang.zhang@gmail.com>
References: <20230330102013.545588-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
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
 .../include/asm/mach-loongson32/regs-wdt.h    | 15 ------
 arch/mips/loongson32/common/Makefile          |  2 +-
 arch/mips/loongson32/common/reset.c           | 51 -------------------
 3 files changed, 1 insertion(+), 67 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/regs-wdt.h
 delete mode 100644 arch/mips/loongson32/common/reset.c

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

