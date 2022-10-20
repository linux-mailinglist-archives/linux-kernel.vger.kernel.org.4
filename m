Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0256054A8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 03:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJTBCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 21:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiJTBCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 21:02:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A29516D570
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:02:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C8DB26171B
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:02:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 358A5C433C1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 01:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666227737;
        bh=Up2VerrOxVYswXUVHRewL92xXQNU8nYbGKMF4T9eQMk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sKtpNK0SrEihd0IJ7UVVVGR1y3RMLwkwybN/iWBNJ8jtCtlX/uFTOyvNE45WoRYmx
         4nj7KqCK7tcCfr4w7oHry8n6GuOcP4+x01VKLGY1KZgssZPi4w8y9SSkaMtUwrTXju
         yy9xvB2GiSgZ9X5mr2C7DCA8ainxNZm0ETdXtEDEHPnDnA9PWLm+Dudw1HvSdge8BZ
         epsqJetOitViaPQAOslBcdAg15lgThLXtuEs2h4ktDqGSbStdaa2v5tHkKYkht5BcD
         xlKz0QNKjuQg24hYm8aryE2YVd0xsp9bWSl5lbqnnkaxmwLGfBKg4yCo8hhRL8P8B6
         2H5DRARDQ2NXg==
Received: by mail-ot1-f43.google.com with SMTP id br15-20020a056830390f00b0061c9d73b8bdso10528942otb.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 18:02:17 -0700 (PDT)
X-Gm-Message-State: ACrzQf1QBrnMvr9Oz119Ouw/dHBl+rVVj6R1003/TzY6cGScKD+Fe9mp
        oLRp0+gJL1Z/ApPPW+1QPzlizFidxzglC5eIw5M=
X-Google-Smtp-Source: AMsMyM6oqhkTNPGdTnaC2Jyt8++7m2Mtw8h0QRwjWlECeuEtwBLsjBNwsv8ogiZxsJfHi1YUkITSH5CvuGBqbzO2Qzw=
X-Received: by 2002:a9d:3634:0:b0:661:a991:7c57 with SMTP id
 w49-20020a9d3634000000b00661a9917c57mr5310013otb.308.1666227736409; Wed, 19
 Oct 2022 18:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20221019154727.2395-1-jszhang@kernel.org>
In-Reply-To: <20221019154727.2395-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 20 Oct 2022 09:02:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQ=q5C87S0Tbei2Q4k7C=PupMcXScXruyeB_BTW01ALPw@mail.gmail.com>
Message-ID: <CAJF2gTQ=q5C87S0Tbei2Q4k7C=PupMcXScXruyeB_BTW01ALPw@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix race when vmap stack overflow
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Wed, Oct 19, 2022 at 11:57 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Currently, when detecting vmap stack overflow, riscv firstly switches
> to the so called shadow stack, then use this shadow stack to call the
> get_overflow_stack() to get the overflow stack. However, there's
> a race here if two or more harts use the same shadow stack at the same
> time.
>
> To solve this race, we introduce spin_shadow_stack atomic var, which
> will make the shadow stack usage serialized.
>
> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Suggested-by: Guo Ren <guoren@kernel.org>
> ---
>  arch/riscv/kernel/entry.S | 4 ++++
>  arch/riscv/kernel/traps.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b9eda3fcbd6d..7b924b16792b 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
>
>  #ifdef CONFIG_VMAP_STACK
>  handle_kernel_stack_overflow:
> +1:     la sp, spin_shadow_stack
> +       amoswap.w sp, sp, (sp)
> +       bnez sp, 1b
> +
>         la sp, shadow_stack
>         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f3e96d60a2ff..88a54947dffb 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -221,11 +221,15 @@ asmlinkage unsigned long get_overflow_stack(void)
>                 OVERFLOW_STACK_SIZE;
>  }
>
> +atomic_t spin_shadow_stack;
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>         unsigned long tsk_stk = (unsigned long)current->stack;
>         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>
> +       atomic_set_release(&spin_shadow_stack, 0);
> +
>         console_verbose();
>
>         pr_emerg("Insufficient stack space to handle exception!\n");
> --
> 2.37.2
>


-- 
Best Regards
 Guo Ren
