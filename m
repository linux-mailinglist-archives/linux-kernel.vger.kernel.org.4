Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6E1602BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJRMhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJRMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:37:03 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D8AABF3E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=he9hCX/JyfBTTpqNFZETXrJiIBrHe05QQi4DdEC0FAU=; b=nOajt4CAteq/ZlvK9iAt9s4QMT
        FNQQhqUwIIkiJ/uYWXlYMtMMksmPWOfum36tvmgjL4/gE4z9fsAJ3FwZN0oIl0Du4aSsS0Ghf7RF0
        u1QOzvTXbBDo+6ukTh31/c9+NIm2NUx2Iie0J94lQoPsodjSLc0pMs9u720yym4jGwx3CPVyW5NkA
        jt9H9G9iMVrKIDvtE/7jY3jfbq7DFZe3FK4YSveYIAQLlMXq1h+MkbZnC6jiz1PTEu7sXImnSHBgY
        QDYQzBwhDCf3I5j8TWyL+xoyGW7zwyx1fSYqP1SInSKRx0Siz1orILjzccYHV6WkRb+l5X26ZK4It
        ldb6ydGQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oklq2-004U8W-NL; Tue, 18 Oct 2022 12:36:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E07E3002C5;
        Tue, 18 Oct 2022 14:36:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id F0E952075A8C7; Tue, 18 Oct 2022 14:36:53 +0200 (CEST)
Date:   Tue, 18 Oct 2022 14:36:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] ftrace,kcfi: Separate ftrace_stub() and
 ftrace_stub_graph()
Message-ID: <Y06d5X39EmKVamLN@hirez.programming.kicks-ass.net>
References: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y06dg4e1xF6JTdQq@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 02:35:16PM +0200, Peter Zijlstra wrote:
> 
> Different function signatures means they needs to be different
> functions; otherwise CFI gets upset.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
> 
> Notable; this patch depends on eac828eaef29 ("x86/ftrace: Remove
> ftrace_epilogue()") which can be cleanly picked on top of -rc1.
> 
> Since kCFI is upstream this should go into some /urgent tree.

Combined (eac828eaef29 + this patch) generate a conflict against
tip/x86/core. Resolution looks like:

diff --cc arch/x86/kernel/ftrace_64.S
index 2a4be92fd144,6a7e6d666a12..000000000000
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@@ -4,7 -4,7 +4,8 @@@
   */
  
  #include <linux/linkage.h>
 +#include <linux/cfi_types.h>
+ #include <asm/asm-offsets.h>
  #include <asm/ptrace.h>
  #include <asm/ftrace.h>
  #include <asm/export.h>
@@@ -130,14 -130,6 +131,16 @@@
  
  	.endm
  
 +SYM_TYPED_FUNC_START(ftrace_stub)
++	CALL_DEPTH_ACCOUNT
 +	RET
 +SYM_FUNC_END(ftrace_stub)
 +
 +SYM_TYPED_FUNC_START(ftrace_stub_graph)
++	CALL_DEPTH_ACCOUNT
 +	RET
 +SYM_FUNC_END(ftrace_stub_graph)
 +
  #ifdef CONFIG_DYNAMIC_FTRACE
  
  SYM_FUNC_START(__fentry__)
@@@ -284,8 -305,13 +311,10 @@@ STACK_FRAME_NON_STANDARD_FP(ftrace_regs
  #else /* ! CONFIG_DYNAMIC_FTRACE */
  
  SYM_FUNC_START(__fentry__)
+ 	CALL_DEPTH_ACCOUNT
+ 
  	cmpq $ftrace_stub, ftrace_trace_function
  	jnz trace
 -
 -SYM_INNER_LABEL(ftrace_stub, SYM_L_GLOBAL)
 -	ENDBR
  	RET
  
  trace:
