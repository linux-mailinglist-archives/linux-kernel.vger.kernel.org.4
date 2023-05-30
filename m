Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4EF716AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjE3RVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:21:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjE3RVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A0BB2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DDB18630F9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C719C4339C;
        Tue, 30 May 2023 17:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467292;
        bh=f0Zkn5jXIKjGAYlwWWUPP5ioQ2KYARa2dNntzf0AIO0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OxnUPmimkmalR7CDQ193rpnYzskhU71pNu8Ny++TNm7eT6EqNSDLRfiYNd9Mj0ylC
         I6sBD8RFM5j3uqSR4FV+i/usidJaTzssrGZIeEvu37HTTyEGWTLmv0NxtgVHuH7xw4
         HRCPIm1fpqe9okZaLaSNpRhI9t5K8+LZ7vzttJdBU2swXxPUM3gS+9qSoy0ssUsZnf
         5xPA19iWudGVHk0kWFyt3dU/W4RZprl8YqoN/SkPdL66wOab2dzTieX/6hkJQgiEh7
         NOx0iz0j75lIo63SgJTdjfyBCnJSAGkNaY3MDsWATHcpsqdgnolYZgqgWjG4Wd3taA
         16F0RUzzrQ3PQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 01/22] objtool: Tidy elf.h
Date:   Tue, 30 May 2023 10:20:53 -0700
Message-Id: <b1490ed85951868219a6ece177a7cd30a6454d66.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorganize elf.h a bit:

- Move the prototypes higher up so they can be used by the inline
  functions.

- Move hash-related code to the bottom.

- Remove the unused ELF_HASH_BITS macro.

No functional changes.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/elf.h | 96 ++++++++++++++---------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 78e2d0fc21ca..b24f83e7ca34 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -83,8 +83,6 @@ struct reloc {
 	bool jump_table_start;
 };
 
-#define ELF_HASH_BITS	20
-
 struct elf {
 	Elf *elf;
 	GElf_Ehdr ehdr;
@@ -110,53 +108,6 @@ struct elf {
 	struct symbol *symbol_data;
 };
 
-#define OFFSET_STRIDE_BITS	4
-#define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
-#define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
-
-#define for_offset_range(_offset, _start, _end)			\
-	for (_offset = ((_start) & OFFSET_STRIDE_MASK);		\
-	     _offset >= ((_start) & OFFSET_STRIDE_MASK) &&	\
-	     _offset <= ((_end) & OFFSET_STRIDE_MASK);		\
-	     _offset += OFFSET_STRIDE)
-
-static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
-{
-	u32 ol, oh, idx = sec->idx;
-
-	offset &= OFFSET_STRIDE_MASK;
-
-	ol = offset;
-	oh = (offset >> 16) >> 16;
-
-	__jhash_mix(ol, oh, idx);
-
-	return ol;
-}
-
-static inline u32 reloc_hash(struct reloc *reloc)
-{
-	return sec_offset_hash(reloc->sec, reloc->offset);
-}
-
-/*
- * Try to see if it's a whole archive (vmlinux.o or module).
- *
- * Note this will miss the case where a module only has one source file.
- */
-static inline bool has_multiple_files(struct elf *elf)
-{
-	return elf->num_files > 1;
-}
-
-static inline int elf_class_addrsize(struct elf *elf)
-{
-	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
-		return sizeof(u32);
-	else
-		return sizeof(u64);
-}
-
 struct elf *elf_open_read(const char *name, int flags);
 struct section *elf_create_section(struct elf *elf, const char *name, unsigned int sh_flags, size_t entsize, int nr);
 
@@ -186,6 +137,24 @@ struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *se
 				     unsigned long offset, unsigned int len);
 struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 
+/*
+ * Try to see if it's a whole archive (vmlinux.o or module).
+ *
+ * Note this will miss the case where a module only has one source file.
+ */
+static inline bool has_multiple_files(struct elf *elf)
+{
+	return elf->num_files > 1;
+}
+
+static inline int elf_class_addrsize(struct elf *elf)
+{
+	if (elf->ehdr.e_ident[EI_CLASS] == ELFCLASS32)
+		return sizeof(u32);
+	else
+		return sizeof(u64);
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
@@ -198,4 +167,33 @@ struct symbol *find_func_containing(struct section *sec, unsigned long offset);
 		for_each_sec(file, __sec)				\
 			sec_for_each_sym(__sec, sym)
 
+#define OFFSET_STRIDE_BITS	4
+#define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
+#define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
+
+#define for_offset_range(_offset, _start, _end)			\
+	for (_offset = ((_start) & OFFSET_STRIDE_MASK);		\
+	     _offset >= ((_start) & OFFSET_STRIDE_MASK) &&	\
+	     _offset <= ((_end) & OFFSET_STRIDE_MASK);		\
+	     _offset += OFFSET_STRIDE)
+
+static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
+{
+	u32 ol, oh, idx = sec->idx;
+
+	offset &= OFFSET_STRIDE_MASK;
+
+	ol = offset;
+	oh = (offset >> 16) >> 16;
+
+	__jhash_mix(ol, oh, idx);
+
+	return ol;
+}
+
+static inline u32 reloc_hash(struct reloc *reloc)
+{
+	return sec_offset_hash(reloc->sec, reloc->offset);
+}
+
 #endif /* _OBJTOOL_ELF_H */
-- 
2.40.1

