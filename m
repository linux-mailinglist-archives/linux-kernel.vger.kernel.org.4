Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8FA718879
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEaR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjEaR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:29:13 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6EB67101
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:29:11 -0700 (PDT)
Received: (qmail 444662 invoked by uid 1000); 31 May 2023 13:29:10 -0400
Date:   Wed, 31 May 2023 13:29:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 1/3] usb: gadget: udc: core: Offload
 usb_udc_vbus_handler processing
Message-ID: <65dd300b-b967-41ab-b174-a7dc13ec2e19@rowland.harvard.edu>
References: <20230531040203.19295-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040203.19295-1-badhri@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 04:02:01AM +0000, Badhri Jagan Sridharan wrote:
> usb_udc_vbus_handler() can be invoked from interrupt context by irq
> handlers of the gadget drivers, however, usb_udc_connect_control() has
> to run in non-atomic context due to the following:
> a. Some of the gadget driver implementations expect the ->pullup
>    callback to be invoked in non-atomic context.
> b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
> 
> Hence offload invocation of usb_udc_connect_control()
> to workqueue.
> 
> Cc: stable@vger.kernel.org
> Fixes: 1016fc0c096c ("USB: gadget: Fix obscure lockdep violation for udc_mutex")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---
> Changes since v1:
> - Address Alan Stern's comment on usb_udc_vbus_handler invocation from
>   atomic context:
> * vbus_events_lock is now a spinlock and allocations in
> * usb_udc_vbus_handler are atomic now.
> 
> Changes since v2:
> - Addressing Alan Stern's comments:
> ** connect_lock is now held by callers of
> * usb_gadget_pullup_update_locked() and gadget_(un)bind_driver() does
> * notdirectly hold the lock.
> 
> ** Both usb_gadget_(dis)connect() and usb_udc_vbus_handler() would
> * set/clear udc->vbus and invoke usb_gadget_pullup_update_locked.
> 
> ** Add "unbinding" to prevent new connections after the gadget is being
> * unbound.
> 
> Changes since v3:
> ** Made a minor cleanup which I missed to do in v3 in
> * usb_udc_vbus_handler().
> 
> Changes since v4:
> - Addressing Alan Stern's comments:
> ** usb_udc_vbus_handler() now offloads invocation of usb_udc_connect_control()
> * from workqueue.
> 
> ** Dropped vbus_events list as this was redundant. Updating to the
> * latest value is suffice
> ---
>  drivers/usb/gadget/udc/core.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> index 52e6d2e84e35..44a9f32679b5 100644
> --- a/drivers/usb/gadget/udc/core.c
> +++ b/drivers/usb/gadget/udc/core.c
> @@ -48,6 +48,7 @@ struct usb_udc {
>  	struct list_head		list;
>  	bool				vbus;
>  	bool				started;
> +	struct work_struct		vbus_work;
>  };
>  
>  static struct class *udc_class;
> @@ -1086,6 +1087,13 @@ static void usb_udc_connect_control(struct usb_udc *udc)
>  		usb_gadget_disconnect(udc->gadget);
>  }
>  
> +static void vbus_event_work(struct work_struct *work)
> +{
> +	struct usb_udc *udc = container_of(work, struct usb_udc, vbus_work);
> +
> +	usb_udc_connect_control(udc);
> +}
> +
>  /**
>   * usb_udc_vbus_handler - updates the udc core vbus status, and try to
>   * connect or disconnect gadget
> @@ -1094,6 +1102,13 @@ static void usb_udc_connect_control(struct usb_udc *udc)
>   *
>   * The udc driver calls it when it wants to connect or disconnect gadget
>   * according to vbus status.
> + *
> + * This function can be invoked from interrupt context by irq handlers of the gadget drivers,
> + * however, usb_udc_connect_control() has to run in non-atomic context due to the following:
> + * a. Some of the gadget driver implementations expect the ->pullup callback to be invoked in
> + * non-atomic context.
> + * b. usb_gadget_disconnect() acquires udc_lock which is a mutex.
> + * Hence offload invocation of usb_udc_connect_control() to workqueue.

Comments should be wrapped after about 76 columns (unless there is some 
very good reason not to).

>   */
>  void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
>  {
> @@ -1101,7 +1116,7 @@ void usb_udc_vbus_handler(struct usb_gadget *gadget, bool status)
>  
>  	if (udc) {
>  		udc->vbus = status;
> -		usb_udc_connect_control(udc);
> +		schedule_work(&udc->vbus_work);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(usb_udc_vbus_handler);
> @@ -1328,6 +1343,7 @@ int usb_add_gadget(struct usb_gadget *gadget)
>  	mutex_lock(&udc_lock);
>  	list_add_tail(&udc->list, &udc_list);
>  	mutex_unlock(&udc_lock);
> +	INIT_WORK(&udc->vbus_work, vbus_event_work);
>  
>  	ret = device_add(&udc->dev);
>  	if (ret)
> @@ -1558,6 +1574,7 @@ static void gadget_unbind_driver(struct device *dev)
>  
>  	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
>  
> +	cancel_work_sync(&udc->vbus_work);
>  	usb_gadget_disconnect(gadget);
>  	usb_gadget_disable_async_callbacks(udc);
>  	if (gadget->irq)

I'm not in love with this, because there's nothing here to prevent the 
work item from being queued again right after it is cancelled.  Patch 
3/3 in the series will fix this, but in the meantime this window will 
exist.

Maybe it would be better to merge the 3/3 patch with this one.  They are 
very closely related, after all, since the other patch addresses the 
matter of not allowing the work item to do anything bad at the wrong 
time.

Alan Stern
