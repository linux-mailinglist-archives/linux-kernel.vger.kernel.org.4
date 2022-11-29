Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A11663C0D7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiK2NTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:19:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiK2NTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:19:06 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B09DEE2A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:19:05 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NM2w010vqzRpQ7;
        Tue, 29 Nov 2022 21:18:24 +0800 (CST)
Received: from dggpeml500005.china.huawei.com (7.185.36.59) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 21:19:03 +0800
Received: from [10.174.178.155] (10.174.178.155) by
 dggpeml500005.china.huawei.com (7.185.36.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 29 Nov 2022 21:19:02 +0800
Subject: Re: [QUESTION] memcg page_counter seems broken in MADV_DONTNEED with
 THP enabled
To:     Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        <aarcange@redhat.com>, <hughd@google.com>, <mgorman@suse.de>,
        <cl@gentwo.org>, <n-horiguchi@ah.jp.nec.com>, <zokeefe@google.com>,
        <rientjes@google.com>, Matthew Wilcox <willy@infradead.org>,
        <peterx@redhat.com>,
        "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>,
        <kirill.shutemov@linux.intel.com>, Lu Jialin <lujialin4@huawei.com>
References: <8a2f2644-71d0-05d7-49d8-878aafa99652@huawei.com>
 <CAHbLzkr-eXk8gateN=EmMoBuW3wxoQKTCfJcTRQsQX3QxD+CmA@mail.gmail.com>
 <Y4W+joR1rIug0ydA@dhcp22.suse.cz>
From:   Yongqiang Liu <liuyongqiang13@huawei.com>
Message-ID: <f383dc2c-10b9-6b3d-6ffa-00b35ab52bf4@huawei.com>
Date:   Tue, 29 Nov 2022 21:19:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <Y4W+joR1rIug0ydA@dhcp22.suse.cz>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.155]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500005.china.huawei.com (7.185.36.59)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2022/11/29 16:10, Michal Hocko Ð´µÀ:
> On Mon 28-11-22 12:01:37, Yang Shi wrote:
>> On Sat, Nov 26, 2022 at 5:10 AM Yongqiang Liu <liuyongqiang13@huawei.com> wrote:
>>> Hi,
>>>
>>> We use mm_counter to how much a process physical memory used. Meanwhile,
>>> page_counter of a memcg is used to count how much a cgroup physical
>>> memory used.
>>> If a cgroup only contains a process, they looks almost the same. But with
>>> THP enabled, sometimes memory.usage_in_bytes in memcg may be twice or
>>> more than rss
>>> in proc/[pid]/smaps_rollup as follow:
> [...]
>>> node_page_stat which shows in meminfo was also decreased. the
>>> __split_huge_pmd
>>> seems free no physical memory unless the total THP was free.I am
>>> confused which
>>> one is the true physical memory used of a process.
>> This should be caused by the deferred split of THP. When MADV_DONTNEED
>> is called on the partial of the map, the huge PMD is split, but the
>> THP itself will not be split until the memory pressure is hit (global
>> or memcg limit). So the unmapped sub pages are actually not freed
>> until that point. So the mm counter is decreased due to the zapping
>> but the physical pages are not actually freed then uncharged from
>> memcg.
> Yes, and this is not really bound to THP. Consider a page cache. It can
> be accessed via syscalls when it doesn't correspondent to rss at all
> while it is still charged to a memcg. Or it can be mapped and then later
> unmapped so it disappear from rss while it is still charged until it
> gets reclaimed by the memory pressure. Or it can be an in-memory object
> that is not bound to any process life time (e.g. tmpfs). Or it can be a
> kernel memory charged to a memcg which is not covered by rss because it
> is either not mapped or it is unknown to rss counters.
Thanks ! it's very nice to me.
