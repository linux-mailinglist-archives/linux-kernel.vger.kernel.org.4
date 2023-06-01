Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437B671F65C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 01:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjFAXFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 19:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjFAXFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 19:05:19 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC22313D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 16:05:17 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id 71dfb90a1353d-456fe20f7f4so412355e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 16:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685660717; x=1688252717;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IlZFrfrzvRhOMg42VULn4bk5PFVF4CJM9Ngh05xbmjc=;
        b=fqywCEnGD6JPUqK6MFZ5TP/gVQOIrLigQrvef9KWQCk0jkChdZ1KOQWfL9L4oKlHzd
         X4qH3HDa3dHAm/S0Sfme5N8EgMavnlVnXGTw/PXjoseyGY2b35XRqL9Ejo9/K7Mox8or
         kbgCDspX/mN22zRmldWz2ckmhqLEZpV2AHzLT/VdzXGDNUDfH9A0SpvRYhHVxikKl3he
         guum/8tG4uHxdahIEHaCThgY4aZ2vINq5S5LcTlM2b0gD598MwLSeEoEKwaDd9xCtEB0
         mySOSqTJMY2fs7WTClhBaRsCb81wWc4OIsQFZGYFJBaQ75c/jLMzt8YFr/0qB3d+O6L4
         3bCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685660717; x=1688252717;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IlZFrfrzvRhOMg42VULn4bk5PFVF4CJM9Ngh05xbmjc=;
        b=CN0Z41jd+r4jstqBtJPtWW1uo/PUQPuL3Jm6PU/be8WrAtsnjNYFP64BlKJiyIoFgS
         ExR7inC3FqwsGU7qtppyuVd68A5Fi3nDOny88rpuP8DLC9OAtZ+bp+xuUJm1eFxsx20M
         jJJB+DPJbThkfsVzYz8dMIbu9YS8xfErtHeX1pAm3JehYwRaa8tVM/yNvdiUjoX6pdQe
         QvqNacmT3BMFc/h1jVMlefKOWNmSZOntffbDpm/cDKtaxVNEAuaSCPwAZF0N+GCb/Kti
         wmLeoo25RRUbGWlz1waF3gICspD+aJ1nKK+b298LX9mzCQwO4PSgPZ0lJ7e/QQbD21Yd
         XOCA==
X-Gm-Message-State: AC+VfDwRJO5Mvb3EisJPVB1m+bSMFFZGHxFCAbzBA4DDJpk0MQUcgeMC
        zgGYFSiDSO7VEHn+2X/2HvrYNLoD0jM=
X-Google-Smtp-Source: ACHHUZ6r0REYWwNVEIeWkcA9KLEIXn7432kDW+8BWdi+qz3ed4Sm4iJ/Gec/hG+D4Kk+hsvcLXQdl6Pq3d4=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a1f:2f90:0:b0:440:5dee:5712 with SMTP id
 v138-20020a1f2f90000000b004405dee5712mr2298808vkv.1.1685660717011; Thu, 01
 Jun 2023 16:05:17 -0700 (PDT)
Date:   Thu,  1 Jun 2023 23:04:56 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230601230456.2234972-1-royluo@google.com>
Subject: [PATCH v1] usb: core: add sysfs entry for usb device state
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
        Roy Luo <royluo@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Roy Luo <royluo@google.com>
---
This patch comes directly from RFC v2 after being reviewed by Alan Stern
Link: https://lore.kernel.org/all/20230531010134.1092942-1-royluo@google.com/
More discussion about implementation options is in RFC v1
Link: https://lore.kernel.org/all/20230525173818.219633-1-royluo@google.com/
---
 Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++++
 drivers/usb/core/hub.c                  | 19 +++++++++++++++++++
 drivers/usb/core/hub.h                  |  2 ++
 drivers/usb/core/port.c                 | 11 +++++++++++
 4 files changed, 41 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index cb172db41b34..155770f18f9c 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -292,6 +292,15 @@ Description:
 		which is marked with early_stop has failed to initialize, it will ignore
 		all future connections until this attribute is clear.
 
+What:		/sys/bus/usb/devices/.../<hub_interface>/port<X>/state
+Date:		May 2023
+Contact:	Roy Luo <royluo@google.com>
+Description:
+		Indicates current state of the USB device attached to the port. Valid
+		states are: 'not-attached', 'attached', 'powered',
+		'reconnecting', 'unauthenticated', 'default', 'addressed',
+		'configured', and 'suspended'.
+
 What:		/sys/bus/usb/devices/.../power/usb2_lpm_l1_timeout
 Date:		May 2013
 Contact:	Mathias Nyman <mathias.nyman@linux.intel.com>
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 97a0f8faea6e..35d94288726b 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2018,6 +2018,23 @@ bool usb_device_is_owned(struct usb_device *udev)
 	return !!hub->ports[udev->portnum - 1]->port_owner;
 }
 
+static void update_port_device_state(struct usb_device *udev)
+{
+	struct usb_port *port_dev = NULL;
+	struct usb_hub *hub = NULL;
+	struct kernfs_node *state_node = NULL;
+
+	if (udev->parent) {
+		hub = usb_hub_to_struct_hub(udev->parent);
+		port_dev = hub->ports[udev->portnum - 1];
+		WRITE_ONCE(port_dev->state, udev->state);
+		state_node = sysfs_get_dirent(port_dev->dev.kobj.sd, "state");
+		if (state_node) {
+			sysfs_notify_dirent(state_node);
+		}
+	}
+}
+
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 {
 	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
@@ -2030,6 +2047,7 @@ static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 	if (udev->state == USB_STATE_SUSPENDED)
 		udev->active_duration -= jiffies;
 	udev->state = USB_STATE_NOTATTACHED;
+	update_port_device_state(udev);
 }
 
 /**
@@ -2086,6 +2104,7 @@ void usb_set_device_state(struct usb_device *udev,
 				udev->state != USB_STATE_SUSPENDED)
 			udev->active_duration += jiffies;
 		udev->state = new_state;
+		update_port_device_state(udev);
 	} else
 		recursively_mark_NOTATTACHED(udev);
 	spin_unlock_irqrestore(&device_state_lock, flags);
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index e23833562e4f..cd13fe189726 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -84,6 +84,7 @@ struct usb_hub {
  * @peer: related usb2 and usb3 ports (share the same connector)
  * @req: default pm qos request for hubs without port power control
  * @connect_type: port's connect type
+ * @state: device state of the usb device attached to the port
  * @location: opaque representation of platform connector location
  * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
  * @portnum: port index num based one
@@ -100,6 +101,7 @@ struct usb_port {
 	struct usb_port *peer;
 	struct dev_pm_qos_request *req;
 	enum usb_port_connect_type connect_type;
+	enum usb_device_state state;
 	usb_port_location_t location;
 	struct mutex status_lock;
 	u32 over_current_count;
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 06a8f1f84f6f..745f2a3aafba 100644
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
+	return sprintf(buf, "%s\n", usb_state_string(state));
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

base-commit: 933174ae28ba72ab8de5b35cb7c98fc211235096
-- 
2.41.0.rc0.172.g3f132b7071-goog

