Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22686EE14B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233706AbjDYLt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjDYLty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:49:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C94E67
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OenIbESUDMerzpX4WLGSnnomtRylcgFMwwHwo8/lU6I=; b=s62+IAJIig/3R3/hkphcr+OXhS
        AG+Lbb4N/1fbdn/z4D3LY4zZd800N0vKKp3i+xy//+h2XbF3K26sMzVmPd2x/kIajdBHcLMR7VTdx
        ZUeaP4PYzNwrlIBn0Op4E/6AnNy49wNq9v2Sw0mkr22FbvrmHKtWb4KFcEOje2MSyh7iUAr0N0D3F
        wz+yUdzJLq7LOGSjh50PAxqLJ50qf5vEO6e6ifOetjPqeYjmxW+nF9ZybjQwR6bIQqZ5VLnqzaXMb
        0GBQVkTgMDhalP4QnPv3FmWJ8tBc7gsgeBfTg5LZg76EU6EiumYUcyDt4lvdcb37Wlze98syrTu5p
        YarPyz4g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1prHAy-001P35-4u; Tue, 25 Apr 2023 11:49:40 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0414D300380;
        Tue, 25 Apr 2023 13:49:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D5A82241B9569; Tue, 25 Apr 2023 13:49:37 +0200 (CEST)
Date:   Tue, 25 Apr 2023 13:49:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "bibo, mao" <maobibo@loongson.cn>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <20230425114937.GC1335080@hirez.programming.kicks-ass.net>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
 <ZEPteS82TbIhMQxe@lothringen>
 <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
 <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 09:52:49PM +0800, bibo, mao wrote:

> > @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
> >   	ori	t0, t0, 0x1f
> >   	xori	t0, t0, 0x1f
> >   	bne	t0, t1, 1f
> > +	addi.d	t0, t0, 0x20
> It is more reasonable with this patch, this will jump out of idle function
> directly after interrupt returns. If so, can we remove checking
> _TIF_NEED_RESCHED in idle ASM function?
> 
> > +	move	t0, CSR_CRMD_IE
> > +	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
> -   	LONG_L	t0, tp, TI_FLAGS
> +	nop
> >   	nop
> -	andi	t0, t0, _TIF_NEED_RESCHED
> -	bnez	t0, 1f
> +	nop
> +	nop
> >   	nop
> > -	nop
> > -	nop
> >   	idle	0

Would not something like the below be a more compact form?
That is; afaict there is no reason to keep it 32 bytes, we can easily go
16 and drop 4 nops.

Additionally, instead of truncating to the start, increase to the end by
doing:

	ip |= 0xf;
	ip++;

Also; I added a wee comment.


diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 44ff1ff64260..3c8a6bab98fe 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -18,27 +18,31 @@
 
 	.align	5
 SYM_FUNC_START(__arch_cpu_idle)
-	/* start of rollback region */
-	LONG_L	t0, tp, TI_FLAGS
-	nop
-	andi	t0, t0, _TIF_NEED_RESCHED
-	bnez	t0, 1f
-	nop
-	nop
-	nop
+	/* start of idle interrupt region */
+	move	t0, CSR_CRMD_IE
+	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
+	/*
+	 * If an interrupt lands here; between enabling interrupts above and
+	 * going idle on the next instruction, we must *NOT* go idle since the
+	 * interrupt could have set TIF_NEED_RESCHED or caused an timer to need
+	 * reprogramming. Fall through -- see handle_vint() below -- and have
+	 * the idle loop take care of things.
+	 */
 	idle	0
-	/* end of rollback region */
-1:	jr	ra
+	nop
+	/* end of idle interrupt region */
+SYM_INNER_LBEL(__arch_cpu_idle_exit, SYM_L_LOCAL)
+	jr	ra
 SYM_FUNC_END(__arch_cpu_idle)
 
 SYM_FUNC_START(handle_vint)
 	BACKUP_T0T1
 	SAVE_ALL
-	la_abs	t1, __arch_cpu_idle
+	la_abs	t1, __arch_cpu_idle_exit
 	LONG_L	t0, sp, PT_ERA
-	/* 32 byte rollback region */
-	ori	t0, t0, 0x1f
-	xori	t0, t0, 0x1f
+	/* 16 byte idle interrupt region */
+	ori	t0, t0, 0x0f
+	addi.d	t0, t0, 1
 	bne	t0, t1, 1f
 	LONG_S	t0, sp, PT_ERA
 1:	move	a0, sp
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
