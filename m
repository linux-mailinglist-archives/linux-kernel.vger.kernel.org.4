Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAED9680D7E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbjA3MUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbjA3MUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:20:21 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4EA3B74D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:20:19 -0800 (PST)
Received: from dggpemm500001.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4P56b96w7MzJqcy;
        Mon, 30 Jan 2023 20:15:49 +0800 (CST)
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Mon, 30 Jan 2023 20:20:16 +0800
Message-ID: <13e4e6ee-414e-7e36-5ac1-fa0fa555ba41@huawei.com>
Date:   Mon, 30 Jan 2023 20:20:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] mm: memcg: fix NULL pointer in
 mem_cgroup_track_foreign_dirty()
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Ma Wupeng <mawupeng1@huawei.com>, <shy828301@gmail.com>
References: <20230129024451.121590-1-wangkefeng.wang@huawei.com>
 <20230129134815.21083b65ef3ae4c3e7fae8eb@linux-foundation.org>
 <568c10e8-c225-b3c4-483a-5bb3329de4c5@huawei.com>
 <Y9eEbTXNm0x0IZem@dhcp22.suse.cz>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <Y9eEbTXNm0x0IZem@dhcp22.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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



On 2023/1/30 16:48, Michal Hocko wrote:
> On Mon 30-01-23 09:16:13, Kefeng Wang wrote:
>>
>>
>> On 2023/1/30 5:48, Andrew Morton wrote:
>>> On Sun, 29 Jan 2023 10:44:51 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
>>>
>>>> As commit 18365225f044 ("hwpoison, memcg: forcibly uncharge LRU pages"),
>>>
>>> Merged in 2017.
>>>
>>>> hwpoison will forcibly uncharg a LRU hwpoisoned page, the folio_memcg
>>>> could be NULl, then, mem_cgroup_track_foreign_dirty_slowpath() could
>>>> occurs a NULL pointer dereference, let's do not record the foreign
>>>> writebacks for folio memcg is null in mem_cgroup_track_foreign() to
>>>> fix it.
>>>>
>>>> Reported-by: Ma Wupeng <mawupeng1@huawei.com>
>>>> Fixes: 97b27821b485 ("writeback, memcg: Implement foreign dirty flushing")
>>>
>>> Merged in 2019.
>>>
...
> 
> Just to make sure I understand. The page has been hwpoisoned, uncharged
> but stayed in the page cache so a next page fault on the address has blowned
> up?
> 
> Say we address the NULL memcg case. What is the resulting behavior?
> Doesn't userspace access a poisoned page and get a silend memory
> corruption?

+ Yang Shi

Check previous link[1], seems that it is a known issue, and there is a 
TODO list for storage backed filesystems from Yang.


[1] 
https://lore.kernel.org/all/20211020210755.23964-6-shy828301@gmail.com/T/#m1d40559ca2dcf94396df5369214288f69dec379b
