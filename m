Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D88D749288
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjGFAUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232691AbjGFAUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:20:25 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FF519B6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:20:18 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-c15a5ed884dso70457276.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jul 2023 17:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688602817; x=1691194817;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knzXabcAOJG0/E2AKfeBSXuBhoKGya+QyzfiqVLDY0c=;
        b=p032VP+I2cT4M0GRmBEuHaLjt1qMukmrGcg8nfFGTMhfFwdBKiYmHMidsUKlN72pQJ
         89p0zkgDGkg05ayMLp2Zy15EuH4npY69hHErx+Ej+kA/kC/qzOm3CUzu+xFCHRpnfDnm
         p+KpKUqfjUwdApExidI7GYGs6y1jPKFnFsxomzO7q8al/MgFZF01MxK56YWvcJU0wn5Z
         CpQN8XPo+70kUOPhKaQyYvA604uKpOxsoFZ36HqckrVSP5UAPYW49hCmhn0+PcWwmCgk
         WAJXaJRJc7irtS3p+QPkcUaxDzgRLG+WvpJWgiBHERoneGF7rrpmU/2NPfF8/nnutgVm
         cYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688602817; x=1691194817;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knzXabcAOJG0/E2AKfeBSXuBhoKGya+QyzfiqVLDY0c=;
        b=eQMXkz8KTPOAAuH0QtiaGp/kvCLgdg4NHcA0aej8KItmqTojYv/Cl7du8nadih/Xmo
         ptX24mpJ/bGwslfZD4XEax66EOJ9xm1qoRqWh0lVIabgcgCsB6+93et6nBCd9FCmX1gt
         wKAnday2Bs3ffC5bWtf1VvLpHoUo7dauSWCmtVSau6D2gw5SZD3P+U9p6VRl/0jhqUYK
         uKGKhhVI28YzKaJLuea1VHE6inVZohldik+aBLFbFsyOX7qzZ/aSrTGo3fWFDNT258K9
         0z/wXSqrPEtjXTvYhVuI2AX3g3Qd2U2RZcxc3KCexH7vPElAAEysLhwzh6HEfpRX3hm+
         dBOA==
X-Gm-Message-State: ABy/qLZm1ppjJqO3ItwkcN2nnoCu0HFixLm1JQNHgJM0cG2Nlz1Pr24z
        U33ovnviAUY6QwUoW2y2dkp/1kK5vIxq0ycJD56ttw==
X-Google-Smtp-Source: APBJJlG9B/AgV8ZlpmDyoFeYHyoyaXzxDtkaKfnNIU8/AaWY2+nG/ix41X59c785FqRwTiYk/QEqPu6RBiViX4Se3rM=
X-Received: by 2002:a25:1657:0:b0:bad:125f:9156 with SMTP id
 84-20020a251657000000b00bad125f9156mr353741ybw.35.1688602817224; Wed, 05 Jul
 2023 17:20:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230705171213.2843068-1-surenb@google.com> <20230705171213.2843068-2-surenb@google.com>
 <10c8fe17-fa9b-bf34-cb88-c758e07c9d72@redhat.com> <CAJuCfpFBh647trAjgPfr0Wcd=7V2gbHUnBe8mR4Pgdmrzh6Hxg@mail.gmail.com>
 <20230705230647.twq3n5nb2iabr7uk@revolver>
In-Reply-To: <20230705230647.twq3n5nb2iabr7uk@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 5 Jul 2023 17:20:06 -0700
Message-ID: <CAJuCfpG1GCwvvOWgtHkGCNLk-emOsb_sA2hki5dMriAQzRQQNg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] fork: lock VMAs of the parent process when forking
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        David Hildenbrand <david@redhat.com>,
        akpm@linux-foundation.org, jirislaby@kernel.org,
        jacobly.alt@gmail.com, holger@applied-asynchrony.com,
        hdegoede@redhat.com, michel@lespinasse.org, jglisse@google.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org,
        mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        dhowells@redhat.com, hughd@google.com, bigeasy@linutronix.de,
        kent.overstreet@linux.dev, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, peterjung1337@gmail.com, rientjes@google.com,
        chriscli@google.com, axelrasmussen@google.com, joelaf@google.com,
        minchan@google.com, rppt@kernel.org, jannh@google.com,
        shakeelb@google.com, tatashin@google.com, edumazet@google.com,
        gthelen@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

On Wed, Jul 5, 2023 at 4:07=E2=80=AFPM Liam R. Howlett <Liam.Howlett@oracle=
.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230705 13:24]:
> > On Wed, Jul 5, 2023 at 10:14=E2=80=AFAM David Hildenbrand <david@redhat=
.com> wrote:
> > >
> > > On 05.07.23 19:12, Suren Baghdasaryan wrote:
> > > > When forking a child process, parent write-protects an anonymous pa=
ge
> > > > and COW-shares it with the child being forked using copy_present_pt=
e().
> > > > Parent's TLB is flushed right before we drop the parent's mmap_lock=
 in
> > > > dup_mmap(). If we get a write-fault before that TLB flush in the pa=
rent,
> > > > and we end up replacing that anonymous page in the parent process i=
n
> > > > do_wp_page() (because, COW-shared with the child), this might lead =
to
> > > > some stale writable TLB entries targeting the wrong (old) page.
> > > > Similar issue happened in the past with userfaultfd (see flush_tlb_=
page()
> > > > call inside do_wp_page()).
> > > > Lock VMAs of the parent process when forking a child, which prevent=
s
> > > > concurrent page faults during fork operation and avoids this issue.
> > > > This fix can potentially regress some fork-heavy workloads. Kernel =
build
> > > > time did not show noticeable regression on a 56-core machine while =
a
> > > > stress test mapping 10000 VMAs and forking 5000 times in a tight lo=
op
> > > > shows ~5% regression. If such fork time regression is unacceptable,
> > > > disabling CONFIG_PER_VMA_LOCK should restore its performance. Furth=
er
> > > > optimizations are possible if this regression proves to be problema=
tic.
> > > >
> > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > Reported-by: Jiri Slaby <jirislaby@kernel.org>
> > > > Closes: https://lore.kernel.org/all/dbdef34c-3a07-5951-e1ae-e9c6e3c=
df51b@kernel.org/
> > > > Reported-by: Holger Hoffst=C3=A4tte <holger@applied-asynchrony.com>
> > > > Closes: https://lore.kernel.org/all/b198d649-f4bf-b971-31d0-e8433ec=
2a34c@applied-asynchrony.com/
> > > > Reported-by: Jacob Young <jacobly.alt@gmail.com>
> > > > Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D217624
> > > > Fixes: 0bff0aaea03e ("x86/mm: try VMA lock-based page fault handlin=
g first")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > ---
> > > >   kernel/fork.c | 6 ++++++
> > > >   1 file changed, 6 insertions(+)
> > > >
> > > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > > index b85814e614a5..403bc2b72301 100644
> > > > --- a/kernel/fork.c
> > > > +++ b/kernel/fork.c
> > > > @@ -658,6 +658,12 @@ static __latent_entropy int dup_mmap(struct mm=
_struct *mm,
> > > >               retval =3D -EINTR;
> > > >               goto fail_uprobe_end;
> > > >       }
> > > > +#ifdef CONFIG_PER_VMA_LOCK
> > > > +     /* Disallow any page faults before calling flush_cache_dup_mm=
 */
> > > > +     for_each_vma(old_vmi, mpnt)
> > > > +             vma_start_write(mpnt);
> > > > +     vma_iter_init(&old_vmi, oldmm, 0);
>
> vma_iter_set(&old_vmi, 0) is probably what you want here.

Ok, I send another version with that.

>
> > > > +#endif
> > > >       flush_cache_dup_mm(oldmm);
> > > >       uprobe_dup_mmap(oldmm, mm);
> > > >       /*
> > >
> > > The old version was most probably fine as well, but this certainly lo=
oks
> > > even safer.
> > >
> > > Acked-by: David Hildenbrand <david@redhat.com>
>
> I think this is overkill and believe setting the vma_start_write() will
> synchronize with any readers since it's using the per-vma rw semaphore
> in write mode. Anything faulting will need to finish before the fork
> continues and faults during the fork will fall back to a read lock of
> the mmap_lock.  Is there a possibility of populate happening outside the
> mmap_write lock/vma_lock?

Yes, I think we understand the loss of concurrency in the parent's
ability to fault pages while forking. Is that a real problem though?

>
> Was your benchmarking done with this loop at the start?

No, it was done with the initial version where the lock was inside the
existing loop. I just reran the benchmark and while kernel compilation
times did not change, the stress test shows ~7% regression now,
probably due to that additional tree walk. I'll update that number in
the new patch.
Thanks!

>
> Thanks,
> Liam
