Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8135763B3E1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 22:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbiK1VF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 16:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234415AbiK1VFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 16:05:04 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3862F644
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:04:53 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id g15-20020a4a894f000000b0047f8e899623so1848205ooi.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 13:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vRGZCzUJ0ffhia8X2kGoAwEvcGD3EwbjnSNO0K2/wNw=;
        b=EhD2l7i+4krHkkf9vXvO2XsUcD5IiujCezypdNr4fvjW3w70qr5E41O4r2ZyXRmXjX
         p2HI+fJuTvI6Df3He52fE/lU7Dze89xJ1KoZPBtv/zmd2NwCZbj6MT+RAYsDKrxYWBfz
         FiEBLvVukJYZpWpxIjqmBORfCsfBEET/jcuTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vRGZCzUJ0ffhia8X2kGoAwEvcGD3EwbjnSNO0K2/wNw=;
        b=U/r1m0yvFSgZw15r33NoCE8UAVuSsr3mVj1MAl7G4izeCryOOoF4rFD44dWj9ZQ7BB
         W5fie2eU4HgQ9HK8GaII/Y4X90iVAPwHx0bLIc47Q5KSRK/FTNsYHCbEvooJSlfkkQbp
         qmhfBXxE1h2C0SDWNkFLC+QPa792bHrZIzBoad17pudzbkmvbFkrgD3k91c6dUNMVtLE
         VmVBzYc4kw8widxPKIYZaDUCUVDup7ECtT9YZ3u46PpOJtrVFs2Z/YpOaJPRZPde8kNL
         7IWtGWmayAThNQVDeBVQit0+g+tE4LVh3avtV+5sikYXgqV/UOF417ozYLikNglENkd+
         sJbA==
X-Gm-Message-State: ANoB5pkUYtJah75YhqNGYyTXSoq9FT/9iQ8DWTQGQtgy2JDZC1EF29yn
        7HAirw7AbKHid+QOBV94NKyKOCEVV8k3f6omLUXw
X-Google-Smtp-Source: AA0mqf5+31JnISbgZecc7GnG0/XpncjmVgCp7OXM0CWoMRMxsX14BRJcn81qDRI9NepRLIRfMzvOi8k7RRpSLWuz2hI=
X-Received: by 2002:a4a:c58a:0:b0:49f:4297:5612 with SMTP id
 x10-20020a4ac58a000000b0049f42975612mr15036822oop.13.1669669492686; Mon, 28
 Nov 2022 13:04:52 -0800 (PST)
MIME-Version: 1.0
References: <20221128161424.608889-1-apatel@ventanamicro.com> <20221128161424.608889-5-apatel@ventanamicro.com>
In-Reply-To: <20221128161424.608889-5-apatel@ventanamicro.com>
From:   Atish Patra <atishp@atishpatra.org>
Date:   Mon, 28 Nov 2022 13:04:42 -0800
Message-ID: <CAOnJCULajHen9us+AePGKarM1xSXp0wVBXyz7ySQyZz9YQvFaQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] RISC-V: KVM: Use switch-case in kvm_riscv_vcpu_set/get_reg()
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 8:14 AM Anup Patel <apatel@ventanamicro.com> wrote:
>
> We should use switch-case in kvm_riscv_vcpu_set/get_reg() functions
> because the else-if ladder is quite big now.
>
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> ---
>  arch/riscv/kvm/vcpu.c | 36 ++++++++++++++++++++++--------------
>  1 file changed, 22 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index 982a3f5e7130..68c86f632d37 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -544,22 +544,26 @@ static int kvm_riscv_vcpu_set_reg_isa_ext(struct kvm_vcpu *vcpu,
>  static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
>                                   const struct kvm_one_reg *reg)
>  {
> -       if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_CONFIG)
> +       switch (reg->id & KVM_REG_RISCV_TYPE_MASK) {
> +       case KVM_REG_RISCV_CONFIG:
>                 return kvm_riscv_vcpu_set_reg_config(vcpu, reg);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_CORE)
> +       case KVM_REG_RISCV_CORE:
>                 return kvm_riscv_vcpu_set_reg_core(vcpu, reg);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_CSR)
> +       case KVM_REG_RISCV_CSR:
>                 return kvm_riscv_vcpu_set_reg_csr(vcpu, reg);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_TIMER)
> +       case KVM_REG_RISCV_TIMER:
>                 return kvm_riscv_vcpu_set_reg_timer(vcpu, reg);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_F)
> +       case KVM_REG_RISCV_FP_F:
>                 return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
>                                                  KVM_REG_RISCV_FP_F);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
> +       case KVM_REG_RISCV_FP_D:
>                 return kvm_riscv_vcpu_set_reg_fp(vcpu, reg,
>                                                  KVM_REG_RISCV_FP_D);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
> +       case KVM_REG_RISCV_ISA_EXT:
>                 return kvm_riscv_vcpu_set_reg_isa_ext(vcpu, reg);
> +       default:
> +               break;
> +       }
>
>         return -EINVAL;
>  }
> @@ -567,22 +571,26 @@ static int kvm_riscv_vcpu_set_reg(struct kvm_vcpu *vcpu,
>  static int kvm_riscv_vcpu_get_reg(struct kvm_vcpu *vcpu,
>                                   const struct kvm_one_reg *reg)
>  {
> -       if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_CONFIG)
> +       switch (reg->id & KVM_REG_RISCV_TYPE_MASK) {
> +       case KVM_REG_RISCV_CONFIG:
>                 return kvm_riscv_vcpu_get_reg_config(vcpu, reg);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_CORE)
> +       case KVM_REG_RISCV_CORE:
>                 return kvm_riscv_vcpu_get_reg_core(vcpu, reg);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_CSR)
> +       case KVM_REG_RISCV_CSR:
>                 return kvm_riscv_vcpu_get_reg_csr(vcpu, reg);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_TIMER)
> +       case KVM_REG_RISCV_TIMER:
>                 return kvm_riscv_vcpu_get_reg_timer(vcpu, reg);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_F)
> +       case KVM_REG_RISCV_FP_F:
>                 return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
>                                                  KVM_REG_RISCV_FP_F);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_FP_D)
> +       case KVM_REG_RISCV_FP_D:
>                 return kvm_riscv_vcpu_get_reg_fp(vcpu, reg,
>                                                  KVM_REG_RISCV_FP_D);
> -       else if ((reg->id & KVM_REG_RISCV_TYPE_MASK) == KVM_REG_RISCV_ISA_EXT)
> +       case KVM_REG_RISCV_ISA_EXT:
>                 return kvm_riscv_vcpu_get_reg_isa_ext(vcpu, reg);
> +       default:
> +               break;
> +       }
>
>         return -EINVAL;
>  }
> --
> 2.34.1
>


Reviewed-by: Atish Patra <atishp@rivosinc.com>
-- 
Regards,
Atish
