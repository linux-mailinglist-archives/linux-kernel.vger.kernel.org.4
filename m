Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC40872D72F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 03:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238818AbjFMBxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 21:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238874AbjFMBxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 21:53:11 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3684D19A7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 18:53:06 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4QgBQC0R56zTlNd;
        Tue, 13 Jun 2023 09:52:35 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 09:53:03 +0800
Message-ID: <99dabd49-16c7-2858-e502-1bb390e13859@huawei.com>
Date:   Tue, 13 Jun 2023 09:53:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next 1/2] mm: compaction: convert to use a folio in
 isolate_migratepages_block()
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <jgowans@amazon.com>,
        <yuzhao@google.com>
References: <20230612143414.186389-1-wangkefeng.wang@huawei.com>
 <ZIcuiHIXsIXKHGFH@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZIcuiHIXsIXKHGFH@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/6/12 22:41, Matthew Wilcox wrote:
> On Mon, Jun 12, 2023 at 10:34:13PM +0800, Kefeng Wang wrote:
>> @@ -959,7 +960,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   				 * Hugepage was successfully isolated and placed
>>   				 * on the cc->migratepages list.
>>   				 */
>> -				low_pfn += compound_nr(page) - 1;
>> +				folio = page_folio(page);
>> +				low_pfn += folio_nr_pages(folio) - 1;
>>   				goto isolate_success_no_list;
> 
> Why is this safe?  That is, how do we know that the folio can't be
> dissolved under us at this point, then reallocated and hit the
> VM_BUG_ON_PGFLAGS(PageTail(page), page) in folio_flags() when we
> test folio_test_large()?

This is successfully isolated path, after isolate_hugetlb(),  the folio
reference is incremented, so I think the folio can't be dissolved here,
correct me if I am wrong.

> 
>> @@ -1132,30 +1137,30 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   			 * and it's on LRU. It can only be a THP so the order
>>   			 * is safe to read and it's 0 for tail pages.
>>   			 */
> 
> ^^^ This comment needs to be updated too.
will update
> 
>> -		mod_node_page_state(page_pgdat(page),
>> -				NR_ISOLATED_ANON + page_is_file_lru(page),
>> -				thp_nr_pages(page));
>> +		lruvec_del_folio(lruvec, folio);
>> +		mod_node_page_state(folio_pgdat(folio),
>> +				NR_ISOLATED_ANON + folio_is_file_lru(folio),
>> +				folio_nr_pages(folio));
> 
> 		node_stat_mod_folio()
> ok

Thanks


> 
