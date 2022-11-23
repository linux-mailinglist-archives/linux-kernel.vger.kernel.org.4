Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AF5635C59
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 13:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237423AbiKWMEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 07:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbiKWMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 07:03:49 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A114044A;
        Wed, 23 Nov 2022 04:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-ID:Content-Description;
        bh=5uH2u2Mf5FTWWLv2WeaMZLafTBLl9MFAoHfwQhR/DdQ=; b=gAbE2NrRNelE+MW4ZZMcaX70Fa
        zigye3uWbFKF8/9tCVIzR0SKZvFIa8pdtAfbZlapkPW6hRGi/7ZbDlqATbQs3WLchJOe2fU+TYRWm
        RZwqlBRaFav+UmeqYZFZ6eN5tSvqVW/oGDT1+HIp13fQMoG8llgRzTo/uy6nqItkvfDon5ntGrMRu
        cZVY8DQIXmB87V0XN5zRlTcXDRx/p9nJG7+SRy3YDvfJ0Vne+koRpJcj3fFpQC/cGZ430FEVjYKIU
        E/zknXrY//CZu7ZwXv/kPw1wGhkuzi9aKFHHxdDUFei8NT/06nDwnoJl5NX8s8kclTDa3PKC4HS6l
        34rmu5AQ==;
Received: from dougal.metanate.com ([192.168.88.1] helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxoTc-0007EL-QS;
        Wed, 23 Nov 2022 12:03:41 +0000
Date:   Wed, 23 Nov 2022 12:03:40 +0000
From:   John Keeping <john@metanate.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Cc:     linux-usb@vger.kernel.org,
        Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 1/3] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
Message-ID: <Y34MHCPs1kDObB9m@donbot>
References: <20221122123523.3068034-1-john@metanate.com>
 <20221122123523.3068034-2-john@metanate.com>
 <723bd024-121d-dd89-7c39-315e93e49c44@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <723bd024-121d-dd89-7c39-315e93e49c44@collabora.com>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 12:52:24PM +0100, Andrzej Pietrasiewicz wrote:
> Hi John,
> 
> W dniu 22.11.2022 o 13:35, John Keeping pisze:
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
> > 
> > Fixes: 71adf1189469 ("USB: gadget: add HID gadget driver")
> > Signed-off-by: John Keeping <john@metanate.com>
> > ---
> >   drivers/usb/gadget/function/f_hid.c | 52 ++++++++++++++++-------------
> >   1 file changed, 28 insertions(+), 24 deletions(-)
> > 
> > diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
> > index ca0a7d9eaa34..8b8bbeaa27cb 100644
> > --- a/drivers/usb/gadget/function/f_hid.c
> > +++ b/drivers/usb/gadget/function/f_hid.c
> > @@ -71,7 +71,7 @@ struct f_hidg {
> >   	wait_queue_head_t		write_queue;
> >   	struct usb_request		*req;
> > -	int				minor;
> > +	struct device			dev;
> >   	struct cdev			cdev;
> >   	struct usb_function		func;
> > @@ -84,6 +84,14 @@ static inline struct f_hidg *func_to_hidg(struct usb_function *f)
> >   	return container_of(f, struct f_hidg, func);
> >   }
> > +static void hidg_release(struct device *dev)
> > +{
> > +	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
> > +
> > +	kfree(hidg->set_report_buf);
> > +	kfree(hidg);
> > +}
> > +
> 
> I assume the above is supposed to free the hidg memory as a result of
> put_device() and you free two things here ...
> 
> >   /*-------------------------------------------------------------------------*/
> >   /*                           Static descriptors                            */
> > @@ -904,9 +912,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
> >   	struct usb_ep		*ep;
> >   	struct f_hidg		*hidg = func_to_hidg(f);
> >   	struct usb_string	*us;
> > -	struct device		*device;
> >   	int			status;
> > -	dev_t			dev;
> >   	/* maybe allocate device-global string IDs, and patch descriptors */
> >   	us = usb_gstrings_attach(c->cdev, ct_func_strings,
> > @@ -999,21 +1005,11 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
> >   	/* create char device */
> >   	cdev_init(&hidg->cdev, &f_hidg_fops);
> > -	dev = MKDEV(major, hidg->minor);
> > -	status = cdev_add(&hidg->cdev, dev, 1);
> > +	status = cdev_device_add(&hidg->cdev, &hidg->dev);
> >   	if (status)
> >   		goto fail_free_descs;
> > -	device = device_create(hidg_class, NULL, dev, NULL,
> > -			       "%s%d", "hidg", hidg->minor);
> > -	if (IS_ERR(device)) {
> > -		status = PTR_ERR(device);
> > -		goto del;
> > -	}
> > -
> >   	return 0;
> > -del:
> > -	cdev_del(&hidg->cdev);
> >   fail_free_descs:
> >   	usb_free_all_descriptors(f);
> >   fail:
> > @@ -1244,9 +1240,7 @@ static void hidg_free(struct usb_function *f)
> >   	hidg = func_to_hidg(f);
> >   	opts = container_of(f->fi, struct f_hid_opts, func_inst);
> > -	kfree(hidg->report_desc);
> > -	kfree(hidg->set_report_buf);
> > -	kfree(hidg);
> 
> ... while here 3 things used to be freed. What happens to hidg->report_desc?

This switched to devm to simplify error handling in hidg_alloc().
