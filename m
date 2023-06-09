Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B357291AD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjFIHsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239106AbjFIHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11A351FDA;
        Fri,  9 Jun 2023 00:47:41 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZicnGSWL58IccW1WHSu/5s3RynMOqaqeMuRqx+MJas8=;
        b=2CQuYnGMyCZJt88HIXHtWoDCWeOTNhxW3LBJB1uj7DRvxRpfcsPJfd91E6DOPmrn1hXmJ2
        /PIjrDmXASc/DKXe9m3ktQmyHUya1TI6HinfDA72I/8897ZuY1GGLsLBJREp+BCaJWCYt1
        ZAAwl4uknmZOgEneXgjr58dwcKMBjqwbUAvIFRmcSqF8x+iFC8tj5MW/p721S6Jx+BJcNP
        gja5mEc71OpSamRwIQH7h18GoPwWEqHPYvUDDngfbfUBoufpTSbeQ4cGxrpuFJvatoDeCu
        p24ht1b8BwgvTKpyBYjbLCGMa7udmS3U9poGZjQwDgCOCfe39K+6/XXdoBY3HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZicnGSWL58IccW1WHSu/5s3RynMOqaqeMuRqx+MJas8=;
        b=oWj54W3wz4rpahITmjsT75sIIXdgi7xeDY6SVW4dsLT1flI91a8XY9GM6fDD288kY6LPDN
        QZeKiBZPHEqo3XBw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Keep GElf_Rel[a] structs synced
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <156d8a3e528a11e5c8577cf552890ed1f2b9567b.1685464332.git.jpoimboe@kernel.org>
References: <156d8a3e528a11e5c8577cf552890ed1f2b9567b.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685479.404.14991753741214834599.tip-bot2@tip-bot2>
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

Commit-ID:     fcf933552bebdecd72b324738c6635f46b0df569
Gitweb:        https://git.kernel.org/tip/fcf933552bebdecd72b324738c6635f46b0df569
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:00 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:18 -07:00

objtool: Keep GElf_Rel[a] structs synced

Keep the GElf_Rela structs synced with their 'struct reloc' counterparts
instead of having to go back and "rebuild" them later.

Link: https://lore.kernel.org/r/156d8a3e528a11e5c8577cf552890ed1f2b9567b.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 55 +++++++++++---------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5cbc9d5..8d491b2 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -534,16 +534,18 @@ err:
 }
 
 /*
- * Ensure that any reloc section containing references to @sym is marked
- * changed such that it will get re-generated in elf_rebuild_reloc_sections()
- * with the new symbol index.
+ * @sym's idx has changed.  Update the relocs which reference it.
  */
-static void elf_dirty_reloc_sym(struct elf *elf, struct symbol *sym)
+static int elf_update_sym_relocs(struct elf *elf, struct symbol *sym)
 {
 	struct reloc *reloc;
 
-	list_for_each_entry(reloc, &sym->reloc_list, sym_reloc_entry)
-		mark_sec_changed(elf, reloc->sec, true);
+	list_for_each_entry(reloc, &sym->reloc_list, sym_reloc_entry) {
+		if (elf_write_reloc(elf, reloc))
+			return -1;
+	}
+
+	return 0;
 }
 
 /*
@@ -716,13 +718,14 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
 		hlist_del(&old->hash);
 		elf_hash_add(symbol, &old->hash, old->idx);
 
-		elf_dirty_reloc_sym(elf, old);
-
 		if (elf_update_symbol(elf, symtab, symtab_shndx, old)) {
 			WARN("elf_update_symbol move");
 			return NULL;
 		}
 
+		if (elf_update_sym_relocs(elf, old))
+			return NULL;
+
 		new_idx = first_non_local;
 	}
 
@@ -833,12 +836,13 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 	reloc->sym = sym;
 	reloc->addend = addend;
 
+	if (elf_write_reloc(elf, reloc))
+		return NULL;
+
 	list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
 	list_add_tail(&reloc->list, &rsec->reloc_list);
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
-	mark_sec_changed(elf, rsec, true);
-
 	return reloc;
 }
 
@@ -1203,31 +1207,6 @@ struct section *elf_create_section_pair(struct elf *elf, const char *name,
 	return sec;
 }
 
-static int elf_rebuild_reloc_section(struct elf *elf, struct section *rsec)
-{
-	struct reloc *reloc;
-	int idx = 0, ret;
-
-	idx = 0;
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
-		reloc->rel.r_offset = reloc->offset;
-		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc->type);
-		if (rsec->sh.sh_type == SHT_RELA) {
-			reloc->rela.r_addend = reloc->addend;
-			ret = gelf_update_rela(rsec->data, idx, &reloc->rela);
-		} else {
-			ret = gelf_update_rel(rsec->data, idx, &reloc->rel);
-		}
-		if (!ret) {
-			WARN_ELF("gelf_update_rel");
-			return -1;
-		}
-		idx++;
-	}
-
-	return 0;
-}
-
 int elf_write_insn(struct elf *elf, struct section *sec,
 		   unsigned long offset, unsigned int len,
 		   const char *insn)
@@ -1351,12 +1330,6 @@ int elf_write(struct elf *elf)
 				return -1;
 			}
 
-			if (sec->base &&
-			    elf_rebuild_reloc_section(elf, sec)) {
-				WARN("elf_rebuild_reloc_section");
-				return -1;
-			}
-
 			mark_sec_changed(elf, sec, false);
 		}
 	}
