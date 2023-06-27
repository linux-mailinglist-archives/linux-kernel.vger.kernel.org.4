Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B002674031E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjF0SXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbjF0SXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:23:12 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA87187
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1687890184; bh=v0dQ6hMAgl8jHCiG1pCY6SjhXdAmEDS3/FIH3Ei4hE8=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
        b=i/gbtqh3fND+wbDw1ZpKYwq8GOxHx5fRlIIPTArSISXkk+7zBzBv1VW3ra8jHWIp9
         0cPZUVcOp2RRhbNdiaUtqguY2Ipfn51Yh8R8Q/1gUDNl1htdJatZs05IJrt3bsOdxc
         GT2eskzqH/p1nuzUaH0ya0F35EIYlHr1ZCCbNrMY=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Tue, 27 Jun 2023 20:23:04 +0200 (CEST)
X-EA-Auth: nBW1evf6hYP/qjFtPSmMco89i5xksIBGwtxo96zJLVokltIuQIua963927lrc3svbdLapoVV1EaSLFp0i1O1PIZI1IrMVgFA
Date:   Tue, 27 Jun 2023 23:52:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>, cluster-devel@redhat.com,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Sumitra Sharma <sumitraartsy@gmail.com>
Subject: Re: [PATCH v2] gfs2: Replace deprecated kmap_atomic() by
 kmap_local_page()
Message-ID: <ZJspAwi5NycJopQf@bu2204.myguest.virtualbox.org>
References: <ZJk1XTtgLFxIcxzp@bu2204.myguest.virtualbox.org>
 <CAHc6FU6P-BK=rU2w6JcswJsf93TwgvtUNNBe8LU4n2djuNjn_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHc6FU6P-BK=rU2w6JcswJsf93TwgvtUNNBe8LU4n2djuNjn_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 03:45:20PM +0200, Andreas Gruenbacher wrote:
> On Mon, Jun 26, 2023 at 8:51 AM Deepak R Varma <drv@mailo.com> wrote:
> > kmap_atomic() is deprecated in favor of kmap_local_{folio,page}().
> 
> I'll apply this, convert the remaining instances of kmap_atomic(), and
> switch to memcpy_{from,to}_page() where appropriate.

Hello Andreas,
Thank you for your review. I am working on the other conversion opportunities
for this module and will send those in shortly.

Regards,
Deepak.

> 
> Thanks,
> Andreas
> 
> > Therefore, replace kmap_atomic() with kmap_local_page() in
> > gfs2_internal_read() and stuffed_readpage().
> >
> > kmap_atomic() disables page-faults and preemption (the latter only for
> > !PREEMPT_RT kernels), However, the code within the mapping/un-mapping in
> > gfs2_internal_read() and stuffed_readpage() does not depend on the
> > above-mentioned side effects.
> >
> > Therefore, a mere replacement of the old API with the new one is all that
> > is required (i.e., there is no need to explicitly add any calls to
> > pagefault_disable() and/or preempt_disable()).
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> > Note: The Patch is build tested only. I will be happy to run recommended testing
> > with some guidance if required.
> >
> > Changes in v2:
> >    - Update patch description to correct the replacement function name from
> >      kmap_local_folio to kmap_local _page
> >
> >
> >  fs/gfs2/aops.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/gfs2/aops.c b/fs/gfs2/aops.c
> > index 3b41542d6697..7bd92054d353 100644
> > --- a/fs/gfs2/aops.c
> > +++ b/fs/gfs2/aops.c
> > @@ -432,10 +432,10 @@ static int stuffed_readpage(struct gfs2_inode *ip, struct page *page)
> >         if (error)
> >                 return error;
> >
> > -       kaddr = kmap_atomic(page);
> > +       kaddr = kmap_local_page(page);
> >         memcpy(kaddr, dibh->b_data + sizeof(struct gfs2_dinode), dsize);
> >         memset(kaddr + dsize, 0, PAGE_SIZE - dsize);
> > -       kunmap_atomic(kaddr);
> > +       kunmap_local(kaddr);
> >         flush_dcache_page(page);
> >         brelse(dibh);
> >         SetPageUptodate(page);
> > @@ -498,12 +498,12 @@ int gfs2_internal_read(struct gfs2_inode *ip, char *buf, loff_t *pos,
> >                                 continue;
> >                         return PTR_ERR(page);
> >                 }
> > -               p = kmap_atomic(page);
> > +               p = kmap_local_page(page);
> >                 amt = size - copied;
> >                 if (offset + size > PAGE_SIZE)
> >                         amt = PAGE_SIZE - offset;
> >                 memcpy(buf + copied, p + offset, amt);
> > -               kunmap_atomic(p);
> > +               kunmap_local(p);
> >                 put_page(page);
> >                 copied += amt;
> >                 index++;
> > --
> > 2.34.1
> >
> >
> >
> 


