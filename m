Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E93C6C518B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 18:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbjCVRCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 13:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjCVRCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 13:02:18 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A084A6286D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:01:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 204-20020a250fd5000000b00b6d6655dc35so8719101ybp.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 10:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679504510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=s9gzetiVSIK/b5GBetbQBksIHa7p5BijP3hFfPNKXms=;
        b=Al3jQT1pbMzzIZbKoN8OZdIupF5HhqP89XVt2n2qjqvb45noH7XxCa63uS5DWIpOwZ
         el9n33kOksVZgSZ84rFZDSrLP4rZtYUYDygTRv74raVlug4krGW0fxk3/i0QDN1nGNZu
         TzZ/lIbSSCBgE0hGiwk0eyoYSRedWyItE99JvN/8MaxBlhPc2kh7RZBVmbzmBqVuA8n9
         IBZaTktoZaMJBDuvF5/l64wWqdzyTIfqO4Vvta76iaK7ROtqWUFmxYPXxI5NxNapu9HA
         12nCz0zKBitNg44jqwgzljSqRScF5jN4xBRm4jViV9ul+wMO7YLJWuciCYlK2m9CPdlB
         eVDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679504510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9gzetiVSIK/b5GBetbQBksIHa7p5BijP3hFfPNKXms=;
        b=DYfOBg8fcuUP8QQqveY7xa/SVhpd5IPN6f2id1uQX7k6YFXKPVhJKUTPWZxFgwsFus
         SbAHgX7UGRMgrDb4Kepx2XhYND34spkvLIF9OaOHHmn/dzscSYzgAOSoBcSNvcLMpreZ
         eSo1vuBtg6JXfB2v1EUeo9BYDMg5hRWJ2faM2x0R3FllUlXv7n7MlKYq5OViWIbEKWmN
         zD3E8AgiwbIDvJH6OLP3g3O8BHjEZrWZhooF6VeA6ocDeTSGxZ66VyZzaFAk9UF2ISrl
         e24TZyWOpZ5Vzu+ERV71vG9mClzYQT8JcsdctFCVVN5poHJ4tyx8rMcVkMlj7kIPwGdZ
         XoRg==
X-Gm-Message-State: AAQBX9ciwjvXDX/m3h0pqoXXf5nfF1s9BDhai3FwKEyU22ahOnrwmkrO
        8SWVTMOrGrucos6WrvXriX9mcnRAQFw=
X-Google-Smtp-Source: AKy350YMdTmQIMIKIDHL/AKlkLAf5Ddcwl0S0FaVZ8c/QVo4F35ev6mCmFRqlvQMGAiLU+VSBkNUbTAAFgY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b342:0:b0:52b:fd10:4809 with SMTP id
 r63-20020a81b342000000b0052bfd104809mr360572ywh.0.1679504510754; Wed, 22 Mar
 2023 10:01:50 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:01:49 -0700
In-Reply-To: <87355wralt.fsf@redhat.com>
Mime-Version: 1.0
References: <20230320185110.1346829-1-jpiotrowski@linux.microsoft.com>
 <ZBsqxeRDh+iV8qmm@google.com> <87355wralt.fsf@redhat.com>
Message-ID: <ZBs0fTo72LjnR22r@google.com>
Subject: Re: [PATCH] KVM: SVM: Flush Hyper-V TLB when required
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        kvm@vger.kernel.org, Tianyu Lan <ltykernel@gmail.com>,
        Michael Kelley <mikelley@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023, Vitaly Kuznetsov wrote:
> Sean Christopherson <seanjc@google.com> writes:
> > diff --git a/arch/x86/kvm/svm/svm_onhyperv.h b/arch/x86/kvm/svm/svm_onhyperv.h
> > index cff838f15db5..d91e019fb7da 100644
> > --- a/arch/x86/kvm/svm/svm_onhyperv.h
> > +++ b/arch/x86/kvm/svm/svm_onhyperv.h
> > @@ -15,6 +15,13 @@ static struct kvm_x86_ops svm_x86_ops;
> >  
> >  int svm_hv_enable_l2_tlb_flush(struct kvm_vcpu *vcpu);
> >  
> > +static inline bool svm_hv_is_enlightened_tlb_enabled(struct kvm_vcpu *vcpu)
> > +{
> > +	struct hv_vmcb_enlightenments *hve = &to_svm(vcpu)->vmcb->control.hv_enlightenments;
> > +
> > +	return !!hve->hv_enlightenments_control.enlightened_npt_tlb;
> 
> In theory, we should not look at Hyper-V enlightenments in VMCB control
> just because our kernel has CONFIG_HYPERV enabled.

Oooh, right, because hv_enlightenments uses software reserved bits, and in theory
KVM could be running on a different hypervisor that uses those bits for something
completely different.

> I'd suggest we add a
> real check that we're running on Hyper-V and we can do it the same way
> it is done in svm_hv_hardware_setup()/svm_hv_init_vmcb():
> 
> 	return (ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB)
> 		&& !!hve->hv_enlightenments_control.enlightened_npt_tlb;

Jeremi, if you grab this, can you put the && on the previous line?  I.e.

	return (ms_hyperv.nested_features & HV_X64_NESTED_ENLIGHTENED_TLB) &&
	       !!hve->hv_enlightenments_control.enlightened_npt_tlb;
