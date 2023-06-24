Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5942473C502
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 02:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjFXAFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 20:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjFXAFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 20:05:21 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28553270D
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 17:05:20 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1b5465a79edso6768595ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 17:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687565119; x=1690157119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=fTKCQ/W5lVHaI7N9DQEKJ7vpWP7e4fiX4kXItMVpXQU=;
        b=ASBiI5GfRMguQVkLO1qZk2ej2s9SQtUeBGfzEoWsuWFCzhrw/DcTn13fMfNp6AXxD9
         xuDs5Xi07+bzHrGVVRbc+HzFAfbPM8inuY5dFMOGI5Kzbr5KiApCYpZw+j0j3Y/LMCVD
         DIurHVGXjdj/3yjPIk5AE1Zyz22ckKBD8PQTrJLUSxKhfKUg3dOfAtJli9s0WuEtn4Z8
         9ciJt3USsvGDO+tYMTZRWshLNBWX47VHNRqkeK6X6qo6FQnwaCzour1y4RV9siRWVlZJ
         1zJOkNkWgC9EmH+WxI5G6dJv9WrTMEXpUS7c8CKzoNVoH+cDtm4MStM211PBWwU195Am
         slqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687565119; x=1690157119;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fTKCQ/W5lVHaI7N9DQEKJ7vpWP7e4fiX4kXItMVpXQU=;
        b=bilghN+Yc3sWvzTc5340BSB9vsgMpPxfbUDdCoI36/zl/H51gODJtkb3oqBd7vSfse
         BTMQe2aBsAKK2pFP3FDlKcrnR3H8XPDDW1l2awFcjtwXY7Ut7L0oq+J+mgUrsFU5eYbS
         GDr7VGQ+HMNsEyz1Ov8VlosaJApyy+neA5oNs+NAomOZdCpUSD0191/yewnpfahX1eVl
         yTxOM6KdOUmAHRMXbrbhij6paODx4edCt8Sej8S9AsSMfDlqUY0QRVz/BqJCJnMngAzh
         B1TaHXImxx9qWSxJjzBW6znU3Kk6wPT5Avv4l/67odlC1sBHXi/id2HPQDtWc8qQt8ld
         8fUQ==
X-Gm-Message-State: AC+VfDz+T9A8FshHVhMR8BhOFymU3S+mqP8fgnQlwv0pSpsILyRZ8Kkl
        +Bg/I7/N1PW/FB6glQVsJYpc3Fro3yo=
X-Google-Smtp-Source: ACHHUZ7ozb6IgTbNB0N4jZYNLNG+86NgUEkUab9mtPS09w81Csj0isBdAdkRhwWGLIWO1igIMu6x6UdVP2M=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:903:328d:b0:1b1:8e8b:7f5e with SMTP id
 jh13-20020a170903328d00b001b18e8b7f5emr115914plb.5.1687565119614; Fri, 23 Jun
 2023 17:05:19 -0700 (PDT)
Date:   Fri, 23 Jun 2023 17:05:18 -0700
In-Reply-To: <20230524155339.415820-4-john.allen@amd.com>
Mime-Version: 1.0
References: <20230524155339.415820-1-john.allen@amd.com> <20230524155339.415820-4-john.allen@amd.com>
Message-ID: <ZJYzPn7ipYfO0fLZ@google.com>
Subject: Re: [RFC PATCH v2 3/6] KVM: x86: SVM: Pass through shadow stack MSRs
From:   Sean Christopherson <seanjc@google.com>
To:     John Allen <john.allen@amd.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, weijiang.yang@intel.com,
        rick.p.edgecombe@intel.com, x86@kernel.org,
        thomas.lendacky@amd.com, bp@alien8.de
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023, John Allen wrote:
> If kvm supports shadow stack, pass through shadow stack MSRs to improve
> guest performance.
> 
> Signed-off-by: John Allen <john.allen@amd.com>
> ---
>  arch/x86/kvm/svm/svm.c | 17 +++++++++++++++++
>  arch/x86/kvm/svm/svm.h |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 6df486bb1ac4..cdbce20989b8 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -136,6 +136,13 @@ static const struct svm_direct_access_msrs {
>  	{ .index = X2APIC_MSR(APIC_TMICT),		.always = false },
>  	{ .index = X2APIC_MSR(APIC_TMCCT),		.always = false },
>  	{ .index = X2APIC_MSR(APIC_TDCR),		.always = false },
> +	{ .index = MSR_IA32_U_CET,                      .always = false },
> +	{ .index = MSR_IA32_S_CET,                      .always = false },
> +	{ .index = MSR_IA32_INT_SSP_TAB,                .always = false },
> +	{ .index = MSR_IA32_PL0_SSP,                    .always = false },
> +	{ .index = MSR_IA32_PL1_SSP,                    .always = false },
> +	{ .index = MSR_IA32_PL2_SSP,                    .always = false },
> +	{ .index = MSR_IA32_PL3_SSP,                    .always = false },
>  	{ .index = MSR_INVALID,				.always = false },
>  };
>  
> @@ -1181,6 +1188,16 @@ static inline void init_vmcb_after_set_cpuid(struct kvm_vcpu *vcpu)
>  		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_EIP, 1, 1);
>  		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_SYSENTER_ESP, 1, 1);
>  	}
> +
> +	if (kvm_cet_user_supported() && guest_cpuid_has(vcpu, X86_FEATURE_SHSTK)) {
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_U_CET, 1, 1);
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_S_CET, 1, 1);
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_INT_SSP_TAB, 1, 1);
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_PL0_SSP, 1, 1);
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_PL1_SSP, 1, 1);
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_PL2_SSP, 1, 1);
> +		set_msr_interception(vcpu, svm->msrpm, MSR_IA32_PL3_SSP, 1, 1);
> +	}

This is wrong, KVM needs to set/clear interception based on SHSKT, i.e. it can't
be a one-way street.  Userspace *probably* won't toggle SHSTK in guest CPUID, but
weirder things have happened.
