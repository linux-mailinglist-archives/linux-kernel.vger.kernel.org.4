Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56FAE6828C9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 10:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232521AbjAaJ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 04:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjAaJ0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 04:26:08 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3531E9FE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:26:07 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id n2so9796725pfo.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 01:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iuOgM24FK59+MffbRIrpSxSdYJY4cKp8hxWLQ7aDyK0=;
        b=mDT4gnR+VFMLC+hvEwWESSYsHhM3swOUMRQkP7LTrvMO2H9o2ZwcW4L7joLuD/XQwX
         owIFiUtwX0EGsPgrnDgoORXLCKM8QzfTDMe8BfdRvCFHYRYmBU13DPROvapuJO+ATfiL
         /5nWa+4I5Ki0TZMWoDyQoeXTyxNcprRRb+lSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iuOgM24FK59+MffbRIrpSxSdYJY4cKp8hxWLQ7aDyK0=;
        b=0Am3I2Sxgm1PrrhYLmzIDE+KCxA2UqVJj+gTPtPcyMwgXdyO1WamU34VZk2NuimwaW
         /Iqpfx5xhtEKBylw6FxoZdbdGMesWhur9BYkYJYjIHphGUrSmUnFq+X79Bqmi04UgO1P
         8bQfqMENW0ev198z9aHZX1gGhNlGEkJ2RjJBw2LxsnQAKiv23kRpwwRIDVEtgEzUsr3m
         tqq0cjBbXjLZbkM/GWIr4zbzAuQAsYIN4E3cUZ7ZCMul77XN2fFg5NDSMTK7toD3kIEA
         wpnovA7EoVhcVaRZR8NP6YG41GHImxylxzi3B6kPa+GFeKkEZa1YaV5BEADLW3DYm+mP
         NLNw==
X-Gm-Message-State: AO0yUKUNN5Xh3vQCKOURzuPiIYdl+7g38dvn/yha5SyIAeLd4mzbS+bT
        V3e4Qb2nzOLJNOfbUw8P8mzX4Yiq73eawfBQ6pFO
X-Google-Smtp-Source: AK7set/MSOrSxz1qNdOEo3o9mrx0RsLwAY3Thk/17kJxDWGdCN+7K9AXDb2PlDva9XbGN0WlRZI59ue/ZbriaRWQtuw=
X-Received: by 2002:a63:510a:0:b0:4da:6df2:f28 with SMTP id
 f10-20020a63510a000000b004da6df20f28mr2526765pgb.36.1675157166777; Tue, 31
 Jan 2023 01:26:06 -0800 (PST)
MIME-Version: 1.0
References: <20230128072737.2995881-1-apatel@ventanamicro.com> <20230128072737.2995881-3-apatel@ventanamicro.com>
In-Reply-To: <20230128072737.2995881-3-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Tue, 31 Jan 2023 01:25:55 -0800
Message-ID: <CAOnJCUJnEMxQxjDtzAJe5_0edi=1pQLVE-LDeQtH9bzn7+O4rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] RISC-V: Detect AIA CSRs from ISA string
To:     Anup Patel <apatel@ventanamicro.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>, kvm@vger.kernel.org,
        kvm-riscv@lists.infradead.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2023 at 11:27 PM Anup Patel <apatel@ventanamicro.com> wrote:
>
> We have two extension names for AIA ISA support: Smaia (M-mode AIA CSRs)
> and Ssaia (S-mode AIA CSRs).
>
> We extend the ISA string parsing to detect Smaia and Ssaia extensions.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/include/asm/hwcap.h | 2 ++
>  arch/riscv/kernel/cpu.c        | 2 ++
>  arch/riscv/kernel/cpufeature.c | 2 ++
>  3 files changed, 6 insertions(+)
>
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 86328e3acb02..341ef30a3718 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -59,6 +59,8 @@ enum riscv_isa_ext_id {
>         RISCV_ISA_EXT_ZIHINTPAUSE,
>         RISCV_ISA_EXT_SSTC,
>         RISCV_ISA_EXT_SVINVAL,
> +       RISCV_ISA_EXT_SMAIA,
> +       RISCV_ISA_EXT_SSAIA,
>         RISCV_ISA_EXT_ID_MAX
>  };
>  static_assert(RISCV_ISA_EXT_ID_MAX <= RISCV_ISA_EXT_MAX);
> diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
> index 1b9a5a66e55a..a215ec929160 100644
> --- a/arch/riscv/kernel/cpu.c
> +++ b/arch/riscv/kernel/cpu.c
> @@ -162,6 +162,8 @@ arch_initcall(riscv_cpuinfo_init);
>   *    extensions by an underscore.
>   */
>  static struct riscv_isa_ext_data isa_ext_arr[] = {
> +       __RISCV_ISA_EXT_DATA(smaia, RISCV_ISA_EXT_SMAIA),
> +       __RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
>         __RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
>         __RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
>         __RISCV_ISA_EXT_DATA(svinval, RISCV_ISA_EXT_SVINVAL),
> diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> index 93e45560af30..3c5b51f519d5 100644
> --- a/arch/riscv/kernel/cpufeature.c
> +++ b/arch/riscv/kernel/cpufeature.c
> @@ -228,6 +228,8 @@ void __init riscv_fill_hwcap(void)
>                                 SET_ISA_EXT_MAP("zihintpause", RISCV_ISA_EXT_ZIHINTPAUSE);
>                                 SET_ISA_EXT_MAP("sstc", RISCV_ISA_EXT_SSTC);
>                                 SET_ISA_EXT_MAP("svinval", RISCV_ISA_EXT_SVINVAL);
> +                               SET_ISA_EXT_MAP("smaia", RISCV_ISA_EXT_SMAIA);
> +                               SET_ISA_EXT_MAP("ssaia", RISCV_ISA_EXT_SSAIA);
>                         }
>  #undef SET_ISA_EXT_MAP
>                 }
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
-- 
Regards,
Atish
