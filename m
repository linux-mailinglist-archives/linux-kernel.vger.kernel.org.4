Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F39B7291B9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 09:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbjFIHtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 03:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239130AbjFIHrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 03:47:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FCC830D1;
        Fri,  9 Jun 2023 00:47:44 -0700 (PDT)
Date:   Fri, 09 Jun 2023 07:47:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686296862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPLNXf9zWyzWyCwmesDgnVebog7KOM+Va2Vyt9T/g5Q=;
        b=tVEDJ6LVH1R5m+I68OIqDMMQMtOUUZShNe8op2Jqn57N9+VYeg/bSbQ5N2FG3RsgoZvFxG
        FiKP6QI4skTN8ptwW231MeBpW88xzqtO7y/5AYJgd+h/AdpafOOtgxDmL0lr4p/GWwhxd6
        VajwILC0GDHj6bMcrrzTug3HGSJU5HC1qlS+E7xqh2Hl87df/AsHMD0nAxnFelp/SJqe0s
        7NiuFey9m2YPul0a+fVmCVRGR422EeDbyk1nvUtfonaEx23OdU420IC+xkz+0ARYZdMU5L
        vN0r51k9L6FiDMj5sa6jJJ0CpfVjZCebcvX5NNeC3Pu57Qt2DoIcDi+9MfYGDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686296862;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lPLNXf9zWyzWyCwmesDgnVebog7KOM+Va2Vyt9T/g5Q=;
        b=1gBi7ubdBLao5CQ2lQRyZUQhYNL5vemHJQKQ05O/MsEaGzQMdCWWrStUA90+tZcqx45bbm
        QY8bjN7xC0gyetAw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] Revert "x86/orc: Make it callthunk aware"
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <a05b916ef941da872cbece1ab3593eceabd05a79.1684245404.git.jpoimboe@kernel.org>
References: <a05b916ef941da872cbece1ab3593eceabd05a79.1684245404.git.jpoimboe@kernel.org>
MIME-Version: 1.0
Message-ID: <168629686183.404.12250905754837686812.tip-bot2@tip-bot2>
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

Commit-ID:     020126239b8f376ed2f0bef9dc07d0b280a0b7f5
Gitweb:        https://git.kernel.org/tip/020126239b8f376ed2f0bef9dc07d0b280a0b7f5
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 16 May 2023 06:56:46 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Wed, 07 Jun 2023 09:48:57 -07:00

Revert "x86/orc: Make it callthunk aware"

Commit 396e0b8e09e8 ("x86/orc: Make it callthunk aware") attempted to
deal with the fact that function prefix code didn't have ORC coverage.
However, it didn't work as advertised.  Use of the "null" ORC entry just
caused affected unwinds to end early.

The root cause has now been fixed with commit 5743654f5e2e ("objtool:
Generate ORC data for __pfx code").

Revert most of commit 396e0b8e09e8 ("x86/orc: Make it callthunk aware").
The is_callthunk() function remains as it's now used by other code.

Link: https://lore.kernel.org/r/a05b916ef941da872cbece1ab3593eceabd05a79.1684245404.git.jpoimboe@kernel.org
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h |  5 -----
 arch/x86/kernel/callthunks.c       |  2 +-
 arch/x86/kernel/unwind_orc.c       | 21 +--------------------
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7da28f..6c15a62 100644
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -113,7 +113,6 @@ extern void callthunks_patch_builtin_calls(void);
 extern void callthunks_patch_module_calls(struct callthunk_sites *sites,
 					  struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
-extern bool is_callthunk(void *addr);
 extern int x86_call_depth_emit_accounting(u8 **pprog, void *func);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
@@ -124,10 +123,6 @@ static __always_inline void *callthunks_translate_call_dest(void *dest)
 {
 	return dest;
 }
-static __always_inline bool is_callthunk(void *addr)
-{
-	return false;
-}
 static __always_inline int x86_call_depth_emit_accounting(u8 **pprog,
 							  void *func)
 {
diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.c
index 22ab139..8e0a9b6 100644
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -293,7 +293,7 @@ void *callthunks_translate_call_dest(void *dest)
 	return target ? : dest;
 }
 
-bool is_callthunk(void *addr)
+static bool is_callthunk(void *addr)
 {
 	unsigned int tmpl_size = SKL_TMPL_SIZE;
 	void *tmpl = skl_call_thunk_template;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 7891727..4ee16b0 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -183,21 +183,6 @@ static struct orc_entry null_orc_entry = {
 	.type = ORC_TYPE_CALL
 };
 
-#ifdef CONFIG_CALL_THUNKS
-static struct orc_entry *orc_callthunk_find(unsigned long ip)
-{
-	if (!is_callthunk((void *)ip))
-		return NULL;
-
-	return &null_orc_entry;
-}
-#else
-static struct orc_entry *orc_callthunk_find(unsigned long ip)
-{
-	return NULL;
-}
-#endif
-
 /* Fake frame pointer entry -- used as a fallback for generated code */
 static struct orc_entry orc_fp_entry = {
 	.type		= ORC_TYPE_CALL,
@@ -250,11 +235,7 @@ static struct orc_entry *orc_find(unsigned long ip)
 	if (orc)
 		return orc;
 
-	orc =  orc_ftrace_find(ip);
-	if (orc)
-		return orc;
-
-	return orc_callthunk_find(ip);
+	return orc_ftrace_find(ip);
 }
 
 #ifdef CONFIG_MODULES
