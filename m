Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A936DF512
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjDLMYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjDLMYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:24:20 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6593B76B4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 05:24:07 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VfwS.8H_1681302242;
Received: from 30.97.48.75(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VfwS.8H_1681302242)
          by smtp.aliyun-inc.com;
          Wed, 12 Apr 2023 20:24:04 +0800
Message-ID: <f30dfee7-526e-07a4-baf6-6be7784beb50@linux.alibaba.com>
Date:   Wed, 12 Apr 2023 20:24:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm/page_alloc: consider pfn holes after pfn_valid() in
 __pageblock_pfn_to_page()
To:     Michal Hocko <mhocko@suse.com>
Cc:     akpm@linux-foundation.org, mgorman@techsingularity.net,
        vbabka@suse.cz, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <62e231a8f2e50c04dcadc7a0cfaa6dea5ce1ec05.1681296022.git.baolin.wang@linux.alibaba.com>
 <ZDaSt8gW7kjfYGx5@dhcp22.suse.cz>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <ZDaSt8gW7kjfYGx5@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/12/2023 7:15 PM, Michal Hocko wrote:
> On Wed 12-04-23 18:45:31, Baolin Wang wrote:
>> Now the __pageblock_pfn_to_page() is used by set_zone_contiguous(),
>> which checks whether the given zone contains holes, and uses pfn_valid()
>> to check if the end pfn is valid. However pfn_valid() can not make sure
>> the end pfn is not a hole if the size of a pageblock is larger than the
>> size of a sub-mem_section, since the struct page getting by pfn_to_page()
>> may represent a hole or an unusable page frame, which may cause incorrect
>> zone contiguous is set.
>>
>> Though another user of pageblock_pfn_to_page() in compaction seems work
>> well now, it is better to avoid scanning or touching these offline pfns.
>> So like commit 2d070eab2e82 ("mm: consider zone which is not fully
>> populated to have holes"), we should also use pfn_to_online_page() for
>> the end pfn to make sure it is a valid pfn with usable page frame.
>> Meanwhile the pfn_valid() for end pfn can be dropped now.
>>
>> Moreover we've already used pfn_to_online_page() for start pfn to make
>> sure it is online and valid, so the pfn_valid() for the start pfn is
>> unnecessary, drop it.
> 
> Is this a theoretical problem or something you have encountered on a
> real machine? Could you provide more details please?

As I replied to David, this is just from code inspection when trying to 
remove the unnecessary pfn_valid() in __pageblock_pfn_to_page().
