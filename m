Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559FC635377
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:58:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236784AbiKWI5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbiKWI5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:57:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFFB1001CA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669193802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XWu6+GwCnxbfZ8amHPAOZGcnSFr/fgzIG5mmAP249rA=;
        b=iUo48WjOsO8uH493AC4xUDd0tgqKtvfnicaqCkWQO24n0rsk53uSQSrdJfuuLOwAAuIwGW
        A7aefp91lVAdhoN43f+I0r+UocZlXrjqMfPvxNNVffQhx5Q8rE4MatH0QUR6gWaJKN+Bd4
        pFDtsXkNGFXvIL+3h9Sv3XMQR/p9ACo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-537-Um504RLVOAStI3FOH3Q3zQ-1; Wed, 23 Nov 2022 03:56:41 -0500
X-MC-Unique: Um504RLVOAStI3FOH3Q3zQ-1
Received: by mail-wm1-f69.google.com with SMTP id m34-20020a05600c3b2200b003cf549cb32bso782136wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:56:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWu6+GwCnxbfZ8amHPAOZGcnSFr/fgzIG5mmAP249rA=;
        b=f/x2ioqOTaSEG0M7BLfQUZzJmeziejuXNlAXJsRWgaPTvGYWuJHDCzJkV7bbFJpN3T
         vL4EXSZ/Un6iiC2gQlSFkITVDGVNaEYgtYsGleY1a/+uZrbsi1hDkMFQElrydCwgwg/c
         3U44dQoZqFaz5fiBbhRsxaPi03SVg5abE4m4Fr8nxL4Tk0nFsqi9vqcvE5iUEonpa3Dj
         CXHVhY68sMDXxlh5LLr6dgSKhEYsoxkiAvMofjOIeK/bdxt270p4Zm5D5zUN0yRdz6B3
         Xd3CATUvaxs4QQHmJQtuth4B3ibr62YsGci211OtULVipxQB1XB+i9ilSdOElOu3AET4
         7TTw==
X-Gm-Message-State: ANoB5plOP3aPLwklgUORtYs54ZTvRDUkRhkK8VikDaa/Yzzu81ySOLnL
        h7gtfhtzGi507FGBwM5hKXRBFSKal5FxsJQZLSI32DanqLSM37dy1MbCvcHmxgW+iw/B0SJFd2m
        mjjOhIvXaLwNLnheWoUcBH2qU
X-Received: by 2002:a5d:6486:0:b0:241:ba9c:cc65 with SMTP id o6-20020a5d6486000000b00241ba9ccc65mr15889255wri.443.1669193800382;
        Wed, 23 Nov 2022 00:56:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4uDU75kInYeD9FSmhw8R0V45qBc7elklNLWlIvr+0tClc6/K1z63WfVyYYsckxcZZ6H9Aq8Q==
X-Received: by 2002:a5d:6486:0:b0:241:ba9c:cc65 with SMTP id o6-20020a5d6486000000b00241ba9ccc65mr15889233wri.443.1669193800065;
        Wed, 23 Nov 2022 00:56:40 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:9f00:a98d:4026:7c44:40fd? (p200300cbc7049f00a98d40267c4440fd.dip0.t-ipconnect.de. [2003:cb:c704:9f00:a98d:4026:7c44:40fd])
        by smtp.gmail.com with ESMTPSA id r19-20020a05600c35d300b003c6b874a0dfsm1910509wmq.14.2022.11.23.00.56.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:56:39 -0800 (PST)
Message-ID: <c61612f7-b861-39cf-3e73-dbe4d134eec0@redhat.com>
Date:   Wed, 23 Nov 2022 09:56:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>, Gavin Shan <gshan@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, william.kucharski@oracle.com,
        ziy@nvidia.com, kirill.shutemov@linux.intel.com,
        zhenyzha@redhat.com, shan.gavin@gmail.com, riel@surriel.com,
        willy@infradead.org, apopple@nvidia.com
References: <20221123005752.161003-1-gshan@redhat.com>
 <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: migrate: Fix THP's mapcount on isolation
In-Reply-To: <e8a64b11-98f9-b571-dce9-a60df98e3e5@google.com>
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

On 23.11.22 06:14, Hugh Dickins wrote:
> On Wed, 23 Nov 2022, Gavin Shan wrote:
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
> 
> Interesting, good catch, looked right to me: except for the Fixes line
> and mention of v5.8.  That CoW change may have added a case which easily
> demonstrates the problem, but it would have been the wrong test on a THP
> for long before then - but only in v5.7 were compound pages allowed
> through at all to reach that test, so I think it should be
> 
> Fixes: 1da2f328fa64 ("mm,thp,compaction,cma: allow THP migration for CMA allocations")
> Cc: stable@vger.kernel.org   # v5.7+
> 
> Oh, no, stop: this is not so easy, even in the latest tree.
> 
> Because at the time of that "admittedly racy check", we have no hold
> at all on the page in question: and if it's PageLRU or PageCompound
> at one instant, it may be different the next instant.  Which leaves it
> vulnerable to whatever BUG_ON()s there may be in the total_mapcount()
> path - needs research.  *Perhaps* there are no more BUG_ON()s in the
> total_mapcount() path than in the existing page_mapcount() path.
> 
> I suspect that for this to be safe (before your patch and more so after),
> it will be necessary to shift the "admittedly racy check" down after the
> get_page_unless_zero() (and check the sequence of operations when a
> compound page is initialized).

Grabbing a reference first sounds like the right approach to me.

> 
> The races I'm talking about are much much rarer than the condition you
> are trying to avoid, so it's frustrating; but such races are real,
> and increasing stable's exposure to them is not so good.

Such checks are always racy and the code has to be able to deal with 
false negatives/postives (we're not even holding the page lock); as you 
state, we just don't want to trigger undefined behavior/BUG.


I'm also curious how that migration code handles a THP that's in the 
swapcache. It better should handle such pages correctly, for example, by 
removing them from the swapcache first, otherwise that could block 
migration.


For example, in mm/ksm.c:write_protect_page() we have

"page_mapcount(page) + 1 + swapped != page_count(page)"

page_mapcount() and "swapped==0/1" makes sense to me, because KSM only 
cares about order-0 pages, so no need for THP games.


But we do have an even better helper in place already: 
mm/huge_memory.c:can_split_folio()

Which cares about

a) Swapcache for THP: each subpage could be in the swapcache
b) Requires the caller to hold one reference to be safe

But I am a bit confused about the "extra_pins" for !anon. Where do the 
folio_nr_pages() references come from?

So *maybe* it makes sense to factor out can_split_folio() and call it 
something like: "folio_maybe_additionally_referenced"  [to clearly 
distinguish it from "folio_maybe_dma_pinned" that cares about actual 
page pinning (read/write page content)].

Such a function could return false positives/negatives due to races and 
the caller would have to hold one reference and be able to deal with the 
semantics.

-- 
Thanks,

David / dhildenb

