Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1D36379DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 14:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKXNXB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 08:23:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiKXNW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 08:22:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F06729AE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669296131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Af+/dAibosKqrfLx5kNJxNqzWHdIAvebWVY3liLga6Q=;
        b=heHVCGs8YsBGMDpqQkMfNXSE+B/NxuFuhVnMbMdiMLz5mMnUbiiIBrJ+RxS/SmiPr2i7Jw
        ubovf0SgzK9rv50MKQLejcelFs8ByxQBHzd4gKaDxzrvw3KT0GedEG3GIhIJj8ahmtLgkf
        JRYWY9MOpal8MwoIOolVtqnjyuw2rdQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-149-m9A_oBBQPm-nhXqTFR3wHQ-1; Thu, 24 Nov 2022 08:22:10 -0500
X-MC-Unique: m9A_oBBQPm-nhXqTFR3wHQ-1
Received: by mail-wr1-f69.google.com with SMTP id g14-20020adfa48e000000b00241f94bcd54so408013wrb.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 05:22:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Af+/dAibosKqrfLx5kNJxNqzWHdIAvebWVY3liLga6Q=;
        b=1ctkwqncKVP66+ZOSVCMMao6jz4HdN9f9w+rcGAlWtMOqHZphaxAaGmmGHR4m89SvZ
         uaMHKWXRDbSAEa8ARnEXUdd7/Pyg/0aSY6lbKcSyLYll6NCorZ2OtIpWxqiuHS0RfsPJ
         JLIu5HTqdziLTNMVyqs/T8t+Cc2kCjUF9JQpPFPc7tKLrkFuCSfrsg0EtkONHm14wDR9
         P/ICTKGV7OisO99gl2FAnARgfwhhhV6Lc5IJxb8Xs5rvRrvkyy5NNsTlu7iiWau5wFIt
         LVrkd0BqCNvliLwmDGepa6cNrHRwNl4q5fr8ZvrTgr6YEl3dQ7gOniAfv/XD96oGlJoF
         NBpg==
X-Gm-Message-State: ANoB5plZNjRvrk3RypN1h58gBfRLKrR48HbkQv2DqsjWNHj5r0XpDAa9
        URNEDQx6E2vg0h66VoZUrcRagvIhdah34wrK5WZ7q28Af49mrC2e4EKZab2O8fM5X//LuUnAMg3
        nGhaE+LBgjYKzcwiTnOCsXD0K
X-Received: by 2002:a5d:51ce:0:b0:236:78cd:f3e7 with SMTP id n14-20020a5d51ce000000b0023678cdf3e7mr19408572wrv.140.1669296128845;
        Thu, 24 Nov 2022 05:22:08 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5TQUNmfgh7Sqy+ZunwQXBpN+8GFhklx6qTEjDOXChgxzsOtIJbZHo8TL9fwJbGKfMfkrSfhQ==
X-Received: by 2002:a5d:51ce:0:b0:236:78cd:f3e7 with SMTP id n14-20020a5d51ce000000b0023678cdf3e7mr19408553wrv.140.1669296128515;
        Thu, 24 Nov 2022 05:22:08 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:2200:bfcb:7212:1370:de13? (p200300cbc7042200bfcb72121370de13.dip0.t-ipconnect.de. [2003:cb:c704:2200:bfcb:7212:1370:de13])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b002366f9bd717sm1694091wrw.45.2022.11.24.05.22.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Nov 2022 05:22:08 -0800 (PST)
Message-ID: <759a17cf-e234-2601-bf42-7a40a4d89466@redhat.com>
Date:   Thu, 24 Nov 2022 14:22:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2] mm: migrate: Fix THP's mapcount on isolation
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        william.kucharski@oracle.com, ziy@nvidia.com,
        kirill.shutemov@linux.intel.com, zhenyzha@redhat.com,
        apopple@nvidia.com, hughd@google.com, willy@infradead.org,
        shan.gavin@gmail.com
References: <20221124095523.31061-1-gshan@redhat.com>
 <3c584ce6-dc8c-e0e4-c78f-b59dfff1fc13@redhat.com>
 <22407f18-0406-6ede-ef1e-592f03d3699e@redhat.com>
 <31bda0ab-a185-340d-b96b-b1cfed7c3910@redhat.com>
 <da854e1c-c876-b2f3-a2cb-56664da541bf@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <da854e1c-c876-b2f3-a2cb-56664da541bf@redhat.com>
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

On 24.11.22 13:55, Gavin Shan wrote:
> On 11/24/22 6:43 PM, David Hildenbrand wrote:
>> On 24.11.22 11:21, Gavin Shan wrote:
>>> On 11/24/22 6:09 PM, David Hildenbrand wrote:
>>>> On 24.11.22 10:55, Gavin Shan wrote:
>>>>> The issue is reported when removing memory through virtio_mem device.
>>>>> The transparent huge page, experienced copy-on-write fault, is wrongly
>>>>> regarded as pinned. The transparent huge page is escaped from being
>>>>> isolated in isolate_migratepages_block(). The transparent huge page
>>>>> can't be migrated and the corresponding memory block can't be put
>>>>> into offline state.
>>>>>
>>>>> Fix it by replacing page_mapcount() with total_mapcount(). With this,
>>>>> the transparent huge page can be isolated and migrated, and the memory
>>>>> block can be put into offline state. Besides, The page's refcount is
>>>>> increased a bit earlier to avoid the page is released when the check
>>>>> is executed.
>>>>
>>>> Did you look into handling pages that are in the swapcache case as well?
>>>>
>>>> See is_refcount_suitable() in mm/khugepaged.c.
>>>>
>>>> Should be easy to reproduce, let me know if you need inspiration.
>>>>
>>>
>>> Nope, I didn't look into the case. Please elaborate the details so that
>>> I can reproduce it firstly.
>>
>>
>> A simple reproducer would be (on a system with ordinary swap (not zram))
>>
>> 1) mmap a region (MAP_ANON|MAP_PRIVATE) that can hold a THP
>>
>> 2) Enable THP for that region (MADV_HUGEPAGE)
>>
>> 3) Populate a THP (e.g., write access)
>>
>> 4) PTE-map the THP, for example, using MADV_FREE on the last subpage
>>
>> 5) Trigger swapout of the THP, for example, using MADV_PAGEOUT
>>
>> 6) Read-access to some subpages to fault them in from the swapcache
>>
>>
>> Now you'd have a THP, which
>>
>> 1) Is partially PTE-mapped into the page table
>> 2) Is in the swapcache (each subpage should have one reference from the swapache)
>>
>>
>> Now we could test, if alloc_contig_range() will still succeed (e.g., using virtio-mem).
>>
> 
> Thanks for the details. Step (4) and (5) can be actually combined. To swap part of
> the THP (e.g. one sub-page) will force the THP to be split.
> 
> I followed your steps in the attached program, there is no issue to do memory hot-remove
> through virtio-mem with or without this patch.

Interesting. But I don't really see how we could pass this check with a 
page that's in the swapcache, maybe I'm missing something else.

I'll try to see if I can reproduce it.

-- 
Thanks,

David / dhildenb

