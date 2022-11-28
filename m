Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D456B63B3F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234446AbiK1VJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234471AbiK1VIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:08:54 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571162F660
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:08:20 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s206so13040422oie.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:08:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jSBfsqCjFUVdLz7ulQ1i3UEkSNxvV0b23GvomxS/sUQ=;
        b=rLHtAPO4mqSfikiodD24FI+oWCKcxXu13WH/iIuPpfO7+LFnq8JEVROmBSArLXBjws
         zBn1FscaWxifjhKOK14Kwvb32xvFgPq6s5W1YKc2w/vfNgSn4+UjcpkmslJcwW73zLjs
         sLUFZiFB859WxDekzTIwggyRPPIXycnk03XO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jSBfsqCjFUVdLz7ulQ1i3UEkSNxvV0b23GvomxS/sUQ=;
        b=P+TYaKEn4N3FaWVUpjybXBQKlzRcpQ77fsm1iBG/VAHqBchF0sgLIbuIeIBPWS6Lxf
         1C5aNCmjejX12d6xmAg9Cz4iweDuBTv893Iln021A7ZrpUESs6HzIM8iRaT4RJYz7wGf
         0muDeSWzbDlUWEh/sls2oPiziGWAVzKcdRJqHBtfvEFPetoz/cZKo1oMR/58M7hxdOEy
         OhVabp3PnoKAZoZXSVT1n9ij2m4Zb0fcUZFQUfaz1mOLRy70yWJ+S0YsNwcsX7bga2vt
         rFXEcOoPmavjfn/YW86m3aZYG+o0BbBnL3v617otr9LSH4G9U8NSBr2ec4OQK0k97LNe
         IW1g==
X-Gm-Message-State: ANoB5plt9GV5wkC8LOeSL7z8ultIobb402exxBvt4KwXh/ALfcVIiH09
        udQ+gONNXWG5mUBBYGnM2uGyIKgXBbNE2q4nY3Iw
X-Google-Smtp-Source: AA0mqf747TRpJM0z0cNNdw0eBXubIWGs0+ixNACK9zM7uCm1pKpeqai+fmM/x3tLSK/eylcYsOBLju2tPTxVJKt7pMA=
X-Received: by 2002:a05:6808:a90:b0:35b:aa33:425a with SMTP id
 q16-20020a0568080a9000b0035baa33425amr4729498oij.181.1669669699655; Mon, 28
 Nov 2022 13:08:19 -0800 (PST)
MIME-Version: 1.0
References: <20221128161424.608889-1-apatel@ventanamicro.com> <20221128161424.608889-8-apatel@ventanamicro.com>
In-Reply-To: <20221128161424.608889-8-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 28 Nov 2022 13:08:08 -0800
Message-ID: <CAOnJCUK3Dffumx0cY7tJbncuinnkLwpGfH7oNXebXM5SeCciQQ@mail.gmail.com>
Subject: Re: [PATCH 7/9] RISC-V: KVM: Save mvendorid, marchid, and mimpid when
 creating VCPU
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

On Mon, Nov 28, 2022 at 8:15 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> We should save VCPU mvendorid, marchid, and mimpid at the time
> of creating VCPU so that we don't have to do host SBI call every
> time Guest/VM ask for these details.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  arch/riscv/include/asm/kvm_host.h |  5 +++++
>  arch/riscv/kvm/vcpu.c             |  6 ++++++
>  arch/riscv/kvm/vcpu_sbi_base.c    | 11 +++++------
>  3 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/include/asm/kvm_host.h b/arch/riscv/include/asm/kvm_host.h
> index 91c74b09a970..93f43a3e7886 100644
> --- a/arch/riscv/include/asm/kvm_host.h
> +++ b/arch/riscv/include/asm/kvm_host.h
> @@ -165,6 +165,11 @@ struct kvm_vcpu_arch {
>         /* ISA feature bits (similar to MISA) */
>         DECLARE_BITMAP(isa, RISCV_ISA_EXT_MAX);
>
> +       /* Vendor, Arch, and Implementation details */
> +       unsigned long mvendorid;
> +       unsigned long marchid;
> +       unsigned long mimpid;
> +
>         /* SSCRATCH, STVEC, and SCOUNTEREN of Host */
>         unsigned long host_sscratch;
>         unsigned long host_stvec;
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 68c86f632d37..312a8a926867 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -21,6 +21,7 @@
>  #include <asm/csr.h>
>  #include <asm/cacheflush.h>
>  #include <asm/hwcap.h>
> +#include <asm/sbi.h>
>
>  const struct _kvm_stats_desc kvm_vcpu_stats_desc[] = {
>         KVM_GENERIC_VCPU_STATS(),
> @@ -171,6 +172,11 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>                         set_bit(host_isa, vcpu->arch.isa);
>         }
>
> +       /* Setup vendor, arch, and implementation details */
> +       vcpu->arch.mvendorid = sbi_get_mvendorid();
> +       vcpu->arch.marchid = sbi_get_marchid();
> +       vcpu->arch.mimpid = sbi_get_mimpid();
> +
>         /* Setup VCPU hfence queue */
>         spin_lock_init(&vcpu->arch.hfence_lock);
>
> diff --git a/arch/riscv/kvm/vcpu_sbi_base.c b/arch/riscv/kvm/vcpu_sbi_base.c
> index 0c806f61c629..5d65c634d301 100644
> --- a/arch/riscv/kvm/vcpu_sbi_base.c
> +++ b/arch/riscv/kvm/vcpu_sbi_base.c
> @@ -19,7 +19,6 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>  {
>         int ret = 0;
>         struct kvm_cpu_context *cp = &vcpu->arch.guest_context;
> -       struct sbiret ecall_ret;
>
>         switch (cp->a6) {
>         case SBI_EXT_BASE_GET_SPEC_VERSION:
> @@ -48,13 +47,13 @@ static int kvm_sbi_ext_base_handler(struct kvm_vcpu *vcpu, struct kvm_run *run,
>                         *out_val = kvm_vcpu_sbi_find_ext(cp->a0) ? 1 : 0;
>                 break;
>         case SBI_EXT_BASE_GET_MVENDORID:
> +               *out_val = vcpu->arch.mvendorid;
> +               break;
>         case SBI_EXT_BASE_GET_MARCHID:
> +               *out_val = vcpu->arch.marchid;
> +               break;
>         case SBI_EXT_BASE_GET_MIMPID:
> -               ecall_ret = sbi_ecall(SBI_EXT_BASE, cp->a6, 0, 0, 0, 0, 0, 0);
> -               if (!ecall_ret.error)
> -                       *out_val = ecall_ret.value;
> -               /*TODO: We are unnecessarily converting the error twice */
> -               ret = sbi_err_map_linux_errno(ecall_ret.error);
> +               *out_val = vcpu->arch.mimpid;
>                 break;
>         default:
>                 ret = -EOPNOTSUPP;
> --
> 2.34.1
>

Reviewed-by: Atish Patra <atishp@rivosinc.com>

-- 
Regards,
Atish
