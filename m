Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD2FB707EDC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 13:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjERLIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 07:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjERLIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 07:08:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA73F173A;
        Thu, 18 May 2023 04:08:05 -0700 (PDT)
Date:   Thu, 18 May 2023 11:08:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1684408082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q1wSTXpmUXEtB4n5FYYFQ1BnbqrVTQgShrk+97Zeuwg=;
        b=MSYQfZgDe/x1T4pUyK2e5CpS2G78XvwcuZi2Gjcnko9U3oVbJpAsQJQC9wuyK91mvb3eEg
        IjNH2/g4YdLcGeEXm4/L7p6rppLM/S4Nb7BnPYxNEX0w1EDWerWVugMJKaoivpb6McJyLT
        HJZJzuXIOjn6/tfmSsP4kJEVd02L9++DmPODwHh4BiekG3SLRUX9A5/PYuIB6KmwZgBi+f
        2frqt/AfQSzNCHu5gtmVYHY/8AfFQa/G9Z6/GFK8SC95A96JzS8CSv/vVu0fyXzJVbZVJz
        gXdPqcHAPC6hmQJ8ZFc8jLnwdGjuiFQ3/0micuWTRqDGci0cqkOLbdutXP1VUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1684408082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q1wSTXpmUXEtB4n5FYYFQ1BnbqrVTQgShrk+97Zeuwg=;
        b=e5N00Cotzeu6JNWOnJlDGrnuYNm2mJ73/+5Wh4gvN/TQCKtk4saIW9PCipdX3qfd2njHeA
        T1mY5CMdxMyGm3Bw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Ignore exc_double_fault() __noreturn warnings
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <a45b085071d3a7d049a20f9e78754452336ecbe8.1681853186.git.jpoimboe@kernel.org>
References: <a45b085071d3a7d049a20f9e78754452336ecbe8.1681853186.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168440808192.404.1122939902210348216.tip-bot2@tip-bot2>
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

Commit-ID:     55eeab2a8a11b71586ef0ad3adf532ca5f97d4be
Gitweb:        https://git.kernel.org/tip/55eeab2a8a11b71586ef0ad3adf532ca5f97d4be
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 18 Apr 2023 14:27:51 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 16 May 2023 06:31:53 -07:00

objtool: Ignore exc_double_fault() __noreturn warnings

This is a hack, but it works for now.

Problem is, exc_double_fault() may or may not return, depending on
whether CONFIG_X86_ESPFIX64 is set.  But objtool has no visibility to
the kernel config.

"Fix" it by silencing the exc_double_fault() __noreturn warning.

This removes the following warning:

  vmlinux.o: warning: objtool: xenpv_exc_double_fault+0xd: exc_double_fault() is missing a __noreturn annotation

Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Link: https://lore.kernel.org/r/a45b085071d3a7d049a20f9e78754452336ecbe8.1681853186.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 8d1b422..8dac1e3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4505,6 +4505,35 @@ static int validate_sls(struct objtool_file *file)
 	return warnings;
 }
 
+static bool ignore_noreturn_call(struct instruction *insn)
+{
+	struct symbol *call_dest = insn_call_dest(insn);
+
+	/*
+	 * FIXME: hack, we need a real noreturn solution
+	 *
+	 * Problem is, exc_double_fault() may or may not return, depending on
+	 * whether CONFIG_X86_ESPFIX64 is set.  But objtool has no visibility
+	 * to the kernel config.
+	 *
+	 * Other potential ways to fix it:
+	 *
+	 *   - have compiler communicate __noreturn functions somehow
+	 *   - remove CONFIG_X86_ESPFIX64
+	 *   - read the .config file
+	 *   - add a cmdline option
+	 *   - create a generic objtool annotation format (vs a bunch of custom
+	 *     formats) and annotate it
+	 */
+	if (!strcmp(call_dest->name, "exc_double_fault")) {
+		/* prevent further unreachable warnings for the caller */
+		insn->sym->warned = 1;
+		return true;
+	}
+
+	return false;
+}
+
 static int validate_reachable_instructions(struct objtool_file *file)
 {
 	struct instruction *insn, *prev_insn;
@@ -4521,7 +4550,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		prev_insn = prev_insn_same_sec(file, insn);
 		if (prev_insn && prev_insn->dead_end) {
 			call_dest = insn_call_dest(prev_insn);
-			if (call_dest) {
+			if (call_dest && !ignore_noreturn_call(prev_insn)) {
 				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
 					  call_dest->name);
 				warnings++;
