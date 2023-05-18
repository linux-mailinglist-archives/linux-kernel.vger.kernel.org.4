Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17245707ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbjERLI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjERLI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:08:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC841FE3;
        Thu, 18 May 2023 04:08:03 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnYAIDQ8NLqV20AkYg6dGovI2YrcEci0y0Arz8TfA0E=;
        b=Itgm20SoQ7oDsj87UPR/DD4Bkus4v39zJeGXIIKHXunR6qOUC1+tLAvCk1ZARTZAUSiB94
        2I1MJjd206T7TOfONgkGw12N/otOqgX5b3Seqo2Id8Xpeo8KCGUS+ZDmEzzql6QUifUcnY
        MrIFQux9guhv3gZWFhxU9nm2eRxLorzUIsbe9JsZHWdQmZU+T2bzjmodh3gSQ+dGuQjLsk
        b2p824/cKcIHQcxwTGiAzBPvkcZyWOI2OxBEyTqCsw/vTNJidMf8BBa+1D6rR2Y4rbvSc3
        9OwhijMsjvP6sqKiaKPPjOtCGD7VDgKmyMzlFl4TNU5S1LbAFendpEN20y0keQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408081;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnYAIDQ8NLqV20AkYg6dGovI2YrcEci0y0Arz8TfA0E=;
        b=/cJ8Ipd6SpW5XWi07GSvyxcC3Z46l+ogCzGa61d42QAcanTQKB60s9fQZvJu1fPRutICim
        sIuedbrJl+YtKBDw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Move noreturn function list to separate file
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <cecacf07a69a244c74474c18b7652627de67a528.1681853186.git.jpoimboe@kernel.org>
References: <cecacf07a69a244c74474c18b7652627de67a528.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808078.404.10229426089395328822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6245ce4ab670166efcdae843c35c14e4c0811aa3
Gitweb:        https://git.kernel.org/tip/6245ce4ab670166efcdae843c35c14e4c0811aa3
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:27:54 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:55 -07:00

objtool: Move noreturn function list to separate file

This makes it a little cleaner and easier to maintain.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/cecacf07a69a244c74474c18b7652627de67a528.1681853186.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/Documentation/objtool.txt |  5 +--
 tools/objtool/check.c                   | 44 +----------------------
 tools/objtool/noreturns.h               | 45 ++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 44 deletions(-)
 create mode 100644 tools/objtool/noreturns.h

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index f9345e0..fe39c2a 100644
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
index 8c2762d..a13c257 100644
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
index 0000000..cede606
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
