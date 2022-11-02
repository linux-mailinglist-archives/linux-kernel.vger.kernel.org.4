Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F304D615F90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:22:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiKBJWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbiKBJVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:21:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BAF65B2;
        Wed,  2 Nov 2022 02:20:09 -0700 (PDT)
Date:   Wed, 02 Nov 2022 09:20:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1667380808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nudvF3fvqi8ECd2W4ikTN2udZW9zEH3pE60NXtrDRM4=;
        b=K7zPOdxMNBmKhsvhY+60TS80VAORApqH36t9c3E+rqwpxDi7wEI+k3YJVt1eBn0+cFph/m
        fcBYC5xT/FnB8JhsL2LhASlP239XH0pqUohKQ9iVmtvGCOnDMaM27j13T1Ku+4vJRRXQ4P
        jBk+i/noMmjFVdehSL2MAhVIm6+25vBVuR440me0enxn3Yu/UzaYN6mY67O44g6JwcRz8E
        XHuScW8R32C/G4IGy34EzKt4LyJKaUFnijKmYFLC9JERqNDrmG6Cpq7klNZ0KNWODGg/LS
        Eogm+cGz8v0C2wKDf8ZldljVdpfGz7zEb6eT8SrqhTWAIRDoDZAYEffLJEFejg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1667380808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nudvF3fvqi8ECd2W4ikTN2udZW9zEH3pE60NXtrDRM4=;
        b=EOrPgFGiLYvA6KbNMxAlS7bUq5buxfoeAxaQl+vIp7D2dd8kwpYDmSGuDWyvbn8+q9pHlK
        0ryYLpYkPxa6mXDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] objtool: Slice up elf_create_section_symbol()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Yujie Liu <yujie.liu@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20221028194453.396634875@infradead.org>
References: <20221028194453.396634875@infradead.org>
MIME-Version: 1.0
Message-ID: <166738080669.7716.12446365852735816600.tip-bot2@tip-bot2>
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

Commit-ID:     4c91be8e926c6b3734d59b9348e305431484d42b
Gitweb:        https://git.kernel.org/tip/4c91be8e926c6b3734d59b9348e305431484d42b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 28 Oct 2022 15:49:26 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Nov 2022 13:44:08 +01:00

objtool: Slice up elf_create_section_symbol()

In order to facilitate creation of more symbol types, slice up
elf_create_section_symbol() to extract a generic helper that deals
with adding ELF symbols.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Link: https://lkml.kernel.org/r/20221028194453.396634875@infradead.org
---
 tools/objtool/elf.c | 56 +++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 21 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 89b37cd..3ad89d9 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -717,11 +717,11 @@ static int elf_update_symbol(struct elf *elf, struct section *symtab,
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
@@ -731,27 +731,16 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
 		return NULL;
 	}
 
-	sym = calloc(1, sizeof(*sym));
-	if (!sym) {
-		perror("malloc");
-		return NULL;
-	}
-
-	sym->name = sec->name;
-	sym->sec = sec;
+	new_idx = symtab->sh.sh_size / symtab->sh.sh_entsize;
 
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
@@ -769,18 +758,43 @@ elf_create_section_symbol(struct elf *elf, struct section *sec)
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
 
-	elf_add_symbol(elf, sym);
+	sym->name = sec->name;
+	sym->sec = sec;
+
+	// st_name 0
+	sym->sym.st_info = GELF_ST_INFO(STB_LOCAL, STT_SECTION);
+	// st_other 0
+	// st_value 0
+	// st_size 0
+
+	sym = __elf_create_symbol(elf, sym);
+	if (sym)
+		elf_add_symbol(elf, sym);
 
 	return sym;
 }
