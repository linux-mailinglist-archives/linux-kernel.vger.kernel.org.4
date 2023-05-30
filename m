Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D341716AC3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjE3RWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbjE3RVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2F398
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A83E63135
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4455C4339B;
        Tue, 30 May 2023 17:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467296;
        bh=9ZwKWAhUoEay6Gr+X0+W5r9EsaeSEGXdmDt4xMDFxig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uOp3p6KQSqRlUXTu0MO4j7jwG+tr59MrcAb6UNI7EASTcyL1slOqos+h3GT+i8rsA
         z98k0FK2n7YqPSjWTaME0/X1wIFB0MzPMqcrmxzehqovSUdJ5juEsupsfwDf41wWo0
         n5jH8AGZ6F06BhZ5ZfxSiA1AKs8PKvT+NwkzMXdXGooU26T4AOdrL5Wf3MaIk2vw/X
         SdMEJibAB6X2Zj8Ld/0+yMyLdIjFupW91skSdRfAOBktfJz1yZTNU6ALcqI8wAgGpM
         pQCSqQeqpNADUGiZN4/S25W9bGQth9ff6pXUMzPfUGVrN9QDyEKNd7SknO+dfxCS/i
         GnWLaBABh6dXw==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 14/22] objtool: Get rid of reloc->offset
Date:   Tue, 30 May 2023 10:21:06 -0700
Message-Id: <2b9ec01178baa346a99522710bf2e82159412e3a.1685464332.git.jpoimboe@kernel.org>
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

Get the offset from the embedded GElf_Rel[a] struct.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 43.83G
- After:  peak heap memory consumption: 42.10G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 14 +++++++-------
 tools/objtool/elf.c                 | 10 +++++-----
 tools/objtool/include/objtool/elf.h |  8 ++++++--
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 1355e6fec7d6..440c326121d4 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -510,11 +510,11 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
 		if (func->type == STT_SECTION)
 			func = find_symbol_by_offset(reloc->sym->sec, reloc->addend);
 
-		idx = (reloc->offset - sym->offset) / sizeof(unsigned long);
+		idx = (reloc_offset(reloc) - sym->offset) / sizeof(unsigned long);
 
 		objtool_pv_add(file, idx, func);
 
-		off = reloc->offset + 1;
+		off = reloc_offset(reloc) + 1;
 		if (off > end)
 			break;
 	}
@@ -1997,7 +1997,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			break;
 
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && reloc->offset != prev_offset + 8)
+		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
 			break;
 
 		/* Detect function pointers from contiguous objects: */
@@ -2022,7 +2022,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		alt->insn = dest_insn;
 		alt->next = insn->alts;
 		insn->alts = alt;
-		prev_offset = reloc->offset;
+		prev_offset = reloc_offset(reloc);
 	}
 
 	if (!prev_offset) {
@@ -4257,8 +4257,8 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 	for (reloc = insn_reloc(file, insn);
 	     reloc;
 	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					      reloc->offset + 1,
-					      (insn->offset + insn->len) - (reloc->offset + 1))) {
+					      reloc_offset(reloc) + 1,
+					      (insn->offset + insn->len) - (reloc_offset(reloc) + 1))) {
 
 		/*
 		 * static_call_update() references the trampoline, which
@@ -4341,7 +4341,7 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
 		return 0;
 
 	WARN_FUNC("data relocation to !ENDBR: %s",
-		  reloc->sec->base, reloc->offset,
+		  reloc->sec->base, reloc_offset(reloc),
 		  offstr(dest->sec, dest->offset));
 
 	return 1;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 70c801254566..2b45460225d1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -246,8 +246,9 @@ struct reloc *find_reloc_by_dest_range(const struct elf *elf, struct section *se
 			if (reloc->sec != rsec)
 				continue;
 
-			if (reloc->offset >= offset && reloc->offset < offset + len) {
-				if (!r || reloc->offset < r->offset)
+			if (reloc_offset(reloc) >= offset &&
+			    reloc_offset(reloc) < offset + len) {
+				if (!r || reloc_offset(reloc) < reloc_offset(r))
 					r = reloc;
 			}
 		}
@@ -830,11 +831,12 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 	}
 
 	reloc->sec = rsec;
-	reloc->offset = offset;
 	reloc->type = type;
 	reloc->sym = sym;
 	reloc->addend = addend;
 
+	reloc->rel.r_offset = offset;
+
 	if (elf_write_reloc(elf, reloc))
 		return NULL;
 
@@ -908,7 +910,6 @@ static int read_reloc(struct section *rsec, int i, struct reloc *reloc)
 		return -1;
 	}
 
-	reloc->offset = reloc->rel.r_offset;
 	reloc->type = GELF_R_TYPE(reloc->rel.r_info);
 	reloc->addend = rela ? reloc->rela.r_addend : 0;
 
@@ -1230,7 +1231,6 @@ int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 	struct section *rsec = reloc->sec;
 	int ret;
 
-	reloc->rel.r_offset = reloc->offset;
 	reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
 
 	if (rsec->sh.sh_type == SHT_RELA) {
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 2a14da633d56..2070860a099e 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -75,7 +75,6 @@ struct reloc {
 	struct section *sec;
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
-	unsigned long offset;
 	s64 addend;
 	unsigned int type;
 	bool jump_table_start;
@@ -204,6 +203,11 @@ static inline unsigned int reloc_idx(struct reloc *reloc)
 	return reloc - reloc->sec->relocs;
 }
 
+static inline unsigned long reloc_offset(struct reloc *reloc)
+{
+	return reloc->rel.r_offset;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
@@ -253,7 +257,7 @@ static inline u32 sec_offset_hash(struct section *sec, unsigned long offset)
 
 static inline u32 reloc_hash(struct reloc *reloc)
 {
-	return sec_offset_hash(reloc->sec, reloc->offset);
+	return sec_offset_hash(reloc->sec, reloc_offset(reloc));
 }
 
 #endif /* _OBJTOOL_ELF_H */
-- 
2.40.1

