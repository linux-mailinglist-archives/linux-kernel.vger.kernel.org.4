Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD4611B21
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 21:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiJ1TsH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 15:48:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiJ1Trz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 15:47:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED6A241B07
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 12:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=IORdw0i358+WCHTJMo8FHxkOZ204c2jlWb6nUgvX6XI=; b=mHVGpEbm8sOcQ7hwd9786o/oxg
        p0whUxIGOUwNbBtGadYe5jv9R6b0FVQTQZ31Y0chVZi2yOPZeuFHU2k6PMkVd2WCCfp/DpXjArrDN
        n21ePo41DzyAu18b+ipSYfhhDicimP6xlfVzqsGDBmAdy6N9YcDq1c3svOG8zNwOWqyvVEe/RI6FZ
        2UHw4VGe31/g6jdAx3jSJY6jEPN5pCwU+6suxlXpuykF1znt84zgQGaiXOQcLbAmOm989AO4Mdy7k
        d61HL9Y6l9tFWVqkCMmyPW4BeqtYIWIhru1d9GO6siabvRPt4lTHoPIHBIkGy1DKbEg/cZrskSKUG
        XNuSXtdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ooVKV-001V5n-VM; Fri, 28 Oct 2022 19:47:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B74FF30035C;
        Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 99F592C6DAB20; Fri, 28 Oct 2022 21:47:41 +0200 (CEST)
Message-ID: <20221028194453.396634875@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 28 Oct 2022 21:40:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        djwong@kernel.org, yujie.liu@intel.com, tglx@linutronix.de,
        jpoimboe@kernel.org, joao.moreira@intel.com,
        samitolvanen@google.com
Subject: [PATCH 2/5] objtool: Slice up elf_create_section_symbol()
References: <20221028194022.388521751@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to facilitate creation of more symbol types, slice up
elf_create_section_symbol() to extract a generic helper that deals
with adding ELF symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 tools/objtool/elf.c |   56 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 21 deletions(-)

--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -717,11 +717,11 @@ static int elf_update_symbol(struct elf
 }
 
 static struct symbol *
-elf_create_section_symbol(struct elf *elf, struct section *sec)
+__elf_create_symbol(struct elf *elf, struct symbol *sym)
 {
 	struct section *symtab, *symtab_shndx;
 	Elf32_Word first_non_local, new_idx;
-	struct symbol *sym, *old;
+	struct symbol *old;
 
 	symtab = find_section_by_name(elf, ".symtab");
 	if (symtab) {
@@ -731,27 +731,16 @@ elf_create_section_symbol(struct elf *el
 		return NULL;
 	}
 
-	sym = calloc(1, sizeof(*sym));
-	if (!sym) {
-		perror("malloc");
-		return NULL;
-	}
+	new_idx = symtab->sh.sh_size / symtab->sh.sh_entsize;
 
-	sym->name = sec->name;
-	sym->sec = sec;
-
-	// st_name 0
-	sym->sym.st_info = GELF_ST_INFO(STB_LOCAL, STT_SECTION);
-	// st_other 0
-	// st_value 0
-	// st_size 0
+	if (GELF_ST_BIND(sym->sym.st_info) != STB_LOCAL)
+		goto non_local;
 
 	/*
 	 * Move the first global symbol, as per sh_info, into a new, higher
 	 * symbol index. This fees up a spot for a new local symbol.
 	 */
 	first_non_local = symtab->sh.sh_info;
-	new_idx = symtab->sh.sh_size / symtab->sh.sh_entsize;
 	old = find_symbol_by_index(elf, first_non_local);
 	if (old) {
 		old->idx = new_idx;
@@ -769,18 +758,43 @@ elf_create_section_symbol(struct elf *el
 		new_idx = first_non_local;
 	}
 
+	/*
+	 * Either way, we will add a LOCAL symbol.
+	 */
+	symtab->sh.sh_info += 1;
+
+non_local:
 	sym->idx = new_idx;
 	if (elf_update_symbol(elf, symtab, symtab_shndx, sym)) {
 		WARN("elf_update_symbol");
 		return NULL;
 	}
 
-	/*
-	 * Either way, we added a LOCAL symbol.
-	 */
-	symtab->sh.sh_info += 1;
+	return sym;
+}
+
+static struct symbol *
+elf_create_section_symbol(struct elf *elf, struct section *sec)
+{
+	struct symbol *sym = calloc(1, sizeof(*sym));
+
+	if (!sym) {
+		perror("malloc");
+		return NULL;
+	}
+
+	sym->name = sec->name;
+	sym->sec = sec;
+
+	// st_name 0
+	sym->sym.st_info = GELF_ST_INFO(STB_LOCAL, STT_SECTION);
+	// st_other 0
+	// st_value 0
+	// st_size 0
 
-	elf_add_symbol(elf, sym);
+	sym = __elf_create_symbol(elf, sym);
+	if (sym)
+		elf_add_symbol(elf, sym);
 
 	return sym;
 }


