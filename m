Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8366EB99F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 16:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjDVOVv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Apr 2023 10:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDVOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Apr 2023 10:21:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAFCE72
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 07:21:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA7A360FC9
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 14:21:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2576C433EF;
        Sat, 22 Apr 2023 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682173308;
        bh=TaJ9j49RW2ngIjcRgCHX6c2dr/Lco/KmY+TYZiZHHDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UlT/Bkw/MdMrMbdnGiSFyZQDq+NKep8wtCLvyWlCVGDWzzF22JoDUvbnXC7DNS4eW
         kvFl9K67SONZaPl5nI3cKe2YsyzWqvvmprOE8n+vi1Vo9O/9uq5C5+ytLRqNVsQu1+
         pDJl+Rs080oamOU8W5O93zEQMvmc4c7GY8nW8nN4O5HOnDlYwrhozMjQD8+8Av6RjX
         rV9QkAxOUlDeDC8Mhpey8q6V7wgaJzkqaKC51YdLPwrB14e/r3RLhxKGDUIrkqj7fp
         v/kCrhXnk1d80Z8ncNBqlcTKhJnTQR962jd8wmnxRTTsh4voTC+GiDoUQv5mrAmES4
         BKMdgsOEwEBKQ==
Date:   Sat, 22 Apr 2023 16:21:45 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Loongson (and other $ARCHs?) idle VS timer enqueue
Message-ID: <ZEPteS82TbIhMQxe@lothringen>
References: <ZEKDZEQmKExv0O7Q@lothringen>
 <87leil2r7v.ffs@tglx>
 <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230422081700.GB1214746@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 22, 2023 at 10:17:00AM +0200, Peter Zijlstra wrote:
> diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
> index 44ff1ff64260..5a102ff80de0 100644
> --- a/arch/loongarch/kernel/genex.S
> +++ b/arch/loongarch/kernel/genex.S
> @@ -40,6 +40,7 @@ SYM_FUNC_START(handle_vint)
>  	ori	t0, t0, 0x1f
>  	xori	t0, t0, 0x1f
>  	bne	t0, t1, 1f
> +	addi.d	t0, t0, 0x20
>  	LONG_S	t0, sp, PT_ERA
>  1:	move	a0, sp
>  	move	a1, sp

But the interrupts are enabled in C from arch_cpu_idle(), which
only then calls the ASM __arch_cpu_idle(). So if the interrupt happens
somewhere in between the call, the rollback (or fast-forward now)
doesn't apply.

I guess interrupts need to be re-enabled from ASM in the beginning
of __arch_cpu_idle() so that it's part of the fast-forward region.

> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index b6de8e88c1bd..cd6aae441ad9 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -140,6 +140,7 @@ LEAF(__r4k_wait)
>  	ori	k0, 0x1f	/* 32 byte rollback region */
>  	xori	k0, 0x1f
>  	bne	k0, k1, \handler
> +	addiu	k0, 0x20
>  	MTC0	k0, CP0_EPC
>  	.set pop
>  	.endm

The same seem to apply with interrupts being re-enabled by r4k_wait().

Thanks.
