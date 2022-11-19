Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B2E6310A6
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 21:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234690AbiKSUUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 15:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbiKSUUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 15:20:42 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF96178A6
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 12:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=T0PEwCj46l8kkuAlr919hhJp7yTxS0xQb6cN9Cx/y8Q=; b=sl2rXH8kIZnL9wKiQp7DPMlcAM
        L7kNckDKmOoE1H6KAqu8TOnsaxkJdasnwxOqw7k3QThDsRvbG2ZsU0ppbJ+b1m7lXhhML2GQGvEW7
        1mpWkAPLtX1cVL1XeeQQE57RVorfa2eR9kc3IcniZwC8/BmxNpRiAVNOa1y6gvVG/GrvKWUdp2Iax
        KuW43K0dBTs7LredAr2L0LJ8cHTUF94gTrV1DKz4nIr2BQSAUK3sbSCy1W+L6XXHYJ/srcYjlapo0
        176dw34x996vRvVQIqko6uMzcWfvKZKCwBNNulzbjdc2ohdbnXHNyQP8xRVc5Yb7Am+4gmkG8Hn/e
        y2c2M7JA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1owUKA-003WVF-H8; Sat, 19 Nov 2022 20:20:26 +0000
Date:   Sat, 19 Nov 2022 20:20:26 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     hev <r@hev.cc>
Cc:     Hugh Dickins <hughd@google.com>, Guoqi <chenguoqic@163.com>,
        Huacai Chen <chenhuacai@loongson.cn>, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rui Wang <kernel@hev.cc>
Subject: Re: [RFC PATCH] mm/shmem: Fix undo range for failed fallocate
Message-ID: <Y3k6ip6q+6j8ZBVh@casper.infradead.org>
References: <20221101032248.819360-1-kernel@hev.cc>
 <Y2KBovUHODJJ8ZnV@casper.infradead.org>
 <CAHirt9h2CrLhYML3XW=Vj4=BD5eVDoRAbULVGgNbEdYnAzwCzA@mail.gmail.com>
 <CAHirt9jh=8tRtGi=f2xhhyDn_Qjb-ofSitvsUyFmVwzCrDLiHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHirt9jh=8tRtGi=f2xhhyDn_Qjb-ofSitvsUyFmVwzCrDLiHg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 19, 2022 at 10:45:52PM +0800, hev wrote:
> Ping

I'll be back on Wednesday and will look then.

> On Thu, Nov 3, 2022 at 3:52 PM hev <r@hev.cc> wrote:
> >
> > Hi Matthew,
> >
> > On Wed, Nov 2, 2022 at 10:41 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Nov 01, 2022 at 11:22:48AM +0800, Rui Wang wrote:
> > > > This patch fixes data loss caused by the fallocate system
> > > > call interrupted by a signal.
> > > >
> > > > Bug: https://lore.kernel.org/linux-mm/33b85d82.7764.1842e9ab207.Coremail.chenguoqic@163.com/
> > > > Fixes: b9a8a4195c7d ("truncate,shmem: Handle truncates that split large folios")
> > >
> > > How does that commit introduce this bug?
> >
> > In the test case[1], we created a file that contains non-zero data
> > from offset 0 to A-1. and a process try to expand this file by
> > fallocate(fd, 0, 0, B), B > A.
> > Concurrently, another process try to interrupt this fallocate syscall
> > by a signal. I think the expected results are:
> >
> > 1. The file is not expanded and file size is A, and the data from
> > offset 0 to A-1 is not changed.
> > 2. The file is expanded and the data from offset 0 to A-1 is not
> > changed, and from A to B-1 contains zeros.
> >
> > Now, the unexpected result is that the file is not expanded and the
> > data that from offset 0 to A-1 is changed by
> > truncate_inode_partial_folio that called
> > from shmem_undo_range with unfalloc = true.
> >
> > This issue is only reproduced when file on tmpfs, and begin from this
> > commit: b9a8a4195c7d ("truncate,shmem: Handle truncates that split
> > large folios")
> >
> > >
> > > > Reported-by: Guoqi Chen <chenguoqic@163.com>
> > > > Cc: Huacai Chen <chenhuacai@loongson.cn>
> > > > Signed-off-by: Rui Wang <kernel@hev.cc>
> > > > ---
> > > >  mm/shmem.c | 20 ++++++++++++--------
> > > >  1 file changed, 12 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/mm/shmem.c b/mm/shmem.c
> > > > index bc9b84602eec..8c8dce34eafc 100644
> > > > --- a/mm/shmem.c
> > > > +++ b/mm/shmem.c
> > > > @@ -948,11 +948,13 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
> > > >       folio = shmem_get_partial_folio(inode, lstart >> PAGE_SHIFT);
> > > >       if (folio) {
> > > >               same_folio = lend < folio_pos(folio) + folio_size(folio);
> > > > -             folio_mark_dirty(folio);
> > > > -             if (!truncate_inode_partial_folio(folio, lstart, lend)) {
> > > > -                     start = folio->index + folio_nr_pages(folio);
> > > > -                     if (same_folio)
> > > > -                             end = folio->index;
> > > > +             if (!unfalloc || !folio_test_uptodate(folio)) {
> > > > +                     folio_mark_dirty(folio);
> > > > +                     if (!truncate_inode_partial_folio(folio, lstart, lend)) {
> > > > +                             start = folio->index + folio_nr_pages(folio);
> > > > +                             if (same_folio)
> > > > +                                     end = folio->index;
> > > > +                     }
> > >
> > > ... so what you're saying is that if we allocate a page, but zeroing
> > > it is interrupted by a signal, we cannot now remove that page from
> > > the cache?  That seems wrong.
> > >
> > > Surely the right solution is to remove this page from the cache if we're
> > > interrupted by a signal.
> >
> > So I think we should not truncate_inode_partial_folio for unfalloc =
> > true. Isn't that right?
> >
> > [1] https://github.com/abner-chenc/abner/blob/master/fallocate.c
> >
> > Regards,
> > Ray
> 
