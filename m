Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70D5D6228B0
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 11:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiKIKlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 05:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiKIKlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 05:41:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF051D320
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 02:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667990405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QHh2DP+7XCzgs9NqlI4mZS2rPIPMdYcdAmHYPRcL3I4=;
        b=AbpYjH7HDkmkGPYdp24cZQ9mwaYGk2f0c2exW9Q9UUedNh6410NUHhns6iZsdmWjX/Z+l7
        IulqIUyWsNr7ztdX/1Q7Z3BFhLDzosnce4/m61L1BveXI+l2boRPaQIjWTZoOMO2M35g82
        Emmqn4KO6A5fv8Dl2EH3dhIQeukVRa8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-258-MkHEasUnM4a46SC5GbxOgg-1; Wed, 09 Nov 2022 05:40:04 -0500
X-MC-Unique: MkHEasUnM4a46SC5GbxOgg-1
Received: by mail-wm1-f71.google.com with SMTP id r187-20020a1c44c4000000b003c41e9ae97dso825319wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 02:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHh2DP+7XCzgs9NqlI4mZS2rPIPMdYcdAmHYPRcL3I4=;
        b=R2PZGCPTSZnzL11o2Nc6rORbyK4DLEChgDM0d3ETZt3mPOa5CS+2qtyKReliTq0ajL
         3uouASwYZPJNeu8ckYs23CRcIoNmi/3464idBCfF+2sX93eV/tzw1VmgU2DnHppH8Z80
         71Fx+KQlGSpMPHfM1m9ns1PqjcwhGPIScnozM8OTTAoq+cQZ5gpR4IwfjBKH2hKD67zm
         qxy07mUz+lTF8UdU2CotNzUHUp8RSsPHQ7/vkSq5e5mrfSlNn5L9RWxrPtXx0ASbXtHf
         gGmm8o2jWkCpNRC3qEfTzk6wpbw9+dtl7oPApMC1IbjylRw/s5M86QKFfjro02ghtrWw
         yihA==
X-Gm-Message-State: ACrzQf1TF/8Ww3p/yLJefsoItF6zUsUs3j4SoJxbVqBSzRXJAluz1TGV
        1SHBh6sOgpl7O+6BnQs3opn7MbOX51RE6NTcK6qSC1iXTHtyl6KfgGIvYcplD4QyITlSlY2htCZ
        BR3sIB1b9NAyzLikCOm8W4+8y
X-Received: by 2002:adf:f98a:0:b0:236:677c:2407 with SMTP id f10-20020adff98a000000b00236677c2407mr38997610wrr.578.1667990403037;
        Wed, 09 Nov 2022 02:40:03 -0800 (PST)
X-Google-Smtp-Source: AMsMyM7LI+bX7eSwNrmbYuFFFX8YGehweOccrbkXTAREf/6mrXpLXKud+Dxs6Fe9VnJVa8i49wZorQ==
X-Received: by 2002:adf:f98a:0:b0:236:677c:2407 with SMTP id f10-20020adff98a000000b00236677c2407mr38997595wrr.578.1667990402674;
        Wed, 09 Nov 2022 02:40:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:b000:3b0e:74a3:bc8:9937? (p200300cbc704b0003b0e74a30bc89937.dip0.t-ipconnect.de. [2003:cb:c704:b000:3b0e:74a3:bc8:9937])
        by smtp.gmail.com with ESMTPSA id bj19-20020a0560001e1300b002302dc43d77sm13047010wrb.115.2022.11.09.02.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 02:40:02 -0800 (PST)
Message-ID: <3e61fb01-5277-80a4-610e-0608475637f8@redhat.com>
Date:   Wed, 9 Nov 2022 11:40:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/5] ksm: support unsharing zero pages placed by KSM
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     xu.xin.sc@gmail.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Xuexin Jiang <jiang.xuexin@zte.com.cn>,
        Xiaokai Ran <ran.xiaokai@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
References: <20221011022006.322158-1-xu.xin16@zte.com.cn>
 <20221011022215.322269-1-xu.xin16@zte.com.cn>
 <92a38ccc-273c-1c32-6305-09bd4f215550@redhat.com>
 <07eb01c0-3702-7446-11ed-bab2fbb68cc2@redhat.com>
Organization: Red Hat
In-Reply-To: <07eb01c0-3702-7446-11ed-bab2fbb68cc2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.22 14:54, David Hildenbrand wrote:
> On 21.10.22 12:17, David Hildenbrand wrote:
>> On 11.10.22 04:22, xu.xin.sc@gmail.com wrote:
>>> From: xu xin <xu.xin16@zte.com.cn>
>>>
>>> use_zero_pages may be very useful, not just because of cache colouring
>>> as described in doc, but also because use_zero_pages can accelerate
>>> merging empty pages when there are plenty of empty pages (full of zeros)
>>> as the time of page-by-page comparisons (unstable_tree_search_insert) is
>>> saved.
>>>
>>> But when enabling use_zero_pages, madvise(addr, len, MADV_UNMERGEABLE) and
>>> other ways (like write 2 to /sys/kernel/mm/ksm/run) to trigger unsharing
>>> will *not* unshare the shared zeropage as placed by KSM (which may be
>>> against the MADV_UNMERGEABLE documentation at least).
>>>
>>> To not blindly unshare all shared zero_pages in applicable VMAs, the patch
>>> introduces a dedicated flag ZERO_PAGE_FLAG to mark the rmap_items of those
>>> shared zero_pages. and guarantee that these rmap_items will be not freed
>>> during the time of zero_pages not being writing, so we can only unshare
>>> the *KSM-placed* zero_pages.
>>>
>>> The patch will not degrade the performance of use_zero_pages as it doesn't
>>> change the way of merging empty pages in use_zero_pages's feature.
>>>
>>> Fixes: e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with colouring")
>>> Reported-by: David Hildenbrand <david@redhat.com>
>>> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
>>> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
>>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>>> Co-developed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
>>> Signed-off-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
>>> Co-developed-by: Yang Yang <yang.yang29@zte.com.cn>
>>> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
>>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>>> ---
>>>     mm/ksm.c | 136 ++++++++++++++++++++++++++++++++++++++++++-------------
>>>     1 file changed, 105 insertions(+), 31 deletions(-)
>>>
>>> diff --git a/mm/ksm.c b/mm/ksm.c
>>> index 13c60f1071d8..e351d7b6d15e 100644
>>> --- a/mm/ksm.c
>>> +++ b/mm/ksm.c
>>> @@ -213,6 +213,7 @@ struct ksm_rmap_item {
>>>     #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
>>>     #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
>>>     #define STABLE_FLAG	0x200	/* is listed from the stable tree */
>>> +#define ZERO_PAGE_FLAG 0x400 /* is zero page placed by KSM */
>>>     
>>>     /* The stable and unstable tree heads */
>>>     static struct rb_root one_stable_tree[1] = { RB_ROOT };
>>> @@ -381,14 +382,6 @@ static inline struct ksm_rmap_item *alloc_rmap_item(void)
>>>     	return rmap_item;
>>>     }
>>>     
>>> -static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
>>> -{
>>> -	ksm_rmap_items--;
>>> -	rmap_item->mm->ksm_rmap_items--;
>>> -	rmap_item->mm = NULL;	/* debug safety */
>>> -	kmem_cache_free(rmap_item_cache, rmap_item);
>>> -}
>>> -
>>>     static inline struct ksm_stable_node *alloc_stable_node(void)
>>>     {
>>>     	/*
>>> @@ -420,7 +413,8 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>>>     }
>>>     
>>>     /*
>>> - * We use break_ksm to break COW on a ksm page: it's a stripped down
>>> + * We use break_ksm to break COW on a ksm page or KSM-placed zero page (only
>>> + * happen when enabling use_zero_pages): it's a stripped down
>>>      *
>>>      *	if (get_user_pages(addr, 1, FOLL_WRITE, &page, NULL) == 1)
>>>      *		put_page(page);
>>> @@ -434,7 +428,8 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>>>      * of the process that owns 'vma'.  We also do not want to enforce
>>>      * protection keys here anyway.
>>>      */
>>> -static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>>> +static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
>>> +				     bool ksm_check_bypass)
>>>     {
>>>     	struct page *page;
>>>     	vm_fault_t ret = 0;
>>> @@ -449,6 +444,16 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>>>     			ret = handle_mm_fault(vma, addr,
>>>     					      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
>>>     					      NULL);
>>> +		else if (ksm_check_bypass && is_zero_pfn(page_to_pfn(page))) {
>>> +			/*
>>> +			 * Although it's not ksm page, it's zero page as placed by
>>> +			 * KSM use_zero_page, so we should unshare it when
>>> +			 * ksm_check_bypass is true.
>>> +			 */
>>> +			ret = handle_mm_fault(vma, addr,
>>> +						  FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
>>> +						  NULL);
>>> +		}
>>
>> Please don't duplicate that page fault triggering code.
>>
>> Also, please be aware that this collides with
>>
>> https://lkml.kernel.org/r/20221021101141.84170-1-david@redhat.com
>>
>> Adjustments should be comparatively easy.
> 
> ... except that I'm still working on FAULT_FLAG_UNSHARE support for the
> shared zeropage. That will be posted soonish (within next 2 weeks).
> 

Posted: https://lkml.kernel.org/r/20221107161740.144456-1-david@redhat.com

With that, we can use FAULT_FLAG_UNSHARE also to break COW on the shared 
zeropage.

-- 
Thanks,

David / dhildenb

