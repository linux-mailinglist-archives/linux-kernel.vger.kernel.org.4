Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C7A6DB8E7
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 06:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDHEnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 00:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjDHEni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 00:43:38 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62DACC01
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 21:43:32 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PtjFt0yCHz17KHN;
        Sat,  8 Apr 2023 12:40:02 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 8 Apr 2023 12:43:29 +0800
Message-ID: <a874c84b-4a83-c12f-e064-eab6a792c1e6@huawei.com>
Date:   Sat, 8 Apr 2023 12:43:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 3/6] userfaultfd: convert copy_huge_page_from_user() to
 copy_folio_from_user()
Content-Language: en-US
To:     Vishal Moola <vishal.moola@gmail.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <mike.kravetz@oracle.com>, <sidhartha.kumar@oracle.com>,
        <muchun.song@linux.dev>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-4-zhangpeng362@huawei.com>
 <CAOzc2pzr7VJRdsx1ud_ceBhbu2XP7Ay72jFETtN8eOt5yR7S=Q@mail.gmail.com>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <CAOzc2pzr7VJRdsx1ud_ceBhbu2XP7Ay72jFETtN8eOt5yR7S=Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 10:28, Vishal Moola wrote:

> On Fri, Mar 31, 2023 at 2:41 AM Peng Zhang <zhangpeng362@huawei.com> wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> Replace copy_huge_page_from_user() with copy_folio_from_user().
>> copy_folio_from_user() does the same as copy_huge_page_from_user(), but
>> takes in a folio instead of a page. Convert page_kaddr to kaddr in
>> copy_folio_from_user() to do indenting cleanup.
>>
>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>> Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>>   include/linux/mm.h |  7 +++----
>>   mm/hugetlb.c       |  5 ++---
>>   mm/memory.c        | 26 ++++++++++++--------------
>>   mm/userfaultfd.c   |  6 ++----
>>   4 files changed, 19 insertions(+), 25 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index e249208f8fbe..cf4d773ca506 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3682,10 +3682,9 @@ extern void copy_user_huge_page(struct page *dst, struct page *src,
>>                                  unsigned long addr_hint,
>>                                  struct vm_area_struct *vma,
>>                                  unsigned int pages_per_huge_page);
>> -extern long copy_huge_page_from_user(struct page *dst_page,
>> -                               const void __user *usr_src,
>> -                               unsigned int pages_per_huge_page,
>> -                               bool allow_pagefault);
>> +long copy_folio_from_user(struct folio *dst_folio,
>> +                          const void __user *usr_src,
>> +                          bool allow_pagefault);
>>
>>   /**
>>    * vma_is_special_huge - Are transhuge page-table entries considered special?
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 7e4a80769c9e..aade1b513474 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -6217,9 +6217,8 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
>>                          goto out;
>>                  }
>>
>> -               ret = copy_huge_page_from_user(&folio->page,
>> -                                               (const void __user *) src_addr,
>> -                                               pages_per_huge_page(h), false);
>> +               ret = copy_folio_from_user(folio, (const void __user *) src_addr,
>> +                                          false);
>>
>>                  /* fallback to copy_from_user outside mmap_lock */
>>                  if (unlikely(ret)) {
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 808f354bce65..4976422b6979 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -5868,35 +5868,33 @@ void copy_user_huge_page(struct page *dst, struct page *src,
>>          process_huge_page(addr_hint, pages_per_huge_page, copy_subpage, &arg);
>>   }
>>
>> -long copy_huge_page_from_user(struct page *dst_page,
>> -                               const void __user *usr_src,
>> -                               unsigned int pages_per_huge_page,
>> -                               bool allow_pagefault)
>> +long copy_folio_from_user(struct folio *dst_folio,
>> +                          const void __user *usr_src,
>> +                          bool allow_pagefault)
>>   {
>> -       void *page_kaddr;
>> +       void *kaddr;
>>          unsigned long i, rc = 0;
>> -       unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
>> +       unsigned int nr_pages = folio_nr_pages(dst_folio);
>> +       unsigned long ret_val = nr_pages * PAGE_SIZE;
>>          struct page *subpage;
>>
>> -       for (i = 0; i < pages_per_huge_page; i++) {
>> -               subpage = nth_page(dst_page, i);
>> -               page_kaddr = kmap_local_page(subpage);
>> +       for (i = 0; i < nr_pages; i++) {
>> +               subpage = folio_page(dst_folio, i);
>> +               kaddr = kmap_local_page(subpage);
>>                  if (!allow_pagefault)
>>                          pagefault_disable();
>> -               rc = copy_from_user(page_kaddr,
>> -                               usr_src + i * PAGE_SIZE, PAGE_SIZE);
>> +               rc = copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
>>                  if (!allow_pagefault)
>>                          pagefault_enable();
>> -               kunmap_local(page_kaddr);
>> +               kunmap_local(kaddr);
>>
>>                  ret_val -= (PAGE_SIZE - rc);
>>                  if (rc)
>>                          break;
>>
>> -               flush_dcache_page(subpage);
>> -
>>                  cond_resched();
>>          }
>> +       flush_dcache_folio(dst_folio);
>>          return ret_val;
>>   }
> Moving the flush_dcache_page() outside the loop to be
> flush_dcache_folio() changes the behavior of the function.
>
> Initially, if it fails to copy the entire page, the function breaks out
> of the loop and returns the number of unwritten bytes without
> flushing the page from the cache. Now if it fails, it will still flush
> out the page it failed on, as well as any later pages it may not
> have gotten to yet.

Agreed. If it fails, could we just not flush the folio?
Like this:
long copy_folio_from_user(...)
{
	...
	for (i = 0; i < nr_pages; i++) {
		...
		rc = copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
		...
		ret_val -= (PAGE_SIZE - rc);
		if (rc)
-                       break;
+                       return ret_val;
		cond_resched();
	}
	flush_dcache_folio(dst_folio);
	return ret_val;
}

Thanks for your review.

Best Regards,
Peng

