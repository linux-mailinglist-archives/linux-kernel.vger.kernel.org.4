Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9103160FB80
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236459AbiJ0PKw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:10:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiJ0PJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:09:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71D418F90F;
        Thu, 27 Oct 2022 08:09:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82469623A9;
        Thu, 27 Oct 2022 15:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98B0C433D6;
        Thu, 27 Oct 2022 15:09:13 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oo4Vd-00Bvcm-0V;
        Thu, 27 Oct 2022 11:09:29 -0400
Message-ID: <20221027150928.983388020@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 27 Oct 2022 11:05:45 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-usb@vger.kernel.org
Subject: [RFC][PATCH v2 20/31] timers: usb: Use del_timer_shutdown() before freeing timer
References: <20221027150525.753064657@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Before a timer is freed, del_timer_shutdown() must be called.

Link: https://lore.kernel.org/all/20220407161745.7d6754b3@gandalf.local.home/

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@kernel.org>
Cc: Johan Hovold <johan@kernel.org>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Matthias Kaehlcke <mka@chromium.org>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-usb@vger.kernel.org
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 drivers/usb/core/hub.c              | 3 +++
 drivers/usb/gadget/udc/m66592-udc.c | 2 +-
 drivers/usb/serial/garmin_gps.c     | 2 +-
 drivers/usb/serial/mos7840.c        | 2 +-
 4 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index bbab424b0d55..397f263ab7da 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -1261,6 +1261,9 @@ static void hub_activate(struct usb_hub *hub, enum hub_activation_type type)
 
 		/* Don't do a long sleep inside a workqueue routine */
 		if (type == HUB_INIT2) {
+			/* Timers must be shutdown before they are re-initialized */
+			if (hub->init_work.work.func)
+				del_timer_shutdown(&hub->init_work.timer);
 			INIT_DELAYED_WORK(&hub->init_work, hub_init_func3);
 			queue_delayed_work(system_power_efficient_wq,
 					&hub->init_work,
diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index 931e6362a13d..a6e2f8358adf 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -1519,7 +1519,7 @@ static int m66592_remove(struct platform_device *pdev)
 
 	usb_del_gadget_udc(&m66592->gadget);
 
-	del_timer_sync(&m66592->timer);
+	del_timer_shutdown(&m66592->timer);
 	iounmap(m66592->reg);
 	free_irq(platform_get_irq(pdev, 0), m66592);
 	m66592_free_request(&m66592->ep[0].ep, m66592->ep0_req);
diff --git a/drivers/usb/serial/garmin_gps.c b/drivers/usb/serial/garmin_gps.c
index f1a8d8343623..2a53f26468bd 100644
--- a/drivers/usb/serial/garmin_gps.c
+++ b/drivers/usb/serial/garmin_gps.c
@@ -1405,7 +1405,7 @@ static void garmin_port_remove(struct usb_serial_port *port)
 
 	usb_kill_anchored_urbs(&garmin_data_p->write_urbs);
 	usb_kill_urb(port->interrupt_in_urb);
-	del_timer_sync(&garmin_data_p->timer);
+	del_timer_shutdown(&garmin_data_p->timer);
 	kfree(garmin_data_p);
 }
 
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 6b12bb4648b8..a90a706d27de 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -1726,7 +1726,7 @@ static void mos7840_port_remove(struct usb_serial_port *port)
 		mos7840_set_led_sync(port, MODEM_CONTROL_REGISTER, 0x0300);
 
 		del_timer_sync(&mos7840_port->led_timer1);
-		del_timer_sync(&mos7840_port->led_timer2);
+		del_timer_shutdown(&mos7840_port->led_timer2);
 
 		usb_kill_urb(mos7840_port->led_urb);
 		usb_free_urb(mos7840_port->led_urb);
-- 
2.35.1
