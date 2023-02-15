Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD3026987CF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjBOW2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:28:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjBOW2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:28:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9519E15545
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676500076;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vft1Qv3jLlAD1lBQ+InfzxWLMn34pjK5f9gIV8ktH5k=;
        b=FOVg79UDSwWl7TJcfONvlnEhL8re4G1Nbj9XmC0gFjnEJ7COSQzY5HkejkBwWD4G4Qg9Kb
        3YG+3li4qa2hSPdIzrZBE37lpukfm3/bqw1Dh/b3wztQrc7lDCRtbifI/9cnAH15ggG+hY
        cE5OZbJYvRSGQ3Wc604A+lvCat3PaTs=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-287-w-C7pwiuO861969-9bjqmQ-1; Wed, 15 Feb 2023 17:27:55 -0500
X-MC-Unique: w-C7pwiuO861969-9bjqmQ-1
Received: by mail-il1-f197.google.com with SMTP id o10-20020a056e02102a00b003006328df7bso222622ilj.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:27:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vft1Qv3jLlAD1lBQ+InfzxWLMn34pjK5f9gIV8ktH5k=;
        b=ahRKLBzzBaYnx332DV2UXf6rvIb5ScH7H3E+67qp7xti+e5xmnsVB1Se4DXU9t8Qeb
         ISIIXAxR3CCej8jZfeulobY7hmw1L8vwbEjNtVqiGwbRsKDN5hqPatLQ+zGVSQCLbPHm
         O4S1+7AcBW9PuSwWgLfmS6oKEEaLliN4HkY9w3HpZbp+FysoEk9Myyzk8oeokxBrvZEh
         Rb8Gs2v1WShbIpzPR48/QFkqQZYwRegS6OEZibwW9VOUGORE5XPlTRgELU2uxAOTetgd
         3q5ZokAtVa7img5Su5KPT/4o88LU+zRoFoPKn43SZyAEksX0HEyOCglZpD/SHEyL7tL2
         dZbg==
X-Gm-Message-State: AO0yUKVIHRxJKLBNEU4T96IA9IYYEUu13KmqsyYh3SB1v+OEHMA73yTG
        otfjoovfjXjxSfjyX8z8XEw19MSg0Vho2OCuQEljz1CVkTQ98E+RjEXktDbGFtyT1sVj6j6oGyH
        RXSVhYngCSnUPk0rfbMn6+N/u
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr2423120iox.0.1676500074420;
        Wed, 15 Feb 2023 14:27:54 -0800 (PST)
X-Google-Smtp-Source: AK7set8YQb9C6xFgZu/24UXnVJo7RqQebXMxXct5eaVPh3FRSWk6iqMS8w5jj8njEBwcZYSo5ASRlg==
X-Received: by 2002:a05:6602:5cd:b0:73a:6c75:5a85 with SMTP id w13-20020a05660205cd00b0073a6c755a85mr2423104iox.0.1676500074087;
        Wed, 15 Feb 2023 14:27:54 -0800 (PST)
Received: from x1n (bras-base-aurron9127w-grc-56-70-30-145-63.dsl.bell.ca. [70.30.145.63])
        by smtp.gmail.com with ESMTPSA id g2-20020a056602242200b007437276ae6dsm233214iob.3.2023.02.15.14.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:27:53 -0800 (PST)
Date:   Wed, 15 Feb 2023 17:27:52 -0500
From:   Peter Xu <peterx@redhat.com>
To:     David Stevens <stevensd@chromium.org>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/khugepaged: skip shmem with userfaultfd
Message-ID: <Y+1caMCj3AjEU7BK@x1n>
References: <20230214075710.2401855-1-stevensd@google.com>
 <20230214075710.2401855-2-stevensd@google.com>
 <Y+wMvVjDpW0nlaPu@x1n>
 <CAD=HUj6c0=-6GRR60up5Jq5CaYbRn8XfSuUvL70Lip6EDB_E-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=HUj6c0=-6GRR60up5Jq5CaYbRn8XfSuUvL70Lip6EDB_E-w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 10:57:11AM +0900, David Stevens wrote:
> On Wed, Feb 15, 2023 at 7:35 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Hi, David,
> >
> > On Tue, Feb 14, 2023 at 04:57:10PM +0900, David Stevens wrote:
> > > From: David Stevens <stevensd@chromium.org>
> > >
> > > Make sure that collapse_file respects any userfaultfds registered with
> > > MODE_MISSING. If userspace has any such userfaultfds registered, then
> > > for any page which it knows to be missing, it may expect a
> > > UFFD_EVENT_PAGEFAULT. This means collapse_file needs to take care when
> > > collapsing a shmem range would result in replacing an empty page with a
> > > THP, so that it doesn't break userfaultfd.
> > >
> > > Synchronization when checking for userfaultfds in collapse_file is
> > > tricky because the mmap locks can't be used to prevent races with the
> > > registration of new userfaultfds. Instead, we provide synchronization by
> > > ensuring that userspace cannot observe the fact that pages are missing
> > > before we check for userfaultfds. Although this allows registration of a
> > > userfaultfd to race with collapse_file, it ensures that userspace cannot
> > > observe any pages transition from missing to present after such a race.
> > > This makes such a race indistinguishable to the collapse occurring
> > > immediately before the userfaultfd registration.
> > >
> > > The first step to provide this synchronization is to stop filling gaps
> > > during the loop iterating over the target range, since the page cache
> > > lock can be dropped during that loop. The second step is to fill the
> > > gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
> > > time, to avoid races with accesses to the page cache that only take the
> > > RCU read lock.
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
> > > ---
> > >  mm/khugepaged.c | 66 +++++++++++++++++++++++++++++++++++++++++++------
> > >  1 file changed, 58 insertions(+), 8 deletions(-)
> >
> > Could you attach a changelog in your next post (probably with a cover
> > letter when patches more than one)?
> >
> > Your patch 1 reminded me that, I think both lseek and mincore will not
> > report DATA but HOLE on the thp holes during collapse, no matter we fill
> > hpage in (as long as hpage being !uptodate) or not (as what you do with
> > this one).
> >
> > However I don't understand how this new patch can avoid the same race issue
> > I mentioned in the last version at all.
> 
> If find_get_entry sees an XA_RETRY_ENTRY, then it will re-read from
> the xarray. This means find_get_entry will loop while we're finalizing
> the collapse - either until we finalize the collapse with the
> multi-index hpage entry or abort the collapse and clear the retry
> entry. This means that even if userspace registers a userfaultfd and
> calls lseek after khugepage check for userfaultfd, the call to lseek
> will block until the collapse is finished.
> 
> There are a number of other places in filemap.c/shmem.c that do their
> own iteration over the xarray, and they all retry on xas_retry() as
> well.

I've no problem on using RETRY entries (as long as others are fine with it
:).  It seems your logic depends on patch 1 being there already, so right
after the RETRY got replaced with the thp it'll show Uptodate==DATA.

However I doubt whether patch 1 is correct at all..  Maybe that can be
instead fixed by having:

		folio_mark_uptodate(folio);

To be before:

		xas_set_order(&xas, start, HPAGE_PMD_ORDER);
		xas_store(&xas, hpage);

To replace patch 1, but I think there's still some issue in patch 2 even if
it works.  Ouch, I cut the codes..  I'll comment inline in another reply.

-- 
Peter Xu

