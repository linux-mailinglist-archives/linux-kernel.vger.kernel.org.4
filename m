Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38CE6C5D62
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:45:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCWDo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjCWDox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:44:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC2E2B618
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 20:44:52 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PhrmN1XTBzrVCt;
        Thu, 23 Mar 2023 11:43:48 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 11:44:49 +0800
Message-ID: <caa178fa-e183-48ba-bdf4-2ea001f4b566@huawei.com>
Date:   Thu, 23 Mar 2023 11:44:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
Subject: Re: [PATCH v2 0/3] userfaultfd: convert userfaultfd functions to use
 folios
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <vishal.moola@gmail.com>, <sidhartha.kumar@oracle.com>,
        <wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
References: <20230314131350.924377-1-zhangpeng362@huawei.com>
 <ZBB1YxPmze070Ltb@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <ZBB1YxPmze070Ltb@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/14 21:23, Matthew Wilcox wrote:

> On Tue, Mar 14, 2023 at 01:13:47PM +0000, Peng Zhang wrote:
>> From: ZhangPeng<zhangpeng362@huawei.com>
>>
>> This patch series converts several userfaultfd functions to use folios.
>> And this series pass the userfaultfd selftests and the LTP userfaultfd
>> test cases.
> That's what you said about the earlier patchset too.  Assuming you
> ran the tests, they need to be improved to fid the bug that was in the
> earlier version of the patches.

I did run the tests both times before sending the patches. However, the
bug in the earlier version patches[1] is a hard corner case[2] to
trigger. To trigger it, we need to call copy_large_folio_from_user()
with allow_pagefault == true, which requires hugetlb_mcopy_atomic_pte()
to return -ENOENT. This means that calling copy_large_folio_from_user()
with allow_pagefault == false failed, i.e. copy_from_user() failed.
Building a self-test that copy_from_user() fails could be difficult.

__mcopy_atomic()
	__mcopy_atomic_hugetlb()
		hugetlb_mcopy_atomic_pte()
			copy_large_folio_from_user(..., ..., false);
			// if ret_val > 0, return -ENOENT
				copy_from_user()
				// copy_from_user() needs to fail
		if (err == -ENOENT) copy_large_folio_from_user(..., ..., true);


[1] https://lore.kernel.org/all/20230314033734.481904-3-zhangpeng362@huawei.com/

> -long copy_huge_page_from_user(struct page *dst_page,
> +long copy_large_folio_from_user(struct folio *dst_folio,
>   				const void __user *usr_src,
> -				unsigned int pages_per_huge_page,
>   				bool allow_pagefault)
>   {
>   	void *page_kaddr;
>   	unsigned long i, rc = 0;
> -	unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
> +	unsigned int nr_pages = folio_nr_pages(dst_folio);
> +	unsigned long ret_val = nr_pages * PAGE_SIZE;
>   	struct page *subpage;
> +	struct folio *inner_folio;
>   
> -	for (i = 0; i < pages_per_huge_page; i++) {
> -		subpage = nth_page(dst_page, i);
> +	for (i = 0; i < nr_pages; i++) {
> +		subpage = folio_page(dst_folio, i);
> +		inner_folio = page_folio(subpage);
>   		if (allow_pagefault)
> -			page_kaddr = kmap(subpage);
> +			page_kaddr = kmap_local_folio(inner_folio, 0);
>   		else
>   			page_kaddr = kmap_atomic(subpage);
>   		rc = copy_from_user(page_kaddr,
>   				usr_src + i * PAGE_SIZE, PAGE_SIZE);
>   		if (allow_pagefault)
> -			kunmap(subpage);
> +			kunmap_local(page_kaddr);
>   		else
>   			kunmap_atomic(page_kaddr);


Thanks,
Peng.

