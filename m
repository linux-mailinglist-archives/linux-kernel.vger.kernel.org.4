Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6AE6CC710
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbjC1Ptr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjC1Pto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:49:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4A383C5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680018530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+goQQ7nfkdzV94CFZrSygIQBY2Lhnm0tpScL2liQamE=;
        b=OraKnfs1bOZS9YniWhBxAuGhPWrtwN7e2Ul/skykfquYqqpn8H/dOEDeYTSObr1d+2FTE3
        jjq/gOTONq57uDVo/D3t3ppN2iIVoCrGJ4qPhVZK0KsAJr9OQZ+dCfI+A1DLK2LcFq9pr3
        weh2rFJLLs7hT8UXbv7bECISp5wL8Ow=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-qH08vMOsMlyzszn0I4sEkw-1; Tue, 28 Mar 2023 11:48:49 -0400
X-MC-Unique: qH08vMOsMlyzszn0I4sEkw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-746bae78af3so35310685a.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 08:48:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680018529;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+goQQ7nfkdzV94CFZrSygIQBY2Lhnm0tpScL2liQamE=;
        b=MSBBRCQwd4NgeloRfKTcGqm9nZb63nF1anRVQ2/MoHlzcoXSzWJoAx+d90v0t6/3GV
         I0iLS2JXtKpfD/YEARP1qjfr+qcrMA7PjPMoj/rubNWHvG253ZAzaUMHiangUHFOYQXj
         z1LnbpTjyIX0zD2v7jBEK/159yTXRt20nH7fxFhTKzxLdgxoxyfVJSfpiho2jRkVySSF
         D4/S9ztekxijRVCdp3HdwyEqlpme/kVrkbGCdUr4YN903J36lG07gGLZn/r1wwDd2Cjg
         QYSd9NWijC3Xf9Qs7Xp2/p2o6Dl//o9C40NcM0cKuZCgqwzKl8MJIAP8WKZsUOFJB6Jt
         f1sg==
X-Gm-Message-State: AAQBX9f7nzjUcQalpGHTlNT4qDs4mc3jocuBKulk60wltZO4wRAa+JsR
        5KQyLcUx1qTDzqUmVQPM6tqfH29v2KIv923tLdORaH4JJQKr3BGneMiMSFW6ErDGbrYh3ldBpJy
        7/arA5xMh3r4crbQsaJUC6vLV
X-Received: by 2002:a05:6214:529e:b0:5df:466f:9ed7 with SMTP id kj30-20020a056214529e00b005df466f9ed7mr3798450qvb.5.1680018528843;
        Tue, 28 Mar 2023 08:48:48 -0700 (PDT)
X-Google-Smtp-Source: AKy350a+iZzU8tvIt9kNMTIn8i6Nrww87gqpHRJjLYYgpvZZAW1Vx/NZ6D4Fbx/xVLMkikEQ9HJa+A==
X-Received: by 2002:a05:6214:529e:b0:5df:466f:9ed7 with SMTP id kj30-20020a056214529e00b005df466f9ed7mr3798421qvb.5.1680018528455;
        Tue, 28 Mar 2023 08:48:48 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-40-70-52-229-124.dsl.bell.ca. [70.52.229.124])
        by smtp.gmail.com with ESMTPSA id c68-20020a379a47000000b00746aa080eefsm8224540qke.6.2023.03.28.08.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:48:47 -0700 (PDT)
Date:   Tue, 28 Mar 2023 11:48:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/3] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <ZCMMU9aZbSsXoyuH@x1n>
References: <20230307052036.1520708-1-stevensd@google.com>
 <20230307052036.1520708-3-stevensd@google.com>
 <28afde5c-a9e7-9d18-8375-4368eb137b5@google.com>
 <CAD=HUj4q0yMXmUHNNqDS1y_GSy100Tm52utg5eZytixeq6ce+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=HUj4q0yMXmUHNNqDS1y_GSy100Tm52utg5eZytixeq6ce+Q@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:34:07PM +0900, David Stevens wrote:
> On Fri, Mar 24, 2023 at 4:48 AM Hugh Dickins <hughd@google.com> wrote:
> >
> > On Tue, 7 Mar 2023, David Stevens wrote:
> >
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > Make sure that collapse_file respects any userfaultfds registered with
> > > MODE_MISSING. If userspace has any such userfaultfds registered, then
> > > for any page which it knows to be missing, it may expect a
> > > UFFD_EVENT_PAGEFAULT. This means collapse_file needs to be careful when
> > > collapsing a shmem range would result in replacing an empty page with a
> > > THP, to avoid breaking userfaultfd.
> > >
> > > Synchronization when checking for userfaultfds in collapse_file is
> > > tricky because the mmap locks can't be used to prevent races with the
> > > registration of new userfaultfds. Instead, we provide synchronization by
> > > ensuring that userspace cannot observe the fact that pages are missing
> > > before we check for userfaultfds. Although this allows registration of a
> > > userfaultfd to race with collapse_file, it ensures that userspace cannot
> > > observe any pages transition from missing to present after such a race
> > > occurs. This makes such a race indistinguishable to the collapse
> > > occurring immediately before the userfaultfd registration.
> > >
> > > The first step to provide this synchronization is to stop filling gaps
> > > during the loop iterating over the target range, since the page cache
> > > lock can be dropped during that loop. The second step is to fill the
> > > gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
> > > time, to avoid races with accesses to the page cache that only take the
> > > RCU read lock.
> > >
> > > The fact that we don't fill holes during the initial iteration means
> > > that collapse_file now has to handle faults occurring during the
> > > collapse. This is done by re-validating the number of missing pages
> > > after acquiring the page cache lock for the final time.
> > >
> > > This fix is targeted at khugepaged, but the change also applies to
> > > MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
> > > return EBUSY if there are any missing pages (instead of succeeding on
> > > shmem and returning EINVAL on anonymous memory). There is also now a
> > > window during MADV_COLLAPSE where a fault on a missing page will cause
> > > the syscall to fail with EAGAIN.
> > >
> > > The fact that intermediate page cache state can no longer be observed
> > > before the rollback of a failed collapse is also technically a
> > > userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
> > > is exceedingly unlikely that anything relies on being able to observe
> > > that transient state.
> > >
> > > Signed-off-by: David Stevens <stevensd@chromium.org>
> > > Acked-by: Peter Xu <peterx@redhat.com>
> >
> > This patch looks to me like a lot of unnecessary (and not very pretty)
> > change, with surprising use of XA_RETRY_ENTRY outside of xarray internals.
> >
> > I think you probably worked on this one, knowing what you intended in 3/3
> > to follow.  But if 3/3 as such does not follow, why can't this one just
> > leave collapse_file()'s code flow unchanged, but insert the
> > > +             vma_interval_tree_foreach(vma, &mapping->i_mmap, start, start) {
> > > +                     if (userfaultfd_missing(vma)) {
> > you need somewhere just before copying and clearing the pages data?
> > Limited to CONFIG_USERFAULTFD=y and shmem and nr_none to minimize impact.
> > The locked !uptodate hpage in the xarray keeping others at bay as before.
> 
> The complication here is that there are places that examine the page
> cache without actually examining the pages in the page cache, and thus
> don't lock the pages they see. At the very least, folio_seek_hole_data
> and shmem_mfill_atomic_pte do so today. I should have included this in
> the commit message.
> 
> I suppose we could require that anything that might examine shmem page
> cache must lock any pages it sees regardless of whether or not it
> actually needs to access the pages, and then update the two functions
> I referenced plus any other similar functions I've missed. I went with
> the approach I did because I felt that localized complexity in
> collapse_file that minimizes intermediate state visible throughout the
> mm subsystem would be preferable. However, if that isn't actually
> preferable, I can take the approach you suggested. Especially now that
> we probably want to fix folio_seek_hole_data anyway.
> 
> > Hmm, looking at that extract, is "start, start" correct?
> 
> That's definitely a bug, good catch.
> 
> > And everywhere
> > else in mm/khugepaged.c is checking userfaultfd_armed(vma): I imagine
> > one or the other is more correct, but I'm not at all a userfaultfder.
> 
> IIUC, the check for userfaultfd_wp in retract_page_tables is
> sufficient for uffd-wp in the shmem case. Simply collapsing a range in
> the underlying shmem file shouldn't affect the semantics of uffd-wp.

Yes that should be the case.  I think this allows shmem page cache to be
still collapse-able into a thp even if some vma has uffd-wp registered. On
a uffd-wp enabled VMA it keeps using pte mappings, while other vmas that
map the same page can map it as thp.

> I could be missing something, though, so Peter would probably be the one
> to know for sure. As for uffd-minor, its interactions with khugepaged are
> currently hopelessly undefined.

Right, my guess is we're purely lucky because currently khugepaged (or the
new MADV_COLLAPSE) merge file thps lazily so we only drop ptes/pmd rather
than installing the new pmd.

To minor mode it means old pte holes will keep being holes (with pmd entry
dropped as a whole, though). It's just that there can be present ptes
becoming holes after collapsed so there can be false positives after the
collapsing of the page cache.  Should not be a problem for minor mode as
long as holes are not populated without being noticed.  After all, minor
mode is a tricky feature, and it's prone to false positives from the 1st
day because file ptes can get lost for a lot of reasons..

If checking userfaultfd_armed() here it'll also work I think, but it won't
help much with e.g. minor mode because at this stage we've already freezed
all existing small pages and unmapped all the ptes anyway, so false
positive is not avoidable anyway for minor mode.  Meanwhile it'll stop the
chance of processes to use shm thp mappings as long as they have a sharer
vma that registered with any type of uffd.  So checking missing here only
seems to be a good choice.

-- 
Peter Xu

