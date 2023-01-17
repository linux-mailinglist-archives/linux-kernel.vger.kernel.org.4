Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4D766E1EA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 16:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjAQPRz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 17 Jan 2023 10:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbjAQPRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 10:17:32 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4BC841B4A;
        Tue, 17 Jan 2023 07:17:26 -0800 (PST)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id ACAE5FF80C;
        Tue, 17 Jan 2023 15:17:23 +0000 (UTC)
Message-ID: <d9f8b9413c10fcf067658979d16a4f5c7abe69e7.camel@hadess.net>
Subject: [RFC] USB: core: Add wireless_status sysfs attribute
From:   Bastien Nocera <hadess@hadess.net>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Date:   Tue, 17 Jan 2023 16:17:23 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

TLDR: new sysfs attribute that makes it possible to leave receivers for
wireless headsets plugged in. At the USB level, or at the base driver
level?

Longer version:
I started working on implementing support for some wireless headsets
that use USB receivers to communicate to the headset itself.

The USB receivers have multiple interfaces, and independent drivers for
each, as is wont to do for USB devices. There's usually a HID interface
to do the custom stuff (LEDs, battery status, connection status, etc.)
and a standard audio class interface.

Those drivers don't know anything about each other, and getting them to
talk to each other would be rather complicated. Additionally the audio
interface is still somewhat functional when the headset is
disconnected.

In the end, I came up with this new sysfs attribute that would make it
possible for user-space (PulseAudio or Pipewire) to know whether the
receiver is plugged in or not.

That allows user-space to not show the battery information for the
device (rather than 0 percent), not offer the headset as an output, and
potentially automatically switch to it when the headset is powered on.

The question is whether this should be a USB sysfs attribute, or one at
the base driver level. Example implementation of the USB sysfs
attribute itself below.

I have a patch for a USB API as well, but I'm having some problems
creating deferred work on a soft irq.

Cheers

----
Add a wireless_status sysfs attribute to USB devices to keep track of
whether a USB device that uses a receiver/emitter combo has its
emitter connected or disconnected.

By default, the USB device will declare not to use a receiver/emitter.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 Documentation/ABI/testing/sysfs-bus-usb | 11 ++++++
 drivers/usb/core/sysfs.c                | 50 +++++++++++++++++++++++++
 drivers/usb/core/usb.h                  |  1 +
 include/linux/usb.h                     |  9 +++++
 4 files changed, 71 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index 568103d3376e..23ba756d40f7 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -166,6 +166,17 @@ Description:
                The file will be present for all speeds of USB devices, and will
                always read "no" for USB 1.1 and USB 2.0 devices.
 
+What:          /sys/bus/usb/devices/.../wireless_status
+Date:          December 2022
+Contact:       Bastien Nocera <hadess@hadess.net>
+Description:
+               Some USB devices use a small USB receiver coupled with a larger
+               wireless device, usually communicating using proprietary
+               wireless protocols. This attribute will read either "connected"
+               or "disconnected" depending on whether the emitter is turned on,
+               in range and connected. If the device does not use a receiver/
+               emitter combo, then this attribute will not exist.
+
 What:          /sys/bus/usb/devices/.../<hub_interface>/port<X>
 Date:          August 2012
 Contact:       Lan Tianyu <tianyu.lan@intel.com>
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index 631574718d8a..6e963fc9ed73 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -849,12 +849,62 @@ static const struct attribute_group dev_string_attr_grp = {
        .is_visible =   dev_string_attrs_are_visible,
 };
 
+static ssize_t wireless_status_show(struct device *dev,
+                                   struct device_attribute *attr, char *buf)
+{
+       struct usb_device *udev;
+
+       udev = to_usb_device(dev);
+       if (udev->wireless_status == USB_WIRELESS_STATUS_DISCONNECTED)
+               return sysfs_emit(buf, "%s\n", "disconnected");
+       return sysfs_emit(buf, "%s\n", "connected");
+}
+static DEVICE_ATTR_RO(wireless_status);
+
+static struct attribute *dev_wireless_status_attrs[] = {
+       &dev_attr_wireless_status.attr,
+       NULL
+};
+
+static umode_t dev_wireless_status_attr_is_visible(struct kobject *kobj,
+               struct attribute *a, int n)
+{
+       struct device *dev = kobj_to_dev(kobj);
+       struct usb_device *udev = to_usb_device(dev);
+
+       if (a != &dev_attr_wireless_status.attr ||
+           udev->wireless_status != USB_WIRELESS_STATUS_NA)
+               return a->mode;
+       return 0;
+}
+
+static const struct attribute_group dev_wireless_status_attr_grp = {
+       .attrs =        dev_wireless_status_attrs,
+       .is_visible =   dev_wireless_status_attr_is_visible,
+};
+
 const struct attribute_group *usb_device_groups[] = {
        &dev_attr_grp,
        &dev_string_attr_grp,
+       &dev_wireless_status_attr_grp,
        NULL
 };
 
+int usb_update_wireless_status_attr(struct usb_device *udev)
+{
+       struct device *dev = &udev->dev;
+       int ret;
+
+       ret = sysfs_update_group(&dev->kobj, &dev_wireless_status_attr_grp);
+       if (ret < 0)
+               return ret;
+
+       sysfs_notify(&dev->kobj, NULL, "wireless_status");
+       kobject_uevent(&dev->kobj, KOBJ_CHANGE);
+
+       return 0;
+}
+
 /* Binary descriptors */
 
 static ssize_t
diff --git a/drivers/usb/core/usb.h b/drivers/usb/core/usb.h
index 0eac7d4285d1..33d42d1b7d99 100644
--- a/drivers/usb/core/usb.h
+++ b/drivers/usb/core/usb.h
@@ -13,6 +13,7 @@ struct usb_dev_state;
 
 extern int usb_create_sysfs_dev_files(struct usb_device *dev);
 extern void usb_remove_sysfs_dev_files(struct usb_device *dev);
+extern int usb_update_wireless_status_attr(struct usb_device *dev);
 extern void usb_create_sysfs_intf_files(struct usb_interface *intf);
 extern void usb_remove_sysfs_intf_files(struct usb_interface *intf);
 extern int usb_create_ep_devs(struct device *parent,
diff --git a/include/linux/usb.h b/include/linux/usb.h
index d2d2f41052c0..0c527cbd7165 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -545,6 +545,12 @@ struct usb3_lpm_parameters {
        int timeout;
 };
 
+enum usb_wireless_status {
+       USB_WIRELESS_STATUS_NA = 0,
+       USB_WIRELESS_STATUS_DISCONNECTED,
+       USB_WIRELESS_STATUS_CONNECTED,
+};
+
 /**
  * struct usb_device - kernel's representation of a USB device
  * @devnum: device number; address on a USB bus
@@ -620,6 +626,8 @@ struct usb3_lpm_parameters {
  *     parent->hub_delay + wHubDelay + tTPTransmissionDelay (40ns)
  *     Will be used as wValue for SetIsochDelay requests.
  * @use_generic_driver: ask driver core to reprobe using the generic driver.
+ * @wireless_status: if the USB device uses a receiver/emitter combo, whether
+ *     the emitter is connected.
  *
  * Notes:
  * Usbcore drivers should not set usbdev->state directly.  Instead use
@@ -708,6 +716,7 @@ struct usb_device {
 
        u16 hub_delay;
        unsigned use_generic_driver:1;
+       enum usb_wireless_status wireless_status;
 };
 #define        to_usb_device(d) container_of(d, struct usb_device, dev)
 
-- 
2.39.0

