Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788AC750B67
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjGLOtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjGLOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F951BE5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689173309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1KpSssKMIgC0UPbDdqI0j9HY5oH6D5zOHCu9BHTLLuQ=;
        b=CO4H/Qg5L6axJ1Bydzn/psSL0YgMkGq+3/EdW1tbghb3asgLzPsR1i16E9LuJuwR7Ct4pd
        LFdZ7v/slqJgbtzTTUH98r9PB05NOcE/S2ViwTk9eWx8wkHFmGrampvq6NRrXd9+aZ/dwC
        QhfvV0XkW215VP+T51ng4sxcoMre+78=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-7AfMiFblMlacIwmSLvDyAA-1; Wed, 12 Jul 2023 10:48:26 -0400
X-MC-Unique: 7AfMiFblMlacIwmSLvDyAA-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-94a34a0b75eso431227166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 07:48:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689173305; x=1691765305;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KpSssKMIgC0UPbDdqI0j9HY5oH6D5zOHCu9BHTLLuQ=;
        b=YnBg7Ar7utLOar9wsusB/kRzU0OJpKSZ7BeqGO4eGkNdYSKfPCc9PaKjWkyYJ4QaV0
         /ab8TY0BLAm7iSEz4gHux/OxRcBht0juvt6O8Z/OMVo+Cp0/JWa2BQhIU0Z8Xnxhoy/v
         ss7muMJIM+4rfOGAJTolNoixxEmEx82pUxjtUXNGqupDFZB7Lohe2+KIvsWvlQEo58lm
         r86v2jqDvxmommzqUvC5lrSZMP4pn7i/y5N8G/Cn/DTlYeaK4q4nCxmZ7mPzLXIxRuvk
         SvzyNtgnUsbD1o8W+jMUcqpH+XZIheNgxtZtKLibOrkmXBc00L2hEhQyReBTMSoe8LLs
         sQ8A==
X-Gm-Message-State: ABy/qLaXhFYCYO50+4Uffoy0CpwNjaFpcZp2xyvtfQAdLYUU63ol5FKp
        ucdYFunhpImR3uFuL5TYAzuNR5lpSk5pEctMOY+vBYERhKU7x6S3AjIUk3+R2TzLk8fuWEa3sX8
        sSoDY26+CPTrSfyb8PRWWKMuH
X-Received: by 2002:a17:907:b9d1:b0:98e:26ae:9b08 with SMTP id xa17-20020a170907b9d100b0098e26ae9b08mr20214283ejc.58.1689173305320;
        Wed, 12 Jul 2023 07:48:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHikde8vkqS0SQD/NwiyYtXfkqDJSRqFJkWGc88nbjcS4R56JaZ+oynazWWITKiVwPVhTIO8Q==
X-Received: by 2002:a17:907:b9d1:b0:98e:26ae:9b08 with SMTP id xa17-20020a170907b9d100b0098e26ae9b08mr20214265ejc.58.1689173305031;
        Wed, 12 Jul 2023 07:48:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d20-20020a17090648d400b00993feabdc6asm2655498ejt.157.2023.07.12.07.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 07:48:24 -0700 (PDT)
Message-ID: <43985ad2-401c-3632-c045-90049d600217@redhat.com>
Date:   Wed, 12 Jul 2023 16:48:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/8] platform/x86: asus-wmi: support setting mini-LED
 mode
Content-Language: en-US, nl
To:     "Luke D. Jones" <luke@ljones.dev>
Cc:     corentin.chary@gmail.com, acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, markgross@kernel.org,
        jdelvare@suse.com, linux@roeck-us.net
References: <20230630053552.976579-1-luke@ljones.dev>
 <20230630053552.976579-8-luke@ljones.dev>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230630053552.976579-8-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/30/23 07:35, Luke D. Jones wrote:
> Support changing the mini-LED mode on some of the newer ASUS laptops.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>

Thanks, patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
>  .../ABI/testing/sysfs-platform-asus-wmi       |  9 ++++
>  drivers/platform/x86/asus-wmi.c               | 53 +++++++++++++++++++
>  include/linux/platform_data/x86/asus-wmi.h    |  1 +
>  3 files changed, 63 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> index 878daf7c2036..5624bdef49cb 100644
> --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> @@ -117,3 +117,12 @@ Description:
>  		Show if the egpu (XG Mobile) is correctly connected:
>  			* 0 - False,
>  			* 1 - True
> +
> +What:		/sys/devices/platform/<platform>/mini_led_mode
> +Date:		Jun 2023
> +KernelVersion:	6.5
> +Contact:	"Luke Jones" <luke@ljones.dev>
> +Description:
> +		Change the mini-LED mode:
> +			* 0 - Single-zone,
> +			* 1 - Multi-zone
> diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> index 602426a7fb41..1fc9e8afc2f3 100644
> --- a/drivers/platform/x86/asus-wmi.c
> +++ b/drivers/platform/x86/asus-wmi.c
> @@ -265,6 +265,7 @@ struct asus_wmi {
>  	bool battery_rsoc_available;
>  
>  	bool panel_overdrive_available;
> +	bool mini_led_mode_available;
>  
>  	struct hotplug_slot hotplug_slot;
>  	struct mutex hotplug_lock;
> @@ -1820,6 +1821,54 @@ static ssize_t panel_od_store(struct device *dev,
>  }
>  static DEVICE_ATTR_RW(panel_od);
>  
> +/* Mini-LED mode **************************************************************/
> +static ssize_t mini_led_mode_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +	int result;
> +
> +	result = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
> +	if (result < 0)
> +		return result;
> +
> +	return sysfs_emit(buf, "%d\n", result);
> +}
> +
> +static ssize_t mini_led_mode_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 mode;
> +
> +	struct asus_wmi *asus = dev_get_drvdata(dev);
> +
> +	result = kstrtou32(buf, 10, &mode);
> +	if (result)
> +		return result;
> +
> +	if (mode > 1)
> +		return -EINVAL;
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_MINI_LED_MODE, mode, &result);
> +
> +	if (err) {
> +		pr_warn("Failed to set mini-LED: %d\n", err);
> +		return err;
> +	}
> +
> +	if (result > 1) {
> +		pr_warn("Failed to set mini-LED mode (result): 0x%x\n", result);
> +		return -EIO;
> +	}
> +
> +	sysfs_notify(&asus->platform_device->dev.kobj, NULL, "mini_led_mode");
> +
> +	return count;
> +}
> +static DEVICE_ATTR_RW(mini_led_mode);
> +
>  /* Quirks *********************************************************************/
>  
>  static void asus_wmi_set_xusb2pr(struct asus_wmi *asus)
> @@ -3727,6 +3776,7 @@ static struct attribute *platform_attributes[] = {
>  	&dev_attr_fan_boost_mode.attr,
>  	&dev_attr_throttle_thermal_policy.attr,
>  	&dev_attr_panel_od.attr,
> +	&dev_attr_mini_led_mode.attr,
>  	NULL
>  };
>  
> @@ -3764,6 +3814,8 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
>  		ok = asus->throttle_thermal_policy_available;
>  	else if (attr == &dev_attr_panel_od.attr)
>  		ok = asus->panel_overdrive_available;
> +	else if (attr == &dev_attr_mini_led_mode.attr)
> +		ok = asus->mini_led_mode_available;
>  
>  	if (devid != -1)
>  		ok = !(asus_wmi_get_devstate_simple(asus, devid) < 0);
> @@ -4026,6 +4078,7 @@ static int asus_wmi_add(struct platform_device *pdev)
>  	asus->kbd_rgb_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE);
>  	asus->kbd_rgb_state_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_STATE);
>  	asus->panel_overdrive_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_PANEL_OD);
> +	asus->mini_led_mode_available = asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_MINI_LED_MODE);
>  
>  	err = fan_boost_mode_check_present(asus);
>  	if (err)
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 2034648f8cdf..ea80361ac6c7 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -66,6 +66,7 @@
>  #define ASUS_WMI_DEVID_CAMERA		0x00060013
>  #define ASUS_WMI_DEVID_LID_FLIP		0x00060062
>  #define ASUS_WMI_DEVID_LID_FLIP_ROG	0x00060077
> +#define ASUS_WMI_DEVID_MINI_LED_MODE	0x0005001E
>  
>  /* Storage */
>  #define ASUS_WMI_DEVID_CARDREADER	0x00080013

