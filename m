Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5E45F4390
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 14:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJDMwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 08:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbiJDMwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 08:52:04 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46C6860538
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 05:49:06 -0700 (PDT)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id C2440407526D;
        Tue,  4 Oct 2022 12:48:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C2440407526D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1664887712;
        bh=3sH90JlUP4xUI9OIJRKWNY06AeCyljb0SU9JvCRGh6A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RHxqjbobGuKeBiMunp/00RI44douvnJPXh+/vbrZ0G9nBxtI/73GNz8iRme/0b62N
         wLI/2rULzhkN2vzxJbCeG5/4KSoa3SnOVT5BhYmDrYg+m8I7QxxFsq5Fltlx6zAD9Q
         n36z50jwO7j4UBLkJC9j/IxWU5jxSt4Uof5tapTs=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v7 4/5] x86/boot: Use cmdline_prapare() in compressed kernel
Date:   Tue,  4 Oct 2022 15:48:23 +0300
Message-Id: <a87e02d90b5f743f361257a135db192c66811042.1664886978.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1664886978.git.baskov@ispras.ru>
References: <cover.1664886978.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_CMDLINE_BOOL and CONFIG_CMDLINE_OVERRIDE were ignored during
options lookup in compressed kernel, including earlyprintk option,
so it was impossible to get earlyprintk messages from that stage
of boot process via command line provided at compile time.
Being able to enable earlyprintk via compile-time option might
be desirable for booting on systems with broken UEFI command line
arguments via EFISTUB.

Use a common helper function to handle CONFIG_CMDLINE_* in compressed
kernel.

Place command_line_init explicitly in '.data' section since it is
used before '.bss' section is zeroed and it is expected to be equal
to zero.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>
---
 arch/x86/boot/compressed/cmdline.c | 24 ++++++++++++++++++++++--
 arch/x86/boot/compressed/misc.h    |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..717f450662aa 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -12,6 +12,15 @@ static inline char rdfs8(addr_t addr)
 	return *((char *)(fs + addr));
 }
 #include "../cmdline.c"
+
+static char command_line[COMMAND_LINE_SIZE] __section(".data") = COMMAND_LINE_INIT;
+static bool command_line_init __section(".data");
+
+/*
+ * This always returns runtime command line and does not account for built-in
+ * command line, so this should not be used for cmdline parsing.
+ * Use get_cmdline() instead.
+ */
 unsigned long get_cmd_line_ptr(void)
 {
 	unsigned long cmd_line_ptr = boot_params->hdr.cmd_line_ptr;
@@ -20,11 +29,22 @@ unsigned long get_cmd_line_ptr(void)
 
 	return cmd_line_ptr;
 }
+
+static inline unsigned long get_cmdline(void)
+{
+	if (!command_line_init) {
+		cmdline_prepare(command_line, (char *)get_cmd_line_ptr());
+		command_line_init = 1;
+	}
+
+	return (unsigned long)command_line;
+}
+
 int cmdline_find_option(const char *option, char *buffer, int bufsize)
 {
-	return __cmdline_find_option(get_cmd_line_ptr(), option, buffer, bufsize);
+	return __cmdline_find_option(get_cmdline(), option, buffer, bufsize);
 }
 int cmdline_find_option_bool(const char *option)
 {
-	return __cmdline_find_option_bool(get_cmd_line_ptr(), option);
+	return __cmdline_find_option_bool(get_cmdline(), option);
 }
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 62208ec04ca4..5bf1357c054c 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -26,6 +26,7 @@
 #include <asm/boot.h>
 #include <asm/bootparam.h>
 #include <asm/desc_defs.h>
+#include <asm/shared/cmdline.h>
 
 #include "tdx.h"
 
-- 
2.35.1

