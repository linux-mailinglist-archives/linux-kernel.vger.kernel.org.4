Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744E06480EF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 11:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiLIK0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 05:26:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLIKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 05:25:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C3F6ACCB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 02:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670581502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQkKlzVgVNRUgJM+r+np7NVae25JNYpyZIMS2uRgl18=;
        b=CIkrVoLXcu2uZitGMN9OA4wrSKec5LLnwEMu/JxY5HOHoFFFkOVCjVEZBNGeaUxGggD45x
        koW2K1PasEBHHd0RG7XwMNYJmAXD8QGutLRzhFb+Q+BNM8CbOmMpllm4anc0D1RLls7P07
        SKdCF6atD/BMYY5ifkobwLE/15GAz+U=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-384-UYP08fXpP72rzJ3mBK25cw-1; Fri, 09 Dec 2022 05:24:59 -0500
X-MC-Unique: UYP08fXpP72rzJ3mBK25cw-1
Received: by mail-wm1-f71.google.com with SMTP id m17-20020a05600c3b1100b003cf9cc47da5so2182965wms.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 02:24:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQkKlzVgVNRUgJM+r+np7NVae25JNYpyZIMS2uRgl18=;
        b=7/ZK77sgaw7Daabgojo+5z5TA5W1qetqWg881LxNEQcxh1loLPMXc36fTiAcds7hOG
         75W9U09I/S2tW3l5TkhQV8BhWzSCpaIWncg6BbTpq8QUA9sj3KQhepNbHz8Pz+Zf9xvr
         mpBFr1Y8dz7hUrkkmUgI4/AIRGbmMVvbi+HA+20odcu/9zn80dvqsInqJUF8HuS4UqMX
         Ty/wgQlToleUhcdmPmI7mYyC5LppgfSr7dj2qxMXucEBHjHqHwb3P6DpUI/Le3BujOwj
         jk1AetBZOfedXZdFDG6NX8u4+a80Qn9++YwgmnULRzBgozSKy4DvIVWFF1qkvQam2iol
         wlCA==
X-Gm-Message-State: ANoB5pkToT2o+y4MLRfnnR+Zq6DAGDJTaw0b5WoCLCX0c79FsCjDatbD
        LnnmLGEthV/xLVOutIPvntfLzTWWBOkq5uVgH9C+stKYhkJ2+3I3J4jSilLcuCBvnnvfvX3fuMV
        KP9KtL9blJc6PkeRcGUnvrnKC
X-Received: by 2002:a05:600c:a52:b0:3d1:c8c8:fb5 with SMTP id c18-20020a05600c0a5200b003d1c8c80fb5mr4426550wmq.18.1670581497802;
        Fri, 09 Dec 2022 02:24:57 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6AC1MVa49QaExok8ylkg0NtcgJrwaAsIOv2fo5HH8LibrrJIYX3LQh80457QVA8mABIgg0OA==
X-Received: by 2002:a05:600c:a52:b0:3d1:c8c8:fb5 with SMTP id c18-20020a05600c0a5200b003d1c8c80fb5mr4426534wmq.18.1670581497379;
        Fri, 09 Dec 2022 02:24:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c702:2e00:b9ea:114c:a3f5:327e? (p200300cbc7022e00b9ea114ca3f5327e.dip0.t-ipconnect.de. [2003:cb:c702:2e00:b9ea:114c:a3f5:327e])
        by smtp.gmail.com with ESMTPSA id y1-20020a1c4b01000000b003d208eb17ecsm1328703wma.26.2022.12.09.02.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Dec 2022 02:24:56 -0800 (PST)
Message-ID: <72a62bf5-7633-f35f-75fd-0222fd0ab49f@redhat.com>
Date:   Fri, 9 Dec 2022 11:24:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to
 pmd unshare
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        James Houghton <jthoughton@google.com>,
        Jann Horn <jannh@google.com>, Rik van Riel <riel@surriel.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>
References: <20221207203034.650899-1-peterx@redhat.com>
 <20221207203034.650899-9-peterx@redhat.com>
 <a9cbfa20-b83d-203c-85ef-77ffe9445913@redhat.com> <Y5JNXomE5eGo8DyF@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y5JNXomE5eGo8DyF@x1n>
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

On 08.12.22 21:47, Peter Xu wrote:
> On Thu, Dec 08, 2022 at 02:14:42PM +0100, David Hildenbrand wrote:
>> On 07.12.22 21:30, Peter Xu wrote:
>>> Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
>>> to make sure the pgtable page will not be freed concurrently.
>>>
>>> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
>>> Signed-off-by: Peter Xu <peterx@redhat.com>
>>> ---
>>>    arch/s390/mm/gmap.c      |  2 ++
>>>    fs/proc/task_mmu.c       |  2 ++
>>>    include/linux/pagewalk.h | 11 ++++++++++-
>>>    mm/hmm.c                 | 15 ++++++++++++++-
>>>    mm/pagewalk.c            |  2 ++
>>>    5 files changed, 30 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>>> index 8947451ae021..292a54c490d4 100644
>>> --- a/arch/s390/mm/gmap.c
>>> +++ b/arch/s390/mm/gmap.c
>>> @@ -2643,7 +2643,9 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
>>>    	end = start + HPAGE_SIZE - 1;
>>>    	__storage_key_init_range(start, end);
>>>    	set_bit(PG_arch_1, &page->flags);
>>> +	hugetlb_vma_unlock_read(walk->vma);
>>>    	cond_resched();
>>> +	hugetlb_vma_lock_read(walk->vma);
>>>    	return 0;
>>>    }
>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>> index e35a0398db63..cf3887fb2905 100644
>>> --- a/fs/proc/task_mmu.c
>>> +++ b/fs/proc/task_mmu.c
>>> @@ -1613,7 +1613,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>>>    			frame++;
>>>    	}
>>> +	hugetlb_vma_unlock_read(walk->vma);
>>>    	cond_resched();
>>> +	hugetlb_vma_lock_read(walk->vma);
>>
>> We already hold the mmap_lock and reschedule. Even without the
>> cond_resched() we might happily reschedule on a preemptive kernel. So I'm
>> not sure if this optimization is strictly required or even helpful in
>> practice here.
> 
> It's just low hanging fruit if we need that complexity anyway.
> 
> That's also why I didn't do that for v1 (where I missed hmm special case,
> though..), but I think since we'll need that anyway, we'd better release
> the vma lock if we can easily do so.
> 
> mmap_lock is just more special because it needs more work in the caller to
> release (e.g. vma invalidations).  Otherwise I'm happy dropping that too.
> 
>>
>> In the worst case, concurrent unsharing would have to wait.
>> For example, s390_enable_skey() is called at most once for a VM, for most
>> VMs it gets never even called.
>>
>> Or am I missing something important?
> 
> Nothing important.  I just don't see why we need to strictly follow the
> same release rule of mmap_lock here when talking about vma lock.
> 
> In short - if we can drop a lock earlier before sleep, why not?
> 
> I tend to just keep it as-is, but let me know if you have further thoughts
> or concerns.

To me this looks like a possibly unnecessary optimization, requiring 
additional code. IMHO, possibly unnecessary unlock+relock makes thatthat 
code harder to get.

For such cases, it would be good to have any evidence that it really helps.

-- 
Thanks,

David / dhildenb

