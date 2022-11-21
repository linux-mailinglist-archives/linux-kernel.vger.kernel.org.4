Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D75632C68
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 19:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbiKUSzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 13:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiKUSzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 13:55:13 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C27459FD5;
        Mon, 21 Nov 2022 10:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=UVFUp0Y4SrcahNB19ox9gdMLkDywU8HEZEQLPGkyIts=; b=IruOe
        94fqiYcjC+/oJGy42jpPsX2M4xUT429WV6DwcvGaC56kacpy1KDFrw3IMyYJINV1qkupwYepL7aiV
        BEQ2WmCg1/XJipYnAaOAWPiNwEgSFFYVb2/UiwJR+g/Hm9Btjc/9O2N31GRyXzBfcFWvpsexivl4e
        DEa2GkBwsZ7RWKOb7vK7whQrGZB+zzMXcXsGkzZPYYdN0qijmrSBEjGKNcPu1yWftJ59/6N0GIU55
        q2loLO3FkpNDJBkCLCMszUhHNhDVwDPErH6EKz1OSzADj0uYlCfT+aYxvr0pGzYDknOQBZy25t2/a
        Yo28KwlhJysPELsw5OGprYT63wtOA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxBwW-0007Hk-Cy;
        Mon, 21 Nov 2022 18:54:57 +0000
Date:   Mon, 21 Nov 2022 18:54:55 +0000
From:   John Keeping <john@metanate.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3vJfwtH3fniy5ep@donbot>
References: <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
 <Y3piS43drwSoipD9@donbot>
 <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
 <Y3txTcASyvTWqFlc@donbot>
 <Y3uk2kwYsZ3j67+l@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3uk2kwYsZ3j67+l@rowland.harvard.edu>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 11:18:34AM -0500, Alan Stern wrote:
> On Mon, Nov 21, 2022 at 12:38:37PM +0000, John Keeping wrote:
> > On Sun, Nov 20, 2022 at 03:46:26PM -0500, Alan Stern wrote:
> > > I see.  The solution is simple: Embed a struct device in struct f_hidg, 
> > > and call cdev_device_add() to add the device and the cdev.  This will 
> > > automatically make the device the parent of the cdev, so the device's 
> > > refcount won't go to 0 until the cdev's refcount does.  Then you can tie 
> > > the f_hidg's lifetime to the device's, so the device's release routine 
> > > can safely deallocate the entire f_hidg structure.
> > > 
> > > The parent of the new struct device should be set to &gadget->dev.  If 
> > > you can't think of a better name for the device, you could simply append 
> > > ":I" to the parent's name, where I is the interface number, or even 
> > > append ":C.I" where C is the config number (like we do on the host 
> > > side).
> > 
> > There is no gadget->dev at the time struct f_hidg is allocated.
> > 
> > AFAICT the device is the UDC, which is only associated with the gadget
> > when it is bound.  The functions are allocated earlier than this and I
> > can't see any device associated with struct usb_function_instance.
> 
> Ah, that's a shame.  All right, so be it.
> 
> > The patch below does fix the issue, but I'm wondering if there's a
> > deeper problem here that can only be properly solved by adding some
> > device/kobject hierarchy to the config side of things.
> 
> I don't believe there's any deeper problem.  If someone wants to have an 
> fhidg device as a child of the gadget, I think it could be added and 
> removed in the ->set_alt() and ->disable() callbacks.  Or maybe the 
> ->bind() and ->unbind() callbacks (I've never had to work with configfs 
> so I'm not clear on the details).

It turns out there's already a device being created here, just not
associated with the structure.  Your suggestions around
cdev_device_add() made me spot what's going on with that so the actual
fix is to pull its lifetime up to match struct f_hidg.

-- >8 --
Subject: [PATCH] usb: gadget: f_hid: fix f_hidg lifetime vs cdev

The embedded struct cdev does not have its lifetime correctly tied to
the enclosing struct f_hidg, so there is a use-after-free if /dev/hidgN
is held open while the gadget is deleted.

This can readily be replicated with libusbgx's example programs (for
conciseness - operating directly via configfs is equivalent):

	gadget-hid
	exec 3<> /dev/hidg0
	gadget-vid-pid-remove
	exec 3<&-

Pull the existing device up in to struct f_hidg and make use of the
cdev_device_{add,del}() helpers.  This changes the lifetime of the
device object to match struct f_hidg, but note that it is still added
and deleted at the same time.

[Also fix refcount leak on an error path.]

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 50 ++++++++++++++++-------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ca0a7d9eaa34..0b94668a3812 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -71,7 +71,7 @@ struct f_hidg {
 	wait_queue_head_t		write_queue;
 	struct usb_request		*req;
 
-	int				minor;
+	struct device			dev;
 	struct cdev			cdev;
 	struct usb_function		func;
 
@@ -84,6 +84,14 @@ static inline struct f_hidg *func_to_hidg(struct usb_function *f)
 	return container_of(f, struct f_hidg, func);
 }
 
+static void hidg_release(struct device *dev)
+{
+	struct f_hidg *hidg = container_of(dev, struct f_hidg, dev);
+
+	kfree(hidg->set_report_buf);
+	kfree(hidg);
+}
+
 /*-------------------------------------------------------------------------*/
 /*                           Static descriptors                            */
 
@@ -904,9 +912,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 	struct usb_ep		*ep;
 	struct f_hidg		*hidg = func_to_hidg(f);
 	struct usb_string	*us;
-	struct device		*device;
 	int			status;
-	dev_t			dev;
 
 	/* maybe allocate device-global string IDs, and patch descriptors */
 	us = usb_gstrings_attach(c->cdev, ct_func_strings,
@@ -999,21 +1005,12 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
-	dev = MKDEV(major, hidg->minor);
-	status = cdev_add(&hidg->cdev, dev, 1);
+	cdev_set_parent(&hidg->cdev, &hidg->dev.kobj);
+	status = cdev_device_add(&hidg->cdev, &hidg->dev);
 	if (status)
 		goto fail_free_descs;
 
-	device = device_create(hidg_class, NULL, dev, NULL,
-			       "%s%d", "hidg", hidg->minor);
-	if (IS_ERR(device)) {
-		status = PTR_ERR(device);
-		goto del;
-	}
-
 	return 0;
-del:
-	cdev_del(&hidg->cdev);
 fail_free_descs:
 	usb_free_all_descriptors(f);
 fail:
@@ -1244,9 +1241,7 @@ static void hidg_free(struct usb_function *f)
 
 	hidg = func_to_hidg(f);
 	opts = container_of(f->fi, struct f_hid_opts, func_inst);
-	kfree(hidg->report_desc);
-	kfree(hidg->set_report_buf);
-	kfree(hidg);
+	put_device(&hidg->dev);
 	mutex_lock(&opts->lock);
 	--opts->refcnt;
 	mutex_unlock(&opts->lock);
@@ -1256,8 +1251,7 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_hidg *hidg = func_to_hidg(f);
 
-	device_destroy(hidg_class, MKDEV(major, hidg->minor));
-	cdev_del(&hidg->cdev);
+	cdev_device_del(&hidg->cdev);
 
 	usb_free_all_descriptors(f);
 }
@@ -1266,6 +1260,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 {
 	struct f_hidg *hidg;
 	struct f_hid_opts *opts;
+	int ret;
 
 	/* allocate and initialize one new instance */
 	hidg = kzalloc(sizeof(*hidg), GFP_KERNEL);
@@ -1277,17 +1272,28 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	mutex_lock(&opts->lock);
 	++opts->refcnt;
 
-	hidg->minor = opts->minor;
+	device_initialize(&hidg->dev);
+	hidg->dev.release = hidg_release;
+	hidg->dev.class = hidg_class;
+	hidg->dev.devt = MKDEV(major, opts->minor);
+	ret = dev_set_name(&hidg->dev, "hidg%d", opts->minor);
+	if (ret) {
+		--opts->refcnt;
+		mutex_unlock(&opts->lock);
+		return ERR_PTR(ret);
+	}
+
 	hidg->bInterfaceSubClass = opts->subclass;
 	hidg->bInterfaceProtocol = opts->protocol;
 	hidg->report_length = opts->report_length;
 	hidg->report_desc_length = opts->report_desc_length;
 	if (opts->report_desc) {
-		hidg->report_desc = kmemdup(opts->report_desc,
+		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
 					    opts->report_desc_length,
 					    GFP_KERNEL);
 		if (!hidg->report_desc) {
-			kfree(hidg);
+			put_device(&hidg->dev);
+			--opts->refcnt;
 			mutex_unlock(&opts->lock);
 			return ERR_PTR(-ENOMEM);
 		}
-- 
2.38.1

