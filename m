Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63D35730DCE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 05:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbjFOD6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 23:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjFOD6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:58:45 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515802122
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 20:58:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0Vl8reEi_1686801520;
Received: from 30.97.48.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Vl8reEi_1686801520)
          by smtp.aliyun-inc.com;
          Thu, 15 Jun 2023 11:58:41 +0800
Message-ID: <5f340d98-4ee0-35a9-58ed-943834d68042@linux.alibaba.com>
Date:   Thu, 15 Jun 2023 11:59:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2] mm: compaction: skip memory hole rapidly when
 isolating migratable pages
To:     "Huang, Ying" <ying.huang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>, david@redhat.com
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <770f9f61472b24b6bc89adbd71a77d9cf62bb54f.1686646361.git.baolin.wang@linux.alibaba.com>
 <20230614095501.m4porztaibchrgwx@techsingularity.net>
 <87ilbpo1d9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <87ilbpo1d9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/2023 11:22 AM, Huang, Ying wrote:
> Hi, Mel,
> 
> Mel Gorman <mgorman@techsingularity.net> writes:
> 
>> On Tue, Jun 13, 2023 at 04:55:04PM +0800, Baolin Wang wrote:
>>> On some machines, the normal zone can have a large memory hole like
>>> below memory layout, and we can see the range from 0x100000000 to
>>> 0x1800000000 is a hole. So when isolating some migratable pages, the
>>> scanner can meet the hole and it will take more time to skip the large
>>> hole. From my measurement, I can see the isolation scanner will take
>>> 80us ~ 100us to skip the large hole [0x100000000 - 0x1800000000].
>>>
>>> So adding a new helper to fast search next online memory section
>>> to skip the large hole can help to find next suitable pageblock
>>> efficiently. With this patch, I can see the large hole scanning only
>>> takes < 1us.
>>>
>>> [    0.000000] Zone ranges:
>>> [    0.000000]   DMA      [mem 0x0000000040000000-0x00000000ffffffff]
>>> [    0.000000]   DMA32    empty
>>> [    0.000000]   Normal   [mem 0x0000000100000000-0x0000001fa7ffffff]
>>> [    0.000000] Movable zone start for each node
>>> [    0.000000] Early memory node ranges
>>> [    0.000000]   node   0: [mem 0x0000000040000000-0x0000000fffffffff]
>>> [    0.000000]   node   0: [mem 0x0000001800000000-0x0000001fa3c7ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa3c80000-0x0000001fa3ffffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa4000000-0x0000001fa402ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa4030000-0x0000001fa40effff]
>>> [    0.000000]   node   0: [mem 0x0000001fa40f0000-0x0000001fa73cffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa73d0000-0x0000001fa745ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7460000-0x0000001fa746ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7470000-0x0000001fa758ffff]
>>> [    0.000000]   node   0: [mem 0x0000001fa7590000-0x0000001fa7ffffff]
>>>
>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>
>> This may only be necessary for non-contiguous zones so a check for
>> zone_contiguous could be made but I suspect the saving, if any, would be
>> marginal.
>>
>> However, it's subtle that block_end_pfn can end up in an arbirary location
>> past the end of the zone or past cc->free_pfn. As the "continue" will update
>> cc->migrate_pfn, that might lead to errors in the future. It would be a
>> lot safer to pass in cc->free_pfn and do two things with the value. First,
>> there is no point scanning for a valid online section past cc->free_pfn so
>> terminating after cc->free_pfn may save some cycles. Second, cc->migrate_pfn
>> does not end up with an arbitrary value which is a more defensive approach
>> to any future programming errors.
> 
> I have thought about this before.  Originally, I had thought that we
> were safe because cc->free_pfn should be in a online section and
> block_end_pfn should reach cc->free_pfn before the end of zone.  But
> after checking more code and thinking about it again, I found that the
> underlying sections may go offline under us during compaction.  So that,
> cc->free_pfn may be in a offline section or after the end of zone.  So,
> you are right, we need to consider the range of block_end_pfn.
> 
> But, if we thought in this way (memory online/offline at any time), it
> appears that we need to check whether the underlying section was
> offlined.  For example, is it safe to use "pfn_to_page()" in
> "isolate_migratepages_block()"?  Is it possible for the underlying
> section to be offlined under us?

It is possible. There is a previous discussion[1] about the race between 
pfn_to_online_page() and memory offline.

[1] 
https://lore.kernel.org/lkml/87zgc6buoq.fsf@nvidia.com/T/#m642d91bcc726437e1848b295bc57ce249c7ca399
