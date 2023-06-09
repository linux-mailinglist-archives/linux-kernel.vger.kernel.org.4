Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BE97291AE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239214AbjFIHs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbjFIHrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C871FEB;
        Fri,  9 Jun 2023 00:47:41 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMLOC9+JcExYQXo480vdAW5+Y3vcBAhxA0RE2WfX4O8=;
        b=v1+/jUJiUrSlPjG3J/oWtNZa1q1L2TbW4GPGn8UcG/lp/PWSXfGkGDZZKkD6Xxzicc9Zas
        3Msmcwace+oKxWcJXRc9MQNJ/UI4Mc0iaVCQ5s65IVBE6fI3MvB3MJtgHol6rkFuoIjVeN
        eGAk2Kk6dcO0BQ6TbUOnQybUuCt8pxu76JlLyjlCpVYFrfm9LTwLkrGOrld+VTDUiMrzty
        ug+qK5fca5Am9IvobjqigyqV8FIe+0CYT56o6LtXvDOJ4p3CkBodMMyF7bzWITNbpC/cUq
        MR+23bwdeT/9uTzWS13Pqp79BqVUqqORKbkfAATGCqQifyPIwH32gxZOM3k2iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296856;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FMLOC9+JcExYQXo480vdAW5+Y3vcBAhxA0RE2WfX4O8=;
        b=qw4o68jpjQ3DozaCo3xigiSo1g2h1k7N5BEER8fxBsS8WTsgwIFtcszaIRMcO6s5v3Ep9T
        iu0lVBQm/o8mzJAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add mark_sec_changed()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <9a810a8d2e28af6ba07325362d0eb4703bb09d3a.1685464332.git.jpoimboe@kernel.org>
References: <9a810a8d2e28af6ba07325362d0eb4703bb09d3a.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685608.404.5335907781714907060.tip-bot2@tip-bot2>
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

Commit-ID:     ff4082730c2aaff3706232266e09d1ae4b350521
Gitweb:        https://git.kernel.org/tip/ff4082730c2aaff3706232266e09d1ae4b350521
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:20:58 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:16 -07:00

objtool: Add mark_sec_changed()

Ensure elf->changed always gets set when sec->changed gets set.

Link: https://lore.kernel.org/r/9a810a8d2e28af6ba07325362d0eb4703bb09d3a.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 31 ++++++++++++++--------------
 tools/objtool/include/objtool/elf.h | 14 ++++++++++++-
 2 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index f72ec6d..67967c2 100644
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
 
@@ -773,11 +774,11 @@ non_local:
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
index b81d78b..56b66ff 100644
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
 
