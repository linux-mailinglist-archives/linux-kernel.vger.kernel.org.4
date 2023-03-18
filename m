Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A66BFBAE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjCRQyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCRQyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:54:31 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831C32508;
        Sat, 18 Mar 2023 09:54:30 -0700 (PDT)
Date:   Sat, 18 Mar 2023 16:54:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679158468;
        bh=AqJcrdJC5gEX3q4CJrxx1vAdswTTanoGDAbiA2uJP7o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oaW7+TC1Uv9UQ70oJQMd7xnaWeZ2SO6fQrkxCRN3CoadTLUQvfjuOVyiZEn0bNgyl
         Apvo/TW7v8DxLxJB37uYf7R0SVVGJSfMEPh3NFF2TCTH3/fzIhj6CtcTVxrrc9X0PP
         Bwt46NULoejIuNtS1W/INN3cUF/yRJ/VOP8H6UpY=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 2/4] blk-integrity: convert to struct device_attribute
Message-ID: <7dbc76cf-132f-4381-92d8-980c49f13ae3@t-8ch.de>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v2-2-761a50d71900@weissschuh.net>
 <ZBHeJOlwKD4v41kC@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBHeJOlwKD4v41kC@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 08:03:00AM -0700, Christoph Hellwig wrote:
> > +		container_of(attr, struct device_attribute, attr);
> >  	ssize_t ret = 0;
> >  
> > +	if (dev_attr->store)
> > +		ret = dev_attr->store(dev, dev_attr, page, count);
> >  
> >  	return ret;
> 
> This can be simplified to:
> 
> 	if (!rev_attr->store)
> 		return 0;
> 	return dev_attr->store(dev, dev_attr, page, count);
> 
> (I'm still confused why 0 is the right return value here, but that's not
>  new in your patch, so better don't rock that boat).

This indeed looks weird.

Please note that this case will become -EIO in the next patch switching
over to the standard dev_sysfs_ops.

It shouldn't matter though as all writable attributes all have the
store() handler defined.

> > +static ssize_t format_show(struct device *dev, struct device_attribute *attr, char *page)
> 
> Please avoid the overly long line here. an in the other methods.

This was following the "new" 100-characters per line limit.
The new revision will follow the limit with 80.
