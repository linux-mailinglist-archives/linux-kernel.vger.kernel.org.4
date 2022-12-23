Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4965510C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 14:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbiLWNl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 08:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiLWNlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 08:41:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F1186F9;
        Fri, 23 Dec 2022 05:41:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D313CB82033;
        Fri, 23 Dec 2022 13:41:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6A3C433D2;
        Fri, 23 Dec 2022 13:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671802911;
        bh=iy9TCYFDK/6ge2wxUO12WDZJ23hlv+fXg+Yxp1If4xw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I8eiHvbbBm5AyKg3zm0Y/3zLb/1xtgnIxiv8omT3hfi8DcB1Se8NYNXQibX8yhntK
         SZVQ9UOYPa4NXE5BGPXpTQjosmRTXitCjxlITgBAlbuxKQtuS4/iGpdvTASQCypNht
         +wGVD/OtzDpQJqP9xvHJn/gGHdW+8C1fpoJu0SRCrV07g47ze5+DtW0bWnC844K2xM
         eqIdZU//S9pYqW7P3L+W7pMfgOfcFWHHCcu4cvQUoQq4a/djyMCRC+8bpz15UWiv/V
         +iTx9X/TdnlU2luT72ox8AqMBCxkETWT96uPriXrR4zIAzNHFG7T3XvD7jQQ13bHNG
         kRj3aKktHAJ1A==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p8iJs-0008Q9-1R; Fri, 23 Dec 2022 14:42:40 +0100
Date:   Fri, 23 Dec 2022 14:42:40 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Subject: Re: [PATCH] usb: misc: onboard_usb_hub: Don't defer probing for
 'incomplete' DT nodes
Message-ID: <Y6WwUCtexEnF1PWY@hovoldconsulting.com>
References: <20221220004427.1.If5e7ec83b1782e4dffa6ea759416a27326c8231d@changeid>
 <Y6FqiA/SoZHr36jl@hovoldconsulting.com>
 <Y6HDXiRzaAZ+3uTp@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6HDXiRzaAZ+3uTp@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 02:15:19PM +0000, Matthias Kaehlcke wrote:
> Hi Johan,
> 
> On Tue, Dec 20, 2022 at 08:55:52AM +0100, Johan Hovold wrote:
> > On Tue, Dec 20, 2022 at 12:45:01AM +0000, Matthias Kaehlcke wrote:
> > > Some boards have device tree nodes for USB hubs supported by the
> > > onboard_usb_hub driver, but the nodes don't have all properties
> > > needed for the driver to work properly (which is not necessarily
> > > an error in the DT). Currently _find_onboard_hub() returns
> > > -EPROBE_DEFER in such cases, which results in an unusable USB hub,
> > > since successive probes fail in the same way. Use the absence of
> > > the "vdd" supply as an indicator of such 'incomplete' DT nodes
> > > and return -ENODEV.
> > > 
> > > Fixes: 8bc063641ceb ("usb: misc: Add onboard_usb_hub driver")
> > > Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
> > > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > > ---
> > > 
> > >  drivers/usb/misc/onboard_usb_hub.c | 9 +++++++++
> > >  1 file changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/usb/misc/onboard_usb_hub.c b/drivers/usb/misc/onboard_usb_hub.c
> > > index d63c63942af1..2968da515016 100644
> > > --- a/drivers/usb/misc/onboard_usb_hub.c
> > > +++ b/drivers/usb/misc/onboard_usb_hub.c
> > > @@ -363,6 +363,15 @@ static struct onboard_hub *_find_onboard_hub(struct device *dev)
> > >  	hub = dev_get_drvdata(&pdev->dev);
> > >  	put_device(&pdev->dev);
> > >  
> > > +	/*
> > > +	 * Some boards have device tree nodes for USB hubs supported by this
> > > +	 * driver, but the nodes don't have all properties needed for the driver
> > > +	 * to work properly. Use the absence of the "vdd" supply as an indicator
> > > +	 * of such nodes.
> > > +	 */
> > > +	if (!of_get_property(pdev->dev.of_node, "vdd", NULL))
> > > +		return ERR_PTR(-ENODEV);
> > 
> > Does this not break your original use case? Don't you want "vdd-supply"
> > here?
> 
> Ouch, yes it does (to a certain degree). Thanks for pointing it out. My
> sanity check didn't catch this because the platform driver still probes
> successfully and powers the hub on.
> 
> > That said, this seems like the wrong property to look for both in
> > principle and as it is described as optional by the binding:
> > 
> > 	Documentation/devicetree/bindings/usb/realtek,rts5411.yaml
> > 
> > It seems that you should use the compatible property and check that it
> > holds one of the expected values:
> > 
> >  - usbbda,5411
> >  - usbbda,411
> > 
> > rather than treat every hub node as describing a realtek hub (AFAIK,
> > there is no generic binding for this yet).
> 
> The driver only probes for specific hub models, among them the Microchip
> USB2514B hub with which Stefan encountered the regression [1].
> 
> My initial assumption when writing this driver was that the existence of
> a node for a supported hub means that the driver should be used. However
> the regression encountered by Stefan makes clear that this assumption is
> incorrect. It's not common, but a device tree may have nodes for onboard
> USB devices, among them hubs (which might become more common with this
> driver). Not in all instances the hub nodes were added with the intention
> of using this driver for power sequencing the hub (e.g. [2]). 

Yeah, you can't assume that. The DT bindings for USB has been around
since before your onboard-hub driver.

> The
> compatible string alone doesn't indicate that the onboard_hub driver
> should be instantiated for a given hub, which is why I'm using the
> existence of "vdd-supply" as indicator.

I don't have time to review this in details, but checking for a specific
supply like this just seems wrong (as other have since also pointed out
in comments to your v2). There could be hubs which just need to deassert
a reset pin for example, and some of the bindings do not even mandate a
regulator as I mentioned above.

Johan
