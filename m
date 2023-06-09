Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA2572918E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239154AbjFIHrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239076AbjFIHrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AE330D2;
        Fri,  9 Jun 2023 00:47:29 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDPaSVjfCDzLcF7//YwLg51Z4m12AiJ5I8kqkjtTci0=;
        b=kTNdN0NR7S0TjQPUsvSvSE7saueobAW5K6rW+FxTOo5pbRot7VXXGb5NS94rqVfqDtKnSw
        /UJ9/8TFfsuwVeSdjoRmj08TgobqGgCewPKgCFkdvuY9jMs0XXOb4iga1O/ewhpqv+8Ugf
        Cv95YRGB8zxBFR5CHBe7SbNDK+YCTtAsM5vkY70TCnTG0j4hNq04VbIjmqGhhkXTkdbj+2
        Mx04lQBKczIqh3XDDGzxs8Xta0/TXjYqmRmffc7f3Mus6Tl90UrrSfFZFvQZne76Vz9VBO
        CNGnJwkeNqnk1cArdI4Sr8VTSW4Eb8GJkiQnDtMw5OXHGmCpCRbD9lldQYiqIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDPaSVjfCDzLcF7//YwLg51Z4m12AiJ5I8kqkjtTci0=;
        b=XqOFBEnugSUAv9V6s5vi3R2SG8CpABeq+l/8QAvoF1IH1nhvLbepxlGPBAkbnLBSqhw87r
        V0P1fvISDSH8dWBQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Shrink elf hash nodes
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <6e8cd305ed22e743c30d6e72cfdc1be20fb94cd4.1685464332.git.jpoimboe@kernel.org>
References: <6e8cd305ed22e743c30d6e72cfdc1be20fb94cd4.1685464332.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629684776.404.12793392226437928486.tip-bot2@tip-bot2>
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

Commit-ID:     02b54001066364aee72bc4c802b42a96c6e0dc1f
Gitweb:        https://git.kernel.org/tip/02b54001066364aee72bc4c802b42a96c6e0dc1f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 30 May 2023 10:21:11 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 10:03:25 -07:00

objtool: Shrink elf hash nodes

Instead of using hlist for the 'struct elf' hashes, use a custom
single-linked list scheme.

With allyesconfig + CONFIG_DEBUG_INFO:

- Before: peak heap memory consumption: 36.89G
- After:  peak heap memory consumption: 35.12G

Link: https://lore.kernel.org/r/6e8cd305ed22e743c30d6e72cfdc1be20fb94cd4.1685464332.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/elf.c                 | 52 +++++++++++++++++++++++-----
 tools/objtool/include/objtool/elf.h | 24 +++++++------
 2 files changed, 58 insertions(+), 18 deletions(-)

diff --git a/tools/objtool/elf.c b/tools/objtool/elf.c
index 4b0de0e..04038b1 100644
--- a/tools/objtool/elf.c
+++ b/tools/objtool/elf.c
@@ -32,16 +32,52 @@ static inline u32 str_hash(const char *str)
 #define __elf_table(name)	(elf->name##_hash)
 #define __elf_bits(name)	(elf->name##_bits)
 
-#define elf_hash_add(name, node, key) \
-	hlist_add_head(node, &__elf_table(name)[hash_min(key, __elf_bits(name))])
+#define __elf_table_entry(name, key) \
+	__elf_table(name)[hash_min(key, __elf_bits(name))]
+
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
 
-#define elf_hash_for_each_possible(name, obj, member, key) \
-	hlist_for_each_entry(obj, &__elf_table(name)[hash_min(key, __elf_bits(name))], member)
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
index 7b808ac..03a9040 100644
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
