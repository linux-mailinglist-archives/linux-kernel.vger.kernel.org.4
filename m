Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E967274AF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 03:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjFHB7U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 21:59:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjFHB7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 21:59:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55D26A8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 18:59:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5693861875fso1280057b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 18:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686189555; x=1688781555;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9MdW2ilDra+PEQ8cwF5fy8XBSC127csHw3pgdyF8PZ4=;
        b=A+987Bmw2V0OlAgZ3MZTbbjY2DLevU4UhghaGTepNfT+qqOWUsPz3o0aWHMWNUYg4m
         Y+5mO6NHkRunObsE5eaOjmYNKRlDNwn00I0zJnuwyL1uQg2/xHjiQMZL5WBLPWUveOcp
         YhlC48fxbntDayjg1TojSwlLn6RE0YHmL1YkSEQFx/muay1arRf0y4coYDy8p9gkyadH
         DVVDsy3+sENCyzLp39+az3eQkocaUgZhNqJ9HlPu6pL479iCJc5DnbPM08VxunGRHkWo
         n+XUYkk1jPH3q9mX9/KghodmeO/ZfOG7NSmULCJ6ichFkSiHf8j48g7r1a93j9eImDDo
         xKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686189555; x=1688781555;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9MdW2ilDra+PEQ8cwF5fy8XBSC127csHw3pgdyF8PZ4=;
        b=F6NL6556GW2cVutd0r47+Elmg8mY9oyiIeA0IFEjNsRA+xHXtklq4qw1ULSb0RJN7k
         K+zdWPydWru1xZZcDMpMuMo+dEdKAejosPP5fHOTfYnfUfiHFVxN8zSXP/X+tbIVk9X+
         jPzJUvHbtizwAvZqisCC/ec01CT4UUd+Qpw7ZIT4uRTinlDQHt1Wv9RqvzjyzGnyUQjZ
         U4K5gl/7xrcvS8AqRc+cdtP+bNlh3xVlP9DHhaJf8mqhoWm1Eh+sUD8rBspzYbr1qr8l
         D9lLJIO147z3UuPRpU02+AXomqT5qQYRgZCpVh3RPO4Kjc/j1BmplWxIE6T+hdAbeQjK
         qeEw==
X-Gm-Message-State: AC+VfDw2HXl62g4JHZkhkRoWFBCryqgfIU0ye23MxBEf5TiE1yJMSEas
        JdQv6xisbmefLGnEC1O7+7V/RaLPTWU=
X-Google-Smtp-Source: ACHHUZ7p4cbqrZwQ6dMPsf0Wuzi+Ki65gCggpIraOcoX7pW9s/l9FnC+gC04k8r1VhfVvgTzNsKPao1DoH4=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a81:4112:0:b0:54f:93c0:4ba8 with SMTP id
 o18-20020a814112000000b0054f93c04ba8mr3935245ywa.2.1686189555334; Wed, 07 Jun
 2023 18:59:15 -0700 (PDT)
Date:   Thu,  8 Jun 2023 01:59:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230608015913.1679984-1-royluo@google.com>
Subject: [PATCH v4] usb: core: add sysfs entry for usb device state
From:   Roy Luo <royluo@google.com>
To:     raychi@google.com, badhri@google.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Bastien Nocera <hadess@hadess.net>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Douglas Anderson <dianders@chromium.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Roy Luo <royluo@google.com>,
        kernel test robot <oliver.sang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Expose usb device state to userland as the information is useful in
detecting non-compliant setups and diagnosing enumeration failures.
For example:
- End-to-end signal integrity issues: the device would fail port reset
  repeatedly and thus be stuck in POWERED state.
- Charge-only cables (missing D+/D- lines): the device would never enter
  POWERED state as the HC would not see any pullup.

What's the status quo?
We do have error logs such as "Cannot enable. Maybe the USB cable is bad?"
to flag potential setup issues, but there's no good way to expose them to
userspace.

Why add a sysfs entry in struct usb_port instead of struct usb_device?
The struct usb_device is not device_add() to the system until it's in
ADDRESS state hence we would miss the first two states. The struct
usb_port is a better place to keep the information because its life
cycle is longer than the struct usb_device that is attached to the port.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202306042228.e532af6e-oliver.sang@intel.com
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Roy Luo <royluo@google.com>
---
This patch comes directly from RFC v2 after being reviewed by Alan Stern
Link: https://lore.kernel.org/all/20230531010134.1092942-1-royluo@google.com/
More discussion about implementation options is in RFC v1
Link: https://lore.kernel.org/all/20230525173818.219633-1-royluo@google.com/

Changes since v1:
* Address Alan Stern's comment: remove redundant NULL initializers in
  update_port_device_state().

Changes since v2:
* Fix "BUG: sleeping function called from invalid context" caught by
  kernel test robot. Move sleeping function sysfs_get_dirent to port
  initialization and keep the kernfs_node for future reference.
  (Reviewed-by tag is reset as this patch involves more code changes)

Changes since v3:
* Add Alan Stern's Reviewed-by tag.
* Update ABI documentation: update date, comply to char limit per
  line and specify the attribute is pollable.
* Address Greg Kroah-Hartman's comment: use sysfs_emit() instead of
  sprintf().
---
 Documentation/ABI/testing/sysfs-bus-usb | 10 ++++++++
 drivers/usb/core/hub.c                  | 15 ++++++++++++
 drivers/usb/core/hub.h                  |  4 ++++
 drivers/usb/core/port.c                 | 32 +++++++++++++++++++++----
 4 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index cb172db41b34..be663258b9b7 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -292,6 +292,16 @@ Description:
 		which is marked with early_stop has failed to initialize, it will ignore
 		all future connections until this attribute is clear.
 
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/state
+Date:		June 2023
+Contact:	Roy Luo <royluo@google.com>
+Description:
+		Indicates current state of the USB device attached to the port.
+		Valid states are: 'not-attached', 'attached', 'powered',
+		'reconnecting', 'unauthenticated', 'default', 'addressed',
+		'configured', and 'suspended'. This file supports poll() to
+		monitor the state change from user space.
+
 What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
 Date:		May 2013
 Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 97a0f8faea6e..a739403a9e45 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2018,6 +2018,19 @@ bool usb_device_is_owned(struct usb_device *udev)
 	return !!hub->ports[udev->portnum - 1]->port_owner;
 }
 
+static void update_port_device_state(struct usb_device *udev)
+{
+	struct usb_hub *hub;
+	struct usb_port *port_dev;
+
+	if (udev->parent) {
+		hub = usb_hub_to_struct_hub(udev->parent);
+		port_dev = hub->ports[udev->portnum - 1];
+		WRITE_ONCE(port_dev->state, udev->state);
+		sysfs_notify_dirent(port_dev->state_kn);
+	}
+}
+
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 {
 	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
@@ -2030,6 +2043,7 @@ static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 	if (udev->state == USB_STATE_SUSPENDED)
 		udev->active_duration -= jiffies;
 	udev->state = USB_STATE_NOTATTACHED;
+	update_port_device_state(udev);
 }
 
 /**
@@ -2086,6 +2100,7 @@ void usb_set_device_state(struct usb_device *udev,
 				udev->state != USB_STATE_SUSPENDED)
 			udev->active_duration += jiffies;
 		udev->state = new_state;
+		update_port_device_state(udev);
 	} else
 		recursively_mark_NOTATTACHED(udev);
 	spin_unlock_irqrestore(&device_state_lock, flags);
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index e23833562e4f..37897afd1b64 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -84,6 +84,8 @@ struct usb_hub {
  * @peer: related usb2 and usb3 ports (share the same connector)
  * @req: default pm qos request for hubs without port power control
  * @connect_type: port's connect type
+ * @state: device state of the usb device attached to the port
+ * @state_kn: kernfs_node of the sysfs attribute that accesses @state
  * @location: opaque representation of platform connector location
  * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
  * @portnum: port index num based one
@@ -100,6 +102,8 @@ struct usb_port {
 	struct usb_port *peer;
 	struct dev_pm_qos_request *req;
 	enum usb_port_connect_type connect_type;
+	enum usb_device_state state;
+	struct kernfs_node *state_kn;
 	usb_port_location_t location;
 	struct mutex status_lock;
 	u32 over_current_count;
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 06a8f1f84f6f..77be0dc28da9 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -160,6 +160,16 @@ static ssize_t connect_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(connect_type);
 
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+	enum usb_device_state state = READ_ONCE(port_dev->state);
+
+	return sysfs_emit(buf, "%s\n", usb_state_string(state));
+}
+static DEVICE_ATTR_RO(state);
+
 static ssize_t over_current_count_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
@@ -259,6 +269,7 @@ static DEVICE_ATTR_RW(usb3_lpm_permit);
 
 static struct attribute *port_dev_attrs[] = {
 	&dev_attr_connect_type.attr,
+	&dev_attr_state.attr,
 	&dev_attr_location.attr,
 	&dev_attr_quirks.attr,
 	&dev_attr_over_current_count.attr,
@@ -705,19 +716,24 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		return retval;
 	}
 
+	port_dev->state_kn = sysfs_get_dirent(port_dev->dev.kobj.sd, "state");
+	if (!port_dev->state_kn) {
+		dev_err(&port_dev->dev, "failed to sysfs_get_dirent 'state'\n");
+		retval = -ENODEV;
+		goto err_unregister;
+	}
+
 	/* Set default policy of port-poweroff disabled. */
 	retval = dev_pm_qos_add_request(&port_dev->dev, port_dev->req,
 			DEV_PM_QOS_FLAGS, PM_QOS_FLAG_NO_POWER_OFF);
 	if (retval < 0) {
-		device_unregister(&port_dev->dev);
-		return retval;
+		goto err_put_kn;
 	}
 
 	retval = component_add(&port_dev->dev, &connector_ops);
 	if (retval) {
 		dev_warn(&port_dev->dev, "failed to add component\n");
-		device_unregister(&port_dev->dev);
-		return retval;
+		goto err_put_kn;
 	}
 
 	find_and_link_peer(hub, port1);
@@ -754,6 +770,13 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 		port_dev->req = NULL;
 	}
 	return 0;
+
+err_put_kn:
+	sysfs_put(port_dev->state_kn);
+err_unregister:
+	device_unregister(&port_dev->dev);
+
+	return retval;
 }
 
 void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
@@ -765,5 +788,6 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	if (peer)
 		unlink_peers(port_dev, peer);
 	component_del(&port_dev->dev, &connector_ops);
+	sysfs_put(port_dev->state_kn);
 	device_unregister(&port_dev->dev);
 }

base-commit: 933174ae28ba72ab8de5b35cb7c98fc211235096
-- 
2.41.0.rc0.172.g3f132b7071-goog

