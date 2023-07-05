Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C960B7489F2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjGERO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbjGEROx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:14:53 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AFF11997
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:14:50 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-bad0c4f6f50so1460490276.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 10:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688577290; x=1691169290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7af1C7YlyT/T6R9rGIVx9ssRIh5Vdv+9xO7E9CdybRo=;
        b=iSLZ0O2KKs3M6OBTAZbJA8Pbl8IJ7pD9oWmJEoEuFTntLNtayUdcgypwjTQFtQpjxs
         nK7adGDmTgiheah7EiiuZupmauVAae1b6lQUq27EYjOqVLXVyqz+9ffqZqmQi2tNa/Pq
         xjIdSpfsfgIUNiadwiukNd5Iw3IxU1wZ/Ur8GX+OXLkN8+PiqSQ9oyGW4vACys+syw1D
         mstEh0BkF19gLe79D0t1X0iLbiluPC0xtrm0IVVodu+CUrNhC76ZDYNeT9teb2xpzoBV
         XsscJU/G5Lz24Q4C90CYRR3qkhqU+2TuGJcc3GCNwhW9plvdLRyE6T0COQjBFpcVz2IL
         jNfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688577290; x=1691169290;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7af1C7YlyT/T6R9rGIVx9ssRIh5Vdv+9xO7E9CdybRo=;
        b=iS6g4OAa8rJ2aZKW0D7j3rKDoMGODplyRr6wugVchM/VC17ll9rfdALpk53rYzyG+x
         ogxy7GnsmUinNaDNNdFpu7pHsfGUCZmDrwNnTiyc/XcluTWr7XUn57opNgdRLwFP0+Ep
         /ByQIwn8oeHF5an4PbFt68lgpQLFcwrMyo+RMP2Ouot1Ca818OZE2zQNDXvkgeAH2nd6
         mTYiN48Pxc7WwgbLAXG/o6kpTxOzp/lXbpJ95ek0VxeXTOdymTnlONBobnCm6U7uNt4i
         YwQFS45v3V7YwBpMWFdik7c0f1y/z81DscXhZwSEdR7HsMb0ck9q/xdEyHCCegz9WYS2
         YXxQ==
X-Gm-Message-State: ABy/qLZ2Sj8RP0TNjp/+nyDQjgUWGq9RjIEKcSK+sfYuxb0ukjcWkz31
        lvVE+ke/x2fHGPjjBbDik5qZdHCFIuKP/Rm/gGL2JQ==
X-Google-Smtp-Source: APBJJlEX3rgKhr8mlEaVqEbAP0IHoIbU3dQBjYg7kFhHKFndrDa9V5NAcLVaYvpx08xjlz8fYPwgK76mxaEeSW0UxTk=
X-Received: by 2002:a25:add6:0:b0:b9e:c516:6e32 with SMTP id
 d22-20020a25add6000000b00b9ec5166e32mr2028417ybe.24.1688577289460; Wed, 05
 Jul 2023 10:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230705063711.2670599-1-surenb@google.com> <20230705063711.2670599-2-surenb@google.com>
 <970295ab-e85d-7af3-76e6-df53a5c52f8b@redhat.com> <CAJuCfpEkzSqsprQE_zLaPF0zefvuAXQJtpYCgGNZzfj4bRr2dw@mail.gmail.com>
In-Reply-To: <CAJuCfpEkzSqsprQE_zLaPF0zefvuAXQJtpYCgGNZzfj4bRr2dw@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 10:14:38 -0700
Message-ID: <CAJuCfpFejoBUSknS=VTEK0gAhOHG3vUe751pxccT-cBGcBquAw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] fork: lock VMAs of the parent process when forking
To:     David Hildenbrand <david@redhat.com>
Cc:     akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 5, 2023 at 9:10=E2=80=AFAM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> On Wed, Jul 5, 2023 at 1:08=E2=80=AFAM David Hildenbrand <david@redhat.co=
m> wrote:
> >
> > On 05.07.23 08:37, Suren Baghdasaryan wrote:
> > > When forking a child process, parent write-protects an anonymous page
> > > and COW-shares it with the child being forked using copy_present_pte(=
).
> > > Parent's TLB is flushed right before we drop the parent's mmap_lock i=
n
> > > dup_mmap(). If we get a write-fault before that TLB flush in the pare=
nt,
> > > and we end up replacing that anonymous page in the parent process in
> > > do_wp_page() (because, COW-shared with the child), this might lead to
> > > some stale writable TLB entries targeting the wrong (old) page.
> > > Similar issue happened in the past with userfaultfd (see flush_tlb_pa=
ge()
> > > call inside do_wp_page()).
> > > Lock VMAs of the parent process when forking a child, which prevents
> > > concurrent page faults during fork operation and avoids this issue.
> > > This fix can potentially regress some fork-heavy workloads. Kernel bu=
ild
> > > time did not show noticeable regression on a 56-core machine while a
> > > stress test mapping 10000 VMAs and forking 5000 times in a tight loop
> > > shows ~5% regression. If such fork time regression is unacceptable,
> > > disabling CONFIG_PER_VMA_LOCK should restore its performance. Further
> > > optimizations are possible if this regression proves to be problemati=
c.
> >
> > Out of interest, did you also populate page tables / pages for some of =
these
> > VMAs, or is this primarily looping over 10000 VMAs that don't actually =
copy any
> > page tables?
>
> I did not populate the page tables, therefore this represents the
> worst case scenario (the share of time used to lock the VMAs is
> maximized).
>
> >
> > >
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3cdf=
51b@kernel.org/
> > > Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> > > Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec2a=
34c@applied-asynchrony.com/
> > > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handling =
first")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > ---
> > >   kernel/fork.c | 1 +
> > >   1 file changed, 1 insertion(+)
> > >
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index b85814e614a5..d2e12b6d2b18 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -686,6 +686,7 @@ static __latent_entropy int dup_mmap(struct mm_st=
ruct *mm,
> > >       for_each_vma(old_vmi, mpnt) {
> > >               struct file *file;
> > >
> > > +             vma_start_write(mpnt);
> > >               if (mpnt->vm_flags & VM_DONTCOPY) {
> > >                       vm_stat_account(mm, mpnt->vm_flags, -vma_pages(=
mpnt));
> > >                       continue;
> >
> > After the mmap_write_lock_killable(), there will still be a period wher=
e page
> > faults can happen. Essentially, page faults can happen for a VMA until =
we lock that VMA.
> >
> > I cannot immediately name something that is broken allowing for that, a=
nd this change
> > should fix the issue at hand, but exotic things like
> >
> >         flush_cache_dup_mm(oldmm);
> >
> > make me wonder if we really want to allow for that or if there is some =
other corner case
> > in fork() handling that really doesn't expect concurrent page faults (a=
nd, thereby, page
> > table modifications) with fork.
> >
> > For example, documentation/core-api/cachetlb.rst says
> >
> > 2) ``void flush_cache_dup_mm(struct mm_struct *mm)``
> >
> >         This interface flushes an entire user address space from
> >         the caches.  That is, after running, there will be no cache
> >         lines associated with 'mm'.
> >
> >         This interface is used to handle whole address space
> >         page table operations such as what happens during fork.
> >
> >         This option is separate from flush_cache_mm to allow some
> >         optimizations for VIPT caches.
> >
>
> I see. So, we really need to lock all VMAs before
> flush_cache_dup_mm(). Makes sense. I'll post an update to this patch
> shortly.

v3 of the patchset with this fix is posted at
https://lore.kernel.org/all/20230705171213.2843068-1-surenb@google.com/

> Thanks,
> Suren.
>
> >
> > An alternative that requires another VMA walk would be
> >
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 41c964104b58..0f182d3f049b 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -662,6 +662,13 @@ static __latent_entropy int dup_mmap(struct mm_str=
uct *mm,
> >                 retval =3D -EINTR;
> >                 goto fail_uprobe_end;
> >         }
> > +
> > +       /* Disallow any page faults early by locking all VMAs. */
> > +       if (IS_ENABLED(CONFIG_PER_VMA_LOCK)) {
> > +               for_each_vma(old_vmi, mpnt)
> > +                       vma_start_write(mpnt);
> > +               vma_iter_init(old_vmi, old_mm, 0);
> > +       }
> >         flush_cache_dup_mm(oldmm);
> >         uprobe_dup_mmap(oldmm, mm);
> >         /*
> > --
> > 2.41.0
> >
> >
> > Unless there are other thoughts, I guess you change is fine regarding t=
he problem
> > at hand. Not so sure regarding any other corner cases, that's why I'm s=
pelling it out.
> >
> >
> > Acked-by: David Hildenbrand <david@redhat.com>
> >
> > --
> > Cheers,
> >
> > David / dhildenb
> >
