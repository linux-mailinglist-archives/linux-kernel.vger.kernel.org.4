Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544A06AE1C0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 15:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCGOIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 09:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjCGOIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 09:08:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A0185A59
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 06:07:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 561ECB818FF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 14:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070B6C433A0;
        Tue,  7 Mar 2023 14:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678198032;
        bh=nNddimpTffzJ/299GfOhbDILTTlvYfXW/l3wr38dpy8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwXKEabQb8M2BefvBIsC4AI8Fjk7zHxQXNXYj13EaS45Mj1GQ67so+tc7gpAHNd39
         rUeO7Tf4aBgEBdK6HkyLODroiH9+6yI6/uZtMmawwIcNTR12YWaxzMnbfZDAPehRwY
         FFcvRAbpP3g54gws/uNopwlmXhefzh2EKlyuxAD3kKgnJUt1D64MqcIHVo1r2T9fUh
         /bomFTiKRw2Z1tTaeeJe1INmpfFH1dzScPXOSGV/VEYOwUV4KptGqRjrdX+ig6QtoF
         nErqQTKfXjdUNLHU0KfRnnTpGIVFgZwoJFITWt33Opv2NG8WynMIrB5CMsy1UfQnpb
         j4xone8w9rQUg==
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 14/60] arm64: kernel: Manage absolute relocations in code built under pi/
Date:   Tue,  7 Mar 2023 15:04:36 +0100
Message-Id: <20230307140522.2311461-15-ardb@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307140522.2311461-1-ardb@kernel.org>
References: <20230307140522.2311461-1-ardb@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6466; i=ardb@kernel.org; h=from:subject; bh=nNddimpTffzJ/299GfOhbDILTTlvYfXW/l3wr38dpy8=; b=owGbwMvMwCFmkMcZplerG8N4Wi2JIYXdReZQhTsr07KvW7jVP1Zx7z8hpdYwkTF+guvSadfXl vEddnPtKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABPJ0Gb4Z+fMoLZd1yeoZ/OU 8h7Zt/KzXz4RTGc+/W3x+3kLnZXX7mb47/Zwkanv2Wk/Xbq1HzwNOfPhBXfV23Us7sa7p3OeV3C fyQIA
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The mini C runtime runs before relocations are processed, and so it
cannot rely on statically initialized pointer variables.

Add a check to ensure that such code does not get introduced by
accident, by going over the relocations in each object, identifying the
ones that operate on data sections that are part of the executable
image, and raising an error if any relocations of type R_AARCH64_ABS64
exist. Note that such relocations are permitted in other places (e.g.,
debug sections) and will never occur in compiler generated code sections
when using the small code model, so only check sections that have
SHF_ALLOC set and SHF_EXECINSTR cleared.

To accommodate cases where statically initialized symbol references are
unavoidable, introduce a special case for ELF input data sections that
have ".rodata.prel64" in their names, and in these cases, instead of
rejecting any encountered ABS64 relocations, convert them into PREL64
relocations, which don't require any runtime fixups. Note that the code
in question must still be modified to deal with this, as it needs to
convert the 64-bit signed offsets into absolute addresses before use.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm64/kernel/pi/Makefile    |   9 +-
 arch/arm64/kernel/pi/pi.h        |  14 +++
 arch/arm64/kernel/pi/relacheck.c | 130 ++++++++++++++++++++
 3 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/pi/Makefile b/arch/arm64/kernel/pi/Makefile
index c844a0546d7f0e62..bc32a431fe35e6f4 100644
--- a/arch/arm64/kernel/pi/Makefile
+++ b/arch/arm64/kernel/pi/Makefile
@@ -22,11 +22,16 @@ KCSAN_SANITIZE	:= n
 UBSAN_SANITIZE	:= n
 KCOV_INSTRUMENT	:= n
 
+hostprogs	:= relacheck
+
+quiet_cmd_piobjcopy = $(quiet_cmd_objcopy)
+      cmd_piobjcopy = $(cmd_objcopy) && $(obj)/relacheck $(@) $(<)
+
 $(obj)/%.pi.o: OBJCOPYFLAGS := --prefix-symbols=__pi_ \
 			       --remove-section=.note.gnu.property \
 			       --prefix-alloc-sections=.init
-$(obj)/%.pi.o: $(obj)/%.o FORCE
-	$(call if_changed,objcopy)
+$(obj)/%.pi.o: $(obj)/%.o $(obj)/relacheck FORCE
+	$(call if_changed,piobjcopy)
 
 $(obj)/lib-%.o: $(srctree)/lib/%.c FORCE
 	$(call if_changed_rule,cc_o_c)
diff --git a/arch/arm64/kernel/pi/pi.h b/arch/arm64/kernel/pi/pi.h
new file mode 100644
index 0000000000000000..f455ad385976a664
--- /dev/null
+++ b/arch/arm64/kernel/pi/pi.h
@@ -0,0 +1,14 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright 2023 Google LLC
+// Author: Ard Biesheuvel <ardb@google.com>
+
+#define __prel64_initconst	__section(".init.rodata.prel64")
+
+typedef volatile signed long prel64_t;
+
+static inline void *prel64_to_pointer(const prel64_t *offset)
+{
+	if (!*offset)
+		return NULL;
+	return (void *)offset + *offset;
+}
diff --git a/arch/arm64/kernel/pi/relacheck.c b/arch/arm64/kernel/pi/relacheck.c
new file mode 100644
index 0000000000000000..29310c632e9312e7
--- /dev/null
+++ b/arch/arm64/kernel/pi/relacheck.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 - Google LLC
+ * Author: Ard Biesheuvel <ardb@google.com>
+ */
+
+#include <elf.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+#define HOST_ORDER ELFDATA2LSB
+#elif __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__
+#define HOST_ORDER ELFDATA2MSB
+#endif
+
+static Elf64_Ehdr *ehdr;
+static Elf64_Shdr *shdr;
+static const char *strtab;
+static bool swap;
+
+static uint64_t swab_elfxword(uint64_t val)
+{
+	return swap ? __builtin_bswap64(val) : val;
+}
+
+static uint32_t swab_elfword(uint32_t val)
+{
+	return swap ? __builtin_bswap32(val) : val;
+}
+
+static uint16_t swab_elfhword(uint16_t val)
+{
+	return swap ? __builtin_bswap16(val) : val;
+}
+
+int main(int argc, char *argv[])
+{
+	struct stat stat;
+	int fd, ret;
+
+	if (argc < 3) {
+		fprintf(stderr, "file arguments missing\n");
+		exit(EXIT_FAILURE);
+	}
+
+	fd = open(argv[1], O_RDWR);
+	if (fd < 0) {
+		fprintf(stderr, "failed to open %s\n", argv[1]);
+		exit(EXIT_FAILURE);
+	}
+
+	ret = fstat(fd, &stat);
+	if (ret < 0) {
+		fprintf(stderr, "failed to stat() %s\n", argv[1]);
+		exit(EXIT_FAILURE);
+	}
+
+	ehdr = mmap(0, stat.st_size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
+	if (ehdr == MAP_FAILED) {
+		fprintf(stderr, "failed to mmap() %s\n", argv[1]);
+		exit(EXIT_FAILURE);
+	}
+
+	swap = ehdr->e_ident[EI_DATA] != HOST_ORDER;
+	shdr = (void *)ehdr + swab_elfxword(ehdr->e_shoff);
+	strtab = (void *)ehdr +
+		 swab_elfxword(shdr[swab_elfhword(ehdr->e_shstrndx)].sh_offset);
+
+	for (int i = 0; i < swab_elfhword(ehdr->e_shnum); i++) {
+		unsigned long info, flags;
+		bool prel64 = false;
+		Elf64_Rela *rela;
+		int numrela;
+
+		if (swab_elfword(shdr[i].sh_type) != SHT_RELA)
+			continue;
+
+		/* only consider RELA sections operating on data */
+		info = swab_elfword(shdr[i].sh_info);
+		flags = swab_elfxword(shdr[info].sh_flags);
+		if ((flags & (SHF_ALLOC | SHF_EXECINSTR)) != SHF_ALLOC)
+			continue;
+
+		/*
+		 * We generally don't permit ABS64 relocations in the code that
+		 * runs before relocation processing occurs. If statically
+		 * initialized absolute symbol references are unavoidable, they
+		 * may be emitted into a *.rodata.prel64 section and they will
+		 * be converted to place-relative 64-bit references. This
+		 * requires special handling in the referring code.
+		 */
+		if (strstr(strtab + swab_elfword(shdr[info].sh_name),
+			   ".rodata.prel64")) {
+			prel64 = true;
+		}
+
+		rela = (void *)ehdr + swab_elfxword(shdr[i].sh_offset);
+		numrela = swab_elfxword(shdr[i].sh_size) / sizeof(*rela);
+
+		for (int j = 0; j < numrela; j++) {
+			uint64_t info = swab_elfxword(rela[j].r_info);
+
+			if (ELF64_R_TYPE(info) != R_AARCH64_ABS64)
+				continue;
+
+			if (prel64) {
+				/* convert ABS64 into PREL64 */
+				info ^= R_AARCH64_ABS64 ^ R_AARCH64_PREL64;
+				rela[j].r_info = swab_elfxword(info);
+			} else {
+				fprintf(stderr,
+					"Unexpected absolute relocations detected in %s\n",
+					argv[2]);
+				close(fd);
+				unlink(argv[1]);
+				exit(EXIT_FAILURE);
+			}
+		}
+	}
+	close(fd);
+	return 0;
+}
-- 
2.39.2

