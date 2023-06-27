Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468747402AE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 19:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjF0RxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 13:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjF0RxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 13:53:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883B272D;
        Tue, 27 Jun 2023 10:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iZsPmwSsRt+5fYBmzh/Az3swQ98Eyg6tmpxiwGCbGUs=; b=LJW+FA55ARmjpn4k/I+ayLFyPU
        E4sU1gzsix5tt+adgK146yRSQ18iIPBt2gqsPRpJyfzOhL9Gmgz5Bu4sOTobd4BYX69kh0+7zH/NQ
        pDO1v7ZBHXqFwGzYlywTnlDuZkrC9T9wuYU5xKdfH9rkpu3WfNHNAnDkfBA9AdCKkhVZ56Gms3dEG
        6oFKOVMVPf93WWrZsfNZEwc3xfITap+cIJroLbB1zQV5Yw2VbuHqz3QQPVr/q31VOL+vtrn34xUwi
        5Xlzl+SnqJyiuGZznamywJkG4wNsQNn+Kzbl8PlSzf7mKczZ/r0xMp+Cl+zJw8G/cDMywQLC5G2P0
        bnnLc3dw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qECsL-002wzs-8b; Tue, 27 Jun 2023 17:53:13 +0000
Date:   Tue, 27 Jun 2023 18:53:13 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Pankaj Raghav <p.raghav@samsung.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>, Min Li <min15.li@samsung.com>,
        axboe@kernel.dk, hch@lst.de, gregkh@linuxfoundation.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] block: add check that partition length needs to be
 aligned with block size
Message-ID: <ZJsiCd232pwyqhmM@casper.infradead.org>
References: <CGME20230627031105epcas5p3010432ebd447ad865c3ddd986b3ffee0@epcas5p3.samsung.com>
 <20230627110918.7608-1-min15.li@samsung.com>
 <8ea3bdfb-f2d9-ee5e-f623-02b2b134490d@kernel.org>
 <20230627081339.fv76swi3srqdfpra@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627081339.fv76swi3srqdfpra@localhost>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:13:39AM +0200, Pankaj Raghav wrote:
> On Tue, Jun 27, 2023 at 01:39:26PM +0900, Damien Le Moal wrote:
> > > diff --git a/block/ioctl.c b/block/ioctl.c
> > > index 3be11941fb2d..c40b382dd58f 100644
> > > --- a/block/ioctl.c
> > > +++ b/block/ioctl.c
> > > @@ -33,14 +33,18 @@ static int blkpg_do_ioctl(struct block_device *bdev,
> > >  	if (op == BLKPG_DEL_PARTITION)
> > >  		return bdev_del_partition(disk, p.pno);
> > >  
> > > +	/* check if partition is aligned to blocksize */
> > > +	if (p.start & (bdev_logical_block_size(bdev) - 1))
> > > +		return -EINVAL;
> > > +	/* check if length is aligned to blocksize */
> > > +	if (p.length & (bdev_logical_block_size(bdev) - 1))
> > > +		return -EINVAL;
> > 
> > 	long long blksz_mask = bdev_logical_block_size(bdev) - 1;
> > 
> > 	/* Check that the partition is aligned to the block size */
> > 	if ((p.start & blksz_mask) || (p.length & blksz_mask))
> > 		return -EINVAL;
> 
> A Minor nit on top of your comment:
> 
>  	unsigned int blksz = bdev_logical_block_size(bdev);
>  
>  	/* Check that the partition is aligned to the block size */
>  	if (!IS_ALIGNED(p.start, blksz) || !IS_ALIGNED(p.length, blksz))
>  		return -EINVAL;

or you can even do ...

	if (!IS_ALIGNED(p.start | p.length), blksz)

Do I win the code golf trophy?
