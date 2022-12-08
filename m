Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A07647099
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiLHNPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLHNPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:15:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F43484DDC
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670505288;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bt0mI+NueNF1oGdvpp+UZTOceJ8THEeyXlJD5KoeMbA=;
        b=WLf/MuXW4Sgl6Zq0rViUWtRHbnnn4D7vEfFHIb6g6kCrRe+qVKGg9KUQSdXvkRf+JX35sN
        ThYanO66zEbuvDQnFOo4mTogHTJLM5LcOHnd/uz/ayf1xuYY1NqB1DfOmBzVbu/0q2BnhM
        u3bk2kcFwIeSr68tM27oelXpxCnWO9E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-113-ugUbQtICNZyHDI7Qh3f83Q-1; Thu, 08 Dec 2022 08:14:45 -0500
X-MC-Unique: ugUbQtICNZyHDI7Qh3f83Q-1
Received: by mail-wm1-f69.google.com with SMTP id c126-20020a1c3584000000b003cfffcf7c1aso2414658wma.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 05:14:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bt0mI+NueNF1oGdvpp+UZTOceJ8THEeyXlJD5KoeMbA=;
        b=d9n7Bdz+nz1RlIGdXtB4HygtDcLuju4lcvI70zeKBQW7xBa6ZNwAxDmauh4Jl/O2hm
         1aRjD8flEY5bZMXo7rdEww7hgG0FQjaqE5QxysVJn7vlmIAJ3RKLhWHhuapksc7nxcsi
         rqKL11zwF18dE+2Zol0HRusqrxB9tp9NQmgOh98HwjCh5hbpMYLQcXtYVRRgjQ4Du8cB
         eRqC30dfi432K4hIpbFOMzCue0C4SHvC72JIwO6ZEQWzcwbdIwpOya6UAfHu+cf+Lgja
         WIxqybJ218Laef5IX9CCY3M7y8dUchGlyTbdcAoVqjWP3GXiuvEHk7QqsLk5S36+5r4W
         1coA==
X-Gm-Message-State: ANoB5pk1Rgc6t3q7DF+JI18mmafWVIA+dsUHkhu0rUZVzHtpd4Tm7AhD
        Y5D8aCZRhBASzd2zAL1M6uOCd6UyNs8W+L3T1eHjSEMA0Bl/tzeyyVDen/3rXLe5FneeZ/tEEXA
        S57kf43S+0e9A+ZibfyqHq+MN
X-Received: by 2002:a05:600c:3418:b0:3cf:84e9:e722 with SMTP id y24-20020a05600c341800b003cf84e9e722mr2733723wmp.8.1670505283745;
        Thu, 08 Dec 2022 05:14:43 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6K3viiXjbuYrwpcAvPCLjLFhaitAlUA8gWGgPz/SU8KRfd8EQfZvYDrxNpOvKqfEOj5i5Mwg==
X-Received: by 2002:a05:600c:3418:b0:3cf:84e9:e722 with SMTP id y24-20020a05600c341800b003cf84e9e722mr2733710wmp.8.1670505283396;
        Thu, 08 Dec 2022 05:14:43 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id i1-20020adfaac1000000b002238ea5750csm27528687wrc.72.2022.12.08.05.14.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Dec 2022 05:14:42 -0800 (PST)
Message-ID: <a9cbfa20-b83d-203c-85ef-77ffe9445913@redhat.com>
Date:   Thu, 8 Dec 2022 14:14:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 08/10] mm/hugetlb: Make walk_hugetlb_range() safe to
 pmd unshare
In-Reply-To: <20221207203034.650899-9-peterx@redhat.com>
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

On 07.12.22 21:30, Peter Xu wrote:
> Since walk_hugetlb_range() walks the pgtable, it needs the vma lock
> to make sure the pgtable page will not be freed concurrently.
> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>   arch/s390/mm/gmap.c      |  2 ++
>   fs/proc/task_mmu.c       |  2 ++
>   include/linux/pagewalk.h | 11 ++++++++++-
>   mm/hmm.c                 | 15 ++++++++++++++-
>   mm/pagewalk.c            |  2 ++
>   5 files changed, 30 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 8947451ae021..292a54c490d4 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -2643,7 +2643,9 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
>   	end = start + HPAGE_SIZE - 1;
>   	__storage_key_init_range(start, end);
>   	set_bit(PG_arch_1, &page->flags);
> +	hugetlb_vma_unlock_read(walk->vma);
>   	cond_resched();
> +	hugetlb_vma_lock_read(walk->vma);
>   	return 0;
>   }
>   
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index e35a0398db63..cf3887fb2905 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -1613,7 +1613,9 @@ static int pagemap_hugetlb_range(pte_t *ptep, unsigned long hmask,
>   			frame++;
>   	}
>   
> +	hugetlb_vma_unlock_read(walk->vma);
>   	cond_resched();
> +	hugetlb_vma_lock_read(walk->vma);

We already hold the mmap_lock and reschedule. Even without the 
cond_resched() we might happily reschedule on a preemptive kernel. So 
I'm not sure if this optimization is strictly required or even helpful 
in practice here.

In the worst case, concurrent unsharing would have to wait.
For example, s390_enable_skey() is called at most once for a VM, for 
most VMs it gets never even called.

Or am I missing something important?

-- 
Thanks,

David / dhildenb

