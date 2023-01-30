Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD3468150B
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237167AbjA3Pbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237210AbjA3Pbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:31:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E0110AB2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675092647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7W1MuWAjR0OB0X+7FKdl8QDF939WLO0Ry5A9KV0FdU4=;
        b=DYhSt92TOGtSwHXiF2Q1a/22BLJOcuVnA8PMjnXuONyCCJWLl5DeqKPnNOhiPXJFVB1LyI
        dr3H4EsTDukExjy3RAlTBEnSpX8MsnYx0yF7ibqhEQMT8ILrOXCsC/aBUP5VWXIhW8IQ5M
        xL1W3KVMwgsrsBz8R2IYZPbcfmweKxA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-130--UvV_YcwORWDPuKqYUr0xg-1; Mon, 30 Jan 2023 10:30:46 -0500
X-MC-Unique: -UvV_YcwORWDPuKqYUr0xg-1
Received: by mail-ej1-f72.google.com with SMTP id d10-20020a170906640a00b008787d18c373so6559388ejm.17
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:30:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7W1MuWAjR0OB0X+7FKdl8QDF939WLO0Ry5A9KV0FdU4=;
        b=WdP88lA+rQT2zTW258t/fH9LkSy1PtDqm8l+pc4u5g/jZGOA7AlylkWhR+Y+AbePf4
         O6+Jl+YJ3BJe3VKNfl+xafWSfkJy4NXF9uOmuqHtj7WCTJYolsWD0xxVz311rDxPiXi1
         iMucj7iBNuMQ3IDf0VYlE6qfZK5BJxQGxNIuUFxchXCXGqLnlHoN+tk63e9Yw1CQ1bJQ
         66oP+FlS4/JPykUIyP2f827AktGEjnIsjLizWWfSYjd7IzwkGnIxgeUNj+7uanETi9af
         BgDWLp5/7wsp/aIIUQEZTRUDcGEVIqcLzLR811sqHCduiDHjVXqrMhztSm84w3FjF6mI
         DdCw==
X-Gm-Message-State: AFqh2kqm/eUUdSr7LkwU82hI5BuJkDJcM3TiRfPTN54g8UhZEXR7p8EM
        QT11vTz26ZqoP8iW/W1JEPL1A2tVxk6hSfaNRcGsULe2ZKcCbcKbubCg8AeAe4iPmCrZQwZFWm0
        bh8+h16aMv1OiQOqg8gC2eMe+
X-Received: by 2002:a05:6402:528b:b0:49e:28c1:9375 with SMTP id en11-20020a056402528b00b0049e28c19375mr53987199edb.10.1675092645230;
        Mon, 30 Jan 2023 07:30:45 -0800 (PST)
X-Google-Smtp-Source: AMrXdXukQme/Sec8I/w0YypnYiTaMAM1stJuuJK4kkO0erwe5I8WKCX+den1Mk9JE9Hwn9WzKXagkw==
X-Received: by 2002:a05:6402:528b:b0:49e:28c1:9375 with SMTP id en11-20020a056402528b00b0049e28c19375mr53987170edb.10.1675092644929;
        Mon, 30 Jan 2023 07:30:44 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id n3-20020a05640204c300b004a23609fab4sm2792267edw.70.2023.01.30.07.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 07:30:44 -0800 (PST)
Message-ID: <aaf3e646-b117-3ddf-444e-fabc12d76543@redhat.com>
Date:   Mon, 30 Jan 2023 16:30:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/5] platform/x86: dell-ddv: Add hwmon support
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126194021.381092-1-W_Armin@gmx.de>
 <20230126194021.381092-6-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230126194021.381092-6-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

On 1/26/23 20:40, Armin Wolf wrote:
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
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
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

Previously we discussed how expensive some of these calls are. I assume that this
call also is not really "free" to make. Even if it does a fast read from some hw
buffer it still needs to go through the ACPI interpreter and then actually read
from the hw.

It seems that there are just 2 sort of calls made to dell_wmi_ddv_query_sensors:

1. DELL_DDV_THERMAL_SENSOR_INFORMATION
2. DELL_DDV_FAN_SENSOR_INFORMATION

Userspace apps using hwmon will typically have some periodically refreshing
display and when the refresh timer expires they will read all hwmon
attributes in one go.

To avoid this causing unnecessary overhead many hwmon drivers use a driver
based cache and they then refresh the cache if the cache is older then 30 seconds
when userspace does its next read of an attribute.

See e.g. drivers/hwmon/f71882fg.c and the use of the update_lock, valid and
last_updated members of struct f71882fg_data.

Below I see that the return value of a single dell_wmi_ddv_query_sensors() call
returns data for 3 different attributes * count-channels = 3, 6 or 9 read
calls. So to me this sounds like it is worthwhile caching the result.

You can just store a pointer to the returned ACPI-obj and free the old
ACPI obj when it is time to refresh the cache, instead of immidiately
free-ing the obj when the read function returns.

You can use either separate last_updated timestamps for 
DELL_DDV_THERMAL_SENSOR_INFORMATION + DELL_DDV_FAN_SENSOR_INFORMATION,
or just update both at once when the cache is stale. Either way works for me.

This way we gain a significant amount of efficiency wrt not doing the
expensive WMI call multiple times for naught and we avoid userspace
being able to "hammer" the underlying hw with repeated requests (userspace
can still burn 100% CPU on one core of course).









> +	if (ret < 0)
> +		return ret;
> +
> +	entry = (struct thermal_sensor_entry *)obj->package.elements[1].buffer.pointer;
> +	if (count > channel) {

As Guenter already sorta said, please do error handling first,
change this to something like this:

	if (channel >= count) {
		ret = -ENXIO;
		goto out_free;
	}


And then reduce the indentation the switch case by 1 tab / level.

Generally speaking we want the straight (no errors) path to be
indentend by only 1 tab so that if you just read all the lines at
that 1 tab indentation level you are actually reading the normal /
no-errors code path.

Also note that if you switch to a cache as suggested above,
you no longer need the kfree() since that is now done in your
cache-refresh helper.

And then the error check changes to just:

	if (channel >= data->thermal_sensor_count)
		return -ENXIO;




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

I'm fine with not making either _add failing an error, but can we make this a dev_warn,
dev_dbg is a bit too low of a log-level for something which is not supposed to happen.

E.g. change this to:

	ret = dell_wmi_ddv_hwmon_add(data);
	if (ret && ret != -ENODEV)
		dev_warn(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);



> +
> +	ret = dell_wmi_ddv_battery_add(data);
> +	if (ret < 0)
> +		dev_dbg(&wdev->dev, "Unable to register acpi battery hook: %d\n", ret);

And the same here.

Regards,

Hans


> +
> +	return 0;
>  }
> 
>  static const struct wmi_device_id dell_wmi_ddv_id_table[] = {
> --
> 2.30.2
> 

