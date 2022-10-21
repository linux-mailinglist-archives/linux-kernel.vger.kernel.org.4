Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3388D607720
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbiJUMl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiJUMlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:41:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2702681E7
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666356084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QHzZGIR/L3eWjmkvGxDRS//SKT5lTAiH8nYjXGv6sWo=;
        b=bZ7WFy/KRo2tCztutz/rus6kcJ3KO9RUAuOOlg9DSSiS1ysgRPXNEKkERA/KhZ3iTw3rXP
        bidCtAW93NMU4bOuS7su7rLa9lLt6/8PErbCf4VETu9citsWKCpZa7h9mDPOTIOlWNQDEK
        krt+tl5kpqpFofSekaeEJk6veRC/QYg=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-75-SA8pem_eP_SUssnD4J-_Ig-1; Fri, 21 Oct 2022 08:41:23 -0400
X-MC-Unique: SA8pem_eP_SUssnD4J-_Ig-1
Received: by mail-ed1-f72.google.com with SMTP id s8-20020a056402520800b0045cab560d5eso2328402edd.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:41:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QHzZGIR/L3eWjmkvGxDRS//SKT5lTAiH8nYjXGv6sWo=;
        b=SfWSCi3swrSaIvC5oQAK6FK6DKv0yE1ZccwUmU/YVAmbEqTdET+96myKrVxtnGjJzq
         pdkrEsmUnNCQThg5HaE73FVDb3d0zo+o1e4IsDWKOFpTxzGnPqZyPCRobOk2ey8GTpCF
         DEfc3DqHHwzx7BF2GQ+LB3kKJbqWq/JTqEHX+zzJpSdWooDhFyYGOEiEU6tN6hWzZrim
         0GEi+PkHTeIPvE7nmxZCFF2E1xEI5mfboR3TDAMXrroFhsjvrnQVvJoQCKE6+5lbPvb2
         xtJDzYwHcrF0nk0woNF/50hmaiPvWXeDO2k2AWNtkUqbijyowma+3yVVSsgr9v92NenT
         J1cg==
X-Gm-Message-State: ACrzQf31g9C0Z1Htsx4K84WZc7tUXysP+RAU/v0QjqSiWUqnWDgq2/t6
        IW/OZQ+eLpsEicpKLN5z46+gpjm7ok+ri9VXMJhIskpjHT6mkjz6r/LWrnbvVwi+hud5l8+fF6h
        YAaoWFIkjznEAWrl3SqoW7iumw3XdOkJlI/IO3qbgiBPnnak+idxNfplZrkqVVVE58NdsJx247G
        e9
X-Received: by 2002:a50:baec:0:b0:461:4c59:12bf with SMTP id x99-20020a50baec000000b004614c5912bfmr2386073ede.54.1666356082061;
        Fri, 21 Oct 2022 05:41:22 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6RSW63B8AxPtX3+pwhw0aXbCOhejwCfMPNftvJiTc6+wgGrJqhZFR9SUaQf54iaKqPePBggQ==
X-Received: by 2002:a50:baec:0:b0:461:4c59:12bf with SMTP id x99-20020a50baec000000b004614c5912bfmr2386039ede.54.1666356081696;
        Fri, 21 Oct 2022 05:41:21 -0700 (PDT)
Received: from ovpn-192-65.brq.redhat.com (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id n26-20020aa7c69a000000b0046146c730easm910838edq.75.2022.10.21.05.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 05:41:21 -0700 (PDT)
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
Subject: Re: [PATCH v11 16/46] KVM: x86: hyper-v: Don't use
 sparse_set_to_vcpu_mask() in kvm_hv_send_ipi()
In-Reply-To: <87czalczo6.fsf@redhat.com>
References: <20221004123956.188909-1-vkuznets@redhat.com>
 <20221004123956.188909-17-vkuznets@redhat.com>
 <Y1BahCzO4jxFC9Ey@google.com> <87czalczo6.fsf@redhat.com>
Date:   Fri, 21 Oct 2022 14:41:19 +0200
Message-ID: <877d0tcpsg.fsf@ovpn-192-65.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vitaly Kuznetsov <vkuznets@redhat.com> writes:

> Sean Christopherson <seanjc@google.com> writes:
>
>> On Tue, Oct 04, 2022, Vitaly Kuznetsov wrote:
>
> ...
>
>>>  
>>> -	if (all_cpus) {
>>> -		kvm_send_ipi_to_many(kvm, vector, NULL);
>>> -	} else {
>>> -		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
>>> -
>>> -		kvm_send_ipi_to_many(kvm, vector, vcpu_mask);
>>> -	}
>>> +	kvm_hv_send_ipi_to_many(kvm, vector, all_cpus ? NULL : sparse_banks, valid_bank_mask);
>>
>> Any objection to not using a ternary operator?
>>
>> 	if (all_cpus)
>> 		kvm_hv_send_ipi_to_many(kvm, vector, NULL, 0);
>> 	else
>> 		kvm_hv_send_ipi_to_many(kvm, vector, sparse_banks, valid_bank_mask);
>>
>
> Not at all,
>
>> Mostly because it's somewhat arbitrary that earlier code ensures valid_bank_mask
>> is set in the all_cpus=true case, e.g. arguably KVM doesn't need to do the var_cnt
>> sanity check in the all_cpus case:
>>
>> 		all_cpus = send_ipi_ex.vp_set.format == HV_GENERIC_SET_ALL;
>> 		if (all_cpus)
>> 			goto check_and_send_ipi;
>>
>> 		valid_bank_mask = send_ipi_ex.vp_set.valid_bank_mask;
>> 		if (hc->var_cnt != hweight64(valid_bank_mask))
>> 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
>>
>> 		if (!hc->var_cnt)
>> 			goto ret_success;
>>
>
> I think 'var_cnt' (== hweight64(valid_bank_mask)) has to be checked in
> 'all_cpus' case, especially in kvm_hv_flush_tlb(): the code which reads
> TLB flush entries will read them from the wrong offset (data_offset/
> consumed_xmm_halves) otherwise. The problem is less severe in
> kvm_hv_send_ipi() as there's no data after CPU banks. 
>
> At the bare minimum, "KVM: x86: hyper-v: Handle
> HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST{,EX} calls gently" patch from this
> series will have to be adjusted. I *think* mandating var_cnt==0 in 'all_cpus'
> is OK but I don't recall such requirement from TLFS, maybe it's safer to
> just adjust 'data_offset'/'consumed_xmm_halves' even in 'all_cpus' case.
>
> Let me do some tests... 

"We can neither confirm nor deny the existence of the problem". Windows
guests seem to be smart enough to avoid using *_EX hypercalls altogether
for "all cpus" case (as non-ex versions are good enough). Let's keep
allowing non-zero var_cnt for 'all cpus' case for now and think about
hardening it later...

-- 
Vitaly

