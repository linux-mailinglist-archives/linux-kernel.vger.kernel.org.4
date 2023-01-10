Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34DC664D22
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjAJUSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjAJUSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:18:49 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF3D5A8AB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:18:47 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id a184so9745016pfa.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fmZY1OG3vNe332Ldn6SBLXuV8Uze5QRsR/60UtVCPJw=;
        b=ttjElWMwOaUBMpTvifsVi6ycU8gvbU6MTiHvMC392d1gVaNVg+44gVRdyqzuioNEca
         ZmgcKQuhpeDVBw3jidvnWcZGQP6Rkk/eA+jGG3/e5K+Tjop3FxBUqwzBgxKQ6olxphbH
         DLNQdx1wAkhGAwY+U1K8+9OePHIpLDsWZPuFeiVh/9GHwCptRUwR0FaUMVvRr2ugiy2H
         XlI23+BFo1GnV4uJDFFySfN5iFzS6Ge1+KXuylxIfPAJXKmtFNgul8EUXcQ0+Cn3Yqzf
         VRpb0viT6jSA0dffFAOO2ef4ueYDDwxKgWOK6DEroFPUyFPquQY3tw8XWOyRMatAJZ6U
         H4DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fmZY1OG3vNe332Ldn6SBLXuV8Uze5QRsR/60UtVCPJw=;
        b=K7ZjRynCfxHq6IhKzJfyQnjLshvBACBpPYon2EiFU2FHLX/ZgHGoBoeyNIKMX5Um/g
         oP2DXtcWoK+sj0kFhJeMzLR7KqS6JSkLm9aVADnwDZ8/INzChZAJ9axqv+Hakq3WxUd7
         oV1FUj+Y7ZObug3pT5Q0g5A7ysRySOG7EqTakMr+MzmrmbjKpoP2cGastjV79UHKEUsk
         hzPw0tWdMloFf2DJ8LUAdpgQ6Bnzc5v/YpzJsGlPk8haqWw9zYegpt7821Ho7oXxz95c
         EO13DZpE/u3pbVUjrduqcoXgqx/GTLA6hija+qNcdO2lJjqNL91Pc0t0yNyMhBMVbYFl
         cllQ==
X-Gm-Message-State: AFqh2kowtfaf1vgviryQ16J8CfiFB7OXcC2PsE+2k0C0Q+7IKZxK2LXv
        ZJRCJBbHl0aBbq2H6rcXp2NTnw==
X-Google-Smtp-Source: AMrXdXvjO4PLt837d3MdSE38CVPdAv2/VufYEH3Pz9/Z6W2P2LN5VuNgmI/fW6IHumEr5sMHcoUgFA==
X-Received: by 2002:aa7:84d1:0:b0:58a:9619:9b30 with SMTP id x17-20020aa784d1000000b0058a96199b30mr3503750pfn.10.1673381927403;
        Tue, 10 Jan 2023 12:18:47 -0800 (PST)
Received: from vineet-framework.ba.rivosinc.com (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id d3-20020aa797a3000000b005811c4245c7sm8477802pfq.126.2023.01.10.12.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 12:18:46 -0800 (PST)
From:   Vineet Gupta <vineetg@rivosinc.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        Vineet Gupta <vineetg@rivosinc.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] riscv: elf: add .riscv.attributes parsing
Date:   Tue, 10 Jan 2023 12:18:41 -0800
Message-Id: <20230110201841.2069353-1-vineetg@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This implements the elf loader hook to parse RV specific
.riscv.attributes section. This section is inserted by compilers
(gcc/llvm) with build related information such as -march organized as
tag/value attribute pairs.

It identifies the various attribute tags (and corresponding values) as
currently specified in the psABI specification.

This patch only implements the elf parsing mechanics, leaving out the
recording/usage of the attributes to subsequent patches.

Reported-by: kernel test robot <lkp@intel.com>  # code under CONFIG_COMPAT
Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
---
 arch/riscv/Kconfig           |   1 +
 arch/riscv/include/asm/elf.h |  11 +++
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/elf-attr.c | 150 +++++++++++++++++++++++++++++++++++
 4 files changed, 163 insertions(+)
 create mode 100644 arch/riscv/kernel/elf-attr.c

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e2b656043abf..f7e0ab05a2d2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -12,6 +12,7 @@ config 32BIT
 
 config RISCV
 	def_bool y
+	select ARCH_BINFMT_ELF_STATE
 	select ARCH_CLOCKSOURCE_INIT
 	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index e7acffdf21d2..7ab8bd0ec330 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -116,6 +116,17 @@ do {							\
 		*(struct user_regs_struct *)regs;	\
 } while (0);
 
+struct arch_elf_state {
+};
+
+#define INIT_ARCH_ELF_STATE {}
+
+extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
+			    bool is_interp, struct arch_elf_state *state);
+
+extern int arch_check_elf(void *ehdr, bool has_interpreter, void *interp_ehdr,
+			  struct arch_elf_state *state);
+
 #ifdef CONFIG_COMPAT
 
 #define SET_PERSONALITY(ex)					\
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 4cf303a779ab..eff6d845ac9d 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -50,6 +50,7 @@ obj-y	+= riscv_ksyms.o
 obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
+obj-y	+= elf-attr.o
 obj-y	+= probes/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
diff --git a/arch/riscv/kernel/elf-attr.c b/arch/riscv/kernel/elf-attr.c
new file mode 100644
index 000000000000..148d720f97de
--- /dev/null
+++ b/arch/riscv/kernel/elf-attr.c
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023-24 Rivos Inc.
+ */
+
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "rv-elf-attr: " fmt
+
+#define PT_RISCV_ATTRIBUTES		0x70000003
+
+#define RV_ATTR_TAG_stack_align		4
+#define RV_ATTR_TAG_arch		5
+#define RV_ATTR_TAG_unaligned_access	6
+
+#define RV_ATTR_SEC_SZ			SZ_1K
+
+static void rv_elf_attr_int(u64 tag, u64 val)
+{
+}
+
+static void rv_elf_attr_str(u64 tag, const char *str)
+{
+}
+
+static u64
+decode_uleb128(unsigned char **dpp)
+{
+	unsigned char *bp = *dpp;
+	unsigned char byte;
+	unsigned int shift = 0;
+	u64 result = 0;
+
+	while (1) {
+		byte = *bp++;
+		result |= (byte & 0x7f) << shift;
+		if ((byte & 0x80) == 0)
+			break;
+		shift += 7;
+	}
+	*dpp = bp;
+	return result;
+}
+
+/*
+ * Parse .riscv.attributes elf section to get the various compile time
+ * attributes such as -march, unaligned access and so no.
+ */
+static int rv_parse_elf_attributes(struct file *f, const struct elf_phdr *phdr,
+				   struct arch_elf_state *state)
+{
+	unsigned char buf[RV_ATTR_SEC_SZ];
+	unsigned char *p;
+	ssize_t n;
+	int ret = 0;
+	loff_t pos;
+
+	pr_debug("Section .riscv.attributes found\n");
+
+	/* Assume a reasonable size for now */
+	if (phdr->p_filesz > sizeof(buf))
+		return -ENOEXEC;
+
+	memset(buf, 0, RV_ATTR_SEC_SZ);
+	pos = phdr->p_offset;
+	n = kernel_read(f, &buf, phdr->p_filesz, &pos);
+
+	if (n < 0)
+		return -EIO;
+
+	p = buf;
+	p++;				/* format-version (1B) */
+
+	while ((p - buf) < n) {
+
+		unsigned char *vendor_start;
+		u32 len;
+
+		/*
+		 * Organized as "vendor" sub-section(s).
+		 * Current only 1 specified "riscv"
+		 */
+
+		p += 4;			/* sub-section length (4B) */
+		while (*p++ != '\0')	/* vendor name string */
+			;
+		p++;			/* Tag_File (1B) */
+		len = *(u32 *)p;	/* data length (4B) */
+		p += 4;
+
+		len -= 5;		/* data length includes Tag and self length */
+		vendor_start = p;
+		while ((p - vendor_start) < len) {
+
+			u64 tag = decode_uleb128(&p);
+			unsigned char *val_str;
+			u64 val_n;
+
+			switch (tag) {
+			case RV_ATTR_TAG_stack_align:
+				val_n = decode_uleb128(&p);
+				break;
+
+			case RV_ATTR_TAG_unaligned_access:
+				val_n = decode_uleb128(&p);
+				pr_debug("Tag_RISCV_unaligned_access =%llu\n", val_n);
+				rv_elf_attr_int(tag, val_n);
+				break;
+
+			case RV_ATTR_TAG_arch:
+				val_str = p;
+				while (*p++ != '\0')
+					;
+				pr_debug("Tag_RISCV_arch =[%s]\n", val_str);
+				rv_elf_attr_str(tag, val_str);
+				break;
+
+			default:
+				val_n = decode_uleb128(&p);
+				pr_debug("skipping Unrecognized Tag [%llu]=%llu\n", tag, val_n);
+				break;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Hook invoked from common elf loader to parse any arch specific elf segments
+ */
+int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
+		     bool is_interp, struct arch_elf_state *state)
+{
+	struct elf_phdr *phdr = _phdr;
+	int ret = 0;
+
+	if (phdr->p_type == PT_RISCV_ATTRIBUTES && !is_interp)
+		ret = rv_parse_elf_attributes(elf, phdr, state);
+
+	return ret;
+}
+
+int arch_check_elf(void *_ehdr, bool has_interpreter, void *_interp_ehdr,
+		   struct arch_elf_state *state)
+{
+	return 0;
+}
-- 
2.34.1

