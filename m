Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774EE633BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233285AbiKVLzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:55:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233516AbiKVLzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:55:44 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9690327929;
        Tue, 22 Nov 2022 03:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=aTtIsYmSgjNJMwYngbptj8dWJgxtfDsvSXVDb4j71Ik=; b=yrMxl
        e2p3K14JvAJf0dt208JO3KloDsF2pWnjIKfWaOQ2b93xP9BUJUZ6bSsY+SxRNl/5HMW4JZotetuVg
        vXpyRWkQiIKI9MsDaIjrNxzx8UYwiYQlwz61Kl5yKLe3rfzPZ6tR/2QU+v+P75v6u/tpJvanpi99B
        W/rCV8NalOfF8PdAheVNOAb5zpAvQbR4EJPk43ap8+t9qlgxK70aKeVIkGu4ZuOwtRTd7q8XP/po4
        dOYTUyf1MGsgUAhgF6nRgGt7fRDeiS6x/7EANKBeMXlkx/z1BRrh7lDdZmIKTtozCLQgRtqfFtB4Y
        LoW/f+Sdjd4M3UdkdFNExNkvVqIQA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxRsK-0002rD-97;
        Tue, 22 Nov 2022 11:55:40 +0000
Date:   Tue, 22 Nov 2022 11:55:39 +0000
From:   John Keeping <john@metanate.com>
To:     Lee Jones <lee@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg KH <gregkh@linuxfoundation.org>, balbi@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3y4u21VaBgBdP9V@donbot>
References: <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
 <Y3piS43drwSoipD9@donbot>
 <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
 <Y3txTcASyvTWqFlc@donbot>
 <Y3uk2kwYsZ3j67+l@rowland.harvard.edu>
 <Y3vJfwtH3fniy5ep@donbot>
 <Y3yIzO7i0YRYapFg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3yIzO7i0YRYapFg@google.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 08:31:08AM +0000, Lee Jones wrote:
> On Mon, 21 Nov 2022, John Keeping wrote:
> > Subject: [PATCH] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
> > 
> > The embedded struct cdev does not have its lifetime correctly tied to
> > the enclosing struct f_hidg, so there is a use-after-free if /dev/hidgN
> > is held open while the gadget is deleted.
> > 
> > This can readily be replicated with libusbgx's example programs (for
> > conciseness - operating directly via configfs is equivalent):
> > 
> > 	gadget-hid
> > 	exec 3<> /dev/hidg0
> > 	gadget-vid-pid-remove
> > 	exec 3<&-
> > 
> > Pull the existing device up in to struct f_hidg and make use of the
> > cdev_device_{add,del}() helpers.  This changes the lifetime of the
> > device object to match struct f_hidg, but note that it is still added
> > and deleted at the same time.
> 
> This is much better, thanks for re-spinning.
> 
> > [Also fix refcount leak on an error path.]
> > 
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> >  drivers/usb/gadget/function/f_hid.c | 50 ++++++++++++++++-------------
> >  1 file changed, 28 insertions(+), 22 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> > index ca0a7d9eaa34..0b94668a3812 100644
> > --- a/drivers/usb/gadget/function/f_hid.c
> > +++ b/drivers/usb/gadget/function/f_hid.c
> > @@ -71,7 +71,7 @@ struct f_hidg {
> >  	wait_queue_head_t		write_queue;
> >  	struct usb_request		*req;
> >  
> > -	int				minor;
> > +	struct device			dev;
> >  	struct cdev			cdev;
> >  	struct usb_function		func;
> >  
> > @@ -84,6 +84,14 @@ static inline struct f_hidg *func_to_hidg(struct usb_function *f)
> >  	return container_of(f, struct f_hidg, func);
> >  }
> >  
> > +static void hidg_release(struct device *dev)
> > +{
> > +	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
> 
> Could we store/fetch this with dev_{set,get}_drvdata(), and make
> hidg->dev a pointer reducing the size of the struct f_hidg.

That will reduce the size of struct f_hidg, but we'll have an extra
allocation for the device object, so I don't think that's a real
benefit.

It seems simpler to keep a single allocation and embed the device.

> > +	kfree(hidg->set_report_buf);
> > +	kfree(hidg);
> > +}
> > +
> >  /*-------------------------------------------------------------------------*/
> >  /*                           Static descriptors                            */
> >  
> > @@ -904,9 +912,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
> >  	struct usb_ep		*ep;
> >  	struct f_hidg		*hidg = func_to_hidg(f);
> >  	struct usb_string	*us;
> > -	struct device		*device;
> >  	int			status;
> > -	dev_t			dev;
> >  
> >  	/* maybe allocate device-global string IDs, and patch descriptors */
> >  	us = usb_gstrings_attach(c->cdev, ct_func_strings,
> > @@ -999,21 +1005,12 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
> >  
> >  	/* create char device */
> >  	cdev_init(&hidg->cdev, &f_hidg_fops);
> > -	dev = MKDEV(major, hidg->minor);
> > -	status = cdev_add(&hidg->cdev, dev, 1);
> > +	cdev_set_parent(&hidg->cdev, &hidg->dev.kobj);
> 
> cdev_device_add() should take care of this, so long as:
> 
>     if (dev->devt)
>         dev_set_parent(cdev, &dev->kobj);

Thanks, I'll change this.

> > +	status = cdev_device_add(&hidg->cdev, &hidg->dev);
> >  	if (status)
> >  		goto fail_free_descs;
> >  
> > -	device = device_create(hidg_class, NULL, dev, NULL,
> > -			       "%s%d", "hidg", hidg->minor);
> > -	if (IS_ERR(device)) {
> > -		status = PTR_ERR(device);
> > -		goto del;
> > -	}
> > -
> >  	return 0;
> > -del:
> > -	cdev_del(&hidg->cdev);
> >  fail_free_descs:
> >  	usb_free_all_descriptors(f);
> >  fail:
> > @@ -1244,9 +1241,7 @@ static void hidg_free(struct usb_function *f)
> >  
> >  	hidg = func_to_hidg(f);
> >  	opts = container_of(f->fi, struct f_hid_opts, func_inst);
> > -	kfree(hidg->report_desc);
> > -	kfree(hidg->set_report_buf);
> > -	kfree(hidg);
> > +	put_device(&hidg->dev);
> >  	mutex_lock(&opts->lock);
> >  	--opts->refcnt;
> >  	mutex_unlock(&opts->lock);
> > @@ -1256,8 +1251,7 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
> >  {
> >  	struct f_hidg *hidg = func_to_hidg(f);
> >  
> > -	device_destroy(hidg_class, MKDEV(major, hidg->minor));
> > -	cdev_del(&hidg->cdev);
> > +	cdev_device_del(&hidg->cdev);
> >  
> >  	usb_free_all_descriptors(f);
> >  }
> > @@ -1266,6 +1260,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
> >  {
> >  	struct f_hidg *hidg;
> >  	struct f_hid_opts *opts;
> > +	int ret;
> >  
> >  	/* allocate and initialize one new instance */
> >  	hidg = kzalloc(sizeof(*hidg), GFP_KERNEL);
> > @@ -1277,17 +1272,28 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
> >  	mutex_lock(&opts->lock);
> >  	++opts->refcnt;
> >  
> > -	hidg->minor = opts->minor;
> > +	device_initialize(&hidg->dev);
> > +	hidg->dev.release = hidg_release;
> > +	hidg->dev.class = hidg_class;
> > +	hidg->dev.devt = MKDEV(major, opts->minor);
> > +	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
> > +	if (ret) {
> > +		--opts->refcnt;
> 
> Since we're holding the opts lock at this point, is there anything
> preventing us from incrementing the refcnt at the end, just before
> giving up the lock, thus saving 2 decrements in the error paths?

This makes sense.  I'll respin this as a series and include a patch
tidying up the error handling as a final step.

> > +		mutex_unlock(&opts->lock);
> > +		return ERR_PTR(ret);
> > +	}
> > +
> >  	hidg->bInterfaceSubClass = opts->subclass;
> >  	hidg->bInterfaceProtocol = opts->protocol;
> >  	hidg->report_length = opts->report_length;
> >  	hidg->report_desc_length = opts->report_desc_length;
> >  	if (opts->report_desc) {
> > -		hidg->report_desc = kmemdup(opts->report_desc,
> > +		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
> 
> Nice.
> 
> >  					    opts->report_desc_length,
> >  					    GFP_KERNEL);
> >  		if (!hidg->report_desc) {
> > -			kfree(hidg);
> > +			put_device(&hidg->dev);
> > +			--opts->refcnt;
> >  			mutex_unlock(&opts->lock);
> >  			return ERR_PTR(-ENOMEM);
> >  		}
> 
> Thanks for doing this John, your work is appreciated.
