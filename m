Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58265716AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbjE3RWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjE3RVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4899AF9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC3186313A
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C8EC433D2;
        Tue, 30 May 2023 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467297;
        bh=X33W17ZC/Rt3EvD2X+9vvXrqdrMNzh7cjLu7YmfFviY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=std+JsFZ2uczdRX0lNXPswXLmLYXVh447/2/kJ68S1HlEdoEvI2MbV3tFN+/Sx9PS
         v75+bPFHQY35tESdH+JBSkZuvNTzW0vik54/xrAOQLoehSNfWznRWQ6OKQDaZuGGeQ
         11UAX7zpio69+XGVJVqH4Oqhpwi1f2kfSYiOODITR+ylPVx0xdfkaNx8EuF99R6MKl
         LbqeLqd2cxiZTbv7+ttB1nrt1c/KtT84H4xmcImfg+P7i1OOScjbPKH6F3JLhTXeXV
         v4eaX+vxaV/l6PrrdFLwyafc2mNTjNrC/2v7CizlhdYPZMA48pfFmyZDGQ5mym9krb
         SXcSNfALHMmYA==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 15/22] objtool: Get rid of reloc->type
Date:   Tue, 30 May 2023 10:21:07 -0700
Message-Id: <d1c1f8da31e4f052a2478aea585fcf355cacc53a.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get the type from the embedded GElf_Rel[a] struct.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/arch/x86/decode.c     |  2 +-
 tools/objtool/arch/x86/special.c    |  4 ++--
 tools/objtool/check.c               | 11 ++++++-----
 tools/objtool/elf.c                 |  6 ++----
 tools/objtool/include/objtool/elf.h | 11 ++++++++++-
 5 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index 9ef024fd648c..ffb12e83b238 100644
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
index 7c97b7391279..1a54a249cb50 100644
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
index 440c326121d4..1d794d15bc53 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -957,7 +957,7 @@ static int create_mcount_loc_sections(struct objtool_file *file)
 		if (!reloc)
 			return -1;
 
-		reloc->type = addr_size == 8 ? R_ABS64 : R_ABS32;
+		set_reloc_type(reloc, addr_size == 8 ? R_ABS64 : R_ABS32);
 
 		idx++;
 	}
@@ -1353,7 +1353,7 @@ static void annotate_call_site(struct objtool_file *file,
 	 */
 	if (opts.hack_noinstr && insn->sec->noinstr && sym->profiling_func) {
 		if (reloc) {
-			reloc->type = R_NONE;
+			set_reloc_type(reloc, R_NONE);
 			elf_write_reloc(file->elf, reloc);
 		}
 
@@ -1382,7 +1382,7 @@ static void annotate_call_site(struct objtool_file *file,
 			WARN_INSN(insn, "tail call to __fentry__ !?!?");
 		if (opts.mnop) {
 			if (reloc) {
-				reloc->type = R_NONE;
+				set_reloc_type(reloc, R_NONE);
 				elf_write_reloc(file->elf, reloc);
 			}
 
@@ -1864,7 +1864,7 @@ static int handle_jump_alt(struct objtool_file *file,
 		struct reloc *reloc = insn_reloc(file, orig_insn);
 
 		if (reloc) {
-			reloc->type = R_NONE;
+			set_reloc_type(reloc, R_NONE);
 			elf_write_reloc(file->elf, reloc);
 		}
 		elf_write_insn(file->elf, orig_insn->sec,
@@ -4268,7 +4268,8 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 			continue;
 
 		off = reloc->sym->offset;
-		if (reloc->type == R_X86_64_PC32 || reloc->type == R_X86_64_PLT32)
+		if (reloc_type(reloc) == R_X86_64_PC32 ||
+		    reloc_type(reloc) == R_X86_64_PLT32)
 			off += arch_dest_reloc_offset(reloc->addend);
 		else
 			off += reloc->addend;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 2b45460225d1..be9d24dcdf56 100644
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
index 2070860a099e..41d2149f8bb8 100644
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
 
-- 
2.40.1

