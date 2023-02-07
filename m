Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5847468CBFA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 02:37:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjBGBhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 20:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbjBGBhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 20:37:20 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E6A234EE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 17:37:19 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id b3so20354522lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 17:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eU++fqEUJX8cwR4D2NbMbR+6raSWlUuTlSOTzvIMyWg=;
        b=kBifM5uL9aZ5KGZnGGav4RQBQrVOT0claqc8AFQDXa/Ad1Z3Ggzv9iEsrAC/x+UiP8
         xInTL9BS47T7ZYdaljK/hh/D846MNQFY3zCEbFWRFbsQjQsFkV5qrPz6wne/CVACXU0S
         P4WdaS7C/fFv51JDcoyH9GcKHCsdtb9JbO4tQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eU++fqEUJX8cwR4D2NbMbR+6raSWlUuTlSOTzvIMyWg=;
        b=Amp1VSRUABMXW85ch8JWNwkLHV7n8BipdpfAxNjBQNxZxibHKAtMEVrgPeMVGTXhEh
         F4FgmyYcHMboEaW4wvmRoGjDURam6V6oAXajmhpr31ixqE1wo7mG9n6UlL0+fdVhKzrL
         Cdy4iEDaOo12MzVdhoUfpeCdb7EsmzHCa2DmnxmoJKYHTlhNYzY1T7D3419VQe6ZqSHx
         TAxQ9AONm9puBELP1j9GD0XxguJY7Rn/YMZ6aE+tZX1vaOJbXyp5munB2huS28EFR4KP
         vGA3imzLxDBIUeWxe2Pj9xNfRodVUnOR/MgaldcAd+Oe3u4Anme4jftESjaxNeRko1Cj
         k6RA==
X-Gm-Message-State: AO0yUKW2BnK4XgIqEc5bnIrQjMBPKQHIXofzcd/XaW3JR/oLG3dh5sY1
        5Xkh3Y1BjJI64ARcx/HGrbzAQavQ0a2Ip+izz/rntQ==
X-Google-Smtp-Source: AK7set/CtrNgWAHZLyKi/Mo81kmaz28qsBKopec0QsnnFFgLus7VRxwENd555WGn37yH3UvsQRTpHAaiaqhw8bhcs0k=
X-Received: by 2002:ac2:42cf:0:b0:499:f8e4:6dd0 with SMTP id
 n15-20020ac242cf000000b00499f8e46dd0mr151597lfl.162.1675733837659; Mon, 06
 Feb 2023 17:37:17 -0800 (PST)
MIME-Version: 1.0
References: <20230206112856.1802547-1-stevensd@google.com> <Y+FOk+ty7OKmkwLL@casper.infradead.org>
 <Y+Fog2dO1kpRBMvr@x1n> <Y+F2IdXhqc5187s+@casper.infradead.org>
In-Reply-To: <Y+F2IdXhqc5187s+@casper.infradead.org>
From:   David Stevens <stevensd@chromium.org>
Date:   Tue, 7 Feb 2023 10:37:06 +0900
Message-ID: <CAD=HUj4yhMLnBNpumxC4urSY2Js5XuekzGP+UOXJmUV=k5nx=A@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 6:50 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 06, 2023 at 03:52:19PM -0500, Peter Xu wrote:
> > On Mon, Feb 06, 2023 at 07:01:39PM +0000, Matthew Wilcox wrote:
> > > On Mon, Feb 06, 2023 at 08:28:56PM +0900, David Stevens wrote:
> > > > This change first makes sure that the intermediate page cache state
> > > > during collapse is not visible by moving when gaps are filled to after
> > > > the page cache lock is acquired for the final time. This is necessary
> > > > because the synchronization provided by locking hpage is insufficient
> > > > for functions which operate on the page cache without actually locking
> > > > individual pages to examine their content (e.g. shmem_mfill_atomic_pte).
> > >
> > > I've been a little scared of touching khugepaged because, well, look at
> > > that function.  But if we are going to touch it, how about this patch
> > > first?  It does _part_ of what you need by not filling in the holes,
> > > but obviously not the part that looks at uffd.
> > >
> > > It leaves the old pages in-place and frozen.  I think this should be
> > > safe, but I haven't booted it (not entirely sure what test I'd run
> > > to prove that it's not broken)
> >
> > That logic existed since Kirill's original commit to add shmem thp support
> > on khugepaged, so Kirill should be the best to tell.. but so far it seems
> > reasonalbe to me to have that extra operation.
> >
> > The problem is khugepaged will release pgtable lock during collapsing, so
> > AFAICT there can be a race where some other thread tries to insert pages
> > into page cache in parallel with khugepaged right after khugepaged released
> > the page cache lock.
> >
> > For example, it seems to me new page cache can be inserted when khugepaged
> > is copying small page content to the new hpage.

This particular race can't happen with either patch, since the missing
page cache entries are filled when we create the multi-index entry for
hpage.

> Mmm, yes, we need to have _something_ in the page cache to block new
> pages from being added.  It can be either the new or the old pages,
> but it can't be NULL.  It could even be a RETRY entry, since that'll
> have the same effect as a frozen page.
>
> But both David's patch and mine are wrong.  Not sure what to do for
> David's problem -- maybe it's OK to have the holes temporarily filled
> with frozen / RETRY entries until we get to the point where we check
> for an uffd marker?

My patch re-counts the holes after acquiring the page cache lock for
the final time, right before creating the final hpage multi-index
entry. Since we lock present pages while iterating over the target
range, they can't have been truncated before our re-validation of
nr_none. So if the number of missing pages is still equal to nr_none,
then we know that nothing has come along and filled in a missing page.
Compared to adding some sort of marker for missing pages, this does
add another failure path for collapse, but I don't think there is any
race.

-David
