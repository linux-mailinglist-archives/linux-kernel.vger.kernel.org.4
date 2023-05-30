Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5190071559D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjE3GkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjE3GkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:40:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238EAB2
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:40:17 -0700 (PDT)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QVjQ14Zy4zsSZP;
        Tue, 30 May 2023 14:38:01 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 14:40:14 +0800
Message-ID: <0a4221cf-3703-27ff-fbdc-d7c419c5020c@huawei.com>
Date:   Tue, 30 May 2023 14:40:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH -next] mm: page_alloc: simplify has_managed_dma()
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>
References: <20230529144022.42927-1-wangkefeng.wang@huawei.com>
 <ZHS2AgVvrT3n/hlM@casper.infradead.org>
 <38ea4ea3-cd7f-abf4-e992-2f748e3b1fcb@huawei.com>
 <ZHV5JCINq6fc/SG9@MiWiFi-R3L-srv>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <ZHV5JCINq6fc/SG9@MiWiFi-R3L-srv>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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



On 2023/5/30 12:18, Baoquan He wrote:
> On 05/30/23 at 10:10am, Kefeng Wang wrote:
>>
>>
>> On 2023/5/29 22:26, Matthew Wilcox wrote:
>>> On Mon, May 29, 2023 at 10:40:22PM +0800, Kefeng Wang wrote:
>>>> The ZONE_DMA should only exists on Node 0, only check NODE_DATA(0)
>>>> is enough, so simplify has_managed_dma() and make it inline.
>>>
>>> That's true on x86, but is it true on all architectures?
>>
>> There is no document about numa node info for the DMA_ZONE, + Mike
>>
>> I used 'git grep -w ZONE_DMA arch/'
> 
> willy is right. max_zone_pfn can only limit the range of zone, but
> can't decide which zone is put on which node. The memory layout is
> decided by firmware. I searched commit log to get below commit which
> can give a good example.
> 
> commit c1d0da83358a2316d9be7f229f26126dbaa07468
> Author: Laurent Dufour <ldufour@linux.ibm.com>
> Date:   Fri Sep 25 21:19:28 2020 -0700
> 
>      mm: replace memmap_context by meminit_context
>      
>      Patch series "mm: fix memory to node bad links in sysfs", v3.
>      
>      Sometimes, firmware may expose interleaved memory layout like this:
>      
>       Early memory node ranges
>         node   1: [mem 0x0000000000000000-0x000000011fffffff]
>         node   2: [mem 0x0000000120000000-0x000000014fffffff]
>         node   1: [mem 0x0000000150000000-0x00000001ffffffff]
>         node   0: [mem 0x0000000200000000-0x000000048fffffff]
>         node   2: [mem 0x0000000490000000-0x00000007ffffffff]

Oh, it looks strange, but it do occur if firmware report as this way.

Thanks Willy and Baoquan, please ignore the patch.
