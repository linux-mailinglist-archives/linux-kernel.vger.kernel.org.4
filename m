Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59827647394
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 16:53:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiLHPxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 10:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLHPxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 10:53:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7572A4E6B7;
        Thu,  8 Dec 2022 07:53:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 100D061F90;
        Thu,  8 Dec 2022 15:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC74C433C1;
        Thu,  8 Dec 2022 15:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670514796;
        bh=5YewCq0R8sHcelmq+wc5N2jUev3qPGCtH8YJWDhnGL0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nJ8o2nZMwFp0Hcfh0aoKihq8/YCm6OKOICKIu7oISU/ftkXPkMC+pR4X1f/9zmWIM
         Fxwm0LqSShV5LnE+y/KJ0epGGnwZZ2BqHbLVHu+fVT+7cOjpN7SGu2Wv+7XEgWrtFh
         0DJlBfIhbgHga2yxou6XyDuIb8d1AVDRnHiJcDN8=
Date:   Thu, 8 Dec 2022 16:53:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     Minas Harutyunyan <hminas@synopsys.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        William Wu <william.wu@rock-chips.com>,
        Bin Yang <yangbin@rock-chips.com>,
        Frank Wang <frank.wang@rock-chips.com>
Subject: Re: [PATCH 3/3] usb: dwc2: prevent core phy initialisation
Message-ID: <Y5IIaeip81DIvEZ6@kroah.com>
References: <20221206-dwc2-gadget-dual-role-v1-0-36515e1092cd@theobroma-systems.com>
 <20221206-dwc2-gadget-dual-role-v1-3-36515e1092cd@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221206-dwc2-gadget-dual-role-v1-3-36515e1092cd@theobroma-systems.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2022 at 02:19:18PM +0100, Quentin Schulz wrote:
> From: Bin Yang <yangbin@rock-chips.com>
> 
> The usb phys need to be controlled dynamically on some Rockchip SoCs.
> So set the new HCD flag which prevents USB core from trying to manage
> our phys.
> 
> Signed-off-by: Bin Yang <yangbin@rock-chips.com>
> Signed-off-by: Frank Wang <frank.wang@rock-chips.com>
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  drivers/usb/dwc2/hcd.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
> index 657f1f659ffaf..757a66fa32fa8 100644
> --- a/drivers/usb/dwc2/hcd.c
> +++ b/drivers/usb/dwc2/hcd.c
> @@ -5315,6 +5315,13 @@ int dwc2_hcd_init(struct dwc2_hsotg *hsotg)
>  	if (!IS_ERR_OR_NULL(hsotg->uphy))
>  		otg_set_host(hsotg->uphy->otg, &hcd->self);
>  
> +	/*
> +	 * do not manage the PHY state in the HCD core, instead let the driver
> +	 * handle this (for example if the PHY can only be turned on after a
> +	 * specific event)
> +	 */
> +	hcd->skip_phy_initialization = 1;

Wait, doesn't this mess with the phy logic for all other chips that use
this IP block?  Have you tested this on other systems?

I'd like some verification first before taking this change as it seems
very specific-platform.

thanks,

greg k-h
