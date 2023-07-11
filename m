Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8146D74F42E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbjGKP7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjGKP7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:59:41 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2BC810DF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:59:39 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0ltS35Zcz9sFD;
        Tue, 11 Jul 2023 17:59:28 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DZuap8RFcEqn; Tue, 11 Jul 2023 17:59:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0ltP5f2mz9sFC;
        Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BD63F8B779;
        Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id gqZ4cje9FlEz; Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5E7958B77C;
        Tue, 11 Jul 2023 17:59:25 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BFxPmh3695847
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 17:59:25 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BFxPik3695846;
        Tue, 11 Jul 2023 17:59:25 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 4/9] powerpc/features: Add capability to update mmu features later
Date:   Tue, 11 Jul 2023 17:59:16 +0200
Message-ID: <31b27ee2c9d338f4f82cd8cd69d6bff979495290.1689091022.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689091022.git.christophe.leroy@csgroup.eu>
References: <cover.1689091022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091151; l=4060; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=GdD7c2l/Uyecqxws9+sH8Um0e0MhamGooysf3NrpJOA=; b=apcbpvrgNY9hfKbaorzyophs2AAOV8EGShvFrouJzfudh61za4nVtCjVIXRrw0y31OyXOCjOu 6r35QqReEnzDiQU+oJHIZR6prCcwU2OYIw0u9+P6qL/X4DbP1N1EO9a
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On powerpc32, features fixup is performed very early and that's too
early to read the cmdline and take into account 'nosmap' parameter.

On the other hand, no userspace access is performed that early and
KUAP feature fixup can be performed later.

Add a function to update mmu features. The function is passed a
mask with the features that can be updated.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/feature-fixups.h |  1 +
 arch/powerpc/lib/feature-fixups.c         | 31 ++++++++++++++++++++---
 2 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index ac605fc369c4..77824bd289a3 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -292,6 +292,7 @@ extern long __start___barrier_nospec_fixup, __stop___barrier_nospec_fixup;
 extern long __start__btb_flush_fixup, __stop__btb_flush_fixup;
 
 void apply_feature_fixups(void);
+void update_mmu_feature_fixups(unsigned long mask);
 void setup_feature_keys(void);
 #endif
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 80def1c2afcb..4f82581ca203 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -67,7 +67,8 @@ static int patch_alt_instruction(u32 *src, u32 *dest, u32 *alt_start, u32 *alt_e
 	return 0;
 }
 
-static int patch_feature_section(unsigned long value, struct fixup_entry *fcur)
+static int patch_feature_section_mask(unsigned long value, unsigned long mask,
+				      struct fixup_entry *fcur)
 {
 	u32 *start, *end, *alt_start, *alt_end, *src, *dest;
 
@@ -79,7 +80,7 @@ static int patch_feature_section(unsigned long value, struct fixup_entry *fcur)
 	if ((alt_end - alt_start) > (end - start))
 		return 1;
 
-	if ((value & fcur->mask) == fcur->value)
+	if ((value & fcur->mask & mask) == (fcur->value & mask))
 		return 0;
 
 	src = alt_start;
@@ -97,7 +98,8 @@ static int patch_feature_section(unsigned long value, struct fixup_entry *fcur)
 	return 0;
 }
 
-void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
+static void do_feature_fixups_mask(unsigned long value, unsigned long mask,
+				   void *fixup_start, void *fixup_end)
 {
 	struct fixup_entry *fcur, *fend;
 
@@ -105,7 +107,7 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 	fend = fixup_end;
 
 	for (; fcur < fend; fcur++) {
-		if (patch_feature_section(value, fcur)) {
+		if (patch_feature_section_mask(value, mask, fcur)) {
 			WARN_ON(1);
 			printk("Unable to patch feature section at %p - %p" \
 				" with %p - %p\n",
@@ -117,6 +119,11 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 	}
 }
 
+void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
+{
+	do_feature_fixups_mask(value, ~0, fixup_start, fixup_end);
+}
+
 #ifdef CONFIG_PPC_BARRIER_NOSPEC
 static bool is_fixup_addr_valid(void *dest, size_t size)
 {
@@ -651,6 +658,17 @@ void __init apply_feature_fixups(void)
 	do_final_fixups();
 }
 
+void __init update_mmu_feature_fixups(unsigned long mask)
+{
+	saved_mmu_features &= ~mask;
+	saved_mmu_features |= cur_cpu_spec->mmu_features & mask;
+
+	do_feature_fixups_mask(cur_cpu_spec->mmu_features, mask,
+			       PTRRELOC(&__start___mmu_ftr_fixup),
+			       PTRRELOC(&__stop___mmu_ftr_fixup));
+	mmu_feature_keys_init();
+}
+
 void __init setup_feature_keys(void)
 {
 	/*
@@ -683,6 +701,11 @@ late_initcall(check_features);
 #define check(x)	\
 	if (!(x)) printk("feature-fixups: test failed at line %d\n", __LINE__);
 
+static int patch_feature_section(unsigned long value, struct fixup_entry *fcur)
+{
+	return patch_feature_section_mask(value, ~0, fcur);
+}
+
 /* This must be after the text it fixes up, vmlinux.lds.S enforces that atm */
 static struct fixup_entry fixup;
 
-- 
2.41.0

