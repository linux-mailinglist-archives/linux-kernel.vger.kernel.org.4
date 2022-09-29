Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E12AB5EFC1E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 19:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiI2Rg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 13:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235336AbiI2Rgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 13:36:53 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81FCA128A0F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:36:52 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id v130so2334821oie.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 10:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=m2slQLKniQAIpwXwtbmtT31VtLVG+vQF8jCakFn5c3k=;
        b=e28KJh8ye09LwusU7Hp2JYupcs4K/9EOLlHOXKBEcTGRpfBlmT10DD+7eoPX6oDNDN
         gOmIx6B2Z00A+twt+kMdJDsYbD1C02+ux3VxTkEPfz6DjkJ5pcJ+0wfsO4VAC0rsduF5
         h7Vs3zq9LpBTrO/w+JhI3OGq7v6DJrADdhdXQOia2E0X1rtzCepRh2ldSVBeiaWJFflP
         DZQV4L+grFhMBiYHpobQ5ntalceV0HAYBbKqkVFH4/Vg62x2syIY2UVq8aES6OavstX/
         Nb34R192SAZZOORzRpbTL8NExW11XsO9PYFS2+z9HBgI/RtMi/CjYdecprvvANqFipy4
         wsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m2slQLKniQAIpwXwtbmtT31VtLVG+vQF8jCakFn5c3k=;
        b=zRR9g3IUD+2mMb/hB7wJhWVpwxxp4kP2Kc7g+FbD6kKoHNmB4AwHMtGeDKfSEhF40x
         6Gv6TUQn/f+jvWUvvsadNTVJ86T3XSernt+t0gKt+oVyezxlkmTePLPxSAjz78gN8wvn
         rFYQ/5v4WVUE053+ODYo5XM1K+WWlkx6A1X+zWjCKI+FKTa5WdI3XTUXUe7V9GQ8L6eG
         aj8Ys8U0ovIRxpD56O1CfeHpV0iF90JhDKO8Ate1ElavUNs3NdyN9MUWCww1PkU/F80L
         DjOcggWerwVbQ/r+ifd6TVVpVk1rZyfCzJl0ASj7vtNGvpSBB88eR//rzRvNF7Pa5HqG
         jRWg==
X-Gm-Message-State: ACrzQf1xLr5InhRThPgNbsvoyR8DERWuE2JkbZWiUGx4HH0/PgWiFdK3
        TQ91+t7UxXmogFAnMCI71wKCkzXaFJZEuVvxmpPoug==
X-Google-Smtp-Source: AMsMyM6URB8Nxlb2bEg0XnD3aEmc9k/eBSwziTXaatYVjSJXEXdWjNrkBw330Kj7ITgAvZN96z998YgpyP+Fe+Ii4/w=
X-Received: by 2002:aca:a8d0:0:b0:34f:7065:84b8 with SMTP id
 r199-20020acaa8d0000000b0034f706584b8mr7381527oie.13.1664473011671; Thu, 29
 Sep 2022 10:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220912115809.76550-1-faresx@amazon.de> <f88f3f67-20af-0ed4-0227-f2f89d5bcd50@amd.com>
In-Reply-To: <f88f3f67-20af-0ed4-0227-f2f89d5bcd50@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Thu, 29 Sep 2022 10:36:40 -0700
Message-ID: <CALMp9eRnMNkmSezPDDb_Pi8O_AG4rmdvy+pik36zMkCnSkzhhg@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: don't apply host security mitigations to the guest
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Fares Mehanna <faresx@amazon.de>,
        Benjamin Serebrin <serebrin@amazon.com>,
        Filippo Sironi <sironi@amazon.de>,
        Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Babu Moger <babu.moger@amd.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 6:47 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 9/12/22 06:58, Fares Mehanna wrote:
> > Support of virtual SPEC_CTRL caused a new behavior in KVM which made host
> > security mitigations applying by default to the guests.
>
> Maybe expand on this to say that the effective mitigation is the host
> SPEC_CTRL value or'd with guest SPEC_CTRL value.
>
> >
> > We noticed a regression after applying the patch, primarily because of the
> > enablement of SSBD on AMD Milan.
> >
> > This patch keeps the new behavior of applying host security mitigations to
> > the guests, but adds an option to disable it so the guests are free to pick
> > their own security mitigations.
> >
> > Fixes: d00b99c514b3 ("KVM: SVM: Add support for Virtual SPEC_CTRL")
> > Signed-off-by: Fares Mehanna <faresx@amazon.de>
> > Reviewed-by: Benjamin Serebrin <serebrin@amazon.com>
> > Reviewed-by: Filippo Sironi <sironi@amazon.de>
> > ---
> >   arch/x86/kvm/svm/svm.c | 12 +++++++++++-
> >   1 file changed, 11 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index f3813dbacb9f..c6ea24685301 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -225,6 +225,10 @@ module_param(avic, bool, 0444);
> >   bool __read_mostly dump_invalid_vmcb;
> >   module_param(dump_invalid_vmcb, bool, 0644);
> >
> > +/* enable/disable applying host security mitigations on the guest */
> > +static bool host_mitigations_on_guest = true;
> > +module_param(host_mitigations_on_guest, bool, 0444);
> > +
> >
> >   bool intercept_smi = true;
> >   module_param(intercept_smi, bool, 0444);
> > @@ -4000,6 +4004,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
> >        */
> >       if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL))
> >               x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
> > +     else if (!host_mitigations_on_guest)
> > +             /*
> > +              * Clear the host MSR before vm-enter to avoid applying host
> > +              * security mitigations to the guest.
> > +              */
> > +             x86_spec_ctrl_set_guest(0, 0);
>
> If X86_FEATURE_V_SPEC_CTRL is active, won't svm->spec_ctrl and
> svm->virt_spec_ctrl always be zero, in which case you can do the if
> statement similar to the below one? Maybe just add a comment that those
> values will be zero in the case of X86_FEATURE_V_SPEC_CTRL, thus
> eliminating the host security mitigation effect.
>
> Thanks,
> Tom
>
> >
> >       svm_vcpu_enter_exit(vcpu);
> >
> > @@ -4025,7 +4035,7 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
> >       if (!sev_es_guest(vcpu->kvm))
> >               reload_tss(vcpu);
> >
> > -     if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL))
> > +     if (!static_cpu_has(X86_FEATURE_V_SPEC_CTRL) || !host_mitigations_on_guest)
> >               x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);

This is much too late to restore the host's value of IA32_SPEC_CTRL on
hosts that are using RETBLEED_MITIGATION_UNRET. The host's
IA32_SPEC_CTRL value should be restored prior to the UNTRAIN_RET in
vmenter.S.

> >       if (!sev_es_guest(vcpu->kvm)) {
