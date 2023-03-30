Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9066F6D0541
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbjC3MtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbjC3MtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:49:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75042119;
        Thu, 30 Mar 2023 05:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0812E62047;
        Thu, 30 Mar 2023 12:49:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E22BC433AC;
        Thu, 30 Mar 2023 12:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680180541;
        bh=yV9hHzrRv1Q6YO/PdQ447kMj3RlfZO5Fr+eLDq36l50=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mFUxEZ3TPoV2bw0KRvhO31NHmZmp+LWiHXpcv+4Nn7VWa4O/FHQBe/K171IyMzv6m
         Ld6t24Cb8v1Va1ue/4sIaK23KzjyQxuziunua7QZ2YPdqKuMmSr7PLfUKHYR7J3q9s
         vk7GZQOw9wV2Ssx1IxnmXalzXs+PUueShwnAO2l5uXV1Z86cy9mBCQEt6q2aqUzk+g
         cME0WMvf++Q6qCiFU3Oyc7e9xZjGub9FvTuL+L7ivkC7i1oRAUsYaWh+eTjcGtrVe2
         2ufORhpdVPwE2BiC3q4GPP3M4qQQSbFyaYLny5jp1FN1kUBX4hNalV9HjTXGH1awkx
         8J51arUwV88uQ==
Received: by mail-ed1-f49.google.com with SMTP id ek18so76017067edb.6;
        Thu, 30 Mar 2023 05:49:01 -0700 (PDT)
X-Gm-Message-State: AAQBX9dtfVowtW/a4B4O775yj11jDb0pSPss9c//8HElyqZSw5iNmgxz
        yZSuG9NcCOq3oz2zSvsDQ8cAfoqqy8zA2nRfP7I=
X-Google-Smtp-Source: AKy350ZH0jFZI1WI2KtHRVvkWLp8L5lTXda4hknwrBePqSdsSuFC43mzEmglBCbxw5rBcJjvu/354j56uso9yS4lX2s=
X-Received: by 2002:a17:907:6e29:b0:93b:cd04:28 with SMTP id
 sd41-20020a1709076e2900b0093bcd040028mr12100850ejc.10.1680180539469; Thu, 30
 Mar 2023 05:48:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1680176068.git.pengdonglin@sangfor.com.cn> <df4919a76bbf733330158f6ec43c2d424b02d6e1.1680176068.git.pengdonglin@sangfor.com.cn>
In-Reply-To: <df4919a76bbf733330158f6ec43c2d424b02d6e1.1680176068.git.pengdonglin@sangfor.com.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 30 Mar 2023 20:48:45 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6OTxsbM53G4=YSmm0cDTBaAyKJ8zOS+UK6Wx-T7rvLSg@mail.gmail.com>
Message-ID: <CAAhV-H6OTxsbM53G4=YSmm0cDTBaAyKJ8zOS+UK6Wx-T7rvLSg@mail.gmail.com>
Subject: Re: [PATCH v9 7/8] LoongArch: ftrace: Enable HAVE_FUNCTION_GRAPH_RETVAL
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
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Donglin,

On Thu, Mar 30, 2023 at 7:39=E2=80=AFPM Donglin Peng <pengdonglin@sangfor.c=
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
> v9:
>  - Fix stack pointer align issues
>  - Update the commit message
>
> v8:
>  - Modify the control range of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
> ---
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/include/asm/ftrace.h | 20 ++++++++++++++++++++
>  arch/loongarch/kernel/asm-offsets.c | 12 ++++++++++++
>  arch/loongarch/kernel/mcount.S      | 14 ++++++++------
>  arch/loongarch/kernel/mcount_dyn.S  | 15 ++++++++-------
>  5 files changed, 49 insertions(+), 13 deletions(-)
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
> index 3418d32d4fc7..01e7f92de03c 100644
> --- a/arch/loongarch/include/asm/ftrace.h
> +++ b/arch/loongarch/include/asm/ftrace.h
> @@ -63,4 +63,24 @@ void ftrace_graph_func(unsigned long ip, unsigned long=
 parent_ip,
>
>  #endif /* CONFIG_FUNCTION_TRACER */
>
> +#ifndef __ASSEMBLY__
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
> +#endif
> +
>  #endif /* _ASM_LOONGARCH_FTRACE_H */
> diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/=
asm-offsets.c
> index 4bdb203fc66e..fab5bcddeb23 100644
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
> @@ -60,6 +61,17 @@ void output_ptreg_defines(void)
>         BLANK();
>  }
>
> +
> +void output_fgraph_ret_regs_defines(void)
> +{
> +       COMMENT(" LoongArch fgraph_ret_regs offsets. ");
No space needed at the beginning, and I prefer to move this function
to the end of this file.

Huacai
> +       OFFSET(FGRET_REGS_A0, fgraph_ret_regs, regs[0]);
> +       OFFSET(FGRET_REGS_A1, fgraph_ret_regs, regs[1]);
> +       OFFSET(FGRET_REGS_FP, fgraph_ret_regs, fp);
> +       DEFINE(FGRET_REGS_SIZE, sizeof(struct fgraph_ret_regs));
> +       BLANK();
> +}
> +
>  void output_task_defines(void)
>  {
>         COMMENT("LoongArch task_struct offsets.");
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
