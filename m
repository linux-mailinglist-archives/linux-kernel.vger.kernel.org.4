Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F986607759
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 14:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbiJUMyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 08:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiJUMyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 08:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5317B16
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666356868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Qu9bM/ahIqpq1zoKdEkpkNS5tjo6ta77M3NNw/zjMY=;
        b=CwYNG4YguhjmiAFKG5b+2HPFv7yY7TUVHe4UkcT4/ypIOBQk+qWDorY/hhHSSAzUbxHpFn
        JZsoO44cxzFTGhnjgvSXFFVbPGGCjrSyEByKKPvEdOagi5GEOqmp4zX1W5zu+uBbsQg0FS
        CqLOnI68Uiusghwpcoh6Qa6Si7eF1Ao=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-9-jxP-KN8hNhie9eOzP48kjg-1; Fri, 21 Oct 2022 08:54:27 -0400
X-MC-Unique: jxP-KN8hNhie9eOzP48kjg-1
Received: by mail-wm1-f71.google.com with SMTP id l1-20020a7bc341000000b003bfe1273d6cso451280wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 05:54:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Qu9bM/ahIqpq1zoKdEkpkNS5tjo6ta77M3NNw/zjMY=;
        b=4VV+Wq/d6yaiUbMgK3b0oaMkjZkVumNBahx0Yit23N2oZ+O4CJ1cNbOYD0KtpQUiit
         GXYOeViLHD9coauV0q2rOHpRDxhYAeh8lws0VwOVVuth+aWIsAXGh4JTvzu4TFrqnnlZ
         SLSE7gsvSdH2pO2ysHXcHrmnV6lGT4UzM9HQXWKykGJc7nOeZzH31mOisTMyoEfHx03C
         LofqufziLZR97jqPEOWf/zhqu/ak7klv7sgTLB0XGvfD9NdqrEwi6OolXxtiuh5hVhl9
         Rw28iiqcuEPICdaf8OoUBjeQqZ7pYQgVGNsn6s5+rDCV2J4p8kjhzBShS6l6EKZwZjPP
         NONQ==
X-Gm-Message-State: ACrzQf288st7idly9fBu5pOWZsn9HngFsV+pcnLbIcibBj0SzJ4GSZRm
        8Rc2FB9BsoZGzhujFIkuTUxUjdG8ELq9fPUZXcRBNMUG97bzyE5lO/h6jlV/qSobOVJc1J0jf2k
        GQ/Pl9dMvQdG27CLoXQXoMpeW
X-Received: by 2002:a5d:6504:0:b0:22e:44b0:4cf5 with SMTP id x4-20020a5d6504000000b0022e44b04cf5mr11838953wru.362.1666356864581;
        Fri, 21 Oct 2022 05:54:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM50IKEiJEUnefKIx9fjMl6Gfm/amcquyyV6TcAMib7aQM+Bu46eZiZ5YVaDqDHfxpfLhg0orQ==
X-Received: by 2002:a5d:6504:0:b0:22e:44b0:4cf5 with SMTP id x4-20020a5d6504000000b0022e44b04cf5mr11838940wru.362.1666356864291;
        Fri, 21 Oct 2022 05:54:24 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:1700:e40d:574c:c991:5f78? (p200300cbc7081700e40d574cc9915f78.dip0.t-ipconnect.de. [2003:cb:c708:1700:e40d:574c:c991:5f78])
        by smtp.gmail.com with ESMTPSA id l12-20020adffe8c000000b002356c051b9csm4830999wrr.66.2022.10.21.05.54.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 05:54:23 -0700 (PDT)
Message-ID: <07eb01c0-3702-7446-11ed-bab2fbb68cc2@redhat.com>
Date:   Fri, 21 Oct 2022 14:54:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
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
Organization: Red Hat
In-Reply-To: <92a38ccc-273c-1c32-6305-09bd4f215550@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.10.22 12:17, David Hildenbrand wrote:
> On 11.10.22 04:22, xu.xin.sc@gmail.com wrote:
>> From: xu xin <xu.xin16@zte.com.cn>
>>
>> use_zero_pages may be very useful, not just because of cache colouring
>> as described in doc, but also because use_zero_pages can accelerate
>> merging empty pages when there are plenty of empty pages (full of zeros)
>> as the time of page-by-page comparisons (unstable_tree_search_insert) is
>> saved.
>>
>> But when enabling use_zero_pages, madvise(addr, len, MADV_UNMERGEABLE) and
>> other ways (like write 2 to /sys/kernel/mm/ksm/run) to trigger unsharing
>> will *not* unshare the shared zeropage as placed by KSM (which may be
>> against the MADV_UNMERGEABLE documentation at least).
>>
>> To not blindly unshare all shared zero_pages in applicable VMAs, the patch
>> introduces a dedicated flag ZERO_PAGE_FLAG to mark the rmap_items of those
>> shared zero_pages. and guarantee that these rmap_items will be not freed
>> during the time of zero_pages not being writing, so we can only unshare
>> the *KSM-placed* zero_pages.
>>
>> The patch will not degrade the performance of use_zero_pages as it doesn't
>> change the way of merging empty pages in use_zero_pages's feature.
>>
>> Fixes: e86c59b1b12d ("mm/ksm: improve deduplication of zero pages with colouring")
>> Reported-by: David Hildenbrand <david@redhat.com>
>> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
>> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>> Co-developed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
>> Signed-off-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
>> Co-developed-by: Yang Yang <yang.yang29@zte.com.cn>
>> Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
>> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
>> ---
>>    mm/ksm.c | 136 ++++++++++++++++++++++++++++++++++++++++++-------------
>>    1 file changed, 105 insertions(+), 31 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index 13c60f1071d8..e351d7b6d15e 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -213,6 +213,7 @@ struct ksm_rmap_item {
>>    #define SEQNR_MASK	0x0ff	/* low bits of unstable tree seqnr */
>>    #define UNSTABLE_FLAG	0x100	/* is a node of the unstable tree */
>>    #define STABLE_FLAG	0x200	/* is listed from the stable tree */
>> +#define ZERO_PAGE_FLAG 0x400 /* is zero page placed by KSM */
>>    
>>    /* The stable and unstable tree heads */
>>    static struct rb_root one_stable_tree[1] = { RB_ROOT };
>> @@ -381,14 +382,6 @@ static inline struct ksm_rmap_item *alloc_rmap_item(void)
>>    	return rmap_item;
>>    }
>>    
>> -static inline void free_rmap_item(struct ksm_rmap_item *rmap_item)
>> -{
>> -	ksm_rmap_items--;
>> -	rmap_item->mm->ksm_rmap_items--;
>> -	rmap_item->mm = NULL;	/* debug safety */
>> -	kmem_cache_free(rmap_item_cache, rmap_item);
>> -}
>> -
>>    static inline struct ksm_stable_node *alloc_stable_node(void)
>>    {
>>    	/*
>> @@ -420,7 +413,8 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>>    }
>>    
>>    /*
>> - * We use break_ksm to break COW on a ksm page: it's a stripped down
>> + * We use break_ksm to break COW on a ksm page or KSM-placed zero page (only
>> + * happen when enabling use_zero_pages): it's a stripped down
>>     *
>>     *	if (get_user_pages(addr, 1, FOLL_WRITE, &page, NULL) == 1)
>>     *		put_page(page);
>> @@ -434,7 +428,8 @@ static inline bool ksm_test_exit(struct mm_struct *mm)
>>     * of the process that owns 'vma'.  We also do not want to enforce
>>     * protection keys here anyway.
>>     */
>> -static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>> +static int break_ksm(struct vm_area_struct *vma, unsigned long addr,
>> +				     bool ksm_check_bypass)
>>    {
>>    	struct page *page;
>>    	vm_fault_t ret = 0;
>> @@ -449,6 +444,16 @@ static int break_ksm(struct vm_area_struct *vma, unsigned long addr)
>>    			ret = handle_mm_fault(vma, addr,
>>    					      FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
>>    					      NULL);
>> +		else if (ksm_check_bypass && is_zero_pfn(page_to_pfn(page))) {
>> +			/*
>> +			 * Although it's not ksm page, it's zero page as placed by
>> +			 * KSM use_zero_page, so we should unshare it when
>> +			 * ksm_check_bypass is true.
>> +			 */
>> +			ret = handle_mm_fault(vma, addr,
>> +						  FAULT_FLAG_WRITE | FAULT_FLAG_REMOTE,
>> +						  NULL);
>> +		}
> 
> Please don't duplicate that page fault triggering code.
> 
> Also, please be aware that this collides with
> 
> https://lkml.kernel.org/r/20221021101141.84170-1-david@redhat.com
> 
> Adjustments should be comparatively easy.

... except that I'm still working on FAULT_FLAG_UNSHARE support for the 
shared zeropage. That will be posted soonish (within next 2 weeks).

-- 
Thanks,

David / dhildenb

