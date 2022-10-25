Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5932960D600
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 23:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiJYVJo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 17:09:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbiJYVJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 17:09:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32C6637A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666732179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OZkbw7sg/aJ0UJCgE6qUb1gGcYCrOlLNenpjgWAatcU=;
        b=bQRlVsuTZ2JUocIJtBky4uAsRGoH0J/9QUDj6iq+m5qTG1ZCqowWn9MfLLWup3xxNtq+WE
        Py77YfuF5SphgdFoibPwkYPKIpDw+07JgEu8yQlXAhEXjVr4n7jWvGVy2Gt0D9r7gbgQ9R
        jNumDdqYvTWBPlmaceyMR1FomM/MR3I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-454-SrRv4sa2NsWqIBkNSLYAYQ-1; Tue, 25 Oct 2022 17:09:36 -0400
X-MC-Unique: SrRv4sa2NsWqIBkNSLYAYQ-1
Received: by mail-wm1-f71.google.com with SMTP id z10-20020a05600c220a00b003c6ecad1decso53986wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:09:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OZkbw7sg/aJ0UJCgE6qUb1gGcYCrOlLNenpjgWAatcU=;
        b=tGx3b0LcQCrXPxPgoWrx+OKTpN2HroXWdAFLgBvtB2z52FsZquqcEkYqO8fku4VNBc
         KWrypyR7GPSn9TlnWJsbe2HrkVcC9iTxvljvHFlk7iaLU9lv1izzZJmVOFxvl8tO4xH3
         Juq9RgfPMPPqHw72WBgEJkBo0B3kyeZ1/Jsg9JD8j1WGKR36vG/nKnziEs/PVcRxyJjZ
         xdirtleKDCU3vlXQ4PmT3WquDw89l6O+d4IkedKZdkpDOefKiFxmsUruU03PjORk5uya
         0Ok3nHYiurrmegu/5xGryL0VVS7KzATHOtU8XhLRcr0js/go7dIeNgaG+GZepzpIIJUu
         J8Sg==
X-Gm-Message-State: ACrzQf1AqMcCvTJGkhISwgzV+/c8p1jjqYfRj7ECT5WmIa9gOg3mj91U
        /13CNJNSImCFmZOWAZvLGMLE9K9zkIPNG5vHR2n8l4VAFTNc53VANJTqvRcnoZsQP6SXBkwGqHJ
        8Xcz+2p0Z5bdkI/05bEr9G1b0
X-Received: by 2002:a5d:45ce:0:b0:236:78cb:b6e4 with SMTP id b14-20020a5d45ce000000b0023678cbb6e4mr6418887wrs.225.1666732175759;
        Tue, 25 Oct 2022 14:09:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5JdDmKjtdROswfGRXEAwDsOPBCkb0+SiuA7+g9NUHKEOTuZKIzDmq6NPvDNvhE5SRQiGItHg==
X-Received: by 2002:a5d:45ce:0:b0:236:78cb:b6e4 with SMTP id b14-20020a5d45ce000000b0023678cbb6e4mr6418877wrs.225.1666732175530;
        Tue, 25 Oct 2022 14:09:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:e3ec:5559:7c5c:1928? ([2001:b07:6468:f312:e3ec:5559:7c5c:1928])
        by smtp.googlemail.com with ESMTPSA id s11-20020adfbc0b000000b0022e035a4e93sm3464871wrg.87.2022.10.25.14.09.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 14:09:34 -0700 (PDT)
Message-ID: <e906030e-a77d-468f-2c68-d6c643a768c4@redhat.com>
Date:   Tue, 25 Oct 2022 23:09:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH] KVM: x86: Do not expose the host value of CPUID.8000001EH
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jmattson@google.com
References: <20221022082643.1725875-1-pbonzini@redhat.com>
 <Y1gS6Z/kc+WfUsa3@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Y1gS6Z/kc+WfUsa3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/22 18:46, Sean Christopherson wrote:
> On Sat, Oct 22, 2022, Paolo Bonzini wrote:
>> Several fields of CPUID.8000001EH (ExtendedApicId in EAX[31:0],
>> CoreId in EBX[7:0], NodeId in ECX[7:0]) vary on each processor,
>> and it is simply impossible to fit the right values in the
>> KVM_GET_SUPPORTED_CPUID API, in such a way that they can be
>> passed to KVM_SET_CPUID2.
> 
> The same is true for 0xb and 0x1f, why delete 0x8000001e but keep those? I agree
> that KVM_GET_SUPPORTED_CPUID can't get this right, but KVM can at least be
> consistent with itself.

0xb and 0x1f are already special cased because EDX is set to the X2APIC 
id.  KVM knows how to do that unlike the NodeId and CoreId.

It would indeed be more consistent with 0xb and 0x1f if KVM set EAX to 
the X2APIC id automatically; on the other hand the value of EAX for 
0x8000001eh would not be consistent with EBX and ECX, which I think is 
worse.

>> The most likely way to avoid confusion in the guest is to zero
>> out all the values.  Userspace will most likely override it
>> anyway if it want to present a specific topology to the guest.
>>
>> This patch essentially reverts commit 382409b4c43e ("kvm: x86: Include
>> CPUID leaf 0x8000001e in kvm's supported CPUID").
> 
> Why not do a full revert?

To document the reason why the leaf is hidden; after all it was gotten 
wrong once.

>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>   arch/x86/kvm/cpuid.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
>> index a0292ba650df..380b71600a9e 100644
>> --- a/arch/x86/kvm/cpuid.c
>> +++ b/arch/x86/kvm/cpuid.c
>> @@ -1193,6 +1193,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>>   		entry->ebx = entry->ecx = entry->edx = 0;
>>   		break;
>>   	case 0x8000001e:
>> +		/* Different on each processor, just hide it.  */
>> +		entry->eax = entry->ebx = entry->ecx = 0;
>> +		entry->edx = 0;
> 
> Putting EDX in a separate line is rather weird.

It is, but entry->edx is not different on each processor (it is not 
defined at all, and so it should be zeroed).

Paolo

