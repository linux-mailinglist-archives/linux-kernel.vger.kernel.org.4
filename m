Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510E2662DB8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237474AbjAIRyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:54:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237720AbjAIRxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:53:41 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED16277ACD;
        Mon,  9 Jan 2023 09:50:03 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6587D6602D06;
        Mon,  9 Jan 2023 17:49:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673286559;
        bh=XGMYE9u2czmPZW+EittiBepS9Wlyq7LG531b0tzBw7I=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=cPoaJNDcGkIE62TXokWqxedvAv1PwKEw64Ao0HXuUaUufPu44oPOlHWfu7zYOKuGe
         P1R2A729Z1PcWf/h0a4krUdJxfr6iCfsi+CiRzoIe8hAHROwVtloDzVYVaDEMpoYWS
         nWw0p++h9bVNqd+b80JrJFjyTmD4qLeDjwwZeB2Ec5UFEmxvDV11a5Ay7jUsfi04eW
         CRMkVbw0FFd0HT6dnYfVPKfw0DebNwhJ6fXH75/rvHgLD48BqMPqCoI9egi1AyO32O
         QMhASyFkH0WWnWQpHNpGDUzOYunqBQIwutKPvCsckVlmxJtegdF2ZHjc8uHDh19rxr
         VRbx7zDJPgp9Q==
Message-ID: <ca67837b-ef00-b314-2050-3274db8c8fc5@collabora.com>
Date:   Mon, 9 Jan 2023 18:49:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3] usb: gadget: add WebUSB landing page support
Content-Language: en-US
To:     =?UTF-8?B?SsOzIMOBZ2lsYSBCaXRzY2g=?= <jgilab@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <Y7G797A2CIF1Ys/t@jo-einhundert>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <Y7G797A2CIF1Ys/t@jo-einhundert>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jó Ágila Bitsch,

W dniu 1.01.2023 o 17:59, Jó Ágila Bitsch pisze:
> 
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

I envision an "evil" scenario, where you don't own your USB device any more.
Instead you are required to pay a subscription to keep accessing it
because its driver is somewhere on the net. I purposedly have put
evil in quotes, because such a scenario might be considered preferred
by some people. Maybe there are advantages, too, like not having to worry
about correct drivers. Anyway, the kernel is about mechanism, not policy,
so I'm probably in no position to judge such things.

Please see below.

> This patch adds optional support for Linux-based USB gadgets
> wishing to expose such a landing page.
> 
> During device enumeration, a host recognizes that the announced
> USB version is at least 2.01, which means, that there are BOS
> descriptors available. The device than announces WebUSB support
> using a platform device capability. This includes a vendor code
> under which the landing page URL can be retrieved using a
> vendor-specific request.
> 
> Previously, the BOS descriptors would unconditionally include an
> LPM related descriptor, as BOS descriptors were only ever sent
> when the device was LPM capable. As this is no longer the case,
> this patch puts this descriptor behind a lpm_capable condition.
> 
> Usage is modeled after os_desc descriptors:
> echo 1 > webusb/use
> echo "https://www.kernel.org" > webusb/landingPage
> 
> lsusb will report the device with the following lines:
>    Platform Device Capability:
>      bLength                24
>      bDescriptorType        16
>      bDevCapabilityType      5
>      bReserved               0
>      PlatformCapabilityUUID    {3408b638-09a9-47a0-8bfd-a0768815b665}
>        WebUSB:
>          bcdVersion    1.00
>          bVendorCode      0
>          iLandingPage     1 https://www.kernel.org
> 
> Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
> ---
> v2 -> V3: improved commit message to include additional condition in desc_bos as per comment
> 	  by Alan Stern
> V1 -> V2: cleaned up coding style, made URL scheme comparison case insensitive, addressed review
>            comments by Alan Stern
> V0 -> V1: use sysfs_emit instead of sprintf and use lock in webusb_bcdVersion_store, addressed review
> 	  comments by Christophe JAILLET
> 
>   Documentation/ABI/testing/configfs-usb-gadget |  13 ++
>   drivers/usb/gadget/composite.c                |  95 ++++++++++--
>   drivers/usb/gadget/configfs.c                 | 145 ++++++++++++++++++
>   include/linux/usb/composite.h                 |   6 +
>   include/uapi/linux/usb/ch9.h                  |  33 ++++
>   5 files changed, 282 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget b/Documentation/ABI/testing/configfs-usb-gadget
> index b7943aa7e997..8399e0f0ed1c 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget
> +++ b/Documentation/ABI/testing/configfs-usb-gadget
> @@ -143,3 +143,16 @@ Description:
>   		qw_sign		an identifier to be reported as "OS String"
>   				proper
>   		=============	===============================================
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
> index 403563c06477..9b209e69442d 100644
> --- a/drivers/usb/gadget/composite.c
> +++ b/drivers/usb/gadget/composite.c
> @@ -14,6 +14,7 @@
>   #include <linux/device.h>
>   #include <linux/utsname.h>
>   #include <linux/bitfield.h>
> +#include <linux/uuid.h>
>   
>   #include <linux/usb/composite.h>
>   #include <linux/usb/otg.h>
> @@ -713,14 +714,16 @@ static int bos_desc(struct usb_composite_dev *cdev)
>   	 * A SuperSpeed device shall include the USB2.0 extension descriptor
>   	 * and shall support LPM when operating in USB2.0 HS mode.
>   	 */
> -	usb_ext = cdev->req->buf + le16_to_cpu(bos->wTotalLength);
> -	bos->bNumDeviceCaps++;
> -	le16_add_cpu(&bos->wTotalLength, USB_DT_USB_EXT_CAP_SIZE);
> -	usb_ext->bLength = USB_DT_USB_EXT_CAP_SIZE;
> -	usb_ext->bDescriptorType = USB_DT_DEVICE_CAPABILITY;
> -	usb_ext->bDevCapabilityType = USB_CAP_TYPE_EXT;
> -	usb_ext->bmAttributes = cpu_to_le32(USB_LPM_SUPPORT |
> -					    USB_BESL_SUPPORT | besl);
> +	if (cdev->gadget->lpm_capable) {
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
>   	/*
>   	 * The Superspeed USB Capability descriptor shall be implemented by all
> @@ -821,6 +824,40 @@ static int bos_desc(struct usb_composite_dev *cdev)
>   		}
>   	}
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
> +		uuid_t webusb_uuid = UUID_INIT(0x38b60834, 0xa909, 0xa047, 0x8b, 0xfd, 0xa0, 0x76,
> +						0x88, 0x15, 0xb6, 0x65);
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
>   	return le16_to_cpu(bos->wTotalLength);
>   }
>   
> @@ -1744,7 +1781,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>   					cdev->desc.bcdUSB = cpu_to_le16(0x0210);
>   				}
>   			} else {
> -				if (gadget->lpm_capable)
> +				if (gadget->lpm_capable || cdev->use_webusb)
>   					cdev->desc.bcdUSB = cpu_to_le16(0x0201);
>   				else
>   					cdev->desc.bcdUSB = cpu_to_le16(0x0200);
> @@ -1779,7 +1816,7 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>   			break;
>   		case USB_DT_BOS:
>   			if (gadget_is_superspeed(gadget) ||
> -			    gadget->lpm_capable) {
> +			    gadget->lpm_capable || cdev->use_webusb) {
>   				value = bos_desc(cdev);
>   				value = min(w_length, (u16) value);
>   			}
> @@ -2013,6 +2050,44 @@ composite_setup(struct usb_gadget *gadget, const struct usb_ctrlrequest *ctrl)
>   			goto check_value;
>   		}
>   
> +		/*
> +		 * webusb descriptor handling, following:
> +		 * https://wicg.github.io/webusb/#device-requests
> +		 */
> +		if (cdev->use_webusb &&
> +		    (ctrl->bRequestType & USB_TYPE_VENDOR) &&
> +		    ctrl->wIndex == /* WEBUSB_GET_URL*/ 2 &&
> +		    ctrl->bRequest == cdev->b_webusb_vendor_code) {
> +			/*
> +			 * specification of the url descriptor in WebUSB:
> +			 * https://wicg.github.io/webusb/#webusb-descriptors
> +			 */
> +			u8		*buf;
> +			unsigned int	landing_page_length;
> +
> +			buf = cdev->req->buf;
> +			buf[1] = /* WEBUSB_URL*/ 3;

Why not #define WEBUSB_URL?

> +
> +			landing_page_length = strnlen(cdev->landing_page, 252);
> +			if (strncasecmp("https://", cdev->landing_page, 8) == 0) {

Maybe it's me, but it would be easier for me to understand why the "8" if the
comparison was in reverse order of arguments, like this:

strncasecmp(cdev->landing_page, "https://", 8)

because we want the entirety of "https://" compared, not its substring, so the
limit kind of applies to the landing_page in the first place.
Maybe the "8" (and "7" below) can be #define'd, too?

> +				buf[2] = 0x01;

What is this magic 0x01?

> +				memcpy(buf+3, cdev->landing_page+8, landing_page_length-8);

spaces around arithmetic operators?

> +				buf[0] = landing_page_length - 8 + 3;
> +			} else if (strncasecmp("http://", cdev->landing_page, 7) == 0) {
> +				buf[2] = 0x00;

Magic 0x00?

> +				memcpy(buf+3, cdev->landing_page+7, landing_page_length-7);
> +				buf[0] = landing_page_length - 7 + 3;
> +			} else {
> +				buf[2] = 0xFF;

Magic 0xFF? (plus I'd expect lowercase hex digits).

There's "URL Prefixes" table in 4.3.1 URL Descriptor. Why not define 
URL_PREFIX_HTTP/HTTPS/NONE?

> +				memcpy(buf+3, cdev->landing_page, landing_page_length);
> +				buf[0] = landing_page_length + 3;
> +			}
> +
> +			value = buf[0];
> +
> +			goto check_value;
> +		}
> +
>   		VDBG(cdev,
>   			"non-core control req%02x.%02x v%04x i%04x l%d\n",
>   			ctrl->bRequestType, ctrl->bRequest,
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 96121d1c8df4..2b7f01a9efff 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -39,6 +39,7 @@ struct gadget_info {
>   	struct config_group configs_group;
>   	struct config_group strings_group;
>   	struct config_group os_desc_group;
> +	struct config_group webusb_group;
>   
>   	struct mutex lock;
>   	struct usb_gadget_strings *gstrings[MAX_USB_STRING_LANGS + 1];
> @@ -50,6 +51,11 @@ struct gadget_info {
>   	bool use_os_desc;
>   	char b_vendor_code;
>   	char qw_sign[OS_STRING_QW_SIGN_LEN];
> +	bool use_webusb;
> +	u16 bcd_webusb_version;
> +	u8 b_webusb_vendor_code;
> +	char landing_page[255];

A #define for the size?

> +
>   	spinlock_t spinlock;
>   	bool unbind;
>   };
> @@ -780,6 +786,131 @@ static void gadget_strings_attr_release(struct config_item *item)
>   USB_CONFIG_STRING_RW_OPS(gadget_strings);
>   USB_CONFIG_STRINGS_LANG(gadget_strings, gadget_info);
>   
> +static inline struct gadget_info *webusb_item_to_gadget_info(
> +		struct config_item *item)
> +{
> +	return container_of(to_config_group(item),
> +			struct gadget_info, webusb_group);
> +}
> +
> +static ssize_t webusb_use_show(struct config_item *item, char *page)
> +{
> +	return sysfs_emit(page, "%d\n",
> +			webusb_item_to_gadget_info(item)->use_webusb);
> +}
> +
> +static ssize_t webusb_use_store(struct config_item *item, const char *page,
> +				 size_t len)
> +{
> +	struct gadget_info *gi = webusb_item_to_gadget_info(item);
> +	int ret;
> +	bool use;
> +
> +	mutex_lock(&gi->lock);
> +	ret = kstrtobool(page, &use);
> +	if (!ret) {
> +		gi->use_webusb = use;
> +		ret = len;
> +	}
> +	mutex_unlock(&gi->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t webusb_bcdVersion_show(struct config_item *item, char *page)
> +{
> +	return sysfs_emit(page, "0x%04x\n",
> +					webusb_item_to_gadget_info(item)->bcd_webusb_version);
> +}
> +
> +static ssize_t webusb_bcdVersion_store(struct config_item *item,
> +		const char *page, size_t len)
> +{
> +	struct gadget_info *gi = webusb_item_to_gadget_info(item);
> +	u16 bcdVersion;
> +	int ret;
> +
> +	mutex_lock(&gi->lock);
> +	ret = kstrtou16(page, 0, &bcdVersion);
> +	if (ret)
> +		goto out;
> +	ret = is_valid_bcd(bcdVersion);
> +	if (ret)
> +		goto out;
> +
> +	gi->bcd_webusb_version = bcdVersion;
> +	ret = len;
> +
> +out:
> +	mutex_unlock(&gi->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t webusb_bVendorCode_show(struct config_item *item, char *page)
> +{
> +	return sysfs_emit(page, "0x%02x\n",
> +			webusb_item_to_gadget_info(item)->b_webusb_vendor_code);
> +}
> +
> +static ssize_t webusb_bVendorCode_store(struct config_item *item,
> +					   const char *page, size_t len)
> +{
> +	struct gadget_info *gi = webusb_item_to_gadget_info(item);
> +	int ret;
> +	u8 b_vendor_code;
> +
> +	mutex_lock(&gi->lock);
> +	ret = kstrtou8(page, 0, &b_vendor_code);
> +	if (!ret) {
> +		gi->b_webusb_vendor_code = b_vendor_code;
> +		ret = len;
> +	}
> +	mutex_unlock(&gi->lock);
> +
> +	return ret;
> +}
> +
> +static ssize_t webusb_landingPage_show(struct config_item *item, char *page)
> +{
> +	return sysfs_emit(page, "%s\n", webusb_item_to_gadget_info(item)->landing_page);
> +}
> +
> +static ssize_t webusb_landingPage_store(struct config_item *item, const char *page,
> +				     size_t len)
> +{
> +	struct gadget_info *gi = webusb_item_to_gadget_info(item);
> +	int l;
> +
> +	l = min(len, sizeof(gi->landing_page));
> +	if (page[l - 1] == '\n')
> +		--l;
> +
> +	mutex_lock(&gi->lock);
> +	memcpy(gi->landing_page, page, l);
> +	mutex_unlock(&gi->lock);
> +
> +	return len;
> +}
> +
> +CONFIGFS_ATTR(webusb_, use);
> +CONFIGFS_ATTR(webusb_, bVendorCode);
> +CONFIGFS_ATTR(webusb_, bcdVersion);
> +CONFIGFS_ATTR(webusb_, landingPage);
> +
> +static struct configfs_attribute *webusb_attrs[] = {
> +	&webusb_attr_use,
> +	&webusb_attr_bcdVersion,
> +	&webusb_attr_bVendorCode,
> +	&webusb_attr_landingPage,
> +	NULL,
> +};
> +
> +static struct config_item_type webusb_type = {
> +	.ct_attrs	= webusb_attrs,
> +	.ct_owner	= THIS_MODULE,
> +};
> +
>   static inline struct gadget_info *os_desc_item_to_gadget_info(
>   		struct config_item *item)
>   {
> @@ -1341,6 +1472,16 @@ static int configfs_composite_bind(struct usb_gadget *gadget,
>   		gi->cdev.desc.iSerialNumber = s[USB_GADGET_SERIAL_IDX].id;
>   	}
>   
> +	if (gi->use_webusb) {
> +		cdev->use_webusb = true;
> +		cdev->bcd_webusb_version = gi->bcd_webusb_version;
> +		cdev->b_webusb_vendor_code = gi->b_webusb_vendor_code;
> +		memcpy(cdev->landing_page, gi->landing_page,
> +				strnlen(gi->landing_page,
> +						min(sizeof(cdev->landing_page),
> +							sizeof(gi->landing_page))));

checkpatch now allows 100 colums. Plus strnlen() looks indented too far to the
right.

The sizeofs are both 255. Are they ever expected to be different? Maybe not?
Then a #defined constant ensures they are equal. Then there's no need to find
a minimum among equal values.

Regards,

Andrzej

> +	}
> +
>   	if (gi->use_os_desc) {
>   		cdev->use_os_string = true;
>   		cdev->b_vendor_code = gi->b_vendor_code;
> @@ -1605,6 +1746,10 @@ static struct config_group *gadgets_make(
>   			&os_desc_type);
>   	configfs_add_default_group(&gi->os_desc_group, &gi->group);
>   
> +	config_group_init_type_name(&gi->webusb_group, "webusb",
> +			&webusb_type);
> +	configfs_add_default_group(&gi->webusb_group, &gi->group);
> +
>   	gi->composite.bind = configfs_do_nothing;
>   	gi->composite.unbind = configfs_do_nothing;
>   	gi->composite.suspend = NULL;
> diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
> index 43ac3fa760db..eb6fac5bbcde 100644
> --- a/include/linux/usb/composite.h
> +++ b/include/linux/usb/composite.h
> @@ -474,6 +474,12 @@ struct usb_composite_dev {
>   	struct usb_configuration	*os_desc_config;
>   	unsigned int			use_os_string:1;
>   
> +	/* WebUSB */
> +	u16				bcd_webusb_version;
> +	u8				b_webusb_vendor_code;
> +	char				landing_page[255];
> +	unsigned int			use_webusb:1;
> +
>   	/* private: */
>   	/* internals */
>   	unsigned int			suspended:1;
> diff --git a/include/uapi/linux/usb/ch9.h b/include/uapi/linux/usb/ch9.h
> index 31fcfa084e63..3a36550297bc 100644
> --- a/include/uapi/linux/usb/ch9.h
> +++ b/include/uapi/linux/usb/ch9.h
> @@ -947,6 +947,39 @@ struct usb_ss_container_id_descriptor {
>   
>   #define USB_DT_USB_SS_CONTN_ID_SIZE	20
>   
> +/*
> + * Platform Device Capability descriptor: Defines platform specific device
> + * capabilities
> + */
> +#define	USB_PLAT_DEV_CAP_TYPE	5
> +struct usb_plat_dev_cap_descriptor {
> +	__u8  bLength;
> +	__u8  bDescriptorType;
> +	__u8  bDevCapabilityType;
> +	__u8  bReserved;
> +	__u8  UUID[16];
> +} __attribute__((packed));
> +
> +#define USB_DT_USB_PLAT_DEV_CAP_SIZE	20
> +
> +/*
> + * WebUSB Platform Capability descriptor: A device announces support for the
> + * WebUSB command set by including the following Platform Descriptor in its
> + * Binary Object Store
> + * https://wicg.github.io/webusb/#webusb-platform-capability-descriptor
> + */
> +struct usb_webusb_cap_descriptor {
> +	__u8  bLength;
> +	__u8  bDescriptorType;
> +	__u8  bDevCapabilityType;
> +	__u8  bReserved;
> +	__u8  UUID[16];
> +	__u16 bcdVersion;
> +	__u8  bVendorCode;
> +	__u8  iLandingPage;
> +} __attribute__((packed));
> +#define USB_DT_WEBUSB_SIZE	(USB_DT_USB_PLAT_DEV_CAP_SIZE + 4)
> +
>   /*
>    * SuperSpeed Plus USB Capability descriptor: Defines the set of
>    * SuperSpeed Plus USB specific device level capabilities

