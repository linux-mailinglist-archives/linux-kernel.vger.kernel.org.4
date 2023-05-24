Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE3470ED98
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239620AbjEXGHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjEXGHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:07:05 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3083A132;
        Tue, 23 May 2023 23:07:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id BB12668CFE; Wed, 24 May 2023 08:06:59 +0200 (CEST)
Date:   Wed, 24 May 2023 08:06:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mike Snitzer <snitzer@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 19/24] dm: remove dm_get_dev_t
Message-ID: <20230524060659.GB19611@lst.de>
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-20-hch@lst.de> <ZGzujNVLaQD2npwH@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZGzujNVLaQD2npwH@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 12:49:16PM -0400, Mike Snitzer wrote:
> > -		dev = dm_get_dev_t(path);
> > -		if (!dev)
> > +		r = lookup_bdev(path, &dev);
> > +		if (r)
> > +			r = early_lookup_bdev(path, &dev);
> > +		if (r)
> >  			return -ENODEV;
> >  	}
> >  	if (dev == disk_devt(t->md->disk))
> 
> OK, but you aren't actually propagating the exact error code.  Did
> you intend to change the return from -ENODEV to r?

Yes, thanks.
