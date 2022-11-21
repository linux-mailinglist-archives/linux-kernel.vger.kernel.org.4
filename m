Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0207C632CDC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 20:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiKUTSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 14:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbiKUTSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 14:18:23 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 0CA5BDA4F3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:17:58 -0800 (PST)
Received: (qmail 128144 invoked by uid 1000); 21 Nov 2022 14:17:56 -0500
Date:   Mon, 21 Nov 2022 14:17:56 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Keeping <john@metanate.com>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3vO5OwUzsn08Avz@rowland.harvard.edu>
References: <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
 <Y3piS43drwSoipD9@donbot>
 <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
 <Y3txTcASyvTWqFlc@donbot>
 <Y3uk2kwYsZ3j67+l@rowland.harvard.edu>
 <Y3vJfwtH3fniy5ep@donbot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vJfwtH3fniy5ep@donbot>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 06:54:55PM +0000, John Keeping wrote:
> It turns out there's already a device being created here, just not
> associated with the structure.  Your suggestions around
> cdev_device_add() made me spot what's going on with that so the actual
> fix is to pull its lifetime up to match struct f_hidg.

It's not obvious from the patch what device was already being created, 
but never mind...

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
> Pull the existing device up in to struct f_hidg and make use of the
> cdev_device_{add,del}() helpers.  This changes the lifetime of the
> device object to match struct f_hidg, but note that it is still added
> and deleted at the same time.
> 
> [Also fix refcount leak on an error path.]
> 
> Signed-off-by: John Keeping <john@metanate.com>
> ---
>  drivers/usb/gadget/function/f_hid.c | 50 ++++++++++++++++-------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> index ca0a7d9eaa34..0b94668a3812 100644
> --- a/drivers/usb/gadget/function/f_hid.c
> +++ b/drivers/usb/gadget/function/f_hid.c

> @@ -999,21 +1005,12 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
>  
>  	/* create char device */
>  	cdev_init(&hidg->cdev, &f_hidg_fops);
> -	dev = MKDEV(major, hidg->minor);
> -	status = cdev_add(&hidg->cdev, dev, 1);
> +	cdev_set_parent(&hidg->cdev, &hidg->dev.kobj);

This line isn't needed; cdev_device_add() does it for you because 
hidg->dev.devt has been set.

> +	status = cdev_device_add(&hidg->cdev, &hidg->dev);
>  	if (status)
>  		goto fail_free_descs;

> @@ -1277,17 +1272,28 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
>  	mutex_lock(&opts->lock);
>  	++opts->refcnt;
>  
> -	hidg->minor = opts->minor;
> +	device_initialize(&hidg->dev);
> +	hidg->dev.release = hidg_release;
> +	hidg->dev.class = hidg_class;
> +	hidg->dev.devt = MKDEV(major, opts->minor);
> +	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
> +	if (ret) {
> +		--opts->refcnt;
> +		mutex_unlock(&opts->lock);
> +		return ERR_PTR(ret);
> +	}
> +

Otherwise this looks okay (although I don't know any of the details of 
how fhidg works, so you shouldn't take my word for it).

Alan Stern
