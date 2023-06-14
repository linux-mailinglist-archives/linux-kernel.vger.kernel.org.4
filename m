Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371A572FC46
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:21:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbjFNLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjFNLVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:21:08 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A8EFAC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:21:05 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qh2w62W4NzMn17;
        Wed, 14 Jun 2023 19:17:58 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 14 Jun 2023 19:21:03 +0800
Message-ID: <6acaf695-1c77-c0c6-a1d4-4cc946310997@huawei.com>
Date:   Wed, 14 Jun 2023 19:21:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next 1/2] mm: compaction: convert to use a folio in
 isolate_migratepages_block()
Content-Language: en-US
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <jgowans@amazon.com>,
        <yuzhao@google.com>
References: <20230612143414.186389-1-wangkefeng.wang@huawei.com>
 <ZIcuiHIXsIXKHGFH@casper.infradead.org>
 <99dabd49-16c7-2858-e502-1bb390e13859@huawei.com>
In-Reply-To: <99dabd49-16c7-2858-e502-1bb390e13859@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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



On 2023/6/13 9:53, Kefeng Wang wrote:
> 
> 
> On 2023/6/12 22:41, Matthew Wilcox wrote:
>> On Mon, Jun 12, 2023 at 10:34:13PM +0800, Kefeng Wang wrote:
>>> @@ -959,7 +960,8 @@ isolate_migratepages_block(struct compact_control 
>>> *cc, unsigned long low_pfn,
>>>                    * Hugepage was successfully isolated and placed
>>>                    * on the cc->migratepages list.
>>>                    */
>>> -                low_pfn += compound_nr(page) - 1;
>>> +                folio = page_folio(page);
>>> +                low_pfn += folio_nr_pages(folio) - 1;
>>>                   goto isolate_success_no_list;
>>
>> Why is this safe?  That is, how do we know that the folio can't be
>> dissolved under us at this point, then reallocated and hit the
>> VM_BUG_ON_PGFLAGS(PageTail(page), page) in folio_flags() when we
>> test folio_test_large()?
> 
> This is successfully isolated path, after isolate_hugetlb(),  the folio
> reference is incremented, so I think the folio can't be dissolved here,
> correct me if I am wrong.

Hi Matthew，is it enough for the above conversion from page to folio with 
reference?
