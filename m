Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3648674645
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 23:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjASWiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 17:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjASWhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 17:37:00 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D645B1EF5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:18:37 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id k13so3715691plg.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 14:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YsEdBrnw8zv1WxOe57aMagHA1fKjs6sNS2NjosWdfFQ=;
        b=B2NdqkujJqlDIO723PRvDabnr6cpc1OZ/iqkknchwf5q3JQpQDddqf3qQX2vcWgV8Q
         7Xf7jSOk2vnIbHl1NBVXNen8dJDdM/Ks7gurYZYSniofoeC8RI+dv5LqZbXIaqR5avMs
         /TPL63LyCGHUFNhDMpYB2CBdO1Fpk/Kr91O1Kn94u3lZTim/1gdCEItaaTHVJrWZaxsv
         A57bR+Oum3I5RHNGBkKhncfgHfbWrST/Es4JiJlVSsTJgoW/XUcjVZi/AshEkXRLQFNw
         bq07VkTMqpYwaRHzkdUbc6NWkOZi0U1DnbfT5H8B6Mcxwhxa6oxp8Ca95SzawwiUctEp
         ggjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YsEdBrnw8zv1WxOe57aMagHA1fKjs6sNS2NjosWdfFQ=;
        b=ZZNC9Y3bGOU+NgQ4g5VGgoCvCApcGIQBNfZ+k0p2Lnb0xoOSTczNIPIuv6ZcwWSCa5
         pOJWQbpBI3/svmwnj7Z0/iKcCQ9Nmxyt9LmcA0DwsJRoGQi+FjzdkCH/cG6SX+3nEFQd
         T6FXHLnQS2gWa0tKRUNOHKyn4X9kjv7p5UNeH6dZP6WIE6K70nJDmlIfj+bWtwSEO0CN
         qOkFRzgkVPChzYurxr1EmdkOJfQlQb10UuLRTj937d63FSDU0myeQOe7sEJ7I1g06bJm
         PjdYtmDTUFZZAquZy7WZvQLEhpPTQo9qSjHTndF4j9l8auaaqC/eGVgkl9pVc7q1cAKh
         TCXw==
X-Gm-Message-State: AFqh2krJ68pdZY32AHY/8Vs8JtUZ8RfutBI8dKgMNOQAKxpq53uLHT7Q
        +oqAmi2Fixe/nJZx04zMIK60ew==
X-Google-Smtp-Source: AMrXdXtC8J4Wgo0OEX0QMSLV9liCSNVuXn9aZJsWFGfOfKOcGFMmRJrnH2SQ6dfQ90jSfb8oBinU2g==
X-Received: by 2002:a05:6a20:8ba5:b0:b8:93b8:ee2f with SMTP id m37-20020a056a208ba500b000b893b8ee2fmr11692479pzh.45.1674166716555;
        Thu, 19 Jan 2023 14:18:36 -0800 (PST)
Received: from vineet-framework.ba.rivosinc.com ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id w29-20020a63af1d000000b00477bfac06b7sm2850502pge.34.2023.01.19.14.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 14:18:36 -0800 (PST)
From:   Vineet Gupta <vineetg@rivosinc.com>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, palmer@rivosinc.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>, Guo Ren <guoren@kernel.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>, linux@rivosinc.com,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH v4] riscv: elf: add .riscv.attributes parsing
Date:   Thu, 19 Jan 2023 14:18:33 -0800
Message-Id: <20230119221833.3629409-1-vineetg@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <67c50e8d-ae78-076d-cf25-b7781f2209d7@rivosinc.com>
References: <67c50e8d-ae78-076d-cf25-b7781f2209d7@rivosinc.com>
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
Changes since v3 [3]
  - Address more review comments from Jessica.
    Specifically handle unknown tags better knowing they can only be
    int/string.

Changes since v2 [2]
  - Address Jessica's review comments.
    Mostly robustify code some more, checking for end of buffer etc.

Changes since v1 [1]
  - Handling potential oob accesses against malformed elf contents.
  - Handling of multiple sub-subsections

[1]https://lore.kernel.org/linux-riscv/20230110201841.2069353-1-vineetg@rivosinc.com
[2]https://lore.kernel.org/linux-riscv/20230112210622.2337254-1-vineetg@rivosinc.com
[3]https://lore.kernel.org/linux-riscv/20230119174357.3550008-1-vineetg@rivosinc.com

Given the current state of discussions, the intended Vector extension
support would likely not need it, still posting the reworked code for
logical conclusion and for posterity in case need comes up in future
for something like CFI elf annotation.
Maintainers/reviewers can decide whether to merge it.
---
 arch/riscv/Kconfig           |   1 +
 arch/riscv/include/asm/elf.h |  11 ++
 arch/riscv/kernel/Makefile   |   1 +
 arch/riscv/kernel/elf-attr.c | 225 +++++++++++++++++++++++++++++++++++
 4 files changed, 238 insertions(+)
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
index 000000000000..ac5df800516e
--- /dev/null
+++ b/arch/riscv/kernel/elf-attr.c
@@ -0,0 +1,225 @@
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
+static void rv_elf_attr_int(u64 tag, u64 val)
+{
+	if (tag == RV_ATTR_TAG_stack_align ||
+	    tag == RV_ATTR_TAG_unaligned_access)
+		pr_debug("Tag %llx=%llx\n", tag, val);
+	else
+		pr_debug("Unrecognized int Tag [%llx]=%llx\n", tag, val);
+}
+
+static void rv_elf_attr_str(u64 tag, const unsigned char *str)
+{
+	if (tag == RV_ATTR_TAG_arch)
+		pr_debug("Tag %llx=[%s]\n", tag, str);
+	else
+		pr_debug("Unrecognized string Tag [%llx]=[%s]\n", tag, str);
+}
+
+/*
+ * Decode a ule128 encoded value.
+ */
+static int
+decode_uleb128_safe(unsigned char **dpp, u64 *val, const unsigned char *p_end)
+{
+	unsigned char *bp = *dpp;
+	unsigned char byte;
+	unsigned int shift = 0;
+	u64 result = 0;
+
+	while (bp < p_end) {
+		byte = *bp++;
+		result |= (byte & 0x7f) << shift;
+		if ((byte & 0x80) == 0) {
+			*dpp = bp;
+			*val = result;
+			return 0;
+		}
+		shift += 7;
+	}
+
+	return -1;
+}
+
+/*
+ * Parse a single elf attribute.
+ */
+static int rv_parse_elf_attr_safe(unsigned char **dpp, unsigned char *p_end)
+{
+	unsigned char *p = *dpp;
+	unsigned char *str;
+	u64 tag, val;
+
+	if (decode_uleb128_safe(&p, &tag, p_end))
+		goto bad_attr;
+
+	if (tag % 2) {
+		u32 s_len;
+
+		str = p;
+		s_len = strnlen(p, p_end - p) + 1;
+		if ((p + s_len) > p_end)
+			goto bad_attr;
+		p += s_len;
+		rv_elf_attr_str(tag, str);
+	} else {
+		if (decode_uleb128_safe(&p, &val, p_end))
+			goto bad_attr;
+		rv_elf_attr_int(tag, val);
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
+		return n;
+	else if (n == 0)
+		return -ENOEXEC;
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
+		u32 sub_len, vname_len;
+
+		sub_len = get_unaligned_le32(p);
+		if (sub_len <= 4 || sub_len > (p_end - p))
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
+			unsigned char *p_ss_end, *p_ss_start = p;
+			u32 ss_len;
+			u64 tag;
+
+			if (decode_uleb128_safe(&p, &tag, p_end))
+				goto bad_elf;
+
+			if ((p_end - p) < 4)
+				goto bad_elf;
+
+			ss_len = get_unaligned_le32(p);
+			if (ss_len > sub_len)
+				goto bad_elf;
+
+			p += 4;
+			sub_len -= ss_len;
+			p_ss_end = p_ss_start + ss_len;
+
+			/* For now handle attributes relating to whole file */
+			if (tag != RV_ATTR_TAG_file) {
+				p = p_ss_end;
+				continue;
+			}
+
+			/* Attribute(s): tag:value pairs */
+			while (p < p_ss_end) {
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
+	if (phdr->p_type == PT_RISCV_ATTRIBUTES)
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

