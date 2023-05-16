Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156EB704DE2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233034AbjEPMgU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjEPMgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75C355B7
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684240529;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gPcSQRk5YWCF8SG/bxTTXXNa/kiYw7+TxfeC8KMSgkE=;
        b=HpfgmK+LVtVo5lM4zJWBTuIJNqyaH+yWnHA2Chrf/btmN+jM4bXrFRfowd5VSM7pNc6RSx
        HAsVrsDurfHhvWZRdf9hjwgf7bNYXgaiDIqTGi52FbtOpIhDQ+jFmznVbRF9ONCA3EwV0p
        +RiYv7LAZTW2MVqoBN/8Gl3VzEpanE8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-BnCD9lpMO0G1ROFGNK4K8Q-1; Tue, 16 May 2023 08:35:28 -0400
X-MC-Unique: BnCD9lpMO0G1ROFGNK4K8Q-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f387b6d37fso151306251cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:35:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240528; x=1686832528;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPcSQRk5YWCF8SG/bxTTXXNa/kiYw7+TxfeC8KMSgkE=;
        b=iORmSNnV/1i6Q9kywu9Tyc82T6KN0MxqU0mXWy56ZIccpjCG4ZgQIKUKgDP/zlT7cn
         YThSfK6Qgx36v/ZU9RDn2/CrjGAX79cnSjpHMzOB4Fe6Yp4LaO3M+LvMgJBv8qq61/kO
         euviYAP2k7RO2abCvOoGfCgvBJYPCLN/dP6W8HVFBVvjGnjlTlny3ZVtM9TwyTSkANBc
         78asmhQ+wu66o5xfwVPzHVwQ71Ca5MzCpmPnoLRg5+LdkIsnH2gUPxgTExXT7vdpkczt
         zc4s3bxKMY39KfXRuIdHxn8zUKVNp0pjFIaL9mbBgqB36x/jdymTsGyvErSYorElJZ6A
         280A==
X-Gm-Message-State: AC+VfDy1qtrt3xcBgXLYOmm8eDydHklnGinJR/pDM4vwfQY6e5oZ14xl
        vcFpbc+6LzCR2+Gjdhuui7iimbVio4lvpkVNdATHZsVEVPsmhpmfEb6ViCJO7Ho2sy16+rD+ZjA
        5e1B47MqF0csdUXyGVjIskNKT
X-Received: by 2002:a05:622a:1750:b0:3ef:61d9:bc6d with SMTP id l16-20020a05622a175000b003ef61d9bc6dmr58465837qtk.14.1684240528261;
        Tue, 16 May 2023 05:35:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5+d8urdrwiyS7t7x4tC0VLPVJdpWAujqpSopHlHz1JW6isskcmCjkiALJIA7MuvZ88SFH/kA==
X-Received: by 2002:a05:622a:1750:b0:3ef:61d9:bc6d with SMTP id l16-20020a05622a175000b003ef61d9bc6dmr58465796qtk.14.1684240527879;
        Tue, 16 May 2023 05:35:27 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id p3-20020a05620a112300b0075902dffce7sm553768qkk.100.2023.05.16.05.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:35:27 -0700 (PDT)
Message-ID: <851940cd-64f1-9e59-3de9-b50701a99281@redhat.com>
Date:   Tue, 16 May 2023 14:35:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
Content-Language: en-US
To:     Peter Collingbourne <pcc@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
        <Qun-wei.Lin@mediatek.com>, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "surenb@google.com" <surenb@google.com>,
        =?UTF-8?B?Q2hpbndlbiBDaGFuZyAo5by16Yym5paHKQ==?= 
        <chinwen.chang@mediatek.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        =?UTF-8?B?S3Vhbi1ZaW5nIExlZSAo5p2O5Yag56mOKQ==?= 
        <Kuan-Ying.Lee@mediatek.com>,
        =?UTF-8?B?Q2FzcGVyIExpICjmnY7kuK3mpq4p?= <casper.li@mediatek.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        vincenzo.frascino@arm.com,
        Alexandru Elisei <alexandru.elisei@arm.com>, will@kernel.org,
        eugenis@google.com, Steven Price <steven.price@arm.com>,
        stable@vger.kernel.org
References: <20230512235755.1589034-1-pcc@google.com>
 <20230512235755.1589034-2-pcc@google.com>
 <7471013e-4afb-e445-5985-2441155fc82c@redhat.com> <ZGJtJobLrBg3PtHm@arm.com>
 <ZGLC0T32sgVkG5kX@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <ZGLC0T32sgVkG5kX@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.05.23 01:40, Peter Collingbourne wrote:
> On Mon, May 15, 2023 at 06:34:30PM +0100, Catalin Marinas wrote:
>> On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
>>> On 13.05.23 01:57, Peter Collingbourne wrote:
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 01a23ad48a04..83268d287ff1 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -3914,19 +3914,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>    		}
>>>>    	}
>>>> -	/*
>>>> -	 * Remove the swap entry and conditionally try to free up the swapcache.
>>>> -	 * We're already holding a reference on the page but haven't mapped it
>>>> -	 * yet.
>>>> -	 */
>>>> -	swap_free(entry);
>>>> -	if (should_try_to_free_swap(folio, vma, vmf->flags))
>>>> -		folio_free_swap(folio);
>>>> -
>>>> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>>> -	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>>>    	pte = mk_pte(page, vma->vm_page_prot);
>>>> -
>>>>    	/*
>>>>    	 * Same logic as in do_wp_page(); however, optimize for pages that are
>>>>    	 * certainly not shared either because we just allocated them without
>>>> @@ -3946,8 +3934,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>    		pte = pte_mksoft_dirty(pte);
>>>>    	if (pte_swp_uffd_wp(vmf->orig_pte))
>>>>    		pte = pte_mkuffd_wp(pte);
>>>> +	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>>>>    	vmf->orig_pte = pte;
>>>> +	/*
>>>> +	 * Remove the swap entry and conditionally try to free up the swapcache.
>>>> +	 * We're already holding a reference on the page but haven't mapped it
>>>> +	 * yet.
>>>> +	 */
>>>> +	swap_free(entry);
>>>> +	if (should_try_to_free_swap(folio, vma, vmf->flags))
>>>> +		folio_free_swap(folio);
>>>> +
>>>> +	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>>> +	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>>> +
>>>>    	/* ksm created a completely new copy */
>>>>    	if (unlikely(folio != swapcache && swapcache)) {
>>>>    		page_add_new_anon_rmap(page, vma, vmf->address);
>>>> @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>>    	VM_BUG_ON(!folio_test_anon(folio) ||
>>>>    			(pte_write(pte) && !PageAnonExclusive(page)));
>>>>    	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>>>> -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>>>>    	folio_unlock(folio);
>>>>    	if (folio != swapcache && swapcache) {
>>>
>>>
>>> You are moving the folio_free_swap() call after the folio_ref_count(folio)
>>> == 1 check, which means that such (previously) swapped pages that are
>>> exclusive cannot be detected as exclusive.
>>>
>>> There must be a better way to handle MTE here.
>>>
>>> Where are the tags stored, how is the location identified, and when are they
>>> effectively restored right now?
>>
>> I haven't gone through Peter's patches yet but a pretty good description
>> of the problem is here:
>> https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/.
>> I couldn't reproduce it with my swap setup but both Qun-wei and Peter
>> triggered it.
> 
> In order to reproduce this bug it is necessary for the swap slot cache
> to be disabled, which is unlikely to occur during normal operation. I
> was only able to reproduce the bug by disabling it forcefully with the
> following patch:
> 
> diff --git a/mm/swap_slots.c b/mm/swap_slots.c
> index 0bec1f705f8e0..25afba16980c7 100644
> --- a/mm/swap_slots.c
> +++ b/mm/swap_slots.c
> @@ -79,7 +79,7 @@ void disable_swap_slots_cache_lock(void)
>   
>   static void __reenable_swap_slots_cache(void)
>   {
> -	swap_slot_cache_enabled = has_usable_swap();
> +	swap_slot_cache_enabled = false;
>   }
>   
>   void reenable_swap_slots_cache_unlock(void)
> 
> With that I can trigger the bug on an MTE-utilizing process by running
> a program that enumerates the process's private anonymous mappings and
> calls process_madvise(MADV_PAGEOUT) on all of them.
> 
>> When a tagged page is swapped out, the arm64 code stores the metadata
>> (tags) in a local xarray indexed by the swap pte. When restoring from
>> swap, the arm64 set_pte_at() checks this xarray using the old swap pte
>> and spills the tags onto the new page. Apparently something changed in
>> the kernel recently that causes swap_range_free() to be called before
>> set_pte_at(). The arm64 arch_swap_invalidate_page() frees the metadata
>> from the xarray and the subsequent set_pte_at() won't find it.
>>
>> If we have the page, the metadata can be restored before set_pte_at()
>> and I guess that's what Peter is trying to do (again, I haven't looked
>> at the details yet; leaving it for tomorrow).
>>
>> Is there any other way of handling this? E.g. not release the metadata
>> in arch_swap_invalidate_page() but later in set_pte_at() once it was
>> restored. But then we may leak this metadata if there's no set_pte_at()
>> (the process mapping the swap entry died).
> 
> Another problem that I can see with this approach is that it does not
> respect reference counts for swap entries, and it's unclear whether that
> can be done in a non-racy fashion.
> 
> Another approach that I considered was to move the hook to swap_readpage()
> as in the patch below (sorry, it only applies to an older version
> of Android's android14-6.1 branch and not mainline, but you get the
> idea). But during a stress test (running the aforementioned program that
> calls process_madvise(MADV_PAGEOUT) in a loop during an Android "monkey"
> test) I discovered the following racy use-after-free that can occur when
> two tasks T1 and T2 concurrently restore the same page:
> 
> T1:                  | T2:
> arch_swap_readpage() |
>                       | arch_swap_readpage() -> mte_restore_tags() -> xe_load()
> swap_free()          |
>                       | arch_swap_readpage() -> mte_restore_tags() -> mte_restore_page_tags()
> 
> We can avoid it by taking the swap_info_struct::lock spinlock in
> mte_restore_tags(), but it seems like it would lead to lock contention.
> 

Would the idea be to fail swap_readpage() on the one that comes last, 
simply retrying to lookup the page?

This might be a naive question, but how does MTE play along with shared 
anonymous pages?

-- 
Thanks,

David / dhildenb

