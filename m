Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0266633BCE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:52:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiKVLwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiKVLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:52:20 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8022F3AF;
        Tue, 22 Nov 2022 03:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=R9yjdI7hQmwtzs9JPkLaQha0pclNGWaaw26yNHcXB8c=; b=m/7MV
        BNbU9VjV3poMVIUOpgyp4T00yYb0HMb0+hnP0aV1cdyk4Ch9DVT8pvpala78Zmkwl9IpajUh0uL13
        0ZUY5V9bUKMBAcYNVzBAz+sPSAoqiBIiox1cugoeSs7drZdHJSpOCN3cYjoarQre0SIc4A7sj2mdd
        XnE57aZ0qpwqYU3QtFJRob9OKgE2Q19QWZjBZVWMFjAqw/y2p29P1YthSTUSGewbuV+4hyIBqanrs
        UuFxFeKw0VA1tgAJs9uAbZ+QjuOWa4nlEQsKO5zRIMv7zXbHKY2yzlQyQI6nanq/5ZfwQOXbhnSMH
        OORQ7YvVyuFd9VmR/C3bjCa23/tGw==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxRp0-0002pr-MC;
        Tue, 22 Nov 2022 11:52:15 +0000
Date:   Tue, 22 Nov 2022 11:52:13 +0000
From:   John Keeping <john@metanate.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3y37ZCNmaMKBhi3@donbot>
References: <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
 <Y3piS43drwSoipD9@donbot>
 <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
 <Y3txTcASyvTWqFlc@donbot>
 <Y3uk2kwYsZ3j67+l@rowland.harvard.edu>
 <Y3vJfwtH3fniy5ep@donbot>
 <Y3vO5OwUzsn08Avz@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3vO5OwUzsn08Avz@rowland.harvard.edu>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 02:17:56PM -0500, Alan Stern wrote:
> On Mon, Nov 21, 2022 at 06:54:55PM +0000, John Keeping wrote:
> > It turns out there's already a device being created here, just not
> > associated with the structure.  Your suggestions around
> > cdev_device_add() made me spot what's going on with that so the actual
> > fix is to pull its lifetime up to match struct f_hidg.
> 
> It's not obvious from the patch what device was already being created, 
> but never mind...

The patch has:

-       device = device_create(hidg_class, NULL, dev, NULL,
-                              "%s%d", "hidg", hidg->minor);

but this device was not previously associated with the cdev (apart from
indirectly via dev_t).

> > -- >8 --
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
> > 
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
> 
> > @@ -999,21 +1005,12 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
> >  
> >  	/* create char device */
> >  	cdev_init(&hidg->cdev, &f_hidg_fops);
> > -	dev = MKDEV(major, hidg->minor);
> > -	status = cdev_add(&hidg->cdev, dev, 1);
> > +	cdev_set_parent(&hidg->cdev, &hidg->dev.kobj);
> 
> This line isn't needed; cdev_device_add() does it for you because 
> hidg->dev.devt has been set.

Thanks, I'll drop this line.
