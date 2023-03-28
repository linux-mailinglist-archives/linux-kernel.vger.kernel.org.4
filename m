Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802286CBB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjC1Jug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbjC1JuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:50:05 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D9565B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:49:09 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s20so11855621ljp.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679996948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeVnfIbIbRzhGtBIMQdjLXjegBCIU0AjO884AWik9iA=;
        b=glmdP8/q/rlraYsi4uTB1TRFUXNkj7oiIcrDeRkAFbF6AQonA7WKbk/JwEliVp6wKk
         JXlW2g8FsU2sjBsKy/YAyOdJBJPYuCMs5d7z4rlSxMNwzpm47UPy0SIIa4eVBCOlMNM8
         rZV8reLZnDDQXL8KTBbLMtuvAOpnkHQitM47A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jeVnfIbIbRzhGtBIMQdjLXjegBCIU0AjO884AWik9iA=;
        b=gZd+XBxREe6+NRMxkfo+ZTDygdYUFkfhPQ6bU4CDxF82QtCTXfhOFrSvsQdeZbhcTg
         ROQqz00e2a7qu76fBw9zHnesSaF0mtJTe1n+bqO9SxAO7x7F5Wudi5sfq62Qu4nsGZ7d
         wR8NCTS3xHnn5BNJ8EvpcTxPsXhNmYwqFdVd4NraX1otjBIpl7LMT2A08FajkB/CKrW5
         4YskUshFTNGOmd2qkzRNfcoraqYv14NnoIz4DTuoUQFC2WJGBZGnn0wcC0dzr0uV+5dd
         QqaS0170B5ehJacBTC7PsaIMqRBIF3KymnWwUBSemCiURPkFWx0LPqfcD0xNUdggcOC9
         cvhg==
X-Gm-Message-State: AAQBX9eE8kWa/7ebNnsv+p4UvG6MiGXYpTZHzw/RU1zQajgqpML1nrAZ
        //0Os5Bk0omWGS/b2ERsXBbj7K+VldOQhBfYc8KXtg==
X-Google-Smtp-Source: AKy350YtFLevXgRr7ONWwCDxOQz47ystRmA1OzvZCfd+fmKFAubLy5wbayNPDjwwi/mAYB158OTGeP2hiR1LKp3WXqs=
X-Received: by 2002:a05:651c:115:b0:294:6de5:e642 with SMTP id
 a21-20020a05651c011500b002946de5e642mr4542131ljb.3.1679996947995; Tue, 28 Mar
 2023 02:49:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230307052036.1520708-1-stevensd@google.com> <20230307052036.1520708-4-stevensd@google.com>
 <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
In-Reply-To: <866d1a75-d462-563-dfd7-1aa2971a285b@google.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 28 Mar 2023 18:48:56 +0900
Message-ID: <CAD=HUj6rVKt=gYBM_y-biDXc_QkFc2-JBRzYNsPJokGEdokH2w@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] mm/khugepaged: maintain page cache uptodate flag
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
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 4:08=E2=80=AFAM Hugh Dickins <hughd@google.com> wro=
te:
>
> On Tue, 7 Mar 2023, David Stevens wrote:
>
> > From: David Stevens <stevensd@chromium.org>
> >
> > Make sure that collapse_file doesn't interfere with checking the
> > uptodate flag in the page cache by only inserting hpage into the page
> > cache after it has been updated and marked uptodate. This is achieved b=
y
> > simply not replacing present pages with hpage when iterating over the
> > target range. The present pages are already locked, so replacing the
> > with the locked hpage before the collapse is finalized is unnecessary.
> >
> > This fixes a race where folio_seek_hole_data would mistake hpage for
> > an fallocated but unwritten page. This race is visible to userspace via
> > data temporarily disappearing from SEEK_DATA/SEEK_HOLE.
> >
> > Fixes: f3f0e1d2150b ("khugepaged: add support of collapse for tmpfs/shm=
em pages")
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > Acked-by: Peter Xu <peterx@redhat.com>
>
> NAK to this patch, I'm afraid: it deadlocks.
>
> What I know it to deadlock against, does not make the most persuasive
> argument: cgroup v1 deprecated memcg moving, where mc_handle_file_pte()
> uses filemap_get_incore_folio() while holding page table lock, and spins
> around doing "goto repeat" in filemap_get_entry() while folio_try_get_rcu=
()
> keeps failing because collapse_file()'s old page has been left in the
> xarray with its refcount frozen to 0.  Meanwhile, collapse_file() is
> spinning to get that page table lock, to unmap pte of a later page.
>
> mincore()'s use of filemap_get_incore_folio() would be liable to hit
> the same deadlock.  If we think for longer, we may find more examples.
> But even when not actually deadlocking, it's wasting lots of CPU on
> concurrent lookups (e.g. faults) spinning in filemap_get_entry().

Ignoring my changes for now, these callers of filemap_get_incore_folio
seem broken to some degree with respect to khugepaged. Mincore can
show mlocked pages spuriously disappearing - this is pretty easy to
reproduce with concurrent calls to MADV_COLLAPSE and mincore. As for
the memcg code, I'm not sure how precise it is expected to be, but it
seems likely that khugepaged can make task migration accounting less
reliable (although I don't really understand the code).

> I don't suppose it's entirely accurate, but think of keeping a folio
> refcount frozen to 0 as like holding a spinlock (and this lock sadly out
> of sight from lockdep).  The pre-existing code works because the old page
> with refcount frozen to 0 is immediately replaced in the xarray by an
> entry for the new hpage, so the old page is no longer discoverable:
> and the new hpage is locked, not with a spinlock but the usual
> folio/page lock, on which concurrent lookups will sleep.

Is it actually necessary to freeze the original pages? At least at a
surface level, it seems that the arguments in 87c460a0bded
("mm/khugepaged: collapse_shmem() without freezing new_page") would
apply to the original pages as well. And if it is actually necessary
to freeze the original pages, why is it not necessary to freeze the
hugepage for the rollback case? Rolling back hugepage->original pages
seems more-or-less symmetric to collapsing original pages->hugepage.

> Your discovery of the SEEK_DATA/SEEK_HOLE issue is important - thank
> you - but I believe collapse_file() should be left as is, and the fix
> made instead in mapping_seek_hole_data() or folio_seek_hole_data():
> I believe that should not jump to assume that a !uptodate folio is a
> hole (as was reasonable to assume for shmem, before collapsing to huge
> got added), but should lock the folio if !uptodate, and check again
> after getting the lock - if still !uptodate, it's a shmem hole, not
> a transient race with collapse_file().

This sounds like it would work for lseek. I guess it could maybe be
made to sort of work for mincore if we abort the walk, lock the page,
restart the walk, and then re-validate the locked page. Although
that's not exactly efficient.

-David

> I was (pleased but) a little surprised when Matthew found in 5.12 that
> shmem_seek_hole_data() could be generalized to filemap_seek_hole_data():
> he will have a surer grasp of what's safe or unsafe to assume of
> !uptodate in non-shmem folios.
>
> On an earlier audit, for different reasons, I did also run across
> lib/buildid.c build_id_parse() using find_get_page() without checking
> PageUptodate() - looks as if it might do the wrong thing if it races
> with khugepaged collapsing text to huge, and should probably have a
> similar fix.
>
> Hugh
