Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E3F6A0BF0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 15:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbjBWOf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 09:35:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjBWOf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 09:35:56 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0845652A
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677162917;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rmG/J6UhZEyANxVD1qAQonZ8Jg4WYoKnPifDyYlQWJU=;
        b=EUVNMqEnIL2Rl0X5etG5lfdOiMUruiIhUEVRjNcAwNUBO31eMEcFO91OyyrRucLYyUnnJ9
        R/VetnmqMuuUbYTZkFBdIrQCDQZHJK2Qcej82T8JykCed8R0qnxtNl/ZFksAh8wGlQ2OE4
        0ya/u/Zx2wSarRO6GKPGwAnzO8Nje1k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-190-JvlLZfJnO2eTckIWMgTtlw-1; Thu, 23 Feb 2023 09:35:16 -0500
X-MC-Unique: JvlLZfJnO2eTckIWMgTtlw-1
Received: by mail-wm1-f71.google.com with SMTP id l16-20020a05600c1d1000b003e77552705cso3407925wms.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 06:35:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rmG/J6UhZEyANxVD1qAQonZ8Jg4WYoKnPifDyYlQWJU=;
        b=c9iSzYpNBZ2JsyvSURFsSCnukfgfZ53zuKmOaOQgfMbXuEMEu7066q7+4arbfDBonR
         Mvc27d0o6RqJLxRw6OprWZBOJdI7fq3Wg4VFXW7GlzLt4NYQPsbmxGcDKf448v6bEHty
         uFxyi0pHdrNZc4OsLJ5k0+nt7XgwCle8oPB2VxgaPgcBAk3KXwPn9RZHeAHOUNhOFDMp
         JS0f2Kao64vkp6MqhgAmr3GbXFM2G9hBMVdlPutXtSLXnFRsgOf0yW13erB6AL+BQjzg
         irfUGMeG7u9lrpLwpHQNbIIuGQJU/SkxQ2CulG1vayjUKUc71tqRUbV32jDN4jHOZ7US
         7kgA==
X-Gm-Message-State: AO0yUKUbDliwNElh1xFs4ju10lOdxQnXhM+vGzmWmXy4ruH3vpBA5Ho1
        kCqmA5NAd7S+nnkx2bAINstkdOoXNKNUF9BEzsmmv7dZOQvt8RX2sY+Ky8QkdYkYmJgXCY6ODzw
        SpSU23ZFLZ3+Mp8oVwAGImYAC
X-Received: by 2002:a5d:4a01:0:b0:2c5:530d:4045 with SMTP id m1-20020a5d4a01000000b002c5530d4045mr11841391wrq.20.1677162915102;
        Thu, 23 Feb 2023 06:35:15 -0800 (PST)
X-Google-Smtp-Source: AK7set+fw4lGLcgaVgQXgtzIDuIzXyxRS3R9Jj8mBI/xsumulea9jkr+bg2pIWA4Y7ahPlxcPNY/uQ==
X-Received: by 2002:a5d:4a01:0:b0:2c5:530d:4045 with SMTP id m1-20020a5d4a01000000b002c5530d4045mr11841366wrq.20.1677162914664;
        Thu, 23 Feb 2023 06:35:14 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c510b00b003e1f2e43a1csm12165392wms.48.2023.02.23.06.35.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 06:35:14 -0800 (PST)
Message-ID: <4b3c2f37-3b84-3147-7513-4293e5408fdd@redhat.com>
Date:   Thu, 23 Feb 2023 15:35:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Muhammad Usama Anjum <usama.anjum@collabora.com>
References: <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com> <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com> <Y+6NKPuty9V3nycI@x1n>
 <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com> <Y/AIEvHJoMUnh4b6@x1n>
 <c463c421-2f33-9ae3-7d41-b394d1737d42@redhat.com> <Y/VQMyssclyIGa5i@x1n>
 <91d7c512-ee57-7d71-34b7-90e45f5c109b@redhat.com> <Y/Z9ACW8l2E3kOVk@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
In-Reply-To: <Y/Z9ACW8l2E3kOVk@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.23 21:37, Peter Xu wrote:
>> Allocating all these page tables to install uffd-wp flags is also one of the
>> things I actually dislike about the new approach just to get more precision.
> 
> My take is that this is unavoidable if we need the accuracy.  More below.

Yes, it's tricky. Ideally, we'd be able to not allocate any page tables 
at all, and only handle the unmap+remap case in a special way, hmmm

> 
>> I wondered if it could be avoided, but my brain started to hurt. Just an
>> idea how to eventually avoid it:
>>
>>
>> We can catch access to these virtual memory that are not populated using
>> UFFD_MISSING mode. When installing a zeropage, we could set the uffd-wp bit.
> 
> Good point. :)
> 
>> But we don't want to mix in the missing mode I guess. But maybe we could use
>> a similar approach for the uffd-wp async mode? Something like the following.
>>
>>
>> We'd want another mode(s?) for that, in addition to _ASYNC mode:
>>
>> (a) When we hit an unpopulated PTE using read-access, we map a fresh page
>> (e.g., zeropage) and set the uffd-wp bit. This will make sure that the next
>> write access triggers uffd-wp.
>>
>> (b) When we hit an unpopulated PTE using write-access, we only map a fresh
>> page (not setting the bit). We would want to trigger uffd-wp in !_ASYNC mode
> 
> Not setting uffd-wp bit sounds dangerous here.  What if right after the
> pgtable pte got setup then another thread writting to it?  I think it's
> data loss.

Sorry, I think what I meant is that we don't set the bit for _ASYNC 
mode. For !_ASYNC mode, we have to set the bit and notify.

> 
>> after that. In _ASYNC mode, all is good.
> 
> IIUC you're suggesting to have a new vma flag (or VM_UFFD_WP + some other
> feature bit, which is fundamentally similar to a new vma flag) to show that
> "when register uffd-wp on this region, protection starts right away".  Then
> it's not pte based, and we don't have problem on pgtable populations
> either.

Yes, that's the problematic bit I've mentioned, thanks for spelling it out.

> 
> True, but it goes back to why we need pte markers.  It has the accuracy,
> alongside with the trade off of using the pgtables.
> 
> Without pte markers and uffd-wp bits everywhere, how do we tell "this pte
> is none" or "even if this pte is none, it has been written before but just
> got zapped, so we don't need to notify again"?

I agree that we do need pte markers. And it's all very tricky :)

I had some idea of using two markers: PTE_UFFD_WP and PT_UFFD_NO_WP, and 
being pte_none() being something fuzzy in between that the application 
knows how to deal with ("not touched since we registered uffd-wp").

The goal would be to not populate page tables just to insert PTE 
markers/zeropages, but to only special case on the "there is a page 
table with a present PTE and we're unmapping something with uffd-wp set 
or uffd-wp not set". Because when we're unmapping we already have a page 
table entry we can just set instead of allocating a page table.

Sorry for throwing semi-finished ideas at you, but the basic idea would 
be to only special case when we're unmapping something: there, we 
already do have a page mapped and can remember uffd-wp-set (clean) vs. 
!uffd-wp-set (dirty).


uffd-wp protecting a range:
* !pte_none() -> set uffd-wp bit and wrprotect
* pte_none() -> nothing to do
* PTE_UFFD_WP -> nothing to do
* PTE_UFFD_NO_WP -> set PTE_UFFD_WP

unmapping a page (old way: !pte_none() -> pte_none()):
* uffd-wp bit set: set PTE_UFFD_WP
* uffd-wp bit not set: set PTE_UFFD_NO_WP

(re)mapping a page (old: pte_none() -> !pte_none()):
* PTE_UFFD_WP -> set pte bit for new PTE
* PTE_UFFD_NO_WP -> don't set pte bit for new PTE
* pte_none() -> set pte bit for new PTE

Zapping an anon page using MADV_DONTNEED is a bit confusing. It's 
actually similar to a memory write (-> write zeroes), but we don't 
notify uffd-wp for that (I think that's something you comment on below). 
Theoretically, we'd want to set PTE_UFFD_NO_WP ("dirty") in the async 
mode. But that might need more thought of what the expected semantics 
actually are.


When we walk over the page tables we would get the following information 
after protecting the range:

* PTE_UFFD_WP -> clean, not modified since last protection round
* PTE_UFFD_NO_WP -> dirty, modified since last protection round
* pte_none() -> not mapped and therefore not modified since beginning of
                 protection.
* !pte_none() -> uffd-wp bit decides

[...]

>>>>
>>>> Fair enough, I won't interfere. The natural way for me to tackle this would
>>>> be to try fixing soft-dirty instead, or handle the details on how soft-dirty
>>>> is implemented internally: not exposing to user space that we are using
>>>> uffd-wp under the hood, for example.
>>>>
>>>>
>>>> Maybe that would be a reasonable approach? Handle this all internally if
>>>> possible, and remove the old soft-dirty infrastructure once it's working.
>>>>
>>>> We wouldn't be able to use uffd-wp + softdirty, but who really cares I guess
>>>> ...
>>>
>>> The thing is userfaultfd is an exposed and formal kernel interface to
>>> userspace already, before / if this new async mode will land.  IMHO it's
>>> necessary in this case to let the user know what's happening inside rather
>>> than thinking this is not important and make decision for the user. We
>>> don't want to surprise anyone I guess..
>>>
>>> It's not only from the angle where an user may be using userfault in its
>>> tracee app, so the user will know why the "new soft-dirty" won't work.
>>>
>>> It's also about maintaining compatible with soft-dirty even if we want to
>>> replace it some day with uffd-wp - it means there'll at least be a period
>>> of having both of them exist, not until we know they're solidly replaceable
>>> between each other.
>>>
>>> So far it's definitely not in that stage.. and they're not alike - it's
>>> just that some of us wanted to have soft-dirty change into something like
>>> uffd-wp, then since the 1st way is not easily achievable, we can try the
>>> other way round.
>>
>> Right. And uffd-wp even supports hugetlb :)
>>
>>>>>
>>>>> While the other "uffd cannot be nested" defect is actually the same to
>>>>> soft-dirty (no way to have a tracee being able to clear_refs itself or
>>>>> it'll also go a mess), it's just that we can still use soft-dirty to track
>>>>> an uffd application.
>>>>
>>>> I wonder if we really care about that. Would be good to know if there are
>>>> any relevant softdirty users still around ... from what I understoodm even
>>>> CRIU wants to handle it using uffd-wp.
>>>
>>> Yeah I don't know either.
>>>
>>>> Jup.
>>>
>>> What does this mean?
>>
>> Yes to the statement "So I assume there's no major issue to not continue
>> with a new version, then I'll move on." :)
>>
>> But my idea at the very beginning might make sense to consider: can we
>> instead handle this at fault time and avoid allocating all these page
>> tables. Happy to hear if I am missing something important.
> 
> I've raised my questions above.  I had a feeling that you're thinking for
> anonymous mostly, because shmem is even trickier IIUC, because ptes can
> easily got zapped, then if we only rely on a per-vma attribute, there'll be
> tons of false positives.

Yes, I focused on anon. Let's see if any of the above I said makes sense. :)


Anyhow, what we're discussing here is yet another uffd-wp addition, if 
ever, so don't feel blocked by my comments.

-- 
Thanks,

David / dhildenb

