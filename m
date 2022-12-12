Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ADF64A434
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiLLPdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiLLPdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:33:16 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 630A3DF61
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:33:14 -0800 (PST)
Received: (qmail 855217 invoked by uid 1000); 12 Dec 2022 10:33:13 -0500
Date:   Mon, 12 Dec 2022 10:33:13 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: fix misleading usb_set_intfdata() kernel doc
Message-ID: <Y5dJufR1NCzUMvEv@rowland.harvard.edu>
References: <20221212152035.31806-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212152035.31806-1-johan@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 04:20:35PM +0100, Johan Hovold wrote:
> The struct device driver-data pointer is used for any data that a driver
> may need in various callbacks while bound to the device. For
> convenience, subsystems typically provide wrappers such as
> usb_set_intfdata() of the generic accessor functions for use in bus
> callbacks.
> 
> There is generally no longer any need for a driver to clear the pointer,
> but since commit 0998d0631001 ("device-core: Ensure drvdata = NULL when
> no driver is bound") the driver-data pointer is set to NULL by driver
> core post unbind anyway.
> 
> For historical reasons, USB core also clears this pointer when an
> explicitly claimed interface is released.
> 
> Due to a misunderstanding, a misleading kernel doc comment for
> usb_set_intfdata() was recently added which claimed that the driver data
> pointer must not be cleared during disconnect before "all actions [are]
> completed", which is both imprecise and incorrect.
> 
> Specifically, drivers like cdc-acm which claim additional interfaces use
> the driver-data pointer as a flag which is cleared when the first
> interface is unbound. As long as a driver does not do something odd like
> dereference the pointer in, for example, completion callbacks, this can
> be done at any time during disconnect. And in any case this is no
> different than for any other resource, like the driver data itself,
> which may be freed by the disconnect callback.
> 
> Note that the comment actually also claimed that the interface itself
> was somehow being set to NULL by driver core.
> 
> Fix the kernel doc by removing incorrect, overly specific and misleading
> details and adding a comment about why some drivers do clear the
> driver-data pointer.
> 
> Fixes: 27ef17849779 ("usb: add usb_set_intfdata() documentation")
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
> 
> Changes in v2
>  - fix up rather than drop the comment
> 
> 
>  include/linux/usb.h | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/usb.h b/include/linux/usb.h
> index b47371d44d1b..8a32e17f826e 100644
> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -267,16 +267,15 @@ static inline void *usb_get_intfdata(struct usb_interface *intf)
>  }
>  
>  /**
> - * usb_set_intfdata() - associate driver-specific data with the interface
> - * @intf: the usb interface
> - * @data: pointer to the device priv structure or %NULL
> + * usb_set_intfdata() - associate driver-specific data with an interface
> + * @intf: USB interface
> + * @data: driver data
>   *
> - * Drivers should use this function in their probe() to associate their
> - * driver-specific data with the usb interface.
> + * Drivers can use this function in their probe() callbacks to associate
> + * driver-specific data with an interface.
>   *
> - * When disconnecting, the core will take care of setting @intf back to %NULL,
> - * so no actions are needed on the driver side. The interface should not be set
> - * to %NULL before all actions completed (e.g. no outsanding URB remaining).
> + * Note that there is generally no need to clear the driver-data pointer even
> + * if some drivers do so for historical or implementation-specific reasons.

I would add (bikeshedding, I realize -- rephrase to suit yourself):

	This is because the USB core always clears the pointer after 
	unbinding a driver from the interface.

Apart from that:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

>   */
>  static inline void usb_set_intfdata(struct usb_interface *intf, void *data)
>  {
> -- 
> 2.37.4
> 
