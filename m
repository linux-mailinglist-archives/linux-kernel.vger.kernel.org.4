Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619A2634F59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 06:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235563AbiKWFHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 00:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbiKWFHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 00:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC8CEC78F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 21:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669180006;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jGWcKl8qBYO1tbvPCd08CEn8cDcWUBz7kzb9tc09dPg=;
        b=TbWFVWiWj/XgXZS9uBSWpwG5NF/quTbVAbK7cS4g7DuWL8n2wyJsNQB5uWFQ3pZW8nrm5E
        RxQfhMCnQ95HgjkIT51JN/iMFTWHnun6FFjjn9ZUnXvQtXeYAxV9U7MEkhZZk08egZmtfl
        cRHZreoDdCTrvhSCMEhFOOx9Gcydo58=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-249-qb-JEGj8MaKQy4hu6zHiSQ-1; Wed, 23 Nov 2022 00:06:43 -0500
X-MC-Unique: qb-JEGj8MaKQy4hu6zHiSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E95EA3C0D180;
        Wed, 23 Nov 2022 05:06:42 +0000 (UTC)
Received: from [10.64.54.62] (vpn2-54-62.bne.redhat.com [10.64.54.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B6ED2140EBF3;
        Wed, 23 Nov 2022 05:06:39 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com, david@redhat.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com
References: <20221123005752.161003-1-gshan@redhat.com>
 <87sfias2hd.fsf@nvidia.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <1a095dbe-0f9a-db49-8473-17552deccf75@redhat.com>
Date:   Wed, 23 Nov 2022 13:06:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <87sfias2hd.fsf@nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alistair,

On 11/23/22 12:26 PM, Alistair Popple wrote:
> Gavin Shan <gshan@redhat.com> writes:
> 
>> The issue is reported when removing memory through virtio_mem device.
>> The transparent huge page, experienced copy-on-write fault, is wrongly
>> regarded as pinned. The transparent huge page is escaped from being
>> isolated in isolate_migratepages_block(). The transparent huge page
>> can't be migrated and the corresponding memory block can't be put
>> into offline state.
>>
>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>> the transparent huge page can be isolated and migrated, and the memory
>> block can be put into offline state.
>>
>> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
>> Cc: stable@vger.kernel.org   # v5.8+
>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   mm/compaction.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/mm/compaction.c b/mm/compaction.c
>> index c51f7f545afe..c408b5e04c1d 100644
>> --- a/mm/compaction.c
>> +++ b/mm/compaction.c
>> @@ -990,7 +990,7 @@ isolate_migratepages_block(struct compact_control *cc, unsigned long low_pfn,
>>   		 * admittedly racy check.
>>   		 */
>>   		mapping = page_mapping(page);
>> -		if (!mapping && page_count(page) > page_mapcount(page))
>> +		if (!mapping && page_count(page) > total_mapcount(page))
> 
> We have several versions of these checks for pinned pages open-coded
> around the place. See for example migrate_vma_check_page() and
> folio_expected_refs(). It looks like you could use a variant of
> migrate_vma_check_page() which would also check non-anon pins, although
> I don't know the compaction code well enough to know if that's useful.
> 
> Either way it would be nice if we had a common helper for these kind of
> checks. Guess that would be harder to backport, and the change itself
> looks ok. But why isn't the fixes tag 119d6d59dcc0 ("mm, compaction:
> avoid isolating pinned pages")?
> 

Nice to see your comments. folio_expected_refs() only returns the
mapcount for file-mapped pages. migrate_vma_check_page() doesn't
cover THP and there is a 'FIXME' there. A unified helper is beneficial
to maintainance. I think the issue can be fixed in place and have a
followup patch to introduce the unified helper, to make the backporting
happy.

Right, I was thinking of 119d6d59dcc0, which was merged in early days
back to v3.15. I doubt we even had THP support that time. 3917c80280c9
changed the behavior of THP COW handling, to split the THP. Without
3917c80280c9, no splitting is expected and the original condition is
correct to check for anon pins.

>>   			goto isolate_fail;
>>   
>>   		/*
> 

Thanks,
Gavin

