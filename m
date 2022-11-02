Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA4161700C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 22:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiKBVrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 17:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiKBVrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 17:47:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8478AE0C0
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PAqLk4vbz/jMyf0acd8AaUtbY70n/pCagLl/I8+aAy4=; b=Mlqf86ujjgIDW8LACKKsN0DHlm
        UE/XS328m2Mynx6qIbbIMNH7OMcdrWxt1NG/yi2z8JTyqZAmBPPs6AOxF/FD/MwVvj35nvy4gdk9n
        vat5p8hyus8Q3AGatMGa6evGstcpSAOYACyj2J4oVg5iUD+gqQD0HYdN85JfhudFs3E64QY7cmn3Q
        C3GIL3A5aBislzBCL5ULSUHc7IjQqiJw1CsUCoRfGathVddINOSktcpEFfJ4IpzuUxxvkeWBMZPSE
        T85+0KXqR9+sNisVISO+i+m/lTBBOABPaGL0HvU83unLPNmTcjekGgMN1J0CJbe8CO9FrIJDDFDlk
        MN3S3f3A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oqLZO-008W7N-Cu; Wed, 02 Nov 2022 21:46:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D1282300130;
        Wed,  2 Nov 2022 22:46:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ADC7C20B23194; Wed,  2 Nov 2022 22:46:44 +0100 (CET)
Date:   Wed, 2 Nov 2022 22:46:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, djwong@kernel.org,
        yujie.liu@intel.com, tglx@linutronix.de, jpoimboe@kernel.org,
        joao.moreira@intel.com, samitolvanen@google.com
Subject: [PATCH 6/5] objtool: Optimize elf_dirty_reloc_sym()
Message-ID: <Y2LlRA7x+8UsE1xf@hirez.programming.kicks-ass.net>
References: <20221028194022.388521751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028194022.388521751@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: objtool: Optimize elf_dirty_reloc_sym()
From: Peter Zijlstra <peterz@infradead.org>
Date: Wed Nov  2 22:31:19 CET 2022

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
---
 tools/objtool/elf.c                 |   27 ++++++++++-----------------
 tools/objtool/include/objtool/elf.h |    2 ++
 2 files changed, 12 insertions(+), 17 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -356,6 +356,7 @@ static void elf_add_symbol(struct elf *e
 	struct rb_node *pnode;
 	struct symbol *iter;
 
+	INIT_LIST_HEAD(&sym->reloc_list);
 	INIT_LIST_HEAD(&sym->pv_target);
 	sym->alias = sym;
 
@@ -557,6 +558,7 @@ int elf_add_reloc(struct elf *elf, struc
 	reloc->sym = sym;
 	reloc->addend = addend;
 
+	list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
 	list_add_tail(&reloc->list, &sec->reloc->reloc_list);
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
 
@@ -573,21 +575,10 @@ int elf_add_reloc(struct elf *elf, struc
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
@@ -902,11 +893,12 @@ static int read_rela_reloc(struct sectio
 
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
