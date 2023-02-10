Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C136917D4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 06:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjBJFAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 00:00:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBJFAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 00:00:51 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AEC45F64;
        Thu,  9 Feb 2023 21:00:48 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id dt8so3626727oib.0;
        Thu, 09 Feb 2023 21:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+M+Gtjp+ZGltrlXzqyMRQoRVGM0tfwAT1ZfVHi1wyQ=;
        b=nvKPj5Cca2omzt6FZpYHCTq/q4s6MbdVRKwKTsceUhtnZAZF8T4AzjmL3Jzm/bR2TX
         keUnVQAGjQ3jP4fqPwI50WdvmdOXwUx0gBvaGLHV8z1f5o+mvC1RwwC3+nigoHzQE9Wo
         jNU5SLXd41c9lKSUDM1WVxDcf024l9M7BXTWCe+9GWkIEIdMACRKQfzlSm+aR7FONOP4
         JWqVjEbNAUAZwhY+rFDmhVzYNoV5L9Xofeu+Ap7zysecMqKwp9MVnETmky9zQ3dHKV+r
         eK9IZWDsNNqxH9vvdGTDOvivHkMMSOsHRHE8CZbSmlb4TL9zDWUF8sq4GlF54GE/XSbU
         DmXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S+M+Gtjp+ZGltrlXzqyMRQoRVGM0tfwAT1ZfVHi1wyQ=;
        b=1kJDrbYcGSTVa482pTCfTA4Cauc5FphyteRdF1HrZiWgJeF9+fgsXtaP5Bmn/TGD28
         vuj/ZCgtz7Jo+rq/IkbFLxYLsWbdg0yFHcB+UZEjN7bEFfdU2DbFgEr6qTJgZ0+NBvO5
         2G8SHIutUdVRYSbr72POFJi3lww+OZxFYnPlWPHeHSMz77s29INSu/dcAnOjHULKqxZK
         95/GODXCqsLpjwDpsYmAAi6WNgg+8pOcU6AgPAUKODEHrLGLFRHJWePFpinpqUnQ8nTl
         Um+d28BcuKSWJ7ztnhD80tjvIRHuOsBtVeSicVjHdkDPY5SREC/p5XNpGE85jmt6eJUu
         ajEw==
X-Gm-Message-State: AO0yUKXnIXdz0RLgFfEVMrJ34h9iJZzq23kP6sW8BhxPdWJPbmgmHWjU
        agnR7nf0NT9EIj/4wsCVlS8=
X-Google-Smtp-Source: AK7set+N+JYqobUv2g12VGoGYVGe3bfA+UCG7OH1dZsI4BlhPFnulGxZuSGI8RNoDDjfgAK+v1Y/lg==
X-Received: by 2002:a05:6808:8d1:b0:378:57fc:c60a with SMTP id k17-20020a05680808d100b0037857fcc60amr6221932oij.38.1676005246941;
        Thu, 09 Feb 2023 21:00:46 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n66-20020acaef45000000b0035c073aa0d8sm1785522oih.18.2023.02.09.21.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 21:00:46 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 9 Feb 2023 21:00:44 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Armin Wolf <W_Armin@gmx.de>
Cc:     hdegoede@redhat.com, markgross@kernel.org, jdelvare@suse.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] platform/x86: dell-ddv: Add hwmon support
Message-ID: <20230210050044.GA696255@roeck-us.net>
References: <20230209211503.2739-1-W_Armin@gmx.de>
 <20230209211503.2739-2-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230209211503.2739-2-W_Armin@gmx.de>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 10:15:02PM +0100, Armin Wolf wrote:
> Thanks to bugreport 216655 on bugzilla triggered by the
> dell-smm-hwmon driver, the contents of the sensor buffers
> could be almost completely decoded.
> Add an hwmon interface for exposing the fan and thermal
> sensor values. Since the WMI interface can be quite slow
> on some machines, the sensor buffers are cached for 1 second
> to lessen the performance impact.
> The debugfs interface remains in place to aid in reverse-engineering
> of unknown sensor types and the thermal buffer.
> 
> Tested-by: Antonín Skala <skala.antonin@gmail.com>
> Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/platform/x86/dell/Kconfig        |   8 +-
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 490 ++++++++++++++++++++++-
>  2 files changed, 493 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index d319de8f2132..bdd78076b1d7 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -192,12 +192,12 @@ config DELL_WMI_DESCRIPTOR
>  config DELL_WMI_DDV
>  	tristate "Dell WMI sensors Support"
>  	default m
> -	depends on ACPI_BATTERY
>  	depends on ACPI_WMI
> +	depends on ACPI_BATTERY || HWMON
>  	help
> -	  This option adds support for WMI-based sensors like
> -	  battery temperature sensors found on some Dell notebooks.
> -	  It also supports reading of the battery ePPID.
> +	  This option adds support for WMI-based fan and thermal sensors
> +	  found on some Dell notebooks. It also supports various WMI-based battery
> +	  extras like reading of the battery temperature and ePPID.
> 
>  	  To compile this drivers as a module, choose M here: the module will
>  	  be called dell-wmi-ddv.
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> index 9695bf493ea6..d81dc4dd93e3 100644
> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -12,19 +12,27 @@
>  #include <linux/device.h>
>  #include <linux/dev_printk.h>
>  #include <linux/errno.h>
> +#include <linux/kconfig.h>
>  #include <linux/kernel.h>
> +#include <linux/hwmon.h>
>  #include <linux/kstrtox.h>
>  #include <linux/math.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
>  #include <linux/limits.h>
> +#include <linux/pm.h>
>  #include <linux/power_supply.h>
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
> @@ -63,13 +71,63 @@ enum dell_ddv_method {
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
> +struct dell_wmi_ddv_sensors {
> +	struct mutex lock;	/* protect caching */
> +	unsigned long timestamp;
> +	union acpi_object *obj;
> +	u64 entries;
> +};
> +
>  struct dell_wmi_ddv_data {
>  	struct acpi_battery_hook hook;
>  	struct device_attribute temp_attr;
>  	struct device_attribute eppid_attr;
> +	struct dell_wmi_ddv_sensors fans;
> +	struct dell_wmi_ddv_sensors temps;
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
> @@ -171,6 +229,410 @@ static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_ddv_meth
>  	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRING);
>  }
> 
> +/*
> + * Needs to be called with lock held, except during initialization.
> + */
> +static int dell_wmi_ddv_update_sensors(struct wmi_device *wdev, enum dell_ddv_method method,
> +				       struct dell_wmi_ddv_sensors *sensors, size_t entry_size)
> +{
> +	u64 buffer_size, rem, entries;
> +	union acpi_object *obj;
> +	u8 *buffer;
> +	int ret;
> +
> +	if (sensors->obj) {
> +		if (time_before(jiffies, sensors->timestamp + HZ))
> +			return 0;
> +
> +		kfree(sensors->obj);
> +		sensors->obj = NULL;
> +	}
> +
> +	ret = dell_wmi_ddv_query_buffer(wdev, method, 0, &obj);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* buffer format sanity check */
> +	buffer_size = obj->package.elements[0].integer.value;
> +	buffer = obj->package.elements[1].buffer.pointer;
> +	entries = div64_u64_rem(buffer_size, entry_size, &rem);
> +	if (rem != 1 || buffer[buffer_size - 1] != 0xff) {
> +		ret = -ENOMSG;
> +		goto err_free;
> +	}
> +
> +	if (!entries) {
> +		ret = -ENODATA;
> +		goto err_free;
> +	}
> +
> +	sensors->obj = obj;
> +	sensors->entries = entries;
> +	sensors->timestamp = jiffies;
> +
> +	return 0;
> +
> +err_free:
> +	kfree(obj);
> +
> +	return ret;
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
> +	int ret;
> +
> +	ret = dell_wmi_ddv_update_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
> +					  &data->fans, sizeof(*entry));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (channel >= data->fans.entries)
> +		return -ENXIO;
> +
> +	entry = (struct fan_sensor_entry *)data->fans.obj->package.elements[1].buffer.pointer;
> +	switch (attr) {
> +	case hwmon_fan_input:
> +		*val = get_unaligned_le16(&entry[channel].rpm);
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int dell_wmi_ddv_temp_read_channel(struct dell_wmi_ddv_data *data, u32 attr, int channel,
> +					  long *val)
> +{
> +	struct thermal_sensor_entry *entry;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_update_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
> +					  &data->temps, sizeof(*entry));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (channel >= data->temps.entries)
> +		return -ENXIO;
> +
> +	entry = (struct thermal_sensor_entry *)data->temps.obj->package.elements[1].buffer.pointer;
> +	switch (attr) {
> +	case hwmon_temp_input:
> +		*val = entry[channel].now * 1000;
> +		return 0;
> +	case hwmon_temp_min:
> +		*val = entry[channel].min * 1000;
> +		return 0;
> +	case hwmon_temp_max:
> +		*val = entry[channel].max * 1000;
> +		return 0;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static int dell_wmi_ddv_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			     int channel, long *val)
> +{
> +	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		mutex_lock(&data->fans.lock);
> +		ret = dell_wmi_ddv_fan_read_channel(data, attr, channel, val);
> +		mutex_unlock(&data->fans.lock);
> +		return ret;
> +	case hwmon_temp:
> +		mutex_lock(&data->temps.lock);
> +		ret = dell_wmi_ddv_temp_read_channel(data, attr, channel, val);
> +		mutex_unlock(&data->temps.lock);
> +		return ret;
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
> +	int ret;
> +	u8 type;
> +
> +	ret = dell_wmi_ddv_update_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
> +					  &data->fans, sizeof(*entry));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (channel >= data->fans.entries)
> +		return -ENXIO;
> +
> +	entry = (struct fan_sensor_entry *)data->fans.obj->package.elements[1].buffer.pointer;
> +	type = entry[channel].type;
> +	switch (type) {
> +	case 0x00 ... 0x07:
> +		*str = fan_labels[type];
> +		break;
> +	case 0x11 ... 0x14:
> +		*str = fan_dock_labels[type - 0x11];
> +		break;
> +	default:
> +		*str = "Unknown Fan";
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dell_wmi_ddv_temp_read_string(struct dell_wmi_ddv_data *data, int channel,
> +					 const char **str)
> +{
> +	struct thermal_sensor_entry *entry;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_update_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
> +					  &data->temps, sizeof(*entry));
> +	if (ret < 0)
> +		return ret;
> +
> +	if (channel >= data->temps.entries)
> +		return -ENXIO;
> +
> +	entry = (struct thermal_sensor_entry *)data->temps.obj->package.elements[1].buffer.pointer;
> +	switch (entry[channel].type) {
> +	case 0x00:
> +		*str = "CPU";
> +		break;
> +	case 0x11:
> +		*str = "Video";
> +		break;
> +	case 0x22:
> +		*str = "Memory"; /* sometimes called DIMM */
> +		break;
> +	case 0x33:
> +		*str = "Other";
> +		break;
> +	case 0x44:
> +		*str = "Ambient"; /* sometimes called SKIN */
> +		break;
> +	case 0x52:
> +		*str = "SODIMM";
> +		break;
> +	case 0x55:
> +		*str = "HDD";
> +		break;
> +	case 0x62:
> +		*str = "SODIMM 2";
> +		break;
> +	case 0x73:
> +		*str = "NB";
> +		break;
> +	case 0x83:
> +		*str = "Charger";
> +		break;
> +	case 0xbb:
> +		*str = "Memory 3";
> +		break;
> +	default:
> +		*str = "Unknown";
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dell_wmi_ddv_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				    int channel, const char **str)
> +{
> +	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_label:
> +			mutex_lock(&data->fans.lock);
> +			ret = dell_wmi_ddv_fan_read_string(data, channel, str);
> +			mutex_unlock(&data->fans.lock);
> +			return ret;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_label:
> +			mutex_lock(&data->temps.lock);
> +			ret = dell_wmi_ddv_temp_read_string(data, channel, str);
> +			mutex_unlock(&data->temps.lock);
> +			return ret;
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
> +static void dell_wmi_ddv_hwmon_cache_invalidate(struct dell_wmi_ddv_sensors *sensors)
> +{
> +	mutex_lock(&sensors->lock);
> +	kfree(sensors->obj);
> +	sensors->obj = NULL;
> +	mutex_unlock(&sensors->lock);
> +}
> +
> +static void dell_wmi_ddv_hwmon_cache_destroy(void *data)
> +{
> +	struct dell_wmi_ddv_sensors *sensors = data;
> +
> +	mutex_destroy(&sensors->lock);
> +	kfree(sensors->obj);
> +}
> +
> +static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *wdev,
> +							    enum dell_ddv_method method,
> +							    struct dell_wmi_ddv_sensors *sensors,
> +							    size_t entry_size,
> +							    enum hwmon_sensor_types type,
> +							    u32 config)
> +{
> +	struct hwmon_channel_info *info;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_update_sensors(wdev, method, sensors, entry_size);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	mutex_init(&sensors->lock);
> +
> +	ret = devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_hwmon_cache_destroy, sensors);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	info = dell_wmi_ddv_channel_create(&wdev->dev, sensors->entries, type, config);
> +	if (IS_ERR(info))
> +		devm_release_action(&wdev->dev, dell_wmi_ddv_hwmon_cache_destroy, sensors);
> +
> +	return info;
> +}
> +
> +static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
> +{
> +	struct wmi_device *wdev = data->wdev;
> +	struct combined_chip_info *cinfo;
> +	struct hwmon_channel_info *info;
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
> +	info = dell_wmi_ddv_channel_create(&wdev->dev, 1, hwmon_chip, HWMON_C_REGISTER_TZ);
> +	if (IS_ERR(info)) {
> +		ret = PTR_ERR(info);
> +
> +		goto err_release;
> +	}
> +
> +	cinfo->info[index] = info;
> +	index++;
> +
> +	info = dell_wmi_ddv_channel_init(wdev, DELL_DDV_FAN_SENSOR_INFORMATION, &data->fans,
> +					 sizeof(struct fan_sensor_entry), hwmon_fan,
> +					 (HWMON_F_INPUT | HWMON_F_LABEL));
> +	if (!IS_ERR(info)) {
> +		cinfo->info[index] = info;
> +		index++;
> +	}
> +
> +	info = dell_wmi_ddv_channel_init(wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION, &data->temps,
> +					 sizeof(struct thermal_sensor_entry), hwmon_temp,
> +					 (HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
> +					 HWMON_T_LABEL));
> +	if (!IS_ERR(info)) {
> +		cinfo->info[index] = info;
> +		index++;
> +	}
> +
> +	if (index < 2) {
> +		ret = -ENODEV;
> +
> +		goto err_release;
> +	}
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
> @@ -370,9 +832,34 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *context)
> 
>  	dell_wmi_ddv_debugfs_init(wdev);
> 
> -	return dell_wmi_ddv_battery_add(data);
> +	if (IS_REACHABLE(CONFIG_ACPI_BATTERY)) {
> +		ret = dell_wmi_ddv_battery_add(data);
> +		if (ret < 0 && ret != -ENODEV)
> +			dev_warn(&wdev->dev, "Unable to register ACPI battery hook: %d\n", ret);
> +	}
> +
> +	if (IS_REACHABLE(CONFIG_HWMON)) {
> +		ret = dell_wmi_ddv_hwmon_add(data);
> +		if (ret < 0 && ret != -ENODEV)
> +			dev_warn(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
> +	}
> +
> +	return 0;
>  }
> 
> +static int dell_wmi_ddv_resume(struct device *dev)
> +{
> +	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> +
> +	/* Force re-reading of all sensors */
> +	dell_wmi_ddv_hwmon_cache_invalidate(&data->fans);
> +	dell_wmi_ddv_hwmon_cache_invalidate(&data->temps);
> +
> +	return 0;
> +}
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(dell_wmi_ddv_dev_pm_ops, NULL, dell_wmi_ddv_resume);
> +
>  static const struct wmi_device_id dell_wmi_ddv_id_table[] = {
>  	{ DELL_DDV_GUID, NULL },
>  	{ }
> @@ -382,6 +869,7 @@ MODULE_DEVICE_TABLE(wmi, dell_wmi_ddv_id_table);
>  static struct wmi_driver dell_wmi_ddv_driver = {
>  	.driver = {
>  		.name = DRIVER_NAME,
> +		.pm = pm_sleep_ptr(&dell_wmi_ddv_dev_pm_ops),
>  	},
>  	.id_table = dell_wmi_ddv_id_table,
>  	.probe = dell_wmi_ddv_probe,
> --
> 2.30.2
> 
