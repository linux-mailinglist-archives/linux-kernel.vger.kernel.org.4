Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D14C5EC11C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 13:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232056AbiI0LXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 07:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiI0LWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 07:22:36 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0AD138F18
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 04:21:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=xhao@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VQrxzwn_1664277669;
Received: from 30.240.98.177(mailfrom:xhao@linux.alibaba.com fp:SMTPD_---0VQrxzwn_1664277669)
          by smtp.aliyun-inc.com;
          Tue, 27 Sep 2022 19:21:11 +0800
Message-ID: <393d6318-aa38-01ed-6ad8-f9eac89bf0fc@linux.alibaba.com>
Date:   Tue, 27 Sep 2022 19:21:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [RFC 0/6] migrate_pages(): batch TLB flushing
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Zi Yan <ziy@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Oscar Salvador <osalvador@suse.de>,
        Matthew Wilcox <willy@infradead.org>, yangyicong@hisilicon.com,
        v-songbaohua@oppo.com, 21cnbao@gmail.com
References: <20220921060616.73086-1-ying.huang@intel.com>
From:   haoxin <xhao@linux.alibaba.com>
In-Reply-To: <20220921060616.73086-1-ying.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,  Huang

在 2022/9/21 下午2:06, Huang Ying 写道:
> From: "Huang, Ying" <ying.huang@intel.com>
>
> Now, migrate_pages() migrate pages one by one, like the fake code as
> follows,
>
>    for each page
>      unmap
>      flush TLB
>      copy
>      restore map
>
> If multiple pages are passed to migrate_pages(), there are
> opportunities to batch the TLB flushing and copying.  That is, we can
> change the code to something as follows,
>
>    for each page
>      unmap
>    for each page
>      flush TLB
>    for each page
>      copy
>    for each page
>      restore map
>
> The total number of TLB flushing IPI can be reduced considerably.  And
> we may use some hardware accelerator such as DSA to accelerate the
> page copying.
>
> So in this patch, we refactor the migrate_pages() implementation and
> implement the TLB flushing batching.  Base on this, hardware
> accelerated page copying can be implemented.
>
> If too many pages are passed to migrate_pages(), in the naive batched
> implementation, we may unmap too many pages at the same time.  The
> possibility for a task to wait for the migrated pages to be mapped
> again increases.  So the latency may be hurt.  To deal with this
> issue, the max number of pages be unmapped in batch is restricted to
> no more than HPAGE_PMD_NR.  That is, the influence is at the same
> level of THP migration.
>
> We use the following test to measure the performance impact of the
> patchset,
>
> On a 2-socket Intel server,
>
>   - Run pmbench memory accessing benchmark
>
>   - Run `migratepages` to migrate pages of pmbench between node 0 and
>     node 1 back and forth.
>
As the pmbench can not run on arm64 machine, so i use lmbench instead.
I test case like this:  (i am not sure whether it is reasonable, but it seems worked)
./bw_mem -N10000 10000m rd &
time migratepages pid node0 node1

o/patch      		w/patch
real	0m0.035s  	real	0m0.024s
user	0m0.000s  	user	0m0.000s
sys	0m0.035s        sys	0m0.024s

the migratepages time is reduced above 32%.

But there has a problem, i see the batch flush is called by
migrate_pages_batch
	try_to_unmap_flush
		arch_tlbbatch_flush(&tlb_ubc->arch); // there batch flush really work.

But in arm64, the arch_tlbbatch_flush are not supported, becasue it not support CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH yet.

So, the tlb batch flush means no any flush is did, it is a empty func.

Maybe this patch can help solve this problem.
https://lore.kernel.org/linux-arm-kernel/20220921084302.43631-1-yangyicong@huawei.com/T/
		



