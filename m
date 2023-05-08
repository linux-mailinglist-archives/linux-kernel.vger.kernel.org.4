Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 396696FA2AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjEHI5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 04:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjEHI5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:57:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20602171A;
        Mon,  8 May 2023 01:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABB5461BF3;
        Mon,  8 May 2023 08:57:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E934C433D2;
        Mon,  8 May 2023 08:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683536228;
        bh=Meh1xApQc6QmTSta1gO0+RVCqEAE22ANCjwMLkHa9uw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=q6RKEAml9+DeDNWX19AHwf4Mft837x6caaqvjSRx1PxYR8qxLnyGAMNNZlffItVMt
         P+9EAX4Y1a42nN6458dqcKgtgcamfp05H5XKjNup5NzTLElDHsTyyFhIISuuKyO5sD
         8iFJ22+PK02zWmFTxowxLoQ20TUGcqWx2YJIORjk2im8sVw5KhDSPUAM1UFiiSh52O
         A82jitYfZoByAKxjDk6cwd1fvgFFPRDbb04/5oruplz3txQCF9oY/vvUuf5eaPnTM2
         71W9Kh2ud4j3kvzVgi+Eg5i1D2HCKVqVBVF6SZfbONYCkPJOIemBcSXXa9xpdMMn8a
         dIwRn7XOXXmKQ==
Date:   Mon, 8 May 2023 14:27:03 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Haotien Hsu <haotienh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Wayne Chang <waynec@nvidia.com>,
        EJ Hsu <ejh@nvidia.com>
Subject: Re: [PATCH] phy: tegra: xusb: Fix use-after-free issue
Message-ID: <ZFi5XzPjez3lrY49@matsya>
References: <20230504055446.2039372-1-haotienh@nvidia.com>
 <ZFN3lvjjn9Xu-vRl@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFN3lvjjn9Xu-vRl@orome>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-23, 11:15, Thierry Reding wrote:
> On Thu, May 04, 2023 at 01:54:46PM +0800, Haotien Hsu wrote:
> > From: EJ Hsu <ejh@nvidia.com>
> > 
> > For the dual-role port, it will assign the phy dev to usb-phy dev and
> > use the port dev driver as the dev driver of usb-phy.
> > 
> > When we try to destroy the port dev, it will destroy its dev driver
> > as well. But we did not remove the reference from usb-phy dev. This
> > might cause the use-after-free issue in KASAN.
> > 
> > Fixes: e8f7d2f409a1 ("phy: tegra: xusb: Add usb-phy support")
> > Cc: stable@vger.kernel.org
> > 
> > Signed-off-by: EJ Hsu <ejh@nvidia.com>
> > Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> > ---
> >  drivers/phy/tegra/xusb.c | 15 ++++++++-------
> >  1 file changed, 8 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/phy/tegra/xusb.c b/drivers/phy/tegra/xusb.c
> > index 78045bd6c214..515298a9a433 100644
> > --- a/drivers/phy/tegra/xusb.c
> > +++ b/drivers/phy/tegra/xusb.c
> > @@ -563,13 +563,6 @@ static int tegra_xusb_port_init(struct tegra_xusb_port *port,
> >  
> >  static void tegra_xusb_port_unregister(struct tegra_xusb_port *port)
> >  {
> > -	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
> > -		of_platform_depopulate(&port->dev);
> > -		usb_role_switch_unregister(port->usb_role_sw);
> > -		cancel_work_sync(&port->usb_phy_work);
> > -		usb_remove_phy(&port->usb_phy);
> > -	}
> > -
> >  	if (port->ops->remove)
> >  		port->ops->remove(port);
> >  
> > @@ -832,6 +825,14 @@ void tegra_xusb_usb2_port_remove(struct tegra_xusb_port *port)
> >  {
> >  	struct tegra_xusb_usb2_port *usb2 = to_usb2_port(port);
> >  
> > +	if (!IS_ERR_OR_NULL(port->usb_role_sw)) {
> > +		of_platform_depopulate(&port->dev);
> > +		usb_role_switch_unregister(port->usb_role_sw);
> > +		cancel_work_sync(&port->usb_phy_work);
> > +		usb_remove_phy(&port->usb_phy);
> > +		port->usb_phy.dev->driver = NULL;
> > +	}
> > +
> 
> It's a bit difficult to tell what exactly changed because of the
> additional move. The move looks correct because this is only valid for
> USB2 ports, but I think it'd be easier to review if the move was done
> prior to the addition of the ->driver clearing. Or perhaps a mention in
> the commit message would be nice.
> 
> It's obviously up to Vinod and Kishon if they want to see this
> clarified. Either way is fine with me, so:

I agree changes need to be clarified, expecting updated v2 :-)

> 
> Acked-by: Thierry Reding <treding@nvidia.com>



-- 
~Vinod
