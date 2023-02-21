Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6C69E09A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234777AbjBUMoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:44:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjBUMoR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9FFE8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676983413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETZsrYze6b/dsJhg2EvdcWwE9xEagXOLz8mJbUu8Pv8=;
        b=a3nj97MJN9i1BVqtR9Yo7iXJS7jpOKWLQolKRMwtgVNVctJOntSOtmr7ykHIJVLvsqHigW
        U9sDGydj45f7xuLtYX0h1Op7+NzOgik6y6Cp+J6gQYKnvbptWwma2+E7rUUNeP0wVjdNw/
        wSI4Umsx3qzE4LWf3AKpYEEcuSoJ0zM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-235-msuKydhzN3iVjpyzFYQJOg-1; Tue, 21 Feb 2023 07:43:31 -0500
X-MC-Unique: msuKydhzN3iVjpyzFYQJOg-1
Received: by mail-wm1-f71.google.com with SMTP id m28-20020a05600c3b1c00b003e7d4662b83so665024wms.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:43:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETZsrYze6b/dsJhg2EvdcWwE9xEagXOLz8mJbUu8Pv8=;
        b=3u7WWLgfD0UW9DwFtM+JddKB/nzBqPb6F5yXV/M5jCPMidzZ0INV5vpMvf/uXn/RZ9
         +Hpq76aMYBhylkR32XeJ2IxCqVyEphZKLm83pQ89W6KJXXfJtpYpxqOvofhV6za+X+e9
         CTzdcghxZmHgwrw/8WlLlL3EtjfPUPC65DKGOlDMlymxvLT91tN+BDpu4eS1kBOe/wmp
         3xtBKzZosVrZoPl6a/zPSUDU2OT+U1/VQQHgsEERAxNRQbFcytySYGpakzYoqpKa+A/U
         FgjdPayC/faKDwN0KW+aNzgGUrfj7i4h2mxY7Z3xMYL8OOczyhd65bSnzcvRC4UVpLbT
         KBsA==
X-Gm-Message-State: AO0yUKUsKcf1FZJfofGFSDNqzY4CwRv2VGMTuuLhlOH0ftpoJ7w452Kx
        sueEWrP5kX2JutOdiBT8QT6j6Sp2KZwtyAc4/bv9ljpIp86wbuwTIdfOBqijWdIhn0f7+hjAQ5k
        pxlUQTh3U3rXKRuu0nrolLEo2d5v2KQ==
X-Received: by 2002:a5d:4b88:0:b0:2c5:5d17:3377 with SMTP id b8-20020a5d4b88000000b002c55d173377mr4134677wrt.15.1676983410712;
        Tue, 21 Feb 2023 04:43:30 -0800 (PST)
X-Google-Smtp-Source: AK7set8u3SoygG8BtjawKsIC3M3HoiDq7Vp108dlxFOrGOyzNPoU1mbcgDuiidrZotNa/hTqPBGeuA==
X-Received: by 2002:a5d:4b88:0:b0:2c5:5d17:3377 with SMTP id b8-20020a5d4b88000000b002c55d173377mr4134652wrt.15.1676983410238;
        Tue, 21 Feb 2023 04:43:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4800:aecc:dadb:40a8:ce81? (p200300cbc7074800aeccdadb40a8ce81.dip0.t-ipconnect.de. [2003:cb:c707:4800:aecc:dadb:40a8:ce81])
        by smtp.gmail.com with ESMTPSA id a18-20020adffad2000000b002c56013c07fsm3736714wrs.109.2023.02.21.04.43.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 04:43:29 -0800 (PST)
Message-ID: <c463c421-2f33-9ae3-7d41-b394d1737d42@redhat.com>
Date:   Tue, 21 Feb 2023 13:43:28 +0100
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
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com> <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com> <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com> <Y+6NKPuty9V3nycI@x1n>
 <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com> <Y/AIEvHJoMUnh4b6@x1n>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
In-Reply-To: <Y/AIEvHJoMUnh4b6@x1n>
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

>> "
>> UFFD_FEATURE_WP_UNPOPULATED: for anonymous memory, if PTEs/PMDs are still
>> unpopulated (no page mapped), uffd-wp protection to work will not require a
>> previous manual population (e.g., using MADV_POPULATE_READ). The kernel
>> might or might not populate the shared zeropage for that purpose. So after a
>> uffd-wp protection with UFFD_FEATURE_WP_UNPOPULATED enabled, the PTEs/PMDs
>> might or might not be populated.
>> "
> 
> I would really hope we don't mention "manual population" in the man page or
> header comments for app developers.
> 
> That's "how to workaound some issue", I'll read it as "with flag XXX you
> don't need to work around (issue YYY) by doing ZZZ".
> 
> It's much more straightforward to state what the flag will do.  The
> workaround can be documented somewhere but that shouldn't be in the general
> description of the feature.
> 
> I don't have a strong opinion on the name, though.  I guess you would like
> the new feature to avoid using the term zeropage; I'm fine with changing it.
> 
>>
>> For example, it has to be clear that when doing an uffd-wp protect +
>> unprotect, that there could be suddenly zeropages mapped (observable via
>> uffd-missing later, /proc/pagemap).
>>
>> I'd be fine with something like that.
>>
>> [...]
>>

[...]

>> Similarly, with zeropages (as in your current patch), getting a THP later
>> allocated requires going through khugepaged. In comparison, a PMD marker
>> could more easily avoid that. The huge zeropage can work around that, but
>> you'd still need an MADV_DONTNEED on the hole huge zeropage first to remove
>> it, in order to replace it with a "real" THP.
> 
> IMHO relying on khugepaged is fine.
> 
> Note again that the whole wr-protect idea so far is always talking on
> PAGE_SIZE.  Any write happened in whatever PMD/PUD marker will go into:
> 
>    - A pte marker population storm, which happens _inside_ a page fault of
>      the workload thread (rather than the monitor thread),
> 
>    - The bigger the pte marker (PUD > PMD > PTE), the higher possibility
>      that it'll trigger such a storm as long as any of the page is written.
> 
> It means no matter which way we choose, as long as a write happened the
> whole THP idea will get lost as long as the tracking is still in progress.
> 
> I still think zeropage should be rare in serious productions, I think it's
> more likely that above will happen easily in practise and it can have an
> negative impact on page faults.  Even if we give more chance of having THPs
> in the future, we at least pay something else.  It's hard to tell which is
> more worthwhile.
> 
> Not to mention that'll introduce more compexity to the kernel besides the
> anonymous support, which should still be relatively straightforward.
> 
> So I'm fine with switching to pte markers, but I'd leave the PMD+ markers
> alone for now.
> 
[...]

>>
>>>
>>> I wasn't really eager on this before because the workaround of pre-read
>>> works good already (I assume slightly slower but it's fine; not until
>>> someone starts to worry).  But if we want to extend soft-dirty that's not
>>> good at all to have any new user being requested to prefault memory and
>>> figuring out why it's needed.
>>>
>>>>
>>>> Having that said, I have the feeling that you and Muhammad have a plan to
>>>> make it work using uffd-wp and I won't interfere. It would be nicer to use
>>>> softdirty infrastructure IMHO, though.
>>>
>>> Thanks.  If you have any good idea on reusing soft-dirty, please shoot.
>>> I'll be perfectly happy with it as long as it resolves the issue for
>>> Muhammad.  Trust me - I wished the soft dirty thing worked out, but
>>> unfortunately it didn't..  Because at least so far uffd-wp has two major
>>> issues as I can see:
>>>
>>>     (1) Memory type limitations (e.g. general fs memories stop working)
> 
> [1]
> 
>>>     (2) Tracing uffd application is, afaict, impossible
>>
>> I guess the nice thing is, that you can only track individual ranges, you
>> don't have to enable it for the whole process. I assume softdirty tracking
>> could be similarly extended, but with uffd-wp this comes naturally.
>>
>>>
>>> So if there's better way to do with soft-dirty or anything else (and I
>>> assume it'll not be limited to any of above) it's time to say..
>>
>> I started discussing that [1] but as nobody seemed to care about my input I
>> decided to not further spend my time on that. But maybe it's a more
>> fundamental issue we'd have to solve to get this clean.
> 
> The idea of merging VMAs during clear_refs sounds interesting.

Yes. the required changes would be fairly minimal. But I guess we'd 
still have to tackle some of the other issues to make it work really 
precise. (e.g., MADV_DONTNEED)

> 
>>
>> The problem I had with the original approach is that it required precise
>> softdirty tracking even when nobody cared about softdirty tracking, and that
>> it made wrong assumptions about the meaning of VM_SOFTDIRTY. We shouldn't
>> have to worry about any of that if it's disabled (just like with uffd-wp).
>>
>>
>> The semantical difference I see is that with uffd-wp, initially (pte_none())
>> all PTEs are "dirty". With soft-dirty, initially (pte_none()) all PTEs are
>> "clean". We work around that with VM_SOFTIDRTY, which sets all PTEs of a VMA
>> effectively dirty.
>>
>>
>> Maybe we should rethink that approach and logically track soft-clean
>> instead. That is, everything is assumed to be soft-dirty until we set it
>> clean on a PTE/PMD/PUD level. Setting something clean is wp'ing a PTE and
>> marking it soft-clean (which is, clearing the soft-dirty bit logically).
> 
> To me both solutions should be mostly the same but just inverted bits.  The
> bits (for async) doesn't make sense before the "trigger" is pulled, then
> it's about 0/1 with inverted meanings to me.  It's just that soft-dirty
> will naturally work well with none ptes but uffd-wp is not (since none pte
> has all bits 0).

I think what we really want to avoid is, creating a new VMA and 
requiring to populate page tables just to set the PTEs softdirty.

The VMA flag is one way, but it might prevent merging as we discovered. 
Changing the semantic of "pte_none()" to mean " dirty" is another one.

> 
>>
>> The special case is when we don't have anything mapped yet, which is the
>> same thing we are trying to handle AFAICS for uffd-wp here. A PTE
>> (pte_none()) in which case we have to install a soft-dirty PTE/PMD marker to
>> remember that we marked it as clean -- or map the shared zeropage to mark
>> that one clean (not set the soft-dirty bit).
> 
> Yes, soft-dirty is another valid user to pte markers; that's also in my
> very original proposal of it.  If we can have async-uffd-wp then it's
> easier because the uffd-wp marker will simply be reused naturally.
> 
>>
>> Further, I would propose to have VM_SOFTDIRTY_ENABLED flags per VMA and
>> interfaces to (a) enable/disable it either for some VMAs or the whole MM and
>> (b) a process toggle to automatically enable softclean tracking on new VMAs.
>> So we can really only care about it when someone cares about softdirty
>> tracking. The old "VM_SOFTDIRTY" flag could go, because everything
>> (pte_none()) starts out softdirty. So VM_SOFTDIRTY -> VM_SOFTDIRTY_ENABLED
>> with changed semantics.
>>
>> Enabling softdirty-tracking on a VMA might have to go over PTEs, to make
>> sure we really don't have any soft-clean leftovers due to imprecise
>> soft-dirty tracking on VMA level while it was disabled (setting all PTEs
>> soft-dirty if they not already are). Might require a thought if it's really
>> required.
>>
>> Note that I think this resembles what we are doing with uffd-wp. Not sure if
>> we'd still have to handle some unmap handling on pagecache pages. We might
>> want to remember that they are soft-clean using a PTE marker.
>>
>>
>> Requires some more thought, but I'm going to throw it out here that I think
>> there might be ways to modify softdirty tracking.
> 
> As you mentioned, I think the new proposal is growing into uffd-wp-alike.
> I think that's (maybe) also another reason why reusing uffd here is a good
> idea, because we don't need to reinvent everything.
> 
> Need a new vma flag to identify from old?  Uffd-wp already has it.
> 
> What happens if shmem swapped out?  Uffd-wp handles it.
> 
> Need to be accurate and walk the pgtables?  Uffd-wp does it..

Simply because we cared about getting it precise for uffd-wp, which 
nobody cared for before for soft-dirty. And yes, there are similar 
issues to be solve.

You are much rather turning uffd-wp with the async mode into a 
soft-dirty replacement, instead using what we learned with uffd-wp to 
make soft-dirty more precise.

Fair enough, I won't interfere. The natural way for me to tackle this 
would be to try fixing soft-dirty instead, or handle the details on how 
soft-dirty is implemented internally: not exposing to user space that we 
are using uffd-wp under the hood, for example.


Maybe that would be a reasonable approach? Handle this all internally if 
possible, and remove the old soft-dirty infrastructure once it's working.

We wouldn't be able to use uffd-wp + softdirty, but who really cares I 
guess ...

> 
> One thing I didn't mention before (mostly referring to the 1st major
> "defect" of using uffd-wp above I said [1] on memory types): _maybe_ we can
> someday extend at least async mode of uffd-wp to all memory types, so it'll
> even get everything covered.  So far I don't see a strong requirement of
> doing so, but I don't see a major blocker either.

Architecture support is, of course, another issue. Of course, if we 
could replace soft-dirty tracking by uffd-wp internally that would make 
things easier ...

> 
> While the other "uffd cannot be nested" defect is actually the same to
> soft-dirty (no way to have a tracee being able to clear_refs itself or
> it'll also go a mess), it's just that we can still use soft-dirty to track
> an uffd application.

I wonder if we really care about that. Would be good to know if there 
are any relevant softdirty users still around ... from what I 
understoodm even CRIU wants to handle it using uffd-wp.

> 
>>
>>>>>
>>>>> The other thing is it provides a way to make anon and !anon behave the same
>>>>> on empty ptes; it's a pity that it was not already like that.
>>>>
>>>> In an ideal world, we'd simply be using PTE markers unconditionally I think
>>>> and avoid this zeropage feature :/
>>>>
>>>> Is there any particular reason to have UFFD_FEATURE_WP_ZEROPAGE and not
>>>> simply always do that unconditionally? (sure, we have to indicate to user
>>>> space that it now works as expected) Are we really expecting to break user
>>>> space by protecting what was asked for to protect?
>>>
>>> I suspect so.
>>>
>>>   From high level, the major functional changes will be:
>>>
>>>     (1) The user will start to receive more WP message with zero page being
>>>         reported,
>>>
>>>     (2) Wr-protecting a very sparse memory can be much slower
>>>
>>> I would expect there're cases where the app just works as usual.
>>>
>>> However in some other cases the user may really not care about zero pages
>>> at all, and I had a feeling that's actually the majority.
>>>
>>> Live snapshot is actually special because IIUC the old semantics should
>>> work perfectly if the guest OS won't try to sanity check freed pages being
>>> all zeros..  IOW that's some corner case, and if we can control that we may
>>> not even need WP_ZEROPAGE too for QEMU, iiuc.  For many other apps people
>>> may leverage this (ignoring mem holes) and make the app faster.
>>>
>>> Normally when I'm not confident of any functional change, I'd rather use a
>>> flag.  Luckily uffd is very friendly to that, so the user can have better
>>> control of what to expect.  Some future app may explicitly want to always
>>> ignore zero pages when on extremely sparse mem, and without the flag it
>>> can't choose.
>>>
>>>>
>>>>>
>>>>> We can always optimize this behavior in the future with either
>>>>> PMD/PUD/.. pte markers as you said, but IMHO that just needs further
>>>>> justification on the complexity, and also on whether that's beneficial to
>>>>> the majority to become the default behavior.
>>>>
>>>> As I said, usually any new features require good justification. Maybe there
>>>> really is a measurable performance gain (less syscalls, less pgtable walks).
>>>
>>> Muhammad may have a word to say here; let's see whether he has any comment.
>>>
>>> Besides that, as I replied above I'll collect some data in my next post
>>> regardless, with an attempt to optimize with huge zeropages on top.
>>
>> If we can agree on making the shared zeropage an implementation detail, that
>> would be great and I'd see long-term value in that.
>>
>> [1]
>> https://lkml.kernel.org/r/d95d59d7-308d-831c-d8bd-16d06e66e8af@redhat.com
> 
> So I assume there's no major issue to not continue with a new version, then
> I'll move on.

Jup.

-- 
Thanks,

David / dhildenb

