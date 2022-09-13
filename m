Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7155B6824
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 08:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiIMGwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 02:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiIMGv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 02:51:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C905056BAE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 23:51:54 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MRYxC58yBzHntY;
        Tue, 13 Sep 2022 14:49:51 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 13 Sep 2022 14:51:52 +0800
Subject: Re: [PATCH 08/16] mm/page_alloc: add missing is_migrate_isolate()
 check in set_page_guard()
To:     David Hildenbrand <david@redhat.com>
CC:     <osalvador@suse.de>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220909092451.24883-1-linmiaohe@huawei.com>
 <20220909092451.24883-9-linmiaohe@huawei.com>
 <e908087d-bcd8-8c3e-8b64-a01b41b77372@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <9b7f63cf-dfc1-a1d8-695d-94f6b1af4512@huawei.com>
Date:   Tue, 13 Sep 2022 14:51:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <e908087d-bcd8-8c3e-8b64-a01b41b77372@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/9 19:31, David Hildenbrand wrote:
> On 09.09.22 11:24, Miaohe Lin wrote:
>> In MIGRATE_ISOLATE case, zone freepage state shouldn't be modified as
>> caller will take care of it. Add missing is_migrate_isolate() here to
>> avoid possible unbalanced freepage state.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>   mm/page_alloc.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index a35ef385d906..94baf33da865 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -873,7 +873,8 @@ static inline bool set_page_guard(struct zone *zone, struct page *page,
>>       INIT_LIST_HEAD(&page->buddy_list);
>>       set_page_private(page, order);
>>       /* Guard pages are not available for any usage */
>> -    __mod_zone_freepage_state(zone, -(1 << order), migratetype);
>> +    if (!is_migrate_isolate(migratetype))
>> +        __mod_zone_freepage_state(zone, -(1 << order), migratetype);
>>         return true;
>>   }
> 
> Do we have a fixes: tag for this one?
> 
> Can it even happen that the pageblock is isolated when we end up in this function? IIUC, we'd have an allocation in an isolated pageblock, which would be wrong already?

For "normal" page allocation case, migratetype can't be MIGRATE_ISOLATE. So it's fine. But when called from take_page_off_buddy(), the issue
could be triggered as it breaks the assumption in the set_page_guard (that migratetype can't be MIGRATE_ISOLATE). So the fixes tag might be:

	Fixes: 06be6ff3d2ec ("mm,hwpoison: rework soft offline for free pages")

Or am I miss something?

Many thanks for your review and comment in this series, David. :)

Thanks,
Miaohe Lin

