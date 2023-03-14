Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84F96B894D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 05:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbjCNELM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 00:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCNELJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 00:11:09 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A1C8F522
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 21:11:05 -0700 (PDT)
Received: from 30.221.133.100(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VdqYDKL_1678767061)
          by smtp.aliyun-inc.com;
          Tue, 14 Mar 2023 12:11:02 +0800
Message-ID: <db50d82c-07f1-6a87-6960-7810c54f8093@linux.alibaba.com>
Date:   Tue, 14 Mar 2023 12:11:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] mm: compaction: fix the possible deadlock when
 isolating hugetlb pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        osalvador@suse.de, vbabka@suse.cz, william.lam@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1bc1c955b03603c4e14f56dfbbef9f637f18dbbd.1678703534.git.baolin.wang@linux.alibaba.com>
 <a24a86fbae09711e61dc4424aa7aebff718e9995.1678703534.git.baolin.wang@linux.alibaba.com>
 <20230313170838.GA3044@monkey>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20230313170838.GA3044@monkey>
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



On 3/14/2023 1:08 AM, Mike Kravetz wrote:
> On 03/13/23 18:37, Baolin Wang wrote:
>> When trying to isolate a migratable pageblock, it can contain several
>> normal pages or several hugetlb pages (e.g. CONT-PTE 64K hugetlb on arm64)
>> in a pageblock. That means we may hold the lru lock of a normal page to
>> continue to isolate the next hugetlb page by isolate_or_dissolve_huge_page()
>> in the same migratable pageblock.
>>
>> However in the isolate_or_dissolve_huge_page(), it may allocate a new hugetlb
>> page and dissolve the old one by alloc_and_dissolve_hugetlb_folio() if the
>> hugetlb's refcount is zero. That means we can still enter the direct compaction
>> path to allocate a new hugetlb page under the current lru lock, which
>> may cause possible deadlock.
>>
>> To avoid this possible deadlock, we should release the lru lock when trying
>> to isolate a hugetbl page. Moreover it does not make sense to take the lru
>> lock to isolate a hugetlb, which is not in the lru list.
>>
>> Fixes: 369fa227c219 ("mm: make alloc_contig_range handle free hugetlb pages")
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/compaction.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index c9d9ad958e2a..ac8ff152421a 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
> 
> Thanks!
> 
> I suspect holding the lru lock when calling isolate_or_dissolve_huge_page was
> not considered.  However, I wonder if this can really happen in practice?
> 
> Before the code below, there is this:
> 
> 		/*
> 		 * Periodically drop the lock (if held) regardless of its
> 		 * contention, to give chance to IRQs. Abort completely if
> 		 * a fatal signal is pending.
> 		 */
> 		if (!(low_pfn % COMPACT_CLUSTER_MAX)) {
> 			if (locked) {
> 				unlock_page_lruvec_irqrestore(locked, flags);
> 				locked = NULL;
> 			}
> 			...
> 		}
> 
> It would seem that the pfn of a hugetlb page would always be a multiple of
> COMPACT_CLUSTER_MAX so we would drop the lock.  However, I am not sure if
> that is ALWAYS true and would prefer something like the code you suggested.

Well, this is not always true, suppose the CONT-PTE hugetlb on ARM arch, 
which contains 16 contiguous normal pages.

> Did you actually see this deadlock in practice?

I did not see this issue in practice until now, but I think it can be 
triggered from code inspection if trying to isolate a CONT-PTE hugetlb.
