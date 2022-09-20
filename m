Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87CCF5BF092
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiITWxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiITWw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:52:59 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C86AA71BD2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:52:57 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so12325260pjk.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oq3iuYqgpVztglY7H/NFsHDhvYDb/9kInx41v+sCUYo=;
        b=TkcBPM4T6KPghdH6FXzD+gnd3xzgIIgXHLbx3JCrzl7bSBgzPXNoOqNEA3VqRKkwbc
         m/6/lmQ7AzVMA5hzx/4/MSYmc1xwU6qGE3PltYGdF4ZCy70rAfLPV69ysEo0YtEK5qua
         I/CB7fY5z4Eu2SaU2TQL5y3d+TobopeELw0pLGbEYTK7NxEWVw2K/uKaKWFwGgwb14no
         KqgKg7mgdWW0RDYK03mNz2ppfJM5iASv+IYzhqcpJm/Rmdr7qaJewRWIQa4Dl2CSC96o
         EjpRxK6dWK46cxcMmCeRQxgXCMieB+337c0Xnz8BFfVp+srnP1Iu49SekUTLshfXW/g1
         1X3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oq3iuYqgpVztglY7H/NFsHDhvYDb/9kInx41v+sCUYo=;
        b=1cKANsVcM+spCImLepIqpBvD654ts2A6T158pbG56BUhlN4IPAKfwKmzdiCzMDvTEw
         kGWtysLDtY0oeiSeflU72LXJQreEscfxG6JJcdIoFV3nk0/vNIwIB4S2rkKxsuZ3w9xZ
         qQy9oXNnetw44/ZKrx6hrxMcrgafJaD4BRsdRByHb5EhSxJLEyfxafWL5bF9h3Pzpeeh
         0DEoqVDMPP2VFVMbOK9bzzbOBRLOvd1Jv+ZuX71K6sy094cIixL6moEDCbVlynnlxx49
         sZP7yIcoS/QOtI82VAdVesir6YQ5PLxck/CBSH+rYP6BrY3ivzYR97pfULSjRi6nP/Rh
         UpEA==
X-Gm-Message-State: ACrzQf2ozivTMKX6dn1DorEpZ7NIH9lR4Iac6+vxBV0H4eOFib0Pu4Zy
        pLxbjpp+3iV0tZUfkWLOHi3cew==
X-Google-Smtp-Source: AMsMyM5gkpKq6OvOszMaHIpqHSNccl7/7urVrT0Gij2fXPU9+iu3UyR3X+REdjCc9Z/UvK+KtvuVOQ==
X-Received: by 2002:a17:90a:1b6e:b0:1f5:1902:af92 with SMTP id q101-20020a17090a1b6e00b001f51902af92mr6307754pjq.238.1663714377221;
        Tue, 20 Sep 2022 15:52:57 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e11-20020a17090301cb00b00176c431e7e2sm469518plh.13.2022.09.20.15.52.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 15:52:56 -0700 (PDT)
Date:   Tue, 20 Sep 2022 22:52:53 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] KVM: x86: Introduce CPUID_8000_0007_EDX
 'scattered' leaf
Message-ID: <YypEReJYrI0c7Oii@google.com>
References: <20220916135205.3185973-1-vkuznets@redhat.com>
 <20220916135205.3185973-3-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916135205.3185973-3-vkuznets@redhat.com>
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

On Fri, Sep 16, 2022, Vitaly Kuznetsov wrote:
> CPUID_8000_0007_EDX may come handy when X86_FEATURE_CONSTANT_TSC
> needs to be checked.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/cpuid.c         | 4 ++++
>  arch/x86/kvm/reverse_cpuid.h | 9 ++++++++-
>  2 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 75dcf7a72605..f68b14053c9b 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -669,6 +669,10 @@ void kvm_set_cpu_caps(void)
>  	if (!tdp_enabled && IS_ENABLED(CONFIG_X86_64))
>  		kvm_cpu_cap_set(X86_FEATURE_GBPAGES);
>  
> +	kvm_cpu_cap_init_scattered(CPUID_8000_0007_EDX,
> +		SF(CONSTANT_TSC)
> +	);

The scattered leaf needs to be used in __do_cpuid_func(), e.g.

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index ffdc28684cb7..c91f23bb3605 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -1137,8 +1137,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
                /* L2 cache and TLB: pass through host info. */
                break;
        case 0x80000007: /* Advanced power management */
-               /* invariant TSC is CPUID.80000007H:EDX[8] */
-               entry->edx &= (1 << 8);
+               cpuid_entry_override(entry, CPUID_8000_0007_EDX);
+
                /* mask against host */
                entry->edx &= boot_cpu_data.x86_power;
                entry->eax = entry->ebx = entry->ecx = 0;
