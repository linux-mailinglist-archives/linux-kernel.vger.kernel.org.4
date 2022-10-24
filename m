Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37560609BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 09:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiJXHtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 03:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiJXHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 03:49:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A28010B51
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666597781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hTXcuxXaRWJo+QWiUsGFLWlPsijUBF5y61S7CoQKJ+g=;
        b=KpfkA0ERVSr/cSaQJQsWWBWYMLS76bOSYxXaVCfpbnmuMPLUkcPnNe4u9N62lguLofIPH+
        Sgf8L0mA9fO11Khik81RjOW5FbIgXlO95GHC2Q+GMxO3CcE8qzc6H2c/BG+kxxaaKw3GkN
        /8zyWBMUjXYOeSbcYoBO/K3oWDd1zI0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-169-Fs50fhWLPSSmuzl3GOuooQ-1; Mon, 24 Oct 2022 03:49:38 -0400
X-MC-Unique: Fs50fhWLPSSmuzl3GOuooQ-1
Received: by mail-qt1-f200.google.com with SMTP id k9-20020ac85fc9000000b00399e6517f9fso6616662qta.18
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 00:49:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hTXcuxXaRWJo+QWiUsGFLWlPsijUBF5y61S7CoQKJ+g=;
        b=G28KPqewyvH2FOgVoh5KCNSF9TDEv8kHGkQ2zvojSwXh8YX2MPXZCErVXtYKTn8FCq
         k7O9jDKhqNnjVDpiVBEV8bYnZip1hZWgbqTEsmNSUyf+Yw11pyM5IvPLLjbmesQ7YIoZ
         Euo09iBNTjRLu7l+2jOO3TCHhHd3qC41rGWwIhv2n3xgmSpPxrN6XKrVdgcvVXJ5jix+
         DYsD+HStIf326nc4upmj0P5QGQKnzJ2LXNcvIWCUb3/D9MLun7NS+tLbp2NgVLMVem4K
         /Zyqfc0Bz0w2444fZ+/fqAlS2o+RxPgI+QmhqhyVERwcoUWaHIW9lXzxP4ZrFJubkrPw
         IijA==
X-Gm-Message-State: ACrzQf0Os+0IjCfgEi7MHDg4azLJ6KNV/v/7sOhCATMvubyjrJael7NX
        ifRmNCqffK/e2KbkI7nbq5fcnT1a0XdTam/uh5lCPRvLRaicexVeVd1c11N+GOnxZ89mz8Dz5te
        s2Lfxu0zYL7C5vR0bgFEPc6Kz
X-Received: by 2002:a05:622a:4cc:b0:39c:bfb1:8a45 with SMTP id q12-20020a05622a04cc00b0039cbfb18a45mr26104983qtx.647.1666597777847;
        Mon, 24 Oct 2022 00:49:37 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM42uYz07Bby0ZO6+SEobL92Tz9k1kX6G3Tj2qNlGA0BZtOZOgF7K5QRbwlEvLDlM/ObENXC/A==
X-Received: by 2002:a05:622a:4cc:b0:39c:bfb1:8a45 with SMTP id q12-20020a05622a04cc00b0039cbfb18a45mr26104970qtx.647.1666597777593;
        Mon, 24 Oct 2022 00:49:37 -0700 (PDT)
Received: from [192.168.149.123] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id bm2-20020a05620a198200b006ce7d9dea7asm14815613qkb.13.2022.10.24.00.49.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 00:49:36 -0700 (PDT)
Message-ID: <2bd40960-e65e-db2b-ae8f-1109cb9f3fa0@redhat.com>
Date:   Mon, 24 Oct 2022 09:49:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 4/4] KVM: use signals to abort enter_guest/blocking and
 retry
Content-Language: en-US
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
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
 <4ef882c2-1535-d7df-d474-e5fab2975f53@redhat.com>
In-Reply-To: <4ef882c2-1535-d7df-d474-e5fab2975f53@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 24/10/2022 um 09:43 schrieb Emanuele Giuseppe Esposito:
> 
> 
> Am 23/10/2022 um 19:48 schrieb Paolo Bonzini:
>> On 10/22/22 17:48, Emanuele Giuseppe Esposito wrote:
>>> Once a vcpu exectues KVM_RUN, it could enter two states:
>>> enter guest mode, or block/halt.
>>> Use a signal to allow a vcpu to exit the guest state or unblock,
>>> so that it can exit KVM_RUN and release the read semaphore,
>>> allowing a pending KVM_KICK_ALL_RUNNING_VCPUS to continue.
>>>
>>> Note that the signal is not deleted and used to propagate the
>>> exit reason till vcpu_run(). It will be clearead only by
>>> KVM_RESUME_ALL_KICKED_VCPUS. This allows the vcpu to keep try
>>> entering KVM_RUN and perform again all checks done in
>>> kvm_arch_vcpu_ioctl_run() before entering the guest state,
>>> where it will return again if the request is still set.
>>>
>>> However, the userspace hypervisor should also try to avoid
>>> continuously calling KVM_RUN after invoking KVM_KICK_ALL_RUNNING_VCPUS,
>>> because such call will just translate in a back-to-back down_read()
>>> and up_read() (thanks to the signal).
>>
>> Since the userspace should anyway avoid going into this effectively-busy
>> wait, what about clearing the request after the first exit?  The
>> cancellation ioctl can be kept for vCPUs that are never entered after
>> KVM_KICK_ALL_RUNNING_VCPUS.  Alternatively, kvm_clear_all_cpus_request
>> could be done right before up_write().
> 
> Clearing makes sense, but should we "trust" the userspace not to go into
> busy wait?

Actually since this change is just a s/test/check, I would rather keep
test. If userspace does things wrong, this mechanism would still work
properly.

> What's the typical "contract" between KVM and the userspace? Meaning,
> should we cover the basic usage mistakes like forgetting to busy wait on
> KVM_RUN?
> 
> If we don't, I can add a comment when clearing and of course also
> mention it in the API documentation (that I forgot to update, sorry :D)
> 
> Emanuele
> 
>>
>> Paolo
>>
>>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>>> ---
>>>   arch/x86/include/asm/kvm_host.h |  2 ++
>>>   arch/x86/kvm/x86.c              |  8 ++++++++
>>>   virt/kvm/kvm_main.c             | 21 +++++++++++++++++++++
>>>   3 files changed, 31 insertions(+)
>>>
>>> diff --git a/arch/x86/include/asm/kvm_host.h
>>> b/arch/x86/include/asm/kvm_host.h
>>> index aa381ab69a19..d5c37f344d65 100644
>>> --- a/arch/x86/include/asm/kvm_host.h
>>> +++ b/arch/x86/include/asm/kvm_host.h
>>> @@ -108,6 +108,8 @@
>>>       KVM_ARCH_REQ_FLAGS(30, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>>>   #define KVM_REQ_MMU_FREE_OBSOLETE_ROOTS \
>>>       KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
>>> +#define KVM_REQ_USERSPACE_KICK        \
>>> +    KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT)
>>>     #define
>>> CR0_RESERVED_BITS                                               \
>>>       (~(unsigned long)(X86_CR0_PE | X86_CR0_MP | X86_CR0_EM |
>>> X86_CR0_TS \
>>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>>> index b0c47b41c264..2af5f427b4e9 100644
>>> --- a/arch/x86/kvm/x86.c
>>> +++ b/arch/x86/kvm/x86.c
>>> @@ -10270,6 +10270,10 @@ static int vcpu_enter_guest(struct kvm_vcpu
>>> *vcpu)
>>>       }
>>>         if (kvm_request_pending(vcpu)) {
>>> +        if (kvm_test_request(KVM_REQ_USERSPACE_KICK, vcpu)) {
>>> +            r = -EINTR;
>>> +            goto out;
>>> +        }
>>>           if (kvm_check_request(KVM_REQ_VM_DEAD, vcpu)) {
>>>               r = -EIO;
>>>               goto out;
>>> @@ -10701,6 +10705,10 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
>>>               r = vcpu_block(vcpu);
>>>           }
>>>   +        /* vcpu exited guest/unblocked because of this request */
>>> +        if (kvm_test_request(KVM_REQ_USERSPACE_KICK, vcpu))
>>> +            return -EINTR;
>>> +
>>>           if (r <= 0)
>>>               break;
>>>   diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
>>> index ae0240928a4a..13fa7229b85d 100644
>>> --- a/virt/kvm/kvm_main.c
>>> +++ b/virt/kvm/kvm_main.c
>>> @@ -3431,6 +3431,8 @@ static int kvm_vcpu_check_block(struct kvm_vcpu
>>> *vcpu)
>>>           goto out;
>>>       if (kvm_check_request(KVM_REQ_UNBLOCK, vcpu))
>>>           goto out;
>>> +    if (kvm_test_request(KVM_REQ_USERSPACE_KICK, vcpu))
>>> +        goto out;
>>>         ret = 0;
>>>   out:
>>> @@ -4668,6 +4670,25 @@ static long kvm_vm_ioctl(struct file *filp,
>>>           r = kvm_vm_ioctl_enable_cap_generic(kvm, &cap);
>>>           break;
>>>       }
>>> +    case KVM_KICK_ALL_RUNNING_VCPUS: {
>>> +        /*
>>> +         * Notify all running vcpus that they have to stop.
>>> +         * Caught in kvm_arch_vcpu_ioctl_run()
>>> +         */
>>> +        kvm_make_all_cpus_request(kvm, KVM_REQ_USERSPACE_KICK);
>>> +
>>> +        /*
>>> +         * Use wr semaphore to wait for all vcpus to exit from KVM_RUN.
>>> +         */
>>> +        down_write(&memory_transaction);
>>> +        up_write(&memory_transaction);
>>> +        break;
>>> +    }
>>> +    case KVM_RESUME_ALL_KICKED_VCPUS: {
>>> +        /* Remove all requests sent with KVM_KICK_ALL_RUNNING_VCPUS */
>>> +        kvm_clear_all_cpus_request(kvm, KVM_REQ_USERSPACE_KICK);
>>> +        break;
>>> +    }
>>>       case KVM_SET_USER_MEMORY_REGION: {
>>>           struct kvm_userspace_memory_region kvm_userspace_mem;
>>>   
>>

