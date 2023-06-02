Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD8720929
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 20:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjFBSag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 14:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235859AbjFBSae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 14:30:34 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD5C123
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 11:30:33 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-33baee0235cso13465ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 11:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685730632; x=1688322632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDyK58lUidnyjVVYAuq6h8kqn/3ZNeSRFWZ6gY88yo8=;
        b=Qv/hRBQNQRFtRYNvBbjtclB9YP7kgC2TRFhNVlOOcmJ6iWhwmASMM8crJLV1OhCfvt
         yBUEYebj1MYCzSO3HScGfI1riIJQKc53s+xoR8r9E5y0rbapq0valJeE4/aFIkMqvgFi
         mupNxBjD4QZaVuq7YPFWY8JAaS/a17DNuGTUCgaQv5mB4wHF90mrUerqneBwrcUU64Da
         hDQ3kZ5gOeySYlu0ffKD3/M6thz/9S3g3RAN1zpXSIrIWzyRyDscsstxivYWr6Kh2wgP
         YShgKa0G149TMEIf0HFsRTblHNulKIHwh26AoleWuLO1rLtjiz8Tj5H7uJcqUa7sJIhE
         ZouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685730632; x=1688322632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDyK58lUidnyjVVYAuq6h8kqn/3ZNeSRFWZ6gY88yo8=;
        b=EH+3W7JnG02R1E6SllV7WxuMFPTYvP9B7Gwc7dUT3HGWXXk8AfudIvvjdtIbO5k2rT
         HyRtqS2eLwhmceptxfnPoabB+H+nvAxXrmz2OAe7VfAsi2AdfuavXzF53thsM38p6VNe
         VvhcMQxgitkXoSHsg81XiQ27px6nf1tuv4iIXlzUoumXVBrT7emPGfXePtezoWj+d8+9
         bmHd2i0cxzWAXcqzzsU9Yvvtunn5BPV9Vz7xHksBZ68uSd7eGkoQbWMKoeZX0PArEbHj
         mhTzZzokg3jjTu1BPjq2KatyO0sGiRCRz0a12CqUvV/HtvR1UuTDfNeEslS7V+H86spI
         d2QQ==
X-Gm-Message-State: AC+VfDxCohM8HokRH5IENIm12w2lBfEKbA2x+egYev9YXY6T0RxagwxX
        Z8I+ueWAWioYgUop+y2k6hg12CbTxMc1zKeAROGKkA==
X-Google-Smtp-Source: ACHHUZ6jnjb9XQ0zmXNLgIljdsYGjFhc5UzdJPuSuKqIf+dxez3a2bXtn2Icz7m6Sm8IVdzxGGMeq+qjuyjBbmhz3ZQ=
X-Received: by 2002:a05:6e02:1a2d:b0:33b:cea:ce70 with SMTP id
 g13-20020a056e021a2d00b0033b0ceace70mr188162ile.25.1685730632460; Fri, 02 Jun
 2023 11:30:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230602010550.785722-1-seanjc@google.com> <C8324338-FC07-454E-9A5A-1785141FEAB3@nutanix.com>
In-Reply-To: <C8324338-FC07-454E-9A5A-1785141FEAB3@nutanix.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 2 Jun 2023 11:30:21 -0700
Message-ID: <CALMp9eTtkBL3Fb7Dq60go6CL+zGODNn0TTavr436Q-+=mpVFMA@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Use cpu_feature_enabled() for PKU instead of #ifdef
To:     Jon Kohler <jon@nutanix.com>, Mingwei Zhang <mizhang@google.com>
Cc:     Sean Christopherson <seanjc@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 2, 2023 at 8:51=E2=80=AFAM Jon Kohler <jon@nutanix.com> wrote:
>
>
>
> > On Jun 1, 2023, at 9:05 PM, Sean Christopherson <seanjc@google.com> wro=
te:
> >
> > Replace an #ifdef on CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS with a
> > cpu_feature_enabled() check on X86_FEATURE_PKU.  The macro magic of
> > DISABLED_MASK_BIT_SET() means that cpu_feature_enabled() provides the
> > same end result (no code generated) when PKU is disabled by Kconfig.
> >
> > No functional change intended.
> >
> > Cc: Jon Kohler <jon@nutanix.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> > arch/x86/kvm/x86.c | 8 ++------
> > 1 file changed, 2 insertions(+), 6 deletions(-)
> >
> > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > index ceb7c5e9cf9e..eed1f0629023 100644
> > --- a/arch/x86/kvm/x86.c
> > +++ b/arch/x86/kvm/x86.c
> > @@ -1017,13 +1017,11 @@ void kvm_load_guest_xsave_state(struct kvm_vcpu=
 *vcpu)
> >                       wrmsrl(MSR_IA32_XSS, vcpu->arch.ia32_xss);
> >       }
> >
> > -#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> > -     if (static_cpu_has(X86_FEATURE_PKU) &&
> > +     if (cpu_feature_enabled(X86_FEATURE_PKU) &&
> >           vcpu->arch.pkru !=3D vcpu->arch.host_pkru &&
> >           ((vcpu->arch.xcr0 & XFEATURE_MASK_PKRU) ||
> >            kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE)))
> >               write_pkru(vcpu->arch.pkru);
> > -#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
> > }
> > EXPORT_SYMBOL_GPL(kvm_load_guest_xsave_state);
> >
> > @@ -1032,15 +1030,13 @@ void kvm_load_host_xsave_state(struct kvm_vcpu =
*vcpu)
> >       if (vcpu->arch.guest_state_protected)
> >               return;
> >
> > -#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> > -     if (static_cpu_has(X86_FEATURE_PKU) &&
> > +     if (cpu_feature_enabled(X86_FEATURE_PKU) &&
> >           ((vcpu->arch.xcr0 & XFEATURE_MASK_PKRU) ||
> >            kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE))) {
> >               vcpu->arch.pkru =3D rdpkru();
> >               if (vcpu->arch.pkru !=3D vcpu->arch.host_pkru)
> >                       write_pkru(vcpu->arch.host_pkru);
> >       }
> > -#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
> >
> >       if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE)) {
> >
> >
> > base-commit: a053a0e4a9f8c52f3acf8a9d2520c4bf39077a7e
> > --
> > 2.41.0.rc2.161.g9c6817b8e7-goog
> >
>
> Thanks for the cleanup!
>
> Reviewed-by: Jon Kohler <jon@nutanix.com>

+Mingwei Zhang

As we move towards enabling PKRU on the host, due to some customer
requests, I have to wonder if PKRU-disabled is the norm.

In other words, is this a likely() or unlikely() optimization?
