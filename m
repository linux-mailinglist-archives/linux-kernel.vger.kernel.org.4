Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81650650B50
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 13:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbiLSMTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 07:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231993AbiLSMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 07:19:23 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E472CF00A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 04:19:20 -0800 (PST)
Received: from [192.168.10.12] (unknown [39.45.25.143])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B7BB66003EF;
        Mon, 19 Dec 2022 12:19:16 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671452359;
        bh=Fkz+8txKDcicaeIC9mB036Q3Ziqc1S7XLdS0osTQ2/4=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=OOaYhixDWGFqE3vejEvHLy8xD9kzMYpd5fRD3bGI3J8jbdi1qpnCnz6+Tc+ZGNJK1
         WNYGFzQTGqSkDHonTfE0c+f/1QzMyNQ00BjL4SwUzGdhKSmcxeB8JfWMNdXVnYDhrp
         0UfPHT1zITbBIr0W6RNQWOb1UVJt1kv0rD57sKzJgDK/02dSLv4K8AnIaP9TJFF0dk
         mfVKyVsanQRAoEvaRpzfbvK//ADI46Sj6gsGEcM5+eLGsmClFKUDvppjqT3yAKxoQq
         R1Yj4ekutk9AJ1P21cZEb9xNacwynqZmJ4UGbEJsWcLQP/S3rcmxIJRMnoWqJD4+/G
         e5/86rq5GoojA==
Message-ID: <e3c26b56-5458-eb25-c753-fc4c058ba1b1@collabora.com>
Date:   Mon, 19 Dec 2022 17:19:12 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel@collabora.com
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
To:     Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paul Gofman <pgofman@codeweavers.com>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com> <Y3gRy8pUiYWFGqcI@x1n>
 <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com> <Y3vq18eTOE0e7I1+@x1n>
Content-Language: en-US
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y3vq18eTOE0e7I1+@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/22/22 2:17 AM, Peter Xu wrote:
> On Mon, Nov 21, 2022 at 07:57:05PM +0500, Muhammad Usama Anjum wrote:
>> Hi Peter,
>>
>> Thank you so much for replying.
>>
>> On 11/19/22 4:14 AM, Peter Xu wrote:
>>> On Sat, Nov 19, 2022 at 01:16:26AM +0500, Muhammad Usama Anjum wrote:
>>>> Hi Peter and David,
>>>
>>> Hi, Muhammad,
>>>
>>>>
>>>> On 7/25/22 7:20 PM, Peter Xu wrote:
>>>>> The check wanted to make sure when soft-dirty tracking is enabled we won't
>>>>> grant write bit by accident, as a page fault is needed for dirty tracking.
>>>>> The intention is correct but we didn't check it right because VM_SOFTDIRTY
>>>>> set actually means soft-dirty tracking disabled.  Fix it.
>>>> [...]
>>>>> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
>>>>> +{
>>>>> +	/*
>>>>> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
>>>>> +	 * enablements, because when without soft-dirty being compiled in,
>>>>> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
>>>>> +	 * will be constantly true.
>>>>> +	 */
>>>>> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>>>>> +		return false;
>>>>> +
>>>>> +	/*
>>>>> +	 * Soft-dirty is kind of special: its tracking is enabled when the
>>>>> +	 * vma flags not set.
>>>>> +	 */
>>>>> +	return !(vma->vm_flags & VM_SOFTDIRTY);
>>>>> +}
>>>> I'm sorry. I'm unable to understand the inversion here.
>>>>> its tracking is enabled when the vma flags not set.
>>>> VM_SOFTDIRTY is set on the VMA when new VMA is allocated to mark is
>>>> soft-dirty. When we write to clear_refs to clear soft-dirty bit,
>>>> VM_SOFTDIRTY is cleared from the VMA as well. Then why do you say tracking
>>>> is enabled when the vma flags not set?
>>>
>>> Because only when 4>clear_refs happens would VM_SOFTDIRTY be cleared, and
>>> only until then the real tracking starts (by removing write bits on ptes).
>> But even if the VM_SOFTDIRTY is set on the VMA, the individual pages are
>> still marked soft-dirty. Both are independent.
>>
>> It means tracking is enabled all the time in individual pages.
Addition of vma_soft_dirty_enabled() has tinkered with the soft-dirty PTE
bit status setting. The internal behavior has changed. The test case was
shared by David
(https://lore.kernel.org/all/bfcae708-db21-04b4-0bbe-712badd03071@redhat.com/).
The explanation is as following:

_Before_ addition of this patch(76aefad628aae),
m = mmap(2 pages)
clear_softdirty()
mremap(m + pag_size)
mprotect(READ)
mprotect(READ | WRITE);
memset(m)
After memset(),
			PAGE-1		PAGE-2
VM_SOFTDIRTY		set		set
PTE softdirty flag	set		set
/proc//pagemap view	set		set


_After_ addition of this patch(76aefad628aae)
m = mmap(2 pages)
clear_softdirty()
mremap(m + page_size)
mprotect(READ)
mprotect(READ | WRITE);
memset(m)
After memset(),
			PAGE-1		PAGE-2
VM_SOFTDIRTY		set		set
PTE softdirty flag	*not set*	set
/proc//pagemap view	set		set

The user's point of view hasn't changed. But internally after this patch,
the soft-dirty tracking in PTEs gets turn off if VM_SOFTDIRTY is set. The
soft-dirty tracking in the PTEs shouldn't be just turned off when mprotect
is used. Why? Because soft-dirty tracking in the PTEs is always enabled
regardless of VM_SOFTDIRTY is set or not. Example:

m = mem(2 pages)
At this point:
			PAGE-1		PAGE-2
VM_SOFTDIRTY		set		set
PTE softdirty flag	not set		not set
/proc//pagemap view	set		set
memset(m)
At this point:
			PAGE-1		PAGE-2
VM_SOFTDIRTY		set		set
PTE softdirty flag	set		set
/proc//pagemap view	set		set

This example proves that soft-dirty flag on the PTE is set regardless of
the VM_SOFTDIRTY.

The simplest hack to get rid this changed behavior and revert to the
previous behaviour is as following:
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -860,6 +860,8 @@ static inline bool vma_soft_dirty_enabled(struct
vm_area_struct *vma)
        if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
                return false;

+       return true;
+
        /*
         * Soft-dirty is kind of special: its tracking is enabled when the
         * vma flags not set.
I was trying to verify this hack. But I couldn't previously until @Paul has
mentioned this again. I've verified with limited tests that this hack
in-deed works. We are unaware that does this hack create problems in other
areas or not. We can think of better way to solve this. Once we get the
comments from the community.

This internal behavior change is affecting the new feature addition to the
soft-dirty flag which is already delicate and has issues.
(https://lore.kernel.org/all/20221109102303.851281-1-usama.anjum@collabora.com/)

> 
> IMHO it depends on how we define "tracking enabled" - before clear_refs
> even if no pages written they'll also be reported as dirty, then the
> information is useless.
> 
>> Only the soft-dirty bit status in individual page isn't significant if
>> VM_SOFTDIRTY already is set. Right?
> 
> Yes.  But I'd say it makes more sense to say "tracking enabled" if we
> really started tracking (by removing the write bits in ptes, otherwise we
> did nothing).  When vma created we didn't track anything.
> 
> I don't know the rational of why soft-dirty was defined like that.  I think
> it's somehow related to the fact that we allow false positive dirty pages
> not false negative.  IOW, it's a bug to leak a page being dirtied, but not
> vice versa if we report clean page dirty.
> 

-- 
BR,
Muhammad Usama Anjum
