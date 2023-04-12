Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B096C6DE9D3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 05:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjDLDPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 23:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjDLDPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 23:15:15 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CB4524B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 20:15:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VfuWQdr_1681269309;
Received: from 30.97.48.75(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VfuWQdr_1681269309)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 11:15:10 +0800
Message-ID: <80c53bfc-891d-af09-9b69-2954d7fe625e@linux.alibaba.com>
Date:   Wed, 12 Apr 2023 11:15:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 1/2] mm: compaction: consider the number of scanning
 compound pages in isolate fail path
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     akpm@linux-foundation.org, osalvador@suse.de, vbabka@suse.cz,
        william.lam@bytedance.com, mike.kravetz@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <73d6250a90707649cc010731aedc27f946d722ed.1678962352.git.baolin.wang@linux.alibaba.com>
 <20230405103141.yu7p53psbvstv6kg@techsingularity.net>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230405103141.yu7p53psbvstv6kg@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/2023 6:31 PM, Mel Gorman wrote:
> On Thu, Mar 16, 2023 at 07:06:46PM +0800, Baolin Wang wrote:
>> The commit b717d6b93b54 ("mm: compaction: include compound page count
>> for scanning in pageblock isolation") had added compound page statistics
>> for scanning in pageblock isolation, to make sure the number of scanned
>> pages are always larger than the number of isolated pages when isolating
>> mirgratable or free pageblock.
>>
>> However, when failed to isolate the pages when scanning the mirgratable or
>> free pageblock, the isolation failure path did not consider the scanning
>> statistics of the compound pages, which can show the incorrect number of
>> scanned pages in tracepoints or the vmstats to make people confusing about
>> the page scanning pressure in memory compaction.
>>
>> Thus we should take into account the number of scanning pages when failed
>> to isolate the compound pages to make the statistics accurate.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> 
> Acked-by: Mel Gorman <mgorman@techsingularity.net>

Thanks Mel.

> 
> However, the patch highlights weakeness in the tracepoints and how
> useful they are.
> 
> Minimally, I think that the change might be misleading when comparing
> tracepoints across kernel versions as it'll be necessary to check the exact
> meaning of nr_scanned for a given kernel version. That's not a killer problem
> as such, just a hazard if using an analysis tool comparing kernel versions.
> 
> As an example, consider this
> 
>                  if (PageCompound(page)) {
>                          const unsigned int order = compound_order(page);
>                                  
>                          if (likely(order < MAX_ORDER)) {
>                                  blockpfn += (1UL << order) - 1;
>                                  cursor += (1UL << order) - 1;
> 				nr_scanned += compound_nr(page) - 1;		 <<< patch adds
>                          }
>                          goto isolate_fail;
>                  }
> 
> Only the head page is "scanned", the tail pages are not scanned so
> accounting for them as "scanned" is not an accurate reflection of the
> amount of work done. Isolation is different because the compound pages
> isolated is a prediction of how much work is necessary to migrate that
> page as it's obviously more work to copy 2M of data than 4K. The migrated
> pages combined with isolation then can measure efficiency of isolation
> vs migration although imperfectly as isolation is a span while migration
> probably fails at the head page.
> 
> The same applies when skipping buddies, the tail pages are not scanned
> so skipping them is not additional work.
> 
> Everything depends on what the tracepoint is being used for. If it's a
> measure of work done, then accounting for skipped tail pages over-estimates
> the amount of work. However, if the intent is to measure efficiency of
> isolation vs migration then the "span" scanned is more useful.

Yes, we are more concered about the efficiency of isolation vs migration.

> None of this kills the patch, it only notes that the tracepoints as-is
> probably cannot answer all relevant questions, most of which are only
> relevant when making a modification to compaction in general. The patch
> means that an unspecified pressure metric can be derived (maybe interesting
> to sysadmins) but loses a metric about time spent on scanning (maybe
> interesting to developers writing a patch). Of those concerns, sysadmins
> are probably more common so the patch is acceptable but some care will be
> need if modifying the tracepoints further if it enables one type of
> analysis at the cost of another.

I learned, and thanks for your excellent explaination.
