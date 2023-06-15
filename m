Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ECBB73206F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 21:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjFOTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjFOTkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 15:40:43 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C66B2954
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=BhX7pkXejcd+7jOdak4TeKh4gofIP/p6FvONT7yMD5Q=; b=Luncf/CUiCXEJyaixzGv2qhSHY
        FpBEa0sP9GHb+kSvFbCdnhUAl6ex0IbnWIihLc+vrU5Pw52VWmVi1dYIF5rgUcq/yBbQ5fnBT7C0I
        3wroRla56ysNYuNVj7s6Ut8oxsy9oQhuc+xhs6KBlF8eUg6x7JKUC0cX1ZsK5DDlHv12G98EZjay1
        cpv9C9FULKKGfXA4bevZK24nVZmoUtTU5Yo4WNZjwGTMnKbQQWdG5EqCJVOkajdE1H0p+FBVsmvSu
        YWvrH7dT6MjxhkaDEfbxUFnp+PZROLzB6Mfn5k5SkMpHhbmSh+wE8JWtqmXcPcMz3ZWUAJUMwTP2D
        mPoNrRow==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9spY-00BtUT-1s;
        Thu, 15 Jun 2023 19:40:29 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1018830031B;
        Thu, 15 Jun 2023 21:40:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id E847C245F1E4B; Thu, 15 Jun 2023 21:40:26 +0200 (CEST)
Message-ID: <20230615193722.127844423@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Jun 2023 21:35:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, alyssa.milburn@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        samitolvanen@google.com, keescook@chromium.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
Subject: [PATCH 1/2] x86/cfi: Fix ret_from_fork indirect calls
References: <20230615193546.949657149@infradead.org>
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

The ret_from_fork stub does an indirect call to the kthread function,
but only knows about Retpolines. Instead of making the asm more
complicated, punt to C and let the compiler figure it out.

Specifically, this makes it a proper kCFI indirect call when needed (in
fact, it is nearly impossible to code a kCFI indirect call in asm).

This was the only callsite that was still calling func()+0 on regular
indirect functions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
 
+extern void kthread_from_fork(int (*fn)(void *), void *);
+
 static inline void kthread_frame_init(struct inactive_task_frame *frame,
 				      int (*fun)(void *), void *arg)
 {
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -544,6 +544,11 @@ void compat_start_thread(struct pt_regs
 }
 #endif
 
+__visible noinstr void kthread_from_fork(int (*fn)(void *), void *arg)
+{
+	fn(arg);
+}
+
 /*
  *	switch_to(x,y) should switch tasks from x to y.
  *


