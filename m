Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E2167E621
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 14:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjA0NJJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 08:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjA0NI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 08:08:59 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210797EFD3;
        Fri, 27 Jan 2023 05:08:19 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id t7-20020a05683014c700b006864760b1caso2136092otq.0;
        Fri, 27 Jan 2023 05:08:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mdj6XOXFYUD1vp/9oZxmYr9pvWZQw2WEe+CA+3BAP4Y=;
        b=HE7J2owfGbAbSkpRZeozNoCsXC+J81kBqfsK8pIWlCSET6mEroNNdRUSsgrIbiBgQi
         tuHlZTH60bec4njROd0iktdzdhKOitwrvR9h3amqUnULyQ1nWdNCv1kGylMxVcxvJkiD
         PCNpsyzEMG9zUlJb9/3P+k8jiFtrkiWK0Vo029zCFdMgH6spKf/d11MeqET1TR8S58or
         +i04eWALkuqHzMBklcXHmh869ny0fGvPXEf5Wj4bGXLQ9ydHDGs+EwLkH0Ng7gAu79kH
         yELMOSU3h4jf4xwJ17wiDijk39jEXiWipCuecZiVW6jlrA26WIAVMXmX25+Kdku7fY/B
         XrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mdj6XOXFYUD1vp/9oZxmYr9pvWZQw2WEe+CA+3BAP4Y=;
        b=PibJ8y1yRh3dyVxH/kpKZHNB7RijXC5W2mM67YrWhCxC4umygBrqYawZvVAadm8CUK
         G7sric6UpoayXrhbE6/qDZ/RQVP41WJQb1vYUiokbqLEwaC2dxANIY32SPCAAtB/dBxQ
         UraT8SHnOlAV9pfE64Qub5G1t+mtUUrRffhb/dC+4G0Ovm904BEBM5CtBgmttpWf6cWl
         GWFSEw7Io//aSybVTnSMjDx9ttTUrzzIEQq3DEGC56hjNNEjKuZnAkadGt6IUmhA3vYp
         sedVs5OpqZJwTBa78/BsRMp3h7bmKMUYNdEW+UOnGjArhFwPy/9DETXFXDDp3UKb0LBn
         wJiQ==
X-Gm-Message-State: AO0yUKUKgN/E3JF5X1Uj/zFbjbgiQnB014U36m4PovvOPft8CYCZWazJ
        4dfsFA4gy+I5NYoRO6pyeJY=
X-Google-Smtp-Source: AK7set8S1SktctHbWEPubzDmfHK/SBZ+yY3SR7xFMZb5s8qapgvVZVTa1oDP0nrDxGe6DSVBU2esDA==
X-Received: by 2002:a9d:65d3:0:b0:68b:9c22:19cd with SMTP id z19-20020a9d65d3000000b0068b9c2219cdmr729449oth.28.1674824898154;
        Fri, 27 Jan 2023 05:08:18 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t18-20020a9d66d2000000b0068b93a70d73sm549414otm.52.2023.01.27.05.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 05:08:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 27 Jan 2023 05:08:15 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, jdelvare@suse.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: dell-ddv: Add hwmon support
Message-ID: <20230127130815.GA3911997@roeck-us.net>
References: <20230126194021.381092-1-W_Armin@gmx.de>
 <20230126194021.381092-6-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230126194021.381092-6-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 08:40:21PM +0100, Armin Wolf wrote:
> Thanks to bugreport 216655 on bugzilla triggered by the
> dell-smm-hwmon driver, the contents of the sensor buffers
> could be almost completely decoded.
> Add an hwmon interface for exposing the fan and thermal
> sensor values. The debugfs interface remains in place to
> aid in reverse-engineering of unknown sensor types
> and the thermal buffer.
> 
> Tested-by: Antonín Skala <skala.antonin@gmail.com>
> Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/platform/x86/dell/Kconfig        |   1 +
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 435 ++++++++++++++++++++++-
>  2 files changed, 435 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index d319de8f2132..21a74b63d9b1 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -194,6 +194,7 @@ config DELL_WMI_DDV
>  	default m
>  	depends on ACPI_BATTERY
>  	depends on ACPI_WMI
> +	depends on HWMON

Not sure if adding such a dependency is a good idea.
Up to the maintainer to decide. Personally I would prefer
something like
	depends on HWMON || HWMON=n
and some conditionals in the code, as it is done with other drivers
outside the hwmon directory.

>  	help
>  	  This option adds support for WMI-based sensors like
>  	  battery temperature sensors found on some Dell notebooks.
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 9695bf493ea6..5b30bb85199e 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -13,6 +13,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> +#include <linux/hwmon.h>
>  #include <linux/kstrtox.h>
>  #include <linux/math.h>
>  #include <linux/module.h>
> @@ -21,10 +22,13 @@
>  #include <linux/printk.h>
>  #include <linux/seq_file.h>
>  #include <linux/sysfs.h>
> +#include <linux/types.h>
>  #include <linux/wmi.h>
> 
>  #include <acpi/battery.h>
> 
> +#include <asm/unaligned.h>
> +
>  #define DRIVER_NAME	"dell-wmi-ddv"
> 
>  #define DELL_DDV_SUPPORTED_VERSION_MIN	2
> @@ -63,6 +67,29 @@ enum dell_ddv_method {
>  	DELL_DDV_THERMAL_SENSOR_INFORMATION	= 0x22,
>  };
> 
> +struct fan_sensor_entry {
> +	u8 type;
> +	__le16 rpm;
> +} __packed;
> +
> +struct thermal_sensor_entry {
> +	u8 type;
> +	s8 now;
> +	s8 min;
> +	s8 max;
> +	u8 unknown;
> +} __packed;
> +
> +struct combined_channel_info {
> +	struct hwmon_channel_info info;
> +	u32 config[];
> +};
> +
> +struct combined_chip_info {
> +	struct hwmon_chip_info chip;
> +	const struct hwmon_channel_info *info[];
> +};
> +
>  struct dell_wmi_ddv_data {
>  	struct acpi_battery_hook hook;
>  	struct device_attribute temp_attr;
> @@ -70,6 +97,24 @@ struct dell_wmi_ddv_data {
>  	struct wmi_device *wdev;
>  };
> 
> +static const char * const fan_labels[] = {
> +	"CPU Fan",
> +	"Chassis Motherboard Fan",
> +	"Video Fan",
> +	"Power Supply Fan",
> +	"Chipset Fan",
> +	"Memory Fan",
> +	"PCI Fan",
> +	"HDD Fan",
> +};
> +
> +static const char * const fan_dock_labels[] = {
> +	"Docking Chassis/Motherboard Fan",
> +	"Docking Video Fan",
> +	"Docking Power Supply Fan",
> +	"Docking Chipset Fan",
> +};
> +
>  static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv_method method, u32 arg,
>  				   union acpi_object **result, acpi_object_type type)
>  {
> @@ -171,6 +216,386 @@ static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_ddv_meth
>  	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRING);
>  }
> 
> +static int dell_wmi_ddv_query_sensors(struct wmi_device *wdev, enum dell_ddv_method method,
> +				      size_t entry_size, union acpi_object **result, u64 *count)
> +{
> +	union acpi_object *obj;
> +	u64 buffer_size;
> +	u8 *buffer;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_buffer(wdev, method, 0, &obj);
> +	if (ret < 0)
> +		return ret;
> +
> +	buffer_size = obj->package.elements[0].integer.value;
> +	buffer = obj->package.elements[1].buffer.pointer;
> +	if (buffer_size % entry_size != 1 || buffer[buffer_size - 1] != 0xff) {
> +		kfree(obj);
> +

Stray empty line

> +		return -ENOMSG;
> +	}
> +
> +	*count = (buffer_size - 1) / entry_size;
> +	*result = obj;
> +
> +	return 0;
> +}
> +
> +static umode_t dell_wmi_ddv_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
> +				       int channel)
> +{
> +	return 0444;
> +}
> +
> +static int dell_wmi_ddv_fan_read_channel(struct dell_wmi_ddv_data *data, u32 attr, int channel,
> +					 long *val)
> +{
> +	struct fan_sensor_entry *entry;
> +	union acpi_object *obj;
> +	u64 count;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
> +					 sizeof(*entry), &obj, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	entry = (struct fan_sensor_entry *)obj->package.elements[1].buffer.pointer;
> +	if (count > channel) {
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			*val = get_unaligned_le16(&entry[channel].rpm);
> +

Another stray empty line. I see that "empty line before return or break"
is common. Looks odd to me, and I don't see the point (it confuses
the code flow for me and lets my brain focus on the empty line instead
of the code in question), but I guess that is PoV. I won't comment on
it further and let the maintainer decide.

> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +		}
> +	} else {
> +		ret = -ENXIO;
> +	}

Error handling should come first.

> +
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_ddv_temp_read_channel(struct dell_wmi_ddv_data *data, u32 attr, int channel,
> +					  long *val)
> +{
> +	struct thermal_sensor_entry *entry;
> +	union acpi_object *obj;
> +	u64 count;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
> +					 sizeof(*entry), &obj, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	entry = (struct thermal_sensor_entry *)obj->package.elements[1].buffer.pointer;
> +	if (count > channel) {

This is a bit of Joda programming. It is really "channel < count",
ie the requested channel number is in the range of channels reported
by the WMI code. PoV, of course, but I find that the above makes the
code more difficult to read.

> +		switch (attr) {
> +		case hwmon_temp_input:
> +			*val = entry[channel].now * 1000;
> +
> +			break;
> +		case hwmon_temp_min:
> +			*val = entry[channel].min * 1000;
> +
> +			break;
> +		case hwmon_temp_max:
> +			*val = entry[channel].max * 1000;
> +
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;

break; missing

> +		}
> +	} else {
> +		ret = -ENXIO;
> +	}

Same as above - error handling should come first.

> +
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_ddv_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			     int channel, long *val)
> +{
> +	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		return dell_wmi_ddv_fan_read_channel(data, attr, channel, val);
> +	case hwmon_temp:
> +		return dell_wmi_ddv_temp_read_channel(data, attr, channel, val);
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int dell_wmi_ddv_fan_read_string(struct dell_wmi_ddv_data *data, int channel,
> +					const char **str)
> +{
> +	struct fan_sensor_entry *entry;
> +	union acpi_object *obj;
> +	u64 count;
> +	u8 type;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
> +					 sizeof(*entry), &obj, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	entry = (struct fan_sensor_entry *)obj->package.elements[1].buffer.pointer;
> +	if (count > channel) {
> +		type = entry[channel].type;
> +
> +		switch (type) {
> +		case 0x00 ... 0x07:
> +			*str = fan_labels[type];
> +
> +			break;
> +		case 0x11 ... 0x14:
> +			*str = fan_dock_labels[type - 0x11];
> +
> +			break;
> +		default:
> +			*str = "Unknown Fan";

break; missing.

> +		}
> +	} else {
> +		ret = -ENXIO;
> +	}

And again.

> +
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_ddv_temp_read_string(struct dell_wmi_ddv_data *data, int channel,
> +					 const char **str)
> +{
> +	struct thermal_sensor_entry *entry;
> +	union acpi_object *obj;
> +	u64 count;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
> +					 sizeof(*entry), &obj, &count);
> +	if (ret < 0)
> +		return ret;
> +
> +	entry = (struct thermal_sensor_entry *)obj->package.elements[1].buffer.pointer;
> +	if (count > channel) {
> +		switch (entry[channel].type) {
> +		case 0x00:
> +			*str = "CPU";
> +
> +			break;
> +		case 0x11:
> +			*str = "Video";
> +
> +			break;
> +		case 0x22:
> +			*str = "Memory"; // sometimes called DIMM

Personally I don't permit C++ style comments in a hwmon driver
unless _all_ comments are C++ style. Just a remark here.

> +
> +			break;
> +		case 0x33:
> +			*str = "Other";
> +
> +			break;
> +		case 0x44:
> +			*str = "Ambient"; // sometimes called SKIN
> +
> +			break;
> +		case 0x52:
> +			*str = "SODIMM";
> +
> +			break;
> +		case 0x55:
> +			*str = "HDD";
> +
> +			break;
> +		case 0x62:
> +			*str = "SODIMM 2";
> +
> +			break;
> +		case 0x73:
> +			*str = "NB";
> +
> +			break;
> +		case 0x83:
> +			*str = "Charger";
> +
> +			break;
> +		case 0xbb:
> +			*str = "Memory 3";
> +
> +			break;
> +		default:
> +			*str = "Unknown";

break; missing
Ok, I guess this is on purpose. I personally don't permit
that since it always leaves the question if it was on purpose or not.

> +		}
> +	} else {
> +		ret = -ENXIO;
> +	}
> +
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_ddv_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				    int channel, const char **str)
> +{
> +	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_label:
> +			return dell_wmi_ddv_fan_read_string(data, channel, str);
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_label:
> +			return dell_wmi_ddv_temp_read_string(data, channel, str);
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const struct hwmon_ops dell_wmi_ddv_ops = {
> +	.is_visible = dell_wmi_ddv_is_visible,
> +	.read = dell_wmi_ddv_read,
> +	.read_string = dell_wmi_ddv_read_string,
> +};
> +
> +static struct hwmon_channel_info *dell_wmi_ddv_channel_create(struct device *dev, u64 count,
> +							      enum hwmon_sensor_types type,
> +							      u32 config)
> +{
> +	struct combined_channel_info *cinfo;
> +	int i;
> +
> +	cinfo = devm_kzalloc(dev, struct_size(cinfo, config, count + 1), GFP_KERNEL);
> +	if (!cinfo)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cinfo->info.type = type;
> +	cinfo->info.config = cinfo->config;
> +
> +	for (i = 0; i < count; i++)
> +		cinfo->config[i] = config;
> +
> +	return &cinfo->info;
> +}
> +
> +static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *wdev,
> +							    enum dell_ddv_method method,
> +							    size_t entry_size,
> +							    enum hwmon_sensor_types type,
> +							    u32 config)
> +{
> +	union acpi_object *obj;
> +	u64 count;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_sensors(wdev, method, entry_size, &obj, &count);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	kfree(obj);
> +
> +	if (!count)
> +		return ERR_PTR(-ENODEV);
> +
> +	return dell_wmi_ddv_channel_create(&wdev->dev, count, type, config);
> +}
> +
> +static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
> +{
> +	struct wmi_device *wdev = data->wdev;
> +	struct combined_chip_info *cinfo;
> +	struct device *hdev;
> +	int index = 0;
> +	int ret;
> +
> +	if (!devres_open_group(&wdev->dev, dell_wmi_ddv_hwmon_add, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	cinfo = devm_kzalloc(&wdev->dev, struct_size(cinfo, info, 4), GFP_KERNEL);
> +	if (!cinfo) {
> +		ret = -ENOMEM;
> +
> +		goto err_release;
> +	}
> +
> +	cinfo->chip.ops = &dell_wmi_ddv_ops;
> +	cinfo->chip.info = cinfo->info;
> +
> +	cinfo->info[index] = dell_wmi_ddv_channel_create(&wdev->dev, 1, hwmon_chip,
> +							 HWMON_C_REGISTER_TZ);
> +
> +	if (IS_ERR(cinfo->info[index])) {
> +		ret = PTR_ERR(cinfo->info[index]);
> +
> +		goto err_release;
> +	}
> +
> +	index++;
> +
> +	cinfo->info[index] = dell_wmi_ddv_channel_init(wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
> +						       sizeof(struct fan_sensor_entry), hwmon_fan,
> +						       (HWMON_F_INPUT | HWMON_F_LABEL));
> +	if (!IS_ERR(cinfo->info[index]))
> +		index++;
> +
> +	cinfo->info[index] = dell_wmi_ddv_channel_init(wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
> +						       sizeof(struct thermal_sensor_entry),
> +						       hwmon_temp, (HWMON_T_INPUT | HWMON_T_MIN |
> +						       HWMON_T_MAX | HWMON_T_LABEL));
> +	if (!IS_ERR(cinfo->info[index]))
> +		index++;
> +
> +	if (!index) {
> +		ret = -ENODEV;
> +
> +		goto err_release;
> +	}
> +
> +	cinfo->info[index] = NULL;
> +
> +	hdev = devm_hwmon_device_register_with_info(&wdev->dev, "dell_ddv", data, &cinfo->chip,
> +						    NULL);
> +	if (IS_ERR(hdev)) {
> +		ret = PTR_ERR(hdev);
> +
> +		goto err_release;
> +	}
> +
> +	devres_close_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
> +
> +	return 0;
> +
> +err_release:
> +	devres_release_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
> +
> +	return ret;
> +}
> +
>  static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *index)
>  {
>  	const char *uid_str;
> @@ -370,7 +795,15 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *context)
> 
>  	dell_wmi_ddv_debugfs_init(wdev);
> 
> -	return dell_wmi_ddv_battery_add(data);
> +	ret = dell_wmi_ddv_hwmon_add(data);
> +	if (ret < 0)
> +		dev_dbg(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
> +
> +	ret = dell_wmi_ddv_battery_add(data);
> +	if (ret < 0)
> +		dev_dbg(&wdev->dev, "Unable to register acpi battery hook: %d\n", ret);
> +

This used to be an error, but no longer is. Not my call to make
if this is acceptable, just pointing it out.

> +	return 0;
>  }
> 
>  static const struct wmi_device_id dell_wmi_ddv_id_table[] = {
> --
> 2.30.2
> 
