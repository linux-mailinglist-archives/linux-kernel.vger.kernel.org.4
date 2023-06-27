Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451A073F7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 10:49:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjF0ItO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 04:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjF0ItL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 04:49:11 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF07B8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:49:09 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f8775126d3so5780460e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687855747; x=1690447747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dSMCuxbR6i3UVywczVRSw81sy9o/ddDsqyujM139avg=;
        b=o1HmmlGPKrHap3QdACk9rypJuSQP02ua2/AOJlMxbLMT315+60dKUZ2syxKzLDjoz3
         Q5ouAGo1jKMp5ycV8SZiy5bf0tw0FC67/vYH98Iz0Oquh+WnVWtC/6f4ma1aFqOq6gn2
         hCv90Oe049tdtjY5CR66k1rE8HQ7+vnB7X28VZvEauXodMiRtEjRvd1iz5zCM5mlRXpn
         LsPTN/zdUq7Jrr7hGbfQ6+gwepIVqGYWTH37p2uMmts2JBYYXi4/Yefq+DtOCmd3a19P
         yC/Cl+b7cpRiiausl49vpRs/37u44fwabFok0CMLal47hQoMeh5/pB9mX4q6zocE6ZVv
         Batg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687855747; x=1690447747;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSMCuxbR6i3UVywczVRSw81sy9o/ddDsqyujM139avg=;
        b=S4UsZWKfdIOM7Gm1QQXF6cN4/e1Y/xhk2UIK0EOKMhu56ZtOo1RURndCoPSj7+hvM1
         Me+oIkKNg2A4qU4hSEA6QZ7X6dARjNE/p9SiVb7uYEiirEsfRTVO8dtjtIo7qE/REECL
         cdansh/duxaCLax0sy5eXlZHjqBBIOU2FQZ8SIGq7N6SgociwNdneKfaW4Fwi7hRMcez
         PhzkPIDRf64E9BxhysMgdK2gdbwFFmKZ3fDlhM4vgqTjMFXB60QC6MgSglV/+T1q/OZw
         Zl+fo6Fm6ftKOzIXS3Zt/m33QdnJsAPEGqbS8wu/DTuPH9lbCVNAxJTwgFRnZ0xH6540
         DJSQ==
X-Gm-Message-State: AC+VfDyPsSOCrr5fniRE4IkJ8Usm7zytCOhObPAe4DW6CDLh66DOHAmF
        PEbLuxhqwihIvB/Ef2Viu6U=
X-Google-Smtp-Source: ACHHUZ7jxDbDtJNVnIUgNj3sJYjhgJlkHgNl8Hsu60FFtlO324to2ns8dw7cONp/e18hoMAPgTzHJg==
X-Received: by 2002:a19:380d:0:b0:4f8:565e:f4ae with SMTP id f13-20020a19380d000000b004f8565ef4aemr17564887lfa.39.1687855747078;
        Tue, 27 Jun 2023 01:49:07 -0700 (PDT)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b00313eee8c080sm6197012wrv.98.2023.06.27.01.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 01:49:05 -0700 (PDT)
Date:   Tue, 27 Jun 2023 09:49:05 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH] mm/mprotect: allow unfaulted VMAs to be unaccounted on
 mprotect()
Message-ID: <40cd965f-ba4f-44d8-8e7c-d6267b91a9b3@lucifer.local>
References: <20230626204612.106165-1-lstoakes@gmail.com>
 <074fc253-beb4-f7be-14a1-ee5f4745c15b@suse.cz>
 <1832a772-93b4-70ad-3a2c-d8da104ce8dd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1832a772-93b4-70ad-3a2c-d8da104ce8dd@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 08:59:33AM +0200, David Hildenbrand wrote:
> Hi all,
>
> On 27.06.23 08:28, Vlastimil Babka wrote:
> > On 6/26/23 22:46, Lorenzo Stoakes wrote:
> > > When mprotect() is used to make unwritable VMAs writable, they have the
> > > VM_ACCOUNT flag applied and memory accounted accordingly.
> > >
> > > If the VMA has had no pages faulted in and is then made unwritable once
> > > again, it will remain accounted for, despite not being capable of extending
> > > memory usage.
> > >
> > > Consider:-
> > >
> > > ptr = mmap(NULL, page_size * 3, PROT_READ, MAP_ANON | MAP_PRIVATE, -1, 0);
> > > mprotect(ptr + page_size, page_size, PROT_READ | PROT_WRITE);
> > > mprotect(ptr + page_size, page_size, PROT_READ);
> >
> > In the original Mike's example there were actual pages populated, in that
> > case we still won't merge the vma's, right? Guess that can't be helped.
> >
>
> I am clearly missing the motivation for this patch: above is a artificial
> reproducer that I cannot really imagine being relevant in practice.

I cc'd you on this patch exactly because I knew you'd scrutinise it
greatly :)

Well the motivator for the initial investigation was rppt playing with
R[WO]X (this came from an #mm irc conversation), however in his case he
will be mapping pages between the two.

(apologies to rppt, I forgot to add the Reported-By...)

>
> So is there any sane workload that does random mprotect() without even
> touching memory once? Sure, fuzzing, ... artificial reproducers ... but is
> there any real-life problem we're solving here?
>
> IOW, why did you (Lorenzo) invest time optimizing for this andcrafting this
> patch and why should reviewer invest time to understand if it's correct? :)
>

So why I (that Stoakes guy) invested time here was, well I had chased down
the issue for rppt out of curiosity, and 'proved' the point by making
essentially this patch.

I dug into it further and (as the patch message aludes to) have convinced
myself that this is safe, so essentially why NOT submit it :)

In real-use scenarios, yes fuzzers are a thing, but what comes to mind more
immediately is a process that maps a big chunk of virtual memory PROT_NONE
and uses that as part of an internal allocator.

If the process then allocates memory from this chunk (mprotect() ->
PROT_READ | PROT_WRITE), which then gets freed without being used
(mprotect() -> PROT_NONE) we hit the issue. For OVERCOMMIT_NEVER this could
become quite an issue more so than the VMA fragmentation.

In addition, I think a user simply doing the artificial test above would
find the split remaining quite confusing, and somebody debugging some code
like this would equally wonder why it happened, so there is benefit in
clarity too (they of course observing the VMA fragmentation from the
perspective of /proc/$pid/[s]maps).

I believe given we hold a very strong lock (write on mm->mmap_lock) and
that vma->anon_vma being NULL really does seem to imply no pages have been
allocated that this is therefore a safe thing to do and worthwhile.

>
> > > The first mprotect() splits the range into 3 VMAs and the second fails to
> > > merge the three as the middle VMA has VM_ACCOUNT set and the others do not,
> > > rendering them unmergeable.
> > >
> > > This is unnecessary, since no pages have actually been allocated and the
> > > middle VMA is not capable of utilising more memory, thereby introducing
> > > unnecessary VMA fragmentation (and accounting for more memory than is
> > > necessary).
> > >
> > > Since we cannot efficiently determine which pages map to an anonymous VMA,
> > > we have to be very conservative - determining whether any pages at all have
> > > been faulted in, by checking whether vma->anon_vma is NULL.
> > >
> > > We can see that the lack of anon_vma implies that no anonymous pages are
> > > present as evidenced by vma_needs_copy() utilising this on fork to
> > > determine whether page tables need to be copied.
> > >
> > > The only place where anon_vma is set NULL explicitly is on fork with
> > > VM_WIPEONFORK set, however since this flag is intended to cause the child
> > > process to not CoW on a given memory range, it is right to interpret this
> > > as indicating the VMA has no faulted-in anonymous memory mapped.
> > >
> > > If the VMA was forked without VM_WIPEONFORK set, then anon_vma_fork() will
> > > have ensured that a new anon_vma is assigned (and correctly related to its
> > > parent anon_vma) should any pages be CoW-mapped.
> > >
> > > The overall operation is safe against races as we hold a write lock against
> > > mm->mmap_lock.
> > >
> > > If we could efficiently look up the VMA's faulted-in pages then we would
> > > unaccount all those pages not yet faulted in. However as the original
> > > comment alludes this simply isn't currently possible, so we remain
> > > conservative and account all pages or none at all.
> > >
> > > Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
> >
> > So in practice programs will likely do the PROT_WRITE in order to actually
> > populate the area, so this won't trigger as I commented above. But it can
> > still help in some cases and is cheap to do, so:
>
> IMHO we should much rather look into getting hugetlb ranges merged. Mt
> recollection is that we'll never end up merging hugetlb VMAs once split.

I'm not sure how that's relevant to fragmented non-hugetlb VMAs though?

>
> This patch adds code without a clear motivation. Maybe there is a good
> motivation?

See above for motivational thoughts :)

>
> --
> Cheers,
>
> David / dhildenb
>
