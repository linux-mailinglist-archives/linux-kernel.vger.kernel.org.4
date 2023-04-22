Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E76EB9D3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDVPEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 11:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjDVPEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 11:04:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 939311BC2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e7NZCjbPVKi0/f20JwNEha0Xa8ShkuoZ6+XGb+MgtoI=; b=hfPkSrfbXtZ2uC4kHA+nkugca/
        sh4tGYA456nSjGuJ4hMGGLa2EKC1QBBva2IwZExCMT99mK9xFgd0O1ixx9cywOzZ83HtxR1g5U0OH
        +alJdjLcdyXvXwXuyEFyJnezjrFASvix52r2zMiKJ+Aq1X2FgG0hhP9XV/Mfh9zjFXPk55EmiCo9f
        QXXQBb6ZibK/TjM0oRRCsy4ckM8R9ec0Wb6eNwQcw8CVuVsU0XGqDeNuOgJ3evB/d8Kyv3TMv9a9/
        cPr7HZ4FVCzpzubn6paxtLSmw5ec+UJDNOAjvdLoNpMO5vbpyx6uF3PqwWV97xk7djGKxOWE8xW05
        2AyAtdkw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pqEmZ-00GJLV-Vv; Sat, 22 Apr 2023 15:04:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A41F13000DC;
        Sat, 22 Apr 2023 17:04:09 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 495C720979C18; Sat, 22 Apr 2023 17:04:09 +0200 (CEST)
Date:   Sat, 22 Apr 2023 17:04:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
 <ZEPteS82TbIhMQxe@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEPteS82TbIhMQxe@lothringen>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 04:21:45PM +0200, Frederic Weisbecker wrote:
> On Sat, Apr 22, 2023 at 10:17:00AM +0200, Peter Zijlstra wrote:
> > diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> > index 44ff1ff64260..5a102ff80de0 100644
> > --- a/arch/loongarch/kernel/genex.S
> > +++ b/arch/loongarch/kernel/genex.S
> > @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
> >  	ori	t0, t0, 0x1f
> >  	xori	t0, t0, 0x1f
> >  	bne	t0, t1, 1f
> > +	addi.d	t0, t0, 0x20
> >  	LONG_S	t0, sp, PT_ERA
> >  1:	move	a0, sp
> >  	move	a1, sp
> 
> But the interrupts are enabled in C from arch_cpu_idle(), which
> only then calls the ASM __arch_cpu_idle(). So if the interrupt happens
> somewhere in between the call, the rollback (or fast-forward now)
> doesn't apply.
> 
> I guess interrupts need to be re-enabled from ASM in the beginning
> of __arch_cpu_idle() so that it's part of the fast-forward region.

Right; something like so I suppose, but at this point I'm really just
guessing... Loongarch person will have to do.

diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 44ff1ff64260..4814ac5334ef 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -19,13 +19,13 @@
 	.align	5
 SYM_FUNC_START(__arch_cpu_idle)
 	/* start of rollback region */
+	move	t0, CSR_CRMD_IE
+	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
 	LONG_L	t0, tp, TI_FLAGS
 	nop
 	andi	t0, t0, _TIF_NEED_RESCHED
 	bnez	t0, 1f
 	nop
-	nop
-	nop
 	idle	0
 	/* end of rollback region */
 1:	jr	ra
@@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
 	ori	t0, t0, 0x1f
 	xori	t0, t0, 0x1f
 	bne	t0, t1, 1f
+	addi.d	t0, t0, 0x20
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
 	move	a1, sp
diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
index 0b5dd2faeb90..5ba72d229920 100644
--- a/arch/loongarch/kernel/idle.c
+++ b/arch/loongarch/kernel/idle.c
@@ -11,7 +11,6 @@
 
 void __cpuidle arch_cpu_idle(void)
 {
-	raw_local_irq_enable();
 	__arch_cpu_idle(); /* idle instruction needs irq enabled */
 	raw_local_irq_disable();
 }
