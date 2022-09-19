Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDB35BCD16
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiISNZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiISNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:25:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40342CE0C;
        Mon, 19 Sep 2022 06:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BF5FB81AE8;
        Mon, 19 Sep 2022 13:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22B8EC433D6;
        Mon, 19 Sep 2022 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663593926;
        bh=BGhrQD7LEio4Kzy/pFpU7z6uraCfbjuQ8M4hk6gm7kY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m/ge5JnI9Za+mApsbGZjOYiNxGuPzMaNK9x7zigNnuawK+GG7x3j2YVsxXP4bXoN8
         4hkWvjFmJyBpIsa+bytJb46UEjPMfd34GZ8K773UlysZBy9sbmTgSQwqOf8JKemA5L
         W3wxagytkIyG57jOLptQ87ev/Lg4xYtetLlCw+pBEJ5AYA7YFY9yRpTrwIvOGtNNbh
         SYgI0bHaMHl0I/lb0F4EYa6ctGJCgOFsSM5HWgmNqBX6hAbm21sfr9lgNYy4lLBM8F
         FR5hEztjXh27NaTV6f/3jA9B4cUC5futvJpOHgLx0Wute7K6FK1233ZnAMsJBVshaE
         NaG9tW8uB++NQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaGmB-0005RA-7V; Mon, 19 Sep 2022 15:25:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] USB: serial: ftdi_sio: clean up driver prefix
Date:   Mon, 19 Sep 2022 15:24:56 +0200
Message-Id: <20220919132456.20851-4-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220919132456.20851-1-johan@kernel.org>
References: <20220919132456.20851-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop the "sio" infix from the few remaining definitions and symbol names
that still had it.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 38 ++++++++++++++++-------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index cd594937b0e6..f584ce29fc9f 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -100,8 +100,7 @@ struct ftdi_private {
 #endif
 };
 
-/* struct ftdi_sio_quirk is used by devices requiring special attention. */
-struct ftdi_sio_quirk {
+struct ftdi_quirk {
 	int (*probe)(struct usb_serial *);
 	/* Special settings for probed ports. */
 	void (*port_probe)(struct ftdi_private *);
@@ -114,27 +113,27 @@ static int   ftdi_8u2232c_probe(struct usb_serial *serial);
 static void  ftdi_USB_UIRT_setup(struct ftdi_private *priv);
 static void  ftdi_HE_TIRA1_setup(struct ftdi_private *priv);
 
-static const struct ftdi_sio_quirk ftdi_jtag_quirk = {
+static const struct ftdi_quirk ftdi_jtag_quirk = {
 	.probe	= ftdi_jtag_probe,
 };
 
-static const struct ftdi_sio_quirk ftdi_NDI_device_quirk = {
+static const struct ftdi_quirk ftdi_NDI_device_quirk = {
 	.probe	= ftdi_NDI_device_setup,
 };
 
-static const struct ftdi_sio_quirk ftdi_USB_UIRT_quirk = {
+static const struct ftdi_quirk ftdi_USB_UIRT_quirk = {
 	.port_probe = ftdi_USB_UIRT_setup,
 };
 
-static const struct ftdi_sio_quirk ftdi_HE_TIRA1_quirk = {
+static const struct ftdi_quirk ftdi_HE_TIRA1_quirk = {
 	.port_probe = ftdi_HE_TIRA1_setup,
 };
 
-static const struct ftdi_sio_quirk ftdi_stmclite_quirk = {
+static const struct ftdi_quirk ftdi_stmclite_quirk = {
 	.probe	= ftdi_stmclite_probe,
 };
 
-static const struct ftdi_sio_quirk ftdi_8u2232c_quirk = {
+static const struct ftdi_quirk ftdi_8u2232c_quirk = {
 	.probe	= ftdi_8u2232c_probe,
 };
 
@@ -2170,12 +2169,9 @@ static void ftdi_gpio_remove(struct usb_serial_port *port) { }
  * ***************************************************************************
  */
 
-/* Probe function to check for special devices */
-static int ftdi_sio_probe(struct usb_serial *serial,
-					const struct usb_device_id *id)
+static int ftdi_probe(struct usb_serial *serial, const struct usb_device_id *id)
 {
-	const struct ftdi_sio_quirk *quirk =
-				(struct ftdi_sio_quirk *)id->driver_info;
+	const struct ftdi_quirk *quirk = (struct ftdi_quirk *)id->driver_info;
 
 	if (quirk && quirk->probe) {
 		int ret = quirk->probe(serial);
@@ -2188,10 +2184,10 @@ static int ftdi_sio_probe(struct usb_serial *serial,
 	return 0;
 }
 
-static int ftdi_sio_port_probe(struct usb_serial_port *port)
+static int ftdi_port_probe(struct usb_serial_port *port)
 {
+	const struct ftdi_quirk *quirk = usb_get_serial_data(port->serial);
 	struct ftdi_private *priv;
-	const struct ftdi_sio_quirk *quirk = usb_get_serial_data(port->serial);
 	int result;
 
 	priv = kzalloc(sizeof(struct ftdi_private), GFP_KERNEL);
@@ -2337,7 +2333,7 @@ static int ftdi_stmclite_probe(struct usb_serial *serial)
 	return 0;
 }
 
-static void ftdi_sio_port_remove(struct usb_serial_port *port)
+static void ftdi_port_remove(struct usb_serial_port *port)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
@@ -2865,7 +2861,7 @@ static int ftdi_ioctl(struct tty_struct *tty,
 	return -ENOIOCTLCMD;
 }
 
-static struct usb_serial_driver ftdi_sio_device = {
+static struct usb_serial_driver ftdi_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
 		.name =		"ftdi_sio",
@@ -2876,9 +2872,9 @@ static struct usb_serial_driver ftdi_sio_device = {
 	.num_ports =		1,
 	.bulk_in_size =		512,
 	.bulk_out_size =	256,
-	.probe =		ftdi_sio_probe,
-	.port_probe =		ftdi_sio_port_probe,
-	.port_remove =		ftdi_sio_port_remove,
+	.probe =		ftdi_probe,
+	.port_probe =		ftdi_port_probe,
+	.port_remove =		ftdi_port_remove,
 	.open =			ftdi_open,
 	.dtr_rts =		ftdi_dtr_rts,
 	.throttle =		usb_serial_generic_throttle,
@@ -2898,7 +2894,7 @@ static struct usb_serial_driver ftdi_sio_device = {
 };
 
 static struct usb_serial_driver * const serial_drivers[] = {
-	&ftdi_sio_device, NULL
+	&ftdi_device, NULL
 };
 module_usb_serial_driver(serial_drivers, id_table_combined);
 
-- 
2.35.1

