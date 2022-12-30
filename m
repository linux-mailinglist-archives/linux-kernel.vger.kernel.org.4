Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7057C659AC0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiL3Q67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiL3Q64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:58:56 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959851902A;
        Fri, 30 Dec 2022 08:58:54 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso15532406wmp.3;
        Fri, 30 Dec 2022 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9G6+nCXkkfebDXlUHMh5k/k9oHbib4EA4eUdzC/Ay80=;
        b=lAaOvCABfC6FnTPD2744UVr0WTS18u804Driw/BO5jw1xKzuuauUuG/LcRQjcUqa96
         oQbXG8ow4qsvIHHxJGobDwmB4kndXPLiwLCWtzDP/Qt9lhnZGvD33wlFaYmn5k4BHWMj
         hb+hSpcWyAJkfFMpLl5ydwLtDVuQUt8MvfEYFfafTWsP4csBbxuqtTDCeSETxh22kRjt
         aQAslQztb4VxABdOHgNpe7leUxHt0T3t5T8+r+UpWYm05EFQaTAC/ZaIKXUWZ9+xeY/C
         QBiqISPnc9113CS0fI6OtvY4gQSso7e42WBiJKnVQL3slnwQtRXV5GCIUuXSluTQZeHS
         qf6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9G6+nCXkkfebDXlUHMh5k/k9oHbib4EA4eUdzC/Ay80=;
        b=OJet85Z2Rp13Q0npzxdI2lLoVJuKVy+V9nH3tf9rdivrrcxGGeshr87qOVdPM2XW8p
         5ACUIxq0LmveBst3ZFy6U8CUmnuNQgRxJLpqAxti/VUOMM64mDZ7LyY7rQW4UjbvWyrn
         TMmT2yraC2+50q0skjYQ6kflcnHVu1X3MqoWswXAtfVmwzvs26U2VBeMsY5Ln1NHPHCS
         bibbJ2Zgn4A1h7agyINC2nVRNocOltfwkGM1BpD0icGp7kVN2IaiWpbgvmlv8ywLOxK5
         agNJzaHs7tLFPtuwH2l0MkvVv1p/YdcnG9DwWXaz8wcheb3qCmjRxWdBYKi3kPWKi5Vx
         rC3w==
X-Gm-Message-State: AFqh2krbKjvesPHI9z2Mr8wyhWWZhPjcKMGYMEZ4soN/RwBR5+2xe1PZ
        iD19zY5415bZupk4YAmXCY3BCW3ebKc=
X-Google-Smtp-Source: AMrXdXv4VoIAAvM8NiyyI6R1M4Hk6E9qW4AiparLJNK+2LCO+FAUGC/NRI0bJCY8goiLLOfBEmLFEQ==
X-Received: by 2002:a05:600c:34cf:b0:3d0:7415:c5a9 with SMTP id d15-20020a05600c34cf00b003d07415c5a9mr23928320wmq.21.1672419532681;
        Fri, 30 Dec 2022 08:58:52 -0800 (PST)
Received: from jo-einhundert ([2a02:908:13d6:2180:90db:c970:8b1:67f2])
        by smtp.gmail.com with ESMTPSA id l7-20020a05600c4f0700b003d96c811d6dsm29198734wmq.30.2022.12.30.08.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 08:58:52 -0800 (PST)
Date:   Fri, 30 Dec 2022 17:58:51 +0100
From:   =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [PATCH] usb: gadget:  add WebUSB support
Message-ID: <Y68Yy26sQgV6QKxV@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a custom (non-USB IF) extension to the USB standard:

https://wicg.github.io/webusb/

This specification is published under the W3C Community Contributor
Agreement, which in particular allows to implement the specification
without any royalties.

The specification allows USB gadgets to announce an URL to landing
page and describes a Javascript interface for websites to interact
with the USB gadget, if the user allows it. It is currently
supported by Chromium-based browsers, such as Chrome, Edge and
Opera on all major operating systems including Linux.

This patch adds optional support for Linux-based USB gadgets
wishing to expose such a landing page.

During device enumeration, a host recognizes that the announced
USB version is at least 2.01, which means, that there are BOS
descriptors available. The device than announces WebUSB support
using a platform device capability. This includes a vendor code
under which the landing page URL can be retrieved using a
vendor-specific request.

Usage is modeled after os_desc descriptors:
echo 1 > webusb/use
echo "https://www.kernel.org" > webusb/landingPage

lsusb will report the device with the following lines:
  Platform Device Capability:
    bLength                24
    bDescriptorType        16
    bDevCapabilityType      5
    bReserved               0
    PlatformCapabilityUUID    {3408b638-09a9-47a0-8bfd-a0768815b665}
      WebUSB:
        bcdVersion    1.00
        bVendorCode      0
        iLandingPage     1 https://www.kernel.org

Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
---
 Documentation/ABI/testing/configfs-usb-gadget |  13 ++
 drivers/usb/gadget/composite.c                | 102 +++++++++++--
 drivers/usb/gadget/configfs.c                 | 139 ++++++++++++++++++
 include/linux/usb/composite.h                 |   6 +
 include/uapi/linux/usb/ch9.h                  |  33 +++++
 5 files changed, 283 insertions(+), 10 deletions(-)

diff --git a/Documentation/ABI/testing/configfs-usb-gadget b/Documentation/ABI/testing/configfs-usb-gadget
index b7943aa7e997..8399e0f0ed1c 100644
--- a/Documentation/ABI/testing/configfs-usb-gadget
+++ b/Documentation/ABI/testing/configfs-usb-gadget
@@ -143,3 +143,16 @@ Description:
 		qw_sign		an identifier to be reported as "OS String"
 				proper
 		=============	===============================================
+
+What:		/config/usb-gadget/gadget/webusb
+Date:		Dec 2022
+KernelVersion:	6.2
+Description:
+		This group contains "WebUSB" extension handling attributes.
+
+		=============	===============================================
+		use		flag turning "WebUSB" support on/off
+		bcdVersion	bcd WebUSB specification version number
+		b_vendor_code	one-byte value used for custom per-device
+		landing_page	UTF-8 encoded URL of the device's landing page
+		=============	===============================================
diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
index 403563c06477..937695dc5366 100644
--- a/drivers/usb/gadget/composite.c
+++ b/drivers/usb/gadget/composite.c
@@ -14,6 +14,7 @@
 #include <linux/device.h>
 #include <linux/utsname.h>
 #include <linux/bitfield.h>
+#include <linux/uuid.h>
 
 #include <linux/usb/composite.h>
 #include <linux/usb/otg.h>
@@ -713,14 +714,16 @@ static int bos_desc(struct usb_composite_dev *cdev)
 	 * A SuperSpeed device shall include the USB2.0 extension descriptor
 	 * and shall support LPM when operating in USB2.0 HS mode.
 	 */
-	usb_ext = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
-	bos->bNumDeviceCaps++;
-	le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
-	usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
-	usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
-	usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
-	usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
-					    USB_BESL_SUPPORT | besl);
+	if (cdev->gadget->lpm_capable) {
+		usb_ext = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
+		bos->bNumDeviceCaps++;
+		le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
+		usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
+		usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
+		usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
+		usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
+							USB_BESL_SUPPORT | besl);
+	}
 
 	/*
 	 * The Superspeed USB Capability descriptor shall be implemented by all
@@ -821,6 +824,41 @@ static int bos_desc(struct usb_composite_dev *cdev)
 		}
 	}
 
+	/*
+	 * Following the specifaction at:
+	 * https://wicg.github.io/webusb/#webusb-platform-capability-descriptor
+	 */
+	if (cdev->use_webusb) {
+		struct usb_webusb_cap_descriptor *webusb_cap;
+		/*
+		 * little endian PlatformCapablityUUID for WebUSB:
+		 * 3408b638-09a9-47a0-8bfd-a0768815b665
+		 */
+#define WEBUSB_UUID UUID_INIT(0x38b60834, 0xa909, 0xa047, \
+			      0x8b, 0xfd, 0xa0, 0x76, 0x88, 0x15, 0xb6, 0x65)
+		uuid_t webusb_uuid = WEBUSB_UUID;
+
+		webusb_cap = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
+		bos->bNumDeviceCaps++;
+
+		le16_add_cpu(&bos->wTotalLength, USB_DT_WEBUSB_SIZE);
+		webusb_cap->bLength = USB_DT_WEBUSB_SIZE;
+		webusb_cap->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
+		webusb_cap->bDevCapabilityType = USB_PLAT_DEV_CAP_TYPE;
+		webusb_cap->bReserved = 0;
+		export_uuid(webusb_cap->UUID, &webusb_uuid);
+		if (cdev->bcd_webusb_version != 0)
+			webusb_cap->bcdVersion = cpu_to_le16(cdev->bcd_webusb_version);
+		else
+			webusb_cap->bcdVersion = cpu_to_le16(0x0100);
+
+		webusb_cap->bVendorCode = cdev->b_webusb_vendor_code;
+		if (strnlen(cdev->landing_page, sizeof(cdev->landing_page)) > 0)
+			webusb_cap->iLandingPage = 1;
+		else
+			webusb_cap->iLandingPage = 0;
+	}
+
 	return le16_to_cpu(bos->wTotalLength);
 }
 
@@ -1744,7 +1782,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 					cdev->desc.bcdUSB = cpu_to_le16(0x0210);
 				}
 			} else {
-				if (gadget->lpm_capable)
+				if (gadget->lpm_capable || cdev->use_webusb)
 					cdev->desc.bcdUSB = cpu_to_le16(0x0201);
 				else
 					cdev->desc.bcdUSB = cpu_to_le16(0x0200);
@@ -1779,7 +1817,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			break;
 		case USB_DT_BOS:
 			if (gadget_is_superspeed(gadget) ||
-			    gadget->lpm_capable) {
+			    gadget->lpm_capable || cdev->use_webusb) {
 				value = bos_desc(cdev);
 				value = min(w_length, (u16) value);
 			}
@@ -2013,6 +2051,50 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
 			goto check_value;
 		}
 
+		/*
+		 * webusb descriptor handling, following:
+		 * https://wicg.github.io/webusb/#device-requests
+		 */
+		#define WEBUSB_GET_URL 2
+		if (cdev->use_webusb &&
+		    (ctrl->bRequestType & USB_TYPE_VENDOR) &&
+			ctrl->wIndex == WEBUSB_GET_URL &&
+			ctrl->bRequest == cdev->b_webusb_vendor_code) {
+			/*
+			 * specification of the url descriptor in WebUSB:
+			 * https://wicg.github.io/webusb/#webusb-descriptors
+			 */
+			u8				*buf;
+			unsigned int	schema_http;
+			unsigned int	schema_https;
+			unsigned int	landing_page_length;
+
+			buf = cdev->req->buf;
+			#define WEBUSB_URL 3
+			buf[1] = WEBUSB_URL;
+
+			landing_page_length = strnlen(cdev->landing_page, 252);
+			schema_https = (strncmp("https://", cdev->landing_page, 8) == 0);
+			schema_http = (strncmp("http://", cdev->landing_page, 7) == 0);
+			if (schema_https) {
+				buf[2] = 0x01;
+				memcpy(buf+3, cdev->landing_page+8, landing_page_length-8);
+				buf[0] = landing_page_length - 8 + 3;
+			} else if (schema_http) {
+				buf[2] = 0x00;
+				memcpy(buf+3, cdev->landing_page+7, landing_page_length-7);
+				buf[0] = landing_page_length - 7 + 3;
+			} else {
+				buf[2] = 0xFF;
+				memcpy(buf+3, cdev->landing_page, landing_page_length);
+				buf[0] = landing_page_length + 3;
+			}
+
+			value = buf[0];
+
+			goto check_value;
+		}
+
 		VDBG(cdev,
 			"non-core control req%02x.%02x v%04x i%04x l%d\n",
 			ctrl->bRequestType, ctrl->bRequest,
diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 96121d1c8df4..0c1a78d9b5a0 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -39,6 +39,7 @@ struct gadget_info {
 	struct config_group configs_group;
 	struct config_group strings_group;
 	struct config_group os_desc_group;
+	struct config_group webusb_group;
 
 	struct mutex lock;
 	struct usb_gadget_strings *gstrings[MAX_USB_STRING_LANGS + 1];
@@ -50,6 +51,11 @@ struct gadget_info {
 	bool use_os_desc;
 	char b_vendor_code;
 	char qw_sign[OS_STRING_QW_SIGN_LEN];
+	bool			use_webusb;
+	u16				bcd_webusb_version;
+	u8				b_webusb_vendor_code;
+	char			landing_page[255];
+
 	spinlock_t spinlock;
 	bool unbind;
 };
@@ -780,6 +786,125 @@ static void gadget_strings_attr_release(struct config_item *item)
 USB_CONFIG_STRING_RW_OPS(gadget_strings);
 USB_CONFIG_STRINGS_LANG(gadget_strings, gadget_info);
 
+static inline struct gadget_info *webusb_item_to_gadget_info(
+		struct config_item *item)
+{
+	return container_of(to_config_group(item),
+			struct gadget_info, webusb_group);
+}
+
+static ssize_t webusb_use_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n",
+			webusb_item_to_gadget_info(item)->use_webusb);
+}
+
+static ssize_t webusb_use_store(struct config_item *item, const char *page,
+				 size_t len)
+{
+	struct gadget_info *gi = webusb_item_to_gadget_info(item);
+	int ret;
+	bool use;
+
+	mutex_lock(&gi->lock);
+	ret = kstrtobool(page, &use);
+	if (!ret) {
+		gi->use_webusb = use;
+		ret = len;
+	}
+	mutex_unlock(&gi->lock);
+
+	return ret;
+}
+
+static ssize_t webusb_bcdVersion_show(struct config_item *item, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "0x%04x\n",
+					webusb_item_to_gadget_info(item)->bcd_webusb_version);
+}
+
+static ssize_t webusb_bcdVersion_store(struct config_item *item,
+		const char *page, size_t len)
+{
+	struct gadget_info *gi = webusb_item_to_gadget_info(item);
+	u16 bcdVersion;
+	int ret;
+
+	ret = kstrtou16(page, 0, &bcdVersion);
+	if (ret)
+		return ret;
+	ret = is_valid_bcd(bcdVersion);
+	if (ret)
+		return ret;
+
+	gi->bcd_webusb_version = bcdVersion;
+	return len;
+}
+
+static ssize_t webusb_bVendorCode_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "0x%02x\n",
+			webusb_item_to_gadget_info(item)->b_webusb_vendor_code);
+}
+
+static ssize_t webusb_bVendorCode_store(struct config_item *item,
+					   const char *page, size_t len)
+{
+	struct gadget_info *gi = webusb_item_to_gadget_info(item);
+	int ret;
+	u8 b_vendor_code;
+
+	mutex_lock(&gi->lock);
+	ret = kstrtou8(page, 0, &b_vendor_code);
+	if (!ret) {
+		gi->b_webusb_vendor_code = b_vendor_code;
+		ret = len;
+	}
+	mutex_unlock(&gi->lock);
+
+	return ret;
+}
+
+static ssize_t webusb_landingPage_show(struct config_item *item, char *page)
+{
+	return snprintf(page, PAGE_SIZE, "%s\n", webusb_item_to_gadget_info(item)->landing_page);
+}
+
+static ssize_t webusb_landingPage_store(struct config_item *item, const char *page,
+				     size_t len)
+{
+	struct gadget_info *gi = webusb_item_to_gadget_info(item);
+	int l;
+
+	l = min(len, sizeof(gi->landing_page));
+	if (page[l - 1] == '\n')
+		--l;
+
+	mutex_lock(&gi->lock);
+	memcpy(gi->landing_page, page, l);
+	mutex_unlock(&gi->lock);
+
+	return len;
+}
+
+CONFIGFS_ATTR(webusb_, use);
+CONFIGFS_ATTR(webusb_, bVendorCode);
+CONFIGFS_ATTR(webusb_, bcdVersion);
+CONFIGFS_ATTR(webusb_, landingPage);
+
+static struct configfs_attribute *webusb_attrs[] = {
+	&webusb_attr_use,
+	&webusb_attr_bcdVersion,
+	&webusb_attr_bVendorCode,
+	&webusb_attr_landingPage,
+	NULL,
+};
+
+static struct config_item_type webusb_type = {
+	.ct_attrs	= webusb_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
 static inline struct gadget_info *os_desc_item_to_gadget_info(
 		struct config_item *item)
 {
@@ -1341,6 +1466,16 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
 		gi->cdev.desc.iSerialNumber = s[USB_GADGET_SERIAL_IDX].id;
 	}
 
+	if (gi->use_webusb) {
+		cdev->use_webusb = true;
+		cdev->bcd_webusb_version = gi->bcd_webusb_version;
+		cdev->b_webusb_vendor_code = gi->b_webusb_vendor_code;
+		memcpy(cdev->landing_page, gi->landing_page,
+				strnlen(gi->landing_page,
+						min(sizeof(cdev->landing_page),
+							sizeof(gi->landing_page))));
+	}
+
 	if (gi->use_os_desc) {
 		cdev->use_os_string = true;
 		cdev->b_vendor_code = gi->b_vendor_code;
@@ -1605,6 +1740,10 @@ static struct config_group *gadgets_make(
 			&os_desc_type);
 	configfs_add_default_group(&gi->os_desc_group, &gi->group);
 
+	config_group_init_type_name(&gi->webusb_group, "webusb",
+			&webusb_type);
+	configfs_add_default_group(&gi->webusb_group, &gi->group);
+
 	gi->composite.bind = configfs_do_nothing;
 	gi->composite.unbind = configfs_do_nothing;
 	gi->composite.suspend = NULL;
diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 43ac3fa760db..44f90c37dda9 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -474,6 +474,12 @@ struct usb_composite_dev {
 	struct usb_configuration	*os_desc_config;
 	unsigned int			use_os_string:1;
 
+	/* WebUSB */
+	u16				bcd_webusb_version;
+	u8				b_webusb_vendor_code;
+	char			landing_page[255];
+	unsigned int			use_webusb:1;
+
 	/* private: */
 	/* internals */
 	unsigned int			suspended:1;
diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
index 31fcfa084e63..3a36550297bc 100644
--- a/include/uapi/linux/usb/ch9.h
+++ b/include/uapi/linux/usb/ch9.h
@@ -947,6 +947,39 @@ struct usb_ss_container_id_descriptor {
 
 #define USB_DT_USB_SS_CONTN_ID_SIZE	20
 
+/*
+ * Platform Device Capability descriptor: Defines platform specific device
+ * capabilities
+ */
+#define	USB_PLAT_DEV_CAP_TYPE	5
+struct usb_plat_dev_cap_descriptor {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bDevCapabilityType;
+	__u8  bReserved;
+	__u8  UUID[16];
+} __attribute__((packed));
+
+#define USB_DT_USB_PLAT_DEV_CAP_SIZE	20
+
+/*
+ * WebUSB Platform Capability descriptor: A device announces support for the
+ * WebUSB command set by including the following Platform Descriptor in its
+ * Binary Object Store
+ * https://wicg.github.io/webusb/#webusb-platform-capability-descriptor
+ */
+struct usb_webusb_cap_descriptor {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bDevCapabilityType;
+	__u8  bReserved;
+	__u8  UUID[16];
+	__u16 bcdVersion;
+	__u8  bVendorCode;
+	__u8  iLandingPage;
+} __attribute__((packed));
+#define USB_DT_WEBUSB_SIZE	(USB_DT_USB_PLAT_DEV_CAP_SIZE + 4)
+
 /*
  * SuperSpeed Plus USB Capability descriptor: Defines the set of
  * SuperSpeed Plus USB specific device level capabilities
-- 
2.37.2

