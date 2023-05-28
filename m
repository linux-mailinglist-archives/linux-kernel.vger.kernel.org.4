Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 751E571393B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjE1Lep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjE1Len (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:34:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571BCE3;
        Sun, 28 May 2023 04:34:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE20160CF6;
        Sun, 28 May 2023 11:34:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 787B4C433D2;
        Sun, 28 May 2023 11:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685273662;
        bh=PghU2Hv+t8Aav202LeRgb+Lazw2/XSs0JbN+JNQ9TYc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFmzVzQJeoPtVNJCFQG/ZE/4BCYxbbd5U5MbQ+lljN6ZZpEdgpvhSQRuz4JatKhKN
         OCkxMO4qHBSwRZq3BWLAPQA5qbBFOuJrz+ELJw703sbr1G9KSrZkWp3pHvImZvmJie
         YCWWaGbbtBy3nPbJt/uBwg8YaMpUb1v1Epz1eFcc=
Date:   Sun, 28 May 2023 12:33:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Prashanth K <quic_prashk@quicinc.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] usb: common: usb-conn-gpio: Set last role to unknown
 before initial detection
Message-ID: <2023052801-immersion-venus-ad0f@gregkh>
References: <1685004825-30157-1-git-send-email-quic_prashk@quicinc.com>
 <2023052513-gestate-tartar-bf15@gregkh>
 <5f144d80-0439-d014-c845-1cfb1adb840a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f144d80-0439-d014-c845-1cfb1adb840a@quicinc.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 10:15:43AM +0530, Prashanth K wrote:
> 
> 
> On 25-05-23 10:04 pm, Greg Kroah-Hartman wrote:
> > On Thu, May 25, 2023 at 02:23:45PM +0530, Prashanth K wrote:
> > > Currently if we bootup a device without cable connected, then
> > > usb-conn-gpio won't call set_role() since last_role is same as
> > > current role. This happens because during probe last_role gets
> > > initialised to zero.
> > > 
> > > To avoid this, added a new constant in enum usb_role, last_role
> > > is set to USB_ROLE_UNKNOWN before performing initial detection.
> > > 
> > > While at it, also handle default case for the usb_role switch
> > > in cdns3 to avoid build warnings.
> > > 
> > > Fixes: 4602f3bff266 ("usb: common: add USB GPIO based connection detection driver")
> > > Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
> > > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > > v5: Update commit text to mention the changes made in cdns3 driver.
> > > v4: Added Reviewed-by tag.
> > > v3: Added a default case in drivers/usb/cdns3/core.c as pointed out by
> > >      the test robot.
> > > v2: Added USB_ROLE_UNKNWON to enum usb_role.
> > > 
> > >   drivers/usb/cdns3/core.c           | 2 ++
> > >   drivers/usb/common/usb-conn-gpio.c | 3 +++
> > >   include/linux/usb/role.h           | 1 +
> > >   3 files changed, 6 insertions(+)
> > > 
> > > diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
> > > index dbcdf3b..69d2921 100644
> > > --- a/drivers/usb/cdns3/core.c
> > > +++ b/drivers/usb/cdns3/core.c
> > > @@ -252,6 +252,8 @@ static enum usb_role cdns_hw_role_state_machine(struct cdns *cdns)
> > >   		if (!vbus)
> > >   			role = USB_ROLE_NONE;
> > >   		break;
> > > +	default:
> > > +		break;
> > 
> > No error if this happens?
> It wouldn't come to default case in as no one sets the role to
> USB_ROLE_UNKNOWN in cdns3 driver. Moreover it would work the same
> without the default case also (we have added it just to address a warning
> pointed out be test-robot).
> > 
> > >   	}
> > >   	dev_dbg(cdns->dev, "role %d -> %d\n", cdns->role, role);
> > > diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
> > > index e20874c..30bdb81 100644
> > > --- a/drivers/usb/common/usb-conn-gpio.c
> > > +++ b/drivers/usb/common/usb-conn-gpio.c
> > > @@ -257,6 +257,9 @@ static int usb_conn_probe(struct platform_device *pdev)
> > >   	platform_set_drvdata(pdev, info);
> > >   	device_set_wakeup_capable(&pdev->dev, true);
> > > +	/* Set last role to unknown before performing the initial detection */
> > > +	info->last_role = USB_ROLE_UNKNOWN;
> > 
> > Shouldn't last_role have already been set to 0?  If so, why not just
> > have this enum value be 0?
> Last role would be 0 during first detection, that's the problem here.
> During initial detection, if the the new role is detected as USB_ROLE_NONE
> (0), then we wouldn't call the set_role(). But it should send the current
> role to gadget after the inital detection.

So you are hoping that the old enum type is still assigned to 0?  That's
brave, please make it explicit otherwise it's very hard to follow or
ensure that this really will happen.  And most of all, document it so
that that value remains 0 in the future, otherwise a list of enum types
without explicit values are seen as if the values do not matter.

thanks,

greg k-h
