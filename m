Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA748716ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbjE3RWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbjE3RVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45AF7C5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDDC963119
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6362CC433D2;
        Tue, 30 May 2023 17:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467295;
        bh=ahsLwQFtwGTVxZ23xRH22wo/YjNgv9FRU2AJq+x5RMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWzvEeVSYvQlaQGPfxNwl5nzNeioFO0LUl3VrwYzvS7s2yCRICZBPsaPuU62KBtqY
         3UAScF7gOdWgQC7XVtY6fL8dnFFZ4XQuqh1nBd0n7V9im5h+XJBtMwnhPzcT9g98lR
         vj8TSZkjh+eKiG2zcccrGYq2Bl/qm519Uj850VMYcVOI64DenethuXFmM7tPvAuvgd
         suY1uIsaEFkfuWvSLDSnRlVnrY6WtMM7k6JVEdsZUY/HzgxMukDpHz61kO3BUFW02F
         8d4jBAAZYfEGLoAh6NRGP9xtXMzjv16+xYWt5uYXcr+oICFSuIz7vdo/MlpARIyXG4
         dOG+ARt/I23QQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 10/22] objtool: Add for_each_reloc()
Date:   Tue, 30 May 2023 10:21:02 -0700
Message-Id: <dbfcb1037d8b958e52d097b67829c4c6811c24bb.1685464332.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1685464332.git.jpoimboe@kernel.org>
References: <cover.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 24 ++++++++++++------------
 tools/objtool/include/objtool/elf.h |  6 ++++++
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 88f54bb1b01c..1355e6fec7d6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -590,7 +590,7 @@ static int add_dead_ends(struct objtool_file *file)
 	if (!rsec)
 		goto reachable;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -625,7 +625,7 @@ static int add_dead_ends(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -1018,7 +1018,7 @@ static void add_ignores(struct objtool_file *file)
 	if (!rsec)
 		return;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		switch (reloc->sym->type) {
 		case STT_FUNC:
 			func = reloc->sym;
@@ -1259,7 +1259,7 @@ static int add_ignore_alternatives(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -1990,7 +1990,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	 * Each @reloc is a switch table relocation which points to the target
 	 * instruction.
 	 */
-	list_for_each_entry_from(reloc, &table->sec->reloc_list, list) {
+	for_each_reloc_from(table->sec, reloc) {
 
 		/* Check for the end of the table: */
 		if (reloc != table && reloc->jump_table_start)
@@ -2264,7 +2264,7 @@ static int read_noendbr_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		insn = find_insn(file, reloc->sym->sec, reloc->sym->offset + reloc->addend);
 		if (!insn) {
 			WARN("bad .discard.noendbr entry");
@@ -2287,7 +2287,7 @@ static int read_retpoline_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -2323,7 +2323,7 @@ static int read_instr_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -2342,7 +2342,7 @@ static int read_instr_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -2370,7 +2370,7 @@ static int read_validate_unret_hints(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		if (reloc->sym->type != STT_SECTION) {
 			WARN("unexpected relocation symbol type in %s", rsec->name);
 			return -1;
@@ -2398,7 +2398,7 @@ static int read_intra_function_calls(struct objtool_file *file)
 	if (!rsec)
 		return 0;
 
-	list_for_each_entry(reloc, &rsec->reloc_list, list) {
+	for_each_reloc(rsec, reloc) {
 		unsigned long dest_off;
 
 		if (reloc->sym->type != STT_SECTION) {
@@ -4395,7 +4395,7 @@ static int validate_ibt(struct objtool_file *file)
 		    strstr(sec->name, "__patchable_function_entries"))
 			continue;
 
-		list_for_each_entry(reloc, &sec->rsec->reloc_list, list)
+		for_each_reloc(sec->rsec, reloc)
 			warnings += validate_ibt_data_reloc(file, reloc);
 	}
 
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 74f63934afd3..a938cb1d4172 100644
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
-- 
2.40.1

