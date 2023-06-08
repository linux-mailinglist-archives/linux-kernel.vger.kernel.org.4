Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4AD2728B2B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 00:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231569AbjFHWiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 18:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjFHWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 18:38:44 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C89C2D42
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:38:42 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-25676b4fb78so162386a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 15:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20221208.gappssmtp.com; s=20221208; t=1686263921; x=1688855921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NDI0T36P8wam95iTZh7MNh7BQoHwlXa43zNHeNUA3Y4=;
        b=FV4PQ2DT5B7WQ4xUr6FhaQ04OGEnVCo98lVkBdIZ2gptGJkKUXLkbMKVwOHIdbIbmi
         0vUhVgBGv6thYjqfofTXyFip1Wdq7lt1n3wq7JMfjZDYgaV2zVz3hHxjfyxH6HNolC1s
         ku9tzPzSTeBTqG4oqcIElPkdPWxo/iuc4+FnNTZGLiGoWPA8sA84IgDY/wKlSHogp9Tz
         3f9NXBm+Si7LfKPO0Je/J43ROb+F6aB/bHHXuD3nal5fsfBZhxaZRSul6JGtLl+kchIx
         tvJ6dLEPU+E8fepaqE1qyLeLooadelvkkI4PYl3Wd11/Xp03WkmvuhpDbguj5y1s5ncy
         DEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686263921; x=1688855921;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NDI0T36P8wam95iTZh7MNh7BQoHwlXa43zNHeNUA3Y4=;
        b=Y4/CbNjBV9zcfXIeYQ6JdZxXkhbqhe2aO7j5qjBbIPykFFSor56Kp+hfsusjqEGXK5
         IztBhlP/IyBV9FwDHmYlZMESlwViQvr4ry2PfK3IDeISC5o04oPPtdUuTeXenNxipQvi
         mXlFcGtLsDs8xkbLNt90E7vwVx6PvSoIF6f0zMjOD8tjCVZPR3e7WH5ZCy6/1F3xUsVG
         q1lxyOoR1qc0X/f/i5t08b9jFAKnHFklVyC++yEG6IqC7tpkE5gWXRY2H6+Zo3quff4/
         LXh9e5L+rnc/TUSiLTGFW5EElHPhARo0WE0lSvL22NDEhZw2ekz4xYQd8CUcazw9tOdS
         SHrg==
X-Gm-Message-State: AC+VfDzgB9spX7rg88uo6HV1eCkubbGXYSv6AqsRXYrbFz/OFYyljauy
        X4pq+5wDwB6iS1wN3rWlWbkRDw==
X-Google-Smtp-Source: ACHHUZ6S2zaR+XA6b1q26fZg3SHxxh3l8k1iSLOqMLd0ipSgqKSlggWLb4qKncO5lxOfky/Dnez4Bg==
X-Received: by 2002:a17:90b:4b83:b0:256:5895:a2f9 with SMTP id lr3-20020a17090b4b8300b002565895a2f9mr5704187pjb.28.1686263921538;
        Thu, 08 Jun 2023 15:38:41 -0700 (PDT)
Received: from telecaster.tfbnw.net ([2620:10d:c090:400::5:f15c])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a3e0700b0025063e893c9sm3465377pjc.55.2023.06.08.15.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 15:38:41 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-debuggers@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH] x86/unwind/orc: add ELF section with ORC version number
Date:   Thu,  8 Jun 2023 15:38:38 -0700
Message-Id: <5b70bc58ef70aab0a821111cd3201eeced8bab95.1686263379.git.osandov@osandov.com>
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
ORC format as long as I have a way to detect the change. Using the
kernel version is not a solution because distros frequently backport
changes.

It suffices to store a version number for the ORC format in the vmlinux
and kernel module ELF files (to use when parsing ORC sections from ELF),
and in kernel memory (to use when parsing ORC from a core dump). This
patch adds both of these by creating an .orc_header ELF section
containing a 4-byte version number and the corresponding
__start_orc_header and __stop_orc_header symbols.

The current version number is 3. Version 1 is the original version
merged in commit ee9f8fce9964 ("x86/unwind: Add the ORC unwinder").
Version 2 is the version from commit ffb1b4a41016 ("x86/unwind/orc: Add
'signal' field to ORC metadata"), which obviously didn't include this
header but could get it in a backport to the 6.3 stable branch.

1: https://github.com/osandov/drgn
2: https://github.com/osandov/drgn/issues/303

Signed-off-by: Omar Sandoval <osandov@fb.com>
---
Hi,

As mentioned in the commit message, the motivation for this patch is
allowing drgn to continue to make use of ORC for kernel stack unwinding.

I want to make it clear that I don't want ORC to be stable ABI. The
kernel is free to change the format as much as needed, I just need a way
to detect the change. (drgn already pokes at many kernel internals and
needs updates for most kernel versions anyways. We have a big test suite
to catch changes we care about.)

I'm not at all married to (or proud of) this particular implementation;
I'd be happy to use anything that lets me detect the format version in
both cases mentioned in the commit message (ELF file or core dump +
symbol table).

It'd be great if we could get a solution in before 6.4 is released. I
would've reported this sooner, but I just got back from paternity leave
last week.

Thanks!
Omar

 arch/x86/include/asm/orc_header.h      | 14 ++++++++++++++
 arch/x86/include/asm/orc_types.h       | 14 ++++++++++++++
 arch/x86/kernel/unwind_orc.c           |  3 +++
 include/asm-generic/vmlinux.lds.h      |  3 +++
 scripts/mod/modpost.c                  |  5 +++++
 tools/arch/x86/include/asm/orc_types.h | 14 ++++++++++++++
 6 files changed, 53 insertions(+)
 create mode 100644 arch/x86/include/asm/orc_header.h

diff --git a/arch/x86/include/asm/orc_header.h b/arch/x86/include/asm/orc_header.h
new file mode 100644
index 000000000000..08c3710311f7
--- /dev/null
+++ b/arch/x86/include/asm/orc_header.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _ORC_HEADER_H
+#define _ORC_HEADER_H
+
+#include <asm/orc_types.h>
+
+/* For now, the header is just the 4-byte version number. */
+#define ORC_HEADER					\
+	__used __section(".orc_header")			\
+	static const u32 orc_header = ORC_VERSION
+
+#endif /* _ORC_HEADER_H */
diff --git a/arch/x86/include/asm/orc_types.h b/arch/x86/include/asm/orc_types.h
index 46d7e06763c9..fe1669284254 100644
--- a/arch/x86/include/asm/orc_types.h
+++ b/arch/x86/include/asm/orc_types.h
@@ -9,6 +9,20 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 
+/*
+ * Bump this whenever the format of .orc_unwind, .orc_unwind_ip, or .orc_lookup
+ * changes.
+ *
+ * - Version 2:
+ *   - Added struct orc_entry.signal
+ * - Version 3:
+ *     - Removed struct orc_entry.end
+ *     - Made struct orc_entry.type 3 bits
+ *     - Added ORC_TYPE_UNDEFINED and ORC_TYPE_END_OF_STACK
+ *     - Renumbered ORC_TYPE_CALL, ORC_TYPE_REGS, and ORC_TYPE_REGS_PARTIAL
+ */
+#define ORC_VERSION 3
+
 /*
  * The ORC_REG_* registers are base registers which are used to find other
  * registers on the stack.
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
diff --git a/tools/arch/x86/include/asm/orc_types.h b/tools/arch/x86/include/asm/orc_types.h
index 46d7e06763c9..fe1669284254 100644
--- a/tools/arch/x86/include/asm/orc_types.h
+++ b/tools/arch/x86/include/asm/orc_types.h
@@ -9,6 +9,20 @@
 #include <linux/types.h>
 #include <linux/compiler.h>
 
+/*
+ * Bump this whenever the format of .orc_unwind, .orc_unwind_ip, or .orc_lookup
+ * changes.
+ *
+ * - Version 2:
+ *   - Added struct orc_entry.signal
+ * - Version 3:
+ *     - Removed struct orc_entry.end
+ *     - Made struct orc_entry.type 3 bits
+ *     - Added ORC_TYPE_UNDEFINED and ORC_TYPE_END_OF_STACK
+ *     - Renumbered ORC_TYPE_CALL, ORC_TYPE_REGS, and ORC_TYPE_REGS_PARTIAL
+ */
+#define ORC_VERSION 3
+
 /*
  * The ORC_REG_* registers are base registers which are used to find other
  * registers on the stack.
-- 
2.40.1

