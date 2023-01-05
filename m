Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29C365E933
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 11:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjAEKpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 05:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233209AbjAEKpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 05:45:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189F13D9D8
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672915457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dHGUlysATM3xDPfSPCYiDsP85l+XY5+rxynfVJoLVqg=;
        b=I3I6Vwm5Un6i50xBz/1xwyhdWs7CTUf1hBkUFS7uXrcDPaRzri3QWOEO/rvxdHwmBKMMi9
        0JE67e2ZZGPvSzX5BdMul4qF5hRAFFEU2cMTq2+wmZ9gjHOzuU4R4teYU8DTfJKXE5q0Qk
        bGNoFzpuMrNqY2j82oRJwvFI1UXjYsg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-563-RJk1LO_eP9mtYRIZB8GKHQ-1; Thu, 05 Jan 2023 05:44:16 -0500
X-MC-Unique: RJk1LO_eP9mtYRIZB8GKHQ-1
Received: by mail-wm1-f70.google.com with SMTP id j1-20020a05600c1c0100b003d99070f529so812918wms.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 02:44:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dHGUlysATM3xDPfSPCYiDsP85l+XY5+rxynfVJoLVqg=;
        b=5TuuqumCqCj7/SrOwMjATmtOVW+vnN2mzqzH8clp4CW89nyQnfzcj+0vBX6QV8pU9m
         2DojpBsLOuDwAn9iDMM80DawZ1ZCQ8oVfVdjdCsQTfm/7GtCMYfOzix0LVkwfHQLnQ1N
         gP7CvJ1N7hyQnNSfUb8WaEI7EGoks0W59ecIHkNwfVq65L/gqa7m35qq5rrXnjzWmjlz
         tyeuZ8+YmmbLuIMSsGo0WDlGsUXxxGyJVheVdFpkxhg4AH2gsUk7D34sgQQ59j1V6OSA
         QtATvz3+dk2q4ZoDFUfyMEXp6oPRfKc1NxmgAo8tSnmZHZrvWDRPWqnVUruqNMLYBRHh
         aFnA==
X-Gm-Message-State: AFqh2kphanBAk5H5M2/LA4yo/uRasgMAybBKW5d6x/f3cFFmxwdvYnGJ
        rrmLU0hAAZ5ngWgBLpGD1MOblqkk4R/Wlvy44SNN8RumMvBdWk7CrAsMTIT29OgeLIbOetse2iQ
        /tD1Jdx1vTjPhcQSLg7/Jrjh/
X-Received: by 2002:a05:600c:4da0:b0:3d2:3a53:2cd6 with SMTP id v32-20020a05600c4da000b003d23a532cd6mr36441749wmp.9.1672915455426;
        Thu, 05 Jan 2023 02:44:15 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsl4R+7ZBPxCWTZs7iHoDXZlo48wqxcAg3HTZQ0UbVr1JGxsNvD/iszjBEz6cdqocLUbGnWkw==
X-Received: by 2002:a05:600c:4da0:b0:3d2:3a53:2cd6 with SMTP id v32-20020a05600c4da000b003d23a532cd6mr36441736wmp.9.1672915455163;
        Thu, 05 Jan 2023 02:44:15 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e? (p200300cbc7076e00ff02ec7aded5ec1e.dip0.t-ipconnect.de. [2003:cb:c707:6e00:ff02:ec7a:ded5:ec1e])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c339300b003cff309807esm1823807wmp.23.2023.01.05.02.44.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 02:44:14 -0800 (PST)
Message-ID: <86d5f618-800d-9672-56c4-9309ef222a39@redhat.com>
Date:   Thu, 5 Jan 2023 11:44:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <b740c9fb-edba-92ba-59fb-7a5592e5dfc@google.com>
 <dc9f7bb0-77d4-8b0e-c6b6-ece3f77ed326@redhat.com>
 <32be06f-f64-6632-4c36-bed7c0695a3b@google.com>
 <7ff97950-b524-db06-9ad6-e98b80dcfefa@redhat.com>
 <CAHbLzkqjooxnAwqK7vZoJpP2bSUTCUgv3UtWsZgo444jpGSfoA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/khugepaged: fix collapse_pte_mapped_thp() to allow
 anon_vma
In-Reply-To: <CAHbLzkqjooxnAwqK7vZoJpP2bSUTCUgv3UtWsZgo444jpGSfoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.01.23 01:03, Yang Shi wrote:
> On Wed, Jan 4, 2023 at 1:20 AM David Hildenbrand <david@redhat.com> wrote:
>>
>>>> Or am I wrong?
>>>>
>>>>> Is anon_vma lock required?  Almost not: if any page other than expected
>>>>> subpage of the non-anon huge page is found in the page table, collapse is
>>>>> aborted without making any change.  However, it is possible that an anon
>>>>> page was CoWed from this extent in another mm or vma, in which case a
>>>>> concurrent lookup might look here: so keep it away while clearing pmd
>>>>> (but perhaps we shall go back to using pmd_lock() there in future).
>>>>>
>>>>> Note that collapse_pte_mapped_thp() is exceptional in freeing a page table
>>>>> without having cleared its ptes: I'm uneasy about that, and had thought
>>>>> pte_clear()ing appropriate; but exclusive i_mmap lock does fix the problem,
>>>>> and we would have to move the mmu_notification if clearing those ptes.
>>>>>
>>>>> Fixes: 8d3c106e19e8 ("mm/khugepaged: take the right locks for page table
>>>>> retraction")
>>>>> Signed-off-by: Hugh Dickins <hughd@google.com>
>>>>> Cc: Jann Horn <jannh@google.com>
>>>>> Cc: Yang Shi <shy828301@gmail.com>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Cc: Zach O'Keefe <zokeefe@google.com>
>>>>> Cc: Song Liu <songliubraving@fb.com>
>>>>> Cc: <stable@vger.kernel.org>    [5.4+]
>>>>> ---
>>>>> What this fixes is not a dangerous instability!  But I suggest Cc stable
>>>>> because uprobes "healing" has regressed in that way, so this should follow
>>>>> 8d3c106e19e8 into those stable releases where it was backported (and may
>>>>> want adjustment there - I'll supply backports as needed).
>>>>
>>>> If it's really something that doesn't matter in practice (e.g., -1%
>>>> performance while debugging :) ), I guess no CC is needed. If there are real
>>>> production workloads that suffer, I guess ccing stable is fine.
>>>
>>> It's about recovering performance *after* debugging.  It is not something
>>> that is of any value to me personally, nor (so far as I know) to anyone
>>> whom I work with.  But it is something which Song Liu went to the trouble
>>> to make possible in his "THP aware uprobe" series three years ago, and it
>>> is something which Jann unintentionally regressed in his recent commit:
>>> so I thought it proper to reinstate where regressed.
>>
>> Right, although I wonder if that original series fixed a real
>> performance issue or was more a "this makes sense, let's just optimize
>> this corner case by some serious complexity". I hope it's not the latter :)
>>
>>>
>>> (What I do have more of an investment in, is for MADV_COLLAPSE to be able
>>> to collapse some extents in a large vma where some other extent got CoWed,
>>> so giving the whole vma an anon_vma.  But that's not an issue for -stable,
>>> and I cannot tell you offhand whether undoing this anon_vma exclusion is
>>> enough to enable that or not - I suspect not, I suspect a result code or
>>> switch statement needs to be adjusted too.)
>>
>> Yeah, having a single COWed page in a large MAP_PRIVATE file/shmem
>> mapping would disable collapse, so it's the right thing to do.
>>
>> Thinking about it some more, and the effective code change, stable
>> doesn't sound wrong.
>>
>>>>
>>>>
>>>> Side note: set_huge_pmd() wins the award of "ugliest mm function of early
>>>> 2023". I was briefly concerned how do_set_pmd() decides whether the PMD can be
>>>> writable or not. Turns out it's communicated via vm_fault->flags. Just
>>>> horrible.
>>>
>>> I firmly disagree - it's from 2022! and much too small to be ugliest;
>>> but I haven't thought about the aspect that is bothering you there.
>>
>> The ugliest I stumbled over in early 2023 -- until January 2nd :D
>>
>>>
>>> What's bothered me most about it, is the way its name, and the naming of
>>> the do_set_pmd() it interfaces with, give no hint that they are entirely
>>> about file (or shmem) vmas, and would not work right on anon vmas
>>> (I forget whether it's just a matter of which stats updated, or more).
>>
>> Yes. I dug very deep into in-place collapse yesterday because I was
>> briefly concerned about anon THP, and it took me longer to understand
>> that whole machinery than it should (and that anon THP never ever
>> collapse in-place).
>>
>> Some of that khugepaged stuff needs some *serious* cleanups and
>> refactoring. do_set_pmd() is not an exception.
>>
>>
>> Some more examples:
>>
>> if (IS_ENABLED(CONFIG_SHMEM) && vma->vm_file) {
>>          ...
>>          hpage_collapse_scan_file()
>> } else {
>>          hpage_collapse_scan_pmd()
>>          ...
>> }
>>
>>
>> 1) hpage_collapse_scan_pmd() is only for anon memory. Totally obvious
>>      from the name. But why are we potentially calling it for VMAs that
>>      are not applicable? For maximum David confusion?
> 
> IIRC the VMAs are checked before, what do you mean about "not
> applicable"? But anyway khugepaged/MADV_COLLAPSE does release and

I assume when CONFIG_SHMEM=n with ordinary file-thp we'll end up calling it.

> reacquire mmap_lock multiple times, so there are multiple places to
> check VMAs validity.
> 

hpage_collapse_scan_pmd() should be renamed to something like 
hpage_collapse_scan_an/on() and the duplicate code in 
khugepaged_scan_mm_slot() and madvise_collapse() should be factored out 
into something like:

hpage_collapse_scan(vma, addr, cc)
{
	if (vma->vm_file) {
		...
		hpage_collapse_scan_file()
		...
	} else if (vma_is_anonymous(vma)) {
		hpage_collapse_scan_anon()
	} else {
		WARN_ON_ONCE();
	}
}

Any CONFIG_SHMEM etc. optimizations to compile that code out should go 
into hpage_collapse_scan_file() IMHO. ... also properly checking for 
ordinary file THP support.

... and we'd really decide on a terminology "transhuge", "hugepage", 
"hpage", it's a mess. hpage might be easiest, or simply "thp". We just 
need a way to distinguish all that stuff from hugetlb.

>>
>> 2) "IS_ENABLED(CONFIG_SHMEM) && vma->vm_file" is also supposed to cover
>>      ordinary file-thp. Totally obvious from the IS_ENABLED(CONFIG_SHMEM)
>>      ... I probably spent 30minutes understanding what's happening here.
>>      Just misleading and wrong without CONFIG_SHMEM.
>>
>>
>> ... and what's easier to get than this magic set of boolean flags:
>>
>>          hugepage_vma_check(vma, vma->vm_flags, false, false, true)
> 
> This is not perfect. I was thinking about changing them to one flag,
> just like TTU_ flags used by try_to_unmap(). That may make things
> cleaner.
> 

We should provide similar flags to hugepage_vma_revalidate() and just 
replace the "cc" parameter by a way to indicate is_khugepaged. Passing 
in cc is just overkill.

We'd name the functions thp_vma_validate() and thp_vma_revalidate() or 
sth. like that.

>>
>> ... and obviously
>>          hugepage_vma_revalidate()
>> is supposed to be a follow up to a previous
>>          hugepage_vma_check()
>> and totally different from
>>          transhuge_vma_suitable()
>>
>> Hard to make it even less consistent.
> 
> This was after my cleanup, it was much messier before. And I did add
> comments to make them more understandable, but anyway better naming is
> definitely welcome.

Yeah, I appreciate any previous and any future cleanups in that area.

For example: why even *care* about the complexity of installing a PMD in 
collapse_pte_mapped_thp() using set_huge_pmd() just for MADV_COLLAPSE?

Sure, we avoid a single page fault afterwards, but is this *really* 
worth the extra code here? I mean, after we installed the PMD, the page 
could just get reclaimed either way, so there is no guarantee that we 
have a PMD mapped once we return to user space IIUC.


Anyhow, don't want to hijack this thread. I was just forced to 
understand  that code and a lot jumped at me :)

-- 
Thanks,

David / dhildenb

