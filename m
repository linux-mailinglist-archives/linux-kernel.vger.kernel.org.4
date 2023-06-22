Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F9B73A398
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFVOuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbjFVOug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:50:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F16FA1995
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BTT+KoTXqCaNq9y13aV/Jw9DZObN70x0nFDB9z9hNio=; b=fbvfH2/HrnNfAVJ69LLHLM/iwi
        JHopjHpVTm/xSNYjjJbBfkdnDXhp1u+5qYEZbc5IkZjky+2ZsJGY+iFaRB3cXGtzB+VRbinoPb7Ae
        NQU4erYGvI7cq2fINx7mr3lkMpGzJ/3wAR8sVN/Nq1GFMaaQPd2uR1B6G5aU3fAuCpyFWsr2bVeso
        fjY6sp+vZe4i1aUc0irIpwEe/7HnqQMnIF83vXK6a624TlQCjR0K3GZlmpoRDbovKdlWqoPrT8sFw
        cGZaF1/rXWTilayNT6o95K6uZgbEyAyC1YhZ0I9+TsNHp7x9jrSlBYiUNTiPsEIrQGVdXu77Da++h
        jYYnKxvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCLdh-00FgfB-Rc; Thu, 22 Jun 2023 14:50:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 309B0300427;
        Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 17D91209D8B3B; Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Message-ID: <20230622144321.427441595@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 16:42:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alyssa.milburn@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        samitolvanen@google.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com, brgerst@gmail.com
Subject: [PATCH v2 2/6] x86/alternative: Rename apply_ibt_endbr()
References: <20230622144218.860926475@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current name doesn't reflect what it does very well.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/um/kernel/um_arch.c           |    2 +-
 arch/x86/include/asm/alternative.h |    2 +-
 arch/x86/include/asm/ibt.h         |    2 +-
 arch/x86/kernel/alternative.c      |    9 ++++++---
 arch/x86/kernel/module.c           |    2 +-
 5 files changed, 10 insertions(+), 7 deletions(-)

--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -437,7 +437,7 @@ void __init arch_cpu_finalize_init(void)
 	os_check_bugs();
 }
 
-void apply_ibt_endbr(s32 *start, s32 *end)
+void apply_seal_endbr(s32 *start, s32 *end)
 {
 }
 
--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -96,7 +96,7 @@ extern void alternative_instructions(voi
 extern void apply_alternatives(struct alt_instr *start, struct alt_instr *end);
 extern void apply_retpolines(s32 *start, s32 *end);
 extern void apply_returns(s32 *start, s32 *end);
-extern void apply_ibt_endbr(s32 *start, s32 *end);
+extern void apply_seal_endbr(s32 *start, s32 *end);
 extern void apply_fineibt(s32 *start_retpoline, s32 *end_retpoine,
 			  s32 *start_cfi, s32 *end_cfi);
 
--- a/arch/x86/include/asm/ibt.h
+++ b/arch/x86/include/asm/ibt.h
@@ -34,7 +34,7 @@
 /*
  * Create a dummy function pointer reference to prevent objtool from marking
  * the function as needing to be "sealed" (i.e. ENDBR converted to NOP by
- * apply_ibt_endbr()).
+ * apply_seal_endbr()).
  */
 #define IBT_NOSEAL(fname)				\
 	".pushsection .discard.ibt_endbr_noseal\n\t"	\
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -803,7 +803,7 @@ static void __init_or_module poison_endb
 /*
  * Generated by: objtool --ibt
  */
-void __init_or_module noinline apply_ibt_endbr(s32 *start, s32 *end)
+void __init_or_module noinline apply_seal_endbr(s32 *start, s32 *end)
 {
 	s32 *s;
 
@@ -818,7 +818,7 @@ void __init_or_module noinline apply_ibt
 
 #else
 
-void __init_or_module apply_ibt_endbr(s32 *start, s32 *end) { }
+void __init_or_module apply_seal_endbr(s32 *start, s32 *end) { }
 
 #endif /* CONFIG_X86_KERNEL_IBT */
 
@@ -1565,7 +1565,10 @@ void __init alternative_instructions(voi
 	 */
 	callthunks_patch_builtin_calls();
 
-	apply_ibt_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
+	/*
+	 * Seal all functions that do not have their address taken.
+	 */
+	apply_seal_endbr(__ibt_endbr_seal, __ibt_endbr_seal_end);
 
 #ifdef CONFIG_SMP
 	/* Patch to UP if other cpus not imminent. */
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -358,7 +358,7 @@ int module_finalize(const Elf_Ehdr *hdr,
 	}
 	if (ibt_endbr) {
 		void *iseg = (void *)ibt_endbr->sh_addr;
-		apply_ibt_endbr(iseg, iseg + ibt_endbr->sh_size);
+		apply_seal_endbr(iseg, iseg + ibt_endbr->sh_size);
 	}
 	if (locks) {
 		void *lseg = (void *)locks->sh_addr;


