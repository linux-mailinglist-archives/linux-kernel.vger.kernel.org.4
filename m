Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6698A73A39C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjFVOvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjFVOuj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:50:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2462FE7E
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=r2emQb1KTou2w3E9LTe7OUggXTTKEQJMuYJi6cUiILo=; b=ojMRDX4ZBEo3NUsxlNBhbZLvLt
        fkA47p2jhqe8lzrjurlZD2De4pLm2TykWc791yVF/zL0xFJOdfWxq++Veod7TQ+XhUdasBxrjX8nN
        OPAOuz0MCUzYEi5uA94oEvnGBs/JxIEIewilpDBPNdDupmEPS2IQkauXWZ1vv9BQ0B4FqjdrHr9/k
        uz//mQ/fof1UKUzFvRn3jAOYUN6rNV20xLBwELPIXwHorcoG27Mi7SDZOq2BCt3HWvJBLHzwNlkWM
        jBEnghKq3fIWQ5vkBpYn7CMxzJOb13s5sOeop9IS55tSD/6RdDNLVPyBCkK7oQ7E5V7V/TqIP49tf
        wSh7KL6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qCLdh-00FgfE-V5; Thu, 22 Jun 2023 14:50:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 7716F300790;
        Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 29E62209FB79B; Thu, 22 Jun 2023 16:50:24 +0200 (CEST)
Message-ID: <20230622144321.696656240@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 22 Jun 2023 16:42:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alyssa.milburn@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        samitolvanen@google.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com, brgerst@gmail.com,
        "Milburn, Alyssa" <alyssa.milburn@intel.com>
Subject: [PATCH v2 6/6] x86/fineibt: Poison ENDBR at +0
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

Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
booting on IBT enabled hardware to obtain FineIBT, the indirect
functions look like:

  __cfi_foo:
	endbr64
	subl	$hash, %r10d
	jz	1f
	ud2
	nop
  1:
  foo:
	endbr64

This is because the compiler generates code for kCFI+IBT. In that case
the caller does the hash check and will jump to +0, so there must be
an ENDBR there. The compiler doesn't know about FineIBT at all; also
it is possible to actually use kCFI+IBT when booting with 'cfi=kcfi'
on IBT enabled hardware.

Having this second ENDBR however makes it possible to elide the CFI
check. Therefore, we should poison this second ENDBR when switching to
FineIBT mode.

Fixes: 931ab63664f0 ("x86/ibt: Implement FineIBT")
Reported-by: "Milburn, Alyssa" <alyssa.milburn@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20230615193722.194131053@infradead.org
---
 arch/x86/kernel/alternative.c |   16 ++++++++++++++++
 1 file changed, 16 insertions(+)

--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1063,6 +1063,17 @@ static int cfi_rewrite_preamble(s32 *sta
 	return 0;
 }
 
+static void cfi_rewrite_endbr(s32 *start, s32 *end)
+{
+	s32 *s;
+
+	for (s = start; s < end; s++) {
+		void *addr = (void *)s + *s;
+
+		poison_endbr(addr+16, false);
+	}
+}
+
 /* .retpoline_sites */
 static int cfi_rand_callers(s32 *start, s32 *end)
 {
@@ -1157,14 +1168,19 @@ static void __apply_fineibt(s32 *start_r
 		return;
 
 	case CFI_FINEIBT:
+		/* place the FineIBT preamble at func()-16 */
 		ret = cfi_rewrite_preamble(start_cfi, end_cfi);
 		if (ret)
 			goto err;
 
+		/* rewrite the callers to target func()-16 */
 		ret = cfi_rewrite_callers(start_retpoline, end_retpoline);
 		if (ret)
 			goto err;
 
+		/* now that nobody targets func()+0, remove ENDBR there */
+		cfi_rewrite_endbr(start_cfi, end_cfi);
+
 		if (builtin)
 			pr_info("Using FineIBT CFI\n");
 		return;


