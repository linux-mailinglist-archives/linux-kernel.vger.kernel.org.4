Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF766BCB86
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 10:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjCPJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCPJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 05:53:50 -0400
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4268615F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:53:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Ve-ANYQ_1678960387;
Received: from 30.97.48.88(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Ve-ANYQ_1678960387)
          by smtp.aliyun-inc.com;
          Thu, 16 Mar 2023 17:53:08 +0800
Message-ID: <1435450b-f1fb-17f8-1c35-68f27bafcc23@linux.alibaba.com>
Date:   Thu, 16 Mar 2023 17:53:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/2] mm: compaction: consider the number of scanning
 compound pages in isolate fail path
To:     Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org
Cc:     mgorman@techsingularity.net, osalvador@suse.de,
        william.lam@bytedance.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
 <258932e0-a2a6-7f17-014c-05676bfad456@suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <258932e0-a2a6-7f17-014c-05676bfad456@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/15/2023 11:54 PM, Vlastimil Babka wrote:
> On 3/13/23 11:37, Baolin Wang wrote:
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
>> ---
>>   mm/compaction.c | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index 5a9501e0ae01..c9d9ad958e2a 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -587,6 +587,7 @@ static unsigned long isolate_freepages_block(struct compact_control *cc,
>>   				blockpfn += (1UL << order) - 1;
>>   				cursor += (1UL << order) - 1;
>>   			}
>> +			nr_scanned += (1UL << order) - 1;
> 
> I'd rather put it in the block above that tests order < MAX_ORDER. Otherwise
> as the comments say, the value can be bogus as it's racy.

Right, thanks for pointing it out. Will do in next version.

> 
>>   			goto isolate_fail;
>>   		}
>>   
>> @@ -873,9 +874,8 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   			cond_resched();
>>   		}
>>   
>> -		nr_scanned++;
>> -
>>   		page = pfn_to_page(low_pfn);
>> +		nr_scanned += compound_nr(page);
> 
> For the same reason, I'd rather leave the nr_scanned adjustment by order in
> the specific code blocks where we know/think we have a compound or huge page
> and have sanity checked the order/nr_pages, and not add an unchecked
> compound_nr() here.

OK. Sound reasonable to me. Thanks for your input.

>>   		/*
>>   		 * Check if the pageblock has already been marked skipped.
>> @@ -1077,6 +1077,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   			 */
>>   			if (unlikely(PageCompound(page) && !cc->alloc_contig)) {
>>   				low_pfn += compound_nr(page) - 1;
>> +				nr_scanned += compound_nr(page) - 1;
>>   				SetPageLRU(page);
>>   				goto isolate_fail_put;
>>   			}
>> @@ -1097,7 +1098,6 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   isolate_success_no_list:
>>   		cc->nr_migratepages += compound_nr(page);
>>   		nr_isolated += compound_nr(page);
>> -		nr_scanned += compound_nr(page) - 1;
>>   
>>   		/*
>>   		 * Avoid isolating too much unless this block is being
