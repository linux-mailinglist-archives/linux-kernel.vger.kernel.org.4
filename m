Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651CC69AB94
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 13:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjBQMbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 07:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjBQMbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 07:31:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C912F66644
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 04:31:27 -0800 (PST)
Received: from [192.168.10.39] (unknown [119.155.16.218])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DA3996600864;
        Fri, 17 Feb 2023 12:31:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676637086;
        bh=w7MN6GDlicUbqaG24KivscjACBzk6TIVqvyY24/C824=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=S4yqOWikkyf4bMJgNY/8+LQuSXF+F1luRq0Lfy4zBX0JGUI9cblFmfBFvaTdgEhva
         1JvsW6SM550FA1mgG7lEaVBucwKX9NiW45Hho5VM5UJH0zvwebiL37zs3N4QLpGjzw
         B7o09wrnmg3Cs1LJJUce/cFzltuWtiUOfzRYSyE1plHT8wWyeIxaMQIKpNbCTGfs07
         ClwrMspMk/ptlpCGzSsnHT+YXzaYZDdZ8gKZxzoe0ufn7QgoMMIPI0e6xgjOE389oc
         ipK9x9KboORqBsY+n3EIEFtsmre0oCYkK8X9HIz4QmCrH9rHBLplgQ7iQza4E445Gg
         13b9XTjw5IW5A==
Message-ID: <427298c4-0da9-059f-02ff-c5147d317c87@collabora.com>
Date:   Fri, 17 Feb 2023 17:31:19 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>
Subject: Re: [PATCH] mm/uffd: UFFD_FEATURE_WP_ZEROPAGE
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
References: <20230215210257.224243-1-peterx@redhat.com>
 <7eb2bce9-d0b1-a0e3-8be3-f28d858a61a0@redhat.com> <Y+5Z+88Z3T2TyxUI@x1n>
 <4f64d62f-c21d-b7c8-640e-d41742bbbe7b@redhat.com> <Y+5uIS5E9sTLi41T@x1n>
 <456f8e2e-9554-73a3-4fdb-be21f9cc54b6@redhat.com> <Y+6NKPuty9V3nycI@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y+6NKPuty9V3nycI@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SORBS_WEB,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/23 1:08 AM, Peter Xu wrote:
>         On Thu, Feb 16, 2023 at 07:23:17PM +0100, David Hildenbrand wrote:
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
> 
>>
>>>>
>>>>>> 2) It would be applicable even when the zeropage is disallowed
>>>>>>      (mm_forbids_zeropage())
>>>>>
>>>>> Do you mean s390 can disable zeropage with mm_uses_skeys()?  So far uffd-wp
>>>>> doesn't support s390 yet, I'm not sure whether we over worried on this
>>>>> effect.
>>>>>
>>>>> Or is there any other projects / ideas that potentially can enlarge forbid
>>>>> zero pages to more contexts?
>>>>
>>>> I think it was shown that zeropages can be used to build covert channels
>>>> (similar to memory deduplciation, because it effectively is memory
>>>> deduplication). It's mentioned as a note in [1] under VII. A. ("Only
>>>> Deduplicate Zero Pages.")
>>>>
>>>>
>>>> [1] https://www.ndss-symposium.org/wp-content/uploads/2022-81-paper.pdf
>>>
>>> Thanks for the link.  I'm slightly confused how dedup of zero pages is a
>>> concern here, though.
>>>
>>> IIUC the security risk is when the dedup-ed pages contain valid information
>>> so the attacker can measure latency of requests when the attemped malicious
>>> page contains exactly the same content of the data page, by trying to
>>> detect the CoW from happening. >
>>> Here it's the zero page, even if there's CoW difference the data being
>>> exposed can only be all zeros?  Then what's the risk?
>>
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
> 
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
> 
>>
>>>
>>>>
>>>>>
>>>>>> 3) It would be possible to optimize even without the huge zeropage, by
>>>>>>      using a PMD marker.
>>>>>
>>>>> This patch doesn't need huge zeropage being exist.
>>>>
>>>> Yes, and for that reason I think it may perform worse than what we already
>>>> have in some cases. Instead of populating a single PMD you'll have to fill a
>>>> full PTE table.
>>>
>>> Yes.  If you think that'll worth it, I can conditionally do pmd zero thp in
>>> a new version.  Maybe it will be a good intermediate step between
>>> introducing pte markers to pmd/pud/etc, so at least we don't need other
>>> changes to coordinate pte markers to higher levels.
>>
>> [...]
>>
>>>>>> Especially when uffd-wp'ing large ranges that are possibly all unpopulated
>>>>>> (thinking about the existing VM background snapshot use case either with
>>>>>> untouched memory or with things like free page reporting), we might neither
>>>>>> be reading or writing that memory any time soon.
>>>>>
>>>>> Right, I think that's a trade-off. But I still think large portion of
>>>>> totally unpopulated memory should be rare case rather than majority, or am
>>>>> I wrong?  Not to mention that requires a more involved changeset to the
>>>>> kernel.
>>>>>
>>>>> So what I proposed here is the (AFAIU) simplest solution towards providing
>>>>> such a feature in a complete form.  I think we have chance to implement it
>>>>> in other ways like pte markers, but that's something we can work upon, and
>>>>> so far I'm not sure how much benefit we can get out of it yet.
>>>>>
>>>>
>>>> What you propose here can already be achieved by user space fairly easily
>>>> (in fact, QEMU implementation could be further sped up using
>>>> MADV_POPULATE_READ). Usually, we only do that when there are very good
>>>> reasons to (performance).
>>>
>>> Yes POPULATE_READ will be faster.  This patch should make it even faster,
>>> because it merges the two walks.
>>>
>>
>> Getting some performance numbers would be nice.
> 
> Sure, I'll collect some data and post a new version.
> 
>>
>>>>
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
>   (1) Memory type limitations (e.g. general fs memories stop working)
>   (2) Tracing uffd application is, afaict, impossible
> 
> So if there's better way to do with soft-dirty or anything else (and I
> assume it'll not be limited to any of above) it's time to say..
I'm on the same boat with you guys about soft-dirty feature. But I'm very
happy after shifting to UFFD WP. We are closer than ever to complete the
feature.

> 
>>
>>>
>>> The other thing is it provides a way to make anon and !anon behave the same
>>> on empty ptes; it's a pity that it was not already like that.
As you must have guessed, we are looking for same behavior on anon and !anon.

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
> From high level, the major functional changes will be:
> 
>   (1) The user will start to receive more WP message with zero page being
>       reported,
> 
>   (2) Wr-protecting a very sparse memory can be much slower
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
I've just ran my single threaded selftest [1] over an over again to get
some numbers.

Without zeropage
qemu has 6 cores: 26.0355
With zeropage
qemu has 6 cores: 39.203

33% worse performance with zero pages

Definitely, there can be better benchmark application. Please let me know
if I should write better benchmarks on my end.

[1]
https://lore.kernel.org/all/20230202112915.867409-7-usama.anjum@collabora.com

> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
