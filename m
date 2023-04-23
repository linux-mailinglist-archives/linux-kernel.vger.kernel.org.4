Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D836EBD47
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 08:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbjDWGAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 02:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWGAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 02:00:14 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A4B61FEF
        for <linux-kernel@vger.kernel.org>; Sat, 22 Apr 2023 23:00:11 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VgiUM0a_1682229605;
Received: from 30.97.48.67(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VgiUM0a_1682229605)
          by smtp.aliyun-inc.com;
          Sun, 23 Apr 2023 14:00:06 +0800
Message-ID: <9b9f6247-8428-e3ee-18e5-0dda59bbd5e5@linux.alibaba.com>
Date:   Sun, 23 Apr 2023 14:00:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/2] mm/page_alloc: add some comments to explain the
 possible hole in __pageblock_pfn_to_page()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     akpm@linux-foundation.org, ying.huang@intel.com,
        mgorman@techsingularity.net, vbabka@suse.cz, mhocko@suse.com,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <c2eee65ecd15779721af85c9ff109a35345b52d4.1682158312.git.baolin.wang@linux.alibaba.com>
 <02defcbe9d7a797a2257e5f6a28ff7ea78e394e5.1682158312.git.baolin.wang@linux.alibaba.com>
 <ZES/7+zfs0h+lg7y@kernel.org>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZES/7+zfs0h+lg7y@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/23/2023 1:19 PM, Mike Rapoport wrote:
> Hi,
> 
> On Sat, Apr 22, 2023 at 06:15:18PM +0800, Baolin Wang wrote:
>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(), which
>> checks whether the given zone contains holes, and uses pfn_to_online_page()
>> to validate if the start pfn is online and valid, as well as using pfn_valid()
>> to validate the end pfn.
>>
>> However, though the start pfn of a pageblock is valid, it can not always
>> guarantee the end pfn of the pageblock is also valid (may be holes) in some
>> cases. For example, if the pageblock order is MAX_ORDER - 1, which will fall
> 
> Nit: in the current mm tree the default pageblock order is MAX_ORDER.

Ah, yes, will change in next version.

> 
>> into 2 sub-sections, and the end pfn of the pageblock may be hole even though
>> the start pfn is online and valid.
>>
>> This did not break anything until now, but the zone continuous is fragile
>> in this possible scenario. So as previous discussion[1], it is better to
>> add some comments to explain this possible issue in case there are some
>> future pfn walkers that rely on this.
>>
>> [1] https://lore.kernel.org/all/87r0sdsmr6.fsf@yhuang6-desk2.ccr.corp.intel.com/
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/page_alloc.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index 6457b64fe562..dc4005b32ae0 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -1502,6 +1502,14 @@ void __free_pages_core(struct page *page, unsigned int order)
>>    * interleaving within a single pageblock. It is therefore sufficient to check
>>    * the first and last page of a pageblock and avoid checking each individual
>>    * page in a pageblock.
>> + *
>> + * Note: if the start pfn of a pageblock is valid, but it can not always guarantee
>> + * the end pfn of the pageblock is also valid (may be holes) in some cases. For
>> + * example, if the pageblock order is MAX_ORDER - 1, which will fall into 2
>> + * sub-sections, and the end pfn of the pageblock may be hole even though the
>> + * start pfn is online and valid. This did not break anything until now, but be
>> + * careful this possible issue when checking if the whole pfns are valid of a
> 
> careful about ...

OK. Thanks for reviewing.
