Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE5164023D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232957AbiLBIej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiLBId7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:33:59 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67BDAD309
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 00:32:06 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4NNmQF43P9z9sYk;
        Fri,  2 Dec 2022 09:32:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id QLKfa2xsI8g4; Fri,  2 Dec 2022 09:32:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4NNmQF2y4hz9sYc;
        Fri,  2 Dec 2022 09:32:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 559AA8B787;
        Fri,  2 Dec 2022 09:32:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id L6WRUN_HFJhV; Fri,  2 Dec 2022 09:32:05 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.19])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 074598B763;
        Fri,  2 Dec 2022 09:32:04 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2B28VqB8273731
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 2 Dec 2022 09:31:52 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2B28VqBx273730;
        Fri, 2 Dec 2022 09:31:52 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>, bgray@linux.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 4/5] powerpc/feature-fixups: Do not patch init section after init
Date:   Fri,  2 Dec 2022 09:31:42 +0100
Message-Id: <8e9311fc1b057e4e6a2a3a0701ebcc74b787affe.1669969781.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <f67d2a109404d03e8fdf1ea15388c8778337a76b.1669969781.git.christophe.leroy@csgroup.eu>
References: <f67d2a109404d03e8fdf1ea15388c8778337a76b.1669969781.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1669969790; l=1968; s=20211009; h=from:subject:message-id; bh=hHxQ2WszyYP2a1XlZcywBZ+B2PlQxe0kC8ry9n30YxY=; b=wlNhlgnG1lELxDeDXHxq4KZutzvZpjBv2qwFjzpjIKBOmR1BDFY1QO3aPtmDhga3bH5AY03YexlR P14eDEbCCR6OEn/tzaCpSdJGXUn/UOJm3m9SPQdoOpUnd7ed2VHe
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once init section is freed, attempting to patch init code
ends up in the weed.

Commit 51c3c62b58b3 ("powerpc: Avoid code patching freed init sections")
protected patch_instruction() against that, but it is the responsibility
of the caller to ensure that the patched memory is valid.

In the same spirit as jump_label with its jump_label_can_update()
function, add is_fixup_addr_valid() function to skip patching on
freed init section.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/feature-fixups.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 25168a59d1ce..80def1c2afcb 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -118,6 +118,12 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 }
 
 #ifdef CONFIG_PPC_BARRIER_NOSPEC
+static bool is_fixup_addr_valid(void *dest, size_t size)
+{
+	return system_state < SYSTEM_FREEING_INITMEM ||
+	       !init_section_contains(dest, size);
+}
+
 static int do_patch_fixups(long *start, long *end, unsigned int *instrs, int num)
 {
 	int i;
@@ -126,6 +132,9 @@ static int do_patch_fixups(long *start, long *end, unsigned int *instrs, int num
 		int j;
 		unsigned int *dest = (void *)start + *start;
 
+		if (!is_fixup_addr_valid(dest, sizeof(*instrs) * num))
+			continue;
+
 		pr_devel("patching dest %lx\n", (unsigned long)dest);
 
 		for (j = 0; j < num; j++)
@@ -144,6 +153,9 @@ static int do_patch_entry_fixups(long *start, long *end, unsigned int *instrs,
 	for (i = 0; start < end; start++, i++) {
 		unsigned int *dest = (void *)start + *start;
 
+		if (!is_fixup_addr_valid(dest, sizeof(*instrs) * 3))
+			continue;
+
 		pr_devel("patching dest %lx\n", (unsigned long)dest);
 
 		// See comment in do_entry_flush_fixups() RE order of patching
-- 
2.38.1

