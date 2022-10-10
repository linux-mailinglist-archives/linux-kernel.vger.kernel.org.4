Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3D45F9844
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbiJJGVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJJGVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:21:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45DD24BD05
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:21:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D185860E00
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:21:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E02C433C1;
        Mon, 10 Oct 2022 06:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665382868;
        bh=0V6gSXjp/sWlxKzKLIEPESr+SZWzxGexcSKsBK0amRk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yLOilthaslZpyup0QLTvfvjf6fD4VoVZkTM1kjkFPjNXjtioP99F+sXoCk7ZiiBrR
         mSdASGa2xzYAtC9S8lT/SFRjRHRkkifEkCjx2zq5ME7avnZD5MQNH+pDz3XsLJDqVG
         E/i81lgBoetDMmV2q7u/BaufGy4DwgDzotvEfJ5Q=
Date:   Mon, 10 Oct 2022 08:21:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        'Wende Tan' <twd2.me@gmail.com>
Subject: Re: PING: [PATCH] platform: use fwnode_irq_get_byname instead of
 of_irq_get_byname to get irq
Message-ID: <Y0O5//6A3VvT7S5Z@kroah.com>
References: <0E39B15006ADC205+02a601d8d4f8$a00a09e0$e01e1da0$@lohu.info>
 <F789F6E98A6F9BF5+1d8501d8dc56$74036f70$5c0a4e50$@lohu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F789F6E98A6F9BF5+1d8501d8dc56$74036f70$5c0a4e50$@lohu.info>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:14:46AM +0800, Soha Jin wrote:
> > -----Original Message-----
> > From: soha@lohu.info <soha@lohu.info>
> > Sent: Saturday, October 1, 2022 2:15 AM
> > To: gregkh@linuxfoundation.org
> > Cc: rafael@kernel.org; linux-kernel@vger.kernel.org; 'Wende Tan'
> > <twd2.me@gmail.com>
> > Subject: [PATCH] platform: use fwnode_irq_get_byname instead of
> > of_irq_get_byname to get irq
> > 
> > >From 02df97f4d814b9893eef2c2118b85d2b4b9d61ae Mon Sep 17
> > 00:00:00 2001
> > From: Soha Jin <soha@lohu.info>
> > Date: Sat, 1 Oct 2022 00:26:04 +0800
> > Subject: [PATCH] platform: use fwnode_irq_get_byname instead of
> > of_irq_get_byname to get irq
> > 
> > Not only platform devices described by OF have named interrupts, but
> > devices described by ACPI also have named interrupts. The fwnode is an
> > abstraction to different standards, and using fwnode_irq_get_byname can
> > support more devices.
> > 
> > Signed-off-by: Soha Jin <soha@lohu.info>
> > Tested-by: Wende Tan <twd2.me@gmail.com>
> > ---
> >  drivers/base/platform.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c index
> > 51bb22898..968f3d71e 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -441,8 +441,8 @@ static int __platform_get_irq_byname(struct
> > platform_device *dev,
> >  	struct resource *r;
> >  	int ret;
> > 
> > -	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> > -		ret = of_irq_get_byname(dev->dev.of_node, name);
> > +	if (!dev->dev.of_node || IS_ENABLED(CONFIG_OF_IRQ)) {
> > +		ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
> >  		if (ret > 0 || ret == -EPROBE_DEFER)
> >  			return ret;
> >  	}
> > --
> > 2.30.2
> > 
> > 
> 
> Any updates on this 10-day-ago patch?

It's the middle of the merge window, we can't do anything until after
6.1-rc1 is out, please relax and wait for that.

And what is the rush here, what is broken without this change?

thanks,

greg k-h
