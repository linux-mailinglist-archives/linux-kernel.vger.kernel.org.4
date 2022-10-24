Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49F7609BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJXHos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJXHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:44:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10607625E8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666597401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZIv2r2dWkEokiNFPkjqlVbo9H7afruyUMoFYLJNwyjU=;
        b=XL+oh7/rsSmgOR6Iq4EfIB9RHCGxTEYE+crzBlE8pl282JUuLmw2hzDEPGnlAA/kDixll2
        CXSzSnaV4NVZRI4ZFPRvy7S9XkwnX3aoookvXeu6aEnjd4yeXnAFFAOR5M0EN2zqmLVtTN
        zvRnn9BoywLXbXhHP2xBIyOTKCnZXpw=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-178-RiSF1n9VPoO6toG_9AOdlw-1; Mon, 24 Oct 2022 03:43:11 -0400
X-MC-Unique: RiSF1n9VPoO6toG_9AOdlw-1
Received: by mail-qt1-f197.google.com with SMTP id bz12-20020a05622a1e8c00b0039ae6e887ffso6614382qtb.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZIv2r2dWkEokiNFPkjqlVbo9H7afruyUMoFYLJNwyjU=;
        b=oK700Swvh8U2m7xuhvbFrwZiDPXc4WXDtWe3EkezHXxcJtCWkC0gBdfndyocbTJ25E
         OzgTB82dpMrrH/650i5r/kFN1mjiSYAtrVWCDLoaznZ41ART/pZ2n6enh8AQE7e3NGBg
         gm3qHIlh53FGyZabT1xaYsrpM8nMqWzsYXXzFvP1Fm//Lz+PJoZ1mUEdLCHsHarmoWZ7
         JXaYZSpd36vOQ5p4bxLsBy204QOmBpnbZOb4NPmh203YaoQRWALDCVf9+xvyLUGMUB0o
         vhhzbxBqc54Uo6D+FBeL/GesMGbqPuOQxOvMj/xJ2ZaAyX9ITUhVa7cqWdufeEDpZhMX
         7I8Q==
X-Gm-Message-State: ACrzQf3iDktaHfFcGq1yU1ZbBGA/+o/50+P+5mGcXHPL9K8GJ1yyrQ+W
        NtFGGNc4fcLSbfWJveLDwNTz5yxE15KWOgBIwNr8CJ5K2ieEdjkVYD8XjU9xQyRkqtUPTatsh5p
        LxYCECNjNOeVvHyDMWK/kszyS
X-Received: by 2002:a05:620a:22aa:b0:6ef:a22:f164 with SMTP id p10-20020a05620a22aa00b006ef0a22f164mr14256275qkh.697.1666597390492;
        Mon, 24 Oct 2022 00:43:10 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM56ffpk5LHX1u7kc6YRwKSsol+j2ZCZ1+6tHhrTU4K+2HzRICzk+0ehzcxld8f1R1vpFng9YA==
X-Received: by 2002:a05:620a:22aa:b0:6ef:a22:f164 with SMTP id p10-20020a05620a22aa00b006ef0a22f164mr14256262qkh.697.1666597390198;
        Mon, 24 Oct 2022 00:43:10 -0700 (PDT)
Received: from [192.168.149.123] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id h6-20020ac85846000000b0039a9b55b829sm12647888qth.29.2022.10.24.00.43.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 00:43:09 -0700 (PDT)
Message-ID: <4ef882c2-1535-d7df-d474-e5fab2975f53@redhat.com>
Date:   Mon, 24 Oct 2022 09:43:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] KVM: use signals to abort enter_guest/blocking and
 retry
Content-Language: en-US
To:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221022154819.1823133-1-eesposit@redhat.com>
 <20221022154819.1823133-5-eesposit@redhat.com>
 <5ee4eeb8-4d61-06fc-f80d-06efeeffe902@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <5ee4eeb8-4d61-06fc-f80d-06efeeffe902@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 23/10/2022 um 19:48 schrieb Paolo Bonzini:
> On 10/22/22 17:48, Emanuele Giuseppe Esposito wrote:
>> Once a vcpu exectues KVM_RUN, it could enter two states:
>> enter guest mode, or block/halt.
>> Use a signal to allow a vcpu to exit the guest state or unblock,
>> so that it can exit KVM_RUN and release the read semaphore,
>> allowing a pending KVM_KICK_ALL_RUNNING_VCPUS to continue.
>>
>> Note that the signal is not deleted and used to propagate the
>> exit reason till vcpu_run(). It will be clearead only by
>> KVM_RESUME_ALL_KICKED_VCPUS. This allows the vcpu to keep try
>> entering KVM_RUN and perform again all checks done in
>> kvm_arch_vcpu_ioctl_run() before entering the guest state,
>> where it will return again if the request is still set.
>>
>> However, the userspace hypervisor should also try to avoid
>> continuously calling KVM_RUN after invoking KVM_KICK_ALL_RUNNING_VCPUS,
>> because such call will just translate in a back-to-back down_read()
>> and up_read() (thanks to the signal).
> 
> Since the userspace should anyway avoid going into this effectively-busy
> wait, what about clearing the request after the first exit?  The
> cancellation ioctl can be kept for vCPUs that are never entered after
> KVM_KICK_ALL_RUNNING_VCPUS.  Alternatively, kvm_clear_all_cpus_request
> could be done right before up_write().

Clearing makes sense, but should we "trust" the userspace not to go into
busy wait?
What's the typical "contract" between KVM and the userspace? Meaning,
should we cover the basic usage mistakes like forgetting to busy wait on
KVM_RUN?

If we don't, I can add a comment when clearing and of course also
mention it in the API documentation (that I forgot to update, sorry :D)

Emanuele

> 
> Paolo
> 
>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>> ---
>>   arch/x86/include/asm/kvm_host.h |  2 ++
>>   arch/x86/kvm/x86.c              |  8 ++++++++
>>   virt/kvm/kvm_main.c             | 21 +++++++++++++++++++++
>>   3 files changed, 31 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/kvm_host.h
>> b/arch/x86/include/asm/kvm_host.h
>> index aa381ab69a19..d5c37f344d65 100644
>> --- a/arch/x86/include/asm/kvm_host.h
>> +++ b/arch/x86/include/asm/kvm_host.h
>> @@ -108,6 +108,8 @@
>>       KVM_ARCH_REQ_FLAGS(30, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>>   #define KVM_REQ_MMU_FREE_OBSOLETE_ROOTS \
>>       KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>> +#define KVM_REQ_USERSPACE_KICK        \
>> +    KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT)
>>     #define
>> CR0_RESERVED_BITS                                               \
>>       (~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM |
>> X86_CR0_TS \
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index b0c47b41c264..2af5f427b4e9 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -10270,6 +10270,10 @@ static int vcpu_enter_guest(struct kvm_vcpu
>> *vcpu)
>>       }
>>         if (kvm_request_pending(vcpu)) {
>> +        if (kvm_test_request(KVM_REQ_USERSPACE_KICK, vcpu)) {
>> +            r = -EINTR;
>> +            goto out;
>> +        }
>>           if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu)) {
>>               r = -EIO;
>>               goto out;
>> @@ -10701,6 +10705,10 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>>               r = vcpu_block(vcpu);
>>           }
>>   +        /* vcpu exited guest/unblocked because of this request */
>> +        if (kvm_test_request(KVM_REQ_USERSPACE_KICK, vcpu))
>> +            return -EINTR;
>> +
>>           if (r <= 0)
>>               break;
>>   diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>> index ae0240928a4a..13fa7229b85d 100644
>> --- a/virt/kvm/kvm_main.c
>> +++ b/virt/kvm/kvm_main.c
>> @@ -3431,6 +3431,8 @@ static int kvm_vcpu_check_block(struct kvm_vcpu
>> *vcpu)
>>           goto out;
>>       if (kvm_check_request(KVM_REQ_UNBLOCK, vcpu))
>>           goto out;
>> +    if (kvm_test_request(KVM_REQ_USERSPACE_KICK, vcpu))
>> +        goto out;
>>         ret = 0;
>>   out:
>> @@ -4668,6 +4670,25 @@ static long kvm_vm_ioctl(struct file *filp,
>>           r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
>>           break;
>>       }
>> +    case KVM_KICK_ALL_RUNNING_VCPUS: {
>> +        /*
>> +         * Notify all running vcpus that they have to stop.
>> +         * Caught in kvm_arch_vcpu_ioctl_run()
>> +         */
>> +        kvm_make_all_cpus_request(kvm, KVM_REQ_USERSPACE_KICK);
>> +
>> +        /*
>> +         * Use wr semaphore to wait for all vcpus to exit from KVM_RUN.
>> +         */
>> +        down_write(&memory_transaction);
>> +        up_write(&memory_transaction);
>> +        break;
>> +    }
>> +    case KVM_RESUME_ALL_KICKED_VCPUS: {
>> +        /* Remove all requests sent with KVM_KICK_ALL_RUNNING_VCPUS */
>> +        kvm_clear_all_cpus_request(kvm, KVM_REQ_USERSPACE_KICK);
>> +        break;
>> +    }
>>       case KVM_SET_USER_MEMORY_REGION: {
>>           struct kvm_userspace_memory_region kvm_userspace_mem;
>>   
> 

