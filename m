Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784661D97B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 11:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiKEKgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 06:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKEKgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 06:36:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B902AE38;
        Sat,  5 Nov 2022 03:36:30 -0700 (PDT)
Date:   Sat, 05 Nov 2022 10:36:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667644589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7Gx3aKfS5VAgwB+wRizzNS4KlLZzo8Gg/aRiaUgpr8=;
        b=k0XUNQYpT+YN6yFUPO1MGZ6yRvaemmWyCNrNYI7eUa1Vh0q/6nxDTQFDEDimmpq7YXsu0E
        UgKOYK4jO7HspI4J1s1ix/dAMTTpv0mqx+xqbwU5DP7hBmYAThUbkiHJPJmtwib+Qx9PL5
        JFA6JrYvsh9CglRu1XJBfl831Up6MSV71dEYkqPHFtnhcjLrRqdl8HY3+IJNsPs8pDaVb9
        ST9qLJSPF//3qDQRHzwV5xCcEFWkO80hD/oq+sDIJpSAZeRZPSluZ8BOZbl3d4go8soAVD
        jZTyT5BLwi5kRR1lgd6QYpHn/yGYRINXd4wmyEqs4Sbxu6mQumBG1p9FLJtpHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667644589;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X7Gx3aKfS5VAgwB+wRizzNS4KlLZzo8Gg/aRiaUgpr8=;
        b=3M19D6NDseZoQUZbW07xzyHq/QHzV1pdMYpVVEQ3Hgxxh1vjjPARA9wU8r5pJMvzbelgJD
        ZTFdOa3vX1DbS3Aw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Optimize elf_dirty_reloc_sym()
Cc:     Borislav Petkov <bp@alien8.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Y2LlRA7x+8UsE1xf@hirez.programming.kicks-ass.net>
References: <Y2LlRA7x+8UsE1xf@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166764458820.4906.1462951010200408447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     19526717f768bf2f89ca01bd2a595728ebe57540
Gitweb:        https://git.kernel.org/tip/19526717f768bf2f89ca01bd2a595728ebe57540
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Nov 2022 22:31:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 05 Nov 2022 11:28:02 +01:00

objtool: Optimize elf_dirty_reloc_sym()

When moving a symbol in the symtab its index changes and any reloc
referring that symtol-table-index will need to be rewritten too.

In order to facilitate this, objtool simply marks the whole reloc
section 'changed' which will cause the whole section to be
re-generated.

However, finding the relocs that use any given symbol is implemented
rather crudely -- a fully iteration of all sections and their relocs.
Given that some builds have over 20k sections (kallsyms etc..)
iterating all that for *each* symbol moved takes a bit of time.

Instead have each symbol keep a list of relocs that reference it.

This *vastly* improves build times for certain configs.

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Y2LlRA7x+8UsE1xf@hirez.programming.kicks-ass.net
---
 tools/objtool/elf.c                 | 27 ++++++++++-----------------
 tools/objtool/include/objtool/elf.h |  2 ++
 2 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 3d636d1..8cd7f01 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -356,6 +356,7 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 	struct rb_node *pnode;
 	struct symbol *iter;
 
+	INIT_LIST_HEAD(&sym->reloc_list);
 	INIT_LIST_HEAD(&sym->pv_target);
 	sym->alias = sym;
 
@@ -557,6 +558,7 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
 	reloc->sym = sym;
 	reloc->addend = addend;
 
+	list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
 	list_add_tail(&reloc->list, &sec->reloc->reloc_list);
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
@@ -573,21 +575,10 @@ int elf_add_reloc(struct elf *elf, struct section *sec, unsigned long offset,
  */
 static void elf_dirty_reloc_sym(struct elf *elf, struct symbol *sym)
 {
-	struct section *sec;
-
-	list_for_each_entry(sec, &elf->sections, list) {
-		struct reloc *reloc;
-
-		if (sec->changed)
-			continue;
+	struct reloc *reloc;
 
-		list_for_each_entry(reloc, &sec->reloc_list, list) {
-			if (reloc->sym == sym) {
-				sec->changed = true;
-				break;
-			}
-		}
-	}
+	list_for_each_entry(reloc, &sym->reloc_list, sym_reloc_entry)
+		reloc->sec->changed = true;
 }
 
 /*
@@ -902,11 +893,12 @@ static int read_rela_reloc(struct section *sec, int i, struct reloc *reloc, unsi
 
 static int read_relocs(struct elf *elf)
 {
+	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
 	struct section *sec;
 	struct reloc *reloc;
-	int i;
 	unsigned int symndx;
-	unsigned long nr_reloc, max_reloc = 0, tot_reloc = 0;
+	struct symbol *sym;
+	int i;
 
 	if (!elf_alloc_hash(reloc, elf->text_size / 16))
 		return -1;
@@ -947,13 +939,14 @@ static int read_relocs(struct elf *elf)
 
 			reloc->sec = sec;
 			reloc->idx = i;
-			reloc->sym = find_symbol_by_index(elf, symndx);
+			reloc->sym = sym = find_symbol_by_index(elf, symndx);
 			if (!reloc->sym) {
 				WARN("can't find reloc entry symbol %d for %s",
 				     symndx, sec->name);
 				return -1;
 			}
 
+			list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
 			list_add_tail(&reloc->list, &sec->reloc_list);
 			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index b6974e3..bca719b 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -62,6 +62,7 @@ struct symbol {
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
 	struct list_head pv_target;
+	struct list_head reloc_list;
 };
 
 struct reloc {
@@ -73,6 +74,7 @@ struct reloc {
 	};
 	struct section *sec;
 	struct symbol *sym;
+	struct list_head sym_reloc_entry;
 	unsigned long offset;
 	unsigned int type;
 	s64 addend;
