Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E657873FA20
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 12:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjF0KXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 06:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjF0KWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 06:22:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B812D58
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687861143;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PVciXP+z4zzbCJzP6EwhmNISY1M3S5n3Lib1Z6WDS0Q=;
        b=iPHH+0EfpRlCqi3ks9l/XTwOfFRKexEMXZTXKXvtX5ub/yFJpKz+ZlVoz6RfbU/JmDx/aU
        BcAjI9hrEm0TZ5ugzfzgi6Byu/EyhJ83QBLyidJr6XzH8Tg6N6/DGDMDi5qDtvDkcA4bpz
        F7zTFLFBuu+MhJTDJNDe7Rk20od9c0c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-673-gwixpFgtP0y1moYbpzNPdA-1; Tue, 27 Jun 2023 06:19:01 -0400
X-MC-Unique: gwixpFgtP0y1moYbpzNPdA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31275d62506so1695195f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 03:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687861140; x=1690453140;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PVciXP+z4zzbCJzP6EwhmNISY1M3S5n3Lib1Z6WDS0Q=;
        b=KVqtmrabbVGd0frLMJtIQ+o1n6n0DtiLkaub/rCjhWG+UXBNnjC6zFZdWAB3DLUXiM
         MFm8YrAmf1PMUf14X6QIWNkhcE/jHryZtN/IXJa+aXb08h+wCa9+7OLyqdqd7zC74ZLg
         zgnLIhIjdI+RWJ/e8r6zH3V3+TRik3FzDwqqI6hKK8eYMQnKjKCIDjzZMGo5DYXVl6kT
         Lk4e+noM2twObhlbzuKV96An7pv2tvkrq4NIyHl+vORoXQo1WQbVRGeXboRvcu37Lls4
         XvABerRdnwRDu54FHpMs7FnLeKCd1GSHyYfkW5pbjdRhJdoRKe0VZ49LxDPd4ZdjpFC/
         OfUQ==
X-Gm-Message-State: AC+VfDy8+13xqNvy8hY7hoTGVin2stF77vRqT6sMhpV8cUIHNxmp4Pia
        hwvJpIsjci7pMtM9kM+XEJOATUmDQnJN4vW/YYzPzICoE9roC4/Up3rZJTei2CzE9+IuC93y85p
        FXQAVSOT+rjD1RJ2JOrFSWEzo/8FqTYKE
X-Received: by 2002:adf:ec45:0:b0:30f:c9f5:7370 with SMTP id w5-20020adfec45000000b0030fc9f57370mr11517995wrn.25.1687861140203;
        Tue, 27 Jun 2023 03:19:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ74xMOP2OxaEfjkBONlWibOkqUQKbSlBQnEWXQqsXnxyS5eu5FzrJ2UoqYORap13ob6XHpvQg==
X-Received: by 2002:adf:ec45:0:b0:30f:c9f5:7370 with SMTP id w5-20020adfec45000000b0030fc9f57370mr11517974wrn.25.1687861139751;
        Tue, 27 Jun 2023 03:18:59 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b? (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de. [2003:cb:c737:4900:68b3:e93b:e07a:558b])
        by smtp.gmail.com with ESMTPSA id k5-20020a5d6e85000000b003063a92bbf5sm10048047wrz.70.2023.06.27.03.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 03:18:59 -0700 (PDT)
Message-ID: <1b5ce269-bb54-2f65-6919-8b2bb453c09a@redhat.com>
Date:   Tue, 27 Jun 2023 12:18:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
References: <20230626204612.106165-1-lstoakes@gmail.com>
 <074fc253-beb4-f7be-14a1-ee5f4745c15b@suse.cz>
 <1832a772-93b4-70ad-3a2c-d8da104ce8dd@redhat.com>
 <40cd965f-ba4f-44d8-8e7c-d6267b91a9b3@lucifer.local>
 <57c677d1-9809-966e-5254-f01f59eff7bc@redhat.com>
 <a6ae5c22-80f7-47a5-9ba6-2217f20e673e@lucifer.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/mprotect: allow unfaulted VMAs to be unaccounted on
 mprotect()
In-Reply-To: <a6ae5c22-80f7-47a5-9ba6-2217f20e673e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

>>
>> Yeah, and that needs time and you have to motivate me :)
>>
> 
> Beer? ;)

Oh, that always works :)

> 
>>> Well the motivator for the initial investigation was rppt playing with
>>> R[WO]X (this came from an #mm irc conversation), however in his case he
>>> will be mapping pages between the two.
>>
>> And that's the scenario I think we care about in practice (actually
>> accessing memory).

[...]

>>> In real-use scenarios, yes fuzzers are a thing, but what comes to mind more
>>> immediately is a process that maps a big chunk of virtual memory PROT_NONE
>>> and uses that as part of an internal allocator.
>>>
>>> If the process then allocates memory from this chunk (mprotect() ->
>>> PROT_READ | PROT_WRITE), which then gets freed without being used
>>> (mprotect() -> PROT_NONE) we hit the issue. For OVERCOMMIT_NEVER this could
>>> become quite an issue more so than the VMA fragmentation.
>>
>> Using mprotect() when allocating/freeing memory in an allocator is already
>> horribly harmful for performance (well, and the #VMAs), so I don't think
>> that scenario is relevant in practice.
> 
> Chrome for instance maintains vast memory ranges as PROT_NONE. I've not dug
> into what they're doing, but surely to make use of them they'd need to
> mprotect() or mmap()/mremap() (which maybe is what the intent is)

I suspect they are doing something similar than glibc (and some other 
allocators like jemalloc IIRC), because they want to minimze the #VMAs.

> 
> But fair point. However I can't imagine m[re]map'ing like this would be
> cheap either, as you're doing the same kind of expensive operations, so the
> general _approach_ seems like it's used in some way in practice.

Usually people access memory and not play mprotect() games for fun :)

> 
>>
>> What some allocators (iirc even glibc) do is reserve a bigger area with
>> PROT_NONE and grow the accessible part slowly on demand, discarding freed
>> memory using MADV_DONTNEED. So you essentially end up with two VMAs -- one
>> completely accessible, one completely inaccessible.
>>
>> They don't use mprotect() because:
>> (a) It's bad for performance
>> (b) It might increase the #VMAs
>>
>> There is efence, but I remember it simply does mmap()+munmap() and runs into
>> VMA limits easily just by relying on a lot of mappings.
>>
>>
>>>
>>> In addition, I think a user simply doing the artificial test above would
>>> find the split remaining quite confusing, and somebody debugging some code
>>> like this would equally wonder why it happened, so there is benefit in
>>> clarity too (they of course observing the VMA fragmentation from the
>>> perspective of /proc/$pid/[s]maps).
>>
>> My answer would have been "memory gets commited the first time we allow
>> write access, and that wasn't the case for all memory in that range".
>>
>>
>> Now, take your example above and touch the memory.
>>
>>
>> ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
>> mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
>> *(ptr + page_size) = 1;
>> mprotect(ptr + page_size, page_size, PROT_READ);
>>
>>
>> And we'll not merge the VMAs.
>>
>> Which, at least to me, makes existing handling more consistent.
> 
> Indeed, but I don't think it's currently consistent at all.
> 
> The 'correct' solution would be to:-
> 
> 1. account for the block when it becomes writable
> 2. unaccount for any pages not used when it becomes unwritable
> 

I've been messing with something related (but slightly different) for a 
while now in my mind, and I'm not at the point where I can talk about my 
work/idea yet.

But because I've been messing with it, I can comment on some existing 
oddities. Just imagine:

* userfaultfd() can place anon pages even in PROT_NONE areas
* ptrace can place anon pages in PROT_READ areas
* "fun" like the forbidden shared zeropage on s390x in some VMAs can
   place anon pages into PROT_READ areas.

It's all far from "correct" when talking about memory accounting. But it 
seems to get the job done for the most case for now.

> However since we can't go from vma -> folios for anon pages without some
> extreme effort this is not feasible.
> 
> Therefore the existing code hacks it and just keep things accountable.
> 
> The patch reduces the hacking so we get halfway to the correct approach.
> 
> So before: "if you ever make this read/write, we account it forever"
> After: "if you ever make this read/write and USE IT, we account it forever"
> 

"USE" is probably the wrong word. Maybe "MODIFIED", but there are other 
cases (MADV_POPULATE_WRITE)

> To me it is more consistent. Of course this is subjective...
> 
You made the conditional more complicated to make it consistent, won't 
argue with that :)

>>
>> And users could rightfully wonder "why isn't it getting merged". And the
>> answer would be the same: "memory gets commited the first time we allow
>> write access, and that wasn't the case for all memory in that range".
>>
> 
> Yes indeed, a bigger answer is that we don't have fine-grained accounting
> for pages for anon_vma.

Yes, VM_ACCOUNT is all-or nothing, which makes a lot of sense in many 
cases (not in all, though).

[...]

>>
>>>>> So in practice programs will likely do the PROT_WRITE in order to actually
>>>>> populate the area, so this won't trigger as I commented above. But it can
>>>>> still help in some cases and is cheap to do, so:
>>>>
>>>> IMHO we should much rather look into getting hugetlb ranges merged. Mt
>>>> recollection is that we'll never end up merging hugetlb VMAs once split.
>>>
>>> I'm not sure how that's relevant to fragmented non-hugetlb VMAs though?
>>
>> It's a VMA merging issue that can be hit in practice, so I raised it.
>>
>>
>> No strong opinion from my side, just my 2 cents reading the patch
>> description and wondering "why do we even invest time thinking about this
>> case" -- and eventually make handling less consistent IMHO (see above).
> 
> Hmm it seems ilke you have quite a strong opinion :P but this is why I cc-d
> you, as you are a great scrutiniser.

I might make it sound like a strong opinion (because I am challenging 
the motivation), but there is no nak :)

> 
> Yeah, the time investment was just by accident, the patch was originally a
> throwaway thing to prove the point :]
> 
> I very much appreciate your time though! And I owe you at least one beer now.
> 
> I would ask that while you might question the value, whether you think it
> so harmful as not to go in, so Andrew can know whether this debate = don't
> take?
> 
> An Ack-with-meh would be fine. But also if you want to nak, it's also
> fine. I will buy you the beer either way ;)

It's more a "no nak" --  I don't see the real benefit but I also don't 
see the harm (as long as VMA locking is not an issue). If others see the 
benefit, great, so I'll let these decide.

-- 
Cheers,

David / dhildenb

