Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD36735E7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjASKnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:43:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjASKnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:43:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4808648A1C;
        Thu, 19 Jan 2023 02:43:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D56616150D;
        Thu, 19 Jan 2023 10:43:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD982C433EF;
        Thu, 19 Jan 2023 10:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674124995;
        bh=hVXk4PQzJXHjiSdopH+2OghTjDGf7VvJQOEU6Fba2io=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lAdb16x80YCdsLvSQpqbzEjsvHo1EHVEk8XYui+S10AR1tlkr0k8ZeIsY+iUmslvb
         5ON9fGO4AEHgrLk8VLEADRBwTGfl6kF0L8gOQp2h1lLpwfFuKT8Bn+PcUo1A21ou1x
         BBv+yjl1ql05XVFvwq5oqewROtwRK9UF0Lc4I0E4=
Date:   Thu, 19 Jan 2023 11:43:12 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Subject: Re: [PATCH V2 1/2] usb: gadget: u_ether: Improve print in
 gether_setup_name_default()
Message-ID: <Y8kewDt2WbsfciMX@kroah.com>
References: <20230116155545.101391-1-jonathanh@nvidia.com>
 <Y8a45WrjLUdCEHH+@kroah.com>
 <344ab84a-ab31-33cb-0222-9b75fbd981b2@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <344ab84a-ab31-33cb-0222-9b75fbd981b2@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:14:59AM +0000, Jon Hunter wrote:
> 
> On 17/01/2023 15:04, Greg Kroah-Hartman wrote:
> > On Mon, Jan 16, 2023 at 03:55:44PM +0000, Jon Hunter wrote:
> > > The print in in gether_setup_name_default() does not provide any useful
> > > information because a random MAC address will always be generated when
> > > calling this function. Rather than removing the print, update the print
> > > to show MAC address that is generated which is similar to other ethernet
> > > drivers.
> > > 
> > > Finally, given that the strings 'self' and 'host' are static we do not
> > > need to pass these strings as an arguments.
> > > 
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > > V1 -> V2: Added this patch
> > > 
> > >   drivers/usb/gadget/function/u_ether.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> > > index 8f12f3f8f6ee..be8e7b448933 100644
> > > --- a/drivers/usb/gadget/function/u_ether.c
> > > +++ b/drivers/usb/gadget/function/u_ether.c
> > > @@ -845,13 +845,13 @@ struct net_device *gether_setup_name_default(const char *netname)
> > >   	snprintf(net->name, sizeof(net->name), "%s%%d", netname);
> > >   	eth_random_addr(dev->dev_mac);
> > > -	pr_warn("using random %s ethernet address\n", "self");
> > > +	pr_warn("using random self ethernet address %pM\n", dev->dev_mac);
> > 
> > If you are going to fix these up, please use dev_warn() and friends,
> > don't use "raw" pr_* calls in a driver.
> 
> 
> I had a look at that, but I don't think we can in this case. The 'dev'
> structure you see above is of type 'struct eth_dev' and not 'struct device'.

Then use the networking macro for this.  And underneath it all is a real
struct device anyway, so it should be possible.

> In other places in the driver where dev_warn is used the device structure
> comes from the 'struct usb_gadget' but FWICT this is not initialised in the
> above function.

There's a structure somewhere in here, NEVER use raw pr_* calls in a
driver, especially for a message like this.  It needs to point to the
correct device that is making the message, otherwise it's impossible to
know what is going on (and is why we created those macros decades
ago...)

thanks,

greg k-h
