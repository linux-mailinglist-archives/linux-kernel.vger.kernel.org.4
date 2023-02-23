Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C116A113F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBWUaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:30:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjBWUaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:30:15 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D4B59E7F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:30:10 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-536af432ee5so225660787b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CMGzsrET5qE4cm3wL58ElWUmfAVE8Lnnb4W08Pj10+A=;
        b=B6/JiBkDjmKqddTlJFlMqnXK40lAYeDPRS4a3wigdEoxFsz1HP3cZ41O2hEXZV9Xol
         /rRDg2EuqZr4nqAPsi+Nqp2tUvIVu5sXgAPgl2d3pY56FfrlQvdNgLF/0el1elZs0sps
         MYpEft32MAnfenBesVLm9ejdsXPSP8e1VBVq6nYjBaNpd9GqxoaAZyXTGGniZgTblELz
         aIQNB7x2h1Hx32Nv4l8q7wdnu57zyoEQ2TTJOtjZY8xTfiqT5z8Xw6B3ZCMWWL/3u7Hg
         BvGhZFvkbFjcdYBCz+sycnQ5JDiZlEU9TnDAbdR8CsKpngdVEMtZfy5CmGVJkpie5XAW
         fKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CMGzsrET5qE4cm3wL58ElWUmfAVE8Lnnb4W08Pj10+A=;
        b=cTxCl6oJJwAouBSIXg9nrMvWNE5PKGnirZnh/IfJT6ELJZ4eIxpXnCHq9RDDOg4r7Z
         PVWpCxDZAaQIrrxA9DJaHuTLz6LQfNnpiMcGlsguvhYL8KmCXA8amL1D8h731OP/JK4Q
         zBLXHSZopfMQgDXDPiaORe0I0bGFSgNprEL/BT5+ia7seF2zeuo1wIpfkhmFweZ+jN/r
         LcpaUQqVQX+dYKT6tLCRpi2ChzNN/s8+I4q+U1iNKixTL2VyLAK3waTAm53bs7sA5AWR
         6TkjgOxX3KXntH7gI+bg9A8LngANN6BeePvdxgUuIsh7EG414C02B0O3KUoctbWzhdDI
         nAaQ==
X-Gm-Message-State: AO0yUKUdRt+zUhxc2I1BY/sxN2+88gYCNCtsGEqX5Gv+hWcENg57hWJT
        U4OPGdVPEUp6sEwzQce785cLa5ismyAt4deFBrAvEQ==
X-Google-Smtp-Source: AK7set8a9nd1M3o5gtKjXRBIHs8kxt28mAUZ8uoVHl5ofJl5gBClpfYNWL1FfQgENoI8c6BT919QQlLsb6LhXxWAFZ8=
X-Received: by 2002:a05:6902:1449:b0:a06:538f:265f with SMTP id
 a9-20020a056902144900b00a06538f265fmr3251368ybv.4.1677184209550; Thu, 23 Feb
 2023 12:30:09 -0800 (PST)
MIME-Version: 1.0
References: <20230216051750.3125598-1-surenb@google.com> <20230216051750.3125598-24-surenb@google.com>
 <20230223200616.kfnwwpuzuwq5hr7j@revolver>
In-Reply-To: <20230223200616.kfnwwpuzuwq5hr7j@revolver>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 23 Feb 2023 12:29:58 -0800
Message-ID: <CAJuCfpEywUsBxKW5DCHCa_XK45ewhnULia75zoZ9ehW9nsYAMA@mail.gmail.com>
Subject: Re: [PATCH v3 23/35] mm/mmap: prevent pagefault handler from racing
 with mmu_notifier registration
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, peterz@infradead.org, ldufour@linux.ibm.com,
        paulmck@kernel.org, mingo@redhat.com, will@kernel.org,
        luto@kernel.org, songliubraving@fb.com, peterx@redhat.com,
        david@redhat.com, dhowells@redhat.com, hughd@google.com,
        bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com, chriscli@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        rppt@kernel.org, jannh@google.com, shakeelb@google.com,
        tatashin@google.com, edumazet@google.com, gthelen@google.com,
        gurua@google.com, arjunroy@google.com, soheil@google.com,
        leewalsh@google.com, posk@google.com,
        michalechner92@googlemail.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:06 PM Liam R. Howlett
<Liam.Howlett@oracle.com> wrote:
>
> * Suren Baghdasaryan <surenb@google.com> [230216 00:18]:
> > Page fault handlers might need to fire MMU notifications while a new
> > notifier is being registered. Modify mm_take_all_locks to write-lock all
> > VMAs and prevent this race with page fault handlers that would hold VMA
> > locks. VMAs are locked before i_mmap_rwsem and anon_vma to keep the same
> > locking order as in page fault handlers.
> >
> > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > ---
> >  mm/mmap.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 00f8c5798936..801608726be8 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -3501,6 +3501,7 @@ static void vm_lock_mapping(struct mm_struct *mm, struct address_space *mapping)
> >   * of mm/rmap.c:
> >   *   - all hugetlbfs_i_mmap_rwsem_key locks (aka mapping->i_mmap_rwsem for
> >   *     hugetlb mapping);
> > + *   - all vmas marked locked
> >   *   - all i_mmap_rwsem locks;
> >   *   - all anon_vma->rwseml
> >   *
> > @@ -3523,6 +3524,13 @@ int mm_take_all_locks(struct mm_struct *mm)
> >
> >       mutex_lock(&mm_all_locks_mutex);
> >
> > +     mas_for_each(&mas, vma, ULONG_MAX) {
> > +             if (signal_pending(current))
> > +                     goto out_unlock;
> > +             vma_start_write(vma);
> > +     }
> > +
> > +     mas_set(&mas, 0);
> >       mas_for_each(&mas, vma, ULONG_MAX) {
> >               if (signal_pending(current))
> >                       goto out_unlock;
>
> Do we need a vma_end_write_all(mm) in the out_unlock unrolling?

We can't really do that because some VMAs might have been locked
before mm_take_all_locks() got called. So, we will have to wait until
mmap write lock is dropped and vma_end_write_all() is called from
there. Getting a signal while executing mm_take_all_locks() is
probably not too common and won't pose a performance issue.

>
> Also, does this need to honour the strict locking order that we have to
> add an entire new loop?  This function is...suboptimal today, but if we
> could get away with not looping through every VMA for a 4th time, that
> would be nice.

That's what I used to do until Jann pointed out the locking order
requirement to avoid deadlocks in here:
https://lore.kernel.org/all/CAG48ez3EAai=1ghnCMF6xcgUebQRm-u2xhwcpYsfP9=r=oVXig@mail.gmail.com/.

>
> > @@ -3612,6 +3620,7 @@ void mm_drop_all_locks(struct mm_struct *mm)
> >               if (vma->vm_file && vma->vm_file->f_mapping)
> >                       vm_unlock_mapping(vma->vm_file->f_mapping);
> >       }
> > +     vma_end_write_all(mm);
> >
> >       mutex_unlock(&mm_all_locks_mutex);
> >  }
> > --
> > 2.39.1
> >
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>
