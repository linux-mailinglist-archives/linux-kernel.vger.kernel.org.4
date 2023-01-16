Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F566BCF9
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 12:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjAPLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 06:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjAPLfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 06:35:21 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395141DB95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 03:35:20 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NwVJt6q36znVGf;
        Mon, 16 Jan 2023 19:33:34 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 16 Jan 2023 19:35:16 +0800
Message-ID: <07774400-8e85-e728-b325-4263ec5499b1@huawei.com>
Date:   Mon, 16 Jan 2023 19:35:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH -next 5/7] mm: memory: convert wp_page_copy() to use
 folios
Content-Language: en-US
To:     SeongJae Park <sj@kernel.org>, Lorenzo Stoakes <lstoakes@gmail.com>
CC:     David Hildenbrand <david@redhat.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20230113221606.1370-1-sj@kernel.org>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <20230113221606.1370-1-sj@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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



On 2023/1/14 6:16, SeongJae Park wrote:
> Hello,
> 
> On Fri, 13 Jan 2023 19:04:14 +0000 Lorenzo Stoakes <lstoakes@gmail.com> wrote:
> 
>> On Fri, Jan 13, 2023 at 02:08:36PM +0100, David Hildenbrand wrote:
>>> On 13.01.23 14:01, Marek Szyprowski wrote:
>>>> Hi
>>>>
>>>> On 12.01.2023 09:30, Kefeng Wang wrote:
>>>>> The old_page/new_page are converted to old_folio/new_folio in
>>>>> wp_page_copy(), then replaced related page functions to folio
>>>>> functions.
>>>>>
>>>>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>>>>
>>>> This patch, merged into today's linux-next as commit 9ebae00c8e30 ("mm:
>>>> memory: convert wp_page_copy() to use folios"), causes serious stability
>>>> issues on my ARM based test boards. Here is the example of such crash:
>>>
>>> syzbot is also not happy:
>>>
>>> https://lkml.kernel.org/r/000000000000807c7805f2205df1@google.com
>>>
>>> --
>>> Thanks,
>>>
>>> David / dhildenb
>>>
>>
>> This also completely broke my qemu environment.
> 
> Same to me.
> 
>>
>> In that thread Willy points out that the issue stems from blindly assigning
>> page_folio(old_page) to old_folio without checking whether it is NULL first,
>> therefore triggering a NULL pointer deref.
>>
>> A quick fix would be to put in a check (as shown below) which fixes the issue,
>> but as Willy said, I think we should drop this until it can be fixed in a
>> respin.

Hello all, sorry for the break, thanks all to quick fix and analysis, as 
the patch has be dropped from mm-unstable and next, will resend after 
address some comments from Matthew Wilcox and do more test.
