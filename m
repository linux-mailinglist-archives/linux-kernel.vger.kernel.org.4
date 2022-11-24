Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04AC3637579
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKXJpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiKXJpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:45:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0D2776C9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669283084;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcJGIl3Tkb+Zsd2eHhCk2ceJWM8jStf6t2KKTNfutDM=;
        b=diWBwgwlWMiRpKLfJlodtkNgfnYBesqqzrWV5my6yKvwCcmXjUUP7I48qKlP8k/MSQP5x/
        VSWH/I5barS4MOaQFASeweDTv5cfsAWjlFg0gzcWVCBFXRdG+HQ53qiAmp7Jz3imcpimY1
        LG5e3ZF+j9kw+ZVwVMGYVkS5+FiXu0c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-37-vQTK2AiPNCu9ao9qYDUZqA-1; Thu, 24 Nov 2022 04:44:38 -0500
X-MC-Unique: vQTK2AiPNCu9ao9qYDUZqA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C3BF1C07582;
        Thu, 24 Nov 2022 09:44:38 +0000 (UTC)
Received: from [10.64.54.95] (vpn2-54-95.bne.redhat.com [10.64.54.95])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C1FD32027064;
        Thu, 24 Nov 2022 09:44:33 +0000 (UTC)
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
 <9d2ce3f4-9f5d-ff09-c28f-fc28ee6f2817@redhat.com>
 <0bfbcb03-fad4-92db-0a19-167a3a37ab50@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <6b7a43a6-e364-87c0-66ba-5d1f1ee68bf8@redhat.com>
Date:   Thu, 24 Nov 2022 17:44:30 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <0bfbcb03-fad4-92db-0a19-167a3a37ab50@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/22 4:46 PM, David Hildenbrand wrote:
> On 24.11.22 01:14, Gavin Shan wrote:
>> On 11/23/22 4:56 PM, David Hildenbrand wrote:
>>> On 23.11.22 06:14, Hugh Dickins wrote:
>>>> On Wed, 23 Nov 2022, Gavin Shan wrote:
>>>>
>>>>> The issue is reported when removing memory through virtio_mem device.
>>>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>>>> regarded as pinned. The transparent huge page is escaped from being
>>>>> isolated in isolate_migratepages_block(). The transparent huge page
>>>>> can't be migrated and the corresponding memory block can't be put
>>>>> into offline state.
>>>>>
>>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>>>> the transparent huge page can be isolated and migrated, and the memory
>>>>> block can be put into offline state.
>>>>>
>>>>> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
>>>>> Cc: stable@vger.kernel.org   # v5.8+
>>>>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>>
>>>> Interesting, good catch, looked right to me: except for the Fixes line
>>>> and mention of v5.8.  That CoW change may have added a case which easily
>>>> demonstrates the problem, but it would have been the wrong test on a THP
>>>> for long before then - but only in v5.7 were compound pages allowed
>>>> through at all to reach that test, so I think it should be
>>>>
>>>> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for CMA allocations")
>>>> Cc: stable@vger.kernel.org   # v5.7+
>>>>
>>
>> Right, commit 1da2f328fa64 looks more accurate in this particular
>> case, I will fix it up in next revision.
>>
>>>> Oh, no, stop: this is not so easy, even in the latest tree.
>>>>
>>>> Because at the time of that "admittedly racy check", we have no hold
>>>> at all on the page in question: and if it's PageLRU or PageCompound
>>>> at one instant, it may be different the next instant.  Which leaves it
>>>> vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
>>>> path - needs research.  *Perhaps* there are no more BUG_ON()s in the
>>>> total_mapcount() path than in the existing page_mapcount() path.
>>>>
>>>> I suspect that for this to be safe (before your patch and more so after),
>>>> it will be necessary to shift the "admittedly racy check" down after the
>>>> get_page_unless_zero() (and check the sequence of operations when a
>>>> compound page is initialized).
>>>
>>> Grabbing a reference first sounds like the right approach to me.
>>>
>>
>> Yeah, it sounds reasonable to me to grab a page->__refcount in the
>> first place. Looking at isolate_migratepages_block(), the page's refcount
>> is increased by get_page_unless_zero(), but it's too late. To increase
>> the page's refcount at the first place in the function will be conflicting
>> with hugetlb page and non-LRU page. I mean there will be a series to refactor
>> the code so that the page's refcount can be grabbed in the first place.
>>
>> So I plan to post a followup series to refactor the code and grab
>> the page's refcount in the first place. In this way, the fix can be
>> merged as soon as possible. David and Hugh, please let me know if
>> it's reasonable plan? :)
> 
> 
> Can't you just temporarily grab the refcount and drop it again? I mean, it's all racy either way and the code has to be able to cope with such races.
> 

Well, we can do this by moving the hunk of code, which increases page's
refcount, ahead of the check.


   if (unlikely(!get_page_unless_zero(page)))
       goto isolate_fail;

   if (!mapping && (page_count(page) - 1) > total_mapcount(page))
       goto isolate_fail_put;

Thanks,
Gavin

