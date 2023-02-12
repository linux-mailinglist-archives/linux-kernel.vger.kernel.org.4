Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D9069357A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 02:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjBLBIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 20:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjBLBIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 20:08:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067101714C
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 17:08:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 93CC3B80990
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 01:08:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05983C433A0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 01:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676164124;
        bh=58U1Dqlnv9v36C86XyGXn6ypMhMFLysfhN7tIZNEoyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MTp2Lce+/i0os3eYUSPVczRA5cnJfJiuaYMejVzF/gBvAr8Cri/0IpClGFBIO6FFK
         erHysyLJrzzsV9JMuAB252My06EbZq/7rbd37FHw6vtGNTRa/IxObTUu/Gt5MXB8rs
         aHQe3HHdQo5aO9iYhbhSamAi4OMU6zz/zhHpGxnVo2KlDE5xryPy+BhQlcjHHaJJnt
         MDIuKQDOie/10eTdDrbs5fzTkvFQtG8bK6IQNeEimX8Dc+GSOEhRkP4euJQRur2YoL
         gelAasXAjocgFzSvUWKqTW0ZwUQ376P4OzHqBt0eHzSz/2var2HGnTqCp3YoJMGwrp
         /grExj7YnKDZw==
Received: by mail-ej1-f46.google.com with SMTP id hx15so24173580ejc.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 17:08:43 -0800 (PST)
X-Gm-Message-State: AO0yUKVP+lW0dnwTcB6pigTzTActY8OoHErXqZNpS7L6fiUX3EPEaAOC
        KkM3DHiRIUPLJzUgEAOCSYDi12mYbeDysxfFyCU=
X-Google-Smtp-Source: AK7set/kh5n/aPHMLu7Jsv/wO/kU6CTfApIOJ/T7gJf5v1cJWRqmjFjiFv/fp9N28WEByaYGd0wwUSEddwhXxVPXPWA=
X-Received: by 2002:a17:906:5202:b0:877:7480:c561 with SMTP id
 g2-20020a170906520200b008777480c561mr2788767ejm.1.1676164122228; Sat, 11 Feb
 2023 17:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20230211084414.25998-1-zhangqing@loongson.cn>
In-Reply-To: <20230211084414.25998-1-zhangqing@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Sun, 12 Feb 2023 09:08:29 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5hZSysZQQYHwiiQTMEEUyekpPQ_+pijw5TLze7UiTLng@mail.gmail.com>
Message-ID: <CAAhV-H5hZSysZQQYHwiiQTMEEUyekpPQ_+pijw5TLze7UiTLng@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: ptrace: Add function argument access API
To:     Qing Zhang <zhangqing@loongson.cn>
Cc:     Oleg Nesterov <oleg@redhat.com>, WANG Xuerui <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 4:44 PM Qing Zhang <zhangqing@loongson.cn> wrote:
>
> Add regs_get_argument() which returns N th argument of the function
> call, t show This enables ftrace kprobe events to access kernel function
> arguments via $argN syntax.
Sadly, I think this message should be rewritten.

>
> eg:
> echo 'p bio_add_page arg1=$arg1' > kprobe_events
> bash: echo: write error: Invalid argument
>
> Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
> ---
>  arch/loongarch/Kconfig              |  1 +
>  arch/loongarch/include/asm/ptrace.h | 33 +++++++++++++++++++++++++++++
>  2 files changed, 34 insertions(+)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index e3eba2eb4b44..103046966893 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -97,6 +97,7 @@ config LOONGARCH
>         select HAVE_EXIT_THREAD
>         select HAVE_FAST_GUP
>         select HAVE_FTRACE_MCOUNT_RECORD
> +       select HAVE_FUNCTION_ARG_ACCESS_API
>         select HAVE_FUNCTION_GRAPH_TRACER
>         select HAVE_FUNCTION_TRACER
>         select HAVE_GENERIC_VDSO
> diff --git a/arch/loongarch/include/asm/ptrace.h b/arch/loongarch/include/asm/ptrace.h
> index 66a0e6c480a3..f6ffcc00753c 100644
> --- a/arch/loongarch/include/asm/ptrace.h
> +++ b/arch/loongarch/include/asm/ptrace.h
> @@ -120,6 +120,39 @@ static inline long regs_return_value(struct pt_regs *regs)
>         return regs->regs[4];
>  }
>
> +/**
> + * regs_get_kernel_argument() - get Nth function argument in kernel
> + * @regs:       pt_regs of that context
> + * @n:          function argument number (start from 0)
> + *
> + * regs_get_argument() returns @n th argument of the function call.
> + * Note that this chooses most probably assignment, in some case
> + * it can be incorrect.
> + * This is expected to be called from kprobes or ftrace with regs
> + * where the top of stack is the return address.
> + */
> +static inline unsigned long regs_get_kernel_argument(struct pt_regs *regs,
> +                                                    unsigned int n)
> +{
> +       static const unsigned int argument_offs[] = {
> +               offsetof(struct pt_regs, regs[4]),
> +               offsetof(struct pt_regs, regs[5]),
> +               offsetof(struct pt_regs, regs[6]),
> +               offsetof(struct pt_regs, regs[7]),
> +               offsetof(struct pt_regs, regs[8]),
> +               offsetof(struct pt_regs, regs[9]),
> +               offsetof(struct pt_regs, regs[10]),
> +               offsetof(struct pt_regs, regs[11]),
> +#define NR_REG_ARGUMENTS 8
> +       };
> +
> +       if (n >= NR_REG_ARGUMENTS) {
> +               n -= NR_REG_ARGUMENTS;
> +               return regs_get_kernel_stack_nth(regs, n);
> +       } else
> +               return regs_get_register(regs, argument_offs[n]);
> +}
> +
>  #define instruction_pointer(regs) ((regs)->csr_era)
>  #define profile_pc(regs) instruction_pointer(regs)
>
> --
> 2.36.0
>
