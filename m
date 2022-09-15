Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB805B99F0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 13:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIOLnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiIOLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 07:40:50 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 124BF48EBB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 04:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=LufghqVQE4/oVdylEJUs4Nk7E1aIBOIRXlB89gM3l3o=; b=hczBXo4yqDviTwwBVl5CPPlgon
        SD/qVnwC/tMKHwGf119LoQ7FFEBafVPBePKH2bHw8NskzPSx0bLrMQ/e9q8taguCU+D+2Vm8ToeGo
        ty1r7fLgG3dII86bSJUShy5roMhOFvGKIxDw3B3bs6mVi2YyWnNWzvhDxmr/vL9Twh9zrdvNSTGu2
        eXuZPMg+bu5uZYCnTaeF7Rcbb7MAQ1cQ2CLALGi4WdnuwJvotaSTJ5we8QaO1iTER3K8pi3kMMOH1
        yN6iACjWjK6N9C+IqvDR9BWDQugvYexS30Gjrd7rWNP/bwS6anI8bMa4P7jV24sMllYy+KkO6iWUo
        6OERxqdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYnDc-00Cab5-Rn; Thu, 15 Sep 2022 11:39:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F0C9A302D76;
        Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id AF23B2015DC36; Thu, 15 Sep 2022 13:39:39 +0200 (CEST)
Message-ID: <20220915111146.539578813@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 15 Sep 2022 13:11:14 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v3 35/59] x86/entry: Make sync_regs() invocation a tail call
References: <20220915111039.092790446@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

No point in having a call there. Spare the call/ret overhead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1062,11 +1062,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	UNTRAIN_RET
 
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
-.Lerror_entry_from_usermode_after_swapgs:
-
 	/* Put us onto the real thread stack. */
-	call	sync_regs
-	RET
+	jmp	sync_regs
 
 	/*
 	 * There are two places in the kernel that can potentially fault with
@@ -1124,7 +1121,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
 	mov	%rax, %rdi
-	jmp	.Lerror_entry_from_usermode_after_swapgs
+	jmp	sync_regs
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)


