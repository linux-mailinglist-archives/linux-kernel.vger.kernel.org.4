Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88DED640CDB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 19:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbiLBSMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 13:12:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiLBSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 13:12:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA26BECE7B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 10:11:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670004667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeeaXrmiSXAz7yiwwsn7OAqyBFbYdfVCZ2HcYBmojMY=;
        b=cR2GHvhzqVbCQZfm730IvG11gRVhWF3ms/yZTYYzjXz9rBmYFpEMHiS4VevfIYHkN/bHXL
        ln8hCo6zY/0wHJE4F4z57x/00SOXVJ95+6aBkeixdL/T/JOjs/KZMI5Qu/MaKHhhTvhktV
        GVPqOEdb6n0faJepbkWJfBEDUFoBweg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-470-Qql5lt-VPHqFTMRXo9KBXw-1; Fri, 02 Dec 2022 13:11:04 -0500
X-MC-Unique: Qql5lt-VPHqFTMRXo9KBXw-1
Received: by mail-wm1-f70.google.com with SMTP id h4-20020a1c2104000000b003d01b66fe65so4487018wmh.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 10:11:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XeeaXrmiSXAz7yiwwsn7OAqyBFbYdfVCZ2HcYBmojMY=;
        b=Tcb4tvRsDtYRmDO9FmL6mt1A+62Yqj/w/YORy8Sc/VN2aSmTpCIGA445RpYGawKXql
         8aacji0UZPfy7dIptj7jehTtDPxDcbVHFTzYpxhyamsMbnHXx5BxO75taV64Fljb0Neb
         Q99DXz4PS0Y9vhDM4J+V7dPXpW39srIBW5DJh4BxTMZJVgFm4fstjwikqZa0owY4O1gm
         ypzi6N23Xryhyb6Ztt7aEWyWQiP80BxpsN4GgG9wz4BoPOaB7mBd7MZtCpJBj6/vzE2U
         zaFxMMQQO7FFugVNGDsYR7qxhKq8wz3F//oqbCPrb57QYHWEx/ltYvwFRqEvQImWFYAm
         nTKQ==
X-Gm-Message-State: ANoB5pl7GpC3Q3oALasDVynyDhY5wlfaegImTWZosj4R4wTB8ANgb6ho
        We02R2n3YU4VXCpi49GRZ44cuRIjsECWDVxO6JZpCUpURd3K61mKctGl7/d+ebEPHaeOc5WeLXs
        stTrTKmzt3ukqhYIi3lXktGI9
X-Received: by 2002:adf:fc48:0:b0:236:e0d:9ad with SMTP id e8-20020adffc48000000b002360e0d09admr34642322wrs.692.1670004662303;
        Fri, 02 Dec 2022 10:11:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4xWcTwPRLiOiZsUXz8fZzsv2cqll2GO9uYls5i+J9Nl6ucOPyDDmBw9oVRGcoRF6b305NMrw==
X-Received: by 2002:adf:fc48:0:b0:236:e0d:9ad with SMTP id e8-20020adffc48000000b002360e0d09admr34642303wrs.692.1670004662050;
        Fri, 02 Dec 2022 10:11:02 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm16843406wmo.0.2022.12.02.10.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 10:11:00 -0800 (PST)
Message-ID: <fe8c3a38-5d91-aed3-1e7d-6923aa157e79@redhat.com>
Date:   Fri, 2 Dec 2022 19:10:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] KVM: x86: fix APICv/x2AVIC disabled when vm reboot by
 itself
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mlevitsk@redhat.com,
        x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1669984574-32692-1-git-send-email-yuanzhaoxiong@baidu.com>
 <Y4oeh6XWw2qzETEQ@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y4oeh6XWw2qzETEQ@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/22 16:49, Sean Christopherson wrote:
> On Fri, Dec 02, 2022, Yuan ZhaoXiong wrote:
>> This patch fixes that VM rebooting itself will cause APICv
>> disabled when VM is started with APICv/x2AVIC enabled.
>>
>> When a VM reboot itself, The Qemu whill reset LAPIC by invoking
>> ioctl(KVM_SET_LAPIC, ...) to disable x2APIC mode and set APIC_ID
>> to its vcpuid in xAPIC mode.
>>
>> That will be handled in KVM as follows:
>>
>>       kvm_vcpu_ioctl_set_lapic
>>         kvm_apic_set_state
>> 	  kvm_lapic_set_base  =>  disable X2APIC mode
>> 	    kvm_apic_state_fixup
>> 	      kvm_lapic_xapic_id_updated
>> 	        kvm_xapic_id(apic) != apic->vcpu->vcpu_id
>> 		kvm_set_apicv_inhibit(APICV_INHIBIT_REASON_APIC_ID_MODIFIED)
>> 	   memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s))  => update APIC_ID
>>
>> kvm_apic_set_state invokes kvm_lapic_set_base to disable x2APIC mode
>> firstly, but don't change APIC_ID, APIC_ID is 32 bits in x2APIC mode
>> and 8 bist(bit 24 ~ bit 31) in xAPIC mode. So kvm_lapic_xapic_id_updated
>> will set APICV_INHIBIT_REASON_APIC_ID_MODIFIED bit inhibit and disable
>> APICv/x2AVIC.
>>
>> kvm_lapic_xapic_id_updated must be called after APIC_ID is changed.
>>
>> Fixes: 3743c2f02517 ("KVM: x86: inhibit APICv/AVIC on changes to APIC ID or APIC base")
>>
>> Signed-off-by: Yuan ZhaoXiong <yuanzhaoxiong@baidu.com>
>> ---
>>   arch/x86/kvm/lapic.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>> index d7639d1..bf5ce86 100644
>> --- a/arch/x86/kvm/lapic.c
>> +++ b/arch/x86/kvm/lapic.c
>> @@ -2722,8 +2722,6 @@ static int kvm_apic_state_fixup(struct kvm_vcpu *vcpu,
>>   			icr = __kvm_lapic_get_reg64(s->regs, APIC_ICR);
>>   			__kvm_lapic_set_reg(s->regs, APIC_ICR2, icr >> 32);
>>   		}
>> -	} else {
>> -		kvm_lapic_xapic_id_updated(vcpu->arch.apic);
>>   	}
>>   
>>   	return 0;
>> @@ -2759,6 +2757,9 @@ int kvm_apic_set_state(struct kvm_vcpu *vcpu, struct kvm_lapic_state *s)
>>   	}
>>   	memcpy(vcpu->arch.apic->regs, s->regs, sizeof(*s));
>>   
>> +	if (!apic_x2apic_mode(apic))
>> +		kvm_lapic_xapic_id_updated(apic);
>> +
> 
> Already posted[*], along with a pile of other APIC fixes.  Hopefully it will land
> in 6.2.

I'll let this patch overtake the others since it is stable@ material.

I'll also volunteer someone to write a testcase (we can add an 
apicv_enabled boolean statistic too for the sake of the test).

Paolo

> [*] https://lore.kernel.org/all/20221001005915.2041642-7-seanjc@google.com

