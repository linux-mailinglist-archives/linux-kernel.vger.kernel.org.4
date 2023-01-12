Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB5667EF1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 20:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjALTVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 14:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240376AbjALTUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 14:20:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD39ABC2E
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673550515;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9VSyjKCT0gvrfoXydUZBcYmclRp2Xgk9TQtj2d5vMlM=;
        b=Fhlb4qL4b2o9vhKrgv4rnQq3bPNEujxmuiYlwI5NRngP4aTvIHMgTBMtwEQF+PEpZE8TGt
        KVf58LDCiuRFNt8zeXOD9b8LzXQbL8rJ+eTbWRUjlOZxnZsZTGRM4jFvoFgXHoqq6VtjtS
        2IcjzDdCnkfWoSkG4Gaev4ZcFbv7L5M=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-604-qicrkcbGOaGBhwC-Nl947g-1; Thu, 12 Jan 2023 14:08:34 -0500
X-MC-Unique: qicrkcbGOaGBhwC-Nl947g-1
Received: by mail-ej1-f72.google.com with SMTP id oz11-20020a1709077d8b00b007c0dd8018b6so13385534ejc.17
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 11:08:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9VSyjKCT0gvrfoXydUZBcYmclRp2Xgk9TQtj2d5vMlM=;
        b=LBYrZTnl2J6fvqWW/87254Qtl98CewL8apLfqJz1RlHxZ9Vy3E011glQEZKfxMygti
         UxvNG0ICkA5jeY2isVXOBqXQuxQoQcY/0W4b3XEriv7BQ2nVt0vxeuIpvieK2miH4egA
         b+WM9V54HTQZ+VAR75yi2GxtIctDVcwhhs/cGKtxgurQbU+ZAZeA1sbsEaDta+OkAijh
         U9Zu67ok+yF2g1sveukl3vZuvuA0AWZOOToMgtmWT9Uc8bOXFswlnbM3rSg8Ch29fv2p
         SdumrpDZbaALmpFixKGrxay/RM7Y+SU4yRc/H+zbB2xa6mgIv/dkgsp1w1szYv/liWQ3
         RFxg==
X-Gm-Message-State: AFqh2kpDytDwdwoZfSmJTkSYsSWObLJpJ3mK73pdaStF7tqCW/96m0Cn
        sR6JxkmOAlbORhZfXzVWE+vvD6P4H4n9OWfhC5RSHJzN4UYtoPTgzEyZv0ewSkrcIC5AqpYPC+x
        zR0BeAsp5/6bFpluLLNea3X7d
X-Received: by 2002:aa7:cb42:0:b0:496:f517:d30d with SMTP id w2-20020aa7cb42000000b00496f517d30dmr21502444edt.38.1673550513164;
        Thu, 12 Jan 2023 11:08:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsN4Np1xfG8C7aefH6y49d3b+jh2EyVK9sjNJ9AAIJtUlCoYtZoGyFYwOrejE0EjWiWm2+3nw==
X-Received: by 2002:aa7:cb42:0:b0:496:f517:d30d with SMTP id w2-20020aa7cb42000000b00496f517d30dmr21502437edt.38.1673550512954;
        Thu, 12 Jan 2023 11:08:32 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bc25-20020a056402205900b0046b00a9eeb5sm7484089edb.49.2023.01.12.11.08.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 11:08:32 -0800 (PST)
Message-ID: <6863830a-6722-22ff-ff72-f765453d5ba9@redhat.com>
Date:   Thu, 12 Jan 2023 20:08:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC] platform/x86: dell-ddv: Add hwmon support
Content-Language: en-US, nl
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230110221443.8184-1-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230110221443.8184-1-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Armin,

On 1/10/23 23:14, Armin Wolf wrote:
> Thanks to a bugreport on bugzilla triggered by the
> dell-smm-hwmon driver, the contents of the sensor buffers
> could be partially decoded.
> Add an hwmon interface for exposing the fan and thermal
> sensor values. The debugfs interface remains in place to
> aid in reverse-engineering the thermal buffer.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
> This patch is in the process of being tested by multiple people
> on multiple Dell notebooks, and AFAIK the drivers seems to do its
> job well.
> I want to ask for comments regarding how the hwmon support code
> interfaces with the main driver. The hwmon and battery hook support
> code are expected to grow significantly once more people use this
> driver and are reporting bugs and reverse-engineering findings.
> Since both the hwmon and battery support code is quiet independent
> from each other, i was thinking about modularizing the driver by either:
> - spliting the driver into multiple source files which are being linked
>   together
> - spliting the driver into separate subdevice drivers using the MFD or
>   auxiliary bus infrastructure
> 
> When is it justified to modularize a driver?
> And if yes which option should be used to facilitate this?


I'm currently catching up with quite a big patch/bug backlog after
being on holiday for 2 weeks. I'll get back to you on this, but please
give me some time :)

If you have not heard back from me in 2 weeks, feel free
to ping me about this.

Regards,

Hans



> 
> Armin Wolf
> ---
>  drivers/platform/x86/dell/Kconfig        |   1 +
>  drivers/platform/x86/dell/dell-wmi-ddv.c | 374 ++++++++++++++++++++++-
>  2 files changed, 374 insertions(+), 1 deletion(-)
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
> index f99c4cb686fd..b79ff8621aea 100644
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
> @@ -59,13 +63,45 @@ enum dell_ddv_method {
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
>  struct dell_wmi_ddv_data {
>  	struct acpi_battery_hook hook;
>  	struct device_attribute temp_attr;
>  	struct device_attribute eppid_attr;
> +	struct hwmon_chip_info chip_info;
>  	struct wmi_device *wdev;
>  };
> 
> +static const char * const fan_labels[] = {
> +	"Processor Fan",
> +	"Motherboard Fan",
> +	"Video Fan",
> +	"Power Supply Fan",
> +	"Chipset Fan",
> +	"Other Fan",
> +};
> +
> +static const char * const fan_dock_labels[] = {
> +	"Docking Processor Fan",
> +	"Docking Motherboard Fan",
> +	"Docking Video Fan",
> +	"Docking Power Supply Fan",
> +	"Docking Chipset Fan",
> +	"Docking Other Fan",
> +};
> +
>  static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv_method method, u32 arg,
>  				   union acpi_object **result, acpi_object_type type)
>  {
> @@ -167,6 +203,334 @@ static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_ddv_meth
>  	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRING);
>  }
> 
> +static int dell_wmi_ddv_query_sensors(struct wmi_device *wdev, enum dell_ddv_method method,
> +				      size_t entry_size, union acpi_object **result)
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
> +	*result = obj;
> +
> +	return 0;
> +}
> +
> +static u64 dell_wmi_ddv_sensor_count(union acpi_object *obj, size_t entry_size)
> +{
> +	return (obj->package.elements[0].integer.value - 1) / entry_size;
> +}
> +
> +static void *dell_wmi_ddv_get_sensor_entry(union acpi_object *obj, int index, size_t entry_size)
> +{
> +	if (index >= dell_wmi_ddv_sensor_count(obj, entry_size))
> +		return ERR_PTR(-EINVAL);
> +
> +	return &obj->package.elements[1].buffer.pointer[index * entry_size];
> +}
> +
> +static umode_t dell_wmi_ddv_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
> +				       int channel)
> +{
> +	return 0444;
> +}
> +
> +static int dell_wmi_ddv_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +			     int channel, long *val)
> +{
> +	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> +	struct thermal_sensor_entry *thermal_entry;
> +	struct fan_sensor_entry *fan_entry;
> +	union acpi_object *obj;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
> +						 sizeof(*thermal_entry), &obj);
> +		if (ret < 0)
> +			return ret;
> +
> +		thermal_entry = dell_wmi_ddv_get_sensor_entry(obj, channel, sizeof(*thermal_entry));
> +		if (!IS_ERR(thermal_entry)) {
> +			switch (attr) {
> +			case hwmon_temp_input:
> +				*val = thermal_entry->now * 1000;
> +
> +				break;
> +			case hwmon_temp_min:
> +				*val = thermal_entry->min * 1000;
> +
> +				break;
> +			case hwmon_temp_max:
> +				*val = thermal_entry->max * 1000;
> +
> +				break;
> +			default:
> +				ret = -EOPNOTSUPP;
> +
> +				break;
> +			}
> +		} else {
> +			ret = PTR_ERR(thermal_entry);
> +		}
> +
> +		kfree(obj);
> +
> +		return ret;
> +	case hwmon_fan:
> +		ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
> +						 sizeof(*fan_entry), &obj);
> +		if (ret < 0)
> +			return ret;
> +
> +		fan_entry = dell_wmi_ddv_get_sensor_entry(obj, channel, sizeof(*fan_entry));
> +		if (!IS_ERR(fan_entry)) {
> +			switch (attr) {
> +			case hwmon_fan_input:
> +				*val = get_unaligned_le16(&fan_entry->rpm);
> +
> +				break;
> +			default:
> +				ret = -EOPNOTSUPP;
> +
> +				break;
> +			}
> +		} else {
> +			ret = PTR_ERR(fan_entry);
> +		}
> +
> +		kfree(obj);
> +
> +		return ret;
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
> +static const char *dell_wmi_ddv_fan_label(u8 type)
> +{
> +	if (type & BIT(4))
> +		return fan_dock_labels[clamp_val(type & 0x0f, 0, ARRAY_SIZE(fan_dock_labels) - 1)];
> +
> +	return fan_labels[clamp_val(type & 0x0f, 0, ARRAY_SIZE(fan_labels) - 1)];
> +}
> +
> +static int dell_wmi_ddv_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
> +				    int channel, const char **str)
> +{
> +	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> +	struct thermal_sensor_entry *thermal_entry;
> +	struct fan_sensor_entry *fan_entry;
> +	union acpi_object *obj;
> +	int ret;
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
> +						 sizeof(*fan_entry), &obj);
> +		if (ret < 0)
> +			return ret;
> +
> +		fan_entry = dell_wmi_ddv_get_sensor_entry(obj, channel, sizeof(*fan_entry));
> +		if (!IS_ERR(fan_entry)) {
> +			switch (attr) {
> +			case hwmon_fan_label:
> +				*str = dell_wmi_ddv_fan_label(fan_entry->type);
> +
> +				break;
> +			default:
> +				ret = -EOPNOTSUPP;
> +
> +				break;
> +			}
> +		} else {
> +			ret = PTR_ERR(fan_entry);
> +		}
> +
> +		kfree(obj);
> +
> +		return ret;
> +	case hwmon_temp:
> +		ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
> +						 sizeof(*thermal_entry), &obj);
> +		if (ret < 0)
> +			return ret;
> +
> +		thermal_entry = dell_wmi_ddv_get_sensor_entry(obj, channel, sizeof(*thermal_entry));
> +		if (!IS_ERR(thermal_entry)) {
> +			switch (attr) {
> +			case hwmon_temp_label:
> +				switch (thermal_entry->type) {
> +				case 0x00:
> +					*str = "CPU";
> +
> +					break;
> +				case 0x11:
> +					*str = "Video";
> +
> +					break;
> +				case 0x22:
> +					*str = "Memory";
> +
> +					break;
> +				case 0x33:
> +					*str = "Other";
> +
> +					break;
> +				case 0x44:
> +					*str = "Ambient"; // sometimes called SKIN
> +
> +					break;
> +				case 0x73:
> +					*str = "NB";
> +
> +					break;
> +				default:
> +					ret = -ENXIO;
> +				}
> +
> +				break;
> +			default:
> +				ret = -EOPNOTSUPP;
> +
> +				break;
> +			}
> +		} else {
> +			ret = PTR_ERR(thermal_entry);
> +		}
> +
> +		kfree(obj);
> +
> +		return ret;
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
> +static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *wdev,
> +							    enum dell_ddv_method method,
> +							    size_t entry_size,
> +							    enum hwmon_sensor_types type,
> +							    u32 config)
> +{
> +	struct hwmon_channel_info *info;
> +	union acpi_object *obj;
> +	u32 *channel_config;
> +	int i, ret;
> +	u64 count;
> +
> +	ret = dell_wmi_ddv_query_sensors(wdev, method, entry_size, &obj);
> +	if (ret < 0)
> +		return ERR_PTR(ret);
> +
> +	count = dell_wmi_ddv_sensor_count(obj, entry_size);
> +	kfree(obj);
> +	if (!count)
> +		return ERR_PTR(-ENODEV);
> +
> +	info = devm_kzalloc(&wdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return ERR_PTR(-ENOMEM);
> +
> +	info->type = type;
> +	channel_config = devm_kcalloc(&wdev->dev, count + 1, sizeof(*channel_config), GFP_KERNEL);
> +	if (!channel_config) {
> +		devm_kfree(&wdev->dev, info);
> +
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	for (i = 0; i < count; i++)
> +		channel_config[i] = config;
> +
> +	info->config = channel_config;
> +
> +	return info;
> +}
> +
> +static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
> +{
> +	const struct hwmon_channel_info **info;
> +	struct wmi_device *wdev = data->wdev;
> +	struct device *hdev;
> +	int index = 0;
> +	int ret;
> +
> +	if (!devres_open_group(&wdev->dev, dell_wmi_ddv_hwmon_add, GFP_KERNEL))
> +		return -ENOMEM;
> +
> +	info = devm_kcalloc(&wdev->dev, 3, sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		ret = -ENOMEM;
> +
> +		goto err_release;
> +	}
> +
> +	info[index] = dell_wmi_ddv_channel_init(wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
> +						sizeof(struct fan_sensor_entry), hwmon_fan,
> +						(HWMON_F_INPUT | HWMON_F_LABEL));
> +	if (!IS_ERR(info[index]))
> +		index++;
> +
> +	info[index] = dell_wmi_ddv_channel_init(wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
> +						sizeof(struct thermal_sensor_entry), hwmon_temp,
> +						(HWMON_T_INPUT | HWMON_T_MIN | HWMON_T_MAX |
> +						HWMON_T_LABEL));
> +	if (!IS_ERR(info[index]))
> +		index++;
> +
> +	if (!index) {
> +		ret = -ENODEV;
> +
> +		goto err_release;
> +	}
> +
> +	info[index] = NULL;
> +
> +	data->chip_info.ops = &dell_wmi_ddv_ops;
> +	data->chip_info.info = info;
> +
> +	hdev = devm_hwmon_device_register_with_info(&wdev->dev, "dell_ddv", data, &data->chip_info,
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
> @@ -361,7 +725,15 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *context)
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
> +	return 0;
>  }
> 
>  static const struct wmi_device_id dell_wmi_ddv_id_table[] = {
> --
> 2.30.2
> 

