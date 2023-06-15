Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336527315A0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241477AbjFOKls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239559AbjFOKlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:41:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74982212A;
        Thu, 15 Jun 2023 03:41:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1AE8F223DA;
        Thu, 15 Jun 2023 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1686825701; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=duw8QmuBgzcSbjYtb0yXY2qJWjr1+hj1UoSa9ab2Vas=;
        b=ey10ShFkYtny+B2cFcpRjjIo+eHZeBYtILW+b+FR/PCn35pl3N7hqm9bU6++fK01omozGt
        ergXX6sirnFIWMIqcenY3rQaFo8xojMkUMLDFoX5yTykneGvxmyCnm34AHNBNTamaty1A8
        Qfp6Cc4MCfdMonRDjdxkJQNgAhb4TF4=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D3C7013A63;
        Thu, 15 Jun 2023 10:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yDHpMOTqimQleAAAMHmgww
        (envelope-from <oneukum@suse.com>); Thu, 15 Jun 2023 10:41:40 +0000
From:   Oliver Neukum <oneukum@suse.com>
To:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Oliver Neukum <oneukum@suse.com>
Subject: [RFT] Prototype of new watchdog
Date:   Thu, 15 Jun 2023 12:40:20 +0200
Message-ID: <20230615104137.20304-2-oneukum@suse.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230615104137.20304-1-oneukum@suse.com>
References: <20230615104137.20304-1-oneukum@suse.com>
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

---
 drivers/watchdog/Kconfig         |  16 ++
 drivers/watchdog/Makefile        |   1 +
 drivers/watchdog/pcwd_usb_nova.c | 425 +++++++++++++++++++++++++++++++
 3 files changed, 442 insertions(+)
 create mode 100644 drivers/watchdog/pcwd_usb_nova.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f22138709bf5..f7999fb7caaa 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -2210,6 +2210,22 @@ config USBPCWATCHDOG
 
 	  Most people will say N.
 
+config USBPCWATCHDOGNOVA
+        tristate "Berkshire Products USB-PC Watchdog (new driver)"
+        depends on USB
+        help
+          This is the driver for the Berkshire Products USB-PC Watchdog card.
+          This card simply watches your kernel to make sure it doesn't freeze,
+          and if it does, it reboots your computer after a certain amount of
+          time. The card can also monitor the internal temperature of the PC.
+          More info is available at <http://www.berkprod.com/usb_pc_watchdog.htm>.
+        
+          To compile this driver as a module, choose M here: the
+          module will be called pcwd_usb_nova.
+          
+          Most people will say N.
+
+
 config KEEMBAY_WATCHDOG
 	tristate "Intel Keem Bay SoC non-secure watchdog"
 	depends on ARCH_KEEMBAY || (ARM64 && COMPILE_TEST)
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index b4c4ccf2d703..8364e0184424 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_WDTPCI) += wdt_pci.o
 
 # USB-based Watchdog Cards
 obj-$(CONFIG_USBPCWATCHDOG) += pcwd_usb.o
+obj-$(CONFIG_USBPCWATCHDOGNOVA) += pcwd_usb_nova.o
 
 # ALPHA Architecture
 
diff --git a/drivers/watchdog/pcwd_usb_nova.c b/drivers/watchdog/pcwd_usb_nova.c
new file mode 100644
index 000000000000..8a92ba8776ae
--- /dev/null
+++ b/drivers/watchdog/pcwd_usb_nova.c
@@ -0,0 +1,425 @@
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/errno.h>
+#include <linux/usb.h>
+#include <linux/mutex.h>
+
+#include <linux/watchdog.h>
+#include <linux/hid.h>
+
+#include <asm/byteorder.h>
+#include <asm/unaligned.h>
+
+#define MIN_BUF_LENGTH 8
+
+/* stuff taken from the old driver */
+
+/* according to documentation max. time to process a command for the USB
+ * watchdog card is 100 or 200 ms, so we give it 250 ms to do it's job */
+#define USB_COMMAND_TIMEOUT	250
+
+/* Watchdog's internal commands */
+#define CMD_READ_TEMP			0x02    /* Read Temperature;
+							Re-trigger Watchdog */
+#define CMD_TRIGGER			CMD_READ_TEMP
+#define CMD_GET_STATUS			0x04	/* Get Status Information */
+#define CMD_GET_FIRMWARE_VERSION	0x08	/* Get Firmware Version */
+#define CMD_GET_DIP_SWITCH_SETTINGS	0x0c	/* Get Dip Switch Settings */
+#define CMD_READ_WATCHDOG_TIMEOUT	0x18	/* Read Current Watchdog Time */
+#define CMD_WRITE_WATCHDOG_TIMEOUT	0x19	/* Write Current WatchdogTime */
+#define CMD_ENABLE_WATCHDOG		0x30	/* Enable / Disable Watchdog */
+#define CMD_DISABLE_WATCHDOG		CMD_ENABLE_WATCHDOG
+
+/* Watchdog's Dip Switch heartbeat values */
+static const int heartbeat_tbl[] = {
+	5,	/* OFF-OFF-OFF	=  5 Sec  */
+	10,	/* OFF-OFF-ON	= 10 Sec  */
+	30,	/* OFF-ON-OFF	= 30 Sec  */
+	60,	/* OFF-ON-ON	=  1 Min  */
+	300,	/* ON-OFF-OFF	=  5 Min  */
+	600,	/* ON-OFF-ON	= 10 Min  */
+	1800,	/* ON-ON-OFF	= 30 Min  */
+	3600,	/* ON-ON-ON	=  1 hour */
+};
+
+/* The vendor and product id's for the USB-PC Watchdog card */
+#define USB_PCWD_VENDOR_ID	0x0c98
+#define USB_PCWD_PRODUCT_ID	0x1140
+
+/*
+ * --- data structures ---
+ */
+
+struct pcwd_nova_command {
+	u8 command;
+	__be16 value;
+	u8 reserved0;
+	u8 reserved1;
+	u8 reserved2;
+}__attribute__ ((__packed__));
+
+struct pcwd_nova_wdt {
+	struct watchdog_device wdd;
+	struct mutex command_excl;
+	struct completion response_available;
+	int command_result;
+	struct usb_interface *interface;
+	int intr_size;
+	struct pcwd_nova_command *intr_buffer;
+	struct urb *intr_urb;
+	struct pcwd_nova_command *command_buffer;
+};
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (default="
+		__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+static const struct watchdog_info pcwd_nova_info;
+/*
+ * --- helpers ---
+ */
+
+static bool ack_valid(int response)
+{
+	/* the upper byte can be garbage */
+	return (response & 0xff) != 0x00;
+}
+
+static int send_command(struct pcwd_nova_wdt *pwd, u8 command, u16 value)
+{
+	int result = -EIO;
+	int transmitted;
+	long left;
+	struct pcwd_nova_command *cmd = pwd->command_buffer;
+	struct usb_device *dev = interface_to_usbdev(pwd->interface);
+
+	mutex_lock(&pwd->command_excl);
+
+	cmd->command = command;
+	cmd->value = cpu_to_be16(value);
+	cmd->reserved0 = cmd->reserved1 = cmd->reserved2 = 0;
+
+	reinit_completion(&pwd->response_available);
+	transmitted = usb_control_msg(
+			dev,
+			usb_sndctrlpipe(dev, 0),
+			HID_REQ_SET_REPORT,
+			HID_DT_REPORT,
+			0x0200,
+			pwd->interface->cur_altsetting->desc.bInterfaceNumber,
+			cmd,
+			sizeof(struct pcwd_nova_command),
+			USB_CTRL_SET_TIMEOUT);
+	if (transmitted != sizeof(struct pcwd_nova_command)) 
+		goto error;
+
+	left = wait_for_completion_timeout(&pwd->response_available,
+			msecs_to_jiffies(USB_COMMAND_TIMEOUT));
+	if (!left)
+		goto error;
+	result = pwd->command_result;
+error:
+	mutex_unlock(&pwd->command_excl);
+
+	return result;
+}
+
+static int usb_pcwd_stop(struct pcwd_nova_wdt *pwd)
+{
+	int retval;
+
+	retval = send_command(pwd, CMD_DISABLE_WATCHDOG, 0xA5C3);
+	if (retval < 0)
+		goto error;
+
+	if (!ack_valid(retval))
+		retval = -EIO;
+	else
+		retval = 0;
+error:
+	return retval;
+}
+
+static int usb_pcwd_start(struct pcwd_nova_wdt *pwd)
+{
+	int retval;
+
+	retval = send_command(pwd, CMD_ENABLE_WATCHDOG, 0x0000);
+	if (retval < 0)
+		goto error;
+
+	if (!ack_valid(retval))
+		retval = -EIO;
+	else
+		retval = 0;
+
+error:
+	return retval;
+}
+
+static int usb_pcwd_set_heartbeat(struct pcwd_nova_wdt *pwd, u16 hb)
+{
+	int retval;
+
+	retval = send_command(pwd, CMD_WRITE_WATCHDOG_TIMEOUT, hb);
+
+	return retval;
+}
+
+static int usb_pcwd_keepalive(struct pcwd_nova_wdt *pwd)
+{
+	int retval;
+
+	retval = send_command(pwd, CMD_TRIGGER, 0x00);
+
+	return retval;
+}
+
+static int usb_pcwd_get_timeleft(struct pcwd_nova_wdt *pwd)
+{
+	int retval;
+
+	retval = send_command(pwd, CMD_READ_WATCHDOG_TIMEOUT, 0x00);
+
+	return retval < 0 ? -EIO : retval;
+}
+
+static int evaluate_device(struct pcwd_nova_wdt *pwd)
+{
+	int rv;
+	u16 heartbeat;
+
+	rv = usb_pcwd_stop(pwd);
+	if (rv < 0)
+		goto error;
+
+	/* errors intentionally ignored */
+	send_command(pwd, CMD_GET_FIRMWARE_VERSION, 0);
+
+	rv = send_command(pwd, CMD_GET_DIP_SWITCH_SETTINGS, 0);
+	if (rv < 0)
+		goto error;
+
+	heartbeat = heartbeat_tbl[(rv & 0x07)];
+	rv = usb_pcwd_set_heartbeat(pwd, heartbeat);
+	if (rv < 0)
+		/* retry with default */
+		rv = usb_pcwd_set_heartbeat(pwd, 0);
+
+error:
+	return rv;
+}
+
+/*
+ * --- watchdog operations ---
+ */
+
+static int pcwd_nova_pm_start(struct watchdog_device *wdd)
+{
+	struct pcwd_nova_wdt *pwd = (struct pcwd_nova_wdt *)wdd;
+	int r;
+
+	r = usb_pcwd_start(pwd);
+
+	return r;
+}
+
+static int pcwd_nova_pm_stop(struct watchdog_device *wdd)
+{
+	struct pcwd_nova_wdt *pwd = (struct pcwd_nova_wdt *)wdd;
+	int r;
+
+	r = usb_pcwd_stop(pwd);
+
+	return r;
+}
+
+static int pcwd_nova_pm_ping(struct watchdog_device *wdd)
+{
+	struct pcwd_nova_wdt *pwd = (struct pcwd_nova_wdt *)wdd;
+	int r;
+
+	r = usb_pcwd_keepalive(pwd);
+
+	return r;
+}	
+
+static int pcwd_nova_pm_set_heartbeat(struct watchdog_device *wdd,
+		unsigned int new_timeout)
+{
+	struct pcwd_nova_wdt *pwd = (struct pcwd_nova_wdt *)wdd;
+	int r;
+
+	r = usb_pcwd_set_heartbeat(pwd, new_timeout);
+
+	return r;
+}
+
+static unsigned int pcwd_nova_pm_get_timeleft(struct watchdog_device *wdd)
+{
+	struct pcwd_nova_wdt *pwd = (struct pcwd_nova_wdt *)wdd;
+	int r;
+
+	r = usb_pcwd_get_timeleft(pwd);
+
+	return r;
+}
+/*
+ * --- usb operations ---
+ */
+
+static void pwd_intr_callback(struct urb *u)
+{
+	struct pcwd_nova_wdt *pwd = u->context;
+	struct pcwd_nova_command *result = pwd->intr_buffer;
+	int status = u->status;
+
+	switch (status) {
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		goto death;
+	case 0:
+		/* get the payload */
+		pwd->command_result = be16_to_cpu(result->value);
+		break;
+	default:
+		pwd->command_result = -EIO;
+		goto resubmit;
+	}
+
+	complete(&pwd->response_available);
+resubmit:
+	usb_submit_urb(u, GFP_ATOMIC);
+	return;
+death:
+	pwd->command_result = -EIO;
+	complete(&pwd->response_available);
+}
+
+static int usb_pcwd_probe(struct usb_interface *interface,
+		const struct usb_device_id *id)
+{
+	struct pcwd_nova_wdt *pwd;
+	struct usb_endpoint_descriptor *int_in;
+	int r = -EINVAL;
+	int rv, size;
+
+	rv = usb_find_common_endpoints(interface->cur_altsetting,
+		       	NULL, NULL, &int_in, NULL);
+	if (rv < 0)
+		goto err_abort;
+
+	/* keeping allocations together for error handling */
+	r = -ENOMEM;
+	pwd = kzalloc(sizeof(struct pcwd_nova_wdt), GFP_KERNEL);
+	if (!pwd)
+		goto err_abort;
+	pwd->interface = interface;
+	size = max(usb_endpoint_maxp(int_in), MIN_BUF_LENGTH);
+	pwd->intr_buffer = kmalloc(size, GFP_KERNEL);
+	if (!pwd->intr_buffer)
+		goto err_free_pwd;
+	pwd->intr_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!pwd->intr_urb)
+		goto err_free_buffer;
+	pwd->command_buffer = kmalloc(sizeof(struct pcwd_nova_command), GFP_KERNEL);
+	if (!pwd->command_buffer)
+		goto err_free_urb;
+
+	mutex_init(&pwd->command_excl);
+	init_completion(&pwd->response_available);
+	usb_fill_int_urb(pwd->intr_urb,
+			interface_to_usbdev(interface),
+			usb_rcvintpipe(interface_to_usbdev(interface),
+				int_in->bEndpointAddress),
+			pwd->intr_buffer,
+			size,
+			pwd_intr_callback,
+			pwd,
+			int_in->bInterval);
+
+	/*
+	 * we need to start IO now, because we need the device settings
+	 * that means even an unused device takes up bandwidth
+	 */
+	r = usb_submit_urb(pwd->intr_urb, GFP_KERNEL);
+	if (r < 0)
+		goto err_free_all_buffers;
+	r = evaluate_device(pwd);
+	if (r < 0)
+		goto err_free_all_buffers;
+
+	usb_set_intfdata(interface, pwd);
+
+	pwd->wdd.info = &pcwd_nova_info;
+	watchdog_set_drvdata(&pwd->wdd, pwd);
+	watchdog_set_nowayout(&pwd->wdd, nowayout);
+	watchdog_stop_on_reboot(&pwd->wdd);
+	watchdog_stop_on_unregister(&pwd->wdd);
+
+	r = watchdog_register_device(&pwd->wdd);
+	if (r < 0)
+		goto err_kill_urb;
+
+	return 0;
+
+err_kill_urb:
+	usb_kill_urb(pwd->intr_urb);
+	usb_set_intfdata(interface, NULL);
+err_free_all_buffers:
+	kfree(pwd->command_buffer);
+err_free_urb:
+	usb_free_urb(pwd->intr_urb);
+err_free_buffer:
+	kfree(pwd->intr_buffer);
+err_free_pwd:
+	kfree(pwd);
+err_abort:
+	return r;
+}
+
+static void usb_pcwd_disconnect(struct usb_interface *interface)
+{
+	struct pcwd_nova_wdt *pwd;
+
+	pwd = usb_get_intfdata(interface);
+	usb_kill_urb(pwd->intr_urb);
+	complete(&pwd->response_available);
+	watchdog_unregister_device(&pwd->wdd);
+	usb_free_urb(pwd->intr_urb);
+	kfree(pwd->intr_buffer);
+	kfree(pwd->command_buffer);
+	kfree(pwd);
+}
+
+static const struct watchdog_info pcwd_nova_info = {
+	.options = WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE |
+		WDIOF_SETTIMEOUT,
+	.identity = "PC watchdog new driver",
+};
+
+static const struct watchdog_ops pcwd_nova_ops = {
+        .owner = THIS_MODULE,
+        .start = pcwd_nova_pm_start,
+        .stop = pcwd_nova_pm_stop,
+	.ping = pcwd_nova_pm_ping,
+	.set_timeout = pcwd_nova_pm_set_heartbeat,
+	.get_timeleft = pcwd_nova_pm_get_timeleft,
+};
+
+static const struct usb_device_id usb_pcwd_table[] = {
+        { USB_DEVICE(USB_PCWD_VENDOR_ID, USB_PCWD_PRODUCT_ID) },
+	{ },				/* Terminating entry */
+};
+MODULE_DEVICE_TABLE(usb, usb_pcwd_table);
+
+static struct usb_driver usb_pcwd_drivernova = {
+	"New API PCWD",
+	.probe =	usb_pcwd_probe,
+	.disconnect =	usb_pcwd_disconnect,
+	.id_table =	usb_pcwd_table,
+};
+
+module_usb_driver(usb_pcwd_drivernova);
+MODULE_LICENSE("GPL");
-- 
2.41.0

