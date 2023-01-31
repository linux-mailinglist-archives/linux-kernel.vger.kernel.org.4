Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92884683123
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjAaPQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbjAaPQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:16:22 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F6953555
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:14:24 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B0F9E20861;
        Tue, 31 Jan 2023 15:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1675178062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OV/OJTpgobZKCQPy9XYs86MI0Im29Efzc4mHl7jHYoU=;
        b=SXoFGUs2SXaKyexc5VzLHQNpRZuibBtgk63O5h7IrYQ+oKuQA4LFWOSPdAtnSCnLvdDXQh
        MN1ogCJweEH0Br/8YGQIY3uTuZUcjN89m4uFs5HDrN773Qp4XM/hfawX93R5QDKsNmMrgq
        BXepfIX2xJlKcTwVrPwI//VQoSf+4to=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 918D813585;
        Tue, 31 Jan 2023 15:14:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9kdvIk4w2WN7WwAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 31 Jan 2023 15:14:22 +0000
Date:   Tue, 31 Jan 2023 16:14:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Alexander Potapenko <glider@google.com>
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
Subject: Re: [PATCH] mm: extend max struct page size for kmsan
Message-ID: <Y9kwTXhAQiEWz0IJ@dhcp22.suse.cz>
References: <20230130130739.563628-1-arnd@kernel.org>
 <Y9fITnjnIuDz8NYw@dhcp22.suse.cz>
 <CAG_fn=UC-zPKfXvhnXO-Hb7Wp3+BJyT4WvotATigigb63N0tdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UC-zPKfXvhnXO-Hb7Wp3+BJyT4WvotATigigb63N0tdA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 30-01-23 18:59:45, Alexander Potapenko wrote:
> On Mon, Jan 30, 2023 at 2:38 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Mon 30-01-23 14:07:26, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > After x86 has enabled support for KMSAN, it has become possible
> > > to have larger 'struct page' than was expected when commit
> > > 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b
> > > architectures") was merged:
> > >
> > > include/linux/mm.h:156:10: warning: no case matching constant switch condition '96'
> > >         switch (sizeof(struct page)) {
> > >
> > > Extend the maximum accordingly.
> > >
> > > Fixes: 5470dea49f53 ("mm: use mm_zero_struct_page from SPARC on all 64b architectures")
> > > Fixes: 4ca8cc8d1bbe ("x86: kmsan: enable KMSAN builds for x86")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Acked-by: Michal Hocko <mhocko@suse.com>
> >
> > I haven't really followed KMSAN development but I would have expected
> > that it would, like other debugging tools, add its metadata to page_ext
> > rather than page directly.
> 
> Thanks for the comment!
> I was considering page_ext at some point, but managed to convince
> myself it didn't suit the purpose well enough.
> 
> Right now KMSAN allocates its metadata at boot time, when tearing down memblock.
> At that point only a handful of memory ranges exist, and it is pretty
> easy to carve out some unused pages for the metadata for those ranges,
> then divide the rest evenly and return 1/3 to the system, spending 2/3
> to keep the metadata for the returned pages.
> I tried allocating the memory lazily (at page_alloc(), for example),
> and it turned out to be very tricky because of fragmentation: for an
> allocation of a given order, one needs shadow and origin allocations
> of the same order [1], and alloc_pages() simply started with ripping
> apart the biggest chunk of memory available.

page_ext allocation happens quite early as well. There shouldn't be any
real fragmentation that early during the boot.

> IIRC if we choose to allocate metadata via page_ext, the memory will
> be already too fragmented to easily handle it, because it will only
> happen once alloc_pages() is available.
> We also can't get rid of the shadow/origin pointers in struct page_ext
> (storing two 4K-sized arrays in that struct would defeat all the
> possible alignments), so we won't save any memory by switching to
> page_ext.

With page_ext you would allow to compile the feature in disabled by
default and allow to boot time enable it.
 
> [1] - I can go into more details, but the TLDR is that contiguous
> pages within the same allocations better have contiguous shadow/origin
> pages, otherwise unaligned accesses will corrupt other pages.

-- 
Michal Hocko
SUSE Labs
