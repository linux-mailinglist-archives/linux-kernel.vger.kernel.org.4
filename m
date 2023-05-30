Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0AB716AC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 19:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbjE3RWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 13:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbjE3RVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 13:21:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC43FE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 10:21:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB121630DB
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 17:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61182C433A7;
        Tue, 30 May 2023 17:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685467298;
        bh=FMKirBi6c8n5y7aSisMhuMOzaOwJD8A67Hi2Xih1kgQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q96xRZ8Gp3x4c8ouOPI335jvybyekk1BwDQAeA4eP0jRMs3a7efTb3cfbRmzkXEEl
         cllEIbQjA7bqxKAzUM1O+6iB3NqPJcSdoHbmvokyraiGcx4j754gzZrt4DyoqCuqMY
         UttBIfS/aj4ZwmpsOszBVx1Jj66a+daRDPbftrsyPFrnpgV+zcTCEoI7K4VfsCCPs9
         Sgv00CbKcztQsuQPnM4xonVnO0iYtuUF7BTrQlnR8UoDTcp+S7XF5vHWI29SkX1V6U
         pk/+qJEolqLZIfBKFh9+XaASjDhO5FHIi/W3vAsCjM9LD6kNjqERjMRh0RQsxFnTf6
         tj/kky7o29eqg==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH 19/22] objtool: Shrink elf hash nodes
Date:   Tue, 30 May 2023 10:21:11 -0700
Message-Id: <6e8cd305ed22e743c30d6e72cfdc1be20fb94cd4.1685464332.git.jpoimboe@kernel.org>
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

Instead of using hlist for the 'struct elf' hashes, use a custom
single-linked list scheme.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 36.89G
- After:  peak heap memory consumption: 35.12G

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 52 ++++++++++++++++++++++++-----
 tools/objtool/include/objtool/elf.h | 24 +++++++------
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4b0de0e56068..04038b1324cf 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -32,16 +32,52 @@ static inline u32 str_hash(const char *str)
 #define __elf_table(name)	(elf->name##_hash)
 #define __elf_bits(name)	(elf->name##_bits)
 
-#define elf_hash_add(name, node, key) \
-	hlist_add_head(node, &__elf_table(name)[hash_min(key, __elf_bits(name))])
+#define __elf_table_entry(name, key) \
+	__elf_table(name)[hash_min(key, __elf_bits(name))]
 
-#define elf_hash_for_each_possible(name, obj, member, key) \
-	hlist_for_each_entry(obj, &__elf_table(name)[hash_min(key, __elf_bits(name))], member)
+#define elf_hash_add(name, node, key)					\
+({									\
+	struct elf_hash_node *__node = node;				\
+	__node->next = __elf_table_entry(name, key);			\
+	__elf_table_entry(name, key) = __node;				\
+})
+
+static inline void __elf_hash_del(struct elf_hash_node *node,
+				  struct elf_hash_node **head)
+{
+	struct elf_hash_node *cur, *prev;
+
+	if (node == *head) {
+		*head = node->next;
+		return;
+	}
+
+	for (prev = NULL, cur = *head; cur; prev = cur, cur = cur->next) {
+		if (cur == node) {
+			prev->next = cur->next;
+			break;
+		}
+	}
+}
+
+#define elf_hash_del(name, node, key) \
+	__elf_hash_del(node, &__elf_table_entry(name, key))
+
+#define elf_list_entry(ptr, type, member)				\
+({									\
+	typeof(ptr) __ptr = (ptr);					\
+	__ptr ? container_of(__ptr, type, member) : NULL;		\
+})
+
+#define elf_hash_for_each_possible(name, obj, member, key)		\
+	for (obj = elf_list_entry(__elf_table_entry(name, key), typeof(*obj), member); \
+	     obj;							\
+	     obj = elf_list_entry(obj->member.next, typeof(*(obj)), member))
 
 #define elf_alloc_hash(name, size) \
 ({ \
 	__elf_bits(name) = max(10, ilog2(size)); \
-	__elf_table(name) = mmap(NULL, sizeof(struct hlist_head) << __elf_bits(name), \
+	__elf_table(name) = mmap(NULL, sizeof(struct elf_hash_node *) << __elf_bits(name), \
 				 PROT_READ|PROT_WRITE, \
 				 MAP_PRIVATE|MAP_ANON, -1, 0); \
 	if (__elf_table(name) == (void *)-1L) { \
@@ -713,10 +749,10 @@ __elf_create_symbol(struct elf *elf, struct symbol *sym)
 	first_non_local = symtab->sh.sh_info;
 	old = find_symbol_by_index(elf, first_non_local);
 	if (old) {
-		old->idx = new_idx;
 
-		hlist_del(&old->hash);
-		elf_hash_add(symbol, &old->hash, old->idx);
+		elf_hash_del(symbol, &old->hash, old->idx);
+		elf_hash_add(symbol, &old->hash, new_idx);
+		old->idx = new_idx;
 
 		if (elf_update_symbol(elf, symtab, symtab_shndx, old)) {
 			WARN("elf_update_symbol move");
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index 7b808ac3156c..03a9040f696c 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -26,10 +26,14 @@
 #define ELF_C_READ_MMAP ELF_C_READ
 #endif
 
+struct elf_hash_node {
+	struct elf_hash_node *next;
+};
+
 struct section {
 	struct list_head list;
-	struct hlist_node hash;
-	struct hlist_node name_hash;
+	struct elf_hash_node hash;
+	struct elf_hash_node name_hash;
 	GElf_Shdr sh;
 	struct rb_root_cached symbol_tree;
 	struct list_head symbol_list;
@@ -45,8 +49,8 @@ struct section {
 struct symbol {
 	struct list_head list;
 	struct rb_node node;
-	struct hlist_node hash;
-	struct hlist_node name_hash;
+	struct elf_hash_node hash;
+	struct elf_hash_node name_hash;
 	GElf_Sym sym;
 	struct section *sec;
 	char *name;
@@ -67,7 +71,7 @@ struct symbol {
 };
 
 struct reloc {
-	struct hlist_node hash;
+	struct elf_hash_node hash;
 	union {
 		GElf_Rela rela;
 		GElf_Rel  rel;
@@ -93,11 +97,11 @@ struct elf {
 	int section_name_bits;
 	int reloc_bits;
 
-	struct hlist_head *symbol_hash;
-	struct hlist_head *symbol_name_hash;
-	struct hlist_head *section_hash;
-	struct hlist_head *section_name_hash;
-	struct hlist_head *reloc_hash;
+	struct elf_hash_node **symbol_hash;
+	struct elf_hash_node **symbol_name_hash;
+	struct elf_hash_node **section_hash;
+	struct elf_hash_node **section_name_hash;
+	struct elf_hash_node **reloc_hash;
 
 	struct section *section_data;
 	struct symbol *symbol_data;
-- 
2.40.1

