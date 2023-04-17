Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D510C6E45BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 12:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjDQKvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 06:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjDQKut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:50:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86017690;
        Mon, 17 Apr 2023 03:50:03 -0700 (PDT)
Date:   Mon, 17 Apr 2023 10:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681728408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zd9+BPhdTSoYfBjHrlvprQxOAwNDesh2RaIgh/3N3uI=;
        b=Nf/3uSKwBO93jCeGRdBr0IIex+XWkI+OSZnPZeTGx4NKkqdk2aJHSmNI1HmW+QH9VHFBhK
        InYe4HkVCNXVJEfT1C15p7QzK4VAxsPowH4752rU2ZCwILlsUPOWoqvqeG+boAS4I/BBAg
        UzsNPiQ8kKRykNf3SBy4OIrKu33VZ28XqJtb3zLkz9VupdAIgbU8HwvPvzRpZBzgO5sCYN
        gyh2xPvpweI+CvIFBr+uNhZaupz1YbRQhYhzeyhdjyi+C0/aa6fm4srJKMju/IbFa7T6FV
        bop8W5Y71EemMjGZTurZ5kH7OSVUmJUn1aUNIL+0jdbRz0MLG82EQUCoEbPmVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681728408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zd9+BPhdTSoYfBjHrlvprQxOAwNDesh2RaIgh/3N3uI=;
        b=PWp4+BbZ5GKzlSMv4UvSKAG0KfAxXgWU4k5AHusjyi4B5POftuleddfedg6YkJ73f4ape1
        FndtWhsWta1MVWDQ==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] init: Mark start_kernel() __noreturn
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <7069acf026a195f26a88061227fba5a3b0337b9a.1681342859.git.jpoimboe@kernel.org>
References: <7069acf026a195f26a88061227fba5a3b0337b9a.1681342859.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168172840785.404.969854172131344642.tip-bot2@tip-bot2>
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

Commit-ID:     25a6917ca63ad4470bf88535c56f0dec72b570fe
Gitweb:        https://git.kernel.org/tip/25a6917ca63ad4470bf88535c56f0dec72b570fe
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 12 Apr 2023 16:49:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Apr 2023 17:31:23 +02:00

init: Mark start_kernel() __noreturn

Now that arch_call_rest_init() is __noreturn, mark its caller
start_kernel() __noreturn.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/7069acf026a195f26a88061227fba5a3b0337b9a.1681342859.git.jpoimboe@kernel.org
---
 include/linux/start_kernel.h | 2 +-
 init/main.c                  | 2 +-
 tools/objtool/check.c        | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/start_kernel.h b/include/linux/start_kernel.h
index 864921e..a9806a4 100644
--- a/include/linux/start_kernel.h
+++ b/include/linux/start_kernel.h
@@ -8,7 +8,7 @@
 /* Define the prototype for start_kernel here, rather than cluttering
    up something else. */
 
-extern asmlinkage void __init start_kernel(void);
+extern asmlinkage void __init __noreturn start_kernel(void);
 extern void __init __noreturn arch_call_rest_init(void);
 extern void __ref __noreturn rest_init(void);
 
diff --git a/init/main.c b/init/main.c
index 161ed95..65aab4e 100644
--- a/init/main.c
+++ b/init/main.c
@@ -937,7 +937,7 @@ static void __init print_unknown_bootoptions(void)
 	memblock_free(unknown_options, len);
 }
 
-asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
+asmlinkage __visible void __init __no_sanitize_address __noreturn start_kernel(void)
 {
 	char *command_line;
 	char *after_dashes;
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 3d7227f..9aaad9d 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -222,6 +222,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"rewind_stack_and_make_dead",
 		"sev_es_terminate",
 		"snp_abort",
+		"start_kernel",
 		"stop_this_cpu",
 		"usercopy_abort",
 		"xen_cpu_bringup_again",
