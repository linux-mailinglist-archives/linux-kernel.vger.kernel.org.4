Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654E25BCD0F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiISNZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiISNZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:25:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40842D10F;
        Mon, 19 Sep 2022 06:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71312B81BD9;
        Mon, 19 Sep 2022 13:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 256DAC433C1;
        Mon, 19 Sep 2022 13:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663593926;
        bh=YaeRxWbt+/MWcq8tF2wVcj1FK8OAKg3UKPDh2LMI0H8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGDaRJJbV5AY9AJdcBpa5yc4VlrZD3NtG4Na7iZu/uG9K6jI8438B9TjZi9Qi3IIa
         IVmiU4yxKVKdrT5ISZ3ZJejM1CReitaxL+KbyKFPekdUwO8IKKfHdwHtWmcyQ6L6F4
         qRjU2wWzdpj6CuDj6mwP9DFgqO9B4Xq4yOgixiUntCTgRXyh2HV+sSsUyokmMD/3d/
         aXbXCjExPzEn8yIuKoGN0ImIyBbfPU9MBGIs6isB6qW0RGhm27HlKxzdMz6Z7b1fJN
         4XnSXUgtSJ64RqH3tgdxGC2fuLftkDwZLFbA79jrsK8JegLOn0/2VkqRp22TxahObe
         Pv8o6KCrvuDzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaGmB-0005R7-50; Mon, 19 Sep 2022 15:25:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] USB: serial: ftdi_sio: move driver structure
Date:   Mon, 19 Sep 2022 15:24:55 +0200
Message-Id: <20220919132456.20851-3-johan@kernel.org>
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

Move the definition of the USB serial driver structure to the end of the
file where it is used and drop the now redundant forward declarations.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 101 ++++++++++++----------------------
 1 file changed, 35 insertions(+), 66 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index a5fc199cde0b..cd594937b0e6 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1108,77 +1108,11 @@ static const char *ftdi_chip_name[] = {
 #define FTDI_STATUS_B1_MASK	(FTDI_RS_BI)
 /* End TIOCMIWAIT */
 
-/* function prototypes for a FTDI serial converter */
-static int  ftdi_sio_probe(struct usb_serial *serial,
-					const struct usb_device_id *id);
-static int  ftdi_sio_port_probe(struct usb_serial_port *port);
-static void ftdi_sio_port_remove(struct usb_serial_port *port);
-static int  ftdi_open(struct tty_struct *tty, struct usb_serial_port *port);
-static void ftdi_dtr_rts(struct usb_serial_port *port, int on);
-static void ftdi_process_read_urb(struct urb *urb);
-static int ftdi_prepare_write_buffer(struct usb_serial_port *port,
-						void *dest, size_t size);
 static void ftdi_set_termios(struct tty_struct *tty,
 			struct usb_serial_port *port, struct ktermios *old);
-static int  ftdi_tiocmget(struct tty_struct *tty);
-static int  ftdi_tiocmset(struct tty_struct *tty,
-			unsigned int set, unsigned int clear);
-static int  ftdi_ioctl(struct tty_struct *tty,
-			unsigned int cmd, unsigned long arg);
-static void get_serial_info(struct tty_struct *tty, struct serial_struct *ss);
-static int set_serial_info(struct tty_struct *tty,
-				struct serial_struct *ss);
-static void ftdi_break_ctl(struct tty_struct *tty, int break_state);
-static bool ftdi_tx_empty(struct usb_serial_port *port);
 static int ftdi_get_modem_status(struct usb_serial_port *port,
 						unsigned char status[2]);
 
-static unsigned short int ftdi_232am_baud_base_to_divisor(int baud, int base);
-static unsigned short int ftdi_232am_baud_to_divisor(int baud);
-static u32 ftdi_232bm_baud_base_to_divisor(int baud, int base);
-static u32 ftdi_232bm_baud_to_divisor(int baud);
-static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
-static u32 ftdi_2232h_baud_to_divisor(int baud);
-
-static const struct attribute_group *ftdi_groups[];
-
-static struct usb_serial_driver ftdi_sio_device = {
-	.driver = {
-		.owner =	THIS_MODULE,
-		.name =		"ftdi_sio",
-		.dev_groups =	ftdi_groups,
-	},
-	.description =		"FTDI USB Serial Device",
-	.id_table =		id_table_combined,
-	.num_ports =		1,
-	.bulk_in_size =		512,
-	.bulk_out_size =	256,
-	.probe =		ftdi_sio_probe,
-	.port_probe =		ftdi_sio_port_probe,
-	.port_remove =		ftdi_sio_port_remove,
-	.open =			ftdi_open,
-	.dtr_rts =		ftdi_dtr_rts,
-	.throttle =		usb_serial_generic_throttle,
-	.unthrottle =		usb_serial_generic_unthrottle,
-	.process_read_urb =	ftdi_process_read_urb,
-	.prepare_write_buffer =	ftdi_prepare_write_buffer,
-	.tiocmget =		ftdi_tiocmget,
-	.tiocmset =		ftdi_tiocmset,
-	.tiocmiwait =		usb_serial_generic_tiocmiwait,
-	.get_icount =           usb_serial_generic_get_icount,
-	.ioctl =		ftdi_ioctl,
-	.get_serial =		get_serial_info,
-	.set_serial =		set_serial_info,
-	.set_termios =		ftdi_set_termios,
-	.break_ctl =		ftdi_break_ctl,
-	.tx_empty =		ftdi_tx_empty,
-};
-
-static struct usb_serial_driver * const serial_drivers[] = {
-	&ftdi_sio_device, NULL
-};
-
-
 #define WDR_TIMEOUT 5000 /* default urb timeout */
 #define WDR_SHORT_TIMEOUT 1000	/* shorter urb timeout */
 
@@ -2931,6 +2865,41 @@ static int ftdi_ioctl(struct tty_struct *tty,
 	return -ENOIOCTLCMD;
 }
 
+static struct usb_serial_driver ftdi_sio_device = {
+	.driver = {
+		.owner =	THIS_MODULE,
+		.name =		"ftdi_sio",
+		.dev_groups =	ftdi_groups,
+	},
+	.description =		"FTDI USB Serial Device",
+	.id_table =		id_table_combined,
+	.num_ports =		1,
+	.bulk_in_size =		512,
+	.bulk_out_size =	256,
+	.probe =		ftdi_sio_probe,
+	.port_probe =		ftdi_sio_port_probe,
+	.port_remove =		ftdi_sio_port_remove,
+	.open =			ftdi_open,
+	.dtr_rts =		ftdi_dtr_rts,
+	.throttle =		usb_serial_generic_throttle,
+	.unthrottle =		usb_serial_generic_unthrottle,
+	.process_read_urb =	ftdi_process_read_urb,
+	.prepare_write_buffer =	ftdi_prepare_write_buffer,
+	.tiocmget =		ftdi_tiocmget,
+	.tiocmset =		ftdi_tiocmset,
+	.tiocmiwait =		usb_serial_generic_tiocmiwait,
+	.get_icount =           usb_serial_generic_get_icount,
+	.ioctl =		ftdi_ioctl,
+	.get_serial =		get_serial_info,
+	.set_serial =		set_serial_info,
+	.set_termios =		ftdi_set_termios,
+	.break_ctl =		ftdi_break_ctl,
+	.tx_empty =		ftdi_tx_empty,
+};
+
+static struct usb_serial_driver * const serial_drivers[] = {
+	&ftdi_sio_device, NULL
+};
 module_usb_serial_driver(serial_drivers, id_table_combined);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
2.35.1

