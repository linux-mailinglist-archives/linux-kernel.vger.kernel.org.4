Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF107291A9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239221AbjFIHsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjFIHrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C238B30EC;
        Fri,  9 Jun 2023 00:47:37 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woUTeL7pJUPiswVCaUOQDKkSOjlj9VCS06zHC5LyGt4=;
        b=T2Q2Qp35Ve18tlpmfmXeEWBo3niOGVy5RkwYmmDbs3Y/mDlqq8cbP+KwcFtMDNErkwla1I
        wehD1UVt03IL42lDBQ4d7bXeBoBiI3oM8OkWQ6CDlTEq0QXIDRlneI3CIUHYiDN2Dd1oFc
        URX0OBBhh4vz+JlOOJsiXqoXbQL+DTuVwPK99NuPJG0N6cT8sNeOicbMl0wkHXUM4u+ayu
        gl0C+AEkcp5mQTw2JEczD/16r+eQXblDGpLnJQXrxSjLA1GkT32zRUbugUMVEqPxSbq0kW
        VcMiRXPrVsI21mSMDgMHRlJoAV3GRxA9/Vv3InBvIbrqimNRy75qMq56KuJj1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=woUTeL7pJUPiswVCaUOQDKkSOjlj9VCS06zHC5LyGt4=;
        b=SQOYpHfHuJUO8oW+G1Q51SHyBTwnNgcSTtA9KlUKqmmBRBmL4kT8iMZpNNxFaUtYvyeeN7
        wPwyiEm1YxU3hNCg==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Get rid of reloc->offset
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <2b9ec01178baa346a99522710bf2e82159412e3a.1685464332.git.jpoimboe@kernel.org>
References: <2b9ec01178baa346a99522710bf2e82159412e3a.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685097.404.467254531861211741.tip-bot2@tip-bot2>
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

Commit-ID:     e4cbb9b81f1f7519c7ae3abda09cb15794022952
Gitweb:        https://git.kernel.org/tip/e4cbb9b81f1f7519c7ae3abda09cb15794022952
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:06 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:21 -07:00

objtool: Get rid of reloc->offset

Get the offset from the embedded GElf_Rel[a] struct.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 43.83G
- After:  peak heap memory consumption: 42.10G

Link: https://lore.kernel.org/r/2b9ec01178baa346a99522710bf2e82159412e3a.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 14 +++++++-------
 tools/objtool/elf.c                 | 10 +++++-----
 tools/objtool/include/objtool/elf.h |  8 ++++++--
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e21138d..e06ffad 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -511,11 +511,11 @@ static int add_pv_ops(struct objtool_file *file, const char *symname)
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
@@ -1998,7 +1998,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 			break;
 
 		/* Make sure the table entries are consecutive: */
-		if (prev_offset && reloc->offset != prev_offset + 8)
+		if (prev_offset && reloc_offset(reloc) != prev_offset + 8)
 			break;
 
 		/* Detect function pointers from contiguous objects: */
@@ -2023,7 +2023,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 		alt->insn = dest_insn;
 		alt->next = insn->alts;
 		insn->alts = alt;
-		prev_offset = reloc->offset;
+		prev_offset = reloc_offset(reloc);
 	}
 
 	if (!prev_offset) {
@@ -4266,8 +4266,8 @@ static int validate_ibt_insn(struct objtool_file *file, struct instruction *insn
 	for (reloc = insn_reloc(file, insn);
 	     reloc;
 	     reloc = find_reloc_by_dest_range(file->elf, insn->sec,
-					      reloc->offset + 1,
-					      (insn->offset + insn->len) - (reloc->offset + 1))) {
+					      reloc_offset(reloc) + 1,
+					      (insn->offset + insn->len) - (reloc_offset(reloc) + 1))) {
 
 		/*
 		 * static_call_update() references the trampoline, which
@@ -4350,7 +4350,7 @@ static int validate_ibt_data_reloc(struct objtool_file *file,
 		return 0;
 
 	WARN_FUNC("data relocation to !ENDBR: %s",
-		  reloc->sec->base, reloc->offset,
+		  reloc->sec->base, reloc_offset(reloc),
 		  offstr(dest->sec, dest->offset));
 
 	return 1;
diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 70c8012..2b45460 100644
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
index 2a14da6..2070860 100644
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
