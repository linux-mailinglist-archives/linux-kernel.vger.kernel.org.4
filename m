Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833886C4E15
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCVOmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:42:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjCVOmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:42:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B3F9A664E9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 07:42:02 -0700 (PDT)
Received: (qmail 1103683 invoked by uid 1000); 22 Mar 2023 10:41:46 -0400
Date:   Wed, 22 Mar 2023 10:41:46 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sebastian Reichel <sre@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Jiantao Zhang <water.zhangjiantao@huawei.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_ppratap@quicinc.com, quic_wcheng@quicinc.com,
        quic_jackp@quicinc.com, quic_ugoswami@quicinc.com
Subject: Re: [RFC 2/2] usb: gadget: udc: Handle gadget_connect failure during
 bind operation
Message-ID: <a5b57150-81e1-4eba-89e5-005cc78e243a@rowland.harvard.edu>
References: <20230322092740.28491-1-quic_kriskura@quicinc.com>
 <20230322092740.28491-3-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322092740.28491-3-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 02:57:40PM +0530, Krishna Kurapati wrote:
> In the event, gadget_connect call (which invokes pullup) fails,
> propagate the error to udc bind operation which inturn sends the
> error to configfs. The userspace can then retry enumeartion if
> it chooses to.
> 
> Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
> ---
>  drivers/usb/gadget/udc/core.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 23b0629a8774..26bfed5c3a45 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -1051,12 +1051,16 @@ EXPORT_SYMBOL_GPL(usb_gadget_set_state);
>  
>  /* ------------------------------------------------------------------------- */
>  
> -static void usb_udc_connect_control(struct usb_udc *udc)
> +static int usb_udc_connect_control(struct usb_udc *udc)
>  {
> +	int ret;
> +
>  	if (udc->vbus)
> -		usb_gadget_connect(udc->gadget);
> +		ret = usb_gadget_connect(udc->gadget);
>  	else
> -		usb_gadget_disconnect(udc->gadget);
> +		ret = usb_gadget_disconnect(udc->gadget);
> +
> +	return ret;
>  }
>  
>  /**
> @@ -1500,11 +1504,16 @@ static int gadget_bind_driver(struct device *dev)
>  	if (ret)
>  		goto err_start;
>  	usb_gadget_enable_async_callbacks(udc);
> -	usb_udc_connect_control(udc);
> +	ret = usb_udc_connect_control(udc);
> +	if (ret)
> +		goto err_connect_control;
>  
>  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>  	return 0;
>  
> + err_connect_control:

At this point you need to copy the code in gadget_unbind_driver().  In 
particular, this should have:

+	usb_gadget_disable_async_callbacks(udc);
+	if (gadget->irq)
+		synchronize_irq(gadget->irq);

Alan Stern

> +	usb_gadget_udc_stop(udc);
> +
>   err_start:
>  	driver->unbind(udc->gadget);
>  
> -- 
> 2.40.0
> 
