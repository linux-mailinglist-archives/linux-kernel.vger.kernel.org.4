Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72947291A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239340AbjFIHsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239099AbjFIHro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E15430F7;
        Fri,  9 Jun 2023 00:47:40 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8rIz9RIQLow4twqJ7NYKm0MXnwaKgInkeCP1tXKotA=;
        b=Z6f0DuQ1FC3C1bcHLqeJY2VgCKyri5C7Q2Kb8HXR6+YZ0V5ulyqNQlZTpXX1J6WaG0KsYh
        qG+dzjy6JiVSNTV76QyE/6bn6Z+uAKjth81sFcsU1dN6+0GpciLg4V6N6ZcdDDWS+5HMTW
        K7R6fkrDQl+VpQIgFgoJ9Sg/hAAZBVVS6qrhj48N8XwPSPyrEzcXIftGRqRp0vUrgitfBt
        QRF4kREAkWn70OheYGI2lhaNJlrTSsP0lmaPlDkw0G9oiazO+7rSYg9LZtxG4S+mMaKD0k
        oc0ZowBsQ012PD2nR2GkMZRbXsM2foksWW3zJkDkgzZaCaWBslsoeUS2rCwzig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p8rIz9RIQLow4twqJ7NYKm0MXnwaKgInkeCP1tXKotA=;
        b=/UH4vSCFipeSWBw8PJM24Bbzn5Z4ANSakym7KxyGvsNVKxmvzOLhZugG2Fj9AyqfFTwkoh
        pTOCRAZn05+/OaCQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Add for_each_reloc()
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <dbfcb1037d8b958e52d097b67829c4c6811c24bb.1685464332.git.jpoimboe@kernel.org>
References: <dbfcb1037d8b958e52d097b67829c4c6811c24bb.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629685347.404.7238717299564745403.tip-bot2@tip-bot2>
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

Commit-ID:     caa4a6b74b405ddaea40e2946cc3983aac96451d
Gitweb:        https://git.kernel.org/tip/caa4a6b74b405ddaea40e2946cc3983aac96451d
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:02 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:19 -07:00

objtool: Add for_each_reloc()

Link: https://lore.kernel.org/r/dbfcb1037d8b958e52d097b67829c4c6811c24bb.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 24 ++++++++++++------------
 tools/objtool/include/objtool/elf.h |  6 ++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3bc97c2..e21138d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -591,7 +591,7 @@ static int add_dead_ends(struct objtool_file *file)
 	if (!rsec)
 		goto reachable;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -626,7 +626,7 @@ reachable:
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -1019,7 +1019,7 @@ static void add_ignores(struct objtool_file *file)
 	if (!rsec)
 		return;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		switch (reloc->sym->type) {
 		case STT_FUNC:
 			func = reloc->sym;
@@ -1260,7 +1260,7 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -1991,7 +1991,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	 * Each @reloc is a switch table relocation which points to the target
 	 * instruction.
 	 */
-	list_for_each_entry_from(reloc, &table->sec->reloc_list, list) {
+	for_each_reloc_from(table->sec, reloc) {
 
 		/* Check for the end of the table: */
 		if (reloc != table && reloc->jump_table_start)
@@ -2270,7 +2270,7 @@ static int read_noendbr_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
 		if (!insn) {
 			WARN("bad .discard.noendbr entry");
@@ -2293,7 +2293,7 @@ static int read_retpoline_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -2329,7 +2329,7 @@ static int read_instr_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -2348,7 +2348,7 @@ static int read_instr_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -2376,7 +2376,7 @@ static int read_validate_unret_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -2404,7 +2404,7 @@ static int read_intra_function_calls(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		unsigned long dest_off;
 
 		if (reloc->sym->type != STT_SECTION) {
@@ -4404,7 +4404,7 @@ static int validate_ibt(struct objtool_file *file)
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
-		list_for_each_entry(reloc, &sec->rsec->reloc_list, list)
+		for_each_reloc(sec->rsec, reloc)
 			warnings += validate_ibt_data_reloc(file, reloc);
 	}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 74f6393..a938cb1 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -209,6 +209,12 @@ static inline void mark_sec_changed(struct elf *elf, struct section *sec,
 		for_each_sec(file, __sec)				\
 			sec_for_each_sym(__sec, sym)
 
+#define for_each_reloc(rsec, reloc)					\
+	list_for_each_entry(reloc, &rsec->reloc_list, list)
+
+#define for_each_reloc_from(rsec, reloc)				\
+	list_for_each_entry_from(reloc, &rsec->reloc_list, list)
+
 #define OFFSET_STRIDE_BITS	4
 #define OFFSET_STRIDE		(1UL << OFFSET_STRIDE_BITS)
 #define OFFSET_STRIDE_MASK	(~(OFFSET_STRIDE - 1))
