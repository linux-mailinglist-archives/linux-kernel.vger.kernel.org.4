Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5393739F02
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 12:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjFVKzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 06:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjFVKzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 06:55:35 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20421BF5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 03:55:23 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4Qmy210013z9sRm;
        Thu, 22 Jun 2023 12:55:04 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JzeXHVWfZ6P7; Thu, 22 Jun 2023 12:55:04 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Qmy1v70Wsz9sRt;
        Thu, 22 Jun 2023 12:54:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC07F8B763;
        Thu, 22 Jun 2023 12:54:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id qI5FN3vJJBbQ; Thu, 22 Jun 2023 12:54:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.232.14])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3B8978B77D;
        Thu, 22 Jun 2023 12:54:59 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 35MAsrUl2382567
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 22 Jun 2023 12:54:53 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 35MAsrTX2382566;
        Thu, 22 Jun 2023 12:54:53 +0200
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
Subject: [PATCH v2 04/14] powerpc/kuap: Make disabling KUAP at boottime impossible except on book3s/64
Date:   Thu, 22 Jun 2023 12:54:26 +0200
Message-Id: <8e178a6823aee38af74dc59d246185bfc4d846d9.1687430631.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1687430631.git.christophe.leroy@csgroup.eu>
References: <cover.1687430631.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687431271; l=3711; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=qpT8lcamvy7dK8UQJBZ5uk7RcXiHWOqfTZFEErmAGRw=; b=U9dBB/+u2VxlX8iaDgxnhExM/RgR10aljKoyAeC7MwwAM4kZ9SACfIvBAxTwuSXLsBum47C4N sDEorkMzxQ9BeRp2ptsdZog+OJi/GMkLEY8tvjfOdyAwl5qhcZkfMOb
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

It is possible to disable KUAP at boottime with 'nosmap' parameter.

That is implemented with jump_label hence adds a 'nop' in front
of each open/close of userspace access.

From a security point of view it makes sence to disallow disabling
KUAP. And on processors like the 8xx where 'nop' is not seamless,
it saves a few cycles.

In addition, objtool UACCESS validation cannot cope with that
feature because it visits every static branches independentely and
is not able to see that when a UACCESS enable is skipped, the
matching UACCESS disable is skipped as well.

So make KUAP always active when selected in kernel config.

In the future it may be re-implemented by noping the instructions
instead of using static branches.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/kup.h  |  4 +---
 arch/powerpc/mm/book3s32/kuap.c | 15 ++++++---------
 arch/powerpc/mm/init-common.c   |  6 +++---
 arch/powerpc/mm/nohash/kup.c    |  8 +-------
 4 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/include/asm/kup.h b/arch/powerpc/include/asm/kup.h
index 74b7f4cee2ed..a02340535efa 100644
--- a/arch/powerpc/include/asm/kup.h
+++ b/arch/powerpc/include/asm/kup.h
@@ -49,11 +49,9 @@ void setup_kuep(bool disabled);
 void setup_kuap(bool disabled);
 
 #ifndef kuap_is_disabled
-extern struct static_key_false disable_kuap_key;
-
 static __always_inline bool kuap_is_disabled(void)
 {
-	return static_branch_unlikely(&disable_kuap_key);
+	return false;
 }
 #endif
 #else
diff --git a/arch/powerpc/mm/book3s32/kuap.c b/arch/powerpc/mm/book3s32/kuap.c
index c5484729b595..639219d0a821 100644
--- a/arch/powerpc/mm/book3s32/kuap.c
+++ b/arch/powerpc/mm/book3s32/kuap.c
@@ -17,17 +17,14 @@ EXPORT_SYMBOL(kuap_unlock_all_ool);
 
 void setup_kuap(bool disabled)
 {
-	if (!disabled) {
-		kuap_lock_all_ool();
-		init_mm.context.sr0 |= SR_KS;
-		current->thread.sr0 |= SR_KS;
-	}
+	WARN_ON(disabled);
+
+	kuap_lock_all_ool();
+	init_mm.context.sr0 |= SR_KS;
+	current->thread.sr0 |= SR_KS;
 
 	if (smp_processor_id() != boot_cpuid)
 		return;
 
-	if (disabled)
-		static_branch_enable(&disable_kuap_key);
-	else
-		pr_info("Activating Kernel Userspace Access Protection\n");
+	pr_info("Activating Kernel Userspace Access Protection\n");
 }
diff --git a/arch/powerpc/mm/init-common.c b/arch/powerpc/mm/init-common.c
index 74e140b1efef..237086742ec7 100644
--- a/arch/powerpc/mm/init-common.c
+++ b/arch/powerpc/mm/init-common.c
@@ -32,9 +32,6 @@ EXPORT_SYMBOL_GPL(kernstart_virt_addr);
 bool disable_kuep = !IS_ENABLED(CONFIG_PPC_KUEP);
 bool disable_kuap = !IS_ENABLED(CONFIG_PPC_KUAP);
 
-struct static_key_false disable_kuap_key;
-EXPORT_SYMBOL(disable_kuap_key);
-
 static int __init parse_nosmep(char *p)
 {
 	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64))
@@ -48,6 +45,9 @@ early_param("nosmep", parse_nosmep);
 
 static int __init parse_nosmap(char *p)
 {
+	if (!IS_ENABLED(CONFIG_PPC_BOOK3S_64))
+		return 0;
+
 	disable_kuap = true;
 	pr_warn("Disabling Kernel Userspace Access Protection\n");
 	return 0;
diff --git a/arch/powerpc/mm/nohash/kup.c b/arch/powerpc/mm/nohash/kup.c
index 4e22adfa2aa8..3bb79f89de06 100644
--- a/arch/powerpc/mm/nohash/kup.c
+++ b/arch/powerpc/mm/nohash/kup.c
@@ -15,13 +15,7 @@
 #ifdef CONFIG_PPC_KUAP
 void setup_kuap(bool disabled)
 {
-	if (disabled) {
-		if (IS_ENABLED(CONFIG_40x))
-			disable_kuep = true;
-		if (smp_processor_id() == boot_cpuid)
-			static_branch_enable(&disable_kuap_key);
-		return;
-	}
+	WARN_ON(disabled);
 
 	pr_info("Activating Kernel Userspace Access Protection\n");
 
-- 
2.40.1

