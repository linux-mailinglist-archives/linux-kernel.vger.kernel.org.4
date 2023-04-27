Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7FA6F06B7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 15:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243218AbjD0NeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 09:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243664AbjD0Nd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 09:33:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93ACC5;
        Thu, 27 Apr 2023 06:33:57 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4757E1FE35;
        Thu, 27 Apr 2023 13:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682602436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKRJAQs2Ndqm7IzSMR+A7rxBU8QW8BdAdffC5PULh3w=;
        b=XloF75KsTh3J3orK1J0Om5HGNjp5OUXB5yz7v1zQNFL0Sa5F95PKX5D82vj3eIk0i60ABc
        7Wpeb3xUf4nblskvjF0LGbrnvvwwRIjM5voi2GpV2VOGeuGG4/2z5UJuX74xa1w5tecqOc
        JYSSU/85rftkl1xoTHxkI3YsbqcLeKU=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 01B3E138F9;
        Thu, 27 Apr 2023 13:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mAUPOsN5SmSVeQAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 27 Apr 2023 13:33:55 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [PATCH 8/8] usb_pcwd: remove superfluous usb_device pointer
Date:   Thu, 27 Apr 2023 15:33:50 +0200
Message-Id: <20230427133350.31064-9-oneukum@suse.com>
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

Retrieve the device from the interface

Signed-off-by: Oliver Neukum <oneukum@suse.com>
---
 drivers/watchdog/pcwd_usb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
index 09cae7a6ad07..055acc191af9 100644
--- a/drivers/watchdog/pcwd_usb.c
+++ b/drivers/watchdog/pcwd_usb.c
@@ -112,8 +112,6 @@ static char expect_release;
 
 /* Structure to hold all of our device specific stuff */
 struct usb_pcwd_private {
-	/* save off the usb device pointer */
-	struct usb_device	*udev;
 	/* the interface for this device */
 	struct usb_interface	*interface;
 
@@ -210,6 +208,7 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 {
 	int got_response, count;
 	unsigned char *buf;
+	struct usb_device *udev = interface_to_usbdev(usb_pcwd->interface);
 
 	/* We will not send any commands if the USB PCWD device does
 	 * not exist */
@@ -233,7 +232,7 @@ static int usb_pcwd_send_command(struct usb_pcwd_private *usb_pcwd,
 
 	atomic_set(&usb_pcwd->cmd_received, 0);
 
-	if (usb_control_msg(usb_pcwd->udev, usb_sndctrlpipe(usb_pcwd->udev, 0),
+	if (usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 			HID_REQ_SET_REPORT, HID_DT_REPORT,
 			0x0200, usb_pcwd->interface_number, buf, 6,
 			USB_COMMAND_TIMEOUT) != 6) {
@@ -625,8 +624,10 @@ static struct notifier_block usb_pcwd_notifier = {
  */
 static inline void usb_pcwd_delete(struct usb_pcwd_private *usb_pcwd)
 {
+	struct usb_device *udev = interface_to_usbdev(usb_pcwd->interface);
+
 	usb_free_urb(usb_pcwd->intr_urb);
-	usb_free_coherent(usb_pcwd->udev, usb_pcwd->intr_size,
+	usb_free_coherent(udev, usb_pcwd->intr_size,
 			  usb_pcwd->intr_buffer, usb_pcwd->intr_dma);
 	kfree(usb_pcwd);
 }
@@ -691,7 +692,6 @@ static int usb_pcwd_probe(struct usb_interface *interface,
 	usb_pcwd_device = usb_pcwd;
 
 	mutex_init(&usb_pcwd->mtx);
-	usb_pcwd->udev = udev;
 	usb_pcwd->interface = interface;
 	usb_pcwd->interface_number = iface_desc->desc.bInterfaceNumber;
 	usb_pcwd->intr_size = (le16_to_cpu(endpoint->wMaxPacketSize) > 8 ?
-- 
2.40.0

