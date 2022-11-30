Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EA063DAE1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 17:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbiK3QlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 11:41:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiK3Qkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 11:40:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357B4EC38
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669826394;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FibScgnLZTZQVJwSPq/5rFupjljThtgCjtutjs0/d8U=;
        b=e/p1mFqUPLhUr7CPYo4W4ZM/I2dMlsCUoiEnVc50azQg+EVy5hWGA+fMBWMAUtpu2djWWv
        vbny2HxKaM+pkHezGuTWgIiJnlD8Yr9e/CQnLKrqqrhqGv4Hsbz4MEUMRRxyfs3YDwA9JP
        t79dkWPPCtjLSDsSZ4kx8FKFOAelhXw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-613-Gv9LkrGeNHSmQV8l15I9_w-1; Wed, 30 Nov 2022 11:39:53 -0500
X-MC-Unique: Gv9LkrGeNHSmQV8l15I9_w-1
Received: by mail-wm1-f69.google.com with SMTP id u9-20020a05600c00c900b003cfb12839d6so817161wmm.5
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 08:39:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FibScgnLZTZQVJwSPq/5rFupjljThtgCjtutjs0/d8U=;
        b=UtJ1ZzLQQdtD2UPtGPfWr6rx/NbwjrWglhZd/8O/hjNdYDdLhST45nrCZeWMgAgL7v
         r9deghdDGSD9CFE4Qdj+x1mUxK4158trWqB7+SqifZU3E4653zqWqI4f+soRBGfdH4wg
         Jui4MQT7SlK4GqpRDsPADsseeSYGw0mKnmvYyb8VWow7FDAXUDvBPr5ZUVJ5I6w65FH+
         FEYhDNRWrz7fCNuCjXWu6IROyvCGCirYVE2kCpOIfqkBWi+4fMf0X5sRBFSnaxFV/rZa
         T+ljhej4VDBE8ciiMpl2v94cT+KP74Ate6YUxb3gxZb1ytZuS3iqgLfkAEheZ7Lpw9Eb
         zPbg==
X-Gm-Message-State: ANoB5pnRisc5gv4c0mHlGo+boqgMuYTUEIEkJ51Jcqj0uCA1k3GN9OvO
        cEtHoz5y0N2Z+VbMlSnYqr/ByT/roqNSvfTFN1HIOOJ2ROvgb353v3OUnnRKtPiBmG/1neBqTyi
        M47qcxbs+n0y/3uK5z/x/Phta
X-Received: by 2002:a05:600c:3495:b0:3cf:ae53:918f with SMTP id a21-20020a05600c349500b003cfae53918fmr34347032wmq.131.1669826391943;
        Wed, 30 Nov 2022 08:39:51 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4IzXvotDDH3ARJouInxJxra3FD5+ga8g8sHGirbSriZuhOGHjtFxK+lAN+vFsR8EswaedPnA==
X-Received: by 2002:a05:600c:3495:b0:3cf:ae53:918f with SMTP id a21-20020a05600c349500b003cfae53918fmr34347013wmq.131.1669826391634;
        Wed, 30 Nov 2022 08:39:51 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:7600:a8ea:29ce:7ee3:dd41? (p200300cbc7037600a8ea29ce7ee3dd41.dip0.t-ipconnect.de. [2003:cb:c703:7600:a8ea:29ce:7ee3:dd41])
        by smtp.gmail.com with ESMTPSA id u11-20020a5d6acb000000b00241c4bd6c09sm2060024wrw.33.2022.11.30.08.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 08:39:51 -0800 (PST)
Message-ID: <8290e578-9eaa-5859-6309-e62634b66fb5@redhat.com>
Date:   Wed, 30 Nov 2022 17:39:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 09/10] mm/hugetlb: Make page_vma_mapped_walk() safe to pmd
 unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Mike Kravetz <mike.kravetz@oracle.com>
References: <20221129193526.3588187-1-peterx@redhat.com>
 <20221129193526.3588187-10-peterx@redhat.com>
 <65a3a912-3534-6718-2c55-e0d4b5246f1e@redhat.com> <Y4eFq4ZyQ2xHaISy@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y4eFq4ZyQ2xHaISy@x1n>
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

On 30.11.22 17:32, Peter Xu wrote:
> On Wed, Nov 30, 2022 at 05:18:45PM +0100, David Hildenbrand wrote:
>> On 29.11.22 20:35, Peter Xu wrote:
>>> Since page_vma_mapped_walk() walks the pgtable, it needs the vma lock
>>> to make sure the pgtable page will not be freed concurrently.
>>>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    include/linux/rmap.h | 4 ++++
>>>    mm/page_vma_mapped.c | 5 ++++-
>>>    2 files changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>>> index bd3504d11b15..a50d18bb86aa 100644
>>> --- a/include/linux/rmap.h
>>> +++ b/include/linux/rmap.h
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/highmem.h>
>>>    #include <linux/pagemap.h>
>>>    #include <linux/memremap.h>
>>> +#include <linux/hugetlb.h>
>>>    /*
>>>     * The anon_vma heads a list of private "related" vmas, to scan if
>>> @@ -408,6 +409,9 @@ static inline void page_vma_mapped_walk_done(struct page_vma_mapped_walk *pvmw)
>>>    		pte_unmap(pvmw->pte);
>>>    	if (pvmw->ptl)
>>>    		spin_unlock(pvmw->ptl);
>>> +	/* This needs to be after unlock of the spinlock */
>>> +	if (is_vm_hugetlb_page(pvmw->vma))
>>> +		hugetlb_vma_unlock_read(pvmw->vma);
>>>    }
>>>    bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw);
>>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>>> index 93e13fc17d3c..f94ec78b54ff 100644
>>> --- a/mm/page_vma_mapped.c
>>> +++ b/mm/page_vma_mapped.c
>>> @@ -169,10 +169,13 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>>    		if (pvmw->pte)
>>>    			return not_found(pvmw);
>>> +		hugetlb_vma_lock_read(vma);
>>>    		/* when pud is not present, pte will be NULL */
>>>    		pvmw->pte = huge_pte_offset(mm, pvmw->address, size);
>>> -		if (!pvmw->pte)
>>> +		if (!pvmw->pte) {
>>> +			hugetlb_vma_unlock_read(vma);
>>>    			return false;
>>> +		}
>>>    		pvmw->ptl = huge_pte_lock(hstate, mm, pvmw->pte);
>>>    		if (!check_pte(pvmw))
>>
>> Looking at code like  mm/damon/paddr.c:__damon_pa_mkold() and reading the
>> doc of page_vma_mapped_walk(), this might be broken.
>>
>> Can't we get page_vma_mapped_walk() called multiple times?
> 
> Yes it normally can, but not for hugetlbfs?  Feel free to check:
> 
> 	if (unlikely(is_vm_hugetlb_page(vma))) {
>                  ...
> 		/* The only possible mapping was handled on last iteration */
> 		if (pvmw->pte)
> 			return not_found(pvmw);
>          }

Ah, I see, thanks.

Acked-by: David Hildenbrand <david@redhat.com>


-- 
Thanks,

David / dhildenb

