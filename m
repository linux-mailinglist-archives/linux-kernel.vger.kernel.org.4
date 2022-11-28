Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC49B63A951
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiK1NTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbiK1NTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:19:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B72C1F2C9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:17:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AB3CB80DB3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:17:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11380C4314C
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669641431;
        bh=pdjKPY5Vwqu/CAsrLfzJyZMpBhMzVI/GQU7fhz39+/I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t2/QaDHYL5muLSCpLyHRTB56h9iwXWozFrL26rcmfiGijhezfiMnzvm/YQ56gQQSb
         jBUIrmzjOvIV4QrKTxj/PGKHP9eVobTSyE9Ut1HKWDzkZDBJC0yqCTjcqzUG8yGCkj
         1ESoYxcj6R8j6GP0kg/UVgLWcdYodcC1edpaThcetI8zAA3XVeyZaw1htLBWP+ygXU
         G74wqLXwwAYqZQGpdvgxIbBiG0p7yEoTiDxYDgwd2NFooY2BFaGDFZRsB2seb1NJK0
         Du5Tcmj+siY9oGw5+Bc6Q6tu3jJ+B+Ym582GxVz6+2csZSQRocjacZB4nHeH58owPV
         aiFPs9FUVfiSg==
Received: by mail-ed1-f43.google.com with SMTP id z20so15341678edc.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 05:17:10 -0800 (PST)
X-Gm-Message-State: ANoB5pm720M2Hji43MN7ZV53Gwnamz0po3lzsRW3SK/iqdk1xWerG6YS
        jkT7j9ZEAKB1zmx1C9cPiffE+C3uQ5eBC/9onAA=
X-Google-Smtp-Source: AA0mqf79LR06QFhiVEmF2iL7F5EjIQqSlNkibB6++4nyjYylUeni5ntphRqVKawb/z56EA++ZVk9VtgLvgO2nQD815Q=
X-Received: by 2002:aa7:c511:0:b0:469:7731:5b29 with SMTP id
 o17-20020aa7c511000000b0046977315b29mr37242376edq.419.1669641429146; Mon, 28
 Nov 2022 05:17:09 -0800 (PST)
MIME-Version: 1.0
References: <20221123142025.1504030-1-suagrfillet@gmail.com> <20221123142025.1504030-2-suagrfillet@gmail.com>
In-Reply-To: <20221123142025.1504030-2-suagrfillet@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 28 Nov 2022 21:16:57 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSbyfwdCDdUu7S3JpdFpspxVEi+t_8r6SQhaLogE1O7wg@mail.gmail.com>
Message-ID: <CAJF2gTSbyfwdCDdUu7S3JpdFpspxVEi+t_8r6SQhaLogE1O7wg@mail.gmail.com>
Subject: Re: [PATCH 1/2] riscv/ftrace: add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
To:     Song Shuai <suagrfillet@gmail.com>
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        mark.rutland@arm.com, peterz@infradead.org, jolsa@redhat.com,
        bp@suse.de, jpoimboe@kernel.org, linux-riscv@lists.infradead.org,
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

On Wed, Nov 23, 2022 at 10:20 PM Song Shuai <suagrfillet@gmail.com> wrote:
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
> ---
>  arch/riscv/Kconfig              | 1 +
>  arch/riscv/include/asm/ftrace.h | 6 ++++++
>  arch/riscv/kernel/mcount-dyn.S  | 4 ++++
>  3 files changed, 11 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 39ec8d628cf6..d083ec08d0b6 100644
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
> index 01bebb28eabe..be4d57566139 100644
> --- a/arch/riscv/include/asm/ftrace.h
> +++ b/arch/riscv/include/asm/ftrace.h
> @@ -114,6 +114,12 @@ struct ftrace_regs;
>  void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>                        struct ftrace_ops *op, struct ftrace_regs *fregs);
>  #define ftrace_graph_func ftrace_graph_func
> +
> +static inline void arch_ftrace_set_direct_caller(struct pt_regs *regs, unsigned long addr)
> +{
> +               regs->t1 = addr;
> +}
> +
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index 466c6ef217b1..b89c85a58569 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -233,6 +233,7 @@ ENDPROC(ftrace_caller)
>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  ENTRY(ftrace_regs_caller)
>         SAVE_ABI_REGS 1
> +       REG_S   x0, PT_T1(sp)
ENTRY(ftrace_regs_caller)
+    move t1, zero
      SAVE_ABI_REGS 1
      PREPARE_ARGS

Shall we use a move here, instead?

>         PREPARE_ARGS
>
>  ftrace_regs_call:
> @@ -241,7 +242,10 @@ ftrace_regs_call:
>
>
>         RESTORE_ABI_REGS 1
> +       bnez    t1,.Ldirect
>         jr t0
> +.Ldirect:
> +       jr t1
>  ENDPROC(ftrace_regs_caller)
>
>  ENTRY(ftrace_caller)
> --
> 2.20.1
>


-- 
Best Regards
 Guo Ren
