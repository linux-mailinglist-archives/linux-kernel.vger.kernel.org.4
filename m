Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9F45B95FB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIOILc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 04:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiIOILa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 04:11:30 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9366883E5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 01:11:29 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSqZ52WcdzmVPZ;
        Thu, 15 Sep 2022 16:07:41 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 16:11:27 +0800
Subject: Re: [PATCH 08/16] mm/page_alloc: add missing is_migrate_isolate()
 check in set_page_guard()
To:     Oscar Salvador <osalvador@suse.de>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-9-linmiaohe@huawei.com>
 <YyLTl8FvmcRuUYi9@localhost.localdomain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8a23c1b4-494e-1006-ee8c-e27a798d9f8f@huawei.com>
Date:   Thu, 15 Sep 2022 16:11:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YyLTl8FvmcRuUYi9@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/15 15:26, Oscar Salvador wrote:
> On Fri, Sep 09, 2022 at 05:24:43PM +0800, Miaohe Lin wrote:
>> In MIGRATE_ISOLATE case, zone freepage state shouldn't be modified as
>> caller will take care of it. Add missing is_migrate_isolate() here to
>> avoid possible unbalanced freepage state.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> 
> Ok, I gave it some thought and I guess it's safe to assume that this would happen if
> someone isolates the block, and then we face an MCE failure/soft-offline on a page
> within that block.
> 
> take_page_off_buddy
>  break_down_buddy_pages
>   set_page_guard
> 
> will trigger __mod_zone_freepage_state(), which already had been triggered back
> when the block was isolated.
> 
> I think the changelog could grow fatter to better explain the issue.

That will be really helpful. Will do it in v2.

> 
> Reviewed-by: Oscar Salvador <osalvador@suse.de>

Many thanks for your suggestion and review.

Thanks,
Miaohe Lin

> 
>> ---
>>  mm/page_alloc.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a35ef385d906..94baf33da865 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -873,7 +873,8 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
>>  	INIT_LIST_HEAD(&page->buddy_list);
>>  	set_page_private(page, order);
>>  	/* Guard pages are not available for any usage */
>> -	__mod_zone_freepage_state(zone, -(1 << order), migratetype);
>> +	if (!is_migrate_isolate(migratetype))
>> +		__mod_zone_freepage_state(zone, -(1 << order), migratetype);
>>  
>>  	return true;
>>  }
>> -- 
>> 2.23.0
>>
> 

