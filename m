Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984375E5EC9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 11:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbiIVJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiIVJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 05:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD9BD12D7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663839762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CqniHYpEdr1w/8IlQR97YuXzF1PQJXDdRDYRsJG7hRc=;
        b=eLQ75SjVbYGsScSYiGvVnLMLwtZxxqI6O8c9KRIhewaoDgZ+zMmbCkyGoQ+C38PQ9KKoR7
        7Z5v0+wtZNrfWdDacM4+LOeHMckujhBnlD0KkSG06GaZi+1affqLwRPA55cjQ/I9KiwhC4
        p17SDzM5lvMPatMM76fe4JipSWLmtEU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-495-Bg8yfndSOX-otRHKBZQl3Q-1; Thu, 22 Sep 2022 05:42:41 -0400
X-MC-Unique: Bg8yfndSOX-otRHKBZQl3Q-1
Received: by mail-wm1-f70.google.com with SMTP id k38-20020a05600c1ca600b003b49a809168so823123wms.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 02:42:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=CqniHYpEdr1w/8IlQR97YuXzF1PQJXDdRDYRsJG7hRc=;
        b=vQe8j2OdOsBKMvqYW2zkazXb7FR4Tg0YBC5otZV2BrvB9Q55ed1g4BP4lL3Uz0gCOw
         fjWQkFZHasHSHyxViG0nzme8SyFU1C5TZihl/ScBj98BvSotcPpcePlo9V3/uvL1oxFZ
         UQ9mGRhqxg/yXdfO7qzXv/+xrMboNu+uqgTn3FDlPP5XXgyi69+uX6z5+T66tERZgVkA
         B2q5CR9NbrPcdI6Sab+aYKjP+uGsQBkzIJa2mBh+57OsZJ3NCuvuuGDKYRM1LYdKFn04
         bDuZ1im7dUZ+zcfoaShcD8pbqVcKJUULcWqCxnGVqGGmCIKSHU9fyd987/y7DONNY6hI
         DuQA==
X-Gm-Message-State: ACrzQf2s53t1LHFyJQ4gT6U213NUfmMMDAL6sMvve12Lr70ipypk0eJt
        iSILwOwTJRTJmeftLwCYEznJm2UDWJGnWaRwOGTJyDwLifxRr4AN/5P6rdBzap3QViTCeCw9oEP
        sxdR6GlrWjykBjQTY9uL2PaGwukEdSBeJzn9qD0h/9ATgvyFq96plswMMXcbiXJ4TKy7Q6LeIpE
        GR
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr1417192wrr.2.1663839760349;
        Thu, 22 Sep 2022 02:42:40 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM69JrDKfHLHJskgVcDVybedXF9MORZ0v+k/15GgMV4bxD2PDIMcpJftM7I2DLv537/o+S1BXA==
X-Received: by 2002:adf:fb84:0:b0:21a:10f2:1661 with SMTP id a4-20020adffb84000000b0021a10f21661mr1417153wrr.2.1663839759939;
        Thu, 22 Sep 2022 02:42:39 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id l8-20020a5d5268000000b0022a839d053csm4677940wrc.98.2022.09.22.02.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 02:42:38 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Siddharth Chandrasekaran <sidcha@amazon.de>,
        Yuan Yao <yuan.yao@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 03/39] KVM: x86: hyper-v: Introduce TLB flush fifo
In-Reply-To: <YytCKIMgiVY+kSf9@google.com>
References: <20220921152436.3673454-1-vkuznets@redhat.com>
 <20220921152436.3673454-4-vkuznets@redhat.com>
 <YytCKIMgiVY+kSf9@google.com>
Date:   Thu, 22 Sep 2022 11:42:36 +0200
Message-ID: <871qs3oicz.fsf@redhat.com>
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

> On Wed, Sep 21, 2022, Vitaly Kuznetsov wrote:
>> To allow flushing individual GVAs instead of always flushing the whole
>> VPID a per-vCPU structure to pass the requests is needed. Use standard
>> 'kfifo' to queue two types of entries: individual GVA (GFN + up to 4095
>> following GFNs in the lower 12 bits) and 'flush all'.
>> 
>> The size of the fifo is arbitrary set to '16'.
>
> s/arbitrary/arbitrarily
>
>> +static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu)
>> +{
>> +	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
>> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>> +	u64 flush_all_entry = KVM_HV_TLB_FLUSHALL_ENTRY;
>> +
>> +	if (!hv_vcpu)
>> +		return;
>> +
>> +	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
>> +
>> +	kfifo_in_spinlocked(&tlb_flush_fifo->entries, &flush_all_entry,
>> +			    1, &tlb_flush_fifo->write_lock);
>
> Unless I'm missing something, there's no need to disable IRQs, i.e. this can be
> kfifo_in_spinlocked_noirqsave() and the later patch can use spin_lock() instead
> of spin_lock_irqsave().  The only calls to hv_tlb_flush_enqueue() are from
> kvm_hv_hypercall(), i.e. it's always called from process context.
>   

Yes, no IRQ/... contexts are expected, the intention was to take the
spinlock for the shortest amount of time, not to protect against a
deadlock. This probably is not worthy and causes a confusion so I'll
remove it.

>> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
>> index 1030b1b50552..ac30091ab346 100644
>> --- a/arch/x86/kvm/hyperv.h
>> +++ b/arch/x86/kvm/hyperv.h
>> @@ -151,4 +151,20 @@ int kvm_vm_ioctl_hv_eventfd(struct kvm *kvm, struct kvm_hyperv_eventfd *args);
>>  int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>>  		     struct kvm_cpuid_entry2 __user *entries);
>>  
>> +
>
> Unnecessary newline.
>
>> +static inline void kvm_hv_vcpu_empty_flush_tlb(struct kvm_vcpu *vcpu)
>
> What about "reset" or "purge" instead of "empty"?  "empty" is often used as query,
> e.g. list_empty(), it took me a second to realize this is a command.
>

'purge' sounds good to me!

>> +{
>> +	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
>> +	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>> +
>> +	if (!hv_vcpu || !kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu))
>> +		return;
>> +
>> +	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
>> +
>> +	kfifo_reset_out(&tlb_flush_fifo->entries);
>> +}
>
> Missing newline.
>
>> +void kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
>> +
>> +
>
> One too many newlines.
>
>>  #endif
>> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
>> index 86504a8bfd9a..45c35c5467f8 100644
>> --- a/arch/x86/kvm/x86.c
>> +++ b/arch/x86/kvm/x86.c
>> @@ -3385,7 +3385,7 @@ static void kvm_vcpu_flush_tlb_all(struct kvm_vcpu *vcpu)
>>  	static_call(kvm_x86_flush_tlb_all)(vcpu);
>>  }
>>  
>> -static void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
>> +void kvm_vcpu_flush_tlb_guest(struct kvm_vcpu *vcpu)
>>  {
>>  	++vcpu->stat.tlb_flush;
>>  
>> @@ -3420,14 +3420,14 @@ void kvm_service_local_tlb_flush_requests(struct kvm_vcpu *vcpu)
>>  {
>>  	if (kvm_check_request(KVM_REQ_TLB_FLUSH_CURRENT, vcpu)) {
>>  		kvm_vcpu_flush_tlb_current(vcpu);
>> -		kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
>> +		kvm_hv_vcpu_empty_flush_tlb(vcpu);
>
> It might be worth adding a comment to call out that emptying the FIFO _after_ the
> TLB flush is ok, because it's impossible for the CPU to insert TLB entries for the
> guest while running in the host.  At first glance, it looks like this (and the
> existing similar pattern in vcpu_enter_guest()) has a race where it could miss a
> TLB flush.
>
> Definitely not required, e.g. kvm_vcpu_flush_tlb_all() doesn't have a similar
> comment.  I think it's just the existence of the FIFO that made me pause.
>

Np, will add something for future generation of readers)

>>  	}
>>  
>>  	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu)) {
>>  		kvm_vcpu_flush_tlb_guest(vcpu);
>> -		kvm_clear_request(KVM_REQ_HV_TLB_FLUSH, vcpu);
>> +		kvm_hv_vcpu_empty_flush_tlb(vcpu);
>>  	} else if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu)) {
>> -		kvm_vcpu_flush_tlb_guest(vcpu);
>> +		kvm_hv_vcpu_flush_tlb(vcpu);
>
> Rather than expose kvm_vcpu_flush_tlb_guest() to Hyper-V, what about implementing
> this in a similar way to how way KVM-on-HyperV implements remote TLB flushes?  I.e.
> fall back to kvm_vcpu_flush_tlb_guest() if the precise flush "fails".
>
> I don't mind exposing kvm_vcpu_flush_tlb_guest(), but burying the calls inside
> Hyper-V code makes it difficult to see the relationship between KVM_REQ_HV_TLB_FLUSH
> and KVM_REQ_TLB_FLUSH_GUEST.
>
> And as a minor bonus, that also helps document that kvm_hv_vcpu_flush_tlb() doesn't
> yet support precise flushing.
>
> E.g.
>
> 	if (kvm_check_request(KVM_REQ_TLB_FLUSH_GUEST, vcpu)) {
> 		kvm_vcpu_flush_tlb_guest(vcpu);
> 	} else if (kvm_check_request(KVM_REQ_HV_TLB_FLUSH, vcpu)) {
> 		/*
> 		 * Fall back to a "full" guest flush if Hyper-V's precise
> 		 * flushing fails.
> 		 */
> 		if (kvm_hv_vcpu_flush_tlb(vcpu))
> 			kvm_vcpu_flush_tlb_guest(vcpu);
> 	}
>
>
> int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu)
> {
> 	struct kvm_vcpu_hv_tlb_flush_fifo *tlb_flush_fifo;
> 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
>
> 	if (!hv_vcpu)
> 		return -EINVAL;
>
> 	tlb_flush_fifo = &hv_vcpu->tlb_flush_fifo;
>
> 	kfifo_reset_out(&tlb_flush_fifo->entries);
>
> 	/* Precise flushing isn't implemented yet. */
> 	return -EOPNOTSUPP;
> }
>

Oh, I see, certainly can be done this way, even if just to improve the
readability. Will change.

-- 
Vitaly

