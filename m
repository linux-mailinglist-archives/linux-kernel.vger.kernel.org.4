Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518616255BE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:52:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiKKIwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:52:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232577AbiKKIwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:52:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70737742C1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:52:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CC27861EED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 08:52:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B2BC433D6;
        Fri, 11 Nov 2022 08:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668156735;
        bh=fXKuRB663cmxgQcjTNGenw4vOoT0/yPa+UqIg7NWx9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XziARmjqY16i8b1xeJZrqjCAng9ByNMQSF7UcsCMzvhvXJothGBF/YoHONaoB1xxg
         DNTijvthSSD/CWG7Yuxqwqixy56lzHBHwUhez3ov+X0bC0VwTSKkHLOJuu1kZpmp/K
         DVA5kHyvw0x/jx9KlttSxXpLYh41dvXZPYPkg0RY=
Date:   Fri, 11 Nov 2022 09:52:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Soha Jin <soha@lohu.info>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Wende Tan <twd2.me@gmail.com>
Subject: Re: [PATCH v2] platform: use fwnode_irq_get_byname instead of
 of_irq_get_byname to get irq
Message-ID: <Y24NPPF+6CM6b/d2@kroah.com>
References: <20221028164120.2798-1-soha@lohu.info>
 <DS0PR05MB95440932459F31AA76618A75DA009@DS0PR05MB9544.namprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS0PR05MB95440932459F31AA76618A75DA009@DS0PR05MB9544.namprd05.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 08:30:46AM +0000, Soha Jin wrote:
> > -----Original Message-----
> > From: Soha Jin <soha@lohu.info>
> > Sent: Saturday, October 29, 2022 12:41 AM
> > 
> > Not only platform devices described by OF have named interrupts, but
> > devices described by ACPI also have named interrupts. The fwnode is an
> > abstraction to different standards, and using fwnode_irq_get_byname can
> > support more devices.
> > 
> > Moreover, when CONFIG_OF_IRQ is not enabled, there will be a stub method
> > always returning 0, the if statement can be removed safely.
> > 
> > Signed-off-by: Soha Jin <soha@lohu.info>
> > Tested-by: Wende Tan <twd2.me@gmail.com>
> > ---
> >  drivers/base/platform.c | 8 +++-----
> >  1 file changed, 3 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/base/platform.c b/drivers/base/platform.c index
> > 51bb2289865c..6cd7fd478c5f 100644
> > --- a/drivers/base/platform.c
> > +++ b/drivers/base/platform.c
> > @@ -441,11 +441,9 @@ static int __platform_get_irq_byname(struct
> > platform_device *dev,
> >  	struct resource *r;
> >  	int ret;
> > 
> > -	if (IS_ENABLED(CONFIG_OF_IRQ) && dev->dev.of_node) {
> > -		ret = of_irq_get_byname(dev->dev.of_node, name);
> > -		if (ret > 0 || ret == -EPROBE_DEFER)
> > -			return ret;
> > -	}
> > +	ret = fwnode_irq_get_byname(dev_fwnode(&dev->dev), name);
> > +	if (ret > 0 || ret == -EPROBE_DEFER)
> > +		return ret;
> > 
> >  	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
> >  	if (r) {
> > --
> > 2.30.2
> > 
> 
> Hello Greg,
> 
> I noticed the original patch is merged into -next branch, but as I said in
> the mail yesterday (maybe you did not see it), I already composed a v2
> patch 2 weeks ago. Except the formatting fix, this patch also removed a
> useless if-branch.
> 
> Are there any chance to correct this mistake?

Please submit a fixup patch, sorry, I can't rebase that branch now.

greg k-h
