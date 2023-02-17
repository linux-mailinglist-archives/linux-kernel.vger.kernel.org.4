Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9633569AA95
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjBQLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBQLme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:42:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B06537B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676634105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e12s0BrbaMKX6myWRjalX0UcB1DgMoUPY+5jlPc/G2U=;
        b=drRZhb4TcIQWigvHdYC1TX2piR120ResUD6BjQ78EU6fYNaOQIZ8eeXpbYcp+K1q5vYUh2
        QMFdBHckPQ2tEgwXN+sxRAhbghLidxME3KBbCsYfh3U/nVAoTuyXdf9PFKiVKTU6ZSMjsW
        qP0GOshpPSy4Ux4NELKAR/KrBOPNstk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-331-NfWPP2A6Pf6jnVYlXPHrpQ-1; Fri, 17 Feb 2023 06:41:44 -0500
X-MC-Unique: NfWPP2A6Pf6jnVYlXPHrpQ-1
Received: by mail-wm1-f69.google.com with SMTP id m18-20020a05600c3b1200b003dc5dec2ac6so597847wms.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:41:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e12s0BrbaMKX6myWRjalX0UcB1DgMoUPY+5jlPc/G2U=;
        b=OtxpA/vZnvP/mEFD6cgsp7y1N4/7jZcIwNWqif5aIe3J9C+YbMrhw46tmFTNjqXhzx
         YBiWEgh7WuZRqo7U51XqPyIRpe4QiCaRj4MR1Aht4GXcQayM4uldHFVXczA+2gFsgRqa
         aLUViqwplp7qqQaA3WBR1ebnVzNf8X7vFWhfHAUOy0PSZzv2CKtOGj/7bmZM4K3tTdkP
         9DHG4VrtPJBOv2KschYHUM7ZNDruBsYIXOy2sfVzfrqYYAKLirfhP3ZM/aHB7HE+VmNF
         8ngkxoPZF8NUctKep+PgoMSmWuDpy55nsGnm0YWVhy6bJoAnay9fu1rJNU58owMQiiZZ
         MmBw==
X-Gm-Message-State: AO0yUKUO1/pQzWrXVdHYagNsdxlvizFTB+HKhiT8cx2DCggLmiff9jFv
        CEWON77HLAg0jWXEHaJb9Ob5hw0TuvqOm4UMQZaKBFTpP7eFLkMvJj1QZ7l/mtcj84+7sbT+WU7
        DRghjeWQs1ptRMtzSJT2rx9+30u1o1Q==
X-Received: by 2002:a5d:5611:0:b0:2c5:60e2:ed67 with SMTP id l17-20020a5d5611000000b002c560e2ed67mr7612882wrv.0.1676634102784;
        Fri, 17 Feb 2023 03:41:42 -0800 (PST)
X-Google-Smtp-Source: AK7set+iAYcRwpdqWHbMpqvk/5aFtAIuCl5tL/QrGYAAVPv2fRQLk5l/QQXpJXnPg4DSoIOjUCznyQ==
X-Received: by 2002:a5d:5611:0:b0:2c5:60e2:ed67 with SMTP id l17-20020a5d5611000000b002c560e2ed67mr7612855wrv.0.1676634102267;
        Fri, 17 Feb 2023 03:41:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9800:59ba:1006:9052:fb40? (p200300cbc707980059ba10069052fb40.dip0.t-ipconnect.de. [2003:cb:c707:9800:59ba:1006:9052:fb40])
        by smtp.gmail.com with ESMTPSA id b11-20020adfe30b000000b002c573a6216fsm4114896wrj.37.2023.02.17.03.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 03:41:41 -0800 (PST)
Message-ID: <4dbc9913-3483-d22d-bbd2-e4f510fff56d@redhat.com>
Date:   Fri, 17 Feb 2023 12:41:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
In-Reply-To: <Y+6NKPuty9V3nycI@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.02.23 21:08, Peter Xu wrote:
>          On Thu, Feb 16, 2023 at 07:23:17PM +0100, David Hildenbrand wrote:
>> On 16.02.23 18:55, Peter Xu wrote:
>>> On Thu, Feb 16, 2023 at 06:00:51PM +0100, David Hildenbrand wrote:
>>>>>>
>>>>>> There are various reasons why I think a UFFD_FEATURE_WP_UNPOPULATED, using
>>>>>> PTE markers, would be more benficial:
>>>>>>
>>>>>> 1) It would be applicable to anon hugetlb
>>>>>
>>>>> Anon hugetlb should already work with non ptes with the markers?
>>>>>
>>>>
>>>> ... really? I thought we'd do the whole pte marker handling only when
>>>> dealing with hugetlb/shmem. Interesting, thanks. (we could skip population
>>>> in QEMU in that case as well -- we always do it for now)
>>>
>>> Hmm, you're talking about "anon hugetlb", so it's still hugetlb, right? :)
>>
>> I mean especially MAP_PRIVATE|MAP_HUGETLB|MAP_ANONYMOUS, so "in theory"
>> without any fd and thus pagecache. ... but anon hugetlb keeps confusing me
>> with pagecache handling.
> 
> IIUC when mmap(fd==-1) it's the same as MAP_PRIVATE|MAP_HUGETLB.

Let me rephrase my original statement: I thought we'd do the whole pte 
marker handling only when dealing with MAP_SHARED hugetlb ("hugetlb 
shared memory (shmem)"). So not on MAP_PRIVATE hugetlb where we might 
have anon hugetlb pages.


>> The focus of that paper is on CoW latency yes (and deduplication
>> instantiating shared zeropages -- but building a covert channel using CoW
>> latency might be rather tricky I think, because they will get deduplciated
>> independently of a sender action ...).
>>
>> However, in theory, one could build a covert channel between two VMs simply
>> by using cache flushes and reading from the shared zeropage. Measuring
>> access time can reveal if the sender read the page (L3 filled) or not (L3
>> not filled).
> 
> So the attacker will know when someone reads a zeropage, but I still don't
> get how that can leads to data leak..

Oh, a covert channel is not for leaking data, but for communicating via 
an unofficial channel (bypassing firewalls etc). I also don't think one 
can really leak data with the shared zeropage ... unless that data is 
all zero :)

>>
>> Having that said, I don't think that we are going to disable the shared
>> zeropage because of that for some workloads, I assume in most cases it will
>> simply be way too noisy to transmit any kind of data and we have more
>> critical covert channels to sort out if we want to.
>>
>> Just wanted to raise it because you asked :)
>>
>>>
>>> Another note for s390: when it comes we can consider moving to pte markers
>>> conditionally when !zeropage.  But we can leave that for later.
>>
>> Sure, we could always have another feature flag.
> 
> I think that doesn't need to be another feature flag.  If someone will port
> uffd-wp to s390 we can implement pte markers for WP_ZEROPAGE, then we
> either use it when zeropage not exist, or we can switch to pte markers
> completely too without changing the interface if we want, depending on
> whether we think replacing zeropages with pte markers will be a major issue
> with existing apps.  I don't worry too much on that part.

Then maybe the feature name/description should be more generic, such 
that it's merely an implementation detail that could change?

"
UFFD_FEATURE_WP_UNPOPULATED: for anonymous memory, if PTEs/PMDs are 
still unpopulated (no page mapped), uffd-wp protection to work will not 
require a previous manual population (e.g., using MADV_POPULATE_READ). 
The kernel might or might not populate the shared zeropage for that 
purpose. So after a uffd-wp protection with UFFD_FEATURE_WP_UNPOPULATED 
enabled, the PTEs/PMDs might or might not be populated.
"

For example, it has to be clear that when doing an uffd-wp protect + 
unprotect, that there could be suddenly zeropages mapped (observable via 
  uffd-missing later, /proc/pagemap).

I'd be fine with something like that.

[...]

>>>> Using PTE markers would provide a real advantage IMHO for some users (IMHO
>>>> background snapshots), where we might want to avoid populating
>>>> zeropages/page tables as best as we can completely if the VM memory is
>>>> mostly untouched.
>>>>
>>>> Naturally, I wonder if UFFD_FEATURE_WP_ZEROPAGE is really worth it. Is there
>>>> is another good reason to combine the populate zeropage+wp that I am missing
>>>> (e.g., atomicity by doing both in one operation)?
>>>
>>> It also makes the new WP_ASYNC and pagemap interface clean: we don't want
>>> to have user pre-fault it every time too as a common tactic..  It's hard to
>>> use, and the user doesn't need to know the internals of why it is needed,
>>> either.
>>
>> I feel like we're building a lot of infrastructure on uffd-wp instead of
>> having an alternative softdirty mode (using a world switch?) that works as
>> expected and doesn't require that many uffd-wp extensions. ;)
> 
> We used to discuss this WP_ZEROPAGE before, and I thought we were all happy
> to have that.  Obviously you changed your mind. :)

As I said, I'd be sold on the PTE marker idea, or designing the feature 
more generic that it is an implementation detail. :)

The whole "let's place zeropages" is rather a hack and IMHO suboptimal.

For example, when uffd-wp unprotecting again (e.g., after a VM 
snapshot), we'd be left with zeropages mapped. Getting rid of them (for 
example, to reclaim page tables), will require TLB flushes, mmu 
notifiers, because we had present PTEs. In comparison, the nice thing 
about a PTE marker is that it is !present and you can just rip it out.

Similarly, with zeropages (as in your current patch), getting a THP 
later allocated requires going through khugepaged. In comparison, a PMD 
marker could more easily avoid that. The huge zeropage can work around 
that, but you'd still need an MADV_DONTNEED on the hole huge zeropage 
first to remove it, in order to replace it with a "real" THP.

> 
> I wasn't really eager on this before because the workaround of pre-read
> works good already (I assume slightly slower but it's fine; not until
> someone starts to worry).  But if we want to extend soft-dirty that's not
> good at all to have any new user being requested to prefault memory and
> figuring out why it's needed.
> 
>>
>> Having that said, I have the feeling that you and Muhammad have a plan to
>> make it work using uffd-wp and I won't interfere. It would be nicer to use
>> softdirty infrastructure IMHO, though.
> 
> Thanks.  If you have any good idea on reusing soft-dirty, please shoot.
> I'll be perfectly happy with it as long as it resolves the issue for
> Muhammad.  Trust me - I wished the soft dirty thing worked out, but
> unfortunately it didn't..  Because at least so far uffd-wp has two major
> issues as I can see:
> 
>    (1) Memory type limitations (e.g. general fs memories stop working)
>    (2) Tracing uffd application is, afaict, impossible

I guess the nice thing is, that you can only track individual ranges, 
you don't have to enable it for the whole process. I assume softdirty 
tracking could be similarly extended, but with uffd-wp this comes naturally.

> 
> So if there's better way to do with soft-dirty or anything else (and I
> assume it'll not be limited to any of above) it's time to say..

I started discussing that [1] but as nobody seemed to care about my 
input I decided to not further spend my time on that. But maybe it's a 
more fundamental issue we'd have to solve to get this clean.

The problem I had with the original approach is that it required precise 
softdirty tracking even when nobody cared about softdirty tracking, and 
that it made wrong assumptions about the meaning of VM_SOFTDIRTY. We 
shouldn't have to worry about any of that if it's disabled (just like 
with uffd-wp).


The semantical difference I see is that with uffd-wp, initially 
(pte_none()) all PTEs are "dirty". With soft-dirty, initially 
(pte_none()) all PTEs are "clean". We work around that with 
VM_SOFTIDRTY, which sets all PTEs of a VMA effectively dirty.


Maybe we should rethink that approach and logically track soft-clean 
instead. That is, everything is assumed to be soft-dirty until we set it 
clean on a PTE/PMD/PUD level. Setting something clean is wp'ing a PTE 
and marking it soft-clean (which is, clearing the soft-dirty bit logically).

The special case is when we don't have anything mapped yet, which is the 
same thing we are trying to handle AFAICS for uffd-wp here. A PTE 
(pte_none()) in which case we have to install a soft-dirty PTE/PMD 
marker to remember that we marked it as clean -- or map the shared 
zeropage to mark that one clean (not set the soft-dirty bit).

Further, I would propose to have VM_SOFTDIRTY_ENABLED flags per VMA and 
interfaces to (a) enable/disable it either for some VMAs or the whole MM 
and (b) a process toggle to automatically enable softclean tracking on 
new VMAs. So we can really only care about it when someone cares about 
softdirty tracking. The old "VM_SOFTDIRTY" flag could go, because 
everything (pte_none()) starts out softdirty. So VM_SOFTDIRTY -> 
VM_SOFTDIRTY_ENABLED with changed semantics.

Enabling softdirty-tracking on a VMA might have to go over PTEs, to make 
sure we really don't have any soft-clean leftovers due to imprecise 
soft-dirty tracking on VMA level while it was disabled (setting all PTEs 
soft-dirty if they not already are). Might require a thought if it's 
really required.

Note that I think this resembles what we are doing with uffd-wp. Not 
sure if we'd still have to handle some unmap handling on pagecache 
pages. We might want to remember that they are soft-clean using a PTE 
marker.


Requires some more thought, but I'm going to throw it out here that I 
think there might be ways to modify softdirty tracking.

>>>
>>> The other thing is it provides a way to make anon and !anon behave the same
>>> on empty ptes; it's a pity that it was not already like that.
>>
>> In an ideal world, we'd simply be using PTE markers unconditionally I think
>> and avoid this zeropage feature :/
>>
>> Is there any particular reason to have UFFD_FEATURE_WP_ZEROPAGE and not
>> simply always do that unconditionally? (sure, we have to indicate to user
>> space that it now works as expected) Are we really expecting to break user
>> space by protecting what was asked for to protect?
> 
> I suspect so.
> 
>  From high level, the major functional changes will be:
> 
>    (1) The user will start to receive more WP message with zero page being
>        reported,
> 
>    (2) Wr-protecting a very sparse memory can be much slower
> 
> I would expect there're cases where the app just works as usual.
> 
> However in some other cases the user may really not care about zero pages
> at all, and I had a feeling that's actually the majority.
> 
> Live snapshot is actually special because IIUC the old semantics should
> work perfectly if the guest OS won't try to sanity check freed pages being
> all zeros..  IOW that's some corner case, and if we can control that we may
> not even need WP_ZEROPAGE too for QEMU, iiuc.  For many other apps people
> may leverage this (ignoring mem holes) and make the app faster.
> 
> Normally when I'm not confident of any functional change, I'd rather use a
> flag.  Luckily uffd is very friendly to that, so the user can have better
> control of what to expect.  Some future app may explicitly want to always
> ignore zero pages when on extremely sparse mem, and without the flag it
> can't choose.
> 
>>
>>>
>>> We can always optimize this behavior in the future with either
>>> PMD/PUD/.. pte markers as you said, but IMHO that just needs further
>>> justification on the complexity, and also on whether that's beneficial to
>>> the majority to become the default behavior.
>>
>> As I said, usually any new features require good justification. Maybe there
>> really is a measurable performance gain (less syscalls, less pgtable walks).
> 
> Muhammad may have a word to say here; let's see whether he has any comment.
> 
> Besides that, as I replied above I'll collect some data in my next post
> regardless, with an attempt to optimize with huge zeropages on top.

If we can agree on making the shared zeropage an implementation detail, 
that would be great and I'd see long-term value in that.

[1] 
https://lkml.kernel.org/r/d95d59d7-308d-831c-d8bd-16d06e66e8af@redhat.com

-- 
Thanks,

David / dhildenb

