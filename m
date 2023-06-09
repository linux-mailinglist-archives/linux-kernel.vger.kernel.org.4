Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912577291A8
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239076AbjFIHsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237064AbjFIHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B805F30E3;
        Fri,  9 Jun 2023 00:47:37 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwLwpUzKyq6nNNTl3+k2cjBO3xBi59DowUTOWE4B3Ow=;
        b=QtFs65zeIzZNE3ZBY/p25QowAlBtYHphOEAeB59uFRX+i+/bKIoohPli0YKyPh6aXJIx5Q
        d23Mn/2GAO0gvj8RA1zSVElQTyJ/yfdoCNCw8oZYG1S/9d+VA15zWgNyrw/LBlo7suhIo+
        lttbTyFcRdsFndFK1Oaeg1KN2trM7zZ6kQLv/tux3yH/V02sjnYLRNndYjFh5WPkyOFEWU
        WakDgNeWJcxJc14KFzpCJbP26ACJ6zQ+nhCEoGcByJxroeaOIHjRufJgTdoNg5VQ6ONsln
        DyKYW1Y4KqHjGyUEVox+Q1nYuYfCqBX++qkRKp6CBCMRctMcvKI/BPGhW47z1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwLwpUzKyq6nNNTl3+k2cjBO3xBi59DowUTOWE4B3Ow=;
        b=WcOK/E3c/DV7oI03oW5W4aHaJLngE++Em+RZM2JuBJ/NIOmGXPpIfR3zM+X7RTPnrXx7C6
        NuppdjAvJSq5pmAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Get rid of reloc->type
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <d1c1f8da31e4f052a2478aea585fcf355cacc53a.1685464332.git.jpoimboe@kernel.org>
References: <d1c1f8da31e4f052a2478aea585fcf355cacc53a.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685037.404.16323541302922091525.tip-bot2@tip-bot2>
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

Commit-ID:     fcee899d2794319c9dbeb7b877b0c4ac92f5dd16
Gitweb:        https://git.kernel.org/tip/fcee899d2794319c9dbeb7b877b0c4ac92f5dd16
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:07 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:22 -07:00

objtool: Get rid of reloc->type

Get the type from the embedded GElf_Rel[a] struct.

Link: https://lore.kernel.org/r/d1c1f8da31e4f052a2478aea585fcf355cacc53a.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/decode.c     |  2 +-
 tools/objtool/arch/x86/special.c    |  4 ++--
 tools/objtool/check.c               | 11 ++++++-----
 tools/objtool/elf.c                 |  6 ++----
 tools/objtool/include/objtool/elf.h | 11 ++++++++++-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 9ef024f..ffb12e8 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -84,7 +84,7 @@ bool arch_pc_relative_reloc(struct reloc *reloc)
 	 * All relocation types where P (the address of the target)
 	 * is included in the computation.
 	 */
-	switch (reloc->type) {
+	switch (reloc_type(reloc)) {
 	case R_X86_64_PC8:
 	case R_X86_64_PC16:
 	case R_X86_64_PC32:
diff --git a/tools/objtool/arch/x86/special.c b/tools/objtool/arch/x86/special.c
index 7c97b73..1a54a24 100644
--- a/tools/objtool/arch/x86/special.c
+++ b/tools/objtool/arch/x86/special.c
@@ -108,7 +108,7 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	table_offset = text_reloc->addend;
 	table_sec = text_reloc->sym->sec;
 
-	if (text_reloc->type == R_X86_64_PC32)
+	if (reloc_type(text_reloc) == R_X86_64_PC32)
 		table_offset += 4;
 
 	/*
@@ -138,7 +138,7 @@ struct reloc *arch_find_switch_table(struct objtool_file *file,
 	 * indicates a rare GCC quirk/bug which can leave dead
 	 * code behind.
 	 */
-	if (text_reloc->type == R_X86_64_PC32)
+	if (reloc_type(text_reloc) == R_X86_64_PC32)
 		file->ignore_unreachables = true;
 
 	return rodata_reloc;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e06ffad..04b4152 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -958,7 +958,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		if (!reloc)
 			return -1;
 
-		reloc->type = addr_size == 8 ? R_ABS64 : R_ABS32;
+		set_reloc_type(reloc, addr_size == 8 ? R_ABS64 : R_ABS32);
 
 		idx++;
 	}
@@ -1354,7 +1354,7 @@ static void annotate_call_site(struct objtool_file *file,
 	 */
 	if (opts.hack_noinstr && insn->sec->noinstr && sym->profiling_func) {
 		if (reloc) {
-			reloc->type = R_NONE;
+			set_reloc_type(reloc, R_NONE);
 			elf_write_reloc(file->elf, reloc);
 		}
 
@@ -1383,7 +1383,7 @@ static void annotate_call_site(struct objtool_file *file,
 			WARN_INSN(insn, "tail call to __fentry__ !?!?");
 		if (opts.mnop) {
 			if (reloc) {
-				reloc->type = R_NONE;
+				set_reloc_type(reloc, R_NONE);
 				elf_write_reloc(file->elf, reloc);
 			}
 
@@ -1865,7 +1865,7 @@ static int handle_jump_alt(struct objtool_file *file,
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
 		if (reloc) {
-			reloc->type = R_NONE;
+			set_reloc_type(reloc, R_NONE);
 			elf_write_reloc(file->elf, reloc);
 		}
 		elf_write_insn(file->elf, orig_insn->sec,
@@ -4277,7 +4277,8 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 			continue;
 
 		off = reloc->sym->offset;
-		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+		if (reloc_type(reloc) == R_X86_64_PC32 ||
+		    reloc_type(reloc) == R_X86_64_PLT32)
 			off += arch_dest_reloc_offset(reloc->addend);
 		else
 			off += reloc->addend;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 2b45460..be9d24d 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -541,6 +541,7 @@ static int elf_update_sym_relocs(struct elf *elf, struct symbol *sym)
 	struct reloc *reloc;
 
 	list_for_each_entry(reloc, &sym->reloc_list, sym_reloc_entry) {
+		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc_type(reloc));
 		if (elf_write_reloc(elf, reloc))
 			return -1;
 	}
@@ -831,11 +832,11 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 	}
 
 	reloc->sec = rsec;
-	reloc->type = type;
 	reloc->sym = sym;
 	reloc->addend = addend;
 
 	reloc->rel.r_offset = offset;
+	reloc->rel.r_info = GELF_R_INFO(sym->idx, type);
 
 	if (elf_write_reloc(elf, reloc))
 		return NULL;
@@ -910,7 +911,6 @@ static int read_reloc(struct section *rsec, int i, struct reloc *reloc)
 		return -1;
 	}
 
-	reloc->type = GELF_R_TYPE(reloc->rel.r_info);
 	reloc->addend = rela ? reloc->rela.r_addend : 0;
 
 	return 0;
@@ -1231,8 +1231,6 @@ int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 	struct section *rsec = reloc->sec;
 	int ret;
 
-	reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-
 	if (rsec->sh.sh_type == SHT_RELA) {
 		reloc->rela.r_addend = reloc->addend;
 		ret = gelf_update_rela(rsec->data, reloc_idx(reloc), &reloc->rela);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 2070860..41d2149 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -76,7 +76,6 @@ struct reloc {
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
 	s64 addend;
-	unsigned int type;
 	bool jump_table_start;
 };
 
@@ -208,6 +207,16 @@ static inline unsigned long reloc_offset(struct reloc *reloc)
 	return reloc->rel.r_offset;
 }
 
+static inline unsigned int reloc_type(struct reloc *reloc)
+{
+	return GELF_R_TYPE(reloc->rel.r_info);
+}
+
+static inline void set_reloc_type(struct reloc *reloc, int type)
+{
+	reloc->rel.r_info = GELF_R_INFO(GELF_R_SYM(reloc->rel.r_info), type);
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
