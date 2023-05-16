Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810A17052BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 17:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjEPPtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 11:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234123AbjEPPsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 11:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B819012;
        Tue, 16 May 2023 08:47:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 194BE63B7B;
        Tue, 16 May 2023 15:47:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51836C4339C;
        Tue, 16 May 2023 15:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684252031;
        bh=flMIm7rrA3GwPRe1i4A+2+g3vRYY++3FaIonU0BJ0lo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mg4jI0Qd1iMhwE7fFVWVtYXkJ/ZmjPeoPxAQBiXAa/Kg12YaAUl/K8P8ZDSEGhWo8
         CJ/aKo6+JP0nyYIbZxQWh2U43kSkjDxtQG9PUoaiZhDkB+kZCFmiU8ES7TERNlH86g
         cWstm4OIHk3rZ78BVNVccqtYurBxSr51ZxSW0BhdgVScP0gp6JdR6vVpXvViPvuWXQ
         CxJQZZYSeDy6eYleVtK859sxJeUKrWLl0FZKbv2mXmchibDykofKpyolkyI63CD4BL
         5pcOEKp0vPQ46j+18pF9LRf6OgVKbyENHhiH3GbxSqP3+EiLeX5pia9CDovm3A74s/
         riMie3u5rsiRQ==
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
Subject: [PATCH 15/16] ARM: decompressor: move function prototypes to misc.h
Date:   Tue, 16 May 2023 17:46:04 +0200
Message-Id: <20230516154605.517690-16-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230516154605.517690-1-arnd@kernel.org>
References: <20230516154605.517690-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A number of prototypes are missing for the decompressor, some
of them are in the .c files that contain the callers, but are
invisible at the function definition:

arch/arm/boot/compressed/misc.c:129:17: error: no previous prototype for '__div0' [-Werror=missing-prototypes]
arch/arm/boot/compressed/misc.c:138:1: error: no previous prototype for 'decompress_kernel' [-Werror=missing-prototypes]
arch/arm/boot/compressed/misc.c:163:6: error: no previous prototype for 'fortify_panic' [-Werror=missing-prototypes]
arch/arm/boot/compressed/decompress.c:63:5: error: no previous prototype for 'do_decompress' [-Werror=missing-prototypes]
arch/arm/boot/compressed/fdt_check_mem_start.c:63:10: error: no previous prototype for 'fdt_check_mem_start' [-Werror=missing-prototypes]

Move these all to misc.h so they are visible by the callee as well.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/compressed/atags_to_fdt.c        |  1 +
 arch/arm/boot/compressed/fdt_check_mem_start.c |  1 +
 arch/arm/boot/compressed/misc.c                |  6 ------
 arch/arm/boot/compressed/misc.h                | 11 +++++++++++
 4 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/compressed/atags_to_fdt.c b/arch/arm/boot/compressed/atags_to_fdt.c
index c579d9c42fd4..b584e091f702 100644
--- a/arch/arm/boot/compressed/atags_to_fdt.c
+++ b/arch/arm/boot/compressed/atags_to_fdt.c
@@ -2,6 +2,7 @@
 #include <linux/libfdt_env.h>
 #include <asm/setup.h>
 #include <libfdt.h>
+#include "misc.h"
 
 #if defined(CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND)
 #define do_extend_cmdline 1
diff --git a/arch/arm/boot/compressed/fdt_check_mem_start.c b/arch/arm/boot/compressed/fdt_check_mem_start.c
index 9291a2661bdf..aa856567fd33 100644
--- a/arch/arm/boot/compressed/fdt_check_mem_start.c
+++ b/arch/arm/boot/compressed/fdt_check_mem_start.c
@@ -3,6 +3,7 @@
 #include <linux/kernel.h>
 #include <linux/libfdt.h>
 #include <linux/sizes.h>
+#include "misc.h"
 
 static const void *get_prop(const void *fdt, const char *node_path,
 			    const char *property, int minlen)
diff --git a/arch/arm/boot/compressed/misc.c b/arch/arm/boot/compressed/misc.c
index abfed1aa2baa..6b4baa6a9a50 100644
--- a/arch/arm/boot/compressed/misc.c
+++ b/arch/arm/boot/compressed/misc.c
@@ -103,9 +103,6 @@ static void putstr(const char *ptr)
 /*
  * gzip declarations
  */
-extern char input_data[];
-extern char input_data_end[];
-
 unsigned char *output_data;
 
 unsigned long free_mem_ptr;
@@ -131,9 +128,6 @@ asmlinkage void __div0(void)
 	error("Attempting division by 0!");
 }
 
-extern int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
-
-
 void
 decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
 		unsigned long free_mem_ptr_end_p,
diff --git a/arch/arm/boot/compressed/misc.h b/arch/arm/boot/compressed/misc.h
index c958dccd1d97..6da00a26ac08 100644
--- a/arch/arm/boot/compressed/misc.h
+++ b/arch/arm/boot/compressed/misc.h
@@ -6,5 +6,16 @@
 void error(char *x) __noreturn;
 extern unsigned long free_mem_ptr;
 extern unsigned long free_mem_end_ptr;
+void __div0(void);
+void
+decompress_kernel(unsigned long output_start, unsigned long free_mem_ptr_p,
+		  unsigned long free_mem_ptr_end_p, int arch_id);
+void fortify_panic(const char *name);
+int atags_to_fdt(void *atag_list, void *fdt, int total_space);
+uint32_t fdt_check_mem_start(uint32_t mem_start, const void *fdt);
+int do_decompress(u8 *input, int len, u8 *output, void (*error)(char *x));
+
+extern char input_data[];
+extern char input_data_end[];
 
 #endif
-- 
2.39.2

