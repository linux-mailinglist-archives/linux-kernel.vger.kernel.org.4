Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110BC71128A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235487AbjEYRlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYRlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:41:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D622A1A1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:41:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-babb51cb4d4so1666309276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685036465; x=1687628465;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X23gKFEZT8DFV9NTcTfq0NoCckUC9kSkPSFA3d5vAAM=;
        b=4MkrvE29ZOfRI6CIHrIHK1q0Rl2HlLW075NHo6JcQrnGRfVFjHyQ2NYo2ynSo3iYSz
         m+aWqQEOBN0xuoLa5LPYBT2imayyCHPDv9VshSiIIGKb/pN3lABjAOw3r9ukwofIDgom
         sR1OxFI6CZFYGRj34YfzvrAsM8kEqnuvS+wAp1Zr46+GM2UtjU6pVmRLUZw3W8wTHNrk
         ntHxp2UJsAw2e+l5006NnBu6TYMnNjazuayT6Bff991YId1MogUOD5Srsw46xkZ7UEg7
         j3X5eC8B5FnAykLlIqbyPJzdrW1aapbGrP62uHWxdqQUZc0jBr2+iTR29EoCPWBkbR6s
         jk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685036465; x=1687628465;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X23gKFEZT8DFV9NTcTfq0NoCckUC9kSkPSFA3d5vAAM=;
        b=YsYQjn42LUSM6PgCSU1FR1HRtfGys54iVAq489elVLVlPfLEcwsLYIyMP7SmtwsM5X
         hB6oBDt5K5H4R+CczrHps27GvDw/5UFAqge57L4RbNsnZJA/ixRvz33mK8P8Iykn5wsH
         /4fORj9kr2tZnWhVYJwthCGjwBycVUkddshhRwH58iYSZhwQ9WU82G2HvfKxA1mzyPHa
         fWVrUOOu0L/9Dk+G1PWiIf+vqbfUR8kAWLxNSzo7ms7geR/VJdyl9ctlfsNWj9BH7+WB
         2cq+2rg2sNoLVbIAjnwJ5tzO682i/40LUNJFcKne9+9rDsChjIiwAqi4odhLw1zKFLsB
         BzAQ==
X-Gm-Message-State: AC+VfDyht38VSXsoW77SQAcTUkoHZ1NxCE1eA4yNKlO7JEs4iZSx1TGL
        FUfp4fn+gpD57rE20lqT6tUqndOQTGo=
X-Google-Smtp-Source: ACHHUZ6fodKp9XFABIlsgXUk3xeSE+Ahkd77UL4WmykzzMbx2pJHhn6Htmo+grKsyZOdLfxzk0LHBwP55lA=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a05:6902:118e:b0:ba8:9653:c948 with SMTP id
 m14-20020a056902118e00b00ba89653c948mr2007334ybu.3.1685036465026; Thu, 25 May
 2023 10:41:05 -0700 (PDT)
Date:   Thu, 25 May 2023 17:38:18 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230525173818.219633-1-royluo@google.com>
Subject: [RFC PATCH v1] usb: core: add sysfs entry for usb device state
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

Signed-off-by: Roy Luo <royluo@google.com>
---
 Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++++
 drivers/usb/core/hub.c                  | 18 ++++++++++++++++++
 drivers/usb/core/hub.h                  |  5 +++++
 drivers/usb/core/port.c                 | 23 +++++++++++++++++++++++
 4 files changed, 55 insertions(+)

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
index 97a0f8faea6e..69de87c6ae9d 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2018,6 +2018,18 @@ bool usb_device_is_owned(struct usb_device *udev)
 	return !!hub->ports[udev->portnum - 1]->port_owner;
 }
 
+static void notify_port_device_state(struct usb_device *udev)
+{
+	struct usb_port *port_dev = NULL;
+	struct usb_hub *hub = NULL;
+
+	if (udev->parent) {
+		hub = usb_hub_to_struct_hub(udev->parent);
+		port_dev = hub->ports[udev->portnum - 1];
+		schedule_work(&port_dev->work);
+	}
+}
+
 static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 {
 	struct usb_hub *hub = usb_hub_to_struct_hub(udev);
@@ -2030,6 +2042,7 @@ static void recursively_mark_NOTATTACHED(struct usb_device *udev)
 	if (udev->state == USB_STATE_SUSPENDED)
 		udev->active_duration -= jiffies;
 	udev->state = USB_STATE_NOTATTACHED;
+	notify_port_device_state(udev);
 }
 
 /**
@@ -2086,6 +2099,7 @@ void usb_set_device_state(struct usb_device *udev,
 				udev->state != USB_STATE_SUSPENDED)
 			udev->active_duration += jiffies;
 		udev->state = new_state;
+		notify_port_device_state(udev);
 	} else
 		recursively_mark_NOTATTACHED(udev);
 	spin_unlock_irqrestore(&device_state_lock, flags);
@@ -2252,6 +2266,8 @@ void usb_disconnect(struct usb_device **pdev)
 		 */
 		if (!test_and_set_bit(port1, hub->child_usage_bits))
 			pm_runtime_get_sync(&port_dev->dev);
+
+		port_dev->state = NULL;
 	}
 
 	usb_remove_ep_devs(&udev->ep0);
@@ -5315,6 +5331,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 			goto done;
 		}
 
+		port_dev->state = &udev->state;
 		usb_set_device_state(udev, USB_STATE_POWERED);
 		udev->bus_mA = hub->mA_per_port;
 		udev->level = hdev->level + 1;
@@ -5437,6 +5454,7 @@ static void hub_port_connect(struct usb_hub *hub, int port1, u16 portstatus,
 			mutex_unlock(hcd->address0_mutex);
 			usb_unlock_port(port_dev);
 		}
+		port_dev->state = NULL;
 		usb_put_dev(udev);
 		if ((status == -ENOTCONN) || (status == -ENOTSUPP))
 			break;
diff --git a/drivers/usb/core/hub.h b/drivers/usb/core/hub.h
index e23833562e4f..110143568c77 100644
--- a/drivers/usb/core/hub.h
+++ b/drivers/usb/core/hub.h
@@ -84,8 +84,10 @@ struct usb_hub {
  * @peer: related usb2 and usb3 ports (share the same connector)
  * @req: default pm qos request for hubs without port power control
  * @connect_type: port's connect type
+ * @state: device state of the usb device attached to the port
  * @location: opaque representation of platform connector location
  * @status_lock: synchronize port_event() vs usb_port_{suspend|resume}
+ * @work: workqueue for sysfs_notify()
  * @portnum: port index num based one
  * @is_superspeed cache super-speed status
  * @usb3_lpm_u1_permit: whether USB3 U1 LPM is permitted.
@@ -100,8 +102,10 @@ struct usb_port {
 	struct usb_port *peer;
 	struct dev_pm_qos_request *req;
 	enum usb_port_connect_type connect_type;
+	enum usb_device_state	*state;
 	usb_port_location_t location;
 	struct mutex status_lock;
+	struct work_struct work;
 	u32 over_current_count;
 	u8 portnum;
 	u32 quirks;
@@ -114,6 +118,7 @@ struct usb_port {
 
 #define to_usb_port(_dev) \
 	container_of(_dev, struct usb_port, dev)
+#define work_to_usb_port(w)	(container_of((w), struct usb_port, work))
 
 extern int usb_hub_create_port_device(struct usb_hub *hub,
 		int port1);
diff --git a/drivers/usb/core/port.c b/drivers/usb/core/port.c
index 06a8f1f84f6f..7f3430170115 100644
--- a/drivers/usb/core/port.c
+++ b/drivers/usb/core/port.c
@@ -160,6 +160,19 @@ static ssize_t connect_type_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(connect_type);
 
+static ssize_t state_show(struct device *dev,
+			  struct device_attribute *attr, char *buf)
+{
+	struct usb_port *port_dev = to_usb_port(dev);
+	enum usb_device_state state = USB_STATE_NOTATTACHED;
+
+	if (port_dev->state)
+		state = *port_dev->state;
+
+	return sprintf(buf, "%s\n",  usb_state_string(state));
+}
+static DEVICE_ATTR_RO(state);
+
 static ssize_t over_current_count_show(struct device *dev,
 				       struct device_attribute *attr, char *buf)
 {
@@ -259,6 +272,7 @@ static DEVICE_ATTR_RW(usb3_lpm_permit);
 
 static struct attribute *port_dev_attrs[] = {
 	&dev_attr_connect_type.attr,
+	&dev_attr_state.attr,
 	&dev_attr_location.attr,
 	&dev_attr_quirks.attr,
 	&dev_attr_over_current_count.attr,
@@ -666,6 +680,13 @@ static const struct component_ops connector_ops = {
 	.unbind = connector_unbind,
 };
 
+static void usb_port_state_work(struct work_struct *work)
+{
+	struct usb_port *port_dev = work_to_usb_port(work);
+
+	sysfs_notify(&port_dev->dev.kobj, NULL, "state");
+}
+
 int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 {
 	struct usb_port *port_dev;
@@ -699,6 +720,7 @@ int usb_hub_create_port_device(struct usb_hub *hub, int port1)
 	dev_set_name(&port_dev->dev, "%s-port%d", dev_name(&hub->hdev->dev),
 			port1);
 	mutex_init(&port_dev->status_lock);
+	INIT_WORK(&port_dev->work, usb_port_state_work);
 	retval = device_register(&port_dev->dev);
 	if (retval) {
 		put_device(&port_dev->dev);
@@ -764,6 +786,7 @@ void usb_hub_remove_port_device(struct usb_hub *hub, int port1)
 	peer = port_dev->peer;
 	if (peer)
 		unlink_peers(port_dev, peer);
+	flush_work(&port_dev->work);
 	component_del(&port_dev->dev, &connector_ops);
 	device_unregister(&port_dev->dev);
 }

base-commit: 933174ae28ba72ab8de5b35cb7c98fc211235096
-- 
2.41.0.rc0.172.g3f132b7071-goog

