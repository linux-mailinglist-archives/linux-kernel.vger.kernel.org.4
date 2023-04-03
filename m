Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517416D3B33
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 02:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjDCAyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 20:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDCAyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 20:54:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9491693F9;
        Sun,  2 Apr 2023 17:54:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C8B6B81063;
        Mon,  3 Apr 2023 00:54:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A6D8C433AA;
        Mon,  3 Apr 2023 00:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680483289;
        bh=DaAK/KJ9Sxive90qkMpJzTL0+rm8LML3yNxkEv5unjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fhxj7mAjt8HWjA2QS85FafdG4xT9gTww7WnP6uwoZ3XscYPNpMUYvCW22cVGOJrWr
         d77UJg3LfXmI0Q9+8JENWFCHUfWqWixNI0iqpyRzUn7BpOtYj6jDhTlvxXMX6nP/K6
         skaJWSvc+vlKzU2FuSEvIyKUcNNLbzas9nkq11twWDdX6QyOE0Jn9PtjK491vv62K2
         g7gLBEqV4a/1d/CTmLZa0qIK2CPyjQiFdekeKCaarlMBwxbnLqdJEeQf7Ot7d8V388
         RNqNRPv1KNUJgVGcXr37ZKmgFs+Scq1Pjz3uB4OEYKalia5+j7wlKAdvsc422KQfzK
         64eulwTQ03SOg==
Received: by mail-ed1-f50.google.com with SMTP id cn12so111028231edb.4;
        Sun, 02 Apr 2023 17:54:48 -0700 (PDT)
X-Gm-Message-State: AAQBX9eWKtfuxPWijTIjI5YJMDGDIxaz+KuqE3zrdcDek+SLXMaC1EpT
        pzCo4g+Woq6dTiuTgg6fckpR/JFFKL2SspYlCxQ=
X-Google-Smtp-Source: AKy350Y3MsClOTP8ZkPw0uaS0RqqG3xR4PTrm3d8m6ATj8GvN/Rp/4Pm5dyJdZKN/Yb6d7Unx5etaGlBLGm7vu8iIkc=
X-Received: by 2002:a17:906:28da:b0:8d8:4578:18e0 with SMTP id
 p26-20020a17090628da00b008d8457818e0mr16855332ejd.10.1680483287114; Sun, 02
 Apr 2023 17:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680265828.git.pengdonglin@sangfor.com.cn> <2f5d47ce9f7cf35ee2d292def7106169b9e41dc5.1680265828.git.pengdonglin@sangfor.com.cn>
In-Reply-To: <2f5d47ce9f7cf35ee2d292def7106169b9e41dc5.1680265828.git.pengdonglin@sangfor.com.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Mon, 3 Apr 2023 08:54:36 +0800
X-Gmail-Original-Message-ID: <CAAhV-H69EHXx54Btm0JXSdJ+WJxfqWr_KzcD-Cpq1ph6z9WWug@mail.gmail.com>
Message-ID: <CAAhV-H69EHXx54Btm0JXSdJ+WJxfqWr_KzcD-Cpq1ph6z9WWug@mail.gmail.com>
Subject: Re: [PATCH v10 7/8] LoongArch: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
To:     Donglin Peng <pengdonglin@sangfor.com.cn>
Cc:     mhiramat@kernel.org, rostedt@goodmis.org, linux@armlinux.org.uk,
        mark.rutland@arm.com, will@kernel.org, catalin.marinas@arm.com,
        rmk+kernel@armlinux.org.uk, palmer@dabbelt.com,
        paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        tglx@linutronix.de, dave.hansen@linux.intel.com, x86@kernel.org,
        bp@alien8.de, hpa@zytor.com, zhangqing@loongson.cn,
        kernel@xen0n.name, mingo@redhat.com, peterz@infradead.org,
        xiehuan09@gmail.com, dinghui@sangfor.com.cn,
        huangcun@sangfor.com.cn, dolinux.peng@gmail.com,
        linux-trace-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Fri, Mar 31, 2023 at 8:48=E2=80=AFPM Donglin Peng <pengdonglin@sangfor.c=
om.cn> wrote:
>
> The previous patch ("function_graph: Support recording and printing
> the return value of function") has laid the groundwork for the for
> the funcgraph-retval, and this modification makes it available on
> the LoongArch platform.
>
> We introduce a new structure called fgraph_ret_regs for the LoongArch
> platform to hold return registers and the frame pointer. We then fill
> its content in the return_to_handler and pass its address to the
> function ftrace_return_to_handler to record the return value.
>
> Signed-off-by: Donglin Peng <pengdonglin@sangfor.com.cn>
> ---
> v10:
>  - Fix code style issues for LoongArch
>  - Use CONFIG_FUNCTION_GRAPH_TRACER to control fgraph_ret_regs definition
>
> v9:
>  - Fix stack pointer align issues
>  - Update the commit message
>
> v8:
>  - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> ---
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/include/asm/ftrace.h | 22 ++++++++++++++++++++++
>  arch/loongarch/kernel/asm-offsets.c | 15 ++++++++++++++-
>  arch/loongarch/kernel/mcount.S      | 14 ++++++++------
>  arch/loongarch/kernel/mcount_dyn.S  | 15 ++++++++-------
>  5 files changed, 53 insertions(+), 14 deletions(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index 7fd51257e0ed..4bf60132869b 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -99,6 +99,7 @@ config LOONGARCH
>         select HAVE_FAST_GUP
>         select HAVE_FTRACE_MCOUNT_RECORD
>         select HAVE_FUNCTION_ARG_ACCESS_API
> +       select HAVE_FUNCTION_GRAPH_RETVAL if HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER
>         select HAVE_GENERIC_VDSO
> diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include=
/asm/ftrace.h
> index 3418d32d4fc7..22797b7504b5 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -63,4 +63,26 @@ void ftrace_graph_func(unsigned long ip, unsigned long=
 parent_ip,
>
>  #endif /* CONFIG_FUNCTION_TRACER */
>
> +#ifndef __ASSEMBLY__
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +struct fgraph_ret_regs {
> +       /* a0 - a1 */
> +       unsigned long regs[2];
> +
> +       unsigned long fp;
> +       unsigned long __unused;
> +};
> +
> +static inline unsigned long fgraph_ret_regs_return_value(struct fgraph_r=
et_regs *ret_regs)
> +{
> +       return ret_regs->regs[0];
> +}
> +
> +static inline unsigned long fgraph_ret_regs_frame_pointer(struct fgraph_=
ret_regs *ret_regs)
> +{
> +       return ret_regs->fp;
> +}
> +#endif /* ifdef CONFIG_FUNCTION_GRAPH_TRACER */
> +#endif
> +
>  #endif /* _ASM_LOONGARCH_FTRACE_H */
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/=
asm-offsets.c
> index 4bdb203fc66e..505e4bf59603 100644
> --- a/arch/loongarch/kernel/asm-offsets.c
> +++ b/arch/loongarch/kernel/asm-offsets.c
> @@ -12,6 +12,7 @@
>  #include <asm/cpu-info.h>
>  #include <asm/ptrace.h>
>  #include <asm/processor.h>
> +#include <asm/ftrace.h>
>
>  void output_ptreg_defines(void)
>  {
> @@ -264,7 +265,7 @@ void output_smpboot_defines(void)
>  #ifdef CONFIG_HIBERNATION
>  void output_pbe_defines(void)
>  {
> -       COMMENT(" Linux struct pbe offsets. ");
> +       COMMENT("Linux struct pbe offsets.");
>         OFFSET(PBE_ADDRESS, pbe, address);
>         OFFSET(PBE_ORIG_ADDRESS, pbe, orig_address);
>         OFFSET(PBE_NEXT, pbe, next);
> @@ -272,3 +273,15 @@ void output_pbe_defines(void)
>         BLANK();
>  }
>  #endif
> +
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +void output_fgraph_ret_regs_defines(void)
> +{
> +       COMMENT("LoongArch fgraph_ret_regs offsets.");
> +       OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
> +       OFFSET(FGRET_REGS_A1, fgraph_ret_regs, regs[1]);
> +       OFFSET(FGRET_REGS_FP, fgraph_ret_regs, fp);
> +       DEFINE(FGRET_REGS_SIZE, sizeof(struct fgraph_ret_regs));
> +       BLANK();
> +}
> +#endif
> diff --git a/arch/loongarch/kernel/mcount.S b/arch/loongarch/kernel/mcoun=
t.S
> index 8cdc1563cd33..cb8e5803de4b 100644
> --- a/arch/loongarch/kernel/mcount.S
> +++ b/arch/loongarch/kernel/mcount.S
> @@ -79,18 +79,20 @@ SYM_FUNC_START(ftrace_graph_caller)
>  SYM_FUNC_END(ftrace_graph_caller)
>
>  SYM_FUNC_START(return_to_handler)
> -       PTR_ADDI        sp, sp, -2 * SZREG
> -       PTR_S           a0, sp, 0
> -       PTR_S           a1, sp, SZREG
> +       PTR_ADDI        sp, sp, -FGRET_REGS_SIZE
> +       PTR_S           a0, sp, FGRET_REGS_A0
> +       PTR_S           a1, sp, FGRET_REGS_A1
> +       PTR_S           zero, sp, FGRET_REGS_FP
>
> +       move            a0, sp
>         bl              ftrace_return_to_handler
>
>         /* Restore the real parent address: a0 -> ra */
>         move            ra, a0
>
> -       PTR_L           a0, sp, 0
> -       PTR_L           a1, sp, SZREG
> -       PTR_ADDI        sp, sp, 2 * SZREG
> +       PTR_L           a0, sp, FGRET_REGS_A0
> +       PTR_L           a1, sp, FGRET_REGS_A1
> +       PTR_ADDI        sp, sp, FGRET_REGS_SIZE
>         jr              ra
>  SYM_FUNC_END(return_to_handler)
>  #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
> diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/m=
count_dyn.S
> index bbabf06244c2..ec24ae1de741 100644
> --- a/arch/loongarch/kernel/mcount_dyn.S
> +++ b/arch/loongarch/kernel/mcount_dyn.S
> @@ -131,18 +131,19 @@ SYM_CODE_END(ftrace_graph_caller)
>
>  SYM_CODE_START(return_to_handler)
>         /* Save return value regs */
> -       PTR_ADDI        sp, sp, -2 * SZREG
> -       PTR_S           a0, sp, 0
> -       PTR_S           a1, sp, SZREG
> +       PTR_ADDI        sp, sp, -FGRET_REGS_SIZE
> +       PTR_S           a0, sp, FGRET_REGS_A0
> +       PTR_S           a1, sp, FGRET_REGS_A1
> +       PTR_S           zero, sp, FGRET_REGS_FP
>
> -       move            a0, zero
> +       move            a0, sp
>         bl              ftrace_return_to_handler
>         move            ra, a0
>
>         /* Restore return value regs */
> -       PTR_L           a0, sp, 0
> -       PTR_L           a1, sp, SZREG
> -       PTR_ADDI        sp, sp, 2 * SZREG
> +       PTR_L           a0, sp, FGRET_REGS_A0
> +       PTR_L           a1, sp, FGRET_REGS_A1
> +       PTR_ADDI        sp, sp, FGRET_REGS_SIZE
>
>         jr              ra
>  SYM_CODE_END(return_to_handler)
> --
> 2.25.1
>
