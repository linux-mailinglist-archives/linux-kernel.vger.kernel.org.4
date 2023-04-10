Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73816DC915
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 18:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjDJQJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 12:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDJQJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 12:09:35 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 64D84171D
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 09:09:32 -0700 (PDT)
Received: (qmail 139685 invoked by uid 1000); 10 Apr 2023 12:09:31 -0400
Date:   Mon, 10 Apr 2023 12:09:31 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     syzbot <syzbot+23be03b56c5259385d79@syzkaller.appspotmail.com>,
        Thomas Winischhofer <thomas@winischhofer.net>
Cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in sisusb_send_bulk_msg/usb_submit_urb
Message-ID: <1d74e8db-682e-4d9a-af69-3ec56835021e@rowland.harvard.edu>
References: <00000000000096e4f905f81b2702@google.com>
 <b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch has been revised.  Make sure it still works right.

Alan Stern

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.2

Index: usb-devel/drivers/usb/core/usb.c
===================================================================
--- usb-devel.orig/drivers/usb/core/usb.c
+++ usb-devel/drivers/usb/core/usb.c
@@ -207,6 +207,82 @@ int usb_find_common_endpoints_reverse(st
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
+static const struct usb_host_endpoint *usb_find_endpoint(
+		const struct usb_interface *intf, unsigned int ep_addr)
+{
+	int n;
+	const struct usb_host_endpoint *ep;
+
+	n = intf->cur_altsetting->desc.bNumEndpoints;
+	ep = intf->cur_altsetting->endpoint;
+	for (; n > 0; (--n, ++ep)) {
+		if (ep->desc.bEndpointAddress == ep_addr)
+			return ep;
+	}
+	return NULL;
+}
+
+/**
+ * usb_check_bulk_endpoints - Check whether an interface's current altsetting
+ * contains a set of bulk endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are bulk, %false otherwise.
+ */
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_bulk(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_bulk_endpoints);
+
+/**
+ * usb_check_int_endpoints - Check whether an interface's current altsetting
+ * contains a set of interrupt endpoints with the given addresses.
+ * @intf: the interface whose current altsetting should be searched
+ * @ep_addrs: 0-terminated array of the endpoint addresses (number and
+ * direction) to look for
+ *
+ * Search for endpoints with the specified addresses and check their types.
+ *
+ * Return: %true if all the endpoints are found and are interrupt,
+ * %false otherwise.
+ */
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs)
+{
+	const struct usb_host_endpoint *ep;
+
+	for (; *ep_addrs; ++ep_addrs) {
+		ep = usb_find_endpoint(intf, *ep_addrs);
+		if (!ep || !usb_endpoint_xfer_int(&ep->desc))
+			return false;
+	}
+	return true;
+}
+EXPORT_SYMBOL_GPL(usb_check_int_endpoints);
+
+/**
  * usb_find_alt_setting() - Given a configuration, find the alternate setting
  * for the given interface.
  * @config: the configuration to search (not necessarily the current config).
Index: usb-devel/include/linux/usb.h
===================================================================
--- usb-devel.orig/include/linux/usb.h
+++ usb-devel/include/linux/usb.h
@@ -292,6 +292,11 @@ void usb_put_intf(struct usb_interface *
 #define USB_MAXINTERFACES	32
 #define USB_MAXIADS		(USB_MAXINTERFACES/2)
 
+bool usb_check_bulk_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+bool usb_check_int_endpoints(
+		const struct usb_interface *intf, const u8 *ep_addrs);
+
 /*
  * USB Resume Timer: Every Host controller driver should drive the resume
  * signalling on the bus for the amount of time defined by this macro.

Index: usb-devel/drivers/usb/misc/sisusbvga/sisusbvga.c
===================================================================
--- usb-devel.orig/drivers/usb/misc/sisusbvga/sisusbvga.c
+++ usb-devel/drivers/usb/misc/sisusbvga/sisusbvga.c
@@ -2778,6 +2778,20 @@ static int sisusb_probe(struct usb_inter
 	struct usb_device *dev = interface_to_usbdev(intf);
 	struct sisusb_usb_data *sisusb;
 	int retval = 0, i;
+	static const u8 ep_addresses[] = {
+		SISUSB_EP_GFX_IN | USB_DIR_IN,
+		SISUSB_EP_GFX_OUT | USB_DIR_OUT,
+		SISUSB_EP_GFX_BULK_OUT | USB_DIR_OUT,
+		SISUSB_EP_GFX_LBULK_OUT | USB_DIR_OUT,
+		SISUSB_EP_BRIDGE_IN | USB_DIR_IN,
+		SISUSB_EP_BRIDGE_OUT | USB_DIR_OUT,
+		0};
+
+	/* Are the expected endpoints present? */
+	if (!usb_check_bulk_endpoints(intf, ep_addresses)) {
+		dev_err(&intf->dev, "Invalid USB2VGA device\n");
+		return -EINVAL;
+	}
 
 	dev_info(&dev->dev, "USB2VGA dongle found at address %d\n",
 			dev->devnum);
