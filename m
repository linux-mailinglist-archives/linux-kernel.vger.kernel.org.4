Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6BE6D3330
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 20:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDASio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 14:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjDASin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 14:38:43 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B4DCE7299
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 11:38:41 -0700 (PDT)
Received: (qmail 274705 invoked by uid 1000); 1 Apr 2023 14:38:40 -0400
Date:   Sat, 1 Apr 2023 14:38:39 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Greg KH <greg@kroah.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        syzbot <syzbot+4b3f8190f6e13b3efd74@syzkaller.appspotmail.com>,
        syzbot <syzbot+1cb937c125adb93fad2d@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING in shark_write_reg/usb_submit_urb, WARNING in
 shark_write_val/usb_submit_urb
Message-ID: <f764a19d-858e-408c-a5f5-d6fe7306c4cb@rowland.harvard.edu>
References: <00000000000096e4f905f81b2702@google.com>
 <e382763c-cf33-4871-a761-1ac85ae36f27@rowland.harvard.edu>
 <8896f261-9602-4663-aa87-1feb9bf3ec0f@redhat.com>
 <2023040148-aground-cornbread-84e2@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023040148-aground-cornbread-84e2@gregkh>
X-Spam-Status: No, score=0.2 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 04:53:17PM +0200, Greg KH wrote:
> On Sat, Apr 01, 2023 at 12:48:07PM +0200, Hans de Goede wrote:
> > Hi Alan,
> > 
> > On 3/30/23 22:10, Alan Stern wrote:
> > > Reference: https://syzkaller.appspot.com/bug?extid=4b3f8190f6e13b3efd74
> > > Reference: https://syzkaller.appspot.com/bug?extid=1cb937c125adb93fad2d
> > > 
> > > The radio-shark driver just assumes that the endpoints it uses will be
> > > present, without checking.  This adds an appropriate check.
> > > 
> > > Alan Stern
> > > 
> > > #syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ v6.2
> > 
> > Thank you for working on this!
> > 
> > Both the core changes and the 2 radio-shark driver changes look good to me.
> > 
> > Please add my:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > When submitting these upstream.
> > 
> > Regards,
> > 
> > Hans
> > 
> > 
> > 
> > 
> > 
> > > 
> > >  drivers/usb/core/usb.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++
> > >  include/linux/usb.h    |    7 ++++
> > >  2 files changed, 77 insertions(+)
> > > 
> > > Index: usb-devel/drivers/usb/core/usb.c
> > > ===================================================================
> > > --- usb-devel.orig/drivers/usb/core/usb.c
> > > +++ usb-devel/drivers/usb/core/usb.c
> > > @@ -207,6 +207,76 @@ int usb_find_common_endpoints_reverse(st
> > >  EXPORT_SYMBOL_GPL(usb_find_common_endpoints_reverse);
> > >  
> > >  /**
> > > + * usb_find_endpoint() - Given an endpoint address, search for the endpoint's
> > > + * usb_host_endpoint structure in an interface's current altsetting.
> > > + * @intf: the interface whose current altsetting should be searched
> > > + * @ep_addr: the endpoint address (number and direction) to find
> > > + *
> > > + * Search the altsetting's list of endpoints for one with the specified address.
> > > + *
> > > + * Return: Pointer to the usb_host_endpoint if found, %NULL otherwise.
> > > + */
> > > +struct usb_host_endpoint __must_check *usb_find_endpoint(
> > > +		const struct usb_interface *intf, unsigned int ep_addr)
> > > +{
> > > +	int n;
> > > +	struct usb_host_endpoint *ep;
> > > +
> > > +	n = intf->cur_altsetting->desc.bNumEndpoints;
> > > +	ep = intf->cur_altsetting->endpoint;
> > > +	for (; n > 0; (--n, ++ep)) {
> > > +		if (ep->desc.bEndpointAddress == ep_addr)
> > > +			return ep;
> > > +	}
> > > +	return NULL;
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_find_endpoint);
> > > +
> > > +/**
> > > + * usb_check_bulk_endpoint - Check whether an interface's current altsetting
> > > + * contains a bulk endpoint with the given address.
> > > + * @intf: the interface whose current altsetting should be searched
> > > + * @ep_addr: the endpoint address (number and direction) to look for
> > > + *
> > > + * Search for an endpoint with the specified address and check its type.
> > > + *
> > > + * Return: %true if the endpoint is found and is bulk, %false otherwise.
> > > + */
> > > +bool usb_check_bulk_endpoint(
> > > +		const struct usb_interface *intf, unsigned int ep_addr)
> > > +{
> > > +	const struct usb_host_endpoint *ep;
> > > +
> > > +	ep = usb_find_endpoint(intf, ep_addr);
> > > +	if (!ep)
> > > +		return false;
> > > +	return usb_endpoint_xfer_bulk(&ep->desc);
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_check_bulk_endpoint);
> > > +
> > > +/**
> > > + * usb_check_int_endpoint - Check whether an interface's current altsetting
> > > + * contains an interrupt endpoint with the given address.
> > > + * @intf: the interface whose current altsetting should be searched
> > > + * @ep_addr: the endpoint address (number and direction) to look for
> > > + *
> > > + * Search for an endpoint with the specified address and check its type.
> > > + *
> > > + * Return: %true if the endpoint is found and is interrupt, %false otherwise.
> > > + */
> > > +bool usb_check_int_endpoint(
> > > +		const struct usb_interface *intf, unsigned int ep_addr)
> > > +{
> > > +	const struct usb_host_endpoint *ep;
> > > +
> > > +	ep = usb_find_endpoint(intf, ep_addr);
> > > +	if (!ep)
> > > +		return false;
> > > +	return usb_endpoint_xfer_int(&ep->desc);
> > > +}
> > > +EXPORT_SYMBOL_GPL(usb_check_int_endpoint);
> 
> Shouldn't you use the usb_find_bulk_in_endpoint() and friends functions
> instead of these?  Many drivers hard-coded their "I know this endpoint
> is this type" which breaks in fuzzing as you know (and see here), which
> is why those functions were created to be used.

It's true, we could use the existing functions in this case.  I'm not sure 
which approach would be better; it's probably mostly a matter of taste.

Using the existing functions, the probe function would get additional code 
something like this:

	struct usb_endpoint_descriptor *ep;

	if (!(usb_find_int_in_endpoint(intf->cur_altsetting, &ep) == 0 &&
			usb_endpoint_num(&ep->desc) == SHARK_IN_EP) ||
	    !(usb_find_int_out_endpoint(intf->cur_altsetting, &ep) == 0 &&
			usb_endpoint_num(&ep->desc) == SHARK_OUT_EP)) {
		dev_err(...

Using the new functions (with a revised API, see the patch below) we would 
instead add this:

	static const u8 ep_addresses[] = {
		SHARK_IN_EP | USB_DIR_IN,
		SHARK_OUT_EP | USB_DIR_OUT,
		0};

	if (!usb_check_int_endpoints(intf, ep_addresses)) {
		dev_err(...

In this case the difference is not particularly meaningful.  With the new 
functions, the amount of code added to the driver is smaller, but of 
course that's offset by adding the new functions themselves to the core.  
(On the other hand there's probably a bunch of drivers that could stand 
to be fixed up this way, which would amortize the cost to the core.)

The difference becomes a lot more noticeable with the sisusbvga driver 
[1].  It has six endpoints that need to be checked: four bulk-OUT and two 
bulk-IN.  While usb_find_common_endpoints() would be able to find them, 
it's not well suited for checking that they have the expected addresses.  
With the new functions, all the work can be done with a single call.

> I think just using them in the probe function would fix this issue 
> instead of these functions which would only be used by that one driver.

It wouldn't be used just by these two drivers.  The new routines are 
ideally suited for doing the checking in old drivers that have their 
endpoint numbers and directions built-in, like these do.  While I haven't 
looked to see, there must be quite a few of them.

Alan Stern

[1] https://lore.kernel.org/linux-usb/b799fc68-8840-43e7-85f5-27e1e6457a44@rowland.harvard.edu


 drivers/usb/core/usb.c |   76 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/usb.h    |    5 +++
 2 files changed, 81 insertions(+)

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
