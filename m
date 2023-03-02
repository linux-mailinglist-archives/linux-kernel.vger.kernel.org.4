Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5DD6A7974
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjCBCWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjCBCWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:22:06 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA6F91286A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:22:05 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 82so2305774ybn.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 18:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677723725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=icYcAz4iENgGguq1MUlInM5/6GsRcXFU+8O5VO7eInA=;
        b=ICNzManCzUgms4+COGza4gk5YsyseuO5Ijt4EWhpqNEDkAg12yxO+M+x6EF7wlGyGp
         18xfcjTQdZvnANZNl2A9rF7rCOHTU3O7UgOEldBj8JFxYXSdYiuqfdORdbYK3a8OzBha
         GPx1R+762t651JyT8Cj6YRDfJYCZzRhsZnsEISTad9RtLN+lwUYObGJty8p+v5C9AyGP
         3XXAHVdDVphOLPBe2/6syAoOKCOBT/gqoC22awkzHgd0AJ3EE9WzeagQuz79d2V/uPYP
         8Lqoil99Y13JGIIeKOkn5jKR1Pgy1Y4lYmhZVpRrJLR83i3rnovCLcQAjwV4uywIdJzG
         i4rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677723725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icYcAz4iENgGguq1MUlInM5/6GsRcXFU+8O5VO7eInA=;
        b=GCfasrrgBQehLqrE9sdp1jrMgMsk8kzXTQpvmjzpxNvpS0Q/TjDwvWU+evT6TLRFs2
         oKKu80+6AAaoGmMosLU396bb7yqW7UgOIe6rXAdp+2mh8m6o7RytqWdM4M29ovoBkxRi
         fWo1akFmVxC9cIr1UqcxZdLDo92KFAFsBF5M9fCzNreyQnv5zVgX+aOLQFIOznwY/9j4
         MMvVO/nlE9iY836PGq2kWKw3kxsWj9Aa7KRrN4Dd9Nt0tM8BdtRw2RnliCvwY4KSTHXi
         PPaMlVn29+5BN0XXSptGy2VCRrspYG6Nz04ry4ChIeqaaKJgCn0BT980TBxbRcExG6TJ
         wP0w==
X-Gm-Message-State: AO0yUKX0qiveGDtl9RaI9Co/kA2rJV+1nSdM9stn15b9QHkrxNWsmRP7
        hY+Oe1dDbwjulLyOuTwnLcFo26gQwGebDxnT+lCZpQ==
X-Google-Smtp-Source: AK7set8f8UCPLp9V1R6/ru3EOI4J1mkBQgV1T32GNF0OvprkrFWWd8Ter81Ipe29QBKiksN2yO0CRLf6M0naPga3SGQ=
X-Received: by 2002:a25:aa03:0:b0:a06:538f:265f with SMTP id
 s3-20020a25aa03000000b00a06538f265fmr407354ybi.4.1677723724623; Wed, 01 Mar
 2023 18:22:04 -0800 (PST)
MIME-Version: 1.0
References: <20230227173632.3292573-1-surenb@google.com> <20230227173632.3292573-19-surenb@google.com>
 <Y/8CJQGNuMUTdLwP@localhost> <Y/8FNM9czzPHb5eG@localhost> <CAJuCfpHYT++MBC6T-p80n_m5hHWRRC4Y1bO9J-bFFZZDqNX-BQ@mail.gmail.com>
 <CAJuCfpFax8LSdcq1qiz3sp0XPLaNZnkFFky2tQekG2_Azvw9_g@mail.gmail.com> <Y//zmYeu6uexiyOY@localhost>
In-Reply-To: <Y//zmYeu6uexiyOY@localhost>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 1 Mar 2023 18:21:53 -0800
Message-ID: <CAJuCfpEhwye9dn3eUaYE1gSHt+8M5ztBR3ZMoTYyBR7+uSL5aQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/33] mm: write-lock VMAs before removing them from
 VMA tree
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, mgorman@techsingularity.net, dave@stgolabs.net,
        willy@infradead.org, liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
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
Content-Transfer-Encoding: quoted-printable
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

On Wed, Mar 1, 2023 at 4:54 PM Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:
>
> On Wed, Mar 01, 2023 at 10:42:48AM -0800, Suren Baghdasaryan wrote:
> > On Wed, Mar 1, 2023 at 10:34=E2=80=AFAM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > On Tue, Feb 28, 2023 at 11:57=E2=80=AFPM Hyeonggon Yoo <42.hyeyoo@gma=
il.com> wrote:
> > > >
> > > > On Wed, Mar 01, 2023 at 07:43:33AM +0000, Hyeonggon Yoo wrote:
> > > > > On Mon, Feb 27, 2023 at 09:36:17AM -0800, Suren Baghdasaryan wrot=
e:
> > > > > > Write-locking VMAs before isolating them ensures that page faul=
t
> > > > > > handlers don't operate on isolated VMAs.
> > > > > >
> > > > > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > > > > ---
> > > > > >  mm/mmap.c  | 1 +
> > > > > >  mm/nommu.c | 5 +++++
> > > > > >  2 files changed, 6 insertions(+)
> > > > > >
> > > > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > > > index 1f42b9a52b9b..f7ed357056c4 100644
> > > > > > --- a/mm/mmap.c
> > > > > > +++ b/mm/mmap.c
> > > > > > @@ -2255,6 +2255,7 @@ int split_vma(struct vma_iterator *vmi, s=
truct vm_area_struct *vma,
> > > > > >  static inline int munmap_sidetree(struct vm_area_struct *vma,
> > > > > >                                struct ma_state *mas_detach)
> > > > > >  {
> > > > > > +   vma_start_write(vma);
> > > > > >     mas_set_range(mas_detach, vma->vm_start, vma->vm_end - 1);
> > > > >
> > > > > I may be missing something, but have few questions:
> > > > >
> > > > >       1) Why does a writer need to both write-lock a VMA and mark=
 the VMA detached
> > > > >          when unmapping it, isn't it enough to just only write-lo=
ck a VMA?
> > >
> > > We need to mark the VMA detached to avoid handling page fault in a
> > > detached VMA. The possible scenario is:
> > >
> > > lock_vma_under_rcu
> > >   vma =3D mas_walk(&mas)
> > >                                                         munmap_sidetr=
ee
> > >                                                           vma_start_w=
rite(vma)
> > >
> > > mas_store_gfp() // remove VMA from the tree
> > >                                                           vma_end_wri=
te_all()
> > >   vma_start_read(vma)
> > >   // we locked the VMA but it is not part of the tree anymore.
> > >
> > > So, marking the VMA locked before vma_end_write_all() and checking
> >
> > Sorry, I should have said "marking the VMA *detached* before
> > vma_end_write_all() and checking vma->detached after vma_start_read()
> > helps us avoid handling faults in the detached VMA."
> >
> > > vma->detached after vma_start_read() helps us avoid handling faults i=
n
> > > the detached VMA.
>
> Thank you for explanation, that makes sense!
>
> By the way, if there are no 32bit users of Per-VMA lock (are there?),
> "detached" bool could be a VMA flag (i.e. making it depend on 64BIT
> and selecting ARCH_USES_HIGH_VMA_FLAGS)

Yeah, I thought about it but didn't want to make assumptions about
potential users just yet. Besides, I heard there are attempts to make
vm_flags to be always 64-bit (I think Matthew mentioned that to me
once). If that happens, we won't need any dependencies here. Either
way, this conversion into a flag can be done as an additional
optimization later on. I prefer to keep the main patchset as simple as
possible for now.
Thanks,
Suren.

>
> Thanks,
> Hyeonggon
>
> --
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to kernel-team+unsubscribe@android.com.
>
