Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8647C674C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbjATFdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjATFdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:33:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B685D2278A;
        Thu, 19 Jan 2023 21:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4837B822A1;
        Thu, 19 Jan 2023 13:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBA0C433EF;
        Thu, 19 Jan 2023 13:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674133350;
        bh=+LYj8eIhDj+IxLNQjMky1L7O35org24tnkbbNfS3QG0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTJKHHwCSMZDGPNqfuuJAy23LmAfwupt6qkywU1qOc//veMaKDKC9cs/tQhPEmeIs
         csqRGnr3zG3dy3M50j2LbpOMqDm3avAnckJUFnLMitC7t3HTLfv/4iIUHBiLVdGpnI
         LjxHQtdQBj30HRH+Muk17S05w8Jxjue0e6qACQOU=
Date:   Thu, 19 Jan 2023 14:02:27 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>
Cc:     Thinh.Nguyen@synopsys.com, balbi@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Message-ID: <Y8k/Y4O/99pnKI2h@kroah.com>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 01:55:03PM -0800, Elson Roy Serrao wrote:
> Add a flag to indicate whether the gadget is capable
> of sending remote wakeup to the host.
> 
> Signed-off-by: Elson Roy Serrao <quic_eserrao@quicinc.com>
> ---
>  drivers/usb/gadget/composite.c | 3 +++
>  include/linux/usb/gadget.h     | 2 ++
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 403563c..b83963a 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -965,6 +965,9 @@ static int set_config(struct usb_composite_dev *cdev,
>  	else
>  		usb_gadget_clear_selfpowered(gadget);
>  
> +	if (USB_CONFIG_ATT_WAKEUP & c->bmAttributes)
> +		gadget->rw_capable = 1;
> +
>  	usb_gadget_vbus_draw(gadget, power);
>  	if (result >= 0 && cdev->delayed_status)
>  		result = USB_GADGET_DELAYED_STATUS;
> diff --git a/include/linux/usb/gadget.h b/include/linux/usb/gadget.h
> index dc3092c..15785f8 100644
> --- a/include/linux/usb/gadget.h
> +++ b/include/linux/usb/gadget.h
> @@ -385,6 +385,7 @@ struct usb_gadget_ops {
>   *	indicates that it supports LPM as per the LPM ECN & errata.
>   * @irq: the interrupt number for device controller.
>   * @id_number: a unique ID number for ensuring that gadget names are distinct
> + * @rw_capable: True if the gadget is capable of sending remote wakeup.
>   *
>   * Gadgets have a mostly-portable "gadget driver" implementing device
>   * functions, handling all usb configurations and interfaces.  Gadget
> @@ -446,6 +447,7 @@ struct usb_gadget {
>  	unsigned			lpm_capable:1;
>  	int				irq;
>  	int				id_number;
> +	unsigned			rw_capable:1;

Why not put this by the other bitfields in this structure?

thanks,

greg k-h
