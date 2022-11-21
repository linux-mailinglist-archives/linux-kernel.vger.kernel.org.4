Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACA2632754
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiKUPIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbiKUPHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:07:36 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8E0630C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 06:57:16 -0800 (PST)
Received: from [192.168.10.9] (unknown [39.45.241.105])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: usama.anjum)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8623666029A5;
        Mon, 21 Nov 2022 14:57:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669042634;
        bh=SUxqx2ct+YMAWPyZQcYXUyYo4xyFn2Xq74LW6CRW/UM=;
        h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
        b=WTcL3k3D5NZH/YqSRA58tsyvHXmhFUvWvjOma9SFxR7EY66rMcNldGyBxuf7n/zJn
         3z+c3pzeNNzVR/KgEanB+kUDKkOxZNT75be7l/tIC+rll7bGtgasBNVsXaqbf27bWv
         6ZM77e6euue8FNuIswWMKIhB1p/ZzqPMn0t4qxVeXMIkzmHRZDI5xo52IZh+TOzG3r
         Fg57qfv7A01YqWa70ND+sgjXuj4i0RKHuuVMLjN0tQri2iNkpSlyepKpp1K6Ap7QnA
         b7tEqaWkCX/R2scWx8OBUlqvfYYcNQEiInNEKu4Nkw23LUaieEAaUbtSU32jJO2erB
         zHI6ouppmNb6Q==
Message-ID: <a9984aa6-41bc-17c3-b564-87b997c0f2d0@collabora.com>
Date:   Mon, 21 Nov 2022 19:57:05 +0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        David Hildenbrand <david@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 1/3] mm/mprotect: Fix soft-dirty check in
 can_change_pte_writable()
Content-Language: en-US
To:     Peter Xu <peterx@redhat.com>
References: <20220725142048.30450-1-peterx@redhat.com>
 <20220725142048.30450-2-peterx@redhat.com>
 <b75653b8-5264-ca03-bf5c-671e07e7fdd8@collabora.com> <Y3gRy8pUiYWFGqcI@x1n>
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <Y3gRy8pUiYWFGqcI@x1n>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Thank you so much for replying.

On 11/19/22 4:14 AM, Peter Xu wrote:
> On Sat, Nov 19, 2022 at 01:16:26AM +0500, Muhammad Usama Anjum wrote:
>> Hi Peter and David,
> 
> Hi, Muhammad,
> 
>>
>> On 7/25/22 7:20 PM, Peter Xu wrote:
>>> The check wanted to make sure when soft-dirty tracking is enabled we won't
>>> grant write bit by accident, as a page fault is needed for dirty tracking.
>>> The intention is correct but we didn't check it right because VM_SOFTDIRTY
>>> set actually means soft-dirty tracking disabled.  Fix it.
>> [...]
>>> +static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
>>> +{
>>> +	/*
>>> +	 * NOTE: we must check this before VM_SOFTDIRTY on soft-dirty
>>> +	 * enablements, because when without soft-dirty being compiled in,
>>> +	 * VM_SOFTDIRTY is defined as 0x0, then !(vm_flags & VM_SOFTDIRTY)
>>> +	 * will be constantly true.
>>> +	 */
>>> +	if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
>>> +		return false;
>>> +
>>> +	/*
>>> +	 * Soft-dirty is kind of special: its tracking is enabled when the
>>> +	 * vma flags not set.
>>> +	 */
>>> +	return !(vma->vm_flags & VM_SOFTDIRTY);
>>> +}
>> I'm sorry. I'm unable to understand the inversion here.
>>> its tracking is enabled when the vma flags not set.
>> VM_SOFTDIRTY is set on the VMA when new VMA is allocated to mark is
>> soft-dirty. When we write to clear_refs to clear soft-dirty bit,
>> VM_SOFTDIRTY is cleared from the VMA as well. Then why do you say tracking
>> is enabled when the vma flags not set?
> 
> Because only when 4>clear_refs happens would VM_SOFTDIRTY be cleared, and
> only until then the real tracking starts (by removing write bits on ptes).
But even if the VM_SOFTDIRTY is set on the VMA, the individual pages are
still marked soft-dirty. Both are independent.

It means tracking is enabled all the time in individual pages. Only the
soft-dirty bit status in individual page isn't significant if VM_SOFTDIRTY
already is set. Right?

> 
>> I'm missing some obvious thing.  Maybe the meaning of tracking is to see
>> if VM_SOFTDIRTY needs to be set. If VM_SOFTDIRTY is already set, tracking
>> isn't needed. Can you give an example here?
> 
> If VM_SOFTDIRTY is set, pagemap will treat all pages as soft-dirty, please
> see pagemap_pmd_range():
> 
> 		if (vma->vm_flags & VM_SOFTDIRTY)
> 			flags |= PM_SOFT_DIRTY;
> 
> So fundamentally it reports nothing useful when VM_SOFTDIRTY set.  That's
> also why we need the clear_refs first before we can have anything useful.
> 
> Feel free to reference to the doc page (admin-guide/mm/soft-dirty.rst):
> 
> ---8<---
> The soft-dirty is a bit on a PTE which helps to track which pages a task
> writes to. In order to do this tracking one should
> 
>   1. Clear soft-dirty bits from the task's PTEs.
> 
>      This is done by writing "4" into the ``/proc/PID/clear_refs`` file of the
>      task in question.
> 
>   2. Wait some time.
> 
>   3. Read soft-dirty bits from the PTEs.
> 
>      This is done by reading from the ``/proc/PID/pagemap``. The bit 55 of the
>      64-bit qword is the soft-dirty one. If set, the respective PTE was
>      written to since step 1.
> ---8<---
> 
> The tracking starts at step 1, where is when the flag is cleared.
> 
> Thanks,
> 

-- 
BR,
Muhammad Usama Anjum
