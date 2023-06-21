Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 231D8737EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjFUIuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjFUIuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:50:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B151F95
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cz2jATrTeZc5BEzBEzrguwGK/CP5maOGmB7lpt8nnbI=; b=bMXHBjchiEsvOpwVeqrOV9NeCi
        uJGnn1AN9sw5fU4Y+pkh8T4yAJmkuM+e9rIREsTp3HRzVAQ3sI5a8QJFYUaN3PjWG7YX4g12a/3b4
        rFBirt1o+BayLZKt/+lP6hFAR9XWuOJ/3aa1Z2QS8hNHtiCI41ftCEwMhZHTSP8aOK3JaPHfA7IV+
        Aoqtc9Cu5A15hWci9bYMXLCBDKWMhI9SD2vFwGaltTSNWvhvQOdHc0Mn0dFH/FdA0wHVAHd1fh8jE
        3mTc4ufg7/+MtLtG/dubBEm9oj87u0EA+2JKZqoeDUY/gcNLrJZofe4Ul6Ou4yTxO6lD1HHU55mWe
        G+hvogkA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qBtVU-00HK69-0W;
        Wed, 21 Jun 2023 08:50:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EAF543002A9;
        Wed, 21 Jun 2023 10:48:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CDB5520825AF7; Wed, 21 Jun 2023 10:48:02 +0200 (CEST)
Date:   Wed, 21 Jun 2023 10:48:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 2/2] x86/fineibt: Poison ENDBR at +0
Message-ID: <20230621084802.GA2048237@hirez.programming.kicks-ass.net>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.194131053@infradead.org>
 <202306201454.0A2E875F@keescook>
 <20230621081857.GG2046280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621081857.GG2046280@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:18:57AM +0200, Peter Zijlstra wrote:
> (and I need to write a better Changelog).

Updated changelog...

---
Subject: x86/fineibt: Poison ENDBR at +0
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 15 Jun 2023 21:35:48 +0200

Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
booting on IBT enabled hardware obtain FineIBT, the indirect functions
look like:

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
