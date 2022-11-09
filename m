Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFDE622ECD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiKIPNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiKIPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:13:40 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AC0A81115B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 07:13:38 -0800 (PST)
Received: (qmail 511709 invoked by uid 1000); 9 Nov 2022 10:13:37 -0500
Date:   Wed, 9 Nov 2022 10:13:37 -0500
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     jiantao zhang <water.zhangjiantao@huawei.com>
Cc:     =?utf-8?B?6Jab5rab?= <xuetao09@huawei.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jakobkoschel@gmail.com" <jakobkoschel@gmail.com>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "colin.i.king@gmail.com" <colin.i.king@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Caiyadong <caiyadong@huawei.com>,
        xuhaiyang <xuhaiyang5@hisilicon.com>, suzhuangluan@hisilicon.com
Subject: Re: [PATCH] USB: gadget: Fix use-after-free during usb config switch
Message-ID: <Y2vDoeEY48egxrvW@rowland.harvard.edu>
References: <20221109125315.2959-1-xuetao09@huawei.com>
 <eba9e5db-a31f-8061-ed87-bf4c426e4e8d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eba9e5db-a31f-8061-ed87-bf4c426e4e8d@huawei.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Was this supposed to be an actual patch submission?  It doesn't look 
like it, because each line of the email begins with "> ".

On Wed, Nov 09, 2022 at 10:11:51PM +0800, jiantao zhang wrote:
> > In the process of switching USB config from rndis to other config,
> > if function gadget->ops->pullup() return an error,it will inevitably
> > cause a system panic(use after free).
> > 
> > Analysis as follows:
> > =====================================================================
> > (1) write /config/usb_gadget/g1/UDC "none"   (init.usb.configfs.rc:2)
> > 
> > gether_disconnect+0x2c/0x1f8           (dev->port_usb = NULL)
> > rndis_disable+0x4c/0x74
> > composite_disconnect+0x74/0xb0
> > configfs_composite_disconnect+0x60/0x7c
> > usb_gadget_disconnect+0x70/0x124
> > usb_gadget_unregister_driver+0xc8/0x1d8
> > gadget_dev_desc_UDC_store+0xec/0x1e4
> > 
> > In general, pointer dev->port will be set to null.
> > In function usb_gadget_disconnect(),gadget->udc->driver->disconnect()
> > will not be called when gadget->ops->pullup() return an error, therefore,
> > pointer dev->port will not be set to NULL.
> > If pointer dev->port_usb is not null, it will cause an exception of using
> > the freed memory in step3.

Good point.

...
> > Through above analysis, i think gadget->udc->driver->disconnect() need
> > to be called even if gadget->udc->driver->disconnect() return an error.

You mean "even if gadget->ops->pullup() returns an error".  That seems 
reasonable.  The only reason for the ->pullup callback to fail is if the 
hardware doesn't support it, but gadget drivers sometimes need to be 
unloaded regardless of the hardware's capabilities.

> > This reverts commit 0a55187a1ec8c03d0619e7ce41d10fdc39cff036

But this is not reasonable.  You should change the code so that it does 
what you want: Make it call driver->disconnect() even if ops->pullup() 
returns an error.  Don't revert an entire commit just because of one 
side effect.

> > I think this change is a code optimization, not a solution to specific
> > problem. And i think this problem is caused by this change,revert it can
> > solve this problem.

That commit was not just a code optimization.  It did fix a problem: 
Some UDCs would not call driver->disconnect() because they expected the 
core to make the call for them.

> > Of course, my understanding may be inaccurate.There may be a better
> > solution to this problem. If possible, please give some suggestions,
> > thanks.

Simply move the lines which grab the mutex and do the callback after 
the "if" statement, so that they will run regardless of what 
ops->pullup() returns.

Alan Stern

> > Fixes:<0a55187a1ec8c> (USB: gadget core: Issue ->disconnect()
> > callback from usb_gadget_disconnect())
> > 
> > Signed-off-by: Jiantao Zhang <water.zhangjiantao@huawei.com>
> > Signed-off-by: TaoXue <xuetao09@huawei.com>
> > ---
> >   drivers/usb/gadget/udc/core.c | 20 +++++++++++---------
> >   1 file changed, 11 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
> > index c63c0c2cf649..b502b2ac4824 100644
> > --- a/drivers/usb/gadget/udc/core.c
> > +++ b/drivers/usb/gadget/udc/core.c
> > @@ -707,9 +707,6 @@ EXPORT_SYMBOL_GPL(usb_gadget_connect);
> >    * as a disconnect (when a VBUS session is active).  Not all systems
> >    * support software pullup controls.
> >    *
> > - * Following a successful disconnect, invoke the ->disconnect() callback
> > - * for the current gadget driver so that UDC drivers don't need to.
> > - *
> >    * Returns zero on success, else negative errno.
> >    */
> >   int usb_gadget_disconnect(struct usb_gadget *gadget)
> > @@ -734,13 +731,8 @@ int usb_gadget_disconnect(struct usb_gadget *gadget)
> >   	}
> >   	ret = gadget->ops->pullup(gadget, 0);
> > -	if (!ret) {
> > +	if (!ret)
> >   		gadget->connected = 0;
> > -		mutex_lock(&udc_lock);
> > -		if (gadget->udc->driver)
> > -			gadget->udc->driver->disconnect(gadget);
> > -		mutex_unlock(&udc_lock);
> > -	}
> >   out:
> >   	trace_usb_gadget_disconnect(gadget, ret);
> > @@ -1532,6 +1524,11 @@ static void gadget_unbind_driver(struct device *dev)
> >   	kobject_uevent(&udc->dev.kobj, KOBJ_CHANGE);
> >   	usb_gadget_disconnect(gadget);
> > +
> > +	mutex_lock(&udc_lock);
> > +	udc->driver->disconnect(udc->gadget);
> > +	mutex_unlock(&udc_lock);
> > +
> >   	usb_gadget_disable_async_callbacks(udc);
> >   	if (gadget->irq)
> >   		synchronize_irq(gadget->irq);
> > @@ -1626,6 +1623,11 @@ static ssize_t soft_connect_store(struct device *dev,
> >   		usb_gadget_connect(udc->gadget);
> >   	} else if (sysfs_streq(buf, "disconnect")) {
> >   		usb_gadget_disconnect(udc->gadget);
> > +
> > +		mutex_lock(&udc_lock);
> > +		udc->driver->disconnect(udc->gadget);
> > +		mutex_unlock(&udc_lock);
> > +
> >   		usb_gadget_udc_stop(udc);
> >   	} else {
> >   		dev_err(dev, "unsupported command '%s'\n", buf);
