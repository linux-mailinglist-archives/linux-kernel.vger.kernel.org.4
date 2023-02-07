Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634A768CE0E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 05:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjBGEPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 23:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbjBGEOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 23:14:40 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47730360AC
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 20:14:17 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id u12so20763844lfq.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 20:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+f7wjDPMrHW1PNP9DoscYbX49wctOswrwmMtmDVlKE8=;
        b=E6oFlolHJG5LWRWBkgxC0HcMNgoOleW+DNPE3juT6cQlrj0o1SMbutZOLszkJqL/nw
         ViDOqQfC/xwrP+UF2KzvQPRqofWumRHxI9jQD7z93r4sXZtd5lZSpYp1les3D4lKJQ5W
         31YQesE1AHi0oHi0VsrW5A23GZK43KV1hH6Es=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+f7wjDPMrHW1PNP9DoscYbX49wctOswrwmMtmDVlKE8=;
        b=vpXKSIGC0kCUhIL8WYejrCbu5/Z15YPNa9goMzHtjkn8pFa/KeQJSDNaJdiTE3Q5Sv
         cZD5gnZgb8qiSTtzhdSaL65FChkcw0zwaNRYfXUrXTWKZTfXTCim81b1yJR1YwdIAx9m
         PrZk6zbxs8H/TgL+ZzBKrECST/j/ZnJ77ZZ3PXUTsOOEVx0H809LCjXxxWBMFdHUp9ha
         AUur///ri8wAAM+sR5UCVQm5nqS7UvKmRtI3ZpLAjOggzja3/aulZyAf8OMC+3K9wwaU
         stKAJQloCln/YNMyrwOxSNcJ9BXOr0fXmvI+IslGEFTM4vV5z69RSTis2vmfZ2P1CvJ3
         xEKA==
X-Gm-Message-State: AO0yUKWGdkAMcYljLYVXgeI8IixWHDOoMYGJXJqapG3RjBMhxDZfinzL
        rUlYvCk0BiueUni1lg01FHJtZWYhpACh7acWj69t7A==
X-Google-Smtp-Source: AK7set8Sc2MnagCUxPldxu00Oh2fYduHpcAG5njrtPtAX+v6euiFZ3BkdoI0/eECrSdLrd1hBfYnlN1EahKKcj+Les0=
X-Received: by 2002:ac2:528c:0:b0:4cb:6bcb:de45 with SMTP id
 q12-20020ac2528c000000b004cb6bcbde45mr239520lfm.272.1675743255429; Mon, 06
 Feb 2023 20:14:15 -0800 (PST)
MIME-Version: 1.0
References: <20230206112856.1802547-1-stevensd@google.com> <Y+FOk+ty7OKmkwLL@casper.infradead.org>
 <Y+Fog2dO1kpRBMvr@x1n> <Y+F2IdXhqc5187s+@casper.infradead.org>
 <CAD=HUj4yhMLnBNpumxC4urSY2Js5XuekzGP+UOXJmUV=k5nx=A@mail.gmail.com> <Y+G3lDu3UPFZcFE0@casper.infradead.org>
In-Reply-To: <Y+G3lDu3UPFZcFE0@casper.infradead.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 7 Feb 2023 13:14:04 +0900
Message-ID: <CAD=HUj4vyfsEc=vdEDPKm_gaTO94odpVxeCT3mto5sP3RcgRzg@mail.gmail.com>
Subject: Re: [PATCH v2] mm/khugepaged: skip shmem with userfaultfd
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
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

On Tue, Feb 7, 2023 at 11:29 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Feb 07, 2023 at 10:37:06AM +0900, David Stevens wrote:
> > On Tue, Feb 7, 2023 at 6:50 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > On Mon, Feb 06, 2023 at 03:52:19PM -0500, Peter Xu wrote:
> > > > The problem is khugepaged will release pgtable lock during collapsing, so
> > > > AFAICT there can be a race where some other thread tries to insert pages
> > > > into page cache in parallel with khugepaged right after khugepaged released
> > > > the page cache lock.
> > > >
> > > > For example, it seems to me new page cache can be inserted when khugepaged
> > > > is copying small page content to the new hpage.
> >
> > This particular race can't happen with either patch, since the missing
> > page cache entries are filled when we create the multi-index entry for
> > hpage.
>
> Can too.
>
>         for (index = start; index < end; index++) {
> ...
>                         if (xa_is_value(page) || !PageUptodate(page)) {
>                                 xas_unlock_irq(&xas);
>                                 /* swap in or instantiate fallocated page */
>                                 if (shmem_get_folio(mapping->host, index,
>                                                 &folio, SGP_NOALLOC)) {
>                                         result = SCAN_FAIL;
>                                         goto xa_unlocked;
>                                 }
> ...
>
> So we start the iteration, and then a page fault happens in one of
> the indices we've already examined, but we don't have the page on
> the list.  It's a nice wide race too because we're bringing the
> page in from swap.
>

Ah, I misunderstood your objection to refer specifically to the
copy_highpage loop at the end of collapse_file, rather than the entire
process of the collapse.

Yes, there can definitely be faults that fill in pages during the
overall process of collapsing. However, my patch re-checks nr_none
after acquiring the page cache lock for the final time, right before
creating the hpage multi-index entry. Since present pages are locked,
they can't be truncated after we've looked at them. That means that if
nr_none still matches, then there weren't any page faults that
populated missing pages. If we do detect any filled in pages, we can
just roll back the collapse to avoid any problems.

-David
