Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B97C72B368
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 20:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjFKS0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 14:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjFKS02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 14:26:28 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E42BC191
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 11:26:26 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-5ed99ebe076so33680186d6.2
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 11:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686507986; x=1689099986;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MQZPDk9/AlvbGZgHPMv3EA6GMJJp86LhYlg8mXDuNls=;
        b=MB5KTWBVP3gRvHfrYmT/gQN62VUONaBKcfJvO2mXG/479v01Jt+8TeDddhI3RufciY
         e7eJe/iAeA8mDdjYzx8RXdELhbeG9uWOVVymrzv8I2jQp5TIJL8bIYctfuuPc5kyyBzP
         J5oCdUIKvAtNBT0WBtpBNKBXz2EXI8qE9npsaLmPqQ/zT0nWdtdX0LuAmx+j4sV54RU6
         mbsz7rVu2GGvtVZOGm+ZPivDC1ocAqqcF+qurSK5P7auEMd+SwsDIk8RYbCPj38onDho
         uuLIaAlsdwEHCVTqqLOG91oJbaLtYw2KFGQkxDJ5tcCejnQoEMvFeXAYl5vQ6xtaHPbk
         VmUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686507986; x=1689099986;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MQZPDk9/AlvbGZgHPMv3EA6GMJJp86LhYlg8mXDuNls=;
        b=OutuwMfW0ietf2yZEyJtWbUt4Oae+Qp+JpGIMnNBL65aerq7URIoa9aWQpO2683C9v
         QnffMt3UnudloDceaPKFfZ1wZX5vusDEi4bwja5nfsIalH377Yzk6hmk9/rJVC7UplNW
         sOBeAbvk3IAaf1g7nM4jMiUy6MvQi++wzYFSPjjlUhlmkubV4TwkkCrudd0aT5Y8ZDty
         GjCneHnZcOeFo9057kUHNVI0f/wXYKuaZvjayJX8VOh8JlizCbdK+/gGFWgLoVhuF+Si
         u3jux7P43TLBDIEp4EmdsrjEP8y4Io/k7epCuSyY9SbseUWIdoH1cCLRC/injqqAm+1S
         o6IA==
X-Gm-Message-State: AC+VfDxbKZaWght2BsXPbupd6BwZCJEBYGL/pW0Ke6TdrLgekhDzMkO4
        gB2ugMJ4aqzQESTS+KwHNuPDbw==
X-Google-Smtp-Source: ACHHUZ4X3QYfji5XHtFXmULyn42uhP2HoHFSugFLsxjpFdumVXJrUHgtBRgsmMKFkJThVWTI5GUu8g==
X-Received: by 2002:a05:6214:130b:b0:626:2bd8:b67a with SMTP id pn11-20020a056214130b00b006262bd8b67amr9343326qvb.21.1686507985906;
        Sun, 11 Jun 2023 11:26:25 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id t65-20020a0dea44000000b00565eb8af1fesm2033126ywe.132.2023.06.11.11.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 11:26:25 -0700 (PDT)
Date:   Sun, 11 Jun 2023 11:26:16 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     David Stevens <stevensd@chromium.org>
cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/khugepaged: fix iteration in collapse_file
In-Reply-To: <CAD=HUj4vVbyHiT7vPmRorS+v9t2+N46ak=Xrew2cFf5+utC=tQ@mail.gmail.com>
Message-ID: <8ef3ee-ba41-8e9e-4453-73736ff27783@google.com>
References: <20230607053135.2087354-1-stevensd@google.com> <f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com> <CAD=HUj4vVbyHiT7vPmRorS+v9t2+N46ak=Xrew2cFf5+utC=tQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463760895-1284592801-1686507985=:13629"
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463760895-1284592801-1686507985=:13629
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sat, 10 Jun 2023, David Stevens wrote:
> On Sat, Jun 10, 2023 at 5:03=E2=80=AFAM Hugh Dickins <hughd@google.com> w=
rote:
> > On Wed, 7 Jun 2023, David Stevens wrote:
> > >
> > > Remove an unnecessary call to xas_set(index) when iterating over the
> > > target range in collapse_file. The extra call to xas_set reset the xa=
s
> > > cursor to the top of the tree, causing the xas_next call on the next
> > > iteration to walk the tree to index instead of advancing to index+1.
> > > This returned the same page again, which would cause collapse_file to
> > > fail because the page is already locked.
> > >
> > > This bug was hidden when CONFIG_DEBUG_VM was set. When that config wa=
s
> > > used, the xas_load in a subsequent VM_BUG_ON assert would walk xas fr=
om
> > > the top of the tree to index, causing the xas_next call on the next l=
oop
> > > iteration to advance the cursor as expected.
> > >
> > > Fixes: a2e17cc2efc7 ("mm/khugepaged: maintain page cache uptodate fla=
g")
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> >
> > This patch seems to be wrong,

I withdraw the accusation!  I haven't thought about the patch itself:
I'd have to learn a bit more about the xarray rules, so cannot quickly
ack it myself; but withdraw my implicit nack.

> > but I have not investigated why.
> >
> > It's certainly an interesting and worrying observation,
> > if a CONFIG_DEBUG_VM=3Dy kernel goes a significantly different way.
> >
> > I almost always do have CONFIG_DEBUG_VM=3Dy, so you won't be surprised =
that
> > I never saw the issue.  But once I ran an mm-everything with this patch=
 in,
> > I hit that VM_BUG_ON_PAGE(page !=3D xas_load(&xas), page) for the first=
 time
> > (after about 2 hours of huge tmpfs swapping load).
>=20
> Is the particular workload one you can share?

It's a workload familiar to me, and no secret, but which would take much
more time to share than I have to spare; with no great likelihood that
you could easily reproduce all the conditions at the end of it.

> I haven't hit that assert so far with my tests.

And nor have I since.  I've been trying 6.4-rc5 with and without your
patch, mm-everything (of a few days ago) with and without your patch,
with and without my pte_offset_map changes.  Not once have I seen that
VM_BUG_ON_PAGE(page !=3D xas_load(&xas), page) again, even with the exact
same kernel.

I've no doubt that I did hit it, but I'm now having to assume that it's
something very rare (or very rare in my particular testing).  And because
the first time I saw it coincided with the first time I had in your patch
to the last non-blank line above it, I jumped to the conclusion that it
was your patch causing it.  Not unreasonable at the time, but not
justified by later attempts.  Perhaps there was something unrelated
in that kernel, corrupting an xarray node.

If I ever see it again, I hope I'll be able to spend more time
investigating; or if I study that code with more leisure, maybe a
hypothesis for a rare race will arise.  But for now, we'd better
just forget about it.

>=20
> Also, I'm a little surprised that this is the assert which is being
> hit. My patch series didn't make that many changes to the first loop
> of the function, and the changes it did make were mostly about missing
> pages, not present pages.

I was suspicious of that patch series, as I said at the time; and might
one day want to revert it; but it has not given me any actual problem -
that only came with this fix to it.

>=20
> > As if you have just transferred the problem from DEBUG_VM=3Dn to DEBUG_=
VM=3Dy.
> > But I then tried a CONFIG_DEBUG_VM off 6.4-rc1 kernel (including the fi=
xee
> > but not this fixer) under similar load, and saw no problem in 14 hours.
> > So I can't even reproduce the bug that is being fixed here: only hit a
> > bug that it introduces.
>=20
> The bug this fixes isn't a crash - it's the fact that khugepage

Sorry, yes, I should have re-read your commit message before writing
all that.

Thanks,
Hugh

> becomes nearly unable to collapse pages. Specifically, it can only
> collapse if there is exactly one present page, and that page is at
> index 511. Since MADV_COLLAPSE uses the same code path, it's easy to
> reproduce the bug I'm trying to fix with this program:
>=20
> #define _GNU_SOURCE
> #include <assert.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <unistd.h>
>=20
> #define THP_SIZE (2 * 1024 * 1024)
>=20
> #ifndef MADV_COLLAPSE
> #define MADV_COLLAPSE 25
> #endif
>=20
> int main() {
>   int memfd =3D memfd_create("memfd", MFD_CLOEXEC);
>   assert(memfd >=3D 0);
>=20
>   int ret =3D ftruncate(memfd, THP_SIZE);
>   assert(ret >=3D 0);
>=20
>   char *addr =3D mmap(NULL, THP_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, m=
emfd, 0);
>   assert(addr !=3D MAP_FAILED);
>=20
>   addr[0] =3D 0xff;
>=20
>   ret =3D madvise(addr, THP_SIZE, MADV_COLLAPSE);
>   assert(ret =3D=3D 0);
> }
>=20
> If DEBUG_VM isn't set, then the test will trigger the assert. If
> DEBUG_VM is set or if this fix is included, then the test will pass.
>=20
> -David
>=20
> > Hugh
> >
> > > ---
> > >  mm/khugepaged.c | 1 -
> > >  1 file changed, 1 deletion(-)
> > >
> > > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > > index 6b9d39d65b73..2d0d58fb4e7f 100644
> > > --- a/mm/khugepaged.c
> > > +++ b/mm/khugepaged.c
> > > @@ -2070,7 +2070,6 @@ static int collapse_file(struct mm_struct *mm, =
unsigned long addr,
> > >                                       TTU_IGNORE_MLOCK | TTU_BATCH_FL=
USH);
> > >
> > >               xas_lock_irq(&xas);
> > > -             xas_set(&xas, index);
> > >
> > >               VM_BUG_ON_PAGE(page !=3D xas_load(&xas), page);
> > >
> > > --
> > > 2.41.0.rc2.161.g9c6817b8e7-goog
---1463760895-1284592801-1686507985=:13629--
