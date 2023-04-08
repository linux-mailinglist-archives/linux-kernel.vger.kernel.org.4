Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E191B6DB8E5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 06:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjDHEnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 00:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjDHEnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 00:43:14 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3340BB8E
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 21:42:45 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4PtjJD0v7DzKrJw;
        Sat,  8 Apr 2023 12:42:04 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sat, 8 Apr 2023 12:42:42 +0800
Message-ID: <35123e7f-093a-ef90-0c14-befa67bd565c@huawei.com>
Date:   Sat, 8 Apr 2023 12:42:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v5 5/6] mm: convert copy_user_huge_page() to
 copy_user_folio()
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <sidhartha.kumar@oracle.com>, <vishal.moola@gmail.com>,
        <muchun.song@linux.dev>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-6-zhangpeng362@huawei.com>
 <20230406235537.GF14244@monkey>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <20230406235537.GF14244@monkey>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/7 7:55, Mike Kravetz wrote:

> On 03/31/23 17:39, Peng Zhang wrote:
>> From: ZhangPeng <zhangpeng362@huawei.com>
>>
>> Replace copy_user_huge_page() with copy_user_folio(). copy_user_folio()
>> does the same as copy_user_huge_page(), but takes in folios instead of
>> pages. Convert copy_user_gigantic_page() to take in folios.
>> Remove pages_per_huge_page from copy_user_folio(), because we can get
>> that from folio_nr_pages(dst).
>>
>> Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
>> ---
>>   include/linux/mm.h |  7 +++----
>>   mm/hugetlb.c       | 10 ++++------
>>   mm/memory.c        | 28 ++++++++++++++--------------
>>   3 files changed, 21 insertions(+), 24 deletions(-)
> No technical problems with the patch, but ...
>>   
>> @@ -5847,15 +5847,15 @@ static void copy_subpage(unsigned long addr, int idx, void *arg)
>>   			   addr, copy_arg->vma);
>>   }
>>   
>> -void copy_user_huge_page(struct page *dst, struct page *src,
>> -			 unsigned long addr_hint, struct vm_area_struct *vma,
>> -			 unsigned int pages_per_huge_page)
>> +void copy_user_folio(struct folio *dst, struct folio *src,
>> +		      unsigned long addr_hint, struct vm_area_struct *vma)
>>   {
>> +	unsigned int pages_per_huge_page = folio_nr_pages(dst);
>>   	unsigned long addr = addr_hint &
>>   		~(((unsigned long)pages_per_huge_page << PAGE_SHIFT) - 1);
>>   	struct copy_subpage_arg arg = {
>> -		.dst = dst,
>> -		.src = src,
>> +		.dst = &dst->page,
>> +		.src = &src->page,
>>   		.vma = vma,
>>   	};
>>   
> I seem to recall that Matthew suggested changing the function name to
> copy_user_folio.  My only concern is that the name now sounds like a
> general purpose routine for copying folios.  It certainly would work
> for a single page folio, but there is a bunch of unnecessary overhead
> in that case.
>
> That makes me think there should perhaps be an optimized path for single
> page folios that just does copy_user_highpage().  But, the argument addr_hint
> does not make much sense in the single page folio case.  So, I am not
> sure if I agree with leaving large/huge out of the function name.
>
> Just wondering if Matthew has any additional thoughts?

Agreed. In my opinion, it's better to leave large/huge out of the
function name.
Also wondering if Matthew has any additional considerations?

Best Regards,
Peng

