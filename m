Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEFA6E0A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjDMJ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjDMJ0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:26:34 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52204106
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:26:32 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PxvHy2kz2z17SHT;
        Thu, 13 Apr 2023 17:22:54 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 17:26:29 +0800
Message-ID: <2797d1c1-34cd-5dab-0db2-84a1bf493716@huawei.com>
Date:   Thu, 13 Apr 2023 17:26:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/2] mm: memory-failure: Refactor add_to_kill()
Content-Language: en-US
To:     =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Longlong Xia <xialonglong1@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "sunnanyong@huawei.com" <sunnanyong@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20230330074501.205092-1-xialonglong1@huawei.com>
 <20230330074501.205092-2-xialonglong1@huawei.com>
 <20230331054142.GA1435482@hori.linux.bs1.fc.nec.co.jp>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230331054142.GA1435482@hori.linux.bs1.fc.nec.co.jp>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/31 13:41, HORIGUCHI NAOYA(堀口 直也) wrote:
> On Thu, Mar 30, 2023 at 03:45:00PM +0800, Longlong Xia wrote:
>> The page_address_in_vma() is used to find the user virtual address of page
>> in add_to_kill(), but it doesn't support ksm due to the ksm page->index
>> unusable, add an addr as parameter to add_to_kill(), let's the caller to
>> pass it, also rename the function to __add_to_kill(), and adding
>> add_to_kill_anon_file() for handling anonymous pages and file pages,
>> adding add_to_kill_fsdax() for handling fsdax pages.
>>
>> Signed-off-by: Longlong Xia <xialonglong1@huawei.com>
>> ---
>>   mm/memory-failure.c | 29 +++++++++++++++++++++--------
>>   1 file changed, 21 insertions(+), 8 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index a1ede7bdce95e..9ca058f659121 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -405,9 +405,9 @@ static unsigned long dev_pagemap_mapping_shift(struct vm_area_struct *vma,
>>    * page->mapping are sufficient for mapping the page back to its
>>    * corresponding user virtual address.
>>    */
>> -static void add_to_kill(struct task_struct *tsk, struct page *p,
>> -			pgoff_t fsdax_pgoff, struct vm_area_struct *vma,
>> -			struct list_head *to_kill)
>> +static void __add_to_kill(struct task_struct *tsk, struct page *p,
>> +			  struct vm_area_struct *vma, struct list_head *to_kill,
>> +			  unsigned long addr, pgoff_t fsdax_pgoff)
> 
> Hi, Longlong,
> 
> The new argument addr seems to be used only from add_to_kill_ksm(),
> so you can name the argument as such (like ksm_addr), as we do
> for fsdax_pgoff (which is clear to be used only for fsdax)?
Another option, move page_address_in_vma() from __add_to_kill() into
add_to_kill_[anon_file/fsdax](), but use ksm_addr is fine with me,

Reviewed-by: Kefeng Wang <wangkefeng.wang@huawei.com>


> 
> Thanks,
> Naoya Horiguchi
