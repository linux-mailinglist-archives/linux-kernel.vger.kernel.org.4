Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468C6716AC7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjE3RWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbjE3RVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFB8EA
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 79AD46312F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34F1C4339C;
        Tue, 30 May 2023 17:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467297;
        bh=nigN3+rTGBIIkX5YK6qdZ6MMc2ZnMKe0BoHwqwd6Fek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k+M69oU78MdEJXI9LIn8c8i+fZkQYa9WPHxaS7CmX1iegENkA4232pAZH69B9HoqJ
         gmi3V7rp7vybp+7CWaT/0eEdY8DlRPQ6yKIMUwuUlpjj8hukrXmFPcECoyZfetQoM7
         JiM/R6ngcsJ2ZM3NSb7N41q5/82mOAjwA4pmu+KgNzeOUNNHTLuMrvuOy61VOWSUvs
         bz8voy/GPaqTFwsQaJJxqSvYvj7jDe2krDOXRDXtrYT8mzuV/D2kPRr5EKKjcWKeBE
         ZH7w2jSv80Jo302rCgG7EWji026vEv+VJG6S1SG8vFmbSYNXSxd4ZmhIcCyAwLTMbP
         /6R5MLlk8dn7A==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 17/22] objtool: Get rid of reloc->jump_table_start
Date:   Tue, 30 May 2023 10:21:09 -0700
Message-Id: <e1602ed8a6171ada3cfac0bd8449892ec82bd188.1685464332.git.jpoimboe@kernel.org>
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

Rework the jump table logic slightly so 'jump_table_start' is no longer
needed.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 40.37G
- After:  peak heap memory consumption: 38.64G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c               | 35 +++++++++++++++++++----------
 tools/objtool/include/objtool/elf.h |  1 -
 2 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 12a9e6fb3fe7..3fe6b3657e22 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1988,13 +1988,14 @@ static int add_special_section_alts(struct objtool_file *file)
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
@@ -2003,7 +2004,7 @@ static int add_jump_table(struct objtool_file *file, struct instruction *insn,
 	for_each_reloc_from(table->sec, reloc) {
 
 		/* Check for the end of the table: */
-		if (reloc != table && reloc->jump_table_start)
+		if (reloc != table && reloc == next_table)
 			break;
 
 		/* Make sure the table entries are consecutive: */
@@ -2118,29 +2119,39 @@ static void mark_func_jump_tables(struct objtool_file *file,
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
index be08b32a93ee..60686f746c9e 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -75,7 +75,6 @@ struct reloc {
 	struct section *sec;
 	struct symbol *sym;
 	struct list_head sym_reloc_entry;
-	bool jump_table_start;
 };
 
 struct elf {
-- 
2.40.1

