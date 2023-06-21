Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 118957381EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjFUJas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjFUJ3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:29:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54D2733
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6OKDNob7pFq7hFNRiGsiayA8iaNHfWNvKQYPV2c+oiM=; b=Jp7BOPojcVPRE034JasJFwuPNF
        FsEj4YGb6kkh3ICejl0GBEOZPsYSXA8trGBUUxksJJz4B5JpeuS1ftESQHhC8tTdKSyhnDd6c6m2b
        DOM3MrRDtbTLDYuXfjwgYh48ZqWJ/RhrVojfuNsXqx1qNnYmI9HlHvGEA0ctrnwbCPdUuZYBnIm9m
        RkKYowhINBgXz6b3CJEm+ior5PfYVGQpzwhe69UeJOP0bk/jXXdzM0Sui8007rfv3b1R4bCvDfGjb
        JhqkslXqmqM0nn1n2qi4si4WO0+UBTyqQgXz0VbCn6UIyy0FmiXrYee8r+jBY7WleJ6K4ahf3e5Qh
        11egfVuQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qBu88-00EBCz-Op; Wed, 21 Jun 2023 09:28:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DDB663002F0;
        Wed, 21 Jun 2023 11:27:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B99DA2661626E; Wed, 21 Jun 2023 11:27:59 +0200 (CEST)
Date:   Wed, 21 Jun 2023 11:27:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     x86@kernel.org, alyssa.milburn@linux.intel.com,
        linux-kernel@vger.kernel.org, samitolvanen@google.com,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH 1/2] x86/cfi: Fix ret_from_fork indirect calls
Message-ID: <20230621092759.GJ2046280@hirez.programming.kicks-ass.net>
References: <20230615193546.949657149@infradead.org>
 <20230615193722.127844423@infradead.org>
 <202306201455.AF16F617A@keescook>
 <20230621085217.GI2046280@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621085217.GI2046280@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:52:17AM +0200, Peter Zijlstra wrote:
> On Tue, Jun 20, 2023 at 02:56:22PM -0700, Kees Cook wrote:
> > On Thu, Jun 15, 2023 at 09:35:47PM +0200, Peter Zijlstra wrote:
> > > The ret_from_fork stub does an indirect call to the kthread function,
> > > but only knows about Retpolines. Instead of making the asm more
> > > complicated, punt to C and let the compiler figure it out.
> > > 
> > > Specifically, this makes it a proper kCFI indirect call when needed (in
> > > fact, it is nearly impossible to code a kCFI indirect call in asm).
> > > 
> > > This was the only callsite that was still calling func()+0 on regular
> > > indirect functions.
> > > 
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > 
> > I worry this creates a calling gadget, but I don't think it really
> > counts since it's just converting between two prototypes. Regardless:
> 
> Ah, since this will never be indirectly called, I should be able to
> annotate this so it never can be. Let me see what I can get the compiler
> to do.

I can't seem to manage to have it clobber it's __cfi hash value. Ideally
we'd have an attribute to force the thing to 0 or something.

Best I can do is add __noendbr, which will inhibit the ENDBR.

Alternatively, I *can* write the thing in asm by hard-coding the hash
value, but that's not nice:

	mov	%rbx,%r11
	mov	%r12,%rdi
#ifdef CONFIG_CFI_CLANG
	mov	$0x76049ec3,%r10d
	add	-0xf(%r11),%r10d
	je	1f
	ud2
1:
#endif
	CALL_NOSPEC r11

should work.. but if ever that hash function changes we're in trouble.

---
Subject: x86/cfi: Fix ret_from_fork() indirect calls
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu, 15 Jun 2023 21:35:47 +0200

The ret_from_fork() stub does an indirect call to the kthread function,
but only knows about Retpolines. Instead of making the asm more
complicated, punt to C and let the compiler figure it out.

Specifically, this makes it a proper kCFI indirect call when needed (in
fact, it is nearly impossible to code a kCFI indirect call in asm).

This was the only callsite that was still calling func()+0 on regular
indirect functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sami Tolvanen <samitolvanen@google.com>
Link: https://lore.kernel.org/r/20230615193722.127844423@infradead.org
---
 arch/x86/entry/entry_64.S        |    6 ++++--
 arch/x86/include/asm/switch_to.h |    2 ++
 arch/x86/kernel/process_64.c     |    5 +++++
 3 files changed, 11 insertions(+), 2 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -304,8 +304,10 @@ SYM_CODE_START_NOALIGN(ret_from_fork)
 1:
 	/* kernel thread */
 	UNWIND_HINT_END_OF_STACK
-	movq	%r12, %rdi
-	CALL_NOSPEC rbx
+	movq	%rbx, %rdi
+	movq	%r12, %rsi
+	call	kthread_from_fork
+
 	/*
 	 * A kernel thread is allowed to return here after successfully
 	 * calling kernel_execve().  Exit to userspace to complete the execve()
--- a/arch/x86/include/asm/switch_to.h
+++ b/arch/x86/include/asm/switch_to.h
@@ -74,6 +74,8 @@ static inline void update_task_stack(str
 #endif
 }
 
+extern __noendbr void kthread_from_fork(int (*fn)(void *), void *arg);
+
 static inline void kthread_frame_init(struct inactive_task_frame *frame,
 				      int (*fun)(void *), void *arg)
 {
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -544,6 +544,11 @@ void compat_start_thread(struct pt_regs
 }
 #endif
 
+__visible __noendbr void kthread_from_fork(int (*fn)(void *), void *arg)
+{
+	fn(arg);
+}
+
 /*
  *	switch_to(x,y) should switch tasks from x to y.
  *
