Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FAD6AFAD3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 01:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbjCHABi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 19:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCHABf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 19:01:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1B9A9DF6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 16:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678233646;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qW9gd4/b3QuCzS+63GHXuJKF5Pt62wGmuyBt/HuKDFU=;
        b=iI6aUhUI5OZihRx/FCrTwUGJ1q5SZWcvrgQr8JgJF/WgL6bIc6mlcpZKDSjJ6EPn9KgwtY
        z+DzcUFaKsrfZAAGUGOwkdU0jy8vKjyikwORbuRcbegJquAhHOH0/FeMBuxt5FgWC41plk
        qU+Jf4ThPBX05w+luFyd6NvEzt9hBsY=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-8LC5dZdCN_KrHmntS4FA2w-1; Tue, 07 Mar 2023 19:00:45 -0500
X-MC-Unique: 8LC5dZdCN_KrHmntS4FA2w-1
Received: by mail-vs1-f69.google.com with SMTP id y15-20020a67ebcf000000b0041ed82217a7so5258472vso.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 16:00:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678233645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW9gd4/b3QuCzS+63GHXuJKF5Pt62wGmuyBt/HuKDFU=;
        b=2VO3aEMnvIne0EOJaZ6IhNDKW6zQfO5TLhwv1zcmrPYRBOTqq/rElSaRuKe6Bghux7
         qGHXihHh7MNlOeJwEbtwJAD7s3yk+y1imDeEFpVUl4OjNvXbSB0EknWwvwvGX8nhm3q8
         MF58fSeJ7bHZK61MirtozR57stbxUGpMgTkhAHbHcb18FMyqYoGHKaV70oIRdG8A0C77
         Fixl1cBkVCz4tgRCX91i8lsNVl3Wilkbq+zr/QH3cNjFPNM5v2dbeGNqV/dBj8be5eYQ
         9UqyUud+5IKzARvU8yCKDT38aTGnBHlnP2ZdMaaQZAkseGNrdXWNmPesK4QTtHonFC1z
         N7Dg==
X-Gm-Message-State: AO0yUKXBjJ1ScPE+Kql2RXfIHF3ijf3NUY4EnoJeR6Q9tjqvYNYecxwf
        izz1WxtFD3AKexW1p03HooLE9alsaeg7VFe/nMkzhfSE2BiAWB7w5ed4Qd3KEeaDrUmNUejiqN2
        3T6bNDkobqZixLNtuQuGjmxpleEfk8v8EeWrMnp7S
X-Received: by 2002:ab0:470b:0:b0:688:c23f:c22f with SMTP id h11-20020ab0470b000000b00688c23fc22fmr4697811uac.1.1678233645071;
        Tue, 07 Mar 2023 16:00:45 -0800 (PST)
X-Google-Smtp-Source: AK7set/BU97Goh2kzwmBa+eVG07B3PIYzqn1n+bNBvlA+gkL5SVTwJkgysq7PpnSna9C3/sBL0V2kPVygHjiyJI9mZk=
X-Received: by 2002:ab0:470b:0:b0:688:c23f:c22f with SMTP id
 h11-20020ab0470b000000b00688c23fc22fmr4697797uac.1.1678233644707; Tue, 07 Mar
 2023 16:00:44 -0800 (PST)
MIME-Version: 1.0
References: <20230227171751.1211786-1-jpiotrowski@linux.microsoft.com> <ZAd2MRNLw1JAXmOf@google.com>
In-Reply-To: <ZAd2MRNLw1JAXmOf@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed, 8 Mar 2023 01:00:32 +0100
Message-ID: <CABgObfa1578yKuw3sqnCeLXpyyKmMPgNaftP9HCdgHNM9Tztjw@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Disable TDP MMU when running on Hyper-V
To:     Sean Christopherson <seanjc@google.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Tianyu Lan <ltykernel@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 6:36=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
> Thinking about this more, I would rather revert commit 1e0c7d40758b ("KVM=
: SVM:
> hyper-v: Remote TLB flush for SVM") or fix the thing properly straitaway.=
  KVM
> doesn't magically handle the flushes correctly for the shadow/legacy MMU,=
 KVM just
> happens to get lucky and not run afoul of the underlying bugs.

I don't think it's about luck---the legacy MMU's zapping/invalidation
seems to invoke the flush hypercall correctly:

Jeremi, did you ever track the call stack where
hyperv_nested_flush_guest_mapping is triggered?

Paolo

> The revert appears
> to be reasonably straightforward (see bottom).
>
> And _if_ we want to hack-a-fix it, then I would strongly prefer a very is=
olated,
> obviously hacky fix, e.g.
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 36e4561554ca..a9ba4ae14fda 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5779,8 +5779,13 @@ void kvm_configure_mmu(bool enable_tdp, int tdp_fo=
rced_root_level,
>         tdp_root_level =3D tdp_forced_root_level;
>         max_tdp_level =3D tdp_max_root_level;
>
> +       /*
> +        * FIXME: Remove the enlightened TLB restriction when KVM properl=
y
> +        * handles TLB flushes for said enlightenment.
> +        */.
>  #ifdef CONFIG_X86_64
> -       tdp_mmu_enabled =3D tdp_mmu_allowed && tdp_enabled;
> +       tdp_mmu_enabled =3D tdp_mmu_allowed && tdp_enabled &&
> +                         !(ms_hyperv.nested_features & HV_X64_NESTED_ENL=
IGHTENED_TLB);
>  #endif
>         /*
>          * max_huge_page_level reflects KVM's MMU capabilities irrespecti=
ve
>
>
>
>
> The revert...
>
> ---
>  arch/x86/kvm/svm/svm.c          |  3 ---
>  arch/x86/kvm/svm/svm_onhyperv.h | 27 ---------------------------
>  2 files changed, 30 deletions(-)
>
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 11068e8eb969..292650dc85a0 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1320,7 +1320,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>         if (sev_guest(vcpu->kvm))
>                 sev_init_vmcb(svm);
>
> -       svm_hv_init_vmcb(vmcb);
>         init_vmcb_after_set_cpuid(vcpu);
>
>         vmcb_mark_all_dirty(vmcb);
> @@ -4075,8 +4074,6 @@ static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu,=
 hpa_t root_hpa,
>                 svm->vmcb->control.nested_cr3 =3D __sme_set(root_hpa);
>                 vmcb_mark_dirty(svm->vmcb, VMCB_NPT);
>
> -               hv_track_root_tdp(vcpu, root_hpa);
> -
>                 cr3 =3D vcpu->arch.cr3;
>         } else if (root_level >=3D PT64_ROOT_4LEVEL) {
>                 cr3 =3D __sme_set(root_hpa) | kvm_get_active_pcid(vcpu);
> diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyp=
erv.h
> index 6981c1e9a809..5118fd273e73 100644
> --- a/arch/x86/kvm/svm/svm_onhyperv.h
> +++ b/arch/x86/kvm/svm/svm_onhyperv.h
> @@ -15,31 +15,8 @@ static struct kvm_x86_ops svm_x86_ops;
>
>  int svm_hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu);
>
> -static inline void svm_hv_init_vmcb(struct vmcb *vmcb)
> -{
> -       struct hv_vmcb_enlightenments *hve =3D &vmcb->control.hv_enlighte=
nments;
> -
> -       BUILD_BUG_ON(sizeof(vmcb->control.hv_enlightenments) !=3D
> -                    sizeof(vmcb->control.reserved_sw));
> -
> -       if (npt_enabled &&
> -           ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB)
> -               hve->hv_enlightenments_control.enlightened_npt_tlb =3D 1;
> -
> -       if (ms_hyperv.nested_features & HV_X64_NESTED_MSR_BITMAP)
> -               hve->hv_enlightenments_control.msr_bitmap =3D 1;
> -}
> -
>  static inline void svm_hv_hardware_setup(void)
>  {
> -       if (npt_enabled &&
> -           ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB) {
> -               pr_info(KBUILD_MODNAME ": Hyper-V enlightened NPT TLB flu=
sh enabled\n");
> -               svm_x86_ops.tlb_remote_flush =3D hv_remote_flush_tlb;
> -               svm_x86_ops.tlb_remote_flush_with_range =3D
> -                               hv_remote_flush_tlb_with_range;
> -       }
> -
>         if (ms_hyperv.nested_features & HV_X64_NESTED_DIRECT_FLUSH) {
>                 int cpu;
>
> @@ -80,10 +57,6 @@ static inline void svm_hv_update_vp_id(struct vmcb *vm=
cb, struct kvm_vcpu *vcpu)
>  }
>  #else
>
> -static inline void svm_hv_init_vmcb(struct vmcb *vmcb)
> -{
> -}
> -
>  static inline void svm_hv_hardware_setup(void)
>  {
>  }
>
> base-commit: cb8748a781fe983e451f616ce4861a1c49ce79dd
> --
>

