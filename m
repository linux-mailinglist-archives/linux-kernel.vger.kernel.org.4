Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C091681152
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237179AbjA3OMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbjA3OMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:12:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA943B66A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675087882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zIrqd3J5hRsnQaxBAafMrajK/fmCqm3/aeryUUviUsA=;
        b=auFxvu3yXVK6biIdtZHm6zTys8Bjnc4OKC6JpdNcR1ivVyM543hcBdNcd4Jymv/JEbL9xY
        Uh2zGJNJlDnU995vJsX+YOtO5WCDq8aFzcnGg+UTFseZGj9GuZ9QPPTKGeA5rg85YJYWZ0
        XU61hRMn84hSsqiZGKnRmvOHf4vL3zI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-252-mHzjNHWMNqaArCiWVE2XjA-1; Mon, 30 Jan 2023 09:11:13 -0500
X-MC-Unique: mHzjNHWMNqaArCiWVE2XjA-1
Received: by mail-ed1-f69.google.com with SMTP id w16-20020a056402129000b004a1f1a2e79dso6113200edv.23
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:11:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIrqd3J5hRsnQaxBAafMrajK/fmCqm3/aeryUUviUsA=;
        b=a5d/QqnmCFnPduJ0T90Lwgpn3+BrEhs9fZHr9zmYuQ5/WDGANqDzgX2LiSCYBcRr44
         F/ukagqNfJ811raKxOc/QhgXXrL3KBorpinjqgjhLpLn7yphrw/LUuBN6rnKhs04DMaw
         +SCcfKJIB71Sf5XfqAdq6815ieOY9LkNBBhvhztKn+V32Zj+9Dh/8tPe2cqKG4mBSKhx
         x542/IJ9F1XgxBAA8PsLQFWugvBTu9jnpc4UX8IPCDk0pb2PPzcxdDIFBRnjb03nsTqE
         OLwXEAjpf4aO3ECCEdOLgCnRsd/sZgf+gGnvtW3Ii3vPZQ7LHW1Omy9qThpFir7SlGdv
         x2fg==
X-Gm-Message-State: AFqh2kpW4gM/47ZMdra8dnPuuArhJ6HLjz569nqCtJCtsPSd1dPdyXln
        FbgBmdNvFuFDR3l8x3QJUTZHclpKaJqdZfIYinq8mJmnz52fzh0Kagz7NB+cAVTWiDH22OpG/V7
        yoCogamC+SCj//WfpB/sXQ0BW
X-Received: by 2002:a17:906:299b:b0:84d:4394:e8e with SMTP id x27-20020a170906299b00b0084d43940e8emr48389157eje.41.1675087872340;
        Mon, 30 Jan 2023 06:11:12 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuqPG49wfvFC3h6jqcZgdUPPVo3OUxrW3eUglGHXJH9+EpdftpsyFeYkN9nlgN3xVbzc28dZg==
X-Received: by 2002:a17:906:299b:b0:84d:4394:e8e with SMTP id x27-20020a170906299b00b0084d43940e8emr48389132eje.41.1675087872019;
        Mon, 30 Jan 2023 06:11:12 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id d27-20020a170906041b00b00887f6c39ac0sm2074694eja.98.2023.01.30.06.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 06:11:11 -0800 (PST)
Message-ID: <908026af-de39-8475-b8a5-ceb82ab819cd@redhat.com>
Date:   Mon, 30 Jan 2023 15:11:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] platform/x86: hp-wmi: Support omen backlight control
 wmi-acpi methods
Content-Language: en-US
To:     Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230120223908.28678-1-rishitbansal0@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230120223908.28678-1-rishitbansal0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 1/20/23 23:39, Rishit Bansal wrote:
> The HP Omen Command Studio application includes a Light Studio feature
> which can be used to control various features related to the keyboard
> backlight via the 0x20009 command.
> 
> The command supports the following queries:
> 
> - 0x1: Checks if keyboard lighting is supported
> - 0x2: Get the zone colors of each of the 4 zones on the keyboard
> - 0x3: Set the zone colors of each of the 4 zones on the keyboard
> - 0x4: Gets the state (on/off) of the backlight
> - 0x5: Sets the state (on/off) of the backlight
> 
> This patch introduces a new sysfs led class called
> "hp_omen::kbd_backlight" which can be used to control the state of the
> backlight. It also includes a sysfs RW attribute called "kbd_rgb"
> which can be used to get/set the current color of each zone.
> 
> Additionally, it also maps the backlight event to the KEY_KBDILLUMTOGGLE
> key so it shows the correct notification on userspace.
> 
> The patch has been tested on an HP Omen 15-en0037AX (AMD) laptop.
> 
> Signed-off-by: Rishit Bansal <rishitbansal0@gmail.com>
> ---
> Changes since v1:
>  - Map backlight key to KEY_KBDILLUMTOGGLE
> ---
>  drivers/platform/x86/hp/hp-wmi.c | 113 +++++++++++++++++++++++++++++++
>  1 file changed, 113 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 0a99058be813..a9e2634a9d46 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -27,6 +27,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/string.h>
>  #include <linux/dmi.h>
> +#include <linux/leds.h>
>  
>  MODULE_AUTHOR("Matthew Garrett <mjg59@srcf.ucam.org>");
>  MODULE_DESCRIPTION("HP laptop WMI hotkeys driver");
> @@ -136,6 +137,7 @@ enum hp_wmi_command {
>  	HPWMI_WRITE	= 0x02,
>  	HPWMI_ODM	= 0x03,
>  	HPWMI_GM	= 0x20008,
> +	HPWMI_KB    = 0x20009,
>  };
>  
>  enum hp_wmi_hardware_mask {
> @@ -219,6 +221,7 @@ static const struct key_entry hp_wmi_keymap[] = {
>  	{ KE_KEY, 0x21a9,  { KEY_TOUCHPAD_OFF } },
>  	{ KE_KEY, 0x121a9, { KEY_TOUCHPAD_ON } },
>  	{ KE_KEY, 0x231b,  { KEY_HELP } },
> +	{ KE_KEY, KEY_KBDILLUMTOGGLE, { KEY_KBDILLUMTOGGLE }},

Please drop this entry (also see the comment about this below).

>  	{ KE_END, 0 }
>  };
>  
> @@ -734,12 +737,56 @@ static ssize_t postcode_store(struct device *dev, struct device_attribute *attr,
>  	return count;
>  }
>  
> +static ssize_t kbd_rgb_show(struct device *dev,
> +				    struct device_attribute *attr, char *buf)
> +{
> +	u8 val[128];
> +
> +	int ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
> +				       zero_if_sup(val), sizeof(val));
> +
> +	if (ret)
> +		return ret;
> +
> +	strncat(buf, &val[25], 12);
> +
> +	return strlen(buf);

strncat requires that the buffer is pre-zeroed which I'm not
sure is always the case. Instead you should problably just do something
like this:

	strscpy(buf, 12, &val[25]);

	return strlen(buf);

Alos may I ask what the output of reading the new kbd_rgb file
actually looks like ?

And can you please start a new Documentation file:

Documentation/ABI/testing/sysfs-platform-hp-wmi

and document this new kbd_rgb file there?

See for example:

Documentation/ABI/testing/sysfs-platform-asus-wmi

for what this file should look like.

Bonus points if you also do a follow-up patch documenting more
of the sysfs attributes used by this driver, but at a minimum
lets start documenting any new files we add.



> +}
> +
> +static ssize_t kbd_rgb_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t count)
> +{
> +	u8 val[128];
> +	int ret;
> +
> +	ret = hp_wmi_perform_query(HPWMI_HDDTEMP_QUERY, HPWMI_KB, &val,
> +				   zero_if_sup(val), sizeof(val));
> +
> +	if (ret)
> +		return ret;
> +
> +	if (count != 12)
> +		return -1;

So what is the exact format here? and should we not do more error
checking? Also we want 12 chars, then the show code above should use 13,
so that the buffer gets 12 chars + a terminating 0.

Also maybe add defines for the offset value of 25 and the buflen of 12 ?

> +
> +	strncpy(&val[25], buf, count);
> +
> +	ret = hp_wmi_perform_query(HPWMI_ALS_QUERY, HPWMI_KB, &val, sizeof(val),
> +				   0);
> +
> +	if (ret)
> +		return ret;
> +
> +	return count;
> +}
> +
>  static DEVICE_ATTR_RO(display);
>  static DEVICE_ATTR_RO(hddtemp);
>  static DEVICE_ATTR_RW(als);
>  static DEVICE_ATTR_RO(dock);
>  static DEVICE_ATTR_RO(tablet);
>  static DEVICE_ATTR_RW(postcode);
> +static DEVICE_ATTR_RW(kbd_rgb);
>  
>  static struct attribute *hp_wmi_attrs[] = {
>  	&dev_attr_display.attr,
> @@ -748,6 +795,7 @@ static struct attribute *hp_wmi_attrs[] = {
>  	&dev_attr_dock.attr,
>  	&dev_attr_tablet.attr,
>  	&dev_attr_postcode.attr,
> +	&dev_attr_kbd_rgb.attr,
>  	NULL,
>  };
>  ATTRIBUTE_GROUPS(hp_wmi);
> @@ -853,6 +901,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  	case HPWMI_PROXIMITY_SENSOR:
>  		break;
>  	case HPWMI_BACKLIT_KB_BRIGHTNESS:
> +		sparse_keymap_report_event(hp_wmi_input_dev,
> +						KEY_KBDILLUMTOGGLE, 1, true);

Please just directly report the key instead of inserting a fake scancode into
the parse-map:

		input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, true);
		input_sync(hp_wmi_input_dev);
		input_report_key(hp_wmi_input_dev, KEY_KBDILLUMTOGGLE, false);
		input_sync(hp_wmi_input_dev);
>  		break;
>  	case HPWMI_PEAKSHIFT_PERIOD:
>  		break;
> @@ -1294,6 +1344,63 @@ static int thermal_profile_setup(void)
>  
>  static int hp_wmi_hwmon_init(void);
>  
> +static struct led_classdev omen_kbd_led;
> +
> +static enum led_brightness get_omen_backlight_brightness(struct led_classdev *cdev)
> +{
> +	u8 val;
> +
> +	int ret = hp_wmi_perform_query(HPWMI_HARDWARE_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
> +
> +	if (ret)
> +		return ret;
> +
> +	return (val & 0x80) ? LED_ON : LED_OFF;
> +}
> +
> +static void set_omen_backlight_brightness(struct led_classdev *cdev, enum led_brightness value)
> +{
> +	char buffer[4] = { (value == LED_OFF) ? 0x64 : 0xe4, 0, 0, 0 };
> +
> +	hp_wmi_perform_query(HPWMI_WIRELESS_QUERY, HPWMI_KB, &buffer,
> +				       sizeof(buffer), 0);
> +}
> +
> +
> +static bool is_omen_lighting_supported(void)
> +{
> +	u8 val;
> +
> +	int ret = hp_wmi_perform_query(HPWMI_DISPLAY_QUERY, HPWMI_KB, &val, zero_if_sup(val), sizeof(val));
> +
> +	if (ret)
> +		return false;
> +
> +	return (val & 1) == 1;
> +}
> +
> +static int omen_backlight_init(struct device *dev)
> +{
> +	int ret;
> +
> +	omen_kbd_led.name = "hp_omen::kbd_backlight";
> +	omen_kbd_led.brightness_set = set_omen_backlight_brightness;
> +	omen_kbd_led.brightness_get = get_omen_backlight_brightness;
> +	omen_kbd_led.max_brightness = 1;
> +
> +	ret = devm_led_classdev_register(dev, &omen_kbd_led);
> +
> +	if (ret < 0)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static void omen_backlight_exit(struct device *dev)
> +{
> +	devm_led_classdev_unregister(dev, &omen_kbd_led);
> +}
> +

This is not necessary, the whole idea behin devm is that this
will automatically get unegistered on driver unbind.

>  static int __init hp_wmi_bios_setup(struct platform_device *device)
>  {
>  	int err;
> @@ -1321,6 +1428,9 @@ static int __init hp_wmi_bios_setup(struct platform_device *device)
>  
>  	thermal_profile_setup();
>  
> +	if (is_omen_lighting_supported())
> +		omen_backlight_init(&device->dev);
> +
>  	return 0;
>  }
>  
> @@ -1349,6 +1459,9 @@ static int __exit hp_wmi_bios_remove(struct platform_device *device)
>  	if (platform_profile_support)
>  		platform_profile_remove();
>  
> +	if (is_omen_lighting_supported())
> +		omen_backlight_exit(&device->dev);
> +

And this likewise thus is not necessary.

>  	return 0;
>  }
>  

Regards,

Hans

