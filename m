Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD8163126C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 04:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiKTDiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 22:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKTDis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 22:38:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D6694A46
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 19:38:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2761FB80AB9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8999C433D6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 03:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668915524;
        bh=7uBQe17zqyWwAgw1tl1lmly2OHTqQ1g7KNe+gXWVbFk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=i8w/uNHmviqLUqXX+rI7pt1tbjwYsBVhUgwHqSmFQ280k/4Zc9L2s8A1l9iD/AfdV
         8ibtILD5IrQU0R04xuT5HVmQTnInD1Ag/EL12y+66heKFleIhU/BugDQoUvBNG7DvP
         qK5Fxllo4NIg4ML/OG/jMy1LI+ZP2jAhbOi3XfcpVkETH6FqmMLN4RD34yz7bwh7VA
         TZv6v5ZkNKnrhDm2BdxZoTTejdDSmv7MWwf8BVDQPzAdVure3+yfaTqpnr4HR2Gn70
         zljph32bqXKozAiY8TOZMR3ttn08oQM2OqyEUizFnKVQtu6N8MYH5rs3YRLcLDyOAR
         vaqyswO3CtZJw==
Received: by mail-ej1-f52.google.com with SMTP id kt23so21697803ejc.7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 19:38:44 -0800 (PST)
X-Gm-Message-State: ANoB5pmOuMTfz3cpApowMq6BgnTg9r9PPUeR0qDRzYou5y+LJ9xSTBJ1
        HHAV9HX0+68of0Zz3wUnaKGXlSd7JICacD6vL3o=
X-Google-Smtp-Source: AA0mqf5fRqvUMSeOCsgEG2TBdWH+K9jvjjrYrKHKpmALyrPd9GsIq2DcoWkOQDKtUHrqmd87R7uXwEftpPxwhEOdPkA=
X-Received: by 2002:a17:907:cf84:b0:78d:4795:ff1f with SMTP id
 ux4-20020a170907cf8400b0078d4795ff1fmr11375721ejc.331.1668915523015; Sat, 19
 Nov 2022 19:38:43 -0800 (PST)
MIME-Version: 1.0
References: <20221118173217.888077-1-suagrfillet@gmail.com> <20221118173217.888077-3-suagrfillet@gmail.com>
In-Reply-To: <20221118173217.888077-3-suagrfillet@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 20 Nov 2022 11:38:30 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRo+tifz8DqXsAMoK25=_d4f1OqKg=uA=J+75WejprRjA@mail.gmail.com>
Message-ID: <CAJF2gTRo+tifz8DqXsAMoK25=_d4f1OqKg=uA=J+75WejprRjA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] riscv/ftrace: make ftrace_caller call ftrace_graph_func
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 1:32 AM Song Shuai <suagrfillet@gmail.com> wrote:
>
> In order to make the function graph use ftrace directly, ftrace_caller
> should be adjusted to save the necessary regs against the pt_regs layout
> so it can call ftrace_graph_func reasonably.
>
> SAVE_ALL now saves all the regs according to the pt_regs struct. Here
> supersedes SAVE_ALL by SAVE_ABI_REGS which has an extra option to allow
> saving only the necessary ABI-related regs for ftrace_caller.
>
> ftrace_caller and ftrace_regs_caller save their regs with the respective
> option of SAVE_ABI_REGS, then call the tracing function, especially
> graph_ops's ftrace_graph_func. So the ftrace_graph_[regs]_call labels
> aren't needed anymore if FTRACE_WITH_REGS is defined.
>
> As the previous patch described, the ftrace_caller remains with its
> ftrace_graph_call if FTRACE_WITH_REGS isn't defined,
>
> For convenience, the original argument setup for the tracing function in
> ftrace_[regs]_caller is killed and appended to the tail of SAVE_ABI_REGS.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/kernel/mcount-dyn.S | 143 ++++++++++++++++++++++++---------
>  1 file changed, 105 insertions(+), 38 deletions(-)
>
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index 64bc79816f5e..c70f04711a2e 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -57,19 +57,55 @@
>         .endm
>
>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> -       .macro SAVE_ALL
> +
> +/**
> +* SAVE_ABI_REGS - save regs against the pt_regs struct
> +*
> +* @all: tell if saving all the regs
> +*
> +* If all is set, all the regs will be saved, otherwise only ABI
> +* related regs (a0-a7,epc,ra and optional s0) will be saved.
> +*
> +* For convenience the argument setup for tracing function is appended here.
> +* Especially $sp is passed as the 4th argument of the tracing function.
> +*
> +* After the stack is established,
> +*
> +* 0(sp) stores the PC of the traced function which can be accessed
> +* by &(fregs)->regs->epc in tracing function. Note that the real
> +* function entry address should be computed with -FENTRY_RA_OFFSET.
> +*
> +* 8(sp) stores the function return address (i.e. parent IP) that
> +* can be accessed by &(fregs)->regs->ra in tracing function.
> +*
> +* The other regs are saved at the respective localtion and accessed
> +* by the respective pt_regs member.
> +*
> +* Here is the layout of stack for your reference.
> +*
> +* PT_SIZE_ON_STACK  ->  +++++++++
> +*                       + ..... +
> +*                       + t3-t6 +
> +*                       + s2-s11+
> +*                       + a0-a7 + --++++-> ftrace_caller saved
> +*                       + s1    +   +
> +*                       + s0    + --+
> +*                       + t0-t2 +   +
> +*                       + tp    +   +
> +*                       + gp    +   +
> +*                       + sp    +   +
> +*                       + ra    + --+ // parent IP
> +*               sp  ->  + epc   + --+ // PC
> +*                       +++++++++
> +**/
> +       .macro SAVE_ABI_REGS, all=0
>         addi    sp, sp, -PT_SIZE_ON_STACK
>
>         REG_S t0,  PT_EPC(sp)
>         REG_S x1,  PT_RA(sp)
> -       REG_S x2,  PT_SP(sp)
> -       REG_S x3,  PT_GP(sp)
> -       REG_S x4,  PT_TP(sp)
> -       REG_S x5,  PT_T0(sp)
> -       REG_S x6,  PT_T1(sp)
> -       REG_S x7,  PT_T2(sp)
> -       REG_S x8,  PT_S0(sp)
> -       REG_S x9,  PT_S1(sp)
> +
> +       // always save the ABI regs
> +
>         REG_S x10, PT_A0(sp)
>         REG_S x11, PT_A1(sp)
>         REG_S x12, PT_A2(sp)
> @@ -78,6 +114,18 @@
>         REG_S x15, PT_A5(sp)
>         REG_S x16, PT_A6(sp)
>         REG_S x17, PT_A7(sp)
> +
> +       // save the leftover regs
> +
> +       .if \all == 1
> +       REG_S x2,  PT_SP(sp)
> +       REG_S x3,  PT_GP(sp)
> +       REG_S x4,  PT_TP(sp)
> +       REG_S x5,  PT_T0(sp)
> +       REG_S x6,  PT_T1(sp)
> +       REG_S x7,  PT_T2(sp)
> +       REG_S x8,  PT_S0(sp)
> +       REG_S x9,  PT_S1(sp)
>         REG_S x18, PT_S2(sp)
>         REG_S x19, PT_S3(sp)
>         REG_S x20, PT_S4(sp)
> @@ -92,19 +140,28 @@
>         REG_S x29, PT_T4(sp)
>         REG_S x30, PT_T5(sp)
>         REG_S x31, PT_T6(sp)
> +
> +       // save s0 if FP_TEST defined
> +
> +       .else
> +#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> +       REG_S x8,  PT_S0(sp)
> +#endif
> +       .endif
> +
> +       // setup 4 args for tracing functions
> +
> +       addi    a0, t0, -FENTRY_RA_OFFSET       // ip
> +       la      a1, function_trace_op
> +       REG_L   a2, 0(a1)                       // op
> +       REG_L   a1, PT_RA(sp)                   // parent_ip
> +       mv      a3, sp                          // fregs
Moving parameters preparation into SAVE_ABI_REGS is not a good idea.
Give them a separate .macro: PREPARE_ARGS.

> +
>         .endm
>
> -       .macro RESTORE_ALL
> +       .macro RESTORE_ABI_REGS, all=0
>         REG_L t0,  PT_EPC(sp)
>         REG_L x1,  PT_RA(sp)
> -       REG_L x2,  PT_SP(sp)
> -       REG_L x3,  PT_GP(sp)
> -       REG_L x4,  PT_TP(sp)
> -       REG_L x5,  PT_T0(sp)
> -       REG_L x6,  PT_T1(sp)
> -       REG_L x7,  PT_T2(sp)
> -       REG_L x8,  PT_S0(sp)
> -       REG_L x9,  PT_S1(sp)
>         REG_L x10, PT_A0(sp)
>         REG_L x11, PT_A1(sp)
>         REG_L x12, PT_A2(sp)
> @@ -113,6 +170,16 @@
>         REG_L x15, PT_A5(sp)
>         REG_L x16, PT_A6(sp)
>         REG_L x17, PT_A7(sp)
> +
> +       .if \all == 1
> +       REG_L x2,  PT_SP(sp)
> +       REG_L x3,  PT_GP(sp)
> +       REG_L x4,  PT_TP(sp)
> +       REG_L x5,  PT_T0(sp)
> +       REG_L x6,  PT_T1(sp)
> +       REG_L x7,  PT_T2(sp)
> +       REG_L x8,  PT_S0(sp)
> +       REG_L x9,  PT_S1(sp)
>         REG_L x18, PT_S2(sp)
>         REG_L x19, PT_S3(sp)
>         REG_L x20, PT_S4(sp)
> @@ -128,10 +195,16 @@
>         REG_L x30, PT_T5(sp)
>         REG_L x31, PT_T6(sp)
>
> +       .else
> +#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> +       REG_L x8,  PT_S0(sp)
> +#endif
> +       .endif
>         addi    sp, sp, PT_SIZE_ON_STACK
>         .endm
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  ENTRY(ftrace_caller)
>         SAVE_ABI
>
> @@ -160,33 +233,27 @@ ftrace_graph_call:
>         jr t0
>  ENDPROC(ftrace_caller)
>
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  ENTRY(ftrace_regs_caller)
> -       SAVE_ALL
> -
> -       addi    a0, t0, -FENTRY_RA_OFFSET
> -       la      a1, function_trace_op
> -       REG_L   a2, 0(a1)
> -       REG_L   a1, PT_RA(sp)
> -       mv      a3, sp
> +       SAVE_ABI_REGS 1
>
>  ftrace_regs_call:
>         .global ftrace_regs_call
>         call    ftrace_stub
>
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -       addi    a0, sp, PT_RA
> -       REG_L   a1, PT_T0(sp)
> -       addi    a1, a1, -FENTRY_RA_OFFSET
> -#ifdef HAVE_FUNCTION_GRAPH_FP_TEST
> -       mv      a2, s0
> -#endif
> -ftrace_graph_regs_call:
> -       .global ftrace_graph_regs_call
> -       call    ftrace_stub
> -#endif
>
> -       RESTORE_ALL
> +       RESTORE_ABI_REGS 1
>         jr t0
>  ENDPROC(ftrace_regs_caller)
> +
> +ENTRY(ftrace_caller)
> +       SAVE_ABI_REGS 0
> +
> +ftrace_call:
> +       .global ftrace_call
> +       call    ftrace_stub
> +
> +       RESTORE_ABI_REGS 0
> +       jr t0
> +ENDPROC(ftrace_caller)
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> --
> 2.20.1
>


-- 
Best Regards
 Guo Ren
