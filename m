Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6C874F475
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 18:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbjGKQJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 12:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbjGKQJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 12:09:00 -0400
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5CE5E5C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 09:08:58 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [192.168.12.233])
        by localhost (Postfix) with ESMTP id 4R0m5F74D4z9sFD;
        Tue, 11 Jul 2023 18:08:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id y-Uvf8up4Fog; Tue, 11 Jul 2023 18:08:49 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4R0m5C2xzRz9sFC;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 616888B763;
        Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id vp_5QqFmxrez; Tue, 11 Jul 2023 18:08:47 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.233.184])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CBF258B779;
        Tue, 11 Jul 2023 18:08:46 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 36BG8kl83696852
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 18:08:46 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 36BG8kP03696851;
        Tue, 11 Jul 2023 18:08:46 +0200
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
Subject: [PATCH v4 13/15] objtool: Prepare noreturns.h for more architectures
Date:   Tue, 11 Jul 2023 18:08:39 +0200
Message-ID: <cfe3ee3caf3467d0ef5c14becc97534376328492.1689091394.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689091394.git.christophe.leroy@csgroup.eu>
References: <cover.1689091394.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689091706; l=2884; i=christophe.leroy@csgroup.eu; s=20211009; h=from:subject:message-id; bh=VP6S87HnnUqkX0M6jjPWdL69C8RBj2wF1wd8aPIq2Vc=; b=byCCiss6/HehxbWPdM4D62jCIc16bp8efzQXnF+3YAQ/r9qOmO417uSIaMD7StSNPMTNynwMj RXYM24BCDEHBGDv7s4rDb7oinOUcQ0O8VXWPQ2xPBsvC+1v4Zm7vVtl
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

noreturns.h is a mix of x86 specific functions and more generic
core functions.

In preparation of inclusion of powerpc, split x86 functions out of
noreturns.h into arch/noreturns.h

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 .../objtool/arch/x86/include/arch/noreturns.h | 20 +++++++++++++++++++
 tools/objtool/noreturns.h                     | 14 ++-----------
 2 files changed, 22 insertions(+), 12 deletions(-)
 create mode 100644 tools/objtool/arch/x86/include/arch/noreturns.h

diff --git a/tools/objtool/arch/x86/include/arch/noreturns.h b/tools/objtool/arch/x86/include/arch/noreturns.h
new file mode 100644
index 000000000000..a4262aff3917
--- /dev/null
+++ b/tools/objtool/arch/x86/include/arch/noreturns.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This is a (sorted!) list of all known __noreturn functions in arch/x86.
+ * It's needed for objtool to properly reverse-engineer the control flow graph.
+ *
+ * Yes, this is unfortunate.  A better solution is in the works.
+ */
+NORETURN(cpu_bringup_and_idle)
+NORETURN(ex_handler_msr_mce)
+NORETURN(hlt_play_dead)
+NORETURN(hv_ghcb_terminate)
+NORETURN(machine_real_restart)
+NORETURN(rewind_stack_and_make_dead)
+NORETURN(sev_es_terminate)
+NORETURN(snp_abort)
+NORETURN(x86_64_start_kernel)
+NORETURN(x86_64_start_reservations)
+NORETURN(xen_cpu_bringup_again)
+NORETURN(xen_start_kernel)
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index e45c7cb1d5bc..b5e0f078dbb6 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <arch/noreturns.h>
+
 /*
  * This is a (sorted!) list of all known __noreturn functions in the kernel.
  * It's needed for objtool to properly reverse-engineer the control flow graph.
@@ -14,32 +16,20 @@ NORETURN(__stack_chk_fail)
 NORETURN(__ubsan_handle_builtin_unreachable)
 NORETURN(arch_call_rest_init)
 NORETURN(arch_cpu_idle_dead)
-NORETURN(cpu_bringup_and_idle)
 NORETURN(cpu_startup_entry)
 NORETURN(do_exit)
 NORETURN(do_group_exit)
 NORETURN(do_task_dead)
-NORETURN(ex_handler_msr_mce)
 NORETURN(fortify_panic)
-NORETURN(hlt_play_dead)
-NORETURN(hv_ghcb_terminate)
 NORETURN(kthread_complete_and_exit)
 NORETURN(kthread_exit)
 NORETURN(kunit_try_catch_throw)
-NORETURN(machine_real_restart)
 NORETURN(make_task_dead)
 NORETURN(mpt_halt_firmware)
 NORETURN(nmi_panic_self_stop)
 NORETURN(panic)
 NORETURN(panic_smp_self_stop)
 NORETURN(rest_init)
-NORETURN(rewind_stack_and_make_dead)
-NORETURN(sev_es_terminate)
-NORETURN(snp_abort)
 NORETURN(start_kernel)
 NORETURN(stop_this_cpu)
 NORETURN(usercopy_abort)
-NORETURN(x86_64_start_kernel)
-NORETURN(x86_64_start_reservations)
-NORETURN(xen_cpu_bringup_again)
-NORETURN(xen_start_kernel)
-- 
2.41.0

