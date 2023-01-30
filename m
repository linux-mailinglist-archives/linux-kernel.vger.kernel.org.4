Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C79468181D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237184AbjA3SA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbjA3SAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:00:24 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4B3CE3C
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:00:23 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id e9so5551194vsj.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:00:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qeeO0muJc63AtgyRY2bnkkH6u3phpiwZmrClVwHeBEo=;
        b=V6GP4VfZrNzU2D5zuwo0NPyl2YHs9yVedxsvI9A0n4rROnmatrdp+Cw2M637sJPJU8
         64kESSJMYPeVdsTxAIpuzTqdHCDS+KXmY/WUXkFyDMbu513QW1N0VNrPMomf89OMALiA
         1Y6yfXsa/EHS4OCNJyOe+iCzfGpPSOCPSHxDr9u7G/DpQChv1ucdDQ9bAk+kwhisjCxG
         Eea/ER8QqpGzttvYYE9BHL8uSAs6slzQU9pdwCFT2rBfGSBBjkyX8BFv15TVzNT/ulFc
         M7OSyijc4mHujcNMTpsmlW0adMJettHikS6Bu5QFVURLBVWsbf/glckrzdtBukLqKs0O
         L6XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qeeO0muJc63AtgyRY2bnkkH6u3phpiwZmrClVwHeBEo=;
        b=JP6uo/0n3j/2kxD6faGsCsoi7fsgCpk4wmP142I8VCubG7dgZsIYckZzq3S1Qp1fmb
         7Kzy+ktrIp8PwVtYpe8jHRLiFVD634ss1+VZ/BuQYBY7Jn0SWxs909JzjAhPok+4kPgE
         3slWr7L4EVTVQ148SbgnY7gMuNDhBZkanRrOx4JzaduCRFvKDyNGXATzJVVqUlrMd7s1
         vK0C4ISX4O44WpD57bOycNPTPFpU0ks8k6Sxn+FQHiKcL226BPtN/2i2svnuA4dY6xA4
         DEDRL/hqgVVadAApOqRn7TJiRr1q6cYj0txlLPx5gAbdgGhk10ZBWcJiJKuL7FDClSEN
         V0Tg==
X-Gm-Message-State: AO0yUKWjKGbPe8XFJ/4JBba4uOlVyxkKhOrkhJ6zj0Mchgz+KzjQwxtM
        EEm0m1MACNqtwV9/OKehYpxzcsd9+xfi3I8Yt26Ajg==
X-Google-Smtp-Source: AK7set/TYaFtWnZHcBBMy2SDxHlTt70E23XScKK0Y1EW7ItjvJ4FTz76KujSZX0gdHshdVQ5dK8L1GnHnJ6gOWXWtg4=
X-Received: by 2002:a05:6102:449:b0:3fc:3a9e:3203 with SMTP id
 e9-20020a056102044900b003fc3a9e3203mr224518vsq.84.1675101621972; Mon, 30 Jan
 2023 10:00:21 -0800 (PST)
MIME-Version: 1.0
References: <20230130130739.563628-1-arnd@kernel.org> <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
In-Reply-To: <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Mon, 30 Jan 2023 18:59:45 +0100
Message-ID: <CAG_fn=UC-zPKfXvhnXO-Hb7Wp3+BJyT4WvotATigigb63N0tdA@mail.gmail.com>
Subject: Re: [PATCH] mm: extend max struct page size for kmsan
To:     Michal Hocko <mhocko@suse.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Hugh Dickins <hughd@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alex Sierra <alex.sierra@amd.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Jan 30, 2023 at 2:38 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 30-01-23 14:07:26, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > After x86 has enabled support for KMSAN, it has become possible
> > to have larger 'struct page' than was expected when commit
> > 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b
> > architectures") was merged:
> >
> > include/linux/mm.h:156:10: warning: no case matching constant switch condition '96'
> >         switch (sizeof(struct page)) {
> >
> > Extend the maximum accordingly.
> >
> > Fixes: 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b architectures")
> > Fixes: 4ca8cc8d1bbe ("x86: kmsan: enable KMSAN builds for x86")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Michal Hocko <mhocko@suse.com>
>
> I haven't really followed KMSAN development but I would have expected
> that it would, like other debugging tools, add its metadata to page_ext
> rather than page directly.

Thanks for the comment!
I was considering page_ext at some point, but managed to convince
myself it didn't suit the purpose well enough.

Right now KMSAN allocates its metadata at boot time, when tearing down memblock.
At that point only a handful of memory ranges exist, and it is pretty
easy to carve out some unused pages for the metadata for those ranges,
then divide the rest evenly and return 1/3 to the system, spending 2/3
to keep the metadata for the returned pages.
I tried allocating the memory lazily (at page_alloc(), for example),
and it turned out to be very tricky because of fragmentation: for an
allocation of a given order, one needs shadow and origin allocations
of the same order [1], and alloc_pages() simply started with ripping
apart the biggest chunk of memory available.

IIRC if we choose to allocate metadata via page_ext, the memory will
be already too fragmented to easily handle it, because it will only
happen once alloc_pages() is available.
We also can't get rid of the shadow/origin pointers in struct page_ext
(storing two 4K-sized arrays in that struct would defeat all the
possible alignments), so we won't save any memory by switching to
page_ext.



[1] - I can go into more details, but the TLDR is that contiguous
pages within the same allocations better have contiguous shadow/origin
pages, otherwise unaligned accesses will corrupt other pages.
