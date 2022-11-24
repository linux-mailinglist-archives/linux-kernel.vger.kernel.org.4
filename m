Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4716637472
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKXIur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiKXIuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:50:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE71275EA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:49:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669279791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bouCjiccMbkBph0CwILHyMEk13c9R9ulH7Nu8uPZIlo=;
        b=db992nWDebjm2iqF7vrQBr4AD0OMfbef5oiuE+inI1ssLoT9GxajOTpZfEf7RNtxrK/oOO
        aZQIKqK4itqjxm+uyT4F61f/97pbJJbW3VT652qR4jfFYh6zY4IAcrYpVHwOUOjCnw08Na
        OLAFGcERp+1pPJrJzBJuTByaShKn0SE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-23jeoreUMASs6R7pawJuoA-1; Thu, 24 Nov 2022 03:49:47 -0500
X-MC-Unique: 23jeoreUMASs6R7pawJuoA-1
Received: by mail-wm1-f71.google.com with SMTP id x10-20020a05600c420a00b003cfa33f2e7cso659520wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:49:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bouCjiccMbkBph0CwILHyMEk13c9R9ulH7Nu8uPZIlo=;
        b=QCjQEiwG42JnduL4soiolw4+y8yS8NAV64JTr+JRmt0k2PKPkMFP0daUqAADHwqo3F
         JNsypU5x0aE86ZqrRY8jqG5NmycaJ1wFh4iaTuTBVUn//KlGfAIgfIt+GhWI9/LcBKDZ
         FyCHdj2ENK60L77V4KtWHv+sacjoLxt6usmumXdpAoiro70CitgFzBB/iKbzyK0Ao2Of
         dq5cnBpFslegO3asFFY9nqkScFEjmF0zFeBxtmUPwCuAEM5cIQdd0A2yXsBwIdbwNFt/
         aLnzUwu6+Zh6NsXSTxkTUBmZkK3DkZLlncJrZTmvoa74vCb/C800O11RPqADHk5OKa8x
         MREQ==
X-Gm-Message-State: ANoB5pk1GMI1aldhAQF65aGRnK2/EC0OwfN2a9nwJX4ZvPee3KxS1Ct4
        4P0ns9hA4DWmPmWH6pFbxrQx4db8HcN0J2sPXLwrcpuMFr8TlMn8E5bFR3nr3x3eRk5mgc4ZjF3
        JMNY9c4LTD1JVW6ZifA6c//LI
X-Received: by 2002:adf:e4ca:0:b0:241:d5a7:8bf7 with SMTP id v10-20020adfe4ca000000b00241d5a78bf7mr8728563wrm.440.1669279786656;
        Thu, 24 Nov 2022 00:49:46 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7lMi+A4R7Nx1q9fQ8HSx91nzD4aqkEi0jFq0mNdcSOZNVpH2q4UoP8cXz383M5CERZD4uQbg==
X-Received: by 2002:adf:e4ca:0:b0:241:d5a7:8bf7 with SMTP id v10-20020adfe4ca000000b00241d5a78bf7mr8728542wrm.440.1669279786352;
        Thu, 24 Nov 2022 00:49:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:2200:bfcb:7212:1370:de13? (p200300cbc7042200bfcb72121370de13.dip0.t-ipconnect.de. [2003:cb:c704:2200:bfcb:7212:1370:de13])
        by smtp.gmail.com with ESMTPSA id dn7-20020a05600c654700b003cf6e1df4a8sm988382wmb.15.2022.11.24.00.49.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:49:45 -0800 (PST)
Message-ID: <51ffd399-7fa3-b2f2-b6e5-61a8b609e350@redhat.com>
Date:   Thu, 24 Nov 2022 09:49:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Alistair Popple <apopple@nvidia.com>
Cc:     Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com> <871qptrvsw.fsf@nvidia.com>
 <Y37mC1+LQscJaOk4@casper.infradead.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y37mC1+LQscJaOk4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.22 04:33, Matthew Wilcox wrote:
> On Thu, Nov 24, 2022 at 12:06:56PM +1100, Alistair Popple wrote:
>>
>> David Hildenbrand <david@redhat.com> writes:
>>
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
>>>>> Cc: stable@vger.kernel.org   # v5.8+
>>>>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>> Interesting, good catch, looked right to me: except for the Fixes
>>>> line
>>>> and mention of v5.8.  That CoW change may have added a case which easily
>>>> demonstrates the problem, but it would have been the wrong test on a THP
>>>> for long before then - but only in v5.7 were compound pages allowed
>>>> through at all to reach that test, so I think it should be
>>>> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for
>>>> CMA allocations")
>>>> Cc: stable@vger.kernel.org   # v5.7+
>>>> Oh, no, stop: this is not so easy, even in the latest tree.
>>>> Because at the time of that "admittedly racy check", we have no hold
>>>> at all on the page in question: and if it's PageLRU or PageCompound
>>>> at one instant, it may be different the next instant.  Which leaves it
>>>> vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
>>>> path - needs research.  *Perhaps* there are no more BUG_ON()s in the
>>>> total_mapcount() path than in the existing page_mapcount() path.
>>>> I suspect that for this to be safe (before your patch and more so
>>>> after),
>>>> it will be necessary to shift the "admittedly racy check" down after the
>>>> get_page_unless_zero() (and check the sequence of operations when a
>>>> compound page is initialized).
>>>
>>> Grabbing a reference first sounds like the right approach to me.
>>
>> I think you're right. Without a page reference I don't think it is even
>> safe to look at struct page, at least not without synchronisation
>> against memory hot unplug which could remove the struct page. From a
>> quick glance I didn't see anything here that obviously did that though.
> 
> Memory hotplug is the offending party here.  It has to make sure that
> everything else is definitely quiescent before removing the struct pages.
> Otherwise you can't even try_get a refcount.

At least alloc_contig_range() and memory offlining are mutually 
exclusive due to MIGRATE_ISOLTAE. I recall that ordinary memory 
compaction similarly deals with isolated pageblocks (or some other 
mechanism I forgot) to not race with memory offlining. Wouldn't worry 
about that for now.

-- 
Thanks,

David / dhildenb

