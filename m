Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375B06D1CA5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbjCaJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbjCaJiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:38:51 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A7CC10E4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:38:39 -0700 (PDT)
Received: from kwepemm600020.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PnwBH3p0yz17QQG;
        Fri, 31 Mar 2023 17:35:19 +0800 (CST)
Received: from [10.174.179.160] (10.174.179.160) by
 kwepemm600020.china.huawei.com (7.193.23.147) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 31 Mar 2023 17:38:36 +0800
Message-ID: <c79c1066-15a8-34d5-df36-7bd1de9d311d@huawei.com>
Date:   Fri, 31 Mar 2023 17:38:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 5/6] mm: convert copy_user_huge_page() to
 copy_user_folio()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <vishal.moola@gmail.com>, <muchun.song@linux.dev>,
        <sidhartha.kumar@oracle.com>, <wangkefeng.wang@huawei.com>,
        <sunnanyong@huawei.com>
References: <20230330134045.375163-1-zhangpeng362@huawei.com>
 <20230330134045.375163-6-zhangpeng362@huawei.com>
 <ZCXRzfUKZUgPiscf@casper.infradead.org>
From:   "zhangpeng (AS)" <zhangpeng362@huawei.com>
In-Reply-To: <ZCXRzfUKZUgPiscf@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.160]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600020.china.huawei.com (7.193.23.147)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/31 2:15, Matthew Wilcox wrote:

> On Thu, Mar 30, 2023 at 09:40:44PM +0800, Peng Zhang wrote:
>> +void copy_user_folio(struct folio *dst, struct folio *src,
>> +		      unsigned long addr_hint,
>> +		      struct vm_area_struct *vma,
>> +		      unsigned int pages_per_huge_page);
> Do we really want to pass in pages_per_huge_page here?  We can get
> that from folio_nr_pages(dst).

Agreed. It's not necessary to pass in pages_per_huge_page. I'll remove
it in a v5.

>> +++ b/mm/hugetlb.c
>> @@ -5097,8 +5097,8 @@ int copy_hugetlb_page_range(struct mm_struct *dst, struct mm_struct *src,
>>   					ret = PTR_ERR(new_folio);
>>   					break;
>>   				}
>> -				copy_user_huge_page(&new_folio->page, ptepage, addr, dst_vma,
>> -						    npages);
>> +				copy_user_folio(new_folio, page_folio(ptepage), addr, dst_vma,
>> +						npages);
>>   				put_page(ptepage);
> This function should be converted to s/ptepage/pte_folio/, but that's
> not for this patch series.

Appreciate your suggestion. I'll convert this function in a future patch
set.

>> -	copy_user_huge_page(&new_folio->page, old_page, address, vma,
>> -			    pages_per_huge_page(h));
>> +	copy_user_folio(new_folio, page_folio(old_page), address, vma,
>> +			pages_per_huge_page(h));
> Likewise for s/old_page/old_folio/

Will also convert this.

Best Regards,
Peng

