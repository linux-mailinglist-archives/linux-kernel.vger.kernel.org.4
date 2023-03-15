Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31F2C6BBDD3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 21:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCOUQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjCOUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 16:16:24 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2957D1C59B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:16:23 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id bx9-20020a056a00428900b005f077bc6e5eso10640300pfb.16
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678911382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+bS/HSfiAIHzE1BljlnDMwqBXmxYFJcJWZOF0Wd5Po=;
        b=NQSaosRVx7/zJnHPOvPspt/DVRn9KA0UI4unMES9kdaXIokpuLeqGmrxs1+XmvSbIO
         5e0srJHpzbwz/51km5OPbT/IpYUqBxUHPJHiUgKVgAEtfRSw26SkQVLdnbkdJS7DOr7b
         X+tmzMkiSr0hIJhUBQSWSnGaErb5V3FLxZeL+g+LxXN/QmlSSiBNBsal3e0dk9s4XhfV
         qXYN074HQtUTLJrsu5SbxnQUg+lnA8lWDygSMNJCyU9MlvDQX529VJX2/LGClol3tD3j
         3ZyuBXUjirYTayjDZg6HdTg3OTYcFx0xzKu5mAL19sKIzS+L/LqeXcnQ3IlwPW8yrPnf
         BU1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678911382;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R+bS/HSfiAIHzE1BljlnDMwqBXmxYFJcJWZOF0Wd5Po=;
        b=U2KQrvWNUBdp2tsdQ59h7k7VoLNld/F7N2iKUq4CGMBIXtiBdU5wI6e3HRak/1AEfd
         ZGJTG2xYpwLP2ZeIQgZCiZ//fZL7AsTpQx3hejNqPkpORDV1xLbsrFVy+63yZQGDZ9OL
         GP4GKTxqfmkTNKUJ36kyzldfR9P87K7Mq1M92gJBpTEftp+ZZ9scgEBjgEK4dkiP5Qw6
         YefzlzezhgoR9v74kdRXB1nGO6WRRk37NdYbWB/cSnv0CM2iJVmEdgJ6OTtCn9dTa5yV
         aDIqxU9sP2u5FDfmzhte0PvrPyrKtsLrXf+SHRfKtlex2HGcxBwTkSggBwNy0nrP7SPs
         LStg==
X-Gm-Message-State: AO0yUKWIY1HHgz+xYM0+mpVnHT8yRKIUCDrE7oeagj4VfIxJ5fr4O6wH
        wxqa1YaNKIM5hYgMWlaKgZmZE9XNu70=
X-Google-Smtp-Source: AK7set9Irl7M5X5NC/b6sLZ7p9ye1h2toPeT8JP5dVktiq1PORJ5Qojyyw3FCdmadm4BXHbZV4wJJokOQoA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:6386:0:b0:4fb:a38d:c09b with SMTP id
 h6-20020a656386000000b004fba38dc09bmr140169pgv.10.1678911382440; Wed, 15 Mar
 2023 13:16:22 -0700 (PDT)
Date:   Wed, 15 Mar 2023 13:16:20 -0700
In-Reply-To: <20230315195109.580333-1-d-tatianin@yandex-team.ru>
Mime-Version: 1.0
References: <20230315195109.580333-1-d-tatianin@yandex-team.ru>
Message-ID: <ZBInlO18ZlClLbHp@google.com>
Subject: Re: [PATCH] kvm/x86: actually verify that reading MSR_IA32_UCODE_REV succeeds
From:   Sean Christopherson <seanjc@google.com>
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023, Daniil Tatianin wrote:
> ...and return KVM_MSR_RET_INVALID otherwise.
> 
> Found by Linux Verification Center (linuxtesting.org) with the SVACE
> static analysis tool.
> 
> Fixes: cd28325249a1 ("KVM: VMX: support MSR_IA32_ARCH_CAPABILITIES as a feature MSR")
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  arch/x86/kvm/x86.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7713420abab0..7de6939fc371 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1661,7 +1661,8 @@ static int kvm_get_msr_feature(struct kvm_msr_entry *msr)
>  		msr->data = kvm_caps.supported_perf_cap;
>  		break;
>  	case MSR_IA32_UCODE_REV:
> -		rdmsrl_safe(msr->index, &msr->data);
> +		if (rdmsrl_safe(msr->index, &msr->data))
> +			return KVM_MSR_RET_INVALID;

This is unnecessary and would arguably break KVM's ABI.  KVM unconditionally emulates
MSR_IA32_UCODE_REV in software and rdmsrl_safe() zeros the result on a fault (see
ex_handler_msr()).  '0' is a legitimate ucode revid and a reasonable fallback for
a theoretical (virtual) CPU that doesn't support the MSR.
