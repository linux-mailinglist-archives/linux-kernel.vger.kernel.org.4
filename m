Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6999372918B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbjFIHsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239082AbjFIHrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCFE930DB;
        Fri,  9 Jun 2023 00:47:36 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHkI+jsm6uRa/u76pvw2ij+ApgtQIQEjvDppD45sA8g=;
        b=S3zIuWak3eBZGJZNivPh5rHx3nfa0XzUbV3ILXbDTuKqNYy/TDkNHUkEqGlJmsSPmfMYDf
        OyV06vx2nZBQVARGu8GrsjBQw83XZPTm2jvYWM2VoQjktA28AE4JYZi08rm97GJL09I5Gw
        udvwzk72lne5XvHor/PKxkdlymxx2JqDWEu6J3hTCiqdQ19gk+8E65aA2vnB5f0c9P0SSC
        FexRRvlLjF9mBVz4vIxTUxX098LWSqVrc9Q3iAprqqyJAKUFeEDtuu/3Svqfm8QADD15co
        cejzsCnkSkswWk3aJDigubT0yPurCQ7mEYLu+Ui+JPX223yrW06/g5R/jL7Zbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RHkI+jsm6uRa/u76pvw2ij+ApgtQIQEjvDppD45sA8g=;
        b=Dvt+CZqeqwZNHy9ivqjK36b6XBBll5wy1xwMHBIu+H9RkZWw0rr/IJqs45WpwrxnHcqsOM
        y06CssnnHdixKJBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Get rid of reloc->jump_table_start
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <e1602ed8a6171ada3cfac0bd8449892ec82bd188.1685464332.git.jpoimboe@kernel.org>
References: <e1602ed8a6171ada3cfac0bd8449892ec82bd188.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629684907.404.3230061904592631898.tip-bot2@tip-bot2>
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

Commit-ID:     be2f0b1e12644c956a347d7fde93c2ffe9cdb1af
Gitweb:        https://git.kernel.org/tip/be2f0b1e12644c956a347d7fde93c2ffe9cdb1af
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:09 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:24 -07:00

objtool: Get rid of reloc->jump_table_start

Rework the jump table logic slightly so 'jump_table_start' is no longer
needed.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 40.37G
- After:  peak heap memory consumption: 38.64G

Link: https://lore.kernel.org/r/e1602ed8a6171ada3cfac0bd8449892ec82bd188.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 35 ++++++++++++++++++----------
 tools/objtool/include/objtool/elf.h |  1 +-
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 745487d..7fb6467 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1989,13 +1989,14 @@ out:
 }
 
 static int add_jump_table(struct objtool_file *file, struct instruction *insn,
-			    struct reloc *table)
+			  struct reloc *next_table)
 {
-	struct reloc *reloc = table;
-	struct instruction *dest_insn;
-	struct alternative *alt;
 	struct symbol *pfunc = insn_func(insn)->pfunc;
+	struct reloc *table = insn_jump_table(insn);
+	struct instruction *dest_insn;
 	unsigned int prev_offset = 0;
+	struct reloc *reloc = table;
+	struct alternative *alt;
 
 	/*
 	 * Each @reloc is a switch table relocation which points to the target
@@ -2004,7 +2005,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	for_each_reloc_from(table->sec, reloc) {
 
 		/* Check for the end of the table: */
-		if (reloc != table && reloc->jump_table_start)
+		if (reloc != table && reloc == next_table)
 			break;
 
 		/* Make sure the table entries are consecutive: */
@@ -2119,29 +2120,39 @@ static void mark_func_jump_tables(struct objtool_file *file,
 			continue;
 
 		reloc = find_jump_table(file, func, insn);
-		if (reloc) {
-			reloc->jump_table_start = true;
+		if (reloc)
 			insn->_jump_table = reloc;
-		}
 	}
 }
 
 static int add_func_jump_tables(struct objtool_file *file,
 				  struct symbol *func)
 {
-	struct instruction *insn;
-	int ret;
+	struct instruction *insn, *insn_t1 = NULL, *insn_t2;
+	int ret = 0;
 
 	func_for_each_insn(file, func, insn) {
 		if (!insn_jump_table(insn))
 			continue;
 
-		ret = add_jump_table(file, insn, insn_jump_table(insn));
+		if (!insn_t1) {
+			insn_t1 = insn;
+			continue;
+		}
+
+		insn_t2 = insn;
+
+		ret = add_jump_table(file, insn_t1, insn_jump_table(insn_t2));
 		if (ret)
 			return ret;
+
+		insn_t1 = insn_t2;
 	}
 
-	return 0;
+	if (insn_t1)
+		ret = add_jump_table(file, insn_t1, NULL);
+
+	return ret;
 }
 
 /*
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index be08b32..60686f7 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -75,7 +75,6 @@ struct reloc {
 	struct section *sec;
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
-	bool jump_table_start;
 };
 
 struct elf {
