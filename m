Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1256B2C9E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjCISGB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:06:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbjCISFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:05:54 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20B0FCBC8
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 10:05:49 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id v13so2918143ybu.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678385149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d4+MmmI56u1NwsfPU4OAuxHn0FCJxKV3G8aUUxcib8g=;
        b=dFL+zCTyV2D4K76kTGiACEBSB8ZhcIbaSPqHSY0Dy8AXJbnkfDzP8lf++YnyfRuMWb
         UtTxkXITj8d9a9g3fHM0euY9JriF3Pym6jkA0SF+hw4Cnkhz66R/SHI8VTa3IuvIzhzW
         YRcjELEgrPTAREZgFmtZ+rGrYFknTDTbCoa6mMf/hjue2vx9hhcugX4YeAj7qu+t6pUI
         fxWm3ZJIUyLFDdGXlC/uqB81T4HBRXV/2R4eAc+7CQUM1AoZJCqEhQfI9mvvniefNZT3
         UV5rSvy8tp/YlwDUzIq329BLTgO0l8y5lA/GZZtVI7oANFuvsaTRlJQ+MVbMq6vZXcEl
         /b/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678385149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d4+MmmI56u1NwsfPU4OAuxHn0FCJxKV3G8aUUxcib8g=;
        b=L7lyXrwxbqFM3OtcW6NiQqcWBT205jYtV1/TsHsMavLm4AK84UXuVr3prZQFpbse4I
         +ViwCkmz25/8M4OTpHEEoAAK4yuyaK8LsiVdBn4j3RmrwBAu1/L1mSOIgVKmUuc6SdT2
         6LNiwk8yZYdDaGERq6HQ4aZ0+j2zcYD9UBkAFGX4L4eHWze/EYWzi+waRYsRdGGD5Jsx
         EXb2K2nmolLajMtP7v1PM3JMdDwUZByf7mWSAG4Yg3O4ZT/ieUYYg6/X+lrU1ARo3Htj
         kBx4Xm49XC+HY9QohvleFI0mzWk6CcnAfzUuuWbaMXtp3cPSxU5jUuK9HmexsAVrokZ+
         XQNw==
X-Gm-Message-State: AO0yUKV5N4YrEnQWo8bOdMwpv0O6utIBXMxnnO+sV7fPKzLbb6n/DQ7m
        SJCfpvVwsbQul2ApO0l23jxsVfM/DfOYyocq4upx8A==
X-Google-Smtp-Source: AK7set84ZsMlJHmD8/dkY6pPwXjq9IdnqIsG9FFjxubhQV5KD7/LZZ6rD3mpQLc27Nyen19Vk5x5Bdmep7SEoLCLAq0=
X-Received: by 2002:a25:8f8c:0:b0:b21:a3b8:45cd with SMTP id
 u12-20020a258f8c000000b00b21a3b845cdmr3831758ybl.0.1678385148633; Thu, 09 Mar
 2023 10:05:48 -0800 (PST)
MIME-Version: 1.0
References: <20230306230004.1387007-1-jthoughton@google.com> <ZAkH4cImuFttLuDQ@x1n>
In-Reply-To: <ZAkH4cImuFttLuDQ@x1n>
From:   James Houghton <jthoughton@google.com>
Date:   Thu, 9 Mar 2023 10:05:12 -0800
Message-ID: <CADrL8HXk6F+7N9sYfFb3Q=T9Tda2+St1JoBCThrgc2j2yU3bcQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] mm: rmap: merge HugeTLB mapcount logic with THPs
To:     Peter Xu <peterx@redhat.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Mar 8, 2023 at 2:10=E2=80=AFPM Peter Xu <peterx@redhat.com> wrote:
>
> On Mon, Mar 06, 2023 at 11:00:02PM +0000, James Houghton wrote:
> > HugeTLB pages may soon support being mapped with PTEs. To allow for thi=
s
> > case, merge HugeTLB's mapcount scheme with THP's.
> >
> > The first patch of this series comes from the HugeTLB high-granularity
> > mapping series[1], though with some updates, as the original version
> > was buggy[2] and incomplete.
> >
> > I am sending this change as part of this smaller series in hopes that i=
t
> > can be more thoroughly scrutinized.
> >
> > I haven't run any THP performance tests with this series applied.
> > HugeTLB pages don't currently support being mapped with
> > `compound=3Dfalse`, but this mapcount scheme will make collapsing
> > compound=3Dfalse mappings in HugeTLB pages quite slow. This can be
> > optimized with future patches (likely by taking advantage of HugeTLB's
> > alignment guarantees).
> >
> > Matthew Wilcox is working on a mapcounting scheme[3] that will avoid
> > the use of each subpage's mapcount. If this series is applied, Matthew'=
s
> > new scheme will automatically apply to HugeTLB pages.
>
> Is this the plan?
>
> I may have not followed closely on the latest development of Matthew's
> idea.  The thing is if the design requires ptes being installed / removed
> at the same time for the whole folio, then it may not work directly for H=
GM
> if HGM wants to support at least postcopy, iiuc, because if we install th=
e
> whole folio ptes at the same time it seems to beat the whole purpose of
> having HGM..

My understanding is that it doesn't *require* all the PTEs in a folio
to be mapped at the same time. I don't see how it possibly could,
given that UFFDIO_CONTINUE exists (which can already create PTE-mapped
THPs today). It would be faster to populate all the PTEs at the same
time (you would only need to traverse the page table once for the
entire group to see if you should be incrementing mapcount).

Though, with respect to unmapping, if PTEs aren't all unmapped at the
same time, then you could end up with a case where mapcount is still
incremented but nothing is really mapped. I'm not really sure what
should be done there, but this problem applies to PTE-mapped THPs the
same way that it applies to HGMed HugeTLB pages.

> The patch (especially patch 1) looks good.  So it's a pure question just =
to
> make sure we're on the same page.  IIUC your other mapcount proposal may
> work, but it still needs to be able to take care of ptes in less-than-fol=
io
> sizes whatever it'll look like at last.

By my "other mapcount proposal", I assume you mean the "using the
PAGE_SPECIAL bit to track if mapcount has been incremented or not". It
really only serves as an optimization for Matthew's scheme (see below
[2] for some more thoughts), and it doesn't have to only apply to
HugeTLB.

I originally thought[1] that Matthew's scheme would be really painful
for postcopy for HGM without this optimization, but it's actually not
so bad. Let's assume the worst case, that we're UFFDIO_CONTINUEing
from the end to the beginning, like in [1]:

First CONTINUE: pvmw finds an empty PUD, so quickly returns false.
Second CONTINUE: pvmw finds 511 empty PMDs, then finds 511 empty PTEs,
then finds a present PTE (from the first CONTINUE).
Third CONTINUE: pvmw finds 511 empty PMDs, then finds 510 empty PTEs.
...
514th CONTINUE: pvmw finds 510 empty PMDs, then finds 511 empty PTEs.

So it'll be slow, but it won't have to check 262k empty PTEs per
CONTINUE (though you could make this possible with MADV_DONTNEED).
Even with an HGM implementation that only allows PTE-mapping of
HugeTLB pages, it should still behave just like this, too.

> A trivial comment on patch 2 since we're at it: does "a future plan on so=
me
> arch to support 512GB huge page" justify itself?  It would be better
> justified, IMHO, when that support is added (and decided to use HGM)?

That's fine with me. I'm happy to drop that patch.

> What I feel like is missing (rather than patch 2 itself) is some guard to
> make sure thp mapcountings will not be abused with new hugetlb sizes
> coming.
>
> How about another BUG_ON() squashed into patch 1 (probably somewhere in
> page_add_file|anon_rmap()) to make sure folio_size() is always smaller th=
an
> COMPOUND_MAPPED / 2)?

Sure, I can add that.

Thanks, Peter!

- James

[1]: https://lore.kernel.org/linux-mm/CADrL8HUrEgt+1qAtEsOHuQeA+WWnggGfLj8_=
nqHF0k-pqPi52w@mail.gmail.com/

[2]: Some details on what the optimization might look like:

So an excerpt of Matthew's scheme would look something like this:

    /* if we're mapping < folio_nr_pages(folio) worth of PTEs. */
    if (!folio_has_ptes(folio, vma))
      atomic_inc(folio->_mapcount);

where folio_has_ptes() is defined like:

    if (!page_vma_mapped_walk(...))
      return false;
    page_vma_mapped_walk_done(...);
    return true;

You might be able to optimize folio_has_ptes() with a block like this
at the beginning:

    if (folio_is_naturally_aligned(folio, vma)) {
      /* optimization for naturally-aligned folios. */
      if (folio_test_hugetlb(folio)) {
        /* check hstate-level PTE, and do a similar check as below. */
      }
      /* for naturally-aligned THPs: */
      pmdp =3D mm_find_pmd(...); /* or just pass it in. */
      pmd =3D READ_ONCE(*pmdp);
      BUG_ON(!pmd_present(pmd) || pmd_leaf(pmd));
      if (pmd_special(pmd))
        return true;
      /* we already hold the PTL for the PTE. */
      ptl =3D pmd_lock(mm, pmdp);
      /* test and set pmd_special */
      pmd_unlock(ptl)
      return if_we_set_pmd_special;
    }

(pmd_special() doesn't currently exist.) If HugeTLB walking code can
be merged with generic mm, then HugeTLB wouldn't have a special case
at all here.
