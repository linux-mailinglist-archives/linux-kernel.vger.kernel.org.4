Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D89D6A6686
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCADhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCADhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:37:00 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C4D658F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:36:58 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id f13so48552880edz.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112; t=1677641816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZAYTgdH3g2eA8KTBBY4GQlm36jelREL/yz68bJEPuM=;
        b=Tj2mVbFT7fnS3TZ77xTENZyKAVr8LSBmBF5SW1DpFM8/r0A1EjopgCRIf7Cs4yFDMu
         /oUx5ClByWGaFWMVCJmHR+5IUpDXWzbIwFTN4zJTbLS/Um7JEPVDub5JO3eaaSd0CN+1
         TPLZyga2D0laYByTfldbfjj2vTzSf+yIPj93pgDFPO+FqD63aWnUkqk/hVzMOydGhAi7
         ALYvhP7hlHseJk1gk+Pt035iESstyopmIDeTrnGmh2R2GANtp5VxFJ5oHEy0pBIVCdzZ
         +N/wZi42fsScEEYF99++lT1dCnGNd4DBkZCVgjpzFsR32LoyfocsmGBNyd1j7eC75yd1
         kfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677641816;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZAYTgdH3g2eA8KTBBY4GQlm36jelREL/yz68bJEPuM=;
        b=rxXpCyWsdVTUza6Hln2dxNEz0m5sJ8Jda93eTCOMPqH9xVyT6RIaDh/ozpxsoJhXm6
         l7Mp44Y2Y+11cU2DPEYY2O5JMabTVh74IsUB0BPDQZNDcKZG2u1xIbHcSaz0XrnqqDu+
         xrrodgEz3BW3RHQgYpTt+S7OjmtZaM4jysR5xN0VATyO5Kv9kzmh8OjPgTWKF1u8BLJU
         /TEKym88V899KPGN5dBkZkt53yg5Hr8ffeAyBE3UxvmBTYyQ9yvDeCo0AMkRsyZ1sxGJ
         IGaFDIt1Fv0+iq/6K1gUYj82uEA+Sl+KKYl7Idd9auekUMtZ1iZtmn84n7RDXPZjbTJv
         4X4w==
X-Gm-Message-State: AO0yUKVQ/tU1hkMFqt4Eo9ii88kEXhf2oKTrJnTGWHSFshXQv6lRZbLh
        AWY2JyWBsG84Zwz0UY8Se/7soNrs8KaubRJdWfKshw==
X-Google-Smtp-Source: AK7set+dLONCBXH4RidKQNVKyCSGG1a2E+iXTX58/fAlnCKopTiu8AO/bZzUT4U40KUp1mzv2LoYMpt5uHuzD9MiSX8=
X-Received: by 2002:a17:906:3586:b0:8ab:b606:9728 with SMTP id
 o6-20020a170906358600b008abb6069728mr2502509ejb.5.1677641816479; Tue, 28 Feb
 2023 19:36:56 -0800 (PST)
MIME-Version: 1.0
References: <20230208140105.655814-1-thuth@redhat.com> <20230208140105.655814-7-thuth@redhat.com>
In-Reply-To: <20230208140105.655814-7-thuth@redhat.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 1 Mar 2023 09:06:44 +0530
Message-ID: <CAAhSdy2=_6wP9LYXbxajtkaes013oWF6O-fOizcz_QC2ivZfvw@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] KVM: Change return type of kvm_arch_vm_ioctl() to "int"
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org,
        kvm-riscv@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Gavin Shan <gshan@redhat.com>,
        Steven Price <steven.price@arm.com>,
        Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 8, 2023 at 7:31=E2=80=AFPM Thomas Huth <thuth@redhat.com> wrote=
:
>
> All kvm_arch_vm_ioctl() implementations now only deal with "int"
> types as return values, so we can change the return type of these
> functions to use "int" instead of "long".
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Looks good to me.

For KVM RISC-V:
Acked-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
>  arch/arm64/kvm/arm.c       | 3 +--
>  arch/mips/kvm/mips.c       | 4 ++--
>  arch/powerpc/kvm/powerpc.c | 5 ++---
>  arch/riscv/kvm/vm.c        | 3 +--
>  arch/s390/kvm/kvm-s390.c   | 3 +--
>  arch/x86/kvm/x86.c         | 3 +--
>  include/linux/kvm_host.h   | 3 +--
>  7 files changed, 9 insertions(+), 15 deletions(-)
>
> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 9c5573bc4614..e791ad6137b8 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1449,8 +1449,7 @@ static int kvm_vm_ioctl_set_device_addr(struct kvm =
*kvm,
>         }
>  }
>
> -long kvm_arch_vm_ioctl(struct file *filp,
> -                      unsigned int ioctl, unsigned long arg)
> +int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned lo=
ng arg)
>  {
>         struct kvm *kvm =3D filp->private_data;
>         void __user *argp =3D (void __user *)arg;
> diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
> index a25e0b73ee70..84cadaa2c2d3 100644
> --- a/arch/mips/kvm/mips.c
> +++ b/arch/mips/kvm/mips.c
> @@ -1003,9 +1003,9 @@ void kvm_arch_flush_remote_tlbs_memslot(struct kvm =
*kvm,
>         kvm_flush_remote_tlbs(kvm);
>  }
>
> -long kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned l=
ong arg)
> +int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned lo=
ng arg)
>  {
> -       long r;
> +       int r;
>
>         switch (ioctl) {
>         default:
> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index 04494a4fb37a..6f6ba55c224f 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -2386,12 +2386,11 @@ static int kvmppc_get_cpu_char(struct kvm_ppc_cpu=
_char *cp)
>  }
>  #endif
>
> -long kvm_arch_vm_ioctl(struct file *filp,
> -                       unsigned int ioctl, unsigned long arg)
> +int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned lo=
ng arg)
>  {
>         struct kvm *kvm __maybe_unused =3D filp->private_data;
>         void __user *argp =3D (void __user *)arg;
> -       long r;
> +       int r;
>
>         switch (ioctl) {
>         case KVM_PPC_GET_PVINFO: {
> diff --git a/arch/riscv/kvm/vm.c b/arch/riscv/kvm/vm.c
> index 65a964d7e70d..c13130ab459a 100644
> --- a/arch/riscv/kvm/vm.c
> +++ b/arch/riscv/kvm/vm.c
> @@ -87,8 +87,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long =
ext)
>         return r;
>  }
>
> -long kvm_arch_vm_ioctl(struct file *filp,
> -                      unsigned int ioctl, unsigned long arg)
> +int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned lo=
ng arg)
>  {
>         return -EINVAL;
>  }
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 8ad1972b8a73..86ca49814983 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2850,8 +2850,7 @@ static int kvm_s390_vm_mem_op(struct kvm *kvm, stru=
ct kvm_s390_mem_op *mop)
>         return r;
>  }
>
> -long kvm_arch_vm_ioctl(struct file *filp,
> -                      unsigned int ioctl, unsigned long arg)
> +int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned lo=
ng arg)
>  {
>         struct kvm *kvm =3D filp->private_data;
>         void __user *argp =3D (void __user *)arg;
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 2d210ab47e21..52a8c993cd55 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -6645,8 +6645,7 @@ static int kvm_vm_ioctl_set_clock(struct kvm *kvm, =
void __user *argp)
>         return 0;
>  }
>
> -long kvm_arch_vm_ioctl(struct file *filp,
> -                      unsigned int ioctl, unsigned long arg)
> +int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned lo=
ng arg)
>  {
>         struct kvm *kvm =3D filp->private_data;
>         void __user *argp =3D (void __user *)arg;
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 4f26b244f6d0..ed2f1f02976b 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -1398,8 +1398,7 @@ int kvm_vm_ioctl_irq_line(struct kvm *kvm, struct k=
vm_irq_level *irq_level,
>                         bool line_status);
>  int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
>                             struct kvm_enable_cap *cap);
> -long kvm_arch_vm_ioctl(struct file *filp,
> -                      unsigned int ioctl, unsigned long arg);
> +int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned lo=
ng arg);
>  long kvm_arch_vm_compat_ioctl(struct file *filp, unsigned int ioctl,
>                               unsigned long arg);
>
> --
> 2.31.1
>
>
> --
> kvm-riscv mailing list
> kvm-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/kvm-riscv
