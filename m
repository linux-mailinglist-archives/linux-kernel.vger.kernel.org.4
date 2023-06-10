Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0D72A7BD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 03:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjFJBp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 21:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFJBp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 21:45:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC0E2D44
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 18:45:24 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso2996295e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 18:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686361522; x=1688953522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y+PqyIB5ZqDwlmZ1up6rkpqNAc9gKklwSUdrIkGBt/E=;
        b=cu0m1MUv/HXrUmSOm4jb525dJ3bd+mgyvDKFXtB+yAmRSQvoMPoei1e63p5TuksRUQ
         CIDLjtLkiqfA4HB7tGzdN9ELMJ9bAKLJbSH3om9TvSip61Ua4Kr/sCORSAicmie+lhex
         Ku1DndiaervlNRJ2mIs5rEmsH4te5Sq8Ej47k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686361522; x=1688953522;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y+PqyIB5ZqDwlmZ1up6rkpqNAc9gKklwSUdrIkGBt/E=;
        b=GJxlbKkvAoV9TFH3ezuGS9OEkuOesXlCFpWF3K58nHkrhWuX6XmlqOnSAOlB+jXGzh
         2+drO3/rsJEdaiM/cqbuTPHDZdgZhME+78rx/RSgAMjXTgr/kDVdCBs6zg1ovhoj448n
         T1on+Tf9dAYggPGDCoiSO5XLv2C+5dx6/En4WV5A5Y5ZurI/yDiqa0S+SEsKNvsHsWlo
         OMM9EXh/gpIYs4N0P23t6Oscw+wwsZaZ4BEF9FCupwrk1daZGdoKYaSKVs0NsVou1rDJ
         x5U3nQ7EGfTS+rFzQf8ZIaMnUNfcIbFnW3JDMp91PkPZyB/uxqS0eoKyX4WCJ0p5lwbk
         1Rpw==
X-Gm-Message-State: AC+VfDx27ojF172Mt1LBx/cYw0m3HrPuGudMqpZ7fco29ztozuHcDDmL
        RIlUxMgdaD+POBu+zgkZtxtg5X5vWeMy5WWsduVjsA==
X-Google-Smtp-Source: ACHHUZ4Z86AS8lMjHUd1LPTyasItm1dhaX6DQFHJjKsZR+sQdizE7s6pOdBkHPuVtetFopzJo9oBh1QgA8xrmyfYVKY=
X-Received: by 2002:ac2:5dc9:0:b0:4ec:8816:f4fc with SMTP id
 x9-20020ac25dc9000000b004ec8816f4fcmr1842267lfq.6.1686361522539; Fri, 09 Jun
 2023 18:45:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230607053135.2087354-1-stevensd@google.com> <f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com>
In-Reply-To: <f18e4b64-3f88-a8ab-56cc-d1f5f9c58d4@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Sat, 10 Jun 2023 10:45:11 +0900
Message-ID: <CAD=HUj4vVbyHiT7vPmRorS+v9t2+N46ak=Xrew2cFf5+utC=tQ@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: fix iteration in collapse_file
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 10, 2023 at 5:03=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Wed, 7 Jun 2023, David Stevens wrote:
> >
> > Remove an unnecessary call to xas_set(index) when iterating over the
> > target range in collapse_file. The extra call to xas_set reset the xas
> > cursor to the top of the tree, causing the xas_next call on the next
> > iteration to walk the tree to index instead of advancing to index+1.
> > This returned the same page again, which would cause collapse_file to
> > fail because the page is already locked.
> >
> > This bug was hidden when CONFIG_DEBUG_VM was set. When that config was
> > used, the xas_load in a subsequent VM_BUG_ON assert would walk xas from
> > the top of the tree to index, causing the xas_next call on the next loo=
p
> > iteration to advance the cursor as expected.
> >
> > Fixes: a2e17cc2efc7 ("mm/khugepaged: maintain page cache uptodate flag"=
)
> > Signed-off-by: David Stevens <stevensd@chromium.org>
>
> This patch seems to be wrong, but I have not investigated why.
>
> It's certainly an interesting and worrying observation,
> if a CONFIG_DEBUG_VM=3Dy kernel goes a significantly different way.
>
> I almost always do have CONFIG_DEBUG_VM=3Dy, so you won't be surprised th=
at
> I never saw the issue.  But once I ran an mm-everything with this patch i=
n,
> I hit that VM_BUG_ON_PAGE(page !=3D xas_load(&xas), page) for the first t=
ime
> (after about 2 hours of huge tmpfs swapping load).

Is the particular workload one you can share? I haven't hit that
assert so far with my tests.

Also, I'm a little surprised that this is the assert which is being
hit. My patch series didn't make that many changes to the first loop
of the function, and the changes it did make were mostly about missing
pages, not present pages.

> As if you have just transferred the problem from DEBUG_VM=3Dn to DEBUG_VM=
=3Dy.
> But I then tried a CONFIG_DEBUG_VM off 6.4-rc1 kernel (including the fixe=
e
> but not this fixer) under similar load, and saw no problem in 14 hours.
> So I can't even reproduce the bug that is being fixed here: only hit a
> bug that it introduces.

The bug this fixes isn't a crash - it's the fact that khugepage
becomes nearly unable to collapse pages. Specifically, it can only
collapse if there is exactly one present page, and that page is at
index 511. Since MADV_COLLAPSE uses the same code path, it's easy to
reproduce the bug I'm trying to fix with this program:

#define _GNU_SOURCE
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>

#define THP_SIZE (2 * 1024 * 1024)

#ifndef MADV_COLLAPSE
#define MADV_COLLAPSE 25
#endif

int main() {
  int memfd =3D memfd_create("memfd", MFD_CLOEXEC);
  assert(memfd >=3D 0);

  int ret =3D ftruncate(memfd, THP_SIZE);
  assert(ret >=3D 0);

  char *addr =3D mmap(NULL, THP_SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, mem=
fd, 0);
  assert(addr !=3D MAP_FAILED);

  addr[0] =3D 0xff;

  ret =3D madvise(addr, THP_SIZE, MADV_COLLAPSE);
  assert(ret =3D=3D 0);
}

If DEBUG_VM isn't set, then the test will trigger the assert. If
DEBUG_VM is set or if this fix is included, then the test will pass.

-David

> Hugh
>
> > ---
> >  mm/khugepaged.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 6b9d39d65b73..2d0d58fb4e7f 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2070,7 +2070,6 @@ static int collapse_file(struct mm_struct *mm, un=
signed long addr,
> >                                       TTU_IGNORE_MLOCK | TTU_BATCH_FLUS=
H);
> >
> >               xas_lock_irq(&xas);
> > -             xas_set(&xas, index);
> >
> >               VM_BUG_ON_PAGE(page !=3D xas_load(&xas), page);
> >
> > --
> > 2.41.0.rc2.161.g9c6817b8e7-goog
