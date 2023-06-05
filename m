Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A65723290
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFEVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFEVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:55:35 -0400
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A4A102
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:55:33 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id ada2fe7eead31-439756a5e99so862492137.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 14:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686002132; x=1688594132;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYQuGPh6MWx4TKIybC1sfuSbzmExcI9Rq3XqSW+WB34=;
        b=OWr9O+hDja1w2sHtP8jyUvLQmyz0G5Vp+Dbfh2KrCM5SPhMo+R4T9XmV4xPZLmaKkb
         gtjL1QgxgNGegLW5WgOBbw+9oJho7P9PDglDqo4jBeGnky+/j0VnhYs+0LnYL3vhBX+r
         cUWGvQGddIBt2MJxX7CzqiHChMtVVyo/zOsgsVtpHk3XEVFgCUXoE/C9ZinANYjuvpsj
         5BhVHJ5KxDOU/GCygz+jUVshJ+VAHq2WIRqERDlsNElqMX2EboPT8eLBSB2ZYaKvBmyI
         F549Y5F29S+HqZXqh6KV1gwL+WgYnJG1QJQJYEZnevz5SjzP8QHPeja90T6I+xWzA4VQ
         BGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686002132; x=1688594132;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYQuGPh6MWx4TKIybC1sfuSbzmExcI9Rq3XqSW+WB34=;
        b=B0OmtjxBxALas4pjDKgOEv47NDuxBEI9iZ8z02fSFygEZzJD1vbZqSfwlbPMUcx+Di
         RTkz2Oco1OFGHGLiacBJuebD1LiYYZKU29PpVex+ONsUjGo8QREVNBAAj9ZerRillZQw
         E4bUI6O9KnP+Oq5+EdfnR8WC7bMiHv1SCEOrgzscktdg8PBNWUG2K+CqEqtbI3NWG9m+
         YAWp0pFPMQOF4PxG2sGLiWt1SJTQr2mZn9gNyb2hqTtclZr8zdY3k2balbsMvebvtqEL
         KPl8VZvu4/ZTsjznOMeZstVdA3U6R8sqyxLObxLk470ZZa1ukcjqeQr3Bm23CyKmX+bu
         eaKg==
X-Gm-Message-State: AC+VfDzKf9LcTNCXCWRmqA80X8xzrbBZ0BvcE0OM82Frszup4zxMEm7E
        FBLyK8yN962tEoaeNlV+OROypd6amgc=
X-Google-Smtp-Source: ACHHUZ4Ku5zpLqIcM5QLnW8SY+fLX/cJpsaUtqzg9pPg5pnw/jk1QR2T/2fYhCpn1GN0iHVU2hRPqRlNNtw=
X-Received: from royluo-cloudtop0.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:bb8])
 (user=royluo job=sendgmr) by 2002:a67:d814:0:b0:43b:36d1:f0a3 with SMTP id
 e20-20020a67d814000000b0043b36d1f0a3mr329577vsj.3.1686002132548; Mon, 05 Jun
 2023 14:55:32 -0700 (PDT)
Date:   Mon,  5 Jun 2023 21:55:28 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.rc0.172.g3f132b7071-goog
Message-ID: <20230605215529.195045-1-royluo@google.com>
Subject: [PATCH v3] usb: core: add sysfs entry for usb device state
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
  initiailzation and keep the kernfs_node for future reference.
  (Reviewed-by tag is reset as this patch involves more code changes)
---
 Documentation/ABI/testing/sysfs-bus-usb |  9 +++++++
 drivers/usb/core/hub.c                  | 15 ++++++++++++
 drivers/usb/core/hub.h                  |  4 ++++
 drivers/usb/core/port.c                 | 32 +++++++++++++++++++++----
 4 files changed, 56 insertions(+), 4 deletions(-)

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
index 06a8f1f84f6f..2f906e89054e 100644
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

