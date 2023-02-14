Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49188696326
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjBNMLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjBNMLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C5B241C5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676376610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fQGAtPWY8hnlsJbVBZNAgZfYHm1taAI2QR5/9MhuMCw=;
        b=jD3FYNPIHxTQyHz/6Lir9RnQ91fLI1TSQh+Ah7isz3SlnMo/ewDcEygiCzsn48M5Y2mHOb
        qeVZI8dkm40ZiYPiNCRdx2rsVN55tn4h/+ahzkh0F2l9TEcQl+Jw5DF5kdUDBJQxOLojYc
        jLj/yamqPfSnU6XvUHAHBSq7NatCXzA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-442-AGe7PNqdNH2dXT6YojkYzQ-1; Tue, 14 Feb 2023 07:10:09 -0500
X-MC-Unique: AGe7PNqdNH2dXT6YojkYzQ-1
Received: by mail-wr1-f72.google.com with SMTP id o9-20020adfa109000000b002bfc062eaa8so3038763wro.20
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:10:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fQGAtPWY8hnlsJbVBZNAgZfYHm1taAI2QR5/9MhuMCw=;
        b=j/6BVNGKdpDYIf0wRBWOwR6jlzv+TevOW9CXLma6PDYt0bdZrkGXAw1MDNga35g9T5
         ST6L/OSMcopLPPnpPmUYlKs5uJb8sPwojG9P8Qa3vgZZ5Wl5btkCMGwsrw9OJGyTXudE
         sYkXKr69OPPDj3eeSdQ0b8H7NKqmDyjlStFjK9PPIU1MEkWjdCmiTaO0ql57+e/ME58N
         MyXTGsjrvMwacAOAP0Ri6HJMq4D+ja8NsHf8L+VAmHz3ta6fjfUXVxBib7YhQJgV6Fcn
         tk78u6mixjBIp4h7gJpIQ/S7nlqILole/Odb7aK5Jrqgaagd4+Qdr9wgMOyiLRez5nHY
         2CDQ==
X-Gm-Message-State: AO0yUKVYhj+SueB4+7qBS9TleJ9Zek+FnzTUvnoiteOQ2XaB8GEHfVoc
        quHzw0+T5OEQ6/jUF1eyNFn3eZpA6LMbTEYVUNswtgJcorB3ZY40xkwkUGtolqO1z1lgmuIbDev
        ftPQGzdhTzwMewOBXNbow23NWIw9AbQ==
X-Received: by 2002:adf:fa12:0:b0:2c5:54fd:265e with SMTP id m18-20020adffa12000000b002c554fd265emr1682827wrr.70.1676376607937;
        Tue, 14 Feb 2023 04:10:07 -0800 (PST)
X-Google-Smtp-Source: AK7set/eKR65hGUw7zjA32D3rQxfs8/JgEu3cXxJDUUjr9KXAGFDOM4Uq2hNdzig/HmGGAGmmtSQFw==
X-Received: by 2002:adf:fa12:0:b0:2c5:54fd:265e with SMTP id m18-20020adffa12000000b002c554fd265emr1682806wrr.70.1676376607604;
        Tue, 14 Feb 2023 04:10:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c709:1700:969:8e2b:e8bb:46be? (p200300cbc709170009698e2be8bb46be.dip0.t-ipconnect.de. [2003:cb:c709:1700:969:8e2b:e8bb:46be])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d5409000000b002c558228b6dsm5509185wrv.12.2023.02.14.04.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:10:07 -0800 (PST)
Message-ID: <4c9e7ddb-b303-688a-5fc6-be83ca1a8a2a@redhat.com>
Date:   Tue, 14 Feb 2023 13:10:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v1 RFC Zisslpcfi 11/20] mmu: maybe_mkwrite updated to
 manufacture shadow stack PTEs
Content-Language: en-US
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
References: <20230213045351.3945824-1-debug@rivosinc.com>
 <20230213045351.3945824-12-debug@rivosinc.com>
 <2d6eefb8-c7c5-7d32-9a75-ae716f828cd9@redhat.com>
 <20230213143754.GC3943238@debug.ba.rivosinc.com>
 <7693247c-a55d-a375-3621-1b07115a9d99@redhat.com>
 <20230213200109.GA4016181@debug.ba.rivosinc.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230213200109.GA4016181@debug.ba.rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.02.23 21:01, Deepak Gupta wrote:
> On Mon, Feb 13, 2023 at 03:56:22PM +0100, David Hildenbrand wrote:
>> On 13.02.23 15:37, Deepak Gupta wrote:
>>> On Mon, Feb 13, 2023 at 01:05:16PM +0100, David Hildenbrand wrote:
>>>> On 13.02.23 05:53, Deepak Gupta wrote:
>>>>> maybe_mkwrite creates PTEs with WRITE encodings for underlying arch if
>>>>> VM_WRITE is turned on in vma->vm_flags. Shadow stack memory is a write-
>>>>> able memory except it can only be written by certain specific
>>>>> instructions. This patch allows maybe_mkwrite to create shadow stack PTEs
>>>>> if vma is shadow stack VMA. Each arch can define which combination of VMA
>>>>> flags means a shadow stack.
>>>>>
>>>>> Additionally pte_mkshdwstk must be provided by arch specific PTE
>>>>> construction headers to create shadow stack PTEs. (in arch specific
>>>>> pgtable.h).
>>>>>
>>>>> This patch provides dummy/stub pte_mkshdwstk if CONFIG_USER_SHADOW_STACK
>>>>> is not selected.
>>>>>
>>>>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>>>> ---
>>>>>   include/linux/mm.h      | 23 +++++++++++++++++++++--
>>>>>   include/linux/pgtable.h |  4 ++++
>>>>>   2 files changed, 25 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index 8f857163ac89..a7705bc49bfe 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -1093,6 +1093,21 @@ static inline unsigned long thp_size(struct page *page)
>>>>>   void free_compound_page(struct page *page);
>>>>>   #ifdef CONFIG_MMU
>>>>> +
>>>>> +#ifdef CONFIG_USER_SHADOW_STACK
>>>>> +bool arch_is_shadow_stack_vma(struct vm_area_struct *vma);
>>>>> +#endif
>>>>> +
>>>>> +static inline bool
>>>>> +is_shadow_stack_vma(struct vm_area_struct *vma)
>>>>> +{
>>>>> +#ifdef CONFIG_USER_SHADOW_STACK
>>>>> +	return arch_is_shadow_stack_vma(vma);
>>>>> +#else
>>>>> +	return false;
>>>>> +#endif
>>>>> +}
>>>>> +
>>>>>   /*
>>>>>    * Do pte_mkwrite, but only if the vma says VM_WRITE.  We do this when
>>>>>    * servicing faults for write access.  In the normal case, do always want
>>>>> @@ -1101,8 +1116,12 @@ void free_compound_page(struct page *page);
>>>>>    */
>>>>>   static inline pte_t maybe_mkwrite(pte_t pte, struct vm_area_struct *vma)
>>>>>   {
>>>>> -	if (likely(vma->vm_flags & VM_WRITE))
>>>>> -		pte = pte_mkwrite(pte);
>>>>> +	if (likely(vma->vm_flags & VM_WRITE)) {
>>>>> +		if (unlikely(is_shadow_stack_vma(vma)))
>>>>> +			pte = pte_mkshdwstk(pte);
>>>>> +		else
>>>>> +			pte = pte_mkwrite(pte);
>>>>> +	}
>>>>>   	return pte;
>>>>
>>>> Exactly what we are trying to avoid in the x86 approach right now.
>>>> Please see the x86 series on details, we shouldn't try reinventing the
>>>> wheel but finding a core-mm approach that fits multiple architectures.
>>>>
>>>> https://lkml.kernel.org/r/20230119212317.8324-1-rick.p.edgecombe@intel.com
>>>
>>> Thanks David for comment here. I looked at x86 approach. This patch
>>> actually written in a way which is not re-inventing wheel and is following
>>> a core-mm approach that fits multiple architectures.
>>>
>>> Change above checks `is_shadow_stack_vma` and if it returns true then only
>>> it manufactures shadow stack pte else it'll make a regular writeable mapping.
>>>
>>> Now if we look at `is_shadow_stack_vma` implementation, it returns false if
>>> `CONFIG_USER_SHADOW_STACK` is not defined. If `CONFIG_USER_SHADOW_STACK is
>>> defined then it calls `arch_is_shadow_stack_vma` which should be implemented
>>> by arch specific code. This allows each architecture to define their own vma
>>> flag encodings for shadow stack (riscv chooses presence of only `VM_WRITE`
>>> which is analogous to choosen PTE encodings on riscv W=1,R=0,X=0)
>>>
>>> Additionally pte_mkshdwstk will be nop if not implemented by architecture.
>>>
>>> Let me know if this make sense. If I am missing something here, let me know.
>>
>> See the discussion in that thread. The idea is to pass a VMA to
>> pte_mkwrite() and let it handle how to actually set it writable.
>>
> 
> Thanks. I see. Instances where `pte_mkwrite` is directly invoked by checking
> VM_WRITE and thus instead of fixing all those instance, make pte_mkwrite itself
> take vma flag or vma.
> 
> I'll revise.

Thanks, it would be great to discuss in the other threads what else you 
would need to make it work for you. I assume Rick will have something to 
play with soonish (Right, Rick? :) ).

-- 
Thanks,

David / dhildenb

