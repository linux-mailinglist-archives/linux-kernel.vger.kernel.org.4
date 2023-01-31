Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FDB683141
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233019AbjAaPUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjAaPTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:19:55 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA93561B9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:17:55 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id az37so80526vkb.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HO4BAIAwhR/8dHxNa4V65cuTt/guC5rFbEzUi17Mn2w=;
        b=e1IRDig/BS4/25E0+MVfobgLvc/UM4UNqF6kD8IGE0/UEhC3wzw/drzzheebsPSLgI
         BjZYuVg7p4221/Jx9PsX/4ghN+bTo7krsS/k7SxBwAhmq9i7ZrLeNb3rWaGS1GlXnZcZ
         mQTPEBYHDv8tiEz1ow9bo59/5JhlRt7V9VU3iRMi0a8zlaj1pdcxvvvXCq1GRI0YPHoA
         C6FjpAP+Fcy9cOofoWoWrLyzEmerFPqeT9pp5vHQthr6b/rMUScjD257bKPcXNnhKLsG
         1NOC9/gI20SYcARxjWaW+hnwAhFoHHimi2SVEdBSUsjMh5PPl1f5Wi0NQ3vUir5e7CtB
         cX9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HO4BAIAwhR/8dHxNa4V65cuTt/guC5rFbEzUi17Mn2w=;
        b=DnZaIeF+W39lIO0rpy+4EpAAL7Gru/+T4pgDSVm9/7yKakmPUPeS8wMfTr28cuQnje
         dUYamIagTChsuMCaqqvzxJmoAui+Ko0YaOTgf9SIbO0oEIQsa2e40vDStkGqu8xbHi9x
         vAp0rEwNOIqiTiUkN/C58J5K2ckpyg2NPhODqd2QY+2P98F44KLOOX0BWVAqxT+vLmJr
         nEnHKEwg3TZ6cK+7nr0imI0ctqJ5cmB7GYsGWOX5oZ183bPOd+6Npwt+I5YbQIF4hVmH
         bUApeLCWnB0d0XNKzdw9k/q8jKH21bVxZY3PsO8X+sPU8jZwxdZIwJZqD5m7mK596sjp
         FXOA==
X-Gm-Message-State: AO0yUKVhWToV/uGbbskyz1mnOuXpNH9QX0MM+DWYthfQYgLwpBT7B4SZ
        8LUfZ25xyS0jHYi+3pWi6sGPn1R1E6yqlIriptD9yA==
X-Google-Smtp-Source: AK7set94yyrXZTv7NqDwMt5QRHdrOS7b64VoCkDah2vhsGZl+yBW/4zrsMXWM4PUmBC1tET2r43LEgEfvXfSo7lQnkI=
X-Received: by 2002:a05:6122:2498:b0:3e8:a035:4860 with SMTP id
 by24-20020a056122249800b003e8a0354860mr2655158vkb.7.1675178274749; Tue, 31
 Jan 2023 07:17:54 -0800 (PST)
MIME-Version: 1.0
References: <20230130130739.563628-1-arnd@kernel.org> <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
 <CAG_fn=UC-zPKfXvhnXO-Hb7Wp3+BJyT4WvotATigigb63N0tdA@mail.gmail.com> <Y9kwTXhAQiEWz0IJ@dhcp22.suse.cz>
In-Reply-To: <Y9kwTXhAQiEWz0IJ@dhcp22.suse.cz>
From:   Alexander Potapenko <glider@google.com>
Date:   Tue, 31 Jan 2023 16:17:18 +0100
Message-ID: <CAG_fn=UiLM+5uKR+SP_=XVfqxKATi26uByZnV5b=3KNSiV3eHw@mail.gmail.com>
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

On Tue, Jan 31, 2023 at 4:14 PM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 30-01-23 18:59:45, Alexander Potapenko wrote:
> > On Mon, Jan 30, 2023 at 2:38 PM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Mon 30-01-23 14:07:26, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > After x86 has enabled support for KMSAN, it has become possible
> > > > to have larger 'struct page' than was expected when commit
> > > > 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b
> > > > architectures") was merged:
> > > >
> > > > include/linux/mm.h:156:10: warning: no case matching constant switch condition '96'
> > > >         switch (sizeof(struct page)) {
> > > >
> > > > Extend the maximum accordingly.
> > > >
> > > > Fixes: 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b architectures")
> > > > Fixes: 4ca8cc8d1bbe ("x86: kmsan: enable KMSAN builds for x86")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > >
> > > I haven't really followed KMSAN development but I would have expected
> > > that it would, like other debugging tools, add its metadata to page_ext
> > > rather than page directly.
> >
> > Thanks for the comment!
> > I was considering page_ext at some point, but managed to convince
> > myself it didn't suit the purpose well enough.
> >
> > Right now KMSAN allocates its metadata at boot time, when tearing down memblock.
> > At that point only a handful of memory ranges exist, and it is pretty
> > easy to carve out some unused pages for the metadata for those ranges,
> > then divide the rest evenly and return 1/3 to the system, spending 2/3
> > to keep the metadata for the returned pages.
> > I tried allocating the memory lazily (at page_alloc(), for example),
> > and it turned out to be very tricky because of fragmentation: for an
> > allocation of a given order, one needs shadow and origin allocations
> > of the same order [1], and alloc_pages() simply started with ripping
> > apart the biggest chunk of memory available.
>
> page_ext allocation happens quite early as well. There shouldn't be any
> real fragmentation that early during the boot.
>
> > IIRC if we choose to allocate metadata via page_ext, the memory will
> > be already too fragmented to easily handle it, because it will only
> > happen once alloc_pages() is available.
> > We also can't get rid of the shadow/origin pointers in struct page_ext
> > (storing two 4K-sized arrays in that struct would defeat all the
> > possible alignments), so we won't save any memory by switching to
> > page_ext.
>
> With page_ext you would allow to compile the feature in disabled by
> default and allow to boot time enable it.

This makes little sense to do, because KMSAN requires heavy
compile-time instrumentation to work. One cannot simply enable/disable
it at boot time anyway.
