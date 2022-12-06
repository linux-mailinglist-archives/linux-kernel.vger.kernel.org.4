Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E830643AE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 02:40:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233404AbiLFBkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 20:40:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiLFBkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 20:40:07 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CE2B58
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 17:40:05 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NR30C2fBTzqSh2;
        Tue,  6 Dec 2022 09:35:55 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 6 Dec 2022 09:40:03 +0800
Message-ID: <34a694c8-eb12-757a-05e3-f87f3ba1347a@huawei.com>
Date:   Tue, 6 Dec 2022 09:40:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: add cond_resched() in swapin_walk_pmd_entry()
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <xialonglong1@huawei.com>
References: <20221205140327.72304-1-wangkefeng.wang@huawei.com>
 <20221205130359.2c81c5df0fb777cf55495a02@linux-foundation.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20221205130359.2c81c5df0fb777cf55495a02@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/12/6 5:03, Andrew Morton wrote:
> On Mon, 5 Dec 2022 22:03:27 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>
>> When handle MADV_WILLNEED in madvise(), the soflockup may be occurred
>> in swapin_walk_pmd_entry() if swapin lots of memory on slow device,
>> add a cond_resched() into it to avoid the possible softlockup.
>>
>> ...
>>
>> --- a/mm/madvise.c
>> +++ b/mm/madvise.c
>> @@ -226,6 +226,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
>>   			put_page(page);
>>   	}
>>   	swap_read_unplug(splug);
>> +	cond_resched();
>>   
>>   	return 0;
>>   }
> I wonder if this would be better in walk_pmd_range(), to address other
> very large walk attempts.
mm/madvise.c:287:       walk_page_range(vma->vm_mm, start, end, 
&swapin_walk_ops, vma);
mm/madvise.c:514:       walk_page_range(vma->vm_mm, addr, end, 
&cold_walk_ops, &walk_private);

mm/madvise.c:762:       walk_page_range(vma->vm_mm, range.start, range.end,
mm/madvise.c-763-                       &madvise_free_walk_ops, &tlb);

The cold_walk_ops and madvise_free_walk_ops are already with cond_resched()
in theirs pmd_entry walk, maybe there's no need for a precautionary increase
a cond_resched() for now


>
> .
