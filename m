Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82BF7152D6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjE3BIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjE3BIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:08:11 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 7652EDB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 18:08:09 -0700 (PDT)
Received: (qmail 389654 invoked by uid 1000); 29 May 2023 21:08:08 -0400
Date:   Mon, 29 May 2023 21:08:08 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v4 3/3] usb: gadget: udc: core: Offload
 usb_udc_vbus_handler processing
Message-ID: <eca2b381-2b1f-47de-8385-ea448f2cbdb3@rowland.harvard.edu>
References: <20230529234816.3720623-1-badhri@google.com>
 <20230529234816.3720623-3-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529234816.3720623-3-badhri@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 11:48:16PM +0000, Badhri Jagan Sridharan wrote:
> chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handler
> processing.

This is not a good explanation.  In particular, it doesn't explain why 
moving the processing to a workqueue is the proper solution.

You should describe the issue I raised earlier, namely, that 
usb_udc_vbus_handler() has to run in interrupt context but it calls 
usb_udc_connect_control(), which has to run in process context.  And 
explain _why_ these routines have to run in those contexts.

> ---
>  drivers/usb/gadget/udc/core.c | 269 ++++++++++++++++------------------
>  1 file changed, 123 insertions(+), 146 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 4641153e9706..26380e621e9f 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -38,9 +38,10 @@ static const struct bus_type gadget_bus_type;
>   * for udcs who do not care about vbus status, this value is always true
>   * @started: the UDC's started state. True if the UDC had started.
>   * @connect_lock: protects udc->vbus, udc->started, gadget->connect, gadget->deactivate related
> - * functions. usb_gadget_connect_locked, usb_gadget_disconnect_locked,
> - * usb_udc_connect_control_locked, usb_gadget_udc_start_locked, usb_gadget_udc_stop_locked are
> - * called with this lock held.
> + * functions. usb_gadget_pullup_update_locked called with this lock held.
> + * @vbus_events: list head for processing vbus updates on usb_udc_vbus_handler.
> + * @vbus_events_lock: protects vbus_events list
> + * @vbus_work: work item that invokes usb_gadget_pullup_update_locked.
>   *
>   * This represents the internal data structure which is used by the UDC-class
>   * to hold information about udc driver and gadget together.
> @@ -53,6 +54,20 @@ struct usb_udc {
>  	bool				vbus;
>  	bool				started;
>  	struct mutex			connect_lock;
> +	struct list_head		vbus_events;
> +	spinlock_t			vbus_events_lock;
> +	struct work_struct		vbus_work;

Do you really need three new fields here?  Isn't vbus_work sufficient?

> +	bool				unbinding;

Do not include this in the same patch.  The unbinding flag does 
something different from the vbus_work structure, so it belongs in a 
different patch.

> +};
> +
> +/**
> + * struct vbus_event - used to notify vbus updates posted through usb_udc_vbus_handler.
> + * @vbus_on: true when vbus is on. false other wise.
> + * @node: list node for maintaining a list of pending updates to be processed.
> + */
> +struct vbus_event {
> +	bool vbus_on;
> +	struct list_head node;
>  };

Why do we need this?  Why can't the work routine simply set the pullup 
according to the current setting of vbus and the other flags?  That's 
what usb_udc_vbus_handler() does now.

>  
>  static struct class *udc_class;
> @@ -693,40 +708,46 @@ int usb_gadget_vbus_disconnect(struct usb_gadget *gadget)
>  EXPORT_SYMBOL_GPL(usb_gadget_vbus_disconnect);
>  
>  /* Internal version of usb_gadget_connect needs to be called with connect_lock held. */
> -static int usb_gadget_connect_locked(struct usb_gadget *gadget)
> +static int usb_gadget_pullup_update_locked(struct usb_gadget *gadget)
>  	__must_hold(&gadget->udc->connect_lock)
>  {
>  	int ret = 0;
> +	bool connect = !gadget->deactivated && gadget->udc->started && gadget->udc->vbus &&
> +		       !gadget->udc->unbinding;

Since you are wrapping this line anyway, you might as well wrap it 
before column 76.

>  
>  	if (!gadget->ops->pullup) {
>  		ret = -EOPNOTSUPP;
>  		goto out;
>  	}
>  
> -	if (gadget->connected)
> -		goto out;
> -
> -	if (gadget->deactivated || !gadget->udc->started) {
> -		/*
> -		 * If gadget is deactivated we only save new state.
> -		 * Gadget will be connected automatically after activation.
> -		 *
> -		 * udc first needs to be started before gadget can be pulled up.
> -		 */
> -		gadget->connected = true;
> -		goto out;
> +	if (connect != gadget->connected) {
> +		ret = gadget->ops->pullup(gadget, connect);
> +		if (!ret)
> +			gadget->connected = connect;
> +		mutex_lock(&udc_lock);
> +		if (!connect)
> +			gadget->udc->driver->disconnect(gadget);
> +		mutex_unlock(&udc_lock);
>  	}

What will happen if the gadget isn't deactivated, but it is started and 
VBUS power is prevent and the driver isn't unbinding, but the gadget 
driver decides to call usb_gadget_disconnect()?

>  
> -	ret = gadget->ops->pullup(gadget, 1);
> -	if (!ret)
> -		gadget->connected = 1;
> -
>  out:
>  	trace_usb_gadget_connect(gadget, ret);
>  
>  	return ret;
>  }
>  
> +static int usb_gadget_set_vbus(struct usb_gadget *gadget, bool vbus)
> +{
> +	int ret;
> +
> +	mutex_lock(&gadget->udc->connect_lock);
> +	gadget->udc->vbus = vbus;

Why does this have to be here?  What's wrong with setting vbus in 
interrupt context?

> +	ret = usb_gadget_pullup_update_locked(gadget);
> +	mutex_unlock(&gadget->udc->connect_lock);

Sorry, but at this point I'm getting tired of pointing out all the 
problems in this patch, so I'm going to stop here.

How about instead doing something really simple, like just make 
usb_udc_vbus_handler() queue up a work routine that calls 
usb_udc_connect_control()?  Just a minimal change that will be really 
easy to review.

Alan Stern
