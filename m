Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DDF273F87D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjF0JPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjF0JO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:14:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD6810D8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687857243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ij82bTMq6/uViGwAL8PXDdJMt9B/wmu4cITPZfAQEVw=;
        b=VCEVoP/2JAzlM7h4IvVYr3iyRJWI/hqBiKMIXjAoAmrX5xVJ8HskiGtvpgKKL/m6z5d0kT
        Xb5ZuG30lRJAog9CCcyLPJmcKciodbekCTFk+YOnGkS7u3Z9HgfNcQH1svwpm6m1ZfZrav
        L9QDIoGHeHcPuRgwbAvRQEmB/rQJId4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-oXSKtSVkPJCzMGdGTNqkag-1; Tue, 27 Jun 2023 05:14:02 -0400
X-MC-Unique: oXSKtSVkPJCzMGdGTNqkag-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-313fe11f5e2so325519f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687857241; x=1690449241;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ij82bTMq6/uViGwAL8PXDdJMt9B/wmu4cITPZfAQEVw=;
        b=AhRx0cDDSg+Jcb3XRRfN72leuvUaVIOo1lm17XMaAvTlG50k6hpOFkGx/7P62nzgli
         FiFJHt/eI7UygQCOQIqQ9Gc30EDYLkLGirLS+NpQs0Np/a0ji7qTSLS0osSgQClko9aa
         eJSweanwGZjmL5yxoFhDppbfA71z73Q+OUmbOHfLrOY8Q59C5MIDfZJm5RxpulZfSMLV
         T4MSNw6xOy86gKiAwfE9R5QIDQ0ys0GwX08RcCu92Z0gPLTAgifhlR7q42ztBayGKs5D
         u/DVVSdiMTCzoNA/9HEU9jrgM+dLhH4vYgnInU2MG+QVpau4hmkLlpk69Vj2IIugLOkU
         Pr3A==
X-Gm-Message-State: AC+VfDzyd1hfESaehRSmELRD1761DENkN2hRsfBvzWFYaZleFl0f3i6g
        9jsg0QWHb3byZjGlaRi18vWfnBg//du5lNzuI+QdB+aYyllTrdvKSZ0S2plHQWNsDHSykieogVA
        HxeZBY6Ui9z0W17WaVeTKREAF
X-Received: by 2002:a5d:46c5:0:b0:313:ef93:9e6e with SMTP id g5-20020a5d46c5000000b00313ef939e6emr4982669wrs.24.1687857241228;
        Tue, 27 Jun 2023 02:14:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6tpmhqijmTKVbr0EEyMc4aKWpIkUQzTxfjhoUeKuFM2sfKFuMKThEy+JgS1uhzDpGcIn+Rmw==
X-Received: by 2002:a5d:46c5:0:b0:313:ef93:9e6e with SMTP id g5-20020a5d46c5000000b00313ef939e6emr4982656wrs.24.1687857240727;
        Tue, 27 Jun 2023 02:14:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c737:4900:68b3:e93b:e07a:558b? (p200300cbc737490068b3e93be07a558b.dip0.t-ipconnect.de. [2003:cb:c737:4900:68b3:e93b:e07a:558b])
        by smtp.gmail.com with ESMTPSA id cw8-20020a056000090800b00311d8c2561bsm9750387wrb.60.2023.06.27.02.13.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 02:14:00 -0700 (PDT)
Message-ID: <57c677d1-9809-966e-5254-f01f59eff7bc@redhat.com>
Date:   Tue, 27 Jun 2023 11:13:59 +0200
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm/mprotect: allow unfaulted VMAs to be unaccounted on
 mprotect()
In-Reply-To: <40cd965f-ba4f-44d8-8e7c-d6267b91a9b3@lucifer.local>
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

On 27.06.23 10:49, Lorenzo Stoakes wrote:
> On Tue, Jun 27, 2023 at 08:59:33AM +0200, David Hildenbrand wrote:
>> Hi all,
>>
>> On 27.06.23 08:28, Vlastimil Babka wrote:
>>> On 6/26/23 22:46, Lorenzo Stoakes wrote:
>>>> When mprotect() is used to make unwritable VMAs writable, they have the
>>>> VM_ACCOUNT flag applied and memory accounted accordingly.
>>>>
>>>> If the VMA has had no pages faulted in and is then made unwritable once
>>>> again, it will remain accounted for, despite not being capable of extending
>>>> memory usage.
>>>>
>>>> Consider:-
>>>>
>>>> ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
>>>> mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
>>>> mprotect(ptr + page_size, page_size, PROT_READ);
>>>
>>> In the original Mike's example there were actual pages populated, in that
>>> case we still won't merge the vma's, right? Guess that can't be helped.
>>>
>>
>> I am clearly missing the motivation for this patch: above is a artificial
>> reproducer that I cannot really imagine being relevant in practice.
> 
> I cc'd you on this patch exactly because I knew you'd scrutinise it
> greatly :)
> 

Yeah, and that needs time and you have to motivate me :)

> Well the motivator for the initial investigation was rppt playing with
> R[WO]X (this came from an #mm irc conversation), however in his case he
> will be mapping pages between the two.

And that's the scenario I think we care about in practice (actually 
accessing memory).

> 
> (apologies to rppt, I forgot to add the Reported-By...)
> 
>>
>> So is there any sane workload that does random mprotect() without even
>> touching memory once? Sure, fuzzing, ... artificial reproducers ... but is
>> there any real-life problem we're solving here?
>>
>> IOW, why did you (Lorenzo) invest time optimizing for this andcrafting this
>> patch and why should reviewer invest time to understand if it's correct? :)
>>
> 
> So why I (that Stoakes guy) invested time here was, well I had chased down
> the issue for rppt out of curiosity, and 'proved' the point by making
> essentially this patch.
> 
> I dug into it further and (as the patch message aludes to) have convinced
> myself that this is safe, so essentially why NOT submit it :)
> 
> In real-use scenarios, yes fuzzers are a thing, but what comes to mind more
> immediately is a process that maps a big chunk of virtual memory PROT_NONE
> and uses that as part of an internal allocator.
> 
> If the process then allocates memory from this chunk (mprotect() ->
> PROT_READ | PROT_WRITE), which then gets freed without being used
> (mprotect() -> PROT_NONE) we hit the issue. For OVERCOMMIT_NEVER this could
> become quite an issue more so than the VMA fragmentation.

Using mprotect() when allocating/freeing memory in an allocator is 
already horribly harmful for performance (well, and the #VMAs), so I 
don't think that scenario is relevant in practice.

What some allocators (iirc even glibc) do is reserve a bigger area with 
PROT_NONE and grow the accessible part slowly on demand, discarding 
freed memory using MADV_DONTNEED. So you essentially end up with two 
VMAs -- one completely accessible, one completely inaccessible.

They don't use mprotect() because:
(a) It's bad for performance
(b) It might increase the #VMAs

There is efence, but I remember it simply does mmap()+munmap() and runs 
into VMA limits easily just by relying on a lot of mappings.


> 
> In addition, I think a user simply doing the artificial test above would
> find the split remaining quite confusing, and somebody debugging some code
> like this would equally wonder why it happened, so there is benefit in
> clarity too (they of course observing the VMA fragmentation from the
> perspective of /proc/$pid/[s]maps).

My answer would have been "memory gets commited the first time we allow 
write access, and that wasn't the case for all memory in that range".


Now, take your example above and touch the memory.


ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
*(ptr + page_size) = 1;
mprotect(ptr + page_size, page_size, PROT_READ);


And we'll not merge the VMAs.

Which, at least to me, makes existing handling more consistent.

And users could rightfully wonder "why isn't it getting merged". And the 
answer would be the same: "memory gets commited the first time we allow 
write access, and that wasn't the case for all memory in that range".

> 
> I believe given we hold a very strong lock (write on mm->mmap_lock) and
> that vma->anon_vma being NULL really does seem to imply no pages have been
> allocated that this is therefore a safe thing to do and worthwhile.

Do we have to care about the VMA locks now that pagefaults can be served 
without the mmap_lock in write mode?

[...]

>>> So in practice programs will likely do the PROT_WRITE in order to actually
>>> populate the area, so this won't trigger as I commented above. But it can
>>> still help in some cases and is cheap to do, so:
>>
>> IMHO we should much rather look into getting hugetlb ranges merged. Mt
>> recollection is that we'll never end up merging hugetlb VMAs once split.
> 
> I'm not sure how that's relevant to fragmented non-hugetlb VMAs though?

It's a VMA merging issue that can be hit in practice, so I raised it.


No strong opinion from my side, just my 2 cents reading the patch 
description and wondering "why do we even invest time thinking about 
this case" -- and eventually make handling less consistent IMHO (see above).

-- 
Cheers,

David / dhildenb

