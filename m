Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5551C7052A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjEPPrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbjEPPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:47:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FFD9009;
        Tue, 16 May 2023 08:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 289B56199D;
        Tue, 16 May 2023 15:46:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 622B5C433A1;
        Tue, 16 May 2023 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684251998;
        bh=bb4tLM7F7LcxwwEo0PKA82PjYT5xeKwmGZrmJ2KR1Mc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u8ce39x0iL4VHXseEGqG0JIzbnLLnqNL/0pzr0qYvUxVaZ8NJ4MQ1LZaWaWaGYxjz
         k7eseCM1DeE6sB51PtFOtE+loAd/Q7L/Upvbf302nIuitTZSjgAgoGlL5OA67qLTU8
         JBZbJyQ3IGejsPcW14ZnIKNRYDRaWaEynLLz+kYNVTD8n+4c8QqwvjtKMSWvBv+cT2
         T+fPHjwVLaDtlNONHS0Ts6ZOYg1cykE2dbGdGQfR/OmniqrO2P57LBFf+xvjGSlpCf
         zG6SpiGr4NGe4Eh8LrrsZI6PX8qymD76AWPG680zqwEjWTC04mlal+NncPDzd4a3kg
         kqW3/ADTQzuWA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Russell King <linux@armlinux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH 06/16] ARM: tcm: move tcm_init() prototype to asm/tcm.h
Date:   Tue, 16 May 2023 17:45:55 +0200
Message-Id: <20230516154605.517690-7-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The function definition is in a file that does not include the
header with the declaration:

arch/arm/kernel/tcm.c:256:13: error: no previous prototype for 'tcm_init'

Move the declaration to a global header where it can actually be
included.

Fixes: de40614e92bf ("ARM: 7694/1: ARM, TCM: initialize TCM in paging_init(), instead of setup_arch()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/tcm.h | 11 ++++++++---
 arch/arm/mm/mmu.c          |  2 +-
 arch/arm/mm/tcm.h          | 17 -----------------
 3 files changed, 9 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/mm/tcm.h

diff --git a/arch/arm/include/asm/tcm.h b/arch/arm/include/asm/tcm.h
index d8bd8a4b0ede..e1f7dca86a22 100644
--- a/arch/arm/include/asm/tcm.h
+++ b/arch/arm/include/asm/tcm.h
@@ -9,9 +9,7 @@
 #ifndef __ASMARM_TCM_H
 #define __ASMARM_TCM_H
 
-#ifndef CONFIG_HAVE_TCM
-#error "You should not be including tcm.h unless you have a TCM!"
-#endif
+#ifdef CONFIG_HAVE_TCM
 
 #include <linux/compiler.h>
 
@@ -29,4 +27,11 @@ void tcm_free(void *addr, size_t len);
 bool tcm_dtcm_present(void);
 bool tcm_itcm_present(void);
 
+void __init tcm_init(void);
+#else
+/* No TCM support, just blank inlines to be optimized out */
+static inline void tcm_init(void)
+{
+}
+#endif
 #endif
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 463fc2a8448f..f3a52c08a200 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -21,6 +21,7 @@
 #include <asm/sections.h>
 #include <asm/setup.h>
 #include <asm/smp_plat.h>
+#include <asm/tcm.h>
 #include <asm/tlb.h>
 #include <asm/highmem.h>
 #include <asm/system_info.h>
@@ -37,7 +38,6 @@
 
 #include "fault.h"
 #include "mm.h"
-#include "tcm.h"
 
 extern unsigned long __atags_pointer;
 
diff --git a/arch/arm/mm/tcm.h b/arch/arm/mm/tcm.h
deleted file mode 100644
index 6b80a760d875..000000000000
--- a/arch/arm/mm/tcm.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2008-2009 ST-Ericsson AB
- * TCM memory handling for ARM systems
- *
- * Author: Linus Walleij <linus.walleij@stericsson.com>
- * Author: Rickard Andersson <rickard.andersson@stericsson.com>
- */
-
-#ifdef CONFIG_HAVE_TCM
-void __init tcm_init(void);
-#else
-/* No TCM support, just blank inlines to be optimized out */
-static inline void tcm_init(void)
-{
-}
-#endif
-- 
2.39.2

