Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FFB66F4E55
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 03:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjECBF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 21:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjECBF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 21:05:57 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3D42D61
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 18:05:55 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-55b7630a736so5434197b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 18:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683075955; x=1685667955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m4150D4K6PFkw/p8ZQzw3oDIGR67QJcGBtSkoT4wUnc=;
        b=VT/lpwegPmHfVwQRL263/dFBOGViLcIOmDFEKSDN0JoXp3qHS1srQa34+xoWI2Bo9d
         YAYLzTw+/PUqOwvAjrk4Ftff8F5kJWlKfFXLm6SaNUq9sMQIEBd9rc7Y5AZ8mLD4/gub
         P+kVvr9ZVRY31CA33v0UJCQVMLkj77IGdF4r9KJwyIFqNBZisXI+Doy/0kXlk/GNwh8k
         z+LPUjrG+aqA4j2X7/gCMWy17ZSZ2BwqdcFI/QRv5WL4oWVVT1mr8sG4aD6IKapKQSwu
         6mPF3QhOongfrXuWyvUfMuO8ddN1xX1lXjXEaGjKSoOoUaiURn0+HFK99RDAGm9pYQkF
         x4lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683075955; x=1685667955;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m4150D4K6PFkw/p8ZQzw3oDIGR67QJcGBtSkoT4wUnc=;
        b=bCeIELrKpfwrkybyWNVuGXpwuIeAgOdCqZBZy2sbskxOfI2REPjaiYJHaih4xoJ/c5
         wj9h8mCZnv28hhvGxf0/sddVrA6d8UD6kHlDAwJ5uU8IR7NLErKi6gLIWYffqGDHS4Zl
         kyVQis8GjAyYxD0c2xXS7FGyoRdE3Ygnmn6g6uD7C5wiRWH6D0BvxiOC4p5cG/geFCRx
         OddjP9X3gM8i+cJG9xqNgMKgpU50Oh3/3l2tOyDMn6bMATR2t622HwDwFxO+728434Yg
         ZbMpHxsu0zRSkQj949E/P5wPqbM16kbsNeOfW+y2WjUxZUH9dzGHhWteYcOFLelSlIZo
         qRAQ==
X-Gm-Message-State: AC+VfDwjvUkbcd3rf+sF/+yGVF3yWJxY/d853ny3gFgtK3XICppJ81FR
        9wtziy+lRQFSy/HgaQCdkDfnkCEsiujDy40+jlBq2Q==
X-Google-Smtp-Source: ACHHUZ7cagiPfB6DVMqItZRu7qL1h7Wan4Y5rk+T4jkv3yUULWQ9G2mryIrQk1F+sybOs2QQQ1mH3gTdh8agGtHShnk=
X-Received: by 2002:a81:7507:0:b0:55a:20d5:1e38 with SMTP id
 q7-20020a817507000000b0055a20d51e38mr10843182ywc.40.1683075954559; Tue, 02
 May 2023 18:05:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230501175025.36233-1-surenb@google.com> <ZFBvOh8r5WbTVyA8@casper.infradead.org>
 <CAJuCfpHfAFx9rjv0gHK77LbP-8gd-kFnWw=aqfQTP6pH=zvMNg@mail.gmail.com>
 <ZFCB+G9KSNE+J9cZ@casper.infradead.org> <CAJuCfpES=G8i99yYXWoeJq9+JVUjX5Bkq_5VNVTVX7QT+Wkfxg@mail.gmail.com>
 <ZFEmN6G7WRy59Mum@casper.infradead.org> <CAJuCfpFs+Rgpu8v+ddHFwtOx33W5k1sKDdXHM2ej1Upyo_9y4g@mail.gmail.com>
 <ZFGPLXIis6tl1QWX@casper.infradead.org> <CAJuCfpGgc_bCEAE5LrhYPk=qXMU=owgiABTO9ZNqaBx-xfrOuQ@mail.gmail.com>
 <ZFGfaSA7buH0yBv7@casper.infradead.org>
In-Reply-To: <ZFGfaSA7buH0yBv7@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 2 May 2023 18:05:43 -0700
Message-ID: <CAJuCfpHzzsGn0iqD0g56MpBO4=7Tf5XJ1uvMr-mh9RmC3Z91Gw@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm: handle swap page faults under VMA lock if page is uncontended
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 2, 2023 at 4:40=E2=80=AFPM Matthew Wilcox <willy@infradead.org>=
 wrote:
>
> On Tue, May 02, 2023 at 04:04:59PM -0700, Suren Baghdasaryan wrote:
> > On Tue, May 2, 2023 at 3:31=E2=80=AFPM Matthew Wilcox <willy@infradead.=
org> wrote:
> > >
> > > On Tue, May 02, 2023 at 09:36:03AM -0700, Suren Baghdasaryan wrote:
> > > > On Tue, May 2, 2023 at 8:03=E2=80=AFAM Matthew Wilcox <willy@infrad=
ead.org> wrote:
> > > > >
> > > > > On Mon, May 01, 2023 at 10:04:56PM -0700, Suren Baghdasaryan wrot=
e:
> > > > > > On Mon, May 1, 2023 at 8:22=E2=80=AFPM Matthew Wilcox <willy@in=
fradead.org> wrote:
> > > > > > >
> > > > > > > On Mon, May 01, 2023 at 07:30:13PM -0700, Suren Baghdasaryan =
wrote:
> > > > > > > > On Mon, May 1, 2023 at 7:02=E2=80=AFPM Matthew Wilcox <will=
y@infradead.org> wrote:
> > > > > > > > >
> > > > > > > > > On Mon, May 01, 2023 at 10:50:23AM -0700, Suren Baghdasar=
yan wrote:
> > > > > > > > > > +++ b/mm/memory.c
> > > > > > > > > > @@ -3711,11 +3711,6 @@ vm_fault_t do_swap_page(struct v=
m_fault *vmf)
> > > > > > > > > >       if (!pte_unmap_same(vmf))
> > > > > > > > > >               goto out;
> > > > > > > > > >
> > > > > > > > > > -     if (vmf->flags & FAULT_FLAG_VMA_LOCK) {
> > > > > > > > > > -             ret =3D VM_FAULT_RETRY;
> > > > > > > > > > -             goto out;
> > > > > > > > > > -     }
> > > > > > > > > > -
> > > > > > > > > >       entry =3D pte_to_swp_entry(vmf->orig_pte);
> > > > > > > > > >       if (unlikely(non_swap_entry(entry))) {
> > > > > > > > > >               if (is_migration_entry(entry)) {
> > > > > > > > >
> > > > > > > > > You're missing the necessary fallback in the (!folio) cas=
e.
> > > > > > > > > swap_readpage() is synchronous and will sleep.
> > > > > > > >
> > > > > > > > True, but is it unsafe to do that under VMA lock and has to=
 be done
> > > > > > > > under mmap_lock?
> > > > > > >
> > > > > > > ... you were the one arguing that we didn't want to wait for =
I/O with
> > > > > > > the VMA lock held?
> > > > > >
> > > > > > Well, that discussion was about waiting in folio_lock_or_retry(=
) with
> > > > > > the lock being held. I argued against it because currently we d=
rop
> > > > > > mmap_lock lock before waiting, so if we don't drop VMA lock we =
would
> > > > > > be changing the current behavior which might introduce new
> > > > > > regressions. In the case of swap_readpage and swapin_readahead =
we
> > > > > > already wait with mmap_lock held, so waiting with VMA lock held=
 does
> > > > > > not introduce new problems (unless there is a need to hold mmap=
_lock).
> > > > > >
> > > > > > That said, you are absolutely correct that this situation can b=
e
> > > > > > improved by dropping the lock in these cases too. I just didn't=
 want
> > > > > > to attack everything at once. I believe after we agree on the a=
pproach
> > > > > > implemented in https://lore.kernel.org/all/20230501175025.36233=
-3-surenb@google.com
> > > > > > for dropping the VMA lock before waiting, these cases can be ad=
ded
> > > > > > easier. Does that make sense?
> > > > >
> > > > > OK, I looked at this path some more, and I think we're fine.  Thi=
s
> > > > > patch is only called for SWP_SYNCHRONOUS_IO which is only set for
> > > > > QUEUE_FLAG_SYNCHRONOUS devices, which are brd, zram and nvdimms
> > > > > (both btt and pmem).  So the answer is that we don't sleep in thi=
s
> > > > > path, and there's no need to drop the lock.
> > > >
> > > > Yes but swapin_readahead does sleep, so I'll have to handle that ca=
se
> > > > too after this.
> > >
> > > Sleeping is OK, we do that in pXd_alloc()!  Do we block on I/O anywhe=
re
> > > in swapin_readahead()?  It all looks like async I/O to me.
> >
> > Hmm. I thought that we have synchronous I/O in the following paths:
> >     swapin_readahead()->swap_cluster_readahead()->swap_readpage()
> >     swapin_readahead()->swap_vma_readahead()->swap_readpage()
> > but just noticed that in both cases swap_readpage() is called with the
> > synchronous parameter being false. So you are probably right here...
> > Does that mean swapin_readahead() might return a page which does not
> > have its content swapped-in yet?
>
> That's my understanding.  In that case it's !uptodate and still locked.
> The folio_lock_or_retry() will wait for the read to complete unless
> we've told it we'd rather retry.

Ok, and we already drop the locks in folio_lock_or_retry() when
needed. Sounds like we cover this case with this patchset?
