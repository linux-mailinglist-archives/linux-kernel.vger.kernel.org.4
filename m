Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA84F64940C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 12:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbiLKL7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 06:59:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiLKL7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 06:59:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 506D711473;
        Sun, 11 Dec 2022 03:59:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 096BDB80AB3;
        Sun, 11 Dec 2022 11:59:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E813DC433F0;
        Sun, 11 Dec 2022 11:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670759962;
        bh=BzJnh42n6fWjgs4W7n57fEcjIGF+ndH9j7hFI/k3Jsk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pbn4s2K1fvHQlsK0HusUFv5gCz/kRXHc5Dlr01BvUjMqAdQLceM7j4XPaQJyzSiXG
         Pod3kQJPjFb2STAuDLMDKwangCbkS2GwqoDvxst85WM4w8IrXjM3fsVUur5itq5VS6
         XJ03x3LxeqxuwwGGP5v5A1VQyDExVI3Uu2+NDIfdCOetgTG0eiRsai6uAxtdNCTTF2
         Yns0cf1Thvh/nzjN+W/K86wtNYHOIqkBCaikiG/qbFhRr16m9LwEoCeumVK16R2frL
         HLJvKgR8PVi+Dmx2iA+qKgS/JDC7QXcNfJpSxHVfThiKsJBApuntDKewEoNoeOW/gf
         FlEBcxOcvvJBw==
Date:   Sun, 11 Dec 2022 12:12:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     <ye.xingchen@zte.com.cn>, <andriy.shevchenko@linux.intel.com>,
        <lars@metafoo.de>, <u.kleine-koenig@pengutronix.de>,
        <petrm@nvidia.com>, <olteanv@gmail.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: bma180: Convert to use sysfs_emit_at() API
Message-ID: <20221211121216.33006598@jic23-huawei>
In-Reply-To: <20221207095614.z4gv3q76hfx47qs2@CAB-WSD-L081021>
References: <202212071003192805636@zte.com.cn>
        <20221207095614.z4gv3q76hfx47qs2@CAB-WSD-L081021>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Dec 2022 12:56:14 +0300
Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:

> On Wed, Dec 07, 2022 at 10:03:19AM +0800, ye.xingchen@zte.com.cn wrote:
> > From: ye xingchen <ye.xingchen@zte.com.cn>
> > 
> > Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> > should only use sysfs_emit() or sysfs_emit_at() when formatting the
> > value to be returned to user space.
> > 
> > Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>  
> 
> I think it would be better, if you provide one cover letter as 0/3 patch
> and three nested real patches to each iio/accel driver which you want to
> rework: adxl372, bma180, mma8452. Or fix all iio drivers (no only accel)
> and send all of these changes as nested patches for one cover letter.
> 
> Please refer to https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> 
> and use the following commands to generate such patches hierarchy:
> 
> $ git format-patch --cover-letter -o patches ...
> $ git send-email \     
>       --annotate \               
>       --to="john.doe@kernel.org" \               
>       --cc="linux-iio@vger.kernel.org" \
>       --cc="linux-kernel@vger.kernel.org" \
>       --smtp-debug 1 \                  
>       patches/*

Second this comment - also mark it at least v3 as some of these
patches will be on their 3rd version.

One major advantage of such a series is that a reply to the cover letter
can be used to indicate that someone is giving a tag for all the patches
underneath it.  Right now they'd have to reply to every single email.

So please send a v3 with all the similar IIO patches under a single cover
letter.  Make sure to gather tags from earlier versions.

Thanks,

Jonathan

> 
> > ---
> >  drivers/iio/accel/bma180.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index eb697eeb4301..9e3e5dfdded7 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -488,8 +488,7 @@ static ssize_t bma180_show_avail(char *buf, const int *vals, unsigned int n,
> >  	for (i = 0; i < n; i++) {
> >  		if (!vals[i])
> >  			continue;
> > -		len += scnprintf(buf + len, PAGE_SIZE - len,
> > -			micros ? "0.%06d " : "%d ", vals[i]);
> > +		len += sysfs_emit_at(buf, len, micros ? "0.%06d " : "%d ", vals[i]);
> >  	}
> >  	buf[len - 1] = '\n';
> > 
> > -- 
> > 2.25.1  
> 

