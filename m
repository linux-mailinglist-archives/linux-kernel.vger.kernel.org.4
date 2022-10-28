Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB7610E65
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 12:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiJ1KZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 06:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiJ1KZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 06:25:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D3633A02
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:25:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id y65-20020a25c844000000b006bb773548d5so4164771ybf.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 03:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fij7+yee8YnVkbZaAr0DYvfr/2gaVpRH/eo9KFhyHSY=;
        b=FjXtX3Nf0oS7XzvJhJ7sP4La9ZRxeDYMvaj4oJJLXMdvTZDBtLRtieTbVeHy9xev/w
         HNT9DdMNJUpziu/nwY7vP2dpYVn7klChbrtTo6dOTIV3FfRWiEFu/k0ur2gu++Knd2NI
         AcWEqB7qv+5Bn/FLcN1UcDSwUqbjw+SA9shZ1zlyTRBYoXP+/9/skTncHNnkuL/PyqBE
         tKsY9vy2L5AkWAZx9qQjuu4pghzUUufwKZ2BlnkDQ1WUxHtPf8t0OP8Yaei5FI+vBp+8
         fp32gtF7+ov+4cKD7VKfXUMc3G02uLZRvyCuE7HzEiUXNAGYYssH+GgA8co2bsnu80MA
         +lZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Fij7+yee8YnVkbZaAr0DYvfr/2gaVpRH/eo9KFhyHSY=;
        b=AeDZkrZfLiFOfhdw8nL6P5g5yBcjP3cgVE7W2lj7VyJQzCJjOHpJjEeaudXCAbRRa9
         WpI52ZWzC+/GZOZVYuU9QVr9IVDmjQF24T1f0s3N9/ZjqkKSzlMqAPVV9X/9bXBaCMdh
         XIkEQpr//as1AacdihaMEd6YHMjeKDdHzQ5e/s6Q+kw92uBR0JEgY0qrHRXKbRjggxLZ
         35ZntOuR1Q72+R/aoeCfsj9b/LusTF/17qY2j4gG3dQXyfhSgvqwirXohUwP6v/Sw0VB
         Uf+vgcOQgB4Ys1zAZDqH70RRN3ZC17UDsFOY4ad5s5fGMMCNVepR8ZX30lMA4R0Yw35c
         pJzQ==
X-Gm-Message-State: ACrzQf2HA8p9nBuxRH7oRs5kAK5ESSt1u1Ejqh5N+V9KMIuQJmM9ZenL
        dbi9+8/4jFTzaYeaZSPVWYyPWxPo7Uo=
X-Google-Smtp-Source: AMsMyM4Io0tOH54vmmLNh7hi4jUe4GlugVuYCYk8iiYl9RPbguCh7JrcI4HS1ZOVjfmET8C0lOHzZY63+ts=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:c8cf:1264:21c3:c6ff])
 (user=raychi job=sendgmr) by 2002:a05:6902:102e:b0:6ca:c082:1661 with SMTP id
 x14-20020a056902102e00b006cac0821661mr27546842ybt.25.1666952710285; Fri, 28
 Oct 2022 03:25:10 -0700 (PDT)
Date:   Fri, 28 Oct 2022 18:25:05 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221028102505.217565-1-raychi@google.com>
Subject: [PATCH RESEND v4] usb: core: stop USB enumeration if too many retries
From:   Ray Chi <raychi@google.com>
To:     gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        m.grzeschik@pengutronix.de
Cc:     albertccwang@google.com, pumahsu@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a broken USB accessory connects to a USB host, usbcore might
keep doing enumeration retries. If the host has a watchdog mechanism,
the kernel panic will happen on the host.

This patch provides an attribute early_stop to limit the numbers of retries
for each port of a hub. If a port was marked with early_stop attribute,
unsuccessful connection attempts will fail quickly. In addition, if an
early_stop port has failed to initialize, it will ignore all future
connection events until early_stop attribute is clear.

Signed-off-by: Ray Chi <raychi@google.com>
---

Changes since v3:
 - rename the attribute from quick_init to early_stop
 - rename the variable of port_dev from ignore_connect to ignore_event
 - modify changelog, documentation
 - add more comments for hub_port_stop_enumerate()

Changes since v2:
 - replace the quirk with the attribute
 - Document the attribute
 - modify hub_port_stop_enumerate() position in port_event()
 - modify the changelog

Changes since v1:
 - remove usb_hub_set_port_power()
 - add a variable ignore_connect into struct port_dev
 - modify hub_port_stop_enumerate() and set ignore_connect in
   this function
 - avoid calling hub_port_connect_change() in port_event()

---
 Documentation/ABI/testing/sysfs-bus-usb | 11 +++++
 drivers/usb/core/hub.c                  | 59 +++++++++++++++++++++++++
 drivers/usb/core/hub.h                  |  4 ++
 drivers/usb/core/port.c                 | 27 +++++++++++
 4 files changed, 101 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 568103d3376e..545c2dd97ed0 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -264,6 +264,17 @@ Description:
 		attached to the port will not be detected, initialized,
 		or enumerated.
 
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/early_stop
+Date:		Sep 2022
+Contact:	Ray Chi <raychi@google.com>
+Description:
+		Some USB hosts have some watchdog mechanisms so that the device
+		may enter ramdump if it takes a long time during port initialization.
+		This attribute allows each port just has two attempts so that the
+		port initialization will be failed quickly. In addition, if a port
+		which is marked with early_stop has failed to initialize, it will ignore
+		all future connections until this attribute is clear.
+
 What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
 Date:		May 2013
 Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index bbab424b0d55..5510dbef3243 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -3081,6 +3081,48 @@ static int hub_port_reset(struct usb_hub *hub, int port1,
 	return status;
 }
 
+/*
+ * hub_port_stop_enumerate - stop USB enumeration or ignore port events
+ * @hub: target hub
+ * @port1: port num of the port
+ * @retries: port retries number of hub_port_init()
+ *
+ * Return:
+ *    true: ignore port actions/events or give up connection attempts.
+ *    false: keep original behavior.
+ *
+ * This function will be based on retries to check whether the port which is
+ * marked with early_stop attribute would stop enumeration or ignore events.
+ *
+ * Note:
+ * This function didn't change anything if early_stop is not set, and it will
+ * prevent all connection attempts when early_stop is set and the attempts of
+ * the port are more than 1.
+ */
+static bool hub_port_stop_enumerate(struct usb_hub *hub, int port1, int retries)
+{
+	struct usb_port *port_dev = hub->ports[port1 - 1];
+
+	if (port_dev->early_stop) {
+		if (port_dev->ignore_event)
+			return true;
+
+		/*
+		 * We want unsuccessful attempts to fail quickly.
+		 * Since some devices may need one failure during
+		 * port initialization, we allow two tries but no
+		 * more.
+		 */
+		if (retries < 1)
+			return false;
+
+		port_dev->ignore_event = 1;
+	} else
+		port_dev->ignore_event = 0;
+
+	return port_dev->ignore_event;
+}
+
 /* Check if a port is power on */
 int usb_port_is_power_on(struct usb_hub *hub, unsigned int portstatus)
 {
@@ -4855,6 +4897,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 					buf->bMaxPacketSize0;
 			kfree(buf);
 
+			if (r < 0 && hub_port_stop_enumerate(hub, port1, retries)) {
+				retval = r;
+				goto fail;
+			}
+
 			retval = hub_port_reset(hub, port1, udev, delay, false);
 			if (retval < 0)		/* error or disconnect */
 				goto fail;
@@ -5387,6 +5434,9 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 		if ((status == -ENOTCONN) || (status == -ENOTSUPP))
 			break;
 
+		if (hub_port_stop_enumerate(hub, port1, i))
+			break;
+
 		/* When halfway through our retry count, power-cycle the port */
 		if (i == (PORT_INIT_TRIES - 1) / 2) {
 			dev_info(&port_dev->dev, "attempt power cycle\n");
@@ -5614,6 +5664,10 @@ static void port_event(struct usb_hub *hub, int port1)
 	if (!pm_runtime_active(&port_dev->dev))
 		return;
 
+	/* skip port actions if ignore_event is true*/
+	if (hub_port_stop_enumerate(hub, port1, 0))
+		return;
+
 	if (hub_handle_remote_wakeup(hub, port1, portstatus, portchange))
 		connect_change = 1;
 
@@ -5934,6 +5988,9 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 		ret = hub_port_init(parent_hub, udev, port1, i);
 		if (ret >= 0 || ret == -ENOTCONN || ret == -ENODEV)
 			break;
+
+		if (hub_port_stop_enumerate(parent_hub, port1, i))
+			goto stop_enumerate;
 	}
 	mutex_unlock(hcd->address0_mutex);
 
@@ -6022,6 +6079,8 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	udev->bos = bos;
 	return 0;
 
+stop_enumerate:
+	mutex_unlock(hcd->address0_mutex);
 re_enumerate:
 	usb_release_bos_descriptor(udev);
 	udev->bos = bos;
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index b2925856b4cb..e23833562e4f 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -90,6 +90,8 @@ struct usb_hub {
  * @is_superspeed cache super-speed status
  * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
  * @usb3_lpm_u2_permit: whether USB3 U2 LPM is permitted.
+ * @early_stop: whether port initialization will be stopped earlier.
+ * @ignore_event: whether events of the port are ignored.
  */
 struct usb_port {
 	struct usb_device *child;
@@ -103,6 +105,8 @@ struct usb_port {
 	u32 over_current_count;
 	u8 portnum;
 	u32 quirks;
+	unsigned int early_stop:1;
+	unsigned int ignore_event:1;
 	unsigned int is_superspeed:1;
 	unsigned int usb3_lpm_u1_permit:1;
 	unsigned int usb3_lpm_u2_permit:1;
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 38c1a4f4fdea..126da9408359 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -17,6 +17,32 @@ static int usb_port_block_power_off;
 
 static const struct attribute_group *port_dev_group[];
 
+static ssize_t early_stop_show(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+
+	return sysfs_emit(buf, "%s\n", port_dev->early_stop ? "yes" : "no");
+}
+
+static ssize_t early_stop_store(struct device *dev, struct device_attribute *attr,
+				const char *buf, size_t count)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+	bool value;
+
+	if (kstrtobool(buf, &value))
+		return -EINVAL;
+
+	if (value)
+		port_dev->early_stop = 1;
+	else
+		port_dev->early_stop = 0;
+
+	return count;
+}
+static DEVICE_ATTR_RW(early_stop);
+
 static ssize_t disable_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
@@ -236,6 +262,7 @@ static struct attribute *port_dev_attrs[] = {
 	&dev_attr_quirks.attr,
 	&dev_attr_over_current_count.attr,
 	&dev_attr_disable.attr,
+	&dev_attr_early_stop.attr,
 	NULL,
 };
 
-- 
2.38.1.273.g43a17bfeac-goog

