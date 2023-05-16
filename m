Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9C704DD3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232795AbjEPMbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjEPMbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:31:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E7A4C13
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684240262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ALMVvYlZxEE1m2+2KXk6OCrrF6yVXPnBatrbCWbyCNQ=;
        b=MrORSBVn/PHn0Sr8Mqdrh864zrTaVbWZSIG8a+8lOcumsyv+ootbWbd1WZfnk5tcxKFsOJ
        0MhPIJmb3Tky6/0bmJ49nM0UjG+5tLfB0spG1Mn5yXLH69AmZBmfi15r2dI5BYqfs7ck6J
        v+Rhv669bIoU3ncwwjuWtRxPI1GPPys=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-edOHwQugMyagTVwvoMmzHA-1; Tue, 16 May 2023 08:31:00 -0400
X-MC-Unique: edOHwQugMyagTVwvoMmzHA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f42ceb4a4fso29253895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 05:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684240259; x=1686832259;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ALMVvYlZxEE1m2+2KXk6OCrrF6yVXPnBatrbCWbyCNQ=;
        b=dM2Vwrxmv5NDn6rzdZRXp2KUBHOg79Y+5DK0nMnnsuFt9vnNaknxykqz+6l0J5FtLk
         ugxdPAxKuYHFZgNP+//efz2iBVYXt2pFmW7RZoyzVLPTkVsTzYtZPbzTdhfimuMSFaqP
         lcg9P0F4Pako622WxsFEIewpLJLy+dMBzt94OEgVMIjrnl0yT9NauXeGRgS61NGaeK7K
         Yi7BS/n9/RtvDQrqyFNUOwGDz2oRnP8WexKdfwxStcie7INQ62za4TwoR+1n6Yf9AUEx
         BBqH4kH5DGCp58FhazjHk+UbS3OrD8ICuc3NddyZNWLnej4CTSikyINVAjNRrN6TtSii
         06Iw==
X-Gm-Message-State: AC+VfDza1J98p4B0UArKJYy1HAq6hDXnAMslKUPCF/no0cYOgcithXLU
        J+e9UkZZKqEpivuHua3bpxp3z2j6SuDnrkDZCdZ5cDgEk5ggz5x0q3sECefTHCWLYiyX0a83QW2
        PgYnbzs/Ke4ltCkQgG+DgoAmD
X-Received: by 2002:a1c:7507:0:b0:3f1:9acf:8682 with SMTP id o7-20020a1c7507000000b003f19acf8682mr23702008wmc.17.1684240259568;
        Tue, 16 May 2023 05:30:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5Eg6UWL+D6zbQXZNHghi8/vvX2EWStcyjxEyuD7ME2Z87kkdCw4OhQfxz1isxG+5csGWdeXg==
X-Received: by 2002:a1c:7507:0:b0:3f1:9acf:8682 with SMTP id o7-20020a1c7507000000b003f19acf8682mr23701988wmc.17.1684240259166;
        Tue, 16 May 2023 05:30:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c74f:2500:1e3a:9ee0:5180:cc13? (p200300cbc74f25001e3a9ee05180cc13.dip0.t-ipconnect.de. [2003:cb:c74f:2500:1e3a:9ee0:5180:cc13])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b003f50e88ffb5sm2233741wml.24.2023.05.16.05.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 05:30:58 -0700 (PDT)
Message-ID: <91246137-a3d2-689f-8ff6-eccc0e61c8fe@redhat.com>
Date:   Tue, 16 May 2023 14:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Peter Collingbourne <pcc@google.com>,
        =?UTF-8?B?UXVuLXdlaSBMaW4gKOael+e+pOW0tCk=?= 
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH 1/3] mm: Move arch_do_swap_page() call to before
 swap_free()
In-Reply-To: <ZGJtJobLrBg3PtHm@arm.com>
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

On 15.05.23 19:34, Catalin Marinas wrote:
> On Sat, May 13, 2023 at 05:29:53AM +0200, David Hildenbrand wrote:
>> On 13.05.23 01:57, Peter Collingbourne wrote:
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 01a23ad48a04..83268d287ff1 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -3914,19 +3914,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>    		}
>>>    	}
>>> -	/*
>>> -	 * Remove the swap entry and conditionally try to free up the swapcache.
>>> -	 * We're already holding a reference on the page but haven't mapped it
>>> -	 * yet.
>>> -	 */
>>> -	swap_free(entry);
>>> -	if (should_try_to_free_swap(folio, vma, vmf->flags))
>>> -		folio_free_swap(folio);
>>> -
>>> -	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> -	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>>    	pte = mk_pte(page, vma->vm_page_prot);
>>> -
>>>    	/*
>>>    	 * Same logic as in do_wp_page(); however, optimize for pages that are
>>>    	 * certainly not shared either because we just allocated them without
>>> @@ -3946,8 +3934,21 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>    		pte = pte_mksoft_dirty(pte);
>>>    	if (pte_swp_uffd_wp(vmf->orig_pte))
>>>    		pte = pte_mkuffd_wp(pte);
>>> +	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>>>    	vmf->orig_pte = pte;
>>> +	/*
>>> +	 * Remove the swap entry and conditionally try to free up the swapcache.
>>> +	 * We're already holding a reference on the page but haven't mapped it
>>> +	 * yet.
>>> +	 */
>>> +	swap_free(entry);
>>> +	if (should_try_to_free_swap(folio, vma, vmf->flags))
>>> +		folio_free_swap(folio);
>>> +
>>> +	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>> +	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
>>> +
>>>    	/* ksm created a completely new copy */
>>>    	if (unlikely(folio != swapcache && swapcache)) {
>>>    		page_add_new_anon_rmap(page, vma, vmf->address);
>>> @@ -3959,7 +3960,6 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>>>    	VM_BUG_ON(!folio_test_anon(folio) ||
>>>    			(pte_write(pte) && !PageAnonExclusive(page)));
>>>    	set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>>> -	arch_do_swap_page(vma->vm_mm, vma, vmf->address, pte, vmf->orig_pte);
>>>    	folio_unlock(folio);
>>>    	if (folio != swapcache && swapcache) {
>>
>>
>> You are moving the folio_free_swap() call after the folio_ref_count(folio)
>> == 1 check, which means that such (previously) swapped pages that are
>> exclusive cannot be detected as exclusive.
>>
>> There must be a better way to handle MTE here.
>>
>> Where are the tags stored, how is the location identified, and when are they
>> effectively restored right now?
> 
> I haven't gone through Peter's patches yet but a pretty good description
> of the problem is here:
> https://lore.kernel.org/all/5050805753ac469e8d727c797c2218a9d780d434.camel@mediatek.com/.
> I couldn't reproduce it with my swap setup but both Qun-wei and Peter
> triggered it.
> 
> When a tagged page is swapped out, the arm64 code stores the metadata
> (tags) in a local xarray indexed by the swap pte. When restoring from
> swap, the arm64 set_pte_at() checks this xarray using the old swap pte
> and spills the tags onto the new page. Apparently something changed in
> the kernel recently that causes swap_range_free() to be called before
> set_pte_at(). The arm64 arch_swap_invalidate_page() frees the metadata
> from the xarray and the subsequent set_pte_at() won't find it.
> 
> If we have the page, the metadata can be restored before set_pte_at()
> and I guess that's what Peter is trying to do (again, I haven't looked
> at the details yet; leaving it for tomorrow).

Thanks for the details! I was missing that we also have a hook in 
swap_range_free().

> 
> Is there any other way of handling this? E.g. not release the metadata
> in arch_swap_invalidate_page() but later in set_pte_at() once it was
> restored. But then we may leak this metadata if there's no set_pte_at()
> (the process mapping the swap entry died).

That was my immediate thought: do we really have to hook into 
swap_range_free() at all? And I also wondered why we have to do this 
from set_pte_at() and not do this explicitly (maybe that's the other 
arch_* callback on the swapin path).

I'll have a look at v2, maybe it can be fixed easily without having to 
shuffle around too much of the swapin code (which can easily break again 
because the dependencies are not obvious at all and even undocumented in 
the code).

-- 
Thanks,

David / dhildenb

