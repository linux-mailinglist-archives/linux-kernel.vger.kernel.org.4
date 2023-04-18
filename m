Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13936E6E31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 23:29:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232935AbjDRV2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 17:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232999AbjDRV2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 17:28:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C12CC0B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 14:28:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D12D96395F
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 21:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1075AC4339E;
        Tue, 18 Apr 2023 21:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681853282;
        bh=ntG9ViCrjPSzd67qUu5eqOdkFLpY/tylKZuYgUZ9cSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pk0raLmseMDt9vaVephe1yLCLi62LKnBpUmBkCmZlO4/Sn3u7b5Ln3Zq5YmxpVl+4
         /t87PR/8MhAMcKqkGZLxm4l1AzGlZAYMNnGoWU97LqXABy7V+oyb7fV2BX5mefj5v9
         ZgONh0VS3+sWtvi9PqpNzfztuVF2fvJhT93yBfdsF6NUXBndZ4JFT2xAQj9F9lsBcD
         Ofa4D3QKqOVN02bDfDOTunZixBiISy78Mo4Lczhwm6GMndgpBvRj/QQviAUl1ckPXc
         fEoFqkIPx6TAG28sjHwumFEAsFUNVPf8iv/Ywge5y5uV0EGzIkDfuyalEG+UYb/MOf
         e2KbhGMX43y9Q==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 8/8] objtool: Move noreturn function list to separate file
Date:   Tue, 18 Apr 2023 14:27:54 -0700
Message-Id: <cecacf07a69a244c74474c18b7652627de67a528.1681853186.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681853186.git.jpoimboe@kernel.org>
References: <cover.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes it a little cleaner and easier to maintain.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  5 ++-
 tools/objtool/check.c                   | 44 ++----------------------
 tools/objtool/noreturns.h               | 45 +++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 44 deletions(-)
 create mode 100644 tools/objtool/noreturns.h

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 2cd1fa16ed08..00f0a7e385ec 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -306,9 +306,8 @@ the objtool maintainers.
 3. file.o: warning: objtool: foo+0x48c: bar() is missing a __noreturn annotation
 
    The call from foo() to bar() doesn't return, but bar() is missing the
-   __noreturn annotation.  NOTE: In addition to adding the __noreturn
-   annotation, the function name also needs to be added to
-   'global_noreturns' in tools/objtool/check.c.
+   __noreturn annotation.  NOTE: In addition to annotating the function
+   with __noreturn, please also add it to tools/objtool/noreturns.h.
 
 4. file.o: warning: objtool: func(): can't find starting instruction
    or
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2047a6d5339b..69794c25f857 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -192,49 +192,11 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 	struct instruction *insn;
 	bool empty = true;
 
-	/*
-	 * Unfortunately these have to be hard coded because the noreturn
-	 * attribute isn't provided in ELF data. Keep 'em sorted.
-	 */
+#define NORETURN(func) __stringify(func),
 	static const char * const global_noreturns[] = {
-		"__invalid_creds",
-		"__module_put_and_kthread_exit",
-		"__reiserfs_panic",
-		"__stack_chk_fail",
-		"__ubsan_handle_builtin_unreachable",
-		"arch_call_rest_init",
-		"arch_cpu_idle_dead",
-		"btrfs_assertfail",
-		"cpu_bringup_and_idle",
-		"cpu_startup_entry",
-		"do_exit",
-		"do_group_exit",
-		"do_task_dead",
-		"ex_handler_msr_mce",
-		"fortify_panic",
-		"hlt_play_dead",
-		"hv_ghcb_terminate",
-		"kthread_complete_and_exit",
-		"kthread_exit",
-		"kunit_try_catch_throw",
-		"machine_real_restart",
-		"make_task_dead",
-		"mpt_halt_firmware",
-		"nmi_panic_self_stop",
-		"panic",
-		"panic_smp_self_stop",
-		"rest_init",
-		"rewind_stack_and_make_dead",
-		"sev_es_terminate",
-		"snp_abort",
-		"start_kernel",
-		"stop_this_cpu",
-		"usercopy_abort",
-		"x86_64_start_kernel",
-		"x86_64_start_reservations",
-		"xen_cpu_bringup_again",
-		"xen_start_kernel",
+#include "noreturns.h"
 	};
+#undef NORETURN
 
 	if (!func)
 		return false;
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
new file mode 100644
index 000000000000..cede6068ddf6
--- /dev/null
+++ b/tools/objtool/noreturns.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This is a (sorted!) list of all known __noreturn functions in the kernel.
+ * It's needed for objtool to properly reverse-engineer the control flow graph.
+ *
+ * Yes, this is unfortunate.  A better solution is in the works.
+ */
+NORETURN(__invalid_creds)
+NORETURN(__module_put_and_kthread_exit)
+NORETURN(__reiserfs_panic)
+NORETURN(__stack_chk_fail)
+NORETURN(__ubsan_handle_builtin_unreachable)
+NORETURN(arch_call_rest_init)
+NORETURN(arch_cpu_idle_dead)
+NORETURN(btrfs_assertfail)
+NORETURN(cpu_bringup_and_idle)
+NORETURN(cpu_startup_entry)
+NORETURN(do_exit)
+NORETURN(do_group_exit)
+NORETURN(do_task_dead)
+NORETURN(ex_handler_msr_mce)
+NORETURN(fortify_panic)
+NORETURN(hlt_play_dead)
+NORETURN(hv_ghcb_terminate)
+NORETURN(kthread_complete_and_exit)
+NORETURN(kthread_exit)
+NORETURN(kunit_try_catch_throw)
+NORETURN(machine_real_restart)
+NORETURN(make_task_dead)
+NORETURN(mpt_halt_firmware)
+NORETURN(nmi_panic_self_stop)
+NORETURN(panic)
+NORETURN(panic_smp_self_stop)
+NORETURN(rest_init)
+NORETURN(rewind_stack_and_make_dead)
+NORETURN(sev_es_terminate)
+NORETURN(snp_abort)
+NORETURN(start_kernel)
+NORETURN(stop_this_cpu)
+NORETURN(usercopy_abort)
+NORETURN(x86_64_start_kernel)
+NORETURN(x86_64_start_reservations)
+NORETURN(xen_cpu_bringup_again)
+NORETURN(xen_start_kernel)
-- 
2.39.2

