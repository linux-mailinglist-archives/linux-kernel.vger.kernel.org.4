Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7827B66BC81
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjAPLLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:11:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjAPLLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:11:31 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7796930FB
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:11:30 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4NwTnQ6npQz16N8W;
        Mon, 16 Jan 2023 19:09:46 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 19:11:28 +0800
Message-ID: <8b26ceaa-79b4-4c3e-c37a-e191b3403358@huawei.com>
Date:   Mon, 16 Jan 2023 19:11:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 2/7] mm: memory: convert do_anonymous_page() to use
 a folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20230112083006.163393-1-wangkefeng.wang@huawei.com>
 <20230112083006.163393-3-wangkefeng.wang@huawei.com>
 <Y8F5ulAWxiv8T97r@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y8F5ulAWxiv8T97r@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/1/13 23:33, Matthew Wilcox wrote:
> On Thu, Jan 12, 2023 at 04:30:01PM +0800, Kefeng Wang wrote:
>> Convert do_anonymous_page() to use a folio and replace related functions
>> to folio functions.
> 
> I think this patch has a prerequisite of sorting out
> alloc_zeroed_user_highpage_movable().  That way we can get rid of
> the 'page' variable inside this function altogether.

How about provide a wrapper like 
folio_alloc_zeroed_user_highmem_movable(), but the is a little bit long.

static inline struct folio *
folio_alloc_zeroed_user_highmem_movable(struct vm_area_struct *vma,
                                        unsigned long vaddr)
{
        struct folio *folio = NULL;
        struct page *page;

        page = alloc_zeroed_user_highpage_movable(vma, vaddr);
        if (page)
                folio = page_folio(page);

        return folio;
}


> 
>>   	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
>>   	page_add_new_anon_rmap(page, vma, vmf->address);
> 
> folio_add_new_anon-rmap().

ok, will update.

> 
>> -	lru_cache_add_inactive_or_unevictable(page, vma);
>> +	folio_add_lru_vma(folio, vma);
