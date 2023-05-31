Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91F27188A5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjEaRlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230251AbjEaRln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:41:43 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9A14AE56
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:41:00 -0700 (PDT)
Received: (qmail 445117 invoked by uid 1000); 31 May 2023 13:40:53 -0400
Date:   Wed, 31 May 2023 13:40:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, stable <stable@kernel.org>
Subject: Re: [PATCH v5 3/3] usb: gadget: udc: core: Prevent UDC from starting
 when unbound
Message-ID: <9a537d74-28be-48fb-85e0-628f3385de7e@rowland.harvard.edu>
References: <20230531040203.19295-1-badhri@google.com>
 <20230531040203.19295-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040203.19295-3-badhri@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 04:02:03AM +0000, Badhri Jagan Sridharan wrote:
> UDC should neither be started nor pulled up unless the gadget driver is
> bound. The new flag "allow_start" is now set by gadget_bind_driver()
> and cleared by gadget_unbind_driver(). usb_gadget_udc_start_locked()
> now checks whether allow_start is set before starting the UDC by
> invoking the ->udc_start() callback.

"allow_start" isn't quite the right name either, because there is a 
short time interval during which the UDC is started but we don't want 
to allow it to connect to the host (this occurs in 
gadget_unbind_driver() between the disconnect call and the 
usb_gadge_udc_stop call).  A more accurate name would be "allow_connect" 
or "allow_pullup".

> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> v5 is the first version in this series.
> ---
>  drivers/usb/gadget/udc/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 6ffe5fda8bb7..ac9d6186815d 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -37,6 +37,8 @@ static const struct bus_type gadget_bus_type;
>   * @vbus: for udcs who care about vbus status, this value is real vbus status;
>   * for udcs who do not care about vbus status, this value is always true
>   * @started: the UDC's started state. True if the UDC had started.
> + * @allow_start: Indicates whether UDC is allowed to start. Set/cleared by gadget_(un)bind_driver()
> + * after gadget driver is bound or unbound.
>   * @connect_lock: protects udc->vbus, udc->started, gadget->connect, gadget->deactivate related
>   * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
>   * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are

As before, wrap the comments around column 76.

> @@ -52,6 +54,7 @@ struct usb_udc {
>  	struct list_head		list;
>  	bool				vbus;
>  	bool				started;
> +	bool				allow_start;
>  	struct work_struct		vbus_work;
>  	struct mutex			connect_lock;
>  };
> @@ -1204,6 +1207,9 @@ static inline int usb_gadget_udc_start_locked(struct usb_udc *udc)
>  	if (udc->started) {
>  		dev_err(&udc->dev, "UDC had already started\n");
>  		return -EBUSY;
> +	} else if (!udc->allow_start) {
> +		dev_err(&udc->dev, "UDC not allowed to start. Is gadget driver bound ?\n");
> +		return -EIO;
>  	}

This isn't the right test or the right place.  We want to prevent the 
UDC from connecting to the host, not prevent it from starting.

>  
>  	ret = udc->gadget->ops->udc_start(udc->gadget, udc->driver);
> @@ -1590,6 +1596,7 @@ static int gadget_bind_driver(struct device *dev)
>  		goto err_bind;
>  
>  	mutex_lock(&udc->connect_lock);
> +	udc->allow_start = true;
>  	ret = usb_gadget_udc_start_locked(udc);
>  	if (ret) {
>  		mutex_unlock(&udc->connect_lock);
> @@ -1630,6 +1637,7 @@ static void gadget_unbind_driver(struct device *dev)
>  
>  	cancel_work_sync(&udc->vbus_work);
>  	mutex_lock(&udc->connect_lock);
> +	udc->allow_start = false;
>  	usb_gadget_disconnect_locked(gadget);
>  	usb_gadget_disable_async_callbacks(udc);
>  	if (gadget->irq)

Here is where the problem about the vbus work item getting requeued can 
be fixed.  Clear the allow_connect flag before the call to 
cancel_work_sync().  That way, even if the vbus work item gets queued 
again after it is cancelled, when it does run it won't do anything.

Although, come to think of it, there is still the problem of making sure 
that the work item doesn't run after the udc has been deallocated.  It 
looks like you will also need to cancel the work item at the end of 
usb_del_gadget().  At that point the UDC has already been stopped, so it 
won't call usb_hcd_vbus_handler() again.

Alan Stern
