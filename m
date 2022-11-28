Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C5063A8C8
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbiK1MzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiK1My7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:54:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8982415FF7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:54:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4DD6DB80BA6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:54:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 190A7C433D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 12:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669640095;
        bh=NhTLaXEkdYgcJsMx6yEP6NGvTkuPNf2uOMNYgKPmU9k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aofybGdprp+SWCs5FEfdG1ILsXNhOumf+6MdEE2mvlbPONSVSHf8UhymxDvo2h4yC
         1DVNQpVEaFJu+6Vm38cejudOrs+VTmXCagbPxD5KpLcCTtpPQCvVjQ3zKXX5FPdbuA
         H9rJmIw+AQHnGR41KogBDZuc1Opn2CuoXTztMxw7tVc2SaW+mgxbBnZBOlIVntjQEc
         DYsd4xVLRejPeGsgDBiwn/ZT8Y5gjSQZbghqRknQhPOz4stHNI6qsFxxqNeYJKF2EX
         5p3bTCjZJiAGE81EtK4KBgeU9g7PHuflbqbrFciTGqvOMm2NcWknzaa+qqbbzROdtK
         peWbLhe0iqXyw==
Received: by mail-ej1-f53.google.com with SMTP id e27so25465532ejc.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 04:54:55 -0800 (PST)
X-Gm-Message-State: ANoB5pmmXGkJYwlcKpBjtcSdlQjSWSi35ImhChzPVkzy+Mu3CNSwmWUn
        RpNSzhPIfvQEuye8nNqEa2wZBkkzmRIUtSSNAeo=
X-Google-Smtp-Source: AA0mqf6sXDpJjurrIuddM/a2ZbRE2PEk8Ef2Y+2IOd6apwZ7sg/HsraMSzi3JwjLzieYKVgJxNj9cTIeW6Xd5dE0l64=
X-Received: by 2002:a17:906:ee2:b0:78d:3f96:b7aa with SMTP id
 x2-20020a1709060ee200b0078d3f96b7aamr29134490eji.74.1669640093273; Mon, 28
 Nov 2022 04:54:53 -0800 (PST)
MIME-Version: 1.0
References: <CAAYs2=hNAwDk7=F077ityNykZJCCvGVyXsxRzZO3s7rKwOPpUg@mail.gmail.com>
 <20221128101201.4144527-1-guoren@kernel.org>
In-Reply-To: <20221128101201.4144527-1-guoren@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 28 Nov 2022 20:54:41 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTrJCGj19EzRpd_iQ54hAj_bQZQ+xJx7j9FzDSNFwMCLg@mail.gmail.com>
Message-ID: <CAJF2gTTrJCGj19EzRpd_iQ54hAj_bQZQ+xJx7j9FzDSNFwMCLg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
To:     suagrfillet@gmail.com, guoren@kernel.org
Cc:     aou@eecs.berkeley.edu, bp@suse.de, jolsa@redhat.com,
        jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, mark.rutland@arm.com,
        mhiramat@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
        peterz@infradead.org, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Abandoned

On Mon, Nov 28, 2022 at 6:12 PM <guoren@kernel.org> wrote:
>
> From: Song Shuai <suagrfillet@gmail.com>
>
> This patch adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS support for RISC-V.
>
> select the DYNAMIC_FTRACE_WITH_DIRECT_CALLS to provide the
> register_ftrace_direct[_multi] interfaces allowing users to register
> the customed trampoline (direct_caller) as the mcount for one or
> more target functions. And modify_ftrace_direct[_multi] are also
> provided for modifying direct_caller.
>
> To make the direct_caller and the other ftrace hooks (eg. function/fgraph
> tracer, k[ret]probes) co-exist, a temporary register is nominated to
> store the address of direct_caller in ftrace_regs_caller. After the
> setting of the address direct_caller by direct_ops->func and the
> RESTORE_REGS in ftrace_regs_caller, direct_caller will be jumped to
> by the `jr` inst.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Co-developed-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>
> ---
>  Remove modification of mcount-dyn.S. (Guo Ren)
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/ftrace.h | 26 ++++++++++++++++++++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 1d0e5838b11b..2828537abfcd 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -278,6 +278,7 @@ config ARCH_RV64I
>         select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>         select HAVE_DYNAMIC_FTRACE if !XIP_KERNEL && MMU && $(cc-option,-fpatchable-function-entry=8)
>         select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> +       select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
>         select HAVE_FTRACE_MCOUNT_RECORD if !XIP_KERNEL
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER if !XIP_KERNEL && !PREEMPTION
> diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
> index 84f856a3286e..d2c159cdfa5c 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -114,6 +114,32 @@ struct ftrace_regs;
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>                        struct ftrace_ops *op, struct ftrace_regs *fregs);
>  #define ftrace_graph_func ftrace_graph_func
> +
> +static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
> +{
> +               /*
> +                * Backup origin detour target (t0) in t1, and set t0 with addr.
> +                *
> +                * Here is the sample code for riscv direct_caller:
> +                *
> +                * addi sp,sp,-16
> +                * move t0,t1
> +                * ^^^^^^^^^^
> +                * sd   t0,0(sp)
> +                * sd   ra,8(sp)
> +                * call my_direct_func1
> +                * ld   t0,0(sp)
> +                * ld   ra,8(sp)
> +                * addi sp,sp,16
> +                * jr t0
> +                *
> +                * (Set t0 with t1 for continuous detour, because t1 contains origin detour
> +                *  target)
> +                */
> +               regs->t1 = regs->t0;
> +               regs->t0 = addr;
> +}
> +
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>
>  #endif /* __ASSEMBLY__ */
> --
> 2.36.1
>


-- 
Best Regards
 Guo Ren
