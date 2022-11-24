Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EDD637644
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 11:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbiKXKXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 05:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiKXKW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 05:22:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656F514F509
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 02:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669285323;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+9WV1qYNyaVdVQKDsAXQEGMpoN9r3x4zYBqnGJQF4uY=;
        b=WLXUKeAEHmIHZicHmQvHkiKC5UK9hWq5DsvEiuhKMmg/d8omRVZWW0th8sueDWtEoqPyy+
        Nz4atzpXC3KFICFIMQwEZRmjijLxcaNmoWcqv1SehbdC7fRMLFSjHVMOo9hYKknKJ5Vunr
        WNvkwxPF1ZNcJPeU9TkE8AjMRjKjuuI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-8O94hoaGNjyMoucvV7lfTw-1; Thu, 24 Nov 2022 05:21:58 -0500
X-MC-Unique: 8O94hoaGNjyMoucvV7lfTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 840DE185A78B;
        Thu, 24 Nov 2022 10:21:57 +0000 (UTC)
Received: from [10.64.54.95] (vpn2-54-95.bne.redhat.com [10.64.54.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 67B7710197;
        Thu, 24 Nov 2022 10:21:53 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, zhenyzha@redhat.com,
        apopple@nvidia.com, hughd@google.com, willy@infradead.org,
        shan.gavin@gmail.com
References: <20221124095523.31061-1-gshan@redhat.com>
 <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com>
Date:   Thu, 24 Nov 2022 18:21:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 6:09 PM, David Hildenbrand wrote:
> On 24.11.22 10:55, Gavin Shan wrote:
>> The issue is reported when removing memory through virtio_mem device.
>> The transparent huge page, experienced copy-on-write fault, is wrongly
>> regarded as pinned. The transparent huge page is escaped from being
>> isolated in isolate_migratepages_block(). The transparent huge page
>> can't be migrated and the corresponding memory block can't be put
>> into offline state.
>>
>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>> the transparent huge page can be isolated and migrated, and the memory
>> block can be put into offline state. Besides, The page's refcount is
>> increased a bit earlier to avoid the page is released when the check
>> is executed.
> 
> Did you look into handling pages that are in the swapcache case as well?
> 
> See is_refcount_suitable() in mm/khugepaged.c.
> 
> Should be easy to reproduce, let me know if you need inspiration.
> 

Nope, I didn't look into the case. Please elaborate the details so that
I can reproduce it firstly.

>>
>> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for CMA allocations")
>> Cc: stable@vger.kernel.org   # v5.7+
>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>> v2: Corrected fix tag and increase page's refcount before the check
>> ---
>>   mm/compaction.c | 22 +++++++++++-----------
>>   1 file changed, 11 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index c51f7f545afe..1f6da31dd9a5 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -984,29 +984,29 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>               goto isolate_fail;
>>           }
>> +        /*
>> +         * Be careful not to clear PageLRU until after we're
>> +         * sure the page is not being freed elsewhere -- the
>> +         * page release code relies on it.
>> +         */
>> +        if (unlikely(!get_page_unless_zero(page)))
>> +            goto isolate_fail;
>> +
>>           /*
>>            * Migration will fail if an anonymous page is pinned in memory,
>>            * so avoid taking lru_lock and isolating it unnecessarily in an
>>            * admittedly racy check.
>>            */
>>           mapping = page_mapping(page);
>> -        if (!mapping && page_count(page) > page_mapcount(page))
>> -            goto isolate_fail;
>> +        if (!mapping && (page_count(page) - 1) > total_mapcount(page))
>> +            goto isolate_fail_put;
>>           /*
>>            * Only allow to migrate anonymous pages in GFP_NOFS context
>>            * because those do not depend on fs locks.
>>            */
>>           if (!(cc->gfp_mask & __GFP_FS) && mapping)
>> -            goto isolate_fail;
>> -
>> -        /*
>> -         * Be careful not to clear PageLRU until after we're
>> -         * sure the page is not being freed elsewhere -- the
>> -         * page release code relies on it.
>> -         */
>> -        if (unlikely(!get_page_unless_zero(page)))
>> -            goto isolate_fail;
>> +            goto isolate_fail_put;
>>           /* Only take pages on LRU: a check now makes later tests safe */
>>           if (!PageLRU(page))
> 

Thanks,
Gavin

