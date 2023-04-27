Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6296F06A9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:34:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243687AbjD0Nd7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243373AbjD0Nd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:33:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43889F9;
        Thu, 27 Apr 2023 06:33:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E51651FE17;
        Thu, 27 Apr 2023 13:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682602433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSlsn2rCSqBYTsqLNFs5IVZVQwI9t4hKlG0XoLdqEbM=;
        b=cG8jEYqUL5wSr017j5BbELR8ltGqffADlEjIabymVtICVywJkgWtsEBYQWpQ/rrvQuKDTA
        GEJGd/dm3/uIihq+NwFFJFCs6NKhjfj1TiHOLcFU1KQbWJP4I/ye88GYnDqV+5boEavFr9
        8OfNUrQqIOY3Nd/JsHsxAgHNfiHCg7M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0B8E138F9;
        Thu, 27 Apr 2023 13:33:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iBdFJcF5SmSVeQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 27 Apr 2023 13:33:53 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 1/8] pwcd_usb: fix error handling in probe
Date:   Thu, 27 Apr 2023 15:33:43 +0200
Message-Id: <20230427133350.31064-2-oneukum@suse.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230427133350.31064-1-oneukum@suse.com>
References: <20230427133350.31064-1-oneukum@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If you support only one device, you need to roll back
back your counter in all cases if probe() fails.
That cannot be left to usb_pcwd_delete() because
that must be called conditionally.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/watchdog/pcwd_usb.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 8202f0a6b093..3a22291d633b 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -606,7 +606,7 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	struct usb_endpoint_descriptor *endpoint;
 	struct usb_pcwd_private *usb_pcwd = NULL;
 	int pipe;
-	int retval = -ENOMEM;
+	int retval = -ENODEV;
 	int got_fw_rev;
 	unsigned char fw_rev_major, fw_rev_minor;
 	char fw_ver_str[20];
@@ -615,7 +615,7 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	cards_found++;
 	if (cards_found > 1) {
 		pr_err("This driver only supports 1 device\n");
-		return -ENODEV;
+		goto error_count;
 	}
 
 	/* get the active interface descriptor */
@@ -624,11 +624,12 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	/* check out that we have a HID device */
 	if (!(iface_desc->desc.bInterfaceClass == USB_CLASS_HID)) {
 		pr_err("The device isn't a Human Interface Device\n");
-		return -ENODEV;
+		goto error_count;
 	}
 
 	if (iface_desc->desc.bNumEndpoints < 1)
-		return -ENODEV;
+		goto error_count;
+	
 
 	/* check out the endpoint: it has to be Interrupt & IN */
 	endpoint = &iface_desc->endpoint[0].desc;
@@ -636,16 +637,17 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	if (!usb_endpoint_is_int_in(endpoint)) {
 		/* we didn't find a Interrupt endpoint with direction IN */
 		pr_err("Couldn't find an INTR & IN endpoint\n");
-		return -ENODEV;
+		goto error_count;
 	}
 
 	/* get a handle to the interrupt data pipe */
 	pipe = usb_rcvintpipe(udev, endpoint->bEndpointAddress);
 
 	/* allocate memory for our device and initialize it */
+	retval = -ENOMEM;
 	usb_pcwd = kzalloc(sizeof(struct usb_pcwd_private), GFP_KERNEL);
 	if (usb_pcwd == NULL)
-		goto error;
+		goto error_count;
 
 	usb_pcwd_device = usb_pcwd;
 
@@ -661,13 +663,13 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 					GFP_KERNEL, &usb_pcwd->intr_dma);
 	if (!usb_pcwd->intr_buffer) {
 		pr_err("Out of memory\n");
-		goto error;
+		goto error_delete;
 	}
 
 	/* allocate the urb's */
 	usb_pcwd->intr_urb = usb_alloc_urb(0, GFP_KERNEL);
 	if (!usb_pcwd->intr_urb)
-		goto error;
+		goto error_delete;
 
 	/* initialise the intr urb's */
 	usb_fill_int_urb(usb_pcwd->intr_urb, udev, pipe,
@@ -680,7 +682,7 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	if (usb_submit_urb(usb_pcwd->intr_urb, GFP_KERNEL)) {
 		pr_err("Problem registering interrupt URB\n");
 		retval = -EIO; /* failure */
-		goto error;
+		goto error_delete;
 	}
 
 	/* The device exists and can be communicated with */
@@ -723,7 +725,7 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	retval = register_reboot_notifier(&usb_pcwd_notifier);
 	if (retval != 0) {
 		pr_err("cannot register reboot notifier (err=%d)\n", retval);
-		goto error;
+		goto error_delete;
 	}
 
 	retval = misc_register(&usb_pcwd_temperature_miscdev);
@@ -752,10 +754,12 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	misc_deregister(&usb_pcwd_temperature_miscdev);
 err_out_unregister_reboot:
 	unregister_reboot_notifier(&usb_pcwd_notifier);
-error:
+error_delete:
 	if (usb_pcwd)
 		usb_pcwd_delete(usb_pcwd);
 	usb_pcwd_device = NULL;
+error_count:
+	cards_found--;
 	return retval;
 }
 
-- 
2.40.0

