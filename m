Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64138743EF0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 17:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjF3Pcy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 11:32:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231633AbjF3Pcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 11:32:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23BE49C9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:31:13 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bf34588085bso1863684276.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 08:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688139073; x=1690731073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsmw8jfciOwOf213T4vvvPY507/uByM+euYpoT+ptPg=;
        b=6D0cPh+YeGLV8h/5nl0BrWU1nUHMKAygp6XFTnbzbVbzPdSQq4/ECryMaHR5gvfsav
         NXTGslGrBOjg7lgnNb5aHwxGAoINBxGmiGeDZsrxbRnoQqwY/NM2FdzBlytI2TixQg7U
         TLQeIAv+Ntmzte95EoKJuz8ijPtLyHdpgh0L+8Bledrd6WBR8pi8zcueQHPBZxl1xtMi
         A7l4wp+0ksdBdPxWnM8hap5e+ZNHevlDyIAjwAz+tm2010ZiKkbfRWf+EMRdsEuRwiH7
         uiAXX9mP9Y/vMUfcuUlhEtcfG9N+V9kaPtL6CcOvugUCgx0MsqshYTEJXD79h9ROcSKb
         r7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139073; x=1690731073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bsmw8jfciOwOf213T4vvvPY507/uByM+euYpoT+ptPg=;
        b=fkkPOm6fjOvYjaI0qgiUQuTLVfdwAw0YH73CGeC5DlflSC+F8amio7ItvjuQ90FlM0
         D7OKTSoESVEDjKL7fZQo8Qdi/8m4TOcRXY00nfX45Z6bzj+obsmaQAWs+9d1vOKl0Oud
         z465jLvQ1YrcGt6RuJMeKNkHiGdK+7ebfLiVNYQHbi95HgG4B6JWMvRMTxs02THNZwLQ
         jksznAzFVVhbT6fzr8iVH83h+V5J9/3njz6uBIRvRHAgdH/5LpZMfzJyQcK0bjiFW6jk
         0RIygio1pSIJurpoxdoyl5OcLfxS0H4S2wATekKCMiPto9ksnxYwUx2Pboygrxp9lhQz
         iruw==
X-Gm-Message-State: ABy/qLbv2Mj3Emjkqv4ybwBnZp0Qdhh+UVD7M6TqifJmc8FsJTMluDrT
        u1u8qM0zN/qH+Gm1KNekivXqH8ARLL0=
X-Google-Smtp-Source: APBJJlH96WkeOuqF0lr9jikNmEIJLpGKCJfNaoB1ON4ZeustBd39YLNr9WURKYvxNyFg73yTWuDFTIt48Hc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:e090:0:b0:c42:2b05:17aa with SMTP id
 x138-20020a25e090000000b00c422b0517aamr8586ybg.6.1688139073025; Fri, 30 Jun
 2023 08:31:13 -0700 (PDT)
Date:   Fri, 30 Jun 2023 08:31:11 -0700
In-Reply-To: <ZJ6L4oWE9refbXnX@chao-email>
Mime-Version: 1.0
References: <20230217231022.816138-1-seanjc@google.com> <20230217231022.816138-2-seanjc@google.com>
 <ZJ6L4oWE9refbXnX@chao-email>
Message-ID: <ZJ71P+i4aRg3S5TL@google.com>
Subject: Re: [PATCH 01/12] KVM: x86: Add a framework for enabling KVM-governed
 x86 features
From:   Sean Christopherson <seanjc@google.com>
To:     Chao Gao <chao.gao@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 30, 2023, Chao Gao wrote:
> On Fri, Feb 17, 2023 at 03:10:11PM -0800, Sean Christopherson wrote:
> >+static __always_inline void kvm_governed_feature_set(struct kvm_vcpu *vcpu,
> >+						     unsigned int x86_feature)
> >+{
> >+	BUILD_BUG_ON(KVM_NR_GOVERNED_FEATURES >
> >+		     sizeof(vcpu->arch.governed_features.enabled) * BITS_PER_BYTE);
> >+
> >+	vcpu->arch.governed_features.enabled |= kvm_governed_feature_bit(x86_feature);
> >+}
> >+
> >+static __always_inline void kvm_governed_feature_check_and_set(struct kvm_vcpu *vcpu,
> >+							       unsigned int x86_feature)
> >+{
> >+	if (guest_cpuid_has(vcpu, x86_feature))
> 
> Most callers in this series are conditional on either boot_cpu_has() or some
> local variables. Can we convert them to kvm_cpu_cap_has() and incorporate them
> within this function? i.e.,
> 
> 	if (kvm_cpu_cap_has(x86_feature) && guest_cpuid_has(vcpu, x86_feature))

Hmm, I was going to say "no", as most callers don't check kvm_cpu_cap_has() verbatim,
but it doesn't have to be that way.   The majority of SVM features factor in module
params, but KVM should set the kvm_cpu capability if and only if a feature is supported
in hardware *and* enabled by its module param.

And arguably that's kinda sorta a bug fix, because this

	if (lbrv)
		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_LBRV);

technically should be 

	if (lbrv && nested)
		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_LBRV);	

Heh, and it's kinda sorta a bug fix for XSAVES on VMX, because this

	if (cpu_has_vmx_xsaves() && boot_cpu_has(X86_FEATURE_XSAVE) &&
	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_XSAVES);

should technically be

	if (kvm_cpu_cap_has(X86_FEATURE_XSAVES) &&
	    boot_cpu_has(X86_FEATURE_XSAVE) &&
	    guest_cpuid_has(vcpu, X86_FEATURE_XSAVE))
		kvm_governed_feature_check_and_set(vcpu, X86_FEATURE_XSAVES);

> The benefits of doing so are
> 1. callers needn't repeat
> 
> 	if (kvm_cpu_cap_has(x86_feature))
> 		kvm_governed_feature_check_and_set(x86_feature)
> 
> 2. this fits the idea better that guests can use a governed feature only if host
>    supports it _and_ QEMU exposes it to the guest.

Agreed, especially since we'll still have kvm_governed_feature_set() for the
extra special cases.

Thanks for the input!
