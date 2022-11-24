Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7E636ECA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiKXAP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiKXAPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:15:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAE13F07D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:15:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669248900;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RGBaalQAMOMB18Hyg4LVBpssuniV3B6MVURv6Y4rVAc=;
        b=Hh4PP/HPjT3a4yknRajVPnDjB9yNMsfBoZBv8wyzWwBjLJlMGtQf0bQS3KBGDhjEqXqhgL
        YiRxl7ZAdICnz6IGEDoS4vcW3pvD+bbvIwyQ9YK4zI7w3+5XEd5kVX0VOTKiHVOAccY/FS
        pEHXntGLAD0tYEnJPjTpuILZ6ksvVME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-0zcAGajzMSGKrYb48y_aoQ-1; Wed, 23 Nov 2022 19:14:56 -0500
X-MC-Unique: 0zcAGajzMSGKrYb48y_aoQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 972B585A588;
        Thu, 24 Nov 2022 00:14:55 +0000 (UTC)
Received: from [10.64.54.95] (vpn2-54-95.bne.redhat.com [10.64.54.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 311402166B26;
        Thu, 24 Nov 2022 00:14:50 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
To:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com,
        willy@infradead.org, apopple@nvidia.com
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <9d2ce3f4-9f5d-ff09-c28f-fc28ee6f2817@redhat.com>
Date:   Thu, 24 Nov 2022 08:14:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/23/22 4:56 PM, David Hildenbrand wrote:
> On 23.11.22 06:14, Hugh Dickins wrote:
>> On Wed, 23 Nov 2022, Gavin Shan wrote:
>>
>>> The issue is reported when removing memory through virtio_mem device.
>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>> regarded as pinned. The transparent huge page is escaped from being
>>> isolated in isolate_migratepages_block(). The transparent huge page
>>> can't be migrated and the corresponding memory block can't be put
>>> into offline state.
>>>
>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>> the transparent huge page can be isolated and migrated, and the memory
>>> block can be put into offline state.
>>>
>>> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
>>> Cc: stable@vger.kernel.org   # v5.8+
>>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>
>> Interesting, good catch, looked right to me: except for the Fixes line
>> and mention of v5.8.  That CoW change may have added a case which easily
>> demonstrates the problem, but it would have been the wrong test on a THP
>> for long before then - but only in v5.7 were compound pages allowed
>> through at all to reach that test, so I think it should be
>>
>> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for CMA allocations")
>> Cc: stable@vger.kernel.org   # v5.7+
>>

Right, commit 1da2f328fa64 looks more accurate in this particular
case, I will fix it up in next revision.

>> Oh, no, stop: this is not so easy, even in the latest tree.
>>
>> Because at the time of that "admittedly racy check", we have no hold
>> at all on the page in question: and if it's PageLRU or PageCompound
>> at one instant, it may be different the next instant.  Which leaves it
>> vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
>> path - needs research.  *Perhaps* there are no more BUG_ON()s in the
>> total_mapcount() path than in the existing page_mapcount() path.
>>
>> I suspect that for this to be safe (before your patch and more so after),
>> it will be necessary to shift the "admittedly racy check" down after the
>> get_page_unless_zero() (and check the sequence of operations when a
>> compound page is initialized).
> 
> Grabbing a reference first sounds like the right approach to me.
> 

Yeah, it sounds reasonable to me to grab a page->__refcount in the
first place. Looking at isolate_migratepages_block(), the page's refcount
is increased by get_page_unless_zero(), but it's too late. To increase
the page's refcount at the first place in the function will be conflicting
with hugetlb page and non-LRU page. I mean there will be a series to refactor
the code so that the page's refcount can be grabbed in the first place.

So I plan to post a followup series to refactor the code and grab
the page's refcount in the first place. In this way, the fix can be
merged as soon as possible. David and Hugh, please let me know if
it's reasonable plan? :)

   static int isolate_migratepages_block()
   {
       for (; low_pfn < end_pfn; low_pfn++) {
           :
           page = pfn_to_page(low_pfn);
           if (unlikely(!get_page_unless_zero(page)))                           // grab page's refcount in the first place
               goto isolate_fail_put;
           :
           if (PageHuge(page) && cc->alloc_contig) {
               ret = isolate_or_dissolve_huge_page(page, &cc->migratepages);   // refcount is increased by this function
               :
           }
           :
           if (!PageLRU(page)) {
               if (unlikely(__PageMovable(page)) &&
                   !PageIsolated(page)) {
                   if (!isolate_movable_page(page, mode)))                     // refcunt is increased here too
                       goto isolate_success;
               }
           }
           :
           mapping = page_mapping(page);
           if (!mapping && page_count(page) > total_mapcount(page))
               goto isolate_fail;
           :
           if (unlikely(!get_page_unless_zero(page)))                         // too late to grab the refcount?
               goto isolate_fail;
           :
       }
   }


[...]

Thanks,
Gavin

