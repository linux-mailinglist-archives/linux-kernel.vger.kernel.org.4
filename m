Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B8E6242EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiKJNJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230238AbiKJNJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:09:39 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0264C12A89
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:09:37 -0800 (PST)
Received: from localhost.localdomain (unknown [83.149.199.65])
        by mail.ispras.ru (Postfix) with ESMTPSA id 1B85D40737BB;
        Thu, 10 Nov 2022 13:09:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 1B85D40737BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1668085776;
        bh=8C0m+nikY+hKoEP6Ez5Q8u9vl0RUFjErqLyUvRmpH6Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZYwUalCb2nXd9lnjaqKwRXntRhcitVOzWlSmiJzHB5wCOn6y7U4B/c9YUkVuH7zxT
         BpA2vKgZurcsqZQK1gvVBNh/lFmv3JdwFnD+BtfGm7IU5kiAVH2pswTXc2ROiOl6u6
         3EthC7c8acYuGdY1iKyQrGrl1vAfutJ2lPdA2QkE=
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>
Subject: [PATCH v8 4/5] x86/boot: Use cmdline_prapare() in compressed kernel
Date:   Thu, 10 Nov 2022 16:09:32 +0300
Message-Id: <290b33437bc94c32fce2e13c0599eab5e1cc3132.1668082601.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <cover.1668082601.git.baskov@ispras.ru>
References: <cover.1668082601.git.baskov@ispras.ru>
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
index f1add5d85da9..53ad259ee441 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -12,6 +12,15 @@ static inline char rdfs8(addr_t addr)
 	return *((char *)(fs + addr));
 }
 #include "../cmdline.c"
+
+static char command_line[COMMAND_LINE_SIZE] __section(".data");
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
2.37.4

