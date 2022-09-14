Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4825B81EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiINHN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiINHNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:13:49 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D5B8C72B52;
        Wed, 14 Sep 2022 00:13:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.138.126])
        by APP-05 (Coremail) with SMTP id zQCowAA3Pt4kfyFjLwWNAg--.39905S2;
        Wed, 14 Sep 2022 15:13:41 +0800 (CST)
From:   Jiasheng Jiang <jiasheng@iscas.ac.cn>
To:     johan@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiasheng Jiang <jiasheng@iscas.ac.cn>
Subject: [PATCH v5] USB: serial: ftdi_sio: Convert to use dev_groups
Date:   Wed, 14 Sep 2022 15:13:34 +0800
Message-Id: <20220914071334.2820756-1-jiasheng@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAA3Pt4kfyFjLwWNAg--.39905S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1rJry3uryfCw48Cry8Xwb_yoWrCF1Dpa
        yUXFWSqF4UJF4agFs8Ca1qgw1rCw4kKa9Ig3yxGw4FkF1fJ34Iqa4IyasYvry3tFykKFya
        qrsaqrWqkF4xJrUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
        6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
        I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
        4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxG
        rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
        vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IY
        x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
        xKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbrMaUUUUUU==
X-Originating-IP: [124.16.138.126]
X-CM-SenderInfo: pmld2xxhqjqxpvfd2hldfou0/
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver core supports the ability to handle the creation and removal
of device-specific sysfs files in a race-free manner. Moreover, it can
guarantee the success of creation. Therefore, it should be better to
convert to use dev_groups.

Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
---
Changelog:

v4 -> v5:

1. Use a forward declaration for ftdi_sio_groups.
2. Correct ftdi_sio_attr_is_visible() implementation.

v3 -> v4:

1. Move the code and remove the pre-definitions.

v2 -> v3:

1. Add is_visible to filter the unneeded files.

v1 -> v2:

1. Change the title.
2. Switch to use an attribute group.
---
 drivers/usb/serial/ftdi_sio.c | 60 +++++++++++++++++------------------
 1 file changed, 29 insertions(+), 31 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index d5a3986dfee7..660181064cda 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -1108,10 +1108,13 @@ static u32 ftdi_232bm_baud_to_divisor(int baud);
 static u32 ftdi_2232h_baud_base_to_divisor(int baud, int base);
 static u32 ftdi_2232h_baud_to_divisor(int baud);
 
+extern const struct attribute_group *ftdi_sio_groups[];
+
 static struct usb_serial_driver ftdi_sio_device = {
 	.driver = {
 		.owner =	THIS_MODULE,
 		.name =		"ftdi_sio",
+		.dev_groups =	ftdi_sio_groups,
 	},
 	.description =		"FTDI USB Serial Device",
 	.id_table =		id_table_combined,
@@ -1729,38 +1732,19 @@ static ssize_t event_char_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(event_char);
 
-static int create_sysfs_attrs(struct usb_serial_port *port)
+static umode_t ftdi_sio_attr_is_visible(struct kobject *kobj,
+					 struct attribute *attr, int idx)
 {
+	struct device *dev = kobj_to_dev(kobj);
+	struct usb_serial_port *port = container_of(dev, struct usb_serial_port, dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
-	int retval = 0;
+	umode_t mode = attr->mode;
 
 	/* XXX I've no idea if the original SIO supports the event_char
 	 * sysfs parameter, so I'm playing it safe.  */
 	if (priv->chip_type != SIO) {
-		dev_dbg(&port->dev, "sysfs attributes for %s\n", ftdi_chip_name[priv->chip_type]);
-		retval = device_create_file(&port->dev, &dev_attr_event_char);
-		if ((!retval) &&
-		    (priv->chip_type == FT232BM ||
-		     priv->chip_type == FT2232C ||
-		     priv->chip_type == FT232RL ||
-		     priv->chip_type == FT2232H ||
-		     priv->chip_type == FT4232H ||
-		     priv->chip_type == FT232H ||
-		     priv->chip_type == FTX)) {
-			retval = device_create_file(&port->dev,
-						    &dev_attr_latency_timer);
-		}
-	}
-	return retval;
-}
-
-static void remove_sysfs_attrs(struct usb_serial_port *port)
-{
-	struct ftdi_private *priv = usb_get_serial_port_data(port);
-
-	/* XXX see create_sysfs_attrs */
-	if (priv->chip_type != SIO) {
-		device_remove_file(&port->dev, &dev_attr_event_char);
+		if (attr == &dev_attr_event_char.attr)
+			return mode;
 		if (priv->chip_type == FT232BM ||
 		    priv->chip_type == FT2232C ||
 		    priv->chip_type == FT232RL ||
@@ -1768,12 +1752,29 @@ static void remove_sysfs_attrs(struct usb_serial_port *port)
 		    priv->chip_type == FT4232H ||
 		    priv->chip_type == FT232H ||
 		    priv->chip_type == FTX) {
-			device_remove_file(&port->dev, &dev_attr_latency_timer);
+			if (attr == &dev_attr_latency_timer.attr)
+				return mode;
 		}
 	}
-
+	return 0;
 }
 
+static struct attribute *ftdi_sio_attrs[] = {
+	&dev_attr_event_char.attr,
+	&dev_attr_latency_timer.attr,
+	NULL,
+};
+
+static const struct attribute_group ftdi_sio_group = {
+	.attrs = ftdi_sio_attrs,
+	.is_visible = ftdi_sio_attr_is_visible,
+};
+
+const struct attribute_group *ftdi_sio_groups[] = {
+	&ftdi_sio_group,
+	NULL
+};
+
 #ifdef CONFIG_GPIOLIB
 
 static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
@@ -2251,7 +2252,6 @@ static int ftdi_sio_port_probe(struct usb_serial_port *port)
 	if (read_latency_timer(port) < 0)
 		priv->latency = 16;
 	write_latency_timer(port);
-	create_sysfs_attrs(port);
 
 	result = ftdi_gpio_init(port);
 	if (result < 0) {
@@ -2377,8 +2377,6 @@ static void ftdi_sio_port_remove(struct usb_serial_port *port)
 
 	ftdi_gpio_remove(port);
 
-	remove_sysfs_attrs(port);
-
 	kfree(priv);
 }
 
-- 
2.25.1

