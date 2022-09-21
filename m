Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B795BF8DF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiIUIS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiIUISQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:18:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E77087681
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663748278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UB796Vt6XXX5oZ6lyqB/fr2UDx3FHm5YRogO/KgZ0Gc=;
        b=d3t820yXoiqrP34u15TXuopgVgQ0MUYW8PrNqs9QN1ArynxJaBUwiKYy82cpSsVVYbTrpo
        jU7U4JJKqApblC7w93/AkrlDH9ihuhnuImRWQV/l61EsECPwXK8Lpo1wfP+fB+gNpQMLDH
        alFFde6Z2mYWsvQiIYh6Gn/JB+F4+Sc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-515-kPHlno2ONly6Inv9oTGz6Q-1; Wed, 21 Sep 2022 04:17:56 -0400
X-MC-Unique: kPHlno2ONly6Inv9oTGz6Q-1
Received: by mail-wm1-f70.google.com with SMTP id c128-20020a1c3586000000b003b324bb08c5so7552466wma.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=UB796Vt6XXX5oZ6lyqB/fr2UDx3FHm5YRogO/KgZ0Gc=;
        b=OH9yOFRkM0Xjif5GQ+98OL3M1N2MFUU2XH2gkTMLO+Z5wcHqlKGIPVcPsKMHUOLspv
         hFkT3r7QUR8DFaZXI8NWFgCxlWRkhZYbcxCiyb2BZbdXX0zXBgO992PGDZ5wKH/AfzbL
         f4QE5GFMFAi7tlm/kPm7/ljZAKKSScQgXKSY0VgCdKVz1UOjL+Vb+2XnoEKvMbFO69G0
         P5rqDSWvyI/HuFQYccZyMdxU+8rf0r1yVM+iCXBt2LvPLnVsDXay/cWEUXQ7WqxJUhqj
         TcZdhKyNmfw3ujOAWAugAaq9/fI5+n9eLC+YQ1Y9hEo/9+XIXz16qMZzKVT6c8rRV82G
         S3bA==
X-Gm-Message-State: ACrzQf1i/YHxOdLwvqYhv30tiAKlHGxFiIvlYfLEp3Lfy5HUGtqNhWlB
        Nt8fihyrCWIfd76xcUOEkl/P283ZBk66YLPTyWMZ9jiSFlaLYQGCqpJi4KfcbnjhnA/O2etnq4W
        PTGeQaIevbkzUrtfIojZ2JWP/PS6Kvm/cpJBMs78URT56LFeU8L0InhIOJnM4xfdt2TJUADBnU4
        gd
X-Received: by 2002:a5d:4444:0:b0:22a:2a64:a0fd with SMTP id x4-20020a5d4444000000b0022a2a64a0fdmr16661965wrr.293.1663748275663;
        Wed, 21 Sep 2022 01:17:55 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM43v7wWRoXSXV6v4Az3dSj1S/kPw0MIiHrhTuij8Z+2yQa1grcSowSXQ8ZmRtHUuPrI50y4HQ==
X-Received: by 2002:a5d:4444:0:b0:22a:2a64:a0fd with SMTP id x4-20020a5d4444000000b0022a2a64a0fdmr16661948wrr.293.1663748275362;
        Wed, 21 Sep 2022 01:17:55 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id i15-20020adfaacf000000b00228df23bd51sm1767242wrc.82.2022.09.21.01.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 01:17:54 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] KVM: x86: Introduce CPUID_8000_0007_EDX
 'scattered' leaf
In-Reply-To: <YypEReJYrI0c7Oii@google.com>
References: <20220916135205.3185973-1-vkuznets@redhat.com>
 <20220916135205.3185973-3-vkuznets@redhat.com>
 <YypEReJYrI0c7Oii@google.com>
Date:   Wed, 21 Sep 2022 10:17:53 +0200
Message-ID: <8735clp2dq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Fri, Sep 16, 2022, Vitaly Kuznetsov wrote:
>> CPUID_8000_0007_EDX may come handy when X86_FEATURE_CONSTANT_TSC
>> needs to be checked.
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  arch/x86/kvm/cpuid.c         | 4 ++++
>>  arch/x86/kvm/reverse_cpuid.h | 9 ++++++++-
>>  2 files changed, 12 insertions(+), 1 deletion(-)
>> 
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index 75dcf7a72605..f68b14053c9b 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -669,6 +669,10 @@ void kvm_set_cpu_caps(void)
>>  	if (!tdp_enabled && IS_ENABLED(CONFIG_X86_64))
>>  		kvm_cpu_cap_set(X86_FEATURE_GBPAGES);
>>  
>> +	kvm_cpu_cap_init_scattered(CPUID_8000_0007_EDX,
>> +		SF(CONSTANT_TSC)
>> +	);
>
> The scattered leaf needs to be used in __do_cpuid_func(), e.g.
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index ffdc28684cb7..c91f23bb3605 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -1137,8 +1137,8 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>                 /* L2 cache and TLB: pass through host info. */
>                 break;
>         case 0x80000007: /* Advanced power management */
> -               /* invariant TSC is CPUID.80000007H:EDX[8] */
> -               entry->edx &= (1 << 8);
> +               cpuid_entry_override(entry, CPUID_8000_0007_EDX);
> +

Ah, missed that part! Will add.

>                 /* mask against host */
>                 entry->edx &= boot_cpu_data.x86_power;
>                 entry->eax = entry->ebx = entry->ecx = 0;
>

-- 
Vitaly

