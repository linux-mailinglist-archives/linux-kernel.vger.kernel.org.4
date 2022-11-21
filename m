Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2189632942
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 17:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKUQSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 11:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiKUQSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:18:36 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 198E918E1F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 08:18:34 -0800 (PST)
Received: (qmail 122626 invoked by uid 1000); 21 Nov 2022 11:18:34 -0500
Date:   Mon, 21 Nov 2022 11:18:34 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Keeping <john@metanate.com>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3uk2kwYsZ3j67+l@rowland.harvard.edu>
References: <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
 <Y3piS43drwSoipD9@donbot>
 <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
 <Y3txTcASyvTWqFlc@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3txTcASyvTWqFlc@donbot>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 12:38:37PM +0000, John Keeping wrote:
> On Sun, Nov 20, 2022 at 03:46:26PM -0500, Alan Stern wrote:
> > I see.  The solution is simple: Embed a struct device in struct f_hidg, 
> > and call cdev_device_add() to add the device and the cdev.  This will 
> > automatically make the device the parent of the cdev, so the device's 
> > refcount won't go to 0 until the cdev's refcount does.  Then you can tie 
> > the f_hidg's lifetime to the device's, so the device's release routine 
> > can safely deallocate the entire f_hidg structure.
> > 
> > The parent of the new struct device should be set to &gadget->dev.  If 
> > you can't think of a better name for the device, you could simply append 
> > ":I" to the parent's name, where I is the interface number, or even 
> > append ":C.I" where C is the config number (like we do on the host 
> > side).
> 
> There is no gadget->dev at the time struct f_hidg is allocated.
> 
> AFAICT the device is the UDC, which is only associated with the gadget
> when it is bound.  The functions are allocated earlier than this and I
> can't see any device associated with struct usb_function_instance.

Ah, that's a shame.  All right, so be it.

> The patch below does fix the issue, but I'm wondering if there's a
> deeper problem here that can only be properly solved by adding some
> device/kobject hierarchy to the config side of things.

I don't believe there's any deeper problem.  If someone wants to have an 
fhidg device as a child of the gadget, I think it could be added and 
removed in the ->set_alt() and ->disable() callbacks.  Or maybe the 
->bind() and ->unbind() callbacks (I've never had to work with configfs 
so I'm not clear on the details).

> -- >8 --
> Subject: [PATCH] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
> 
> The embedded struct cdev does not have its lifetime correctly tied to
> the enclosing struct f_hidg, so there is a use-after-free if /dev/hidgN
> is held open while the gadget is deleted.
> 
> This can readily be replicated with libusbgx's example programs (for
> conciseness - operating directly via configfs is equivalent):
> 
> 	gadget-hid
> 	exec 3<> /dev/hidg0
> 	gadget-vid-pid-remove
> 	exec 3<&-
> 
> Add a device to f_hidg so that the cdev can properly take a reference to
> this and the structure will be freed only when the child device is
> released.
> 
> [Also fix refcount leak on an error path.]
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 35 ++++++++++++++++++++++++-----
>  1 file changed, 30 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index ca0a7d9eaa34..7ae97e5c4d20 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c
> @@ -71,6 +71,7 @@ struct f_hidg {
>  	wait_queue_head_t		write_queue;
>  	struct usb_request		*req;
>  
> +	struct device			dev;
>  	int				minor;
>  	struct cdev			cdev;
>  	struct usb_function		func;
> @@ -84,6 +85,14 @@ static inline struct f_hidg *func_to_hidg(struct usb_function *f)
>  	return container_of(f, struct f_hidg, func);
>  }
>  
> +static void hidg_release(struct device *dev)
> +{
> +	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
> +
> +	kfree(hidg->set_report_buf);
> +	kfree(hidg);
> +}
> +
>  /*-------------------------------------------------------------------------*/
>  /*                           Static descriptors                            */
>  
> @@ -999,6 +1008,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
>  
>  	/* create char device */
>  	cdev_init(&hidg->cdev, &f_hidg_fops);
> +	cdev_set_parent(&hidg->cdev, &hidg->dev.kobj);
>  	dev = MKDEV(major, hidg->minor);
>  	status = cdev_add(&hidg->cdev, dev, 1);

Instead of doing it by hand like this, why not call cdev_device_add()?

>  	if (status)
> @@ -1244,9 +1254,7 @@ static void hidg_free(struct usb_function *f)
>  
>  	hidg = func_to_hidg(f);
>  	opts = container_of(f->fi, struct f_hid_opts, func_inst);
> -	kfree(hidg->report_desc);
> -	kfree(hidg->set_report_buf);
> -	kfree(hidg);
> +	device_unregister(&hidg->dev);

Are you certain at this point that hidg->dev has been registered?  Even 
on all the error paths?

>  	mutex_lock(&opts->lock);
>  	--opts->refcnt;
>  	mutex_unlock(&opts->lock);
> @@ -1266,6 +1274,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>  {
>  	struct f_hidg *hidg;
>  	struct f_hid_opts *opts;
> +	int ret;
>  
>  	/* allocate and initialize one new instance */
>  	hidg = kzalloc(sizeof(*hidg), GFP_KERNEL);
> @@ -1277,17 +1286,27 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>  	mutex_lock(&opts->lock);
>  	++opts->refcnt;
>  
> +	device_initialize(&hidg->dev);
> +	hidg->dev.release = hidg_release;
> +	ret = dev_set_name(&hidg->dev, "hidg%d", hidg->minor);
> +	if (ret) {
> +		--opts->refcnt;
> +		mutex_unlock(&opts->lock);
> +		return ERR_PTR(ret);
> +	}
> +
>  	hidg->minor = opts->minor;
>  	hidg->bInterfaceSubClass = opts->subclass;
>  	hidg->bInterfaceProtocol = opts->protocol;
>  	hidg->report_length = opts->report_length;
>  	hidg->report_desc_length = opts->report_desc_length;
>  	if (opts->report_desc) {
> -		hidg->report_desc = kmemdup(opts->report_desc,
> +		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
>  					    opts->report_desc_length,
>  					    GFP_KERNEL);
>  		if (!hidg->report_desc) {
> -			kfree(hidg);
> +			put_device(&hidg->dev);
> +			--opts->refcnt;
>  			mutex_unlock(&opts->lock);
>  			return ERR_PTR(-ENOMEM);
>  		}
> @@ -1307,6 +1326,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>  	/* this could be made configurable at some point */
>  	hidg->qlen	   = 4;
>  
> +	ret = device_add(&hidg->dev);
> +	if (ret) {
> +		put_device(&hidg->dev);
> +		return ERR_PTR(ret);
> +	}

Why do this here instead of when the cdev is registered?  Or to put it 
another way, why not add the two of them at the same time by calling 
cdev_device_add() rather than adding them at two separate places?

Alan Stern

> +
>  	return &hidg->func;
>  }
>  
> -- 
> 2.38.1
> 
