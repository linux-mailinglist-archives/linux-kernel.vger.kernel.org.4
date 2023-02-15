Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155686973FB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjBOB51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:57:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231686AbjBOB5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:57:25 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07BBCC08
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:57:23 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id g14so20499017ljh.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:57:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cYMyKojxXxWghsfpVdAPfvlnxMoCvfLD+NRFUZR90tk=;
        b=AcguxSU9/O9NtruNgs2xpDm26HeYPyDxEez7bq0rUpyIhBoi1tTFR7+ahB4H5GzwKn
         dY18vJVzL0vPnIPFCILVpTTxWLBHNMopFqesOPPYuoF6J/+XMQwtISmcOL+4o0zv/9ki
         58jwVZe7FuFQohwNEyVX+R7mxEsi7uyAF7EB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYMyKojxXxWghsfpVdAPfvlnxMoCvfLD+NRFUZR90tk=;
        b=jgY4Wuwsd42v48D8CkrCEJ3ntZ/Bvo7JOoCyQsjQG0EJIAZn2UJEwOvLFx6ppTxC+3
         c2oHdkIcBLWiSwnFlwIc0QAPNcv0pq9+i7ygWs8tbzaYszOe0K2rElvFxTrLn2POoqNt
         tQpS8flZLHX6a3RRt+NXVh4fF7vCgqo/bSU6wUKPSJygf2fBNXl9+hg6c6mAuvXtY9sn
         92x+buu7Zdurg1Ti6NjK6med3zHX2+as5yo30YMBrlXumHcJZxeFkdLYeUhkPcq9+OQM
         fiQnyUlvOTDp9PNAx38DXMU9ATa4lThqA2DdNt2iEpDq1g0D+F60LoCnDmo0q1yxT9sH
         GStQ==
X-Gm-Message-State: AO0yUKX3BAD9XrbjAQXrqX6AQMqTIqhPCgcr6uLWU0poQAbFlpsjOdhM
        nt+gLcmataWSrrtqNcjlPWPwqD/6sZDKr8gKk3+tEw==
X-Google-Smtp-Source: AK7set863q/bVzvozkrgJEZCBK9xxNSAnJIlUOHNgskReBusI2JJzk/miopUpJRkyhtVXgauxh3TO1Vaw811U+H9gNo=
X-Received: by 2002:a2e:bc09:0:b0:293:4862:5e31 with SMTP id
 b9-20020a2ebc09000000b0029348625e31mr348809ljf.5.1676426242166; Tue, 14 Feb
 2023 17:57:22 -0800 (PST)
MIME-Version: 1.0
References: <20230214075710.2401855-1-stevensd@google.com> <20230214075710.2401855-2-stevensd@google.com>
 <Y+wMvVjDpW0nlaPu@x1n>
In-Reply-To: <Y+wMvVjDpW0nlaPu@x1n>
From:   David Stevens <stevensd@chromium.org>
Date:   Wed, 15 Feb 2023 10:57:11 +0900
Message-ID: <CAD=HUj6c0=-6GRR60up5Jq5CaYbRn8XfSuUvL70Lip6EDB_E-w@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm/khugepaged: skip shmem with userfaultfd
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-mm@kvack.org, Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Yang Shi <shy828301@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 7:35 AM Peter Xu <peterx@redhat.com> wrote:
>
> Hi, David,
>
> On Tue, Feb 14, 2023 at 04:57:10PM +0900, David Stevens wrote:
> > From: David Stevens <stevensd@chromium.org>
> >
> > Make sure that collapse_file respects any userfaultfds registered with
> > MODE_MISSING. If userspace has any such userfaultfds registered, then
> > for any page which it knows to be missing, it may expect a
> > UFFD_EVENT_PAGEFAULT. This means collapse_file needs to take care when
> > collapsing a shmem range would result in replacing an empty page with a
> > THP, so that it doesn't break userfaultfd.
> >
> > Synchronization when checking for userfaultfds in collapse_file is
> > tricky because the mmap locks can't be used to prevent races with the
> > registration of new userfaultfds. Instead, we provide synchronization by
> > ensuring that userspace cannot observe the fact that pages are missing
> > before we check for userfaultfds. Although this allows registration of a
> > userfaultfd to race with collapse_file, it ensures that userspace cannot
> > observe any pages transition from missing to present after such a race.
> > This makes such a race indistinguishable to the collapse occurring
> > immediately before the userfaultfd registration.
> >
> > The first step to provide this synchronization is to stop filling gaps
> > during the loop iterating over the target range, since the page cache
> > lock can be dropped during that loop. The second step is to fill the
> > gaps with XA_RETRY_ENTRY after the page cache lock is acquired the final
> > time, to avoid races with accesses to the page cache that only take the
> > RCU read lock.
> >
> > This fix is targeted at khugepaged, but the change also applies to
> > MADV_COLLAPSE. MADV_COLLAPSE on a range with a userfaultfd will now
> > return EBUSY if there are any missing pages (instead of succeeding on
> > shmem and returning EINVAL on anonymous memory). There is also now a
> > window during MADV_COLLAPSE where a fault on a missing page will cause
> > the syscall to fail with EAGAIN.
> >
> > The fact that intermediate page cache state can no longer be observed
> > before the rollback of a failed collapse is also technically a
> > userspace-visible change (via at least SEEK_DATA and SEEK_END), but it
> > is exceedingly unlikely that anything relies on being able to observe
> > that transient state.
> >
> > Signed-off-by: David Stevens <stevensd@chromium.org>
> > ---
> >  mm/khugepaged.c | 66 +++++++++++++++++++++++++++++++++++++++++++------
> >  1 file changed, 58 insertions(+), 8 deletions(-)
>
> Could you attach a changelog in your next post (probably with a cover
> letter when patches more than one)?
>
> Your patch 1 reminded me that, I think both lseek and mincore will not
> report DATA but HOLE on the thp holes during collapse, no matter we fill
> hpage in (as long as hpage being !uptodate) or not (as what you do with
> this one).
>
> However I don't understand how this new patch can avoid the same race issue
> I mentioned in the last version at all.

If find_get_entry sees an XA_RETRY_ENTRY, then it will re-read from
the xarray. This means find_get_entry will loop while we're finalizing
the collapse - either until we finalize the collapse with the
multi-index hpage entry or abort the collapse and clear the retry
entry. This means that even if userspace registers a userfaultfd and
calls lseek after khugepage check for userfaultfd, the call to lseek
will block until the collapse is finished.

There are a number of other places in filemap.c/shmem.c that do their
own iteration over the xarray, and they all retry on xas_retry() as
well.

-David
