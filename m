Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF53061EC11
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiKGH3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:29:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbiKGH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:29:01 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E1C140F6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 23:28:00 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368e6c449f2so101090637b3.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 23:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UZIa3TPodu5p4r3EQIwk/znAe98Z3Rc479m8woaBUnA=;
        b=aEZzUeFpa53BR08+bOZCPAJp68yJPGO5DYXJaFjDC+eK3wbOJd/13AecPzXdUbvVrs
         M2AyNgf9LIupmkjImHuk4oIu9jcmStSYc7EaoOL4VuSTRsT3z3s1PFACXjmzBMrQI48v
         3rIuZ0wm5Tcc8UFVMfhF6AsW+DxTh+tTTQT4i+ZJ1yHinLbw2ISFllk/ldwcJWHiO4yQ
         7PLbNNtcrQWQ7m6C7z7i+MtfYtvSGZKEWpxJwh98T7CYSMpTWyiaJjwyyIRMHVUSRIwI
         iYazraq5PDyCRJnjyz1hrMgGZqBUoX4DgVUL/+hs3u/1/ub80dwR+p/XvGcATp/kzwd+
         lSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZIa3TPodu5p4r3EQIwk/znAe98Z3Rc479m8woaBUnA=;
        b=tlPxLmnBDdL+O1WrxZ6f8mCH3ormCUcdfrdFu1A6DJl/wIxSwObSJzMTC0u6hpI3KV
         pphwrCnxr3bWfmKUrSa9Ee6XOq28A85k0jdNhx/z8G4KBbugUaTgWznLmbyn79/3rBcE
         OTxMzdkFcIBgTCbmNYwEikQFsRdFNC9BNfQY3yHUMYmfRw157QGXQLIEcp10OBh2RQ5c
         cb+ObAgNdwcZINnKa6Ui8EDwuX2bsMej/qvgOP0+Z2fCa9SBTYYcwwmlDGYrZefPDT4o
         Zki7l69t8i0NvZ6vUzDj+3UN31MQLlIwEt22cH1dUG4T3Ls7VWowr61mdYrkUwoRM2Nj
         lc6w==
X-Gm-Message-State: ACrzQf2xqU/mDh/pe3LIETs1O0q8kIy6IFWktzDH9WfJ4CFCSp0HJi1V
        cE3cqzHDgd6YtFRVfIPT6gz8NibBqFs=
X-Google-Smtp-Source: AMsMyM6NT1BnynqufCzLVkZCmh7tZAfIYYrUmNaM8lkfWYxzxvUJnMs7cyuWsW2mdYEknS42bGjdynlQ8n8=
X-Received: from raychi.tao.corp.google.com ([2401:fa00:fc:202:f4f4:86d8:c505:8643])
 (user=raychi job=sendgmr) by 2002:a25:d491:0:b0:6cf:e8f1:df9b with SMTP id
 m139-20020a25d491000000b006cfe8f1df9bmr523202ybf.355.1667806079793; Sun, 06
 Nov 2022 23:27:59 -0800 (PST)
Date:   Mon,  7 Nov 2022 15:27:54 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221107072754.3336357-1-raychi@google.com>
Subject: [Patch v5] usb: core: stop USB enumeration if too many retries
From:   Ray Chi <raychi@google.com>
To:     stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        m.grzeschik@pengutronix.de
Cc:     albertccwang@google.com, pumahsu@google.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Ray Chi <raychi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
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

Changes since v4:
 - change the location of calling hub_port_stop_enumerate()
 - modify if statement in hub_port_stop_enumerate()
 - modify if statement in port_event()

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
 drivers/usb/core/hub.c                  | 60 +++++++++++++++++++++++++
 drivers/usb/core/hub.h                  |  4 ++
 drivers/usb/core/port.c                 | 27 +++++++++++
 4 files changed, 102 insertions(+)

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
index bbab424b0d55..77e73fc8d673 100644
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
+		if (retries < 2)
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
@@ -4796,6 +4838,11 @@ hub_port_init(struct usb_hub *hub, struct usb_device *udev, int port1,
 	do_new_scheme = use_new_scheme(udev, retry_counter, port_dev);
 
 	for (retries = 0; retries < GET_DESCRIPTOR_TRIES; (++retries, msleep(100))) {
+		if (hub_port_stop_enumerate(hub, port1, retries)) {
+			retval = -ENODEV;
+			break;
+		}
+
 		if (do_new_scheme) {
 			struct usb_device_descriptor *buf;
 			int r = 0;
@@ -5246,6 +5293,11 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 	status = 0;
 
 	for (i = 0; i < PORT_INIT_TRIES; i++) {
+		if (hub_port_stop_enumerate(hub, port1, i)) {
+			status = -ENODEV;
+			break;
+		}
+
 		usb_lock_port(port_dev);
 		mutex_lock(hcd->address0_mutex);
 		retry_locked = true;
@@ -5614,6 +5666,10 @@ static void port_event(struct usb_hub *hub, int port1)
 	if (!pm_runtime_active(&port_dev->dev))
 		return;
 
+	/* skip port actions if ignore_event and early_stop are true */
+	if (port_dev->ignore_event && port_dev->early_stop)
+		return;
+
 	if (hub_handle_remote_wakeup(hub, port1, portstatus, portchange))
 		connect_change = 1;
 
@@ -5927,6 +5983,10 @@ static int usb_reset_and_verify_device(struct usb_device *udev)
 	mutex_lock(hcd->address0_mutex);
 
 	for (i = 0; i < PORT_INIT_TRIES; ++i) {
+		if (hub_port_stop_enumerate(parent_hub, port1, i)) {
+			ret = -ENODEV;
+			break;
+		}
 
 		/* ep0 maxpacket size may change; let the HCD know about it.
 		 * Other endpoints will be handled by re-enumeration. */
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
index 015204fc67a1..06a8f1f84f6f 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -18,6 +18,32 @@ static int usb_port_block_power_off;
 
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
@@ -237,6 +263,7 @@ static struct attribute *port_dev_attrs[] = {
 	&dev_attr_quirks.attr,
 	&dev_attr_over_current_count.attr,
 	&dev_attr_disable.attr,
+	&dev_attr_early_stop.attr,
 	NULL,
 };
 
-- 
2.38.1.431.g37b22c650d-goog

