Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194CC729197
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:48:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239181AbjFIHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239034AbjFIHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B21030F0;
        Fri,  9 Jun 2023 00:47:30 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVkDUbItXGjPFU1VNyt6lEre2F5+FmUFzoISbzHDuZA=;
        b=IPvN7CDtVNqSrynbxSyFRgwwc6gdLpeQTTWdb0Hlz5pYMww+A+JxegqAE8NvksgFUpMuqM
        OTuAxy21qaVxS5qFUdCNTst9uzl0d+oKXn1OgpQoOSiZ7zazEWUSpdSgfJ3WzrMOnW9Onh
        H42eruAb0bzkvextdo8XZKwHQKItGw35Jn+nyKeGc48KTfHaONX+/uaDbMJA+hf7xCLxeS
        w4twbxhvYYfnHo2LZalbGlPFXrGZzKeqzKf9kOAy3qwJTYcwvQNTQ7+MwZ47awREqG0b1s
        FlcSIVqLcEYCOBBl25Nk2lYbBWjZAK+niSVrdd9iaW8pR2BrwhEGJ5XYNbtFGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UVkDUbItXGjPFU1VNyt6lEre2F5+FmUFzoISbzHDuZA=;
        b=Z11QETfcgiqSd7J33PKWiD6MUmaBE6EJELy/skZgg/9ouc82nv0Tm6HdGGB7PGXlnDxKYS
        BfnlwmrjoQHtmPAA==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Shrink reloc->sym_reloc_entry
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <a51f0a6f9bbf2494d5a3a449807307e78a940988.1685464332.git.jpoimboe@kernel.org>
References: <a51f0a6f9bbf2494d5a3a449807307e78a940988.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629684841.404.10488527727887221050.tip-bot2@tip-bot2>
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

Commit-ID:     890f10a433f51f95eccaec13d46dde769ccc113b
Gitweb:        https://git.kernel.org/tip/890f10a433f51f95eccaec13d46dde769ccc113b
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:10 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:25 -07:00

objtool: Shrink reloc->sym_reloc_entry

Convert it to a singly-linked list.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 38.64G
- After:  peak heap memory consumption: 36.89G

Link: https://lore.kernel.org/r/a51f0a6f9bbf2494d5a3a449807307e78a940988.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 |  9 +++++----
 tools/objtool/include/objtool/elf.h |  4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 16e019a..4b0de0e 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -356,7 +356,6 @@ static void elf_add_symbol(struct elf *elf, struct symbol *sym)
 	struct rb_node *pnode;
 	struct symbol *iter;
 
-	INIT_LIST_HEAD(&sym->reloc_list);
 	INIT_LIST_HEAD(&sym->pv_target);
 	sym->alias = sym;
 
@@ -540,7 +539,7 @@ static int elf_update_sym_relocs(struct elf *elf, struct symbol *sym)
 {
 	struct reloc *reloc;
 
-	list_for_each_entry(reloc, &sym->reloc_list, sym_reloc_entry) {
+	for (reloc = sym->relocs; reloc; reloc = reloc->sym_next_reloc) {
 		reloc->rel.r_info = GELF_R_INFO(reloc->sym->idx, reloc_type(reloc));
 		if (elf_write_reloc(elf, reloc))
 			return -1;
@@ -841,8 +840,9 @@ static struct reloc *elf_init_reloc(struct elf *elf, struct section *rsec,
 	if (elf_write_reloc(elf, reloc))
 		return NULL;
 
-	list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
 	elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
+	reloc->sym_next_reloc = sym->relocs;
+	sym->relocs = reloc;
 
 	return reloc;
 }
@@ -960,8 +960,9 @@ static int read_relocs(struct elf *elf)
 				return -1;
 			}
 
-			list_add_tail(&reloc->sym_reloc_entry, &sym->reloc_list);
 			elf_hash_add(reloc, &reloc->hash, reloc_hash(reloc));
+			reloc->sym_next_reloc = sym->relocs;
+			sym->relocs = reloc;
 
 			nr_reloc++;
 		}
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 60686f7..7b808ac 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -63,7 +63,7 @@ struct symbol {
 	u8 profiling_func    : 1;
 	u8 warned	     : 1;
 	struct list_head pv_target;
-	struct list_head reloc_list;
+	struct reloc *relocs;
 };
 
 struct reloc {
@@ -74,7 +74,7 @@ struct reloc {
 	};
 	struct section *sec;
 	struct symbol *sym;
-	struct list_head sym_reloc_entry;
+	struct reloc *sym_next_reloc;
 };
 
 struct elf {
