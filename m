Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19062633C98
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiKVMfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:35:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233373AbiKVMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:35:35 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B685B5B9;
        Tue, 22 Nov 2022 04:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:References:
        In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Reply-To:
        Content-ID:Content-Description;
        bh=klbTl7HLzDhjQhMufy4j3EDYOzLDgfBHxVxD7HUlLtI=; b=Ui9NMrKSmj3G1KD2ytqNoQyqr+
        roZDBgCP3u/jG7M04BgVFd571+TCxoRxVgeK6jTAkXvMsPs7ptAx7Yf8RBdzbOh8T5J1He4JtCruI
        FkM8P+oIK5QiE1/KQZiqorp749Y0ECFETRrjYhXIbEm4dPWPGcRn2nC2c+CVH/w3x5eI9h/GuUtVu
        xuxTvRSu/84JoykrJADD+worDk5/YOqThfOP0pqYmJUWZwa3FP5EbW3n62oKI8keKhkRVRmycH4X/
        42bJVgWJQaRMv/U9s/rzhSsPhpqfdih4b1k6ImQKbmZOgOsCUeGHi0RjoOPBxUd+gni9A9CApYyMf
        nZPvgGIQ==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxSUt-0003da-7C;
        Tue, 22 Nov 2022 12:35:31 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Keeping <john@metanate.com>, Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 1/3] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
Date:   Tue, 22 Nov 2022 12:35:21 +0000
Message-Id: <20221122123523.3068034-2-john@metanate.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221122123523.3068034-1-john@metanate.com>
References: <20221122123523.3068034-1-john@metanate.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

Fixes: 71adf1189469 ("USB: gadget: add HID gadget driver")
Signed-off-by: John Keeping <john@metanate.com>
---
 drivers/usb/gadget/function/f_hid.c | 52 ++++++++++++++++-------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/gadget/function/f_hid.c b/drivers/usb/gadget/function/f_hid.c
index ca0a7d9eaa34..8b8bbeaa27cb 100644
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
@@ -999,21 +1005,11 @@ static int hidg_bind(struct usb_configuration *c, struct usb_function *f)
 
 	/* create char device */
 	cdev_init(&hidg->cdev, &f_hidg_fops);
-	dev = MKDEV(major, hidg->minor);
-	status = cdev_add(&hidg->cdev, dev, 1);
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
@@ -1244,9 +1240,7 @@ static void hidg_free(struct usb_function *f)
 
 	hidg = func_to_hidg(f);
 	opts = container_of(f->fi, struct f_hid_opts, func_inst);
-	kfree(hidg->report_desc);
-	kfree(hidg->set_report_buf);
-	kfree(hidg);
+	put_device(&hidg->dev);
 	mutex_lock(&opts->lock);
 	--opts->refcnt;
 	mutex_unlock(&opts->lock);
@@ -1256,8 +1250,7 @@ static void hidg_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_hidg *hidg = func_to_hidg(f);
 
-	device_destroy(hidg_class, MKDEV(major, hidg->minor));
-	cdev_del(&hidg->cdev);
+	cdev_device_del(&hidg->cdev, &hidg->dev);
 
 	usb_free_all_descriptors(f);
 }
@@ -1266,6 +1259,7 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
 {
 	struct f_hidg *hidg;
 	struct f_hid_opts *opts;
+	int ret;
 
 	/* allocate and initialize one new instance */
 	hidg = kzalloc(sizeof(*hidg), GFP_KERNEL);
@@ -1277,17 +1271,27 @@ static struct usb_function *hidg_alloc(struct usb_function_instance *fi)
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
-					    opts->report_desc_length,
-					    GFP_KERNEL);
+		hidg->report_desc = devm_kmemdup(&hidg->dev, opts->report_desc,
+						 opts->report_desc_length,
+						 GFP_KERNEL);
 		if (!hidg->report_desc) {
-			kfree(hidg);
+			put_device(&hidg->dev);
 			mutex_unlock(&opts->lock);
 			return ERR_PTR(-ENOMEM);
 		}
-- 
2.38.1

