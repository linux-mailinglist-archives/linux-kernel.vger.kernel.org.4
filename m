Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9910716AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjE3RWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjE3RVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB62BE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C6C4B6314D
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 103B1C433D2;
        Tue, 30 May 2023 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467298;
        bh=6IoUil4pi2vqJ2egXzU2ifWGGynkECsbxuV8rRcIrsA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EtNkEs+DQNw3m2EDY+JnKtgWFehlb+1Id6wTd8gOBuASpMrK0RzedKPnjueqXPBvp
         ukItez3LW3k3NNKgnNM3RREcWDPZx3qet8/hsdNwn+Soy7CpKwR/v17fbFl5LfaHBa
         2GDADgxQuIYci1wk6rtQdExheBglKeBCkkJ7m79jP97+gcWI9o8zkyeNfY5KVTKRkj
         XeQHBzwVB+Bg+YjKh7RrvXYwE0PQpXg7cVtfHH4tr6dH+L0yc/msShU/e/csmPHehS
         H3fxPvRkTxxhW8v8zcKBJNX7MbFaQ/RSzST6/iU0LYAJ6WZw/LmeCQkWPKshyrUEqO
         T4lCDB3e+Q4AQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 18/22] objtool: Shrink reloc->sym_reloc_entry
Date:   Tue, 30 May 2023 10:21:10 -0700
Message-Id: <a51f0a6f9bbf2494d5a3a449807307e78a940988.1685464332.git.jpoimboe@kernel.org>
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

Convert it to a singly-linked list.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 38.64G
- After:  peak heap memory consumption: 36.89G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 9 +++++----
 tools/objtool/include/objtool/elf.h | 4 ++--
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 16e019a1762c..4b0de0e56068 100644
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
index 60686f746c9e..7b808ac3156c 100644
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
-- 
2.40.1

