Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610EF6D0FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjC3ULD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjC3ULB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:11:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 560459EF3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:11:00 -0700 (PDT)
Received: (qmail 212186 invoked by uid 1000); 30 Mar 2023 16:10:59 -0400
Date:   Thu, 30 Mar 2023 16:10:59 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com>,
        syzbot <syzbot+1cb937c125adb93fad2d@syzkaller.appspotmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in shark_write_reg/usb_submit_urb, WARNING in
 shark_write_val/usb_submit_urb
Message-ID: <e382763c-cf33-4871-a761-1ac85ae36f27@rowland.harvard.edu>
References: <00000000000096e4f905f81b2702@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000096e4f905f81b2702@google.com>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reference: https://syzkaller.appspot.com/bug?extid=4b3f8190f6e13b3efd74
Reference: https://syzkaller.appspot.com/bug?extid=1cb937c125adb93fad2d

The radio-shark driver just assumes that the endpoints it uses will be
present, without checking.  This adds an appropriate check.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.2

 drivers/usb/core/usb.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h    |    7 ++++
 2 files changed, 77 insertions(+)

Index: usb-devel/drivers/usb/core/usb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/usb.c
+++ usb-devel/drivers/usb/core/usb.c
@@ -207,6 +207,76 @@ int usb_find_common_endpoints_reverse(st
 EXPORT_SYMBOL_GPL(usb_find_common_endpoints_reverse);
 
 /**
+ * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
+ * usb_host_endpoint structure in an interface's current altsetting.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addr: the endpoint address (number and direction) to find
+ *
+ * Search the altsetting's list of endpoints for one with the specified address.
+ *
+ * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
+ */
+struct usb_host_endpoint __must_check *usb_find_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr)
+{
+	int n;
+	struct usb_host_endpoint *ep;
+
+	n = intf->cur_altsetting->desc.bNumEndpoints;
+	ep = intf->cur_altsetting->endpoint;
+	for (; n > 0; (--n, ++ep)) {
+		if (ep->desc.bEndpointAddress == ep_addr)
+			return ep;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(usb_find_endpoint);
+
+/**
+ * usb_check_bulk_endpoint - Check whether an interface's current altsetting
+ * contains a bulk endpoint with the given address.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addr: the endpoint address (number and direction) to look for
+ *
+ * Search for an endpoint with the specified address and check its type.
+ *
+ * Return: %true if the endpoint is found and is bulk, %false otherwise.
+ */
+bool usb_check_bulk_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr)
+{
+	const struct usb_host_endpoint *ep;
+
+	ep = usb_find_endpoint(intf, ep_addr);
+	if (!ep)
+		return false;
+	return usb_endpoint_xfer_bulk(&ep->desc);
+}
+EXPORT_SYMBOL_GPL(usb_check_bulk_endpoint);
+
+/**
+ * usb_check_int_endpoint - Check whether an interface's current altsetting
+ * contains an interrupt endpoint with the given address.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addr: the endpoint address (number and direction) to look for
+ *
+ * Search for an endpoint with the specified address and check its type.
+ *
+ * Return: %true if the endpoint is found and is interrupt, %false otherwise.
+ */
+bool usb_check_int_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr)
+{
+	const struct usb_host_endpoint *ep;
+
+	ep = usb_find_endpoint(intf, ep_addr);
+	if (!ep)
+		return false;
+	return usb_endpoint_xfer_int(&ep->desc);
+}
+EXPORT_SYMBOL_GPL(usb_check_int_endpoint);
+
+/**
  * usb_find_alt_setting() - Given a configuration, find the alternate setting
  * for the given interface.
  * @config: the configuration to search (not necessarily the current config).
Index: usb-devel/include/linux/usb.h
===================================================================
--- usb-devel.orig/include/linux/usb.h
+++ usb-devel/include/linux/usb.h
@@ -292,6 +292,13 @@ void usb_put_intf(struct usb_interface *
 #define USB_MAXINTERFACES	32
 #define USB_MAXIADS		(USB_MAXINTERFACES/2)
 
+struct usb_host_endpoint __must_check *usb_find_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr);
+bool usb_check_bulk_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr);
+bool usb_check_int_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr);
+
 /*
  * USB Resume Timer: Every Host controller driver should drive the resume
  * signalling on the bus for the amount of time defined by this macro.

 drivers/media/radio/radio-shark.c  |    7 +++++++
 drivers/media/radio/radio-shark2.c |    7 +++++++
 2 files changed, 14 insertions(+)

Index: usb-devel/drivers/media/radio/radio-shark.c
===================================================================
--- usb-devel.orig/drivers/media/radio/radio-shark.c
+++ usb-devel/drivers/media/radio/radio-shark.c
@@ -317,6 +317,13 @@ static int usb_shark_probe(struct usb_in
 	struct shark_device *shark;
 	int retval = -ENOMEM;
 
+	/* Are the expected endpoints present? */
+	if (!usb_check_int_endpoint(intf, SHARK_IN_EP | USB_DIR_IN) ||
+	    !usb_check_int_endpoint(intf, SHARK_OUT_EP | USB_DIR_OUT)) {
+		dev_err(&intf->dev, "Invalid radioSHARK device\n");
+		return -EINVAL;
+	}
+
 	shark = kzalloc(sizeof(struct shark_device), GFP_KERNEL);
 	if (!shark)
 		return retval;
Index: usb-devel/drivers/media/radio/radio-shark2.c
===================================================================
--- usb-devel.orig/drivers/media/radio/radio-shark2.c
+++ usb-devel/drivers/media/radio/radio-shark2.c
@@ -283,6 +283,13 @@ static int usb_shark_probe(struct usb_in
 	struct shark_device *shark;
 	int retval = -ENOMEM;
 
+	/* Are the expected endpoints present? */
+	if (!usb_check_int_endpoint(intf, SHARK_IN_EP | USB_DIR_IN) ||
+	    !usb_check_int_endpoint(intf, SHARK_OUT_EP | USB_DIR_OUT)) {
+		dev_err(&intf->dev, "Invalid radioSHARK2 device\n");
+		return -EINVAL;
+	}
+
 	shark = kzalloc(sizeof(struct shark_device), GFP_KERNEL);
 	if (!shark)
 		return retval;
