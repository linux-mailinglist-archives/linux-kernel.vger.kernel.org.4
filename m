Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD76D632258
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiKUMhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbiKUMhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:37:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF21D9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669034199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gRniTnQ250/D9FMQbsGUOqQVU6omRQuB8EuAbpKYAkw=;
        b=VREyFfyg6fOyK2UGnRHD9UTRSlfCCz0RJz4i/lInYBaBYMF78ygm3E1unWm0+kcf2oXCVQ
        Sn7XBzBCZEnrrUTMslgCk6iYlWiNtDDiADwPyhMM8VAPwUvIFkOuCGmD4qxGwCAFQ2WGBc
        MWFhU1KncrzXO++lFIsoT0FAtTsat1c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-9rRm0kAzPxO_XCSU2okXWA-1; Mon, 21 Nov 2022 07:36:37 -0500
X-MC-Unique: 9rRm0kAzPxO_XCSU2okXWA-1
Received: by mail-wr1-f70.google.com with SMTP id r6-20020adfbb06000000b00241d4028812so899633wrg.20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:36:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gRniTnQ250/D9FMQbsGUOqQVU6omRQuB8EuAbpKYAkw=;
        b=cH9MRSszQ60ybOrfUMUAPNZkfW8RjSqvjX09VE0uGZKvXVuclMjeGejl/a4ZQpvbf+
         yQQDzs2drIb+bekEp9h7/6Oct8iaZsDt6Y5XvyMOxhLInkzhMOwO/Xyr8A8JjvjJcUlf
         qsO5dL9Wk0eHPI9RWMXWJ1H6hoNGOHHqkpdXUDOPIrINjCWODK8yqRJCBZsXph9jW8b2
         1huQaXNEHLKCUzZsthh/o2W9o80ZeK/8A8CEYnFAsyzmWMsBnqe6RZ6ukc8Ua+I2DEMA
         UjRK5RqwIOC6zZ+XHReQpUfFxoWw+4wgYkqEx3c2l2jxShdCtpVZIKehk3fRv6KqINOi
         eV7Q==
X-Gm-Message-State: ANoB5pkOZfdN93/L8QLv7toRfTDr0zIH7DgkXzUwZEW+k+LVv0AmBKKq
        KQ7bgDjE5eYgtHapjZ0rD81FPuD8w/daM9+BqIGMfkiGWMUCCWzGUhVPAWwFFmKmxadAKrOryMt
        ZXBcYQBaV7F89GTnKLRXK+szR
X-Received: by 2002:a7b:ca55:0:b0:3cf:84e9:e705 with SMTP id m21-20020a7bca55000000b003cf84e9e705mr5494985wml.28.1669034195948;
        Mon, 21 Nov 2022 04:36:35 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6fJdt9vj66HoednnpZcIMbPJ6xqzpTE3KCu7tuygESSBhjFv8UOz7cNS3cm9CNH3XB1fBAqw==
X-Received: by 2002:a7b:ca55:0:b0:3cf:84e9:e705 with SMTP id m21-20020a7bca55000000b003cf84e9e705mr5494966wml.28.1669034195674;
        Mon, 21 Nov 2022 04:36:35 -0800 (PST)
Received: from [10.35.4.238] (bzq-82-81-161-50.red.bezeqint.net. [82.81.161.50])
        by smtp.gmail.com with ESMTPSA id m29-20020a05600c3b1d00b003c6b7f5567csm26808132wms.0.2022.11.21.04.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 04:36:35 -0800 (PST)
Message-ID: <4aadf4616e4f1c6219e7c83ee491494feefa78e1.camel@redhat.com>
Subject: Re: [PATCH 07/13] KVM: SVM: Add VNMI support in get/set_nmi_mask
From:   Maxim Levitsky <mlevitsk@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sandipan Das <sandipan.das@amd.com>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Jing Liu <jing2.liu@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Wyes Karny <wyes.karny@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Babu Moger <babu.moger@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Jim Mattson <jmattson@google.com>, x86@kernel.org,
        Santosh Shukla <santosh.shukla@amd.com>
Date:   Mon, 21 Nov 2022 14:36:33 +0200
In-Reply-To: <Y3aDTvglaSfhG8Tg@google.com>
References: <20221117143242.102721-1-mlevitsk@redhat.com>
         <20221117143242.102721-8-mlevitsk@redhat.com> <Y3aDTvglaSfhG8Tg@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-5.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-11-17 at 18:54 +0000, Sean Christopherson wrote:
> On Thu, Nov 17, 2022, Maxim Levitsky wrote:
> > From: Santosh Shukla <santosh.shukla@amd.com>
> > 
> > VMCB intr_ctrl bit12 (V_NMI_MASK) is set by the processor when handling
> > NMI in guest and is cleared after the NMI is handled. Treat V_NMI_MASK
> > as read-only in the hypervisor except for the SMM case where hypervisor
> > before entring and after leaving SMM mode requires to set and unset
> > V_NMI_MASK.
> > 
> > Adding API(get_vnmi_vmcb) in order to return the correct vmcb for L1 or
> > L2.
> > 
> > Maxim:
> >    - made set_vnmi_mask/clear_vnmi_mask/is_vnmi_mask warn if called
> >      without vNMI enabled
> >    - clear IRET intercept in svm_set_nmi_mask even with vNMI
> > 
> > Signed-off-by: Santosh Shukla <santosh.shukla@amd.com>
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  arch/x86/kvm/svm/svm.c | 18 ++++++++++++++-
> >  arch/x86/kvm/svm/svm.h | 52 ++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 69 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 08a7b2a0a29f3a..c16f68f6c4f7d7 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3618,13 +3618,29 @@ static int svm_nmi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
> >  
> >  static bool svm_get_nmi_mask(struct kvm_vcpu *vcpu)
> >  {
> > -       return !!(vcpu->arch.hflags & HF_NMI_MASK);
> > +       struct vcpu_svm *svm = to_svm(vcpu);
> > +
> > +       if (is_vnmi_enabled(svm))
> > +               return is_vnmi_mask_set(svm);
> > +       else
> > +               return !!(vcpu->arch.hflags & HF_NMI_MASK);
> >  }
> >  
> >  static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
> >  {
> >         struct vcpu_svm *svm = to_svm(vcpu);
> >  
> > +       if (is_vnmi_enabled(svm)) {
> > +               if (masked)
> > +                       set_vnmi_mask(svm);
> 
> I believe not setting INTERCEPT_IRET is correct, but only because the existing
> code is unnecessary.  And this all very subtly relies on KVM_REQ_EVENT being set
> and/or KVM already being in kvm_check_and_inject_events().
> 
> When NMIs become unblocked, INTERCEPT_IRET can be cleared, but KVM should also
> pending KVM_REQ_EVENT.  AFAICT, that doesn't happen when this is called via the
> emulator.  Ah, because em_iret() only handles RM for Intel's restricted guest
> crap.  I.e. it "works" only because it never happens.  All other flows set
> KVM_REQ_EVENT when toggling NMI blocking, e.g. the RSM path of kvm_smm_changed().
Makes sense


> 
> And when NMIs become blocked, there's no need to force INTERCEPT_IRET in this
> code because kvm_check_and_inject_events() will request an NMI window and set the
> intercept if necessary, and all paths that set NMI blocking are guaranteed to
> reach kvm_check_and_inject_events() before entering the guest.

I think I understand what you mean.


When a normal NMI is injected, we do have to intercept IRET because this is how
we know that NMI done executing.

But if NMI becames masked then it can be either if:

1. We are already in NMI, so masking it is essintially NOP, so no need to intercept
IRET since it is already intercepted.

2. We are not in NMI, then we don't need to intercept IRET, since its interception
is not needed to track that NMI is over, but only needed to detect NMI window
(IRET can be used without a paired NMI to unblock NMIs, which is IMHO a very wrong
x86 design decision, but the ship sailed long ago), and so we can intercept IRET
only when we request an actual NMI window.

Makes sense and I'll send a patch to do it.


> 
>   1. RSM => kvm_smm_changed() sets KVM_REQ_EVENT
>   2. enter_smm() is only called from within kvm_check_and_inject_events(),
>      before pending NMIs are processed (yay priority)
>   3. emulator_set_nmi_mask() never blocks NMIs, only does the half-baked IRET emulation
>   4. kvm_vcpu_ioctl_x86_set_vcpu_event() sets KVM_REQ_EVENT
> 
> So, can you add a prep patch to drop the forced INTERCEPT_IRET?  That way the
> logic for vNMI and !vNMI is the same.
> 
> > +               else {
> > +                       clear_vnmi_mask(svm);
> 
> This is the only code that sets/clears the vNMI mask, so rather than have set/clear
> helpers, what about a single helper to do the dirty work? 

Or not have any hepler at all maybe, since it is only done once? I don't know
I just wanted to not change the original patches too much, I only changed
the minimum to make it work.

> 
> > +                       if (!sev_es_guest(vcpu->kvm))
> > +                               svm_clr_intercept(svm, INTERCEPT_IRET);
> > +               }
> > +               return;
> > +       }
> > +
> >         if (masked) {
> >                 vcpu->arch.hflags |= HF_NMI_MASK;
> >                 if (!sev_es_guest(vcpu->kvm))
> > diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> > index f5383104d00580..bf7f4851dee204 100644
> > --- a/arch/x86/kvm/svm/svm.h
> > +++ b/arch/x86/kvm/svm/svm.h
> > @@ -35,6 +35,7 @@ extern u32 msrpm_offsets[MSRPM_OFFSETS] __read_mostly;
> >  extern bool npt_enabled;
> >  extern int vgif;
> >  extern bool intercept_smi;
> > +extern bool vnmi;
> >  
> >  enum avic_modes {
> >         AVIC_MODE_NONE = 0,
> > @@ -531,6 +532,57 @@ static inline bool is_x2apic_msrpm_offset(u32 offset)
> >                (msr < (APIC_BASE_MSR + 0x100));
> >  }
> >  
> > +static inline struct vmcb *get_vnmi_vmcb(struct vcpu_svm *svm)
> > +{
> > +       if (!vnmi)
> > +               return NULL;
> > +
> > +       if (is_guest_mode(&svm->vcpu))
> > +               return svm->nested.vmcb02.ptr;
> > +       else
> > +               return svm->vmcb01.ptr;
> > +}
> > +
> > +static inline bool is_vnmi_enabled(struct vcpu_svm *svm)
> > +{
> > +       struct vmcb *vmcb = get_vnmi_vmcb(svm);
> > +
> > +       if (vmcb)
> > +               return !!(vmcb->control.int_ctl & V_NMI_ENABLE);
> > +       else
> > +               return false;
> 
> Maybe just this?
> 
>         return vmcb && (vmcb->control.int_ctl & V_NMI_ENABLE);
> 
> Or if an inner helper is added:
> 
>         return vmcb && __is_vnmi_enabled(vmcb);
> 
> > +}
> > +
> > +static inline bool is_vnmi_mask_set(struct vcpu_svm *svm)
> > +{
> > +       struct vmcb *vmcb = get_vnmi_vmcb(svm);
> > +
> > +       if (!WARN_ON_ONCE(!vmcb))
> 
> Rather than WARN, add an inner __is_vnmi_enabled() that takes the vnmi_vmcb.
> Actually, if you do that, the test/set/clear helpers can go away entirely.
> 
> > +               return false;
> > +
> > +       return !!(vmcb->control.int_ctl & V_NMI_MASK);
> > +}
> > +
> > +static inline void set_vnmi_mask(struct vcpu_svm *svm)
> > +{
> > +       struct vmcb *vmcb = get_vnmi_vmcb(svm);
> > +
> > +       if (!WARN_ON_ONCE(!vmcb))
> > +               return;
> > +
> > +       vmcb->control.int_ctl |= V_NMI_MASK;
> > +}
> > +
> > +static inline void clear_vnmi_mask(struct vcpu_svm *svm)
> > +{
> > +       struct vmcb *vmcb = get_vnmi_vmcb(svm);
> > +
> > +       if (!WARN_ON_ONCE(!vmcb))
> > +               return;
> > +
> > +       vmcb->control.int_ctl &= ~V_NMI_MASK;
> > +}
> 
> These helpers can all go in svm.  There are no users oustide of svm.c, and
> unless I'm misunderstanding how nested works, there should never be oustide users.
> 
> E.g. with HF_NMI_MASK => svm->nmi_masked, the end result can be something like:
> 
> static bool __is_vnmi_enabled(struct *vmcb)
> {
>         return !!(vmcb->control.int_ctl & V_NMI_ENABLE);
> }
> 
> static bool is_vnmi_enabled(struct vcpu_svm *svm)
> {
>         struct vmcb *vmcb = get_vnmi_vmcb(svm);
> 
>         return vmcb && __is_vnmi_enabled(vmcb);
> }
> 
> static bool svm_get_nmi_mask(struct kvm_vcpu *vcpu)
> {
>         struct vcpu_svm *svm = to_svm(vcpu);
>         struct vmcb *vmcb = get_vnmi_vmcb(svm);
> 
>         if (vmcb && __is_vnmi_enabled(vmcb))
>                 return !!(vmcb->control.int_ctl & V_NMI_MASK);
>         else
>                 return !!(vcpu->arch.hflags & HF_NMI_MASK);
> }
> 
> static void svm_set_or_clear_vnmi_mask(struct vmcb *vmcb, bool set)
> {
>         if (set)
>                 vmcb->control.int_ctl |= V_NMI_MASK;
>         else
>                 vmcb->control.int_ctl &= ~V_NMI_MASK;
> }
> 
> static void svm_set_nmi_mask(struct kvm_vcpu *vcpu, bool masked)
> {
>         struct vcpu_svm *svm = to_svm(vcpu);
>         struct vmcb *vmcb = get_vnmi_vmcb(svm);
> 
>         if (vmcb && __is_vnmi_enabled(vmcb)) {
>                 if (masked)
>                         vmcb->control.int_ctl |= V_NMI_MASK;
>                 else
>                         vmcb->control.int_ctl &= ~V_NMI_MASK;
>         } else {
>                 svm->nmi_masked = masked;
>         }
> 
>         if (!masked)
>                 svm_disable_iret_interception(svm);
> }

OK, this is one of the ways to do it, makes sense overall.
I actualy wanted to do something like that but opted to not touch
the original code too much, but only what I needed. I can do this
in a next version.

Best regards,
	Maxim Levitsky

> 


