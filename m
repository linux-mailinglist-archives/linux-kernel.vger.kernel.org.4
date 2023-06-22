Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B015D739F00
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbjFVKzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjFVKzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:55:21 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C56D1FC1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:55:18 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Qmy1z2rnNz9sRn;
        Thu, 22 Jun 2023 12:55:03 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V2sTXnLGuWS1; Thu, 22 Jun 2023 12:55:03 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Qmy1v6Sspz9sRs;
        Thu, 22 Jun 2023 12:54:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DA12C8B763;
        Thu, 22 Jun 2023 12:54:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Xnxzm3g9CkGg; Thu, 22 Jun 2023 12:54:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.14])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3732F8B77C;
        Thu, 22 Jun 2023 12:54:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35MAssr72382583
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 12:54:54 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35MAssQM2382582;
        Thu, 22 Jun 2023 12:54:54 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sathvika Vasireddy <sv@linux.ibm.com>,
        Naveen N Rao <naveen@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 08/14] objtool: Fix JUMP_ENTRY_SIZE for bi-arch like powerpc
Date:   Thu, 22 Jun 2023 12:54:30 +0200
Message-Id: <85a0e5fde0c36219332a74871ef4699008ec7edb.1687430631.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687430631.git.christophe.leroy@csgroup.eu>
References: <cover.1687430631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687431272; l=2995; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=oDQ+yu2c80GlkN1xTGQWllMn8lTFly+buQPlZ9vYv6s=; b=6vfsq3Ai6s9XeMQ1kxtJ6r3TF2kx85UhChrMJNVC4mdQ8sLprQlge6yFmcRWx40NJePTmHT3I XfRCVc4YhaAB1BLREE9Z8hKbzZY5Mz6XVdJI3m/cPrUXr8TtPxzAFbs
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	struct jump_entry {
		s32 code;
		s32 target;
		long key;
	};

It means that the size of the third argument depends on
whether we are building a 32 bits or 64 bits kernel.

Therefore JUMP_ENTRY_SIZE must depend on elf_class_addrsize(elf).

To allow that, entries[] table must be initialised at runtime. This is
easily done by moving it into its only user which is special_get_alts().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../arch/powerpc/include/arch/special.h       |  2 +-
 tools/objtool/special.c                       | 55 +++++++++----------
 2 files changed, 28 insertions(+), 29 deletions(-)

diff --git a/tools/objtool/arch/powerpc/include/arch/special.h b/tools/objtool/arch/powerpc/include/arch/special.h
index ffef9ada7133..ede05633c2e4 100644
--- a/tools/objtool/arch/powerpc/include/arch/special.h
+++ b/tools/objtool/arch/powerpc/include/arch/special.h
@@ -6,7 +6,7 @@
 #define EX_ORIG_OFFSET 0
 #define EX_NEW_OFFSET 4
 
-#define JUMP_ENTRY_SIZE 16
+#define JUMP_ENTRY_SIZE (8 + elf_class_addrsize(elf)) /* 12 on PPC32, 16 on PPC64 */
 #define JUMP_ORIG_OFFSET 0
 #define JUMP_NEW_OFFSET 4
 #define JUMP_KEY_OFFSET 8
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index baa85c31526b..4015c1cd0fe1 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -26,34 +26,6 @@ struct special_entry {
 	unsigned char key; /* jump_label key */
 };
 
-static const struct special_entry entries[] = {
-	{
-		.sec = ".altinstructions",
-		.group = true,
-		.size = ALT_ENTRY_SIZE,
-		.orig = ALT_ORIG_OFFSET,
-		.orig_len = ALT_ORIG_LEN_OFFSET,
-		.new = ALT_NEW_OFFSET,
-		.new_len = ALT_NEW_LEN_OFFSET,
-		.feature = ALT_FEATURE_OFFSET,
-	},
-	{
-		.sec = "__jump_table",
-		.jump_or_nop = true,
-		.size = JUMP_ENTRY_SIZE,
-		.orig = JUMP_ORIG_OFFSET,
-		.new = JUMP_NEW_OFFSET,
-		.key = JUMP_KEY_OFFSET,
-	},
-	{
-		.sec = "__ex_table",
-		.size = EX_ENTRY_SIZE,
-		.orig = EX_ORIG_OFFSET,
-		.new = EX_NEW_OFFSET,
-	},
-	{},
-};
-
 void __weak arch_handle_alternative(unsigned short feature, struct special_alt *alt)
 {
 }
@@ -144,6 +116,33 @@ int special_get_alts(struct elf *elf, struct list_head *alts)
 	unsigned int nr_entries;
 	struct special_alt *alt;
 	int idx, ret;
+	const struct special_entry entries[] = {
+		{
+			.sec = ".altinstructions",
+			.group = true,
+			.size = ALT_ENTRY_SIZE,
+			.orig = ALT_ORIG_OFFSET,
+			.orig_len = ALT_ORIG_LEN_OFFSET,
+			.new = ALT_NEW_OFFSET,
+			.new_len = ALT_NEW_LEN_OFFSET,
+			.feature = ALT_FEATURE_OFFSET,
+		},
+		{
+			.sec = "__jump_table",
+			.jump_or_nop = true,
+			.size = JUMP_ENTRY_SIZE,
+			.orig = JUMP_ORIG_OFFSET,
+			.new = JUMP_NEW_OFFSET,
+			.key = JUMP_KEY_OFFSET,
+		},
+		{
+			.sec = "__ex_table",
+			.size = EX_ENTRY_SIZE,
+			.orig = EX_ORIG_OFFSET,
+			.new = EX_NEW_OFFSET,
+		},
+		{},
+	};
 
 	INIT_LIST_HEAD(alts);
 
-- 
2.40.1

