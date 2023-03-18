Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882366BFBB1
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 17:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjCRQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCRQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 12:56:07 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A3C32503;
        Sat, 18 Mar 2023 09:56:06 -0700 (PDT)
Date:   Sat, 18 Mar 2023 16:56:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679158564;
        bh=qSw6t5TafsNcSL7zpnL1WRQ/KMi1c9c0NquGbXd2Apw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OJHFcqtBs2KXgGlc4Fc/IDuT5eb+PiEXI2ZIOKkHeMbOoPPlG3FfCdN72LstG828K
         job5PGWaopoaH6D1PSkVrA9Va9358nOhxjefH5vSb1CvKR8z19tocGCzem2/7vC5vx
         3TdIVW1LdPYMT6BlevxbVOLiuxZgohqLjnKGjluc=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2 3/4] blk-integrity: register sysfs attributes on
 struct device
Message-ID: <0e7d7df8-f14e-4925-9c11-d08cb52dd4e6@t-8ch.de>
References: <20230309-kobj_release-gendisk_integrity-v2-0-761a50d71900@weissschuh.net>
 <20230309-kobj_release-gendisk_integrity-v2-3-761a50d71900@weissschuh.net>
 <ZBHfCwnqUtBpqdTW@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBHfCwnqUtBpqdTW@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 08:06:51AM -0700, Christoph Hellwig wrote:
> > +static const struct attribute_group integrity_group  = {
> 
> Double whitespace before the =

Ack.

> > +	.name = "integrity", .attrs = integrity_attrs,
> >  };
> 
> We generally put each field member on separate lines for readability.

Ack.

> >  int blk_integrity_add(struct gendisk *disk)
> >  {
> > +	return device_add_groups(disk_to_dev(disk), integrity_groups);
> >  }
> >  
> >  void blk_integrity_del(struct gendisk *disk)
> >  {
> > +	device_remove_groups(disk_to_dev(disk), integrity_groups);
> 
> Can't we just add integrity_group to disk_attr_groups and remove these
> calls entirely?

Thanks for the pointer. This works and is indeed nicer.
