Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D666D72EDBB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 23:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjFMVPK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 17:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbjFMVPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 17:15:08 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216B7173C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:15:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-652d76be8c2so6361996b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20221208.gappssmtp.com; s=20221208; t=1686690906; x=1689282906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NCLquGQvDexYDJN5ZYb1VbkASAozbobEJg+/ErQneBk=;
        b=oX27fUbIEJ+RzWt+5RVZVO4efM0QAkkR1rzJMH5dKnuY/+THYQ/328YKD9fxtc5Wo6
         CAF0Dj2yJbxetL1CuZZv6hE6JOXzCo8JHdb3SbuRbbtzWTczztu8TMTVlR35kwW+/258
         3wwqnt3Gu4pFO3u/pbW7qel3d+E5ytSdbM1Lznu5tU7m0yhMi66gduGpMByKJ+a81Eom
         nWxdc0H1Y2a+ShKTXNRIJf4awUQZY76KSWZi6SXWgH+ysxSW+OQ82o3j+cfEf396xxAQ
         8cRY8OsD1QoCkRnaw0hjRMTRmd/Lv1FVsQywvIhwl8yNGdjt53JTAYUI5fvWKRGJehWC
         g6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686690906; x=1689282906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCLquGQvDexYDJN5ZYb1VbkASAozbobEJg+/ErQneBk=;
        b=URoebe0YGAMIeIlyAQ11mGzu1ZiCEUd3UeXmiE8zVXyrlvPS59pqEb3y9EYA1+fTho
         02Zu/o/wPNUCz3jLDSW46DO+8ksj9b1C8LaDL7u2B/GdAv4Fqd1jwsdwnxD9xbCYX53v
         UfB590Sqpk6VYDQ9OREevOdNbz1RY0p93DLkO5l7qFIGKrIujefDEGgMInr19+1hRlYw
         K6YUVlwOptnDB6pptcV7rB+dbEwPAJfYV3wmux3yjShDvgHp+xoAuClRfKi2tzI57ObK
         wRpbTT/sh5SHFFzLEJ/ffF16BLfog8f+KS1xGpIsHf17852lLyhqO7/X3bQ1F9hrUUw5
         TcDw==
X-Gm-Message-State: AC+VfDzkHOXDxcFP43yAMLdDA0w3LmwKBM+rOcWu/dltMiZzmSR2QbuW
        P1Nr8+yVJQl0V7UPb4WchdHNFebbaTZ97dxn0mw=
X-Google-Smtp-Source: ACHHUZ5nIu8EFfWRkUwtRPl8VyQw9wqTMm1iqoC/+4gzb9hofLlreBXBUehYPK0pSovublexcs4ZcQ==
X-Received: by 2002:a05:6a00:24d3:b0:64d:4a94:1a60 with SMTP id d19-20020a056a0024d300b0064d4a941a60mr21394437pfv.18.1686690906314;
        Tue, 13 Jun 2023 14:15:06 -0700 (PDT)
Received: from telecaster.tfbnw.net ([2620:10d:c090:400::5:3fe])
        by smtp.gmail.com with ESMTPSA id y23-20020aa78557000000b0064cb0845c77sm9039793pfn.122.2023.06.13.14.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 14:15:05 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v2] x86/unwind/orc: add ELF section with ORC version identifier
Date:   Tue, 13 Jun 2023 14:14:56 -0700
Message-Id: <aef9c8dc43915b886a8c48509a12ec1b006ca1ca.1686690801.git.osandov@osandov.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

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

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Hi,

This is v2 of my patch to make it possible for external tools like drgn
to identify versions of the ORC format. As stated in v1 [1], I don't
want ORC to be stable ABI; I just need a way to identify the format
being used.

This version incorporates Peter's suggestion to hash the ORC definitions
instead of requiring a manual version number; this is easier to maintain
and more resilient to backports.

I would love to get this in before 6.4 is released, and then hopefully
backport it to 6.3-stable.

This is based on Linus' tree as of today (commit
fb054096aea0576f0c0a61c598e5e9676443ee86).

Thanks!
Omar

 arch/x86/Makefile                 | 12 ++++++++++++
 arch/x86/include/asm/Kbuild       |  1 +
 arch/x86/include/asm/orc_header.h | 19 +++++++++++++++++++
 arch/x86/kernel/unwind_orc.c      |  3 +++
 include/asm-generic/vmlinux.lds.h |  3 +++
 scripts/mod/modpost.c             |  5 +++++
 scripts/orc_hash.sh               | 16 ++++++++++++++++
 7 files changed, 59 insertions(+)
 create mode 100644 arch/x86/include/asm/orc_header.h
 create mode 100755 scripts/orc_hash.sh

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b39975977c03..fdc2e3abd615 100644
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
index 1e51650b79d7..4f1ce5fc4e19 100644
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
index 000000000000..07bacf3e160e
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
index 3ac50b7298d1..4d8e518365f4 100644
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
index cebdf1ca415d..da9e5629ea43 100644
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
index d4531d09984d..c12150f96b88 100644
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
new file mode 100755
index 000000000000..466611aa0053
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
-- 
2.40.1

