Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8D00613E12
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJaTOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiJaTON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:14:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B02C120BD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 12:14:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAFCB61418
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 19:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AB9C433C1;
        Mon, 31 Oct 2022 19:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667243651;
        bh=80lqoPPKDQ+glCPrCeg2E0gbOPazZmUenJWu7c2v11s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XixhbcpmCWhV7gKONpioTcsPjwo2dubUfERuxu+IC1URA6AThPGAW1QT8pM76DbZc
         TuL61Mc0yVscRfNbtfO7fxI2Aeel+eKLGOvfmRdbYLHIGrGTsoeXghxXtjbOvNFzwC
         u+bMsgr6u06r/u3PMYjW6EHQVf+L+e+vKAE1wkqeIsGMjL0097ckG9WYjbZslkJieL
         l33yQRsao15+j07391m/ub1t8lg3ZkhsAr8cyy/XYlmfFewsWa3btuFAAmuSZ0dEZJ
         PWjuZiPd7Kf3jFMP3ArpS0tEdzqiH1qeD/K0zn7t9PONKFzB4oqXhYVD+OkAlzW5/a
         TCEYD90sRgRWA==
Date:   Mon, 31 Oct 2022 19:14:06 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: process: fix kernel info leakage
Message-ID: <Y2AefvfMgZDoQUto@spud>
References: <20221029113450.4027-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029113450.4027-1-jszhang@kernel.org>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 29, 2022 at 07:34:50PM +0800, Jisheng Zhang wrote:
> thread_struct's s[12] may contain random kernel memory content, which
> may be finally leaked to userspace. This is a security hole. Fix it
> by clearing the s[12] array in thread_struct when fork.
> 
> As for kthread case, it's better to clear the s[12] array as well.
> 
> Fixes: 7db91e57a0ac ("RISC-V: Task implementation")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
> 
> Previously, it's one of the series of "riscv: entry: further clean up
> and VMAP_STACK fix". This is a fix, so I move it out of the series and
> send it separately

Should this not be carrying a R-b from Guo Ren from that series?
https://lore.kernel.org/linux-riscv/CAJF2gTSdVyAaM12T+7kXAdRPGS4VyuO08X1c7paE-n4Fr8OtRA@mail.gmail.com/
> 
>  arch/riscv/kernel/process.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
> index ceb9ebab6558..52002d54b163 100644
> --- a/arch/riscv/kernel/process.c
> +++ b/arch/riscv/kernel/process.c
> @@ -164,6 +164,8 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
>  	unsigned long tls = args->tls;
>  	struct pt_regs *childregs = task_pt_regs(p);
>  
> +	memset(&p->thread.s, 0, sizeof(p->thread.s));
> +
>  	/* p->thread holds context to be restored by __switch_to() */
>  	if (unlikely(args->fn)) {
>  		/* Kernel thread */
> -- 
> 2.37.2
> 
