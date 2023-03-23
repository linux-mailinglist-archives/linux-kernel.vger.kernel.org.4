Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A656C701A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 19:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCWSSj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 14:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCWSSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 14:18:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A361B9;
        Thu, 23 Mar 2023 11:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D3EEBCE107E;
        Thu, 23 Mar 2023 18:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2C9C433EF;
        Thu, 23 Mar 2023 18:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679595509;
        bh=WhCzWcaPK24XWwTeClnh/FUWbcEJpxxfRM1j8nVub2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sv2L3vCTyRW2t4CIYDR0LBuRXJmziYj9Fw7uVXqLZas2tFLQQPmlESoDQWHfeqWgu
         O5KJn6VVPWx817PiMv+cxb8hPd0a79EEWQow6iDPVxy8MKUexMNe63h+978bRkB75q
         JT4xe50YsXpQSKVyp8M0z1ReOIYb1yPG+aSa6cl0=
Date:   Thu, 23 Mar 2023 19:18:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu,
        vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] usb: dwc3-am62: Fix up wake-up configuration and
 spurious wake up
Message-ID: <ZByX8sliiPnrqXqN@kroah.com>
References: <20230316131226.89540-1-rogerq@kernel.org>
 <20230316131226.89540-4-rogerq@kernel.org>
 <64adaa25-9179-3805-8d71-38418dc1bd54@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64adaa25-9179-3805-8d71-38418dc1bd54@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:24:17AM +0200, Roger Quadros wrote:
> Hi,
> 
> On 16/03/2023 15:12, Roger Quadros wrote:
> > Explicitly set and clear wakeup config so we don't leave anything
> > to chance.
> > 
> > Clear wakeup status on suspend so we know what caused wake up.
> > 
> > The LINESTATE wake up should not be enabled in device mode
> > if we are not connected to a USB host else it will cause spurious
> > wake up.
> > 
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  drivers/usb/dwc3/dwc3-am62.c | 32 ++++++++++++++++++++++----------
> >  1 file changed, 22 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-am62.c b/drivers/usb/dwc3/dwc3-am62.c
> > index 859b48279658..af0524e2f1e1 100644
> > --- a/drivers/usb/dwc3/dwc3-am62.c
> > +++ b/drivers/usb/dwc3/dwc3-am62.c
> > @@ -60,6 +60,13 @@
> >  #define USBSS_WAKEUP_CFG_SESSVALID_EN	BIT(1)
> >  #define USBSS_WAKEUP_CFG_VBUSVALID_EN	BIT(0)
> >  
> > +#define USBSS_WAKEUP_CFG_ALL	(USBSS_WAKEUP_CFG_VBUSVALID_EN | \
> > +				 USBSS_WAKEUP_CFG_SESSVALID_EN | \
> > +				 USBSS_WAKEUP_CFG_LINESTATE_EN | \
> > +				 USBSS_WAKEUP_CFG_OVERCURRENT_EN)
> > +
> > +#define USBSS_WAKEUP_CFG_NONE	0
> > +
> >  /* WAKEUP STAT register bits */
> >  #define USBSS_WAKEUP_STAT_OVERCURRENT	BIT(4)
> >  #define USBSS_WAKEUP_STAT_LINESTATE	BIT(3)
> > @@ -103,6 +110,7 @@ struct dwc3_data {
> >  	struct regmap *syscon;
> >  	unsigned int offset;
> >  	unsigned int vbus_divider;
> > +	u32 wakeup_stat;
> >  };
> >  
> >  static const int dwc3_ti_rate_table[] = {	/* in KHZ */
> > @@ -294,6 +302,7 @@ static int dwc3_ti_suspend_common(struct device *dev)
> >  {
> >  	struct dwc3_data *data = dev_get_drvdata(dev);
> >  	u32 reg, current_prtcap_dir;
> > +	u32 vbus_stat;
> >  
> >  	if (device_may_wakeup(dev)) {
> >  		reg = dwc3_ti_readl(data, USBSS_CORE_STAT);
> > @@ -302,12 +311,20 @@ static int dwc3_ti_suspend_common(struct device *dev)
> >  		/* Set wakeup config enable bits */
> >  		reg = dwc3_ti_readl(data, USBSS_WAKEUP_CONFIG);
> >  		if (current_prtcap_dir == DWC3_GCTL_PRTCAP_HOST) {
> > -			reg |= USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
> > +			reg = USBSS_WAKEUP_CFG_LINESTATE_EN | USBSS_WAKEUP_CFG_OVERCURRENT_EN;
> >  		} else {
> > -			reg |= USBSS_WAKEUP_CFG_OVERCURRENT_EN | USBSS_WAKEUP_CFG_LINESTATE_EN |
> > -			       USBSS_WAKEUP_CFG_VBUSVALID_EN;
> > +			reg = USBSS_WAKEUP_CFG_VBUSVALID_EN | USBSS_WAKEUP_CFG_SESSVALID_EN;
> > +			/*
> > +			 * Enable LINESTATE wake up only if connected to bus else
> > +			 * it causes spurious wake-up.
> > +			 */
> > +			vbus_stat = dwc3_ti_readl(data, USBSS_VBUS_STAT);
> > +			if (vbus_stat & (USBSS_VBUS_STAT_SESSVALID | USBSS_VBUS_STAT_VBUSVALID))
> > +				reg |= USBSS_WAKEUP_CFG_LINESTATE_EN;
> 
> There is one corner case where a spurious wake-up still happens.
> i.e. If we are not in USB_SUSPEND state while entering SoC sleep.
> 
> So looks like we need to check if we are in USB SUSPEND before enabling
> LINESTATE wakeup enable.

Ok, I'll not apply this one, only the first 2 now.

thanks,

greg k-h
