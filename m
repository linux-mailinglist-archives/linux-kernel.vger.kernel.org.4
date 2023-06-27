Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAF1573F8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjF0Jrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbjF0Jrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:47:36 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2587A2691
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:47:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f8735ac3e3so6047570e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687859252; x=1690451252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qqbmfg2i5tMs+M5sVTXjr7TRPyOp7h8Ot9HK2FLl7/8=;
        b=Eh/Y8zHGV48d6HLSsqcSremmvRGnU3YCMMUgH+95jH/pbfUaZMxz0KmUhS2XPaT53y
         RZTC0yxExfRcW+kw4mQ3x9DNSKi+5iTIJNCJmj3IBLMI4Gpw36UmiPLtr3c2OsIPA/Ih
         KTmmaf/+J08MpqoWUM0CE0uhXwssLvPhuhosfzfZ6sRaOdEru+0Te/A1i2SB4RD/oNJL
         mvoO4JefgNMssm9nsekHT6gPM3vpQ/Bt1sM5GbcfikjE3KCjXrzUdFf7htUa8qbIYrEw
         RCnMKzTZw+ghb35ENZBIMiZnnWGYEegxhmL8QWtulgpTiWxfLhnj96dqfisxA6iWbipn
         Yg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687859252; x=1690451252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qqbmfg2i5tMs+M5sVTXjr7TRPyOp7h8Ot9HK2FLl7/8=;
        b=Yu9vYw81+2vsUrYxGRX6CMHRvOAVQHRFAttc15UAH8NFKSowRgBYLIJxUA7M/wjYbV
         fqh60j2hWPGDUl/A/fzMQl45ksWRH2Z2jv26RC85I7bOpXOUDcV9YOmwts1VItn611i+
         G20ZPZn0Bply5SitWMOJe5YfY+HElj919oJzE7CnK4jkaYr5b/JuyP1BdcTrESH2NGpU
         7/R6kWnDXyawffDfUDqt+RN2fkNqghKC7X/6d3jdJDBb0b3XnLQJhnpTIINt57VCObId
         XmcSFStOmzO4l2ndwMG7S0HS4UX9ckbLutEXJ/xVKY72lo/p2+PhP1iMnHKCT3J+iSif
         WM1w==
X-Gm-Message-State: AC+VfDx5DXdMNVNwUYzlAk5CYF03nshQWiccM3zmPqkuFADD0dnu0hju
        6S7MynAeDiZ9FF0rMc7CkFo=
X-Google-Smtp-Source: ACHHUZ4fbvKkDA8Mwi7hNM5sESO33OduA6ASv5DD93C5iLM5j9HngWwgwKi3Mxqq0baOEvVMXt678Q==
X-Received: by 2002:a05:6512:3e20:b0:4f6:2e4e:e425 with SMTP id i32-20020a0565123e2000b004f62e4ee425mr1532413lfv.50.1687859251911;
        Tue, 27 Jun 2023 02:47:31 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id i18-20020a5d5232000000b003047ae72b14sm9937124wra.82.2023.06.27.02.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 02:47:31 -0700 (PDT)
Date:   Tue, 27 Jun 2023 10:47:30 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mm/mprotect: allow unfaulted VMAs to be unaccounted on
 mprotect()
Message-ID: <a6ae5c22-80f7-47a5-9ba6-2217f20e673e@lucifer.local>
References: <20230626204612.106165-1-lstoakes@gmail.com>
 <074fc253-beb4-f7be-14a1-ee5f4745c15b@suse.cz>
 <1832a772-93b4-70ad-3a2c-d8da104ce8dd@redhat.com>
 <40cd965f-ba4f-44d8-8e7c-d6267b91a9b3@lucifer.local>
 <57c677d1-9809-966e-5254-f01f59eff7bc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c677d1-9809-966e-5254-f01f59eff7bc@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 11:13:59AM +0200, David Hildenbrand wrote:
> On 27.06.23 10:49, Lorenzo Stoakes wrote:
> > On Tue, Jun 27, 2023 at 08:59:33AM +0200, David Hildenbrand wrote:
> > > Hi all,
> > >
> > > On 27.06.23 08:28, Vlastimil Babka wrote:
> > > > On 6/26/23 22:46, Lorenzo Stoakes wrote:
> > > > > When mprotect() is used to make unwritable VMAs writable, they have the
> > > > > VM_ACCOUNT flag applied and memory accounted accordingly.
> > > > >
> > > > > If the VMA has had no pages faulted in and is then made unwritable once
> > > > > again, it will remain accounted for, despite not being capable of extending
> > > > > memory usage.
> > > > >
> > > > > Consider:-
> > > > >
> > > > > ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
> > > > > mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
> > > > > mprotect(ptr + page_size, page_size, PROT_READ);
> > > >
> > > > In the original Mike's example there were actual pages populated, in that
> > > > case we still won't merge the vma's, right? Guess that can't be helped.
> > > >
> > >
> > > I am clearly missing the motivation for this patch: above is a artificial
> > > reproducer that I cannot really imagine being relevant in practice.
> >
> > I cc'd you on this patch exactly because I knew you'd scrutinise it
> > greatly :)
> >
>
> Yeah, and that needs time and you have to motivate me :)
>

Beer? ;)

> > Well the motivator for the initial investigation was rppt playing with
> > R[WO]X (this came from an #mm irc conversation), however in his case he
> > will be mapping pages between the two.
>
> And that's the scenario I think we care about in practice (actually
> accessing memory).

Yes indeed, I mean I am not denying this patch is edge case stuff, in reality
you'd allocate pages, and correctly that would be accountable, the unallocated
R/O bit not and it would remain accountable.

>
> >
> > (apologies to rppt, I forgot to add the Reported-By...)
> >
> > >
> > > So is there any sane workload that does random mprotect() without even
> > > touching memory once? Sure, fuzzing, ... artificial reproducers ... but is
> > > there any real-life problem we're solving here?
> > >
> > > IOW, why did you (Lorenzo) invest time optimizing for this andcrafting this
> > > patch and why should reviewer invest time to understand if it's correct? :)
> > >
> >
> > So why I (that Stoakes guy) invested time here was, well I had chased down
> > the issue for rppt out of curiosity, and 'proved' the point by making
> > essentially this patch.
> >
> > I dug into it further and (as the patch message aludes to) have convinced
> > myself that this is safe, so essentially why NOT submit it :)
> >
> > In real-use scenarios, yes fuzzers are a thing, but what comes to mind more
> > immediately is a process that maps a big chunk of virtual memory PROT_NONE
> > and uses that as part of an internal allocator.
> >
> > If the process then allocates memory from this chunk (mprotect() ->
> > PROT_READ | PROT_WRITE), which then gets freed without being used
> > (mprotect() -> PROT_NONE) we hit the issue. For OVERCOMMIT_NEVER this could
> > become quite an issue more so than the VMA fragmentation.
>
> Using mprotect() when allocating/freeing memory in an allocator is already
> horribly harmful for performance (well, and the #VMAs), so I don't think
> that scenario is relevant in practice.

Chrome for instance maintains vast memory ranges as PROT_NONE. I've not dug
into what they're doing, but surely to make use of them they'd need to
mprotect() or mmap()/mremap() (which maybe is what the intent is)

But fair point. However I can't imagine m[re]map'ing like this would be
cheap either, as you're doing the same kind of expensive operations, so the
general _approach_ seems like it's used in some way in practice.

>
> What some allocators (iirc even glibc) do is reserve a bigger area with
> PROT_NONE and grow the accessible part slowly on demand, discarding freed
> memory using MADV_DONTNEED. So you essentially end up with two VMAs -- one
> completely accessible, one completely inaccessible.
>
> They don't use mprotect() because:
> (a) It's bad for performance
> (b) It might increase the #VMAs
>
> There is efence, but I remember it simply does mmap()+munmap() and runs into
> VMA limits easily just by relying on a lot of mappings.
>
>
> >
> > In addition, I think a user simply doing the artificial test above would
> > find the split remaining quite confusing, and somebody debugging some code
> > like this would equally wonder why it happened, so there is benefit in
> > clarity too (they of course observing the VMA fragmentation from the
> > perspective of /proc/$pid/[s]maps).
>
> My answer would have been "memory gets commited the first time we allow
> write access, and that wasn't the case for all memory in that range".
>
>
> Now, take your example above and touch the memory.
>
>
> ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
> mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
> *(ptr + page_size) = 1;
> mprotect(ptr + page_size, page_size, PROT_READ);
>
>
> And we'll not merge the VMAs.
>
> Which, at least to me, makes existing handling more consistent.

Indeed, but I don't think it's currently consistent at all.

The 'correct' solution would be to:-

1. account for the block when it becomes writable
2. unaccount for any pages not used when it becomes unwritable

However since we can't go from vma -> folios for anon pages without some
extreme effort this is not feasible.

Therefore the existing code hacks it and just keep things accountable.

The patch reduces the hacking so we get halfway to the correct approach.

So before: "if you ever make this read/write, we account it forever"
After: "if you ever make this read/write and USE IT, we account it forever"

To me it is more consistent. Of course this is subjective...

>
> And users could rightfully wonder "why isn't it getting merged". And the
> answer would be the same: "memory gets commited the first time we allow
> write access, and that wasn't the case for all memory in that range".
>

Yes indeed, a bigger answer is that we don't have fine-grained accounting
for pages for anon_vma.

> >
> > I believe given we hold a very strong lock (write on mm->mmap_lock) and
> > that vma->anon_vma being NULL really does seem to imply no pages have been
> > allocated that this is therefore a safe thing to do and worthwhile.
>
> Do we have to care about the VMA locks now that pagefaults can be served
> without the mmap_lock in write mode?

Any switch to VMA locking would need careful attention applied to mprotect
and require equally strong assurances given we are fiddling with entries in
the maple tree (and more broadly the mmap_lock implies something stronger).

>
> [...]
>
> > > > So in practice programs will likely do the PROT_WRITE in order to actually
> > > > populate the area, so this won't trigger as I commented above. But it can
> > > > still help in some cases and is cheap to do, so:
> > >
> > > IMHO we should much rather look into getting hugetlb ranges merged. Mt
> > > recollection is that we'll never end up merging hugetlb VMAs once split.
> >
> > I'm not sure how that's relevant to fragmented non-hugetlb VMAs though?
>
> It's a VMA merging issue that can be hit in practice, so I raised it.
>
>
> No strong opinion from my side, just my 2 cents reading the patch
> description and wondering "why do we even invest time thinking about this
> case" -- and eventually make handling less consistent IMHO (see above).

Hmm it seems ilke you have quite a strong opinion :P but this is why I cc-d
you, as you are a great scrutiniser.

Yeah, the time investment was just by accident, the patch was originally a
throwaway thing to prove the point :]

I very much appreciate your time though! And I owe you at least one beer now.

I would ask that while you might question the value, whether you think it
so harmful as not to go in, so Andrew can know whether this debate = don't
take?

An Ack-with-meh would be fine. But also if you want to nak, it's also
fine. I will buy you the beer either way ;)

>
> --
> Cheers,
>
> David / dhildenb
>
