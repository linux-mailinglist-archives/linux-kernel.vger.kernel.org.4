Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A59705007
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233115AbjEPN5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjEPN5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:57:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3C71711
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 06:57:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62B7E6168D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 13:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 979DBC433D2;
        Tue, 16 May 2023 13:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684245429;
        bh=Dg6xwqAYoBbJ+/6rCpEbcwJd7iha1URjRnlvLQywWho=;
        h=From:To:Cc:Subject:Date:From;
        b=OfwUrj6GRuK7IpN+1ySxaWFi+FLMIldsaeFzydc+4ar2z8xmew09zdNiWgavN7UgD
         Lupr7WbGFXNXxdxGhvK1lCIvM6aZO9UWE2mMKhP3zeJ5B+6itQPVrKnr7TWkSiE1k5
         CZx2QDsC99s3Zw6En+AtfQ2XaFMNbVq5KFJ3uK37jNjzGooczBSdZvexxp0h+53cBe
         9xJ3OMaPzwSj7RxDzhvXKpSOY5xij3uH/vVpiQ6exdyHxivZfFePfCR3nUeLcT1ixK
         Y10Jm7Am0/HX8t30ikVogZgudCIqqZkT61U4LU+gjma0WEHbH6MJ7qdPczpSFc6ssU
         vLpKolMZSw9GQ==
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] Revert "x86/orc: Make it callthunk aware"
Date:   Tue, 16 May 2023 06:56:46 -0700
Message-Id: <a05b916ef941da872cbece1ab3593eceabd05a79.1684245404.git.jpoimboe@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
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

Commit 396e0b8e09e8 ("x86/orc: Make it callthunk aware") attempted to
deal with the fact that function prefix code didn't have ORC coverage.
However, it didn't work as advertised.  Use of the "null" ORC entry just
caused affected unwinds to end early.

The root cause has now been fixed with commit 5743654f5e2e ("objtool:
Generate ORC data for __pfx code").

Revert most of commit 396e0b8e09e8 ("x86/orc: Make it callthunk aware").
The is_callthunk() function remains as it's now used by other code.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h |  5 -----
 arch/x86/kernel/callthunks.c       |  2 +-
 arch/x86/kernel/unwind_orc.c       | 21 +--------------------
 3 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/arch/x86/include/asm/alternative.h b/arch/x86/include/asm/alternative.h
index d7da28fada87..6c15a622ad60 100644
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
index 22ab13966427..8e0a9b637e23 100644
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
index 3ac50b7298d1..183bc20f610e 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -136,21 +136,6 @@ static struct orc_entry null_orc_entry = {
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
@@ -203,11 +188,7 @@ static struct orc_entry *orc_find(unsigned long ip)
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
-- 
2.40.1

