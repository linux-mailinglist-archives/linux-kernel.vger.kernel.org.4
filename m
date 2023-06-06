Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C230D724F72
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 00:07:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239825AbjFFWHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 18:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbjFFWHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 18:07:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F10170C
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 15:07:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 091C662DA3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:07:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD255C433D2;
        Tue,  6 Jun 2023 22:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686089236;
        bh=EhsLPDAwMF6B/StlX4CuZ4dgWiqs9O/C+kIYo2IjFcs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OwMRn7f9jCqEFusXNZKX+DuYyjs3WCl+kfFw9hGEVmB44r84tCsaTjL42zairsJHC
         IULjHEda0Xe8cbHq0fvpxINFoWxyzAF3clOTOpXELGXOY38Z8T1snrZimnYkPQBUYX
         ftA5AKLdIE42n3P2R3zdh5HhyZNrqZAje6zfWlO+akqi8rDGdfg/sM/2phe2YEBpQW
         5keEkYltf0b5NwJn/NTDyJVvs9Ut/+et4CW69yW8qYYL3cjkzg9WNttJgRBIwMwFMV
         OSuEy7/nmn/8p0BPnG1sAolfYp2SPj/4Dstp087VcKIbfI0A663AJpOv23eGc3Rzb/
         lezZz0bvl3f4g==
Date:   Wed, 7 Jun 2023 00:07:13 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "bibo, mao" <maobibo@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <ZH+uEdhTCc2wIyIi@lothringen>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
 <ZEPteS82TbIhMQxe@lothringen>
 <20230422150409.GL1214746@hirez.programming.kicks-ass.net>
 <7d91fa2a-57c5-6c78-8e2d-7fbdd6a11cba@loongson.cn>
 <20230425114937.GC1335080@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425114937.GC1335080@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 01:49:37PM +0200, Peter Zijlstra wrote:
> Would not something like the below be a more compact form?
> That is; afaict there is no reason to keep it 32 bytes, we can easily go
> 16 and drop 4 nops.
> 
> Additionally, instead of truncating to the start, increase to the end by
> doing:
> 
> 	ip |= 0xf;
> 	ip++;
> 
> Also; I added a wee comment.
> 
> 
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 44ff1ff64260..3c8a6bab98fe 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -18,27 +18,31 @@
>  
>  	.align	5
>  SYM_FUNC_START(__arch_cpu_idle)
> -	/* start of rollback region */
> -	LONG_L	t0, tp, TI_FLAGS
> -	nop
> -	andi	t0, t0, _TIF_NEED_RESCHED
> -	bnez	t0, 1f
> -	nop
> -	nop
> -	nop
> +	/* start of idle interrupt region */
> +	move	t0, CSR_CRMD_IE
> +	csrxchg	t0, t0, LOONGARCH_CSR_CRMD
> +	/*
> +	 * If an interrupt lands here; between enabling interrupts above and
> +	 * going idle on the next instruction, we must *NOT* go idle since the
> +	 * interrupt could have set TIF_NEED_RESCHED or caused an timer to need
> +	 * reprogramming. Fall through -- see handle_vint() below -- and have
> +	 * the idle loop take care of things.
> +	 */
>  	idle	0
> -	/* end of rollback region */
> -1:	jr	ra
> +	nop
> +	/* end of idle interrupt region */
> +SYM_INNER_LBEL(__arch_cpu_idle_exit, SYM_L_LOCAL)
> +	jr	ra
>  SYM_FUNC_END(__arch_cpu_idle)
>  
>  SYM_FUNC_START(handle_vint)
>  	BACKUP_T0T1
>  	SAVE_ALL
> -	la_abs	t1, __arch_cpu_idle
> +	la_abs	t1, __arch_cpu_idle_exit
>  	LONG_L	t0, sp, PT_ERA
> -	/* 32 byte rollback region */
> -	ori	t0, t0, 0x1f
> -	xori	t0, t0, 0x1f
> +	/* 16 byte idle interrupt region */
> +	ori	t0, t0, 0x0f
> +	addi.d	t0, t0, 1
>  	bne	t0, t1, 1f
>  	LONG_S	t0, sp, PT_ERA
>  1:	move	a0, sp
> diff --git a/arch/loongarch/kernel/idle.c b/arch/loongarch/kernel/idle.c
> index 0b5dd2faeb90..5ba72d229920 100644
> --- a/arch/loongarch/kernel/idle.c
> +++ b/arch/loongarch/kernel/idle.c
> @@ -11,7 +11,6 @@
>  
>  void __cpuidle arch_cpu_idle(void)
>  {
> -	raw_local_irq_enable();
>  	__arch_cpu_idle(); /* idle instruction needs irq enabled */
>  	raw_local_irq_disable();
>  }

What is the status of this? Is someone from loongarch going to take it?

Thanks.
