Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5917291B6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbjFIHtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239117AbjFIHrq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A05B2D7F;
        Fri,  9 Jun 2023 00:47:43 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9P87doE6Z0HH3lUedPUa2tyR5oQm9EuwPpj3rRLBwbI=;
        b=KlKjnLkTGiNJn0Mnutx3SqgB1I0XrhaDHa9brf2j6U24v46bO0V2lfSyjJRvTqjDm9ZHDX
        75fYUiDor5HavPUqh9mMBn9SjfMIS0BL+X4UH7JkOZkP3rFHymPJ1ZuWAh8Z2NuAtB1iKd
        /69Hxw4HCUi+Y9yPpB5FW9jj185BSySqCWG/T7oZRSXYisAy10zOVWGbbCs6i/Dk8yDA82
        kcDVhZqbmh2eFEHTZztfs0LgTKl5onG12a0L1GuYRh5r3u1wwlYIG7coTKjuwx0TQ/YArm
        4QlvaIQVRenQgE1+bP+Cl/HMRd93dLkh3+UVDwkQSrX2zj5AAcRzK6uYhA9wwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296859;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9P87doE6Z0HH3lUedPUa2tyR5oQm9EuwPpj3rRLBwbI=;
        b=Y2CRn8IEwyUA1qprseFGMQb2DMHoqIIHfhUyaNm9y9t192bnqrwmDJCq5C8RWjsR1mUho+
        7MoK7asZaqqEi7CQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Tidy elf.h
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <b1490ed85951868219a6ece177a7cd30a6454d66.1685464332.git.jpoimboe@kernel.org>
References: <b1490ed85951868219a6ece177a7cd30a6454d66.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685929.404.5936123077928755991.tip-bot2@tip-bot2>
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

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     809373e17b2649948cc681dd1962b2736b22c7a6
Gitweb:        https://git.kernel.org/tip/809373e17b2649948cc681dd1962b2736b22c7a6
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:20:53 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:13 -07:00

objtool: Tidy elf.h

Reorganize elf.h a bit:

- Move the prototypes higher up so they can be used by the inline
  functions.

- Move hash-related code to the bottom.

- Remove the unused ELF_HASH_BITS macro.

No functional changes.

Link: https://lore.kernel.org/r/b1490ed85951868219a6ece177a7cd30a6454d66.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/include/objtool/elf.h | 96 +++++++++++++---------------
 1 file changed, 47 insertions(+), 49 deletions(-)

diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 78e2d0f..b24f83e 100644
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
