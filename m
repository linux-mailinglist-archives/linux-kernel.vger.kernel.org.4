Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3BA716ABA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjE3RV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjE3RVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ADBDBE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93CD563124
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBFBBC4339C;
        Tue, 30 May 2023 17:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467294;
        bh=/gny+U0KyTIKAob4MYatyz6EsssqX1Se8bu0EbKgaIo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BX04ZWtWbxtq70YVJJRjpAvsIMqgzMSC+2JSsrIA+ZoDMe0grMLRyFbvopLaazmFy
         41vh6bNUpoHiKpM6yFey+X6JBe/4gEQPZ1CfG3+4XP4AWUMiqcbCm7B6IKpk1e7laT
         9scNyb9avMScJuTeTRazsjOWJxAfzU6CaX6/jyQjC99ydfS9qFT4U20Xj9aaANCHtc
         BCRYMor+ZFOM3+NZ33CxJqZnKDZbZu0vS/MVhTmjd9BALTzYL4LGVL6QK7PsAnya3C
         aa+qpAN3R2KAib4lnFYOZ8+QGq9nb0VDyyQpp5aSC9mHk5mYLPpYotuLNeuRuh9h7o
         DVX88xKso6bVg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 06/22] objtool: Add mark_sec_changed()
Date:   Tue, 30 May 2023 10:20:58 -0700
Message-Id: <9a810a8d2e28af6ba07325362d0eb4703bb09d3a.1685464332.git.jpoimboe@kernel.org>
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

Ensure elf->changed always gets set when sec->changed gets set.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 31 +++++++++++++++--------------
 tools/objtool/include/objtool/elf.h | 14 ++++++++++++-
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f72ec6d8fb14..67967c231972 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -562,7 +562,8 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
 	sec->rsec->sh.sh_size += sec->rsec->sh.sh_entsize;
-	sec->rsec->changed = true;
+
+	mark_sec_changed(elf, sec->rsec, true);
 
 	return 0;
 }
@@ -577,7 +578,7 @@ static void elf_dirty_reloc_sym(struct elf *elf, struct symbol *sym)
 	struct reloc *reloc;
 
 	list_for_each_entry(reloc, &sym->reloc_list, sym_reloc_entry)
-		reloc->sec->changed = true;
+		mark_sec_changed(elf, reloc->sec, true);
 }
 
 /*
@@ -654,7 +655,7 @@ static int elf_update_symbol(struct elf *elf, struct section *symtab,
 			symtab_data->d_align = 1;
 			symtab_data->d_type = ELF_T_SYM;
 
-			symtab->changed = true;
+			mark_sec_changed(elf, symtab, true);
 			symtab->truncate = true;
 
 			if (t) {
@@ -669,7 +670,7 @@ static int elf_update_symbol(struct elf *elf, struct section *symtab,
 				shndx_data->d_align = sizeof(Elf32_Word);
 				shndx_data->d_type = ELF_T_WORD;
 
-				symtab_shndx->changed = true;
+				mark_sec_changed(elf, symtab_shndx, true);
 				symtab_shndx->truncate = true;
 			}
 
@@ -773,11 +774,11 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
 	}
 
 	symtab->sh.sh_size += symtab->sh.sh_entsize;
-	symtab->changed = true;
+	mark_sec_changed(elf, symtab, true);
 
 	if (symtab_shndx) {
 		symtab_shndx->sh.sh_size += sizeof(Elf32_Word);
-		symtab_shndx->changed = true;
+		mark_sec_changed(elf, symtab_shndx, true);
 	}
 
 	return sym;
@@ -1040,7 +1041,8 @@ static int elf_add_string(struct elf *elf, struct section *strtab, char *str)
 
 	len = strtab->sh.sh_size;
 	strtab->sh.sh_size += data->d_size;
-	strtab->changed = true;
+
+	mark_sec_changed(elf, strtab, true);
 
 	return len;
 }
@@ -1075,7 +1077,6 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	}
 
 	sec->idx = elf_ndxscn(s);
-	sec->changed = true;
 
 	sec->data = elf_newdata(s);
 	if (!sec->data) {
@@ -1122,7 +1123,7 @@ struct section *elf_create_section(struct elf *elf, const char *name,
 	elf_hash_add(section, &sec->hash, sec->idx);
 	elf_hash_add(section_name, &sec->name_hash, str_hash(sec->name));
 
-	elf->changed = true;
+	mark_sec_changed(elf, sec, true);
 
 	return sec;
 }
@@ -1208,9 +1209,8 @@ int elf_write_insn(struct elf *elf, struct section *sec,
 	}
 
 	memcpy(data->d_buf + offset, insn, len);
-	elf_flagdata(data, ELF_C_SET, ELF_F_DIRTY);
 
-	elf->changed = true;
+	mark_sec_changed(elf, sec, true);
 
 	return 0;
 }
@@ -1235,7 +1235,7 @@ int elf_write_reloc(struct elf *elf, struct reloc *reloc)
 		return -1;
 	}
 
-	elf->changed = true;
+	mark_sec_changed(elf, rsec, true);
 
 	return 0;
 }
@@ -1307,12 +1307,14 @@ int elf_write(struct elf *elf)
 		if (sec->truncate)
 			elf_truncate_section(elf, sec);
 
-		if (sec->changed) {
+		if (sec_changed(sec)) {
 			s = elf_getscn(elf->elf, sec->idx);
 			if (!s) {
 				WARN_ELF("elf_getscn");
 				return -1;
 			}
+
+			/* Note this also flags the section dirty */
 			if (!gelf_update_shdr(s, &sec->sh)) {
 				WARN_ELF("gelf_update_shdr");
 				return -1;
@@ -1324,8 +1326,7 @@ int elf_write(struct elf *elf)
 				return -1;
 			}
 
-			sec->changed = false;
-			elf->changed = true;
+			mark_sec_changed(elf, sec, false);
 		}
 	}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index b81d78b35126..56b66ff91943 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -39,7 +39,7 @@ struct section {
 	Elf_Data *data;
 	char *name;
 	int idx;
-	bool changed, text, rodata, noinstr, init, truncate;
+	bool _changed, text, rodata, noinstr, init, truncate;
 	struct reloc *reloc_data;
 };
 
@@ -164,6 +164,18 @@ static inline bool is_reloc_sec(struct section *sec)
 	return sec->sh.sh_type == SHT_RELA || sec->sh.sh_type == SHT_REL;
 }
 
+static inline bool sec_changed(struct section *sec)
+{
+	return sec->_changed;
+}
+
+static inline void mark_sec_changed(struct elf *elf, struct section *sec,
+				    bool changed)
+{
+	sec->_changed = changed;
+	elf->changed |= changed;
+}
+
 #define for_each_sec(file, sec)						\
 	list_for_each_entry(sec, &file->elf->sections, list)
 
-- 
2.40.1

