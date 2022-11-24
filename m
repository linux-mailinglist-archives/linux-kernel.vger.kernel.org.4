Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA30B637460
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 09:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiKXIsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 03:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiKXIr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 03:47:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7BEFAE94
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669279622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4n/Mj6FX5RcMoXU1Ro8lJ+6enfIFo7SixFfBkNMSQ1w=;
        b=MuO+edGx+/IVev5Ri7etNZp6yK1Gx32cCUezjOZcWj6uRvtTnwAnKKk9l0gXxkU/cANohN
        LpuJyJYKdnJ8BbPR+Fvii65e3CMqJ1riobo6yP7hCzxiWvAsBaSY/VAcBu+XSMFGRsBLv/
        EBwI8g82vfmqCwj6wH4W66khtuVfxh4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-177-EOgIVf8MOlSZwVhFDNtk5A-1; Thu, 24 Nov 2022 03:47:00 -0500
X-MC-Unique: EOgIVf8MOlSZwVhFDNtk5A-1
Received: by mail-wm1-f70.google.com with SMTP id ay40-20020a05600c1e2800b003cf8aa16377so644844wmb.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 00:47:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4n/Mj6FX5RcMoXU1Ro8lJ+6enfIFo7SixFfBkNMSQ1w=;
        b=a4NGoS1KHzecxt0vp41h42POO9Fe+pP0gs96jzgHTl06iCDk8mHJJwwoPR4QHAecB6
         YyuJyFpmR9i942B+VQTFm5XS4a8iJg48bQDLTmFNFy7nZz+UGLNT7zeHyFFHZrRaf0Z2
         CcDqmmmos0JYDfVGNuoAjAjug6KXxyZfD3ATxzhmO0gl80/kHg+R1vraUwgttHfWS/Vd
         t6KjAu3mGJrFa3yCDZTxAEtfNfua6VVWf/Yvd32DdYjARK3hRzIBQcAgyQ9lc+Wbb+Lv
         cMxqvJImqcZ8E2CtBvc0yG47cfbaOAARxvfULqKSQd/gm8XW6dKdn/IrH1beW9agUCLx
         CCdw==
X-Gm-Message-State: ANoB5pn163bCebd3gHiLgZ10bvlWoA1jChbK4SQdo5NHbWO6yHgzg45G
        PZoqXE3imC5ZrNz1tw8u203zrlMWHiaMecEE5QH+QoWt51VWNfca+lyYjTXoay2EQQ4qQEPkQ3f
        w0Tj85WrwezjDDaaldWQ+MGdV
X-Received: by 2002:a05:600c:1f0f:b0:3d0:2a82:1cb2 with SMTP id bd15-20020a05600c1f0f00b003d02a821cb2mr8863486wmb.206.1669279619657;
        Thu, 24 Nov 2022 00:46:59 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6bn2nLT8jXz5jZ8OGFq5hnA5XQ409+mb3jJ/xNk+VXCYJY0M8GPrwD2IZxwaIPUXLO789B/A==
X-Received: by 2002:a05:600c:1f0f:b0:3d0:2a82:1cb2 with SMTP id bd15-20020a05600c1f0f00b003d02a821cb2mr8863464wmb.206.1669279619366;
        Thu, 24 Nov 2022 00:46:59 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:2200:bfcb:7212:1370:de13? (p200300cbc7042200bfcb72121370de13.dip0.t-ipconnect.de. [2003:cb:c704:2200:bfcb:7212:1370:de13])
        by smtp.gmail.com with ESMTPSA id w8-20020a5d6088000000b0024165454262sm751245wrt.11.2022.11.24.00.46.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 00:46:58 -0800 (PST)
Message-ID: <0bfbcb03-fad4-92db-0a19-167a3a37ab50@redhat.com>
Date:   Thu, 24 Nov 2022 09:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com,
        willy@infradead.org, apopple@nvidia.com
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
 <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
 <9d2ce3f4-9f5d-ff09-c28f-fc28ee6f2817@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9d2ce3f4-9f5d-ff09-c28f-fc28ee6f2817@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.22 01:14, Gavin Shan wrote:
> On 11/23/22 4:56 PM, David Hildenbrand wrote:
>> On 23.11.22 06:14, Hugh Dickins wrote:
>>> On Wed, 23 Nov 2022, Gavin Shan wrote:
>>>
>>>> The issue is reported when removing memory through virtio_mem device.
>>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>>> regarded as pinned. The transparent huge page is escaped from being
>>>> isolated in isolate_migratepages_block(). The transparent huge page
>>>> can't be migrated and the corresponding memory block can't be put
>>>> into offline state.
>>>>
>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>>> the transparent huge page can be isolated and migrated, and the memory
>>>> block can be put into offline state.
>>>>
>>>> Fixes: 3917c80280c9 ("thp: change CoW semantics for anon-THP")
>>>> Cc: stable@vger.kernel.org   # v5.8+
>>>> Reported-by: Zhenyu Zhang <zhenyzha@redhat.com>
>>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>>
>>> Interesting, good catch, looked right to me: except for the Fixes line
>>> and mention of v5.8.  That CoW change may have added a case which easily
>>> demonstrates the problem, but it would have been the wrong test on a THP
>>> for long before then - but only in v5.7 were compound pages allowed
>>> through at all to reach that test, so I think it should be
>>>
>>> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for CMA allocations")
>>> Cc: stable@vger.kernel.org   # v5.7+
>>>
> 
> Right, commit 1da2f328fa64 looks more accurate in this particular
> case, I will fix it up in next revision.
> 
>>> Oh, no, stop: this is not so easy, even in the latest tree.
>>>
>>> Because at the time of that "admittedly racy check", we have no hold
>>> at all on the page in question: and if it's PageLRU or PageCompound
>>> at one instant, it may be different the next instant.  Which leaves it
>>> vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
>>> path - needs research.  *Perhaps* there are no more BUG_ON()s in the
>>> total_mapcount() path than in the existing page_mapcount() path.
>>>
>>> I suspect that for this to be safe (before your patch and more so after),
>>> it will be necessary to shift the "admittedly racy check" down after the
>>> get_page_unless_zero() (and check the sequence of operations when a
>>> compound page is initialized).
>>
>> Grabbing a reference first sounds like the right approach to me.
>>
> 
> Yeah, it sounds reasonable to me to grab a page->__refcount in the
> first place. Looking at isolate_migratepages_block(), the page's refcount
> is increased by get_page_unless_zero(), but it's too late. To increase
> the page's refcount at the first place in the function will be conflicting
> with hugetlb page and non-LRU page. I mean there will be a series to refactor
> the code so that the page's refcount can be grabbed in the first place.
> 
> So I plan to post a followup series to refactor the code and grab
> the page's refcount in the first place. In this way, the fix can be
> merged as soon as possible. David and Hugh, please let me know if
> it's reasonable plan? :)


Can't you just temporarily grab the refcount and drop it again? I mean, 
it's all racy either way and the code has to be able to cope with such 
races.

-- 
Thanks,

David / dhildenb

