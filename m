Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196B062D0CF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 02:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233732AbiKQBtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 20:49:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230103AbiKQBtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 20:49:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844B956EDE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:49:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AC19B81E89
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA12C433D6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 01:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668649759;
        bh=rVkagLHMllNvzG3aGM9n9XGMbP6OS0YaVGqKyaXaMgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aLavwsN04ttyteAh5JPva6h35Ty64UXiTjQ0aU7O+cYvN6bMYUfXSrD+MplptFLPW
         EHKJI5FBbAjFhvIv8y7Lw+mzS0e/cnvUo+3jFH/nIt/qOlISWcdoxRLfBsSsMfjlCn
         TjVh5COrNGsSYTQQDdlbSUJzvTtoAXcNuGHqo0/vrAOdZ1JApeRbt+Der8af3DjfED
         +rdA6ERwIgzcsbB8JZmSv0w7HpksgfWZb/SugIk4Kr3w1pNdPyFAgeltvwukQZr3Ht
         R12mzUHNdfYoNkr+8d/5nXuVO39JP+M8DmueJxABn+8kGTfVJ16EhRuU+Kt3f9oMtn
         ygKOdPJ6feF3w==
Received: by mail-ej1-f54.google.com with SMTP id ft34so1475453ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 17:49:19 -0800 (PST)
X-Gm-Message-State: ANoB5pmXMA13FkgCtY8uyDstO1rak5Dv9nMn5Kc0mWVSzYRY1tKYJNpc
        nWfHYf8iOJhNQvfobxfvTxmjdkDdD9+fFHMtQ14=
X-Google-Smtp-Source: AA0mqf4G5/JzvdiUJ7yjlVqUXPvKVJYlnB64NKRidGzfAVV/INPHMsFt8gwucahVQyl25A0OLBTOAhCftvJ19SR/F44=
X-Received: by 2002:a17:906:4a8a:b0:7ad:bc84:2f23 with SMTP id
 x10-20020a1709064a8a00b007adbc842f23mr436307eju.262.1668649758001; Wed, 16
 Nov 2022 17:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20221116031305.286634-1-suagrfillet@gmail.com> <20221116031305.286634-4-suagrfillet@gmail.com>
In-Reply-To: <20221116031305.286634-4-suagrfillet@gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 17 Nov 2022 09:49:06 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSdLnC39oABHmfjKEtixC25QbXDPRWyyCmhZ8-Un=sUkA@mail.gmail.com>
Message-ID: <CAJF2gTSdLnC39oABHmfjKEtixC25QbXDPRWyyCmhZ8-Un=sUkA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] riscv/ftrace: cleanup ftrace_caller and ftrace_regs_caller
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

On Wed, Nov 16, 2022 at 11:13 AM Song Shuai <suagrfillet@gmail.com> wrote:
>
> ftrace_caller and ftrace_regs_caller save their regs with the respective
> option of SAVE_ALL, then call the tracing function, especially graph_ops's
> ftrace_graph_func. So the ftrace_graph_[regs]_call labels aren't needed
> anymore if FTRACE_WITH_REGS is defined.
>
> If FTRACE_WITH_REGS isn't defined, the !FTRACE_WITH_REGS version
> ftrace_caller remains with the ftrace_graph_call. So the enable/disable
> helpers are revised for serving only this ftrace_graph_call.
>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> ---
>  arch/riscv/kernel/ftrace.c     | 19 ++----------------
>  arch/riscv/kernel/mcount-dyn.S | 35 +++++++++++++++-------------------
>  2 files changed, 17 insertions(+), 37 deletions(-)
>
> diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> index 148a5480076b..2f0bcedc6a2d 100644
> --- a/arch/riscv/kernel/ftrace.c
> +++ b/arch/riscv/kernel/ftrace.c
> @@ -211,30 +211,15 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
>  #else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>
>  extern void ftrace_graph_call(void);
> -extern void ftrace_graph_regs_call(void);
>  int ftrace_enable_ftrace_graph_caller(void)
>  {
> -       int ret;
> -
> -       ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> -                                   (unsigned long)&prepare_ftrace_return, true);
> -       if (ret)
> -               return ret;
> -
> -       return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
> +       return  __ftrace_modify_call((unsigned long)&ftrace_graph_call,
>                                     (unsigned long)&prepare_ftrace_return, true);
>  }
>
>  int ftrace_disable_ftrace_graph_caller(void)
>  {
> -       int ret;
> -
> -       ret = __ftrace_modify_call((unsigned long)&ftrace_graph_call,
> -                                   (unsigned long)&prepare_ftrace_return, false);
> -       if (ret)
> -               return ret;
> -
> -       return __ftrace_modify_call((unsigned long)&ftrace_graph_regs_call,
> +       return  __ftrace_modify_call((unsigned long)&ftrace_graph_call,
>                                     (unsigned long)&prepare_ftrace_return, false);
>  }
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index 2f0a280bd7a0..9e4097c6793d 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -215,6 +215,7 @@
>         .endm
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>
> +#ifndef CONFIG_DYNAMIC_FTRACE_WITH_REGS
>  ENTRY(ftrace_caller)
>         SAVE_ABI
>
> @@ -243,33 +244,27 @@ ftrace_graph_call:
>         ret
>  ENDPROC(ftrace_caller)
>
> -#ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> +#else /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
>  ENTRY(ftrace_regs_caller)
> -       SAVE_ALL
> -
> -       addi    a0, ra, -FENTRY_RA_OFFSET
> -       la      a1, function_trace_op
> -       REG_L   a2, 0(a1)
> -       REG_L   a1, PT_SIZE_ON_STACK(sp)
> -       mv      a3, sp
> +       SAVE_ALL 1
I think the patch is broken, we shouldn't split mcount-dyn.S
modification from the patch.

>
>  ftrace_regs_call:
>         .global ftrace_regs_call
>         call    ftrace_stub
>
> -#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> -       addi    a0, sp, PT_RA
> -       REG_L   a1, PT_EPC(sp)
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
> +       RESTORE_ALL 1
>         ret
>  ENDPROC(ftrace_regs_caller)
> +
> +ENTRY(ftrace_caller)
> +       SAVE_ALL 0
> +
> +ftrace_call:
> +       .global ftrace_call
> +       call    ftrace_stub
> +
> +       RESTORE_ALL 0
> +       ret
> +ENDPROC(ftrace_caller)
>  #endif /* CONFIG_DYNAMIC_FTRACE_WITH_REGS */
> --
> 2.20.1
>


--
Best Regards
 Guo Ren
