Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 009DA632270
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:39:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbiKUMjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:39:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbiKUMi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:38:57 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B24EB960E;
        Mon, 21 Nov 2022 04:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=Wrs3szcBAZIykl6mGC4jBH1XMnRmSa8wYcSH6Ng5nGE=; b=QaikM
        2jqYpSt1KuKpbiqBhDN5R7NLwxasVaFd+WJ0/FHQzAU4fCwBIS4yQtpndcsSNPj4CDe9pRpqUIdJ+
        M03UE7BN54e1oTmG+sjsJW5v9BqgaLLaxwp19DP4IO9DlWzKsV0p5rll1DwMK9sFfBKkuMro/6Xpa
        GeiN3u1+mSHueCswGkJenmMGMDtewLI1+SJFJunWBngqNm9/apOKvY3Jk1wtXg5ib8BkLocQ978zd
        x2f8F6JHZeGFMzxVfUN1Z1nKWPvThQMJmHBpBwDTYrx8vFTBv/pYUz4iWXhlCxI+7lOJ12klGI0yx
        IEBVCUn3HX8y/B84zRw4QNLao18+A==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1ox64M-00087B-8O;
        Mon, 21 Nov 2022 12:38:39 +0000
Date:   Mon, 21 Nov 2022 12:38:37 +0000
From:   John Keeping <john@metanate.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Lee Jones <lee@kernel.org>, Greg KH <gregkh@linuxfoundation.org>,
        balbi@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: gadget: f_hid: Conduct proper refcounting on
 shared f_hidg pointer
Message-ID: <Y3txTcASyvTWqFlc@donbot>
References: <20221117120813.1257583-1-lee@kernel.org>
 <Y3YuL8rSE9pNfIZN@kroah.com>
 <Y3Y7MlwV0UFcA3w8@google.com>
 <Y3ZlvyZoL+PzpbQX@rowland.harvard.edu>
 <Y3dIXUmjTfJLpPe7@google.com>
 <Y3er7nenAhbmBdBy@rowland.harvard.edu>
 <Y3e0zAa7+HiNVrKN@donbot>
 <Y3f0DJTOQ/8TVX0h@rowland.harvard.edu>
 <Y3piS43drwSoipD9@donbot>
 <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3qSImZkZwCG1kA1@rowland.harvard.edu>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 20, 2022 at 03:46:26PM -0500, Alan Stern wrote:
> On Sun, Nov 20, 2022 at 05:22:19PM +0000, John Keeping wrote:
> > On Fri, Nov 18, 2022 at 04:07:24PM -0500, Alan Stern wrote:
> > > On Fri, Nov 18, 2022 at 04:37:32PM +0000, John Keeping wrote:
> > > > I don't think it's at all simple to fix this - I posted a series
> > > > addressing the lifetime issues here a few years ago but didn't chase it
> > > > up and there was no feedback:
> > > > 
> > > > 	https://lore.kernel.org/linux-usb/20191028114228.3679219-1-john@metanate.com/
> > > > 
> > > > That includes a patch to remove the embedded struct cdev and manage its
> > > > lifetime separately, which I think is needed as there are two different
> > > > struct device objects here and we cannot tie their lifetimes together.
> > > 
> > > I still don't have a clear picture of what the real problem is.  Lee's 
> > > original patch description just said "external references are presently 
> > > not tracked", with no details about what those external references are. 
> > > Why not add just proper cdev_get() and cdev_put() calls to whatever code 
> > > handles those external references, so that they _are_ tracked?
> > > 
> > > What are the two different struct device objects?  Why do their 
> > > lifetimes need to be tied together?  If you do need to tie their 
> > > lifetimes somehow, why not simply make one of them (the one which is 
> > > logically allowed to be shorter-lived) hold a reference to the other?
> > 
> > The problem is that we have a struct cdev embedded in f_hidg but the
> > lifetime of f_hidg is not tied to any kobject so we can't solve this in
> > the right way by setting the parent kobject of the cdev.
> > 
> > While refcounting struct f_hidg is necessary, it's not sufficient
> > because the only way to keep it alive long enough for the final
> > kobject_put() on the embedded cdev is to tie the lifetime to a kobject
> > of its own and there is no suitable object as this is not the model
> > followed by gadget function instances.
> 
> I see.  The solution is simple: Embed a struct device in struct f_hidg, 
> and call cdev_device_add() to add the device and the cdev.  This will 
> automatically make the device the parent of the cdev, so the device's 
> refcount won't go to 0 until the cdev's refcount does.  Then you can tie 
> the f_hidg's lifetime to the device's, so the device's release routine 
> can safely deallocate the entire f_hidg structure.
> 
> The parent of the new struct device should be set to &gadget->dev.  If 
> you can't think of a better name for the device, you could simply append 
> ":I" to the parent's name, where I is the interface number, or even 
> append ":C.I" where C is the config number (like we do on the host 
> side).

There is no gadget->dev at the time struct f_hidg is allocated.

AFAICT the device is the UDC, which is only associated with the gadget
when it is bound.  The functions are allocated earlier than this and I
can't see any device associated with struct usb_function_instance.

The patch below does fix the issue, but I'm wondering if there's a
deeper problem here that can only be properly solved by adding some
device/kobject hierarchy to the config side of things.

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

Add a device to f_hidg so that the cdev can properly take a reference to
this and the structure will be freed only when the child device is
released.

[Also fix refcount leak on an error path.]

Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 35 ++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ca0a7d9eaa34..7ae97e5c4d20 100644
--- a/drivers/usb/gadget/function/f_hid.c
+++ b/drivers/usb/gadget/function/f_hid.c
@@ -71,6 +71,7 @@ struct f_hidg {
 	wait_queue_head_t		write_queue;
 	struct usb_request		*req;
 
+	struct device			dev;
 	int				minor;
 	struct cdev			cdev;
 	struct usb_function		func;
@@ -84,6 +85,14 @@ static inline struct f_hidg *func_to_hidg(struct usb_function *f)
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
 
@@ -999,6 +1008,7 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
+	cdev_set_parent(&hidg->cdev, &hidg->dev.kobj);
 	dev = MKDEV(major, hidg->minor);
 	status = cdev_add(&hidg->cdev, dev, 1);
 	if (status)
@@ -1244,9 +1254,7 @@ static void hidg_free(struct usb_function *f)
 
 	hidg = func_to_hidg(f);
 	opts = container_of(f->fi, struct f_hid_opts, func_inst);
-	kfree(hidg->report_desc);
-	kfree(hidg->set_report_buf);
-	kfree(hidg);
+	device_unregister(&hidg->dev);
 	mutex_lock(&opts->lock);
 	--opts->refcnt;
 	mutex_unlock(&opts->lock);
@@ -1266,6 +1274,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 {
 	struct f_hidg *hidg;
 	struct f_hid_opts *opts;
+	int ret;
 
 	/* allocate and initialize one new instance */
 	hidg = kzalloc(sizeof(*hidg), GFP_KERNEL);
@@ -1277,17 +1286,27 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	mutex_lock(&opts->lock);
 	++opts->refcnt;
 
+	device_initialize(&hidg->dev);
+	hidg->dev.release = hidg_release;
+	ret = dev_set_name(&hidg->dev, "hidg%d", hidg->minor);
+	if (ret) {
+		--opts->refcnt;
+		mutex_unlock(&opts->lock);
+		return ERR_PTR(ret);
+	}
+
 	hidg->minor = opts->minor;
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
@@ -1307,6 +1326,12 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 	/* this could be made configurable at some point */
 	hidg->qlen	   = 4;
 
+	ret = device_add(&hidg->dev);
+	if (ret) {
+		put_device(&hidg->dev);
+		return ERR_PTR(ret);
+	}
+
 	return &hidg->func;
 }
 
-- 
2.38.1

