Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9DE565A65D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 20:47:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiLaTru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 14:47:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232298AbiLaTrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 14:47:47 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id B10A860EC
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 11:47:44 -0800 (PST)
Received: (qmail 362789 invoked by uid 1000); 31 Dec 2022 14:47:43 -0500
Date:   Sat, 31 Dec 2022 14:47:43 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v1] usb: gadget:  add WebUSB support
Message-ID: <Y7CR30YUj2znMDm7@rowland.harvard.edu>
References: <7615b2ac-a849-94a7-94a5-fb1c2075d7db@wanadoo.fr>
 <Y69F/5+DLAEqujXC@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y69F/5+DLAEqujXC@jo-einhundert>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 09:11:43PM +0100, Jó Ágila Bitsch wrote:
> There is a custom (non-USB IF) extension to the USB standard:
> 
> https://wicg.github.io/webusb/
> 
> This specification is published under the W3C Community Contributor
> Agreement, which in particular allows to implement the specification
> without any royalties.
> 
> The specification allows USB gadgets to announce an URL to landing
> page and describes a Javascript interface for websites to interact
> with the USB gadget, if the user allows it. It is currently
> supported by Chromium-based browsers, such as Chrome, Edge and
> Opera on all major operating systems including Linux.
> 
> This patch adds optional support for Linux-based USB gadgets
> wishing to expose such a landing page.
> 
> During device enumeration, a host recognizes that the announced
> USB version is at least 2.01, which means, that there are BOS

Where is this 2.01 value specified?  I don't remember seeing it in the 
usual USBIF documents.

> descriptors available. The device than announces WebUSB support
> using a platform device capability. This includes a vendor code
> under which the landing page URL can be retrieved using a
> vendor-specific request.
> 
> Usage is modeled after os_desc descriptors:
> echo 1 > webusb/use
> echo "https://www.kernel.org" > webusb/landingPage
> 
> lsusb will report the device with the following lines:
>   Platform Device Capability:
>     bLength                24
>     bDescriptorType        16
>     bDevCapabilityType      5
>     bReserved               0
>     PlatformCapabilityUUID    {3408b638-09a9-47a0-8bfd-a0768815b665}
>       WebUSB:
>         bcdVersion    1.00
>         bVendorCode      0
>         iLandingPage     1 https://www.kernel.org
> 
> Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
> ---
>  Documentation/ABI/testing/configfs-usb-gadget |  13 ++
>  drivers/usb/gadget/composite.c                | 102 ++++++++++--
>  drivers/usb/gadget/configfs.c                 | 145 ++++++++++++++++++
>  include/linux/usb/composite.h                 |   6 +
>  include/uapi/linux/usb/ch9.h                  |  33 ++++
>  5 files changed, 289 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget b/Documentation/ABI/testing/configfs-usb-gadget
> index b7943aa7e997..8399e0f0ed1c 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget
> +++ b/Documentation/ABI/testing/configfs-usb-gadget
> @@ -143,3 +143,16 @@ Description:
>  		qw_sign		an identifier to be reported as "OS String"
>  				proper
>  		=============	===============================================
> +
> +What:		/config/usb-gadget/gadget/webusb
> +Date:		Dec 2022
> +KernelVersion:	6.2
> +Description:
> +		This group contains "WebUSB" extension handling attributes.
> +
> +		=============	===============================================
> +		use		flag turning "WebUSB" support on/off
> +		bcdVersion	bcd WebUSB specification version number
> +		b_vendor_code	one-byte value used for custom per-device
> +		landing_page	UTF-8 encoded URL of the device's landing page
> +		=============	===============================================
> diff --git a/drivers/usb/gadget/composite.c b/drivers/usb/gadget/composite.c
> index 403563c06477..937695dc5366 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -14,6 +14,7 @@
>  #include <linux/device.h>
>  #include <linux/utsname.h>
>  #include <linux/bitfield.h>
> +#include <linux/uuid.h>
>  
>  #include <linux/usb/composite.h>
>  #include <linux/usb/otg.h>
> @@ -713,14 +714,16 @@ static int bos_desc(struct usb_composite_dev *cdev)
>  	 * A SuperSpeed device shall include the USB2.0 extension descriptor
>  	 * and shall support LPM when operating in USB2.0 HS mode.
>  	 */
> -	usb_ext = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
> -	bos->bNumDeviceCaps++;
> -	le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
> -	usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
> -	usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
> -	usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
> -	usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
> -					    USB_BESL_SUPPORT | besl);
> +	if (cdev->gadget->lpm_capable) {

This change doesn't seem to be related to the purpose of this patch.

> +		usb_ext = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
> +		bos->bNumDeviceCaps++;
> +		le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
> +		usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
> +		usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
> +		usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
> +		usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
> +							USB_BESL_SUPPORT | besl);
> +	}
>  
>  	/*
>  	 * The Superspeed USB Capability descriptor shall be implemented by all
> @@ -821,6 +824,41 @@ static int bos_desc(struct usb_composite_dev *cdev)
>  		}
>  	}
>  
> +	/*
> +	 * Following the specifaction at:
> +	 * https://wicg.github.io/webusb/#webusb-platform-capability-descriptor
> +	 */
> +	if (cdev->use_webusb) {
> +		struct usb_webusb_cap_descriptor *webusb_cap;
> +		/*
> +		 * little endian PlatformCapablityUUID for WebUSB:
> +		 * 3408b638-09a9-47a0-8bfd-a0768815b665
> +		 */
> +#define WEBUSB_UUID UUID_INIT(0x38b60834, 0xa909, 0xa047, \
> +			      0x8b, 0xfd, 0xa0, 0x76, 0x88, 0x15, 0xb6, 0x65)
> +		uuid_t webusb_uuid = WEBUSB_UUID;

This #define seems to be pointless.  It is used nowhere but in the 
immediately following line.  You might as well eliminate it.

Or you might define this UUID at the same place in the header file 
where you define struct usb_webusb_cap_descriptor.

> +
> +		webusb_cap = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
> +		bos->bNumDeviceCaps++;
> +
> +		le16_add_cpu(&bos->wTotalLength, USB_DT_WEBUSB_SIZE);
> +		webusb_cap->bLength = USB_DT_WEBUSB_SIZE;
> +		webusb_cap->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
> +		webusb_cap->bDevCapabilityType = USB_PLAT_DEV_CAP_TYPE;
> +		webusb_cap->bReserved = 0;
> +		export_uuid(webusb_cap->UUID, &webusb_uuid);
> +		if (cdev->bcd_webusb_version != 0)
> +			webusb_cap->bcdVersion = cpu_to_le16(cdev->bcd_webusb_version);
> +		else
> +			webusb_cap->bcdVersion = cpu_to_le16(0x0100);
> +
> +		webusb_cap->bVendorCode = cdev->b_webusb_vendor_code;
> +		if (strnlen(cdev->landing_page, sizeof(cdev->landing_page)) > 0)
> +			webusb_cap->iLandingPage = 1;
> +		else
> +			webusb_cap->iLandingPage = 0;
> +	}
> +
>  	return le16_to_cpu(bos->wTotalLength);
>  }
>  
> @@ -1744,7 +1782,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>  					cdev->desc.bcdUSB = cpu_to_le16(0x0210);
>  				}
>  			} else {
> -				if (gadget->lpm_capable)
> +				if (gadget->lpm_capable || cdev->use_webusb)
>  					cdev->desc.bcdUSB = cpu_to_le16(0x0201);
>  				else
>  					cdev->desc.bcdUSB = cpu_to_le16(0x0200);
> @@ -1779,7 +1817,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>  			break;
>  		case USB_DT_BOS:
>  			if (gadget_is_superspeed(gadget) ||
> -			    gadget->lpm_capable) {
> +			    gadget->lpm_capable || cdev->use_webusb) {
>  				value = bos_desc(cdev);
>  				value = min(w_length, (u16) value);
>  			}
> @@ -2013,6 +2051,50 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>  			goto check_value;
>  		}
>  
> +		/*
> +		 * webusb descriptor handling, following:
> +		 * https://wicg.github.io/webusb/#device-requests
> +		 */
> +		#define WEBUSB_GET_URL 2

A similar comment applies to this #define.  In this case it might make 
sense to put all the WebUSB-related #defines in an appropriate header 
file.

> +		if (cdev->use_webusb &&
> +		    (ctrl->bRequestType & USB_TYPE_VENDOR) &&
> +			ctrl->wIndex == WEBUSB_GET_URL &&
> +			ctrl->bRequest == cdev->b_webusb_vendor_code) {

Bad indentation.  Visually this makes it look like the last two tests 
are part of the conditional block, because they share its indentation 
level.

> +			/*
> +			 * specification of the url descriptor in WebUSB:
> +			 * https://wicg.github.io/webusb/#webusb-descriptors
> +			 */
> +			u8				*buf;
> +			unsigned int	schema_http;

*buf and schema_http should be indented by the same amount.

> +			unsigned int	schema_https;
> +			unsigned int	landing_page_length;
> +
> +			buf = cdev->req->buf;
> +			#define WEBUSB_URL 3
> +			buf[1] = WEBUSB_URL;
> +
> +			landing_page_length = strnlen(cdev->landing_page, 252);
> +			schema_https = (strncmp("https://", cdev->landing_page, 8) == 0);
> +			schema_http = (strncmp("http://", cdev->landing_page, 7) == 0);

Do you really need these temporary variables?  Why not put the tests 
directly into the "if" conditions?

Also, should the comparisons be case-insensitive?

> +			if (schema_https) {
> +				buf[2] = 0x01;
> +				memcpy(buf+3, cdev->landing_page+8, landing_page_length-8);
> +				buf[0] = landing_page_length - 8 + 3;
> +			} else if (schema_http) {
> +				buf[2] = 0x00;
> +				memcpy(buf+3, cdev->landing_page+7, landing_page_length-7);
> +				buf[0] = landing_page_length - 7 + 3;
> +			} else {
> +				buf[2] = 0xFF;
> +				memcpy(buf+3, cdev->landing_page, landing_page_length);
> +				buf[0] = landing_page_length + 3;
> +			}
> +
> +			value = buf[0];
> +
> +			goto check_value;
> +		}
> +
>  		VDBG(cdev,
>  			"non-core control req%02x.%02x v%04x i%04x l%d\n",
>  			ctrl->bRequestType, ctrl->bRequest,
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 96121d1c8df4..da49b36f7033 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -39,6 +39,7 @@ struct gadget_info {
>  	struct config_group configs_group;
>  	struct config_group strings_group;
>  	struct config_group os_desc_group;
> +	struct config_group webusb_group;
>  
>  	struct mutex lock;
>  	struct usb_gadget_strings *gstrings[MAX_USB_STRING_LANGS + 1];
> @@ -50,6 +51,11 @@ struct gadget_info {
>  	bool use_os_desc;
>  	char b_vendor_code;
>  	char qw_sign[OS_STRING_QW_SIGN_LEN];
> +	bool			use_webusb;
> +	u16				bcd_webusb_version;
> +	u8				b_webusb_vendor_code;

Again, improper indentation.

> +	char			landing_page[255];
> +
>  	spinlock_t spinlock;
>  	bool unbind;
>  };

...

> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
> index 43ac3fa760db..44f90c37dda9 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -474,6 +474,12 @@ struct usb_composite_dev {
>  	struct usb_configuration	*os_desc_config;
>  	unsigned int			use_os_string:1;
>  
> +	/* WebUSB */
> +	u16				bcd_webusb_version;
> +	u8				b_webusb_vendor_code;
> +	char			landing_page[255];

Improper indentation.

> +	unsigned int			use_webusb:1;
> +
>  	/* private: */
>  	/* internals */
>  	unsigned int			suspended:1;

Alan Stern
