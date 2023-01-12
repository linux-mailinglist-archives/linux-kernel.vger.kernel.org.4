Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75F4666854C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 22:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235985AbjALV13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 16:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjALV0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 16:26:53 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D510831A8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:06:27 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 36so13629508pgp.10
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 13:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DDsh5GRLDmAPT4ohGzYkIMdBdaGK6a97VLrKERNXpSI=;
        b=tC88Nl63tlsqkUVXbppM8YyNoBDPMJ+wX9IGOvEwtqpHT/QQDNc6B23b26p3/GE2xC
         Hv0XaI+Yp2/yv8Uk5lg/9zlLhNfRGbnvq/+p4zsXDk3g5c/RjXNv35N0RyAb/iW9lbgF
         PZHloYiuqIJt/JBYLbi50vZUYFjgvFmPTgD/5UMPS4OEO3V/CiMn3cVBnkUn3k2LF3OF
         7S7fwQoigqFodERVfs2x4uAib9GFLZM4DU21atw0fmuSzw4ndZyWS0xz7PM2bS8CBamP
         mHjEGgiL4VGMTtdo6YuQuKwRrCESQwFUi3u33nFVKwFQB5MZsaP5P/MR5e4oYpTpq1Rj
         u85g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDsh5GRLDmAPT4ohGzYkIMdBdaGK6a97VLrKERNXpSI=;
        b=eoFQonv2eH9HGDkKeTt1MnZlWM6PVqPYciuworIouYQi50OnxADDLrWW3GrlpOKPiq
         MErBKpB78KyCLqNGk+og7xjDy7RQtwhHE89Bm2rQbP8DRbr0KoXpKnDWK7IdeoUTnIQ0
         fK3u1lMNGwajsN6aNbPGEbSf82ENcfvUgDGNw6SAd0ICfwG9c+F33PWI57LYfUMsEGQk
         OBaauUYpIYEuz87bsgaa4C8+AmFp98ME7E8NSHf45U+TQ7oOhpUItLZP80z73+dBj3//
         E1cNF0f7bl1hu6qvZHze1HEZgs7XuQNRuvP7wGc0MQKaPwGfizXLcueT1HJdPiXYdtha
         wKTw==
X-Gm-Message-State: AFqh2koNro2iLisZ4FuthavafTs8MDSDXFobWCsMJ3KG/EeRU+fcPL/N
        gTluhhd4+83pzXaAHd3cWmXgrg==
X-Google-Smtp-Source: AMrXdXsWQjghAE7kgEGAEd1aCFC8+rYzpvT4J079pmOQkHUq/42SJ+7iweefO9sVUj+hscQUxYqVpA==
X-Received: by 2002:a05:6a00:1715:b0:580:ea08:5277 with SMTP id h21-20020a056a00171500b00580ea085277mr7392268pfc.16.1673557586949;
        Thu, 12 Jan 2023 13:06:26 -0800 (PST)
Received: from vineet-framework.ba.rivosinc.com (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id a203-20020a621ad4000000b00580e3917af7sm9206679pfa.117.2023.01.12.13.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 13:06:26 -0800 (PST)
From:   Vineet Gupta <vineetg@rivosinc.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH v2] riscv: elf: add .riscv.attributes parsing
Date:   Thu, 12 Jan 2023 13:06:22 -0800
Message-Id: <20230112210622.2337254-1-vineetg@rivosinc.com>
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

Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
---
Changes since v1 [1]
  - Handling potential oob accesses due to against malformed elf contents
  - Handling of multiple sub-subsections

[1]https://lore.kernel.org/linux-riscv/20230110201841.2069353-1-vineetg@rivosinc.com

Given the current state of discussions, the intended Vector extension
support would likely not need it, still posting the reworked v2 for
logical conclusion and for posterity in case need comes up in future
for something like CFI elf annotation.
Maintainers/reviewers can decide whether to merge it.
---
 arch/riscv/Kconfig           |   1 +
 arch/riscv/include/asm/elf.h |  11 ++
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/elf-attr.c | 232 +++++++++++++++++++++++++++++++++++
 4 files changed, 245 insertions(+)
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
index 000000000000..51bcee92dd5b
--- /dev/null
+++ b/arch/riscv/kernel/elf-attr.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+#include <linux/binfmts.h>
+#include <linux/elf.h>
+#include <asm/unaligned.h>
+
+#undef pr_fmt
+#define pr_fmt(fmt) "rv-elf-attr: " fmt
+
+#define PT_RISCV_ATTRIBUTES		0x70000003
+
+#define RV_ATTR_TAG_file		1
+
+#define RV_ATTR_TAG_stack_align		4
+#define RV_ATTR_TAG_arch		5
+#define RV_ATTR_TAG_unaligned_access	6
+
+#define RV_ATTR_VENDOR_RISCV		"riscv"
+
+#define RV_ATTR_SEC_SZ			SZ_1K
+
+static void rv_elf_attr_int(u32 tag, u32 val)
+{
+	pr_debug("Tag %x=%d\n", tag, val);
+}
+
+static void rv_elf_attr_str(u32 tag, const unsigned char *str)
+{
+	pr_debug("Tag %x=[%s]\n", tag, str);
+}
+
+/*
+ * Decode a ule128 encoded value.
+ */
+static int
+decode_uleb128_safe(unsigned char **dpp, u32 *val, const unsigned char *p_end)
+{
+	unsigned char *bp = *dpp;
+	unsigned char byte;
+	unsigned int shift = 0;
+	u32 result = 0;
+	int ok = 0;
+
+	while (bp < p_end) {
+		byte = *bp++;
+		result |= (byte & 0x7f) << shift;
+		if ((byte & 0x80) == 0) {
+			ok = 1;
+			break;
+		}
+		shift += 7;
+	}
+	if (!ok)
+		return -1;
+	*dpp = bp;
+	*val = result;
+	return 0;
+}
+
+/*
+ * Parse a single elf attribute.
+ */
+static int rv_parse_elf_attr_safe(unsigned char **dpp, unsigned char *p_end)
+{
+	unsigned char *p = *dpp;
+	unsigned char *str;
+	u32 tag, val, s_len;
+
+	if (decode_uleb128_safe(&p, &tag, p_end))
+		goto bad_attr;
+
+	switch (tag) {
+	case RV_ATTR_TAG_stack_align:
+		if (decode_uleb128_safe(&p, &val, p_end))
+			goto bad_attr;
+		rv_elf_attr_int(tag, val);
+		break;
+
+	case RV_ATTR_TAG_unaligned_access:
+		if (decode_uleb128_safe(&p, &val, p_end))
+			goto bad_attr;
+		rv_elf_attr_int(tag, val);
+		break;
+
+	case RV_ATTR_TAG_arch:
+		str = p;
+		s_len = strnlen(p, p_end - p) + 1;
+		p += s_len;
+		if (p > p_end)
+			goto bad_attr;
+		rv_elf_attr_str(tag, str);
+		break;
+
+	default:
+		if (decode_uleb128_safe(&p, &val, p_end))
+			goto bad_attr;
+		pr_debug("skipping Unrecognized Tag [%u]=%u\n", tag, val);
+		break;
+	}
+
+	*dpp = p;
+	return 0;
+bad_attr:
+	return -ENOEXEC;
+}
+
+/*
+ * Parse .riscv.attributes elf section.
+ */
+static int rv_parse_elf_attributes(struct file *f, const struct elf_phdr *phdr,
+				   struct arch_elf_state *state)
+{
+	unsigned char buf[RV_ATTR_SEC_SZ];
+	unsigned char *p, *p_end;
+	ssize_t n;
+	int ret = 0;
+	loff_t pos;
+
+	pr_debug("Section .riscv.attributes found\n");
+
+	/* Assume a reasonable size for now */
+	if (phdr->p_filesz > sizeof(buf))
+		goto bad_elf;
+
+	memset(buf, 0, RV_ATTR_SEC_SZ);
+	pos = phdr->p_offset;
+	n = kernel_read(f, &buf, phdr->p_filesz, &pos);
+
+	if (n < 0)
+		return -EIO;
+
+	p = buf;
+	p_end = p + n;
+
+	/* sanity check format-version */
+	if (*p++ != 'A')
+		goto bad_elf;
+
+	/*
+	 * elf attribute section organized as Vendor sub-sections(s)
+	 *   {sub-section length, vendor name, vendor data}
+	 * Vendor data organized as sub-subsection(s)
+	 *   {tag, sub-subsection length, attributes contents}
+	 * Attribute contents organized as
+	 *   {tag, value} pair(s).
+	 */
+	while ((p_end - p) >= 4) {
+		int sub_len, vname_len;
+
+		sub_len = get_unaligned_le32(p);
+		if (sub_len <= 4 || sub_len > n)
+			goto bad_elf;
+
+		p += 4;
+		sub_len -= 4;
+
+		/* Vendor name string */
+		vname_len = strnlen(p, sub_len) + 1;
+		if (vname_len > sub_len)
+			goto bad_elf;
+
+		/* skip non-mandatory sub-section for now */
+		if (strncmp(p, RV_ATTR_VENDOR_RISCV, sub_len)) {
+			p += sub_len;
+			continue;
+		}
+
+		p += vname_len;
+		sub_len -= vname_len;
+
+		/* Vendor data: sub-subsections(s) */
+		while (sub_len > 0) {
+			u32 tag, content_len;
+			unsigned char *sub_end, *sub_start = p;
+
+			if (decode_uleb128_safe(&p, &tag, p_end))
+				goto bad_elf;
+
+			if ((p_end - p) < 4)
+				goto bad_elf;
+
+			content_len = get_unaligned_le32(p);
+			if (content_len > sub_len)
+				goto bad_elf;
+
+			p += 4;
+			sub_len -= content_len;
+			sub_end = sub_start + content_len;
+
+			/* For now handle attributes relating to whole file */
+			if (tag != RV_ATTR_TAG_file) {
+				p = sub_end;
+				continue;
+			}
+
+			/* Attribute(s): tag:value pairs */
+			while (p < sub_end) {
+				ret = rv_parse_elf_attr_safe(&p, p_end);
+				if (ret)
+					goto bad_elf;
+			}
+		}
+	}
+
+	return ret;
+bad_elf:
+	return -ENOEXEC;
+}
+
+/*
+ * Hook invoked by generic elf loader to parse riscv specific elf segments.
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

