Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882A07334AA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345765AbjFPPYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjFPPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:24:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B57B1BF8;
        Fri, 16 Jun 2023 08:24:44 -0700 (PDT)
Date:   Fri, 16 Jun 2023 15:24:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686929083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MN0HZQJ57wcfQb0HXOoE0f/WDPV885JVC8YH6SW6jGc=;
        b=C0y32c97lZb8A7q170qU6bYWn5PMRiHAM9hHN9Kh/gn4QXaFzYqWg5f5Wb+nJ9sqeN8yCR
        P3qkGit4wE26RZVonRcVINaf7JiNV8fhynG7NiAkU49Jkk0MWu+chKgqdJucrFgWwYq5dw
        Ju6cT0U6VfsRUykC/Ou/vK8g4IKGXQcICAY0oB9DmyFc4F5N7I35N60wz0HqoUY0vdXspa
        mLhoabFIEfSFHrtZ4oDD24ve3VZ+xzuu6oryeG5Pj2MZh7luKjfUC6JIbgaL3tkYQ1WOeq
        FX4Cs9jApKNKNLa5U4IQgsxXQyLEj0V4+XEzSWLfiEI0bylbOVw+IuwW5cSEGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686929083;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MN0HZQJ57wcfQb0HXOoE0f/WDPV885JVC8YH6SW6jGc=;
        b=GRyrBCvBIVuTVociW22kOcTmmo/cV5aIpLzrjK7Oa+olQT+jyHUNG+YVseF8qWQVDhoPXE
        BCWI2acVcEWMuoCA==
From:   "tip-bot2 for Omar Sandoval" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] x86/unwind/orc: Add ELF section with ORC
 version identifier
Cc:     Omar Sandoval <osandov@fb.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com>
References: <aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com>
MIME-Version: 1.0
Message-ID: <168692908232.404.1145760096244311999.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     b9f174c811e3ae4ae8959dc57e6adb9990e913f4
Gitweb:        https://git.kernel.org/tip/b9f174c811e3ae4ae8959dc57e6adb9990e913f4
Author:        Omar Sandoval <osandov@fb.com>
AuthorDate:    Tue, 13 Jun 2023 14:14:56 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Jun 2023 17:17:42 +02:00

x86/unwind/orc: Add ELF section with ORC version identifier

Commits ffb1b4a41016 ("x86/unwind/orc: Add 'signal' field to ORC
metadata") and fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in
two") changed the ORC format. Although ORC is internal to the kernel,
it's the only way for external tools to get reliable kernel stack traces
on x86-64. In particular, the drgn debugger [1] uses ORC for stack
unwinding, and these format changes broke it [2]. As the drgn
maintainer, I don't care how often or how much the kernel changes the
ORC format as long as I have a way to detect the change.

It suffices to store a version identifier in the vmlinux and kernel
module ELF files (to use when parsing ORC sections from ELF), and in
kernel memory (to use when parsing ORC from a core dump+symbol table).
Rather than hard-coding a version number that needs to be manually
bumped, Peterz suggested hashing the definitions from orc_types.h. If
there is a format change that isn't caught by this, the hashing script
can be updated.

This patch adds an .orc_header allocated ELF section containing the
20-byte hash to vmlinux and kernel modules, along with the corresponding
__start_orc_header and __stop_orc_header symbols in vmlinux.

1: https://github.com/osandov/drgn
2: https://github.com/osandov/drgn/issues/303

Fixes: ffb1b4a41016 ("x86/unwind/orc: Add 'signal' field to ORC metadata")
Fixes: fb799447ae29 ("x86,objtool: Split UNWIND_HINT_EMPTY in two")
Signed-off-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lkml.kernel.org/r/aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com
---
 arch/x86/Makefile                 | 12 ++++++++++++
 arch/x86/include/asm/Kbuild       |  1 +
 arch/x86/include/asm/orc_header.h | 19 +++++++++++++++++++
 arch/x86/kernel/unwind_orc.c      |  3 +++
 include/asm-generic/vmlinux.lds.h |  3 +++
 scripts/mod/modpost.c             |  5 +++++
 scripts/orc_hash.sh               | 16 ++++++++++++++++
 7 files changed, 59 insertions(+)
 create mode 100644 arch/x86/include/asm/orc_header.h
 create mode 100644 scripts/orc_hash.sh

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b399759..fdc2e3a 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -305,6 +305,18 @@ ifeq ($(RETPOLINE_CFLAGS),)
 endif
 endif
 
+ifdef CONFIG_UNWINDER_ORC
+orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
+orc_hash_sh := $(srctree)/scripts/orc_hash.sh
+targets += $(orc_hash_h)
+quiet_cmd_orc_hash = GEN     $@
+      cmd_orc_hash = mkdir -p $(dir $@); \
+		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
+$(orc_hash_h): $(srctree)/arch/x86/include/asm/orc_types.h $(orc_hash_sh) FORCE
+	$(call if_changed,orc_hash)
+archprepare: $(orc_hash_h)
+endif
+
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
 	$(Q)rm -rf $(objtree)/arch/x86_64
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 1e51650..4f1ce5f 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 
+generated-y += orc_hash.h
 generated-y += syscalls_32.h
 generated-y += syscalls_64.h
 generated-y += syscalls_x32.h
diff --git a/arch/x86/include/asm/orc_header.h b/arch/x86/include/asm/orc_header.h
new file mode 100644
index 0000000..07bacf3
--- /dev/null
+++ b/arch/x86/include/asm/orc_header.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _ORC_HEADER_H
+#define _ORC_HEADER_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/orc_hash.h>
+
+/*
+ * The header is currently a 20-byte hash of the ORC entry definition; see
+ * scripts/orc_hash.sh.
+ */
+#define ORC_HEADER					\
+	__used __section(".orc_header") __aligned(4)	\
+	static const u8 orc_header[] = { ORC_HASH }
+
+#endif /* _ORC_HEADER_H */
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 3ac50b7..4d8e518 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -7,6 +7,9 @@
 #include <asm/unwind.h>
 #include <asm/orc_types.h>
 #include <asm/orc_lookup.h>
+#include <asm/orc_header.h>
+
+ORC_HEADER;
 
 #define orc_warn(fmt, ...) \
 	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index cebdf1c..da9e562 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -839,6 +839,9 @@
 
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
+	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
 		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d4531d0..c12150f 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1979,6 +1979,11 @@ static void add_header(struct buffer *b, struct module *mod)
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
+	buf_printf(b, "#ifdef CONFIG_UNWINDER_ORC\n");
+	buf_printf(b, "#include <asm/orc_header.h>\n");
+	buf_printf(b, "ORC_HEADER;\n");
+	buf_printf(b, "#endif\n");
+	buf_printf(b, "\n");
 	buf_printf(b, "BUILD_SALT;\n");
 	buf_printf(b, "BUILD_LTO_INFO;\n");
 	buf_printf(b, "\n");
diff --git a/scripts/orc_hash.sh b/scripts/orc_hash.sh
new file mode 100644
index 0000000..466611a
--- /dev/null
+++ b/scripts/orc_hash.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+
+set -e
+
+printf '%s' '#define ORC_HASH '
+
+awk '
+/^#define ORC_(REG|TYPE)_/ { print }
+/^struct orc_entry {$/ { p=1 }
+p { print }
+/^}/ { p=0 }' |
+	sha1sum |
+	cut -d " " -f 1 |
+	sed 's/\([0-9a-f]\{2\}\)/0x\1,/g'
