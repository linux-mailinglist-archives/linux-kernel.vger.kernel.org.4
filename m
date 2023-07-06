Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B84E174923D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232241AbjGFAFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjGFAFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F5919A0
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688601891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kTd/qr4bksrZcC6BdjL1ZLMm9nyCEwUKcpATLihwv5k=;
        b=Px8P2cXmL4kAzwaBh3u1WZKnO0xzSM24m5iqzHheVM8t7KfHajn7LGctxK5ht/b0vsjLtu
        Vur9gkrThWgP8pSpzobwjSYRh36i00HK5bN0utbsBKjzagsAVFUcQsPsckEYMm+D8PWavp
        /on0x3Tkiz3Uw/hxBCTuj8SMYwT8GgA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-W0yA9o32P3eIPDeAceHCNQ-1; Wed, 05 Jul 2023 20:04:50 -0400
X-MC-Unique: W0yA9o32P3eIPDeAceHCNQ-1
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3a337ddff03so171207b6e.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 17:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688601890; x=1691193890;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTd/qr4bksrZcC6BdjL1ZLMm9nyCEwUKcpATLihwv5k=;
        b=lg71VteGHVjhmdA3ZPWhzAf9EsIlT3niXG49xF1ULSkNKz5/mTDqZFAXooCafMHSRw
         nQmwElkN0FlFQC20KViILke67iWwdiWlzQkXKuYmngk6SknYkJ77K6N3S+n72M3xhECb
         HeYZNi+Y/mZqJ2GGOMXPVl6pZ9aJ2LaAtNYUHyr/0VWpOQum5mZKkWdMCSpSalab5QPM
         tkRSfAvO7uTWoitFuLq05C6bBz3apttfUYp7LYCKw8U5VHAQeR4CfjceBm0tIxoPJBOE
         IxOwO/jXB6QoysK2D2Fui7JxzH3xnxZkd06Yo2Kxb/hy8qBk+2G/M8YH1rdFvEH4nIbD
         Ek1Q==
X-Gm-Message-State: ABy/qLZkqmq2caH80eXMEbG9rT9PSdZvm+yfLdcYx1r7MsgZzhhe5ViP
        UncftQeYYo7ZwZqHAYFKjdgHTUgAVn1AyyV3HIv6YtWhMCQHnIp8lKVJh3CPju9XWmNyDFhoNvR
        1b2OX78lYHpe5GDgQx80YxysE
X-Received: by 2002:aca:210c:0:b0:3a3:b98a:d7b3 with SMTP id 12-20020aca210c000000b003a3b98ad7b3mr156726oiz.15.1688601890052;
        Wed, 05 Jul 2023 17:04:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFcAOyD86qn/Ko0yes6t7MQ6QP/I4BxYakSMNNUvAJ9TO78ZpYETGSsp9SSZO8tfA3KeC1o4g==
X-Received: by 2002:aca:210c:0:b0:3a3:b98a:d7b3 with SMTP id 12-20020aca210c000000b003a3b98ad7b3mr156713oiz.15.1688601889815;
        Wed, 05 Jul 2023 17:04:49 -0700 (PDT)
Received: from ?IPV6:2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5? ([2001:8003:e5b0:9f00:dbbc:1945:6e65:ec5])
        by smtp.gmail.com with ESMTPSA id x11-20020a056a00270b00b00662610cf7a8sm83655pfv.172.2023.07.05.17.04.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jul 2023 17:04:48 -0700 (PDT)
Message-ID: <60ba5bb4-6fad-0e51-2cd5-845610e6631d@redhat.com>
Date:   Thu, 6 Jul 2023 10:04:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RESEND PATCH v5 07/11] KVM: arm64: Define
 kvm_tlb_flush_vmid_range()
Content-Language: en-US
To:     Raghavendra Rao Ananta <rananta@google.com>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        David Matlack <dmatlack@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-mips@vger.kernel.org, kvm-riscv@lists.infradead.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
References: <20230621175002.2832640-1-rananta@google.com>
 <20230621175002.2832640-8-rananta@google.com>
 <1fe280a7-0f10-e124-00aa-b137df722c33@redhat.com>
 <CAJHc60xQtjvVsWRE=w-pAioNJW6uh-qKuZz2wp6bkT=X4oCm5A@mail.gmail.com>
From:   Gavin Shan <gshan@redhat.com>
In-Reply-To: <CAJHc60xQtjvVsWRE=w-pAioNJW6uh-qKuZz2wp6bkT=X4oCm5A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/6/23 04:28, Raghavendra Rao Ananta wrote:
> On Tue, Jul 4, 2023 at 5:31 PM Gavin Shan <gshan@redhat.com> wrote:
>> On 6/22/23 03:49, Raghavendra Rao Ananta wrote:
>>> Implement the helper kvm_tlb_flush_vmid_range() that acts
>>> as a wrapper for range-based TLB invalidations. For the
>>> given VMID, use the range-based TLBI instructions to do
>>> the job or fallback to invalidating all the TLB entries.
>>>
>>> Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
>>> ---
>>>    arch/arm64/include/asm/kvm_pgtable.h | 10 ++++++++++
>>>    arch/arm64/kvm/hyp/pgtable.c         | 20 ++++++++++++++++++++
>>>    2 files changed, 30 insertions(+)
>>>
>>
>> It may be reasonable to fold this to PATCH[08/11] since kvm_tlb_flush_vmid_range() is
>> only called by ARM64's kvm_arch_flush_remote_tlbs_range(), which is added by PATCH[08/11].
>> In either way, the changes look good to me:
>>
> Ah, the patches 10 and 11 also call kvm_tlb_flush_vmid_range(), so
> probably it's better to keep the definition isolated?
> 

Thanks for your explanation. It's fine to have two separate patches in this
case. I still need to spend some time to look at PATCH[11/11] whose subject
includes typo (intructions -> instructions)

Thanks,
Gavin

>> Reviewed-by: Gavin Shan <gshan@redhat.com>
>>
>>> diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
>>> index 4cd6762bda805..1b12295a83595 100644
>>> --- a/arch/arm64/include/asm/kvm_pgtable.h
>>> +++ b/arch/arm64/include/asm/kvm_pgtable.h
>>> @@ -682,4 +682,14 @@ enum kvm_pgtable_prot kvm_pgtable_stage2_pte_prot(kvm_pte_t pte);
>>>     *     kvm_pgtable_prot format.
>>>     */
>>>    enum kvm_pgtable_prot kvm_pgtable_hyp_pte_prot(kvm_pte_t pte);
>>> +
>>> +/**
>>> + * kvm_tlb_flush_vmid_range() - Invalidate/flush a range of TLB entries
>>> + *
>>> + * @mmu:     Stage-2 KVM MMU struct
>>> + * @addr:    The base Intermediate physical address from which to invalidate
>>> + * @size:    Size of the range from the base to invalidate
>>> + */
>>> +void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
>>> +                             phys_addr_t addr, size_t size);
>>>    #endif      /* __ARM64_KVM_PGTABLE_H__ */
>>> diff --git a/arch/arm64/kvm/hyp/pgtable.c b/arch/arm64/kvm/hyp/pgtable.c
>>> index 3d61bd3e591d2..df8ac14d9d3d4 100644
>>> --- a/arch/arm64/kvm/hyp/pgtable.c
>>> +++ b/arch/arm64/kvm/hyp/pgtable.c
>>> @@ -631,6 +631,26 @@ static bool stage2_has_fwb(struct kvm_pgtable *pgt)
>>>        return !(pgt->flags & KVM_PGTABLE_S2_NOFWB);
>>>    }
>>>
>>> +void kvm_tlb_flush_vmid_range(struct kvm_s2_mmu *mmu,
>>> +                             phys_addr_t addr, size_t size)
>>> +{
>>> +     unsigned long pages, inval_pages;
>>> +
>>> +     if (!system_supports_tlb_range()) {
>>> +             kvm_call_hyp(__kvm_tlb_flush_vmid, mmu);
>>> +             return;
>>> +     }
>>> +
>>> +     pages = size >> PAGE_SHIFT;
>>> +     while (pages > 0) {
>>> +             inval_pages = min(pages, MAX_TLBI_RANGE_PAGES);
>>> +             kvm_call_hyp(__kvm_tlb_flush_vmid_range, mmu, addr, inval_pages);
>>> +
>>> +             addr += inval_pages << PAGE_SHIFT;
>>> +             pages -= inval_pages;
>>> +     }
>>> +}
>>> +
>>>    #define KVM_S2_MEMATTR(pgt, attr) PAGE_S2_MEMATTR(attr, stage2_has_fwb(pgt))
>>>
>>>    static int stage2_set_prot_attr(struct kvm_pgtable *pgt, enum kvm_pgtable_prot prot,

