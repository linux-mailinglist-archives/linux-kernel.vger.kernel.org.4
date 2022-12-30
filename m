Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53527659680
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbiL3JDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3JDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:03:16 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6322A11832
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:03:14 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Njzlb6VJdzRqHP;
        Fri, 30 Dec 2022 17:01:47 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 30 Dec 2022 17:03:12 +0800
Message-ID: <d5166c14-ee1f-866d-4c11-8ac0417b78b1@huawei.com>
Date:   Fri, 30 Dec 2022 17:03:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: huge_memory: convert split_huge_pages_all() to use a
 folio
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20221229122503.149083-1-wangkefeng.wang@huawei.com>
 <Y66d6edbCgs6QgMj@casper.infradead.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y66d6edbCgs6QgMj@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/30 16:14, Matthew Wilcox wrote:
> On Thu, Dec 29, 2022 at 08:25:03PM +0800, Kefeng Wang wrote:
>> -			if (!PageHead(page) || PageHuge(page) || !PageLRU(page))
>> +			if (!folio_test_large(folio)
>> +				|| folio_test_hugetlb(folio)
>> +				|| !folio_test_lru(folio))
>>   				goto next;
> 
> That is a completely illegible way of indenting this code!  There's
> no visual cue when the condition stops and when the next statement
> begins.  Try one of these:
> 
sorry about the bad indenting,
> 			if (!folio_test_large(folio) ||
> 			    folio_test_hugetlb(folio) ||
> 			    !folio_test_lru(folio))
> 				goto next;
> 
will resend with this one, thanks for your review.

