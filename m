Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351C9716ABC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbjE3RWE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbjE3RVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2BDEC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 432C763123
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C5AEC433A0;
        Tue, 30 May 2023 17:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467294;
        bh=Ysxh7lAkSp3EE9042bKmW8CQmu0Vy2TT9tV2rI9hxSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ruh/7afCQoGJd7hDuV73+GW+lr51JA200teuHzksxnUpgZgRQWR6ZKQf2SKyBOiw5
         Og4+2H07UOJuxuCwPKZAF9s/9hnWoWsg6PS0D5D3rMqnFpXcONgHfKJk13K++5naWq
         2f24BRs6Cz7y0HMj0+xOEGiCzX7XFiUqTDdsuOQoTb/g8vHmXT0Eg28jMq0Vg+Elds
         ClHLv3phlxlXv7Rj9NCFjQYmFBCER3BgOYjf/CVH9hLBbyyrfOve0GPq5UWBLaXjVf
         tCuMJ4X3BcsW05PqTiSxAc2ry1bNsXO2QiDz6uvS/zBmDb+4wuzekpeeH3N9/e1BJd
         0DBc51CYo3+SQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 08/22] objtool: Keep GElf_Rel[a] structs synced
Date:   Tue, 30 May 2023 10:21:00 -0700
Message-Id: <156d8a3e528a11e5c8577cf552890ed1f2b9567b.1685464332.git.jpoimboe@kernel.org>
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

Keep the GElf_Rela structs synced with their 'struct reloc' counterparts
instead of having to go back and "rebuild" them later.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c | 55 ++++++++++++---------------------------------
 1 file changed, 14 insertions(+), 41 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 5cbc9d578a45..8d491b2d123e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -534,16 +534,18 @@ static int read_symbols(struct elf *elf)
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
-- 
2.40.1

