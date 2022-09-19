Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E532A5BCAD3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiISLdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:33:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiISLdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:33:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F111DBC80
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663587189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hs7OtkEz723CBwtrhRodpMUNVeglPiq2p7ND7Mb6hMA=;
        b=WKfCvyg15Wh6tJ3qGxbqzYfz1SiGYC8G7eve6nZ7E3A237NlcDZfJrrkBg4tFOOGvKtOzU
        Ie1Bi6vV6STonq/vth65TnW7DEMl0PQ6RTgedxJyonj/OQYLTei0CvNS8TmcfYIsG/i8J2
        hAmX5f/Rxo1A6TcR33UwrwCqIqX0oU4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-651-EqEbQ4B-PMySPG_Me79Vog-1; Mon, 19 Sep 2022 07:33:08 -0400
X-MC-Unique: EqEbQ4B-PMySPG_Me79Vog-1
Received: by mail-ed1-f72.google.com with SMTP id z13-20020a05640240cd00b0045276a79364so12479278edb.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Hs7OtkEz723CBwtrhRodpMUNVeglPiq2p7ND7Mb6hMA=;
        b=dmq70NfLp7wy88a6tCtZ6CxBzlXNvfuXB8rnl9J4TR6tiqkted54z8UMNMt+Q3uTw5
         uCjWsfdCjX/UZFDrVrPrG+TYJT23xbZqc72k7bo3L8ZM44etd1EXIDIdQLc5YQwxbauM
         bcSNqfZhLt5oA3Fu7Amg3bWPH1wj08Kt0oHZKLTK3XcF7lfYl3o9hUZOEIbzKeIKYaeK
         8aXzKpG5V0cZHI3I0zBut52WsBWx19b4iAaSSrvm6jrS/pH3uk7fCIDlNLkl5TQQk7WU
         6DQBia+DepusdNm+r1+c4dA/VY1NXlmz2UoCSVoJSN+d8UB9te/mSm+w9P8qrutkeasv
         /Uiw==
X-Gm-Message-State: ACrzQf1EjTBNkHnXPB+MDkQ/QMOGlxSQwfmDw4nASW/G2hmQYa+Z5A10
        1aCiqMP9X7fIasp0tt7vMQiNo4z1FSF+1+fUZEcw4uj4AYOcY+b5Y082Fy1yBCG5NJ7HUU29bXf
        CxRIFOLYaIBIRzkA/+E2q5QEj
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id nd15-20020a170907628f00b0072f58fc3815mr12559755ejc.719.1663587186066;
        Mon, 19 Sep 2022 04:33:06 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7D6wXCwj8f/YIcTjy87dpoqr9ZfsXK8N8PaqKaPhnIChF/SssvdPMiNNuJKfXgYEAx7+cayA==
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id nd15-20020a170907628f00b0072f58fc3815mr12559738ejc.719.1663587185793;
        Mon, 19 Sep 2022 04:33:05 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id kz25-20020a17090777d900b007812ba2a360sm2972667ejc.149.2022.09.19.04.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 04:33:05 -0700 (PDT)
Message-ID: <c7d8c851-c046-ae59-4345-e8e308d4fb19@redhat.com>
Date:   Mon, 19 Sep 2022 12:33:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 5/5] platform/x86: dell: Add new dell-wmi-ddv driver
Content-Language: en-US
To:     Armin Wolf <W_Armin@gmx.de>, markgross@kernel.org
Cc:     rafael@kernel.org, lenb@kernel.org, hmh@hmh.eng.br,
        matan@svgalib.org, corentin.chary@gmail.com, jeremy@system76.com,
        productdev@system76.com, platform-driver-x86@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220912125342.7395-1-W_Armin@gmx.de>
 <20220912125342.7395-6-W_Armin@gmx.de>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20220912125342.7395-6-W_Armin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/12/22 13:53, Armin Wolf wrote:
> The dell-wmi-ddv driver adds support for reading
> the current temperature and ePPID of ACPI batteries
> on supported Dell machines.
> 
> Since the WMI interface used by this driver does not
> do any input validation and thus cannot be used for probing,
> the driver depends on the ACPI battery extension machanism
> to discover batteries.
> 
> The driver also supports a debugfs interface for retrieving
> buffers containing fan and thermal sensor information.
> Since the meaing of the content of those buffers is currently
> unknown, the interface is meant for reverse-engineering and
> will likely be replaced with an hwmon interface once the
> meaning has been understood.
> 
> The driver was tested on a Dell Inspiron 3505.
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  .../ABI/testing/debugfs-dell-wmi-ddv          |  21 +
>  .../ABI/testing/sysfs-platform-dell-wmi-ddv   |  16 +
>  MAINTAINERS                                   |   7 +
>  drivers/platform/x86/dell/Kconfig             |  13 +
>  drivers/platform/x86/dell/Makefile            |   1 +
>  drivers/platform/x86/dell/dell-wmi-ddv.c      | 365 ++++++++++++++++++
>  drivers/platform/x86/wmi.c                    |   1 +
>  7 files changed, 424 insertions(+)
>  create mode 100644 Documentation/ABI/testing/debugfs-dell-wmi-ddv
>  create mode 100644 Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
>  create mode 100644 drivers/platform/x86/dell/dell-wmi-ddv.c
> 
> diff --git a/Documentation/ABI/testing/debugfs-dell-wmi-ddv b/Documentation/ABI/testing/debugfs-dell-wmi-ddv
> new file mode 100644
> index 000000000000..fbcc5d6f7388
> --- /dev/null
> +++ b/Documentation/ABI/testing/debugfs-dell-wmi-ddv
> @@ -0,0 +1,21 @@
> +What:		/sys/kernel/debug/dell-wmi-ddv-<wmi_device_name>/fan_sensor_information
> +Date:		September 2022
> +KernelVersion:	6.1
> +Contact:	Armin Wolf <W_Armin@gmx.de>
> +Description:
> +		This file contains the contents of the fan sensor information buffer,
> +		which contains fan sensor entries and a terminating character (0xFF).
> +
> +		Each fan sensor entry consists of three bytes with an unknown meaning,
> +		interested people may use this file for reverse-engineering.
> +
> +What:		/sys/kernel/debug/dell-wmi-ddv-<wmi_device_name>/thermal_sensor_information
> +Date:		September 2022
> +KernelVersion:	6.1
> +Contact:	Armin Wolf <W_Armin@gmx.de>
> +Description:
> +		This file contains the contents of the thermal sensor information buffer,
> +		which contains thermal sensor entries and a terminating character (0xFF).
> +
> +		Each thermal sensor entry consists of five bytes with an unknown meaning,
> +		interested people may use this file for reverse-engineering.
> diff --git a/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv b/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
> new file mode 100644
> index 000000000000..98e0b8399d13
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
> @@ -0,0 +1,16 @@
> +What:		/sys/class/power_supply/<battery_name>/temp
> +Date:		September 2022
> +KernelVersion:	6.1
> +Contact:	Armin Wolf <W_Armin@gmx.de>
> +Description:
> +		Reports the current ACPI battery temperature on supported Dell machines.
> +
> +		Values are represented in 1/10 Degrees Celsius.

This is a standard power_supply class attribute which is already documented in:
Documentation/ABI/testing/sysfs-class-power

so no need to document this here, please drop it.

Other then that this patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> +
> +What:		/sys/class/power_supply/<battery_name>/eppid
> +Date:		September 2022
> +KernelVersion:	6.1
> +Contact:	Armin Wolf <W_Armin@gmx.de>
> +Description:
> +		Reports the Dell ePPID (electronic Dell Piece Part Identification)
> +		of the ACPI battery.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6bb894ea4a77..d9fd4c9eebbc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5821,6 +5821,13 @@ L:	Dell.Client.Kernel@dell.com
>  S:	Maintained
>  F:	drivers/platform/x86/dell/dell-wmi-descriptor.c
> 
> +DELL WMI DDV DRIVER
> +M:	Armin Wolf <W_Armin@gmx.de>
> +S:	Maintained
> +F:	Documentation/ABI/testing/debugfs-dell-wmi-ddv
> +F:	Documentation/ABI/testing/sysfs-platform-dell-wmi-ddv
> +F:	drivers/platform/x86/dell/dell-wmi-ddv.c
> +
>  DELL WMI SYSMAN DRIVER
>  M:	Divya Bharathi <divya.bharathi@dell.com>
>  M:	Prasanth Ksr <prasanth.ksr@dell.com>
> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
> index 25421e061c47..209e63e347e2 100644
> --- a/drivers/platform/x86/dell/Kconfig
> +++ b/drivers/platform/x86/dell/Kconfig
> @@ -189,6 +189,19 @@ config DELL_WMI_DESCRIPTOR
>  	default n
>  	depends on ACPI_WMI
> 
> +config DELL_WMI_DDV
> +	tristate "Dell WMI sensors Support"
> +	default m
> +	depends on ACPI_BATTERY
> +	depends on ACPI_WMI
> +	help
> +	  This option adds support for WMI-based sensors like
> +	  battery temperature sensors found on some Dell notebooks.
> +	  It also supports reading of the batteries ePPID.
> +
> +	  To compile this drivers as a module, choose M here: the module will
> +	  be called dell-wmi-ddv.
> +
>  config DELL_WMI_LED
>  	tristate "External LED on Dell Business Netbooks"
>  	default m
> diff --git a/drivers/platform/x86/dell/Makefile b/drivers/platform/x86/dell/Makefile
> index ddba1df71e80..1b8942426622 100644
> --- a/drivers/platform/x86/dell/Makefile
> +++ b/drivers/platform/x86/dell/Makefile
> @@ -19,5 +19,6 @@ dell-wmi-objs				:= dell-wmi-base.o
>  dell-wmi-$(CONFIG_DELL_WMI_PRIVACY)	+= dell-wmi-privacy.o
>  obj-$(CONFIG_DELL_WMI_AIO)		+= dell-wmi-aio.o
>  obj-$(CONFIG_DELL_WMI_DESCRIPTOR)	+= dell-wmi-descriptor.o
> +obj-$(CONFIG_DELL_WMI_DDV)		+= dell-wmi-ddv.o
>  obj-$(CONFIG_DELL_WMI_LED)		+= dell-wmi-led.o
>  obj-$(CONFIG_DELL_WMI_SYSMAN)		+= dell-wmi-sysman/
> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
> new file mode 100644
> index 000000000000..6eef298f13eb
> --- /dev/null
> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
> @@ -0,0 +1,365 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * dell-wmi-ddv.c -- Linux driver for WMI sensor information on Dell notebooks.
> + *
> + * Copyright (C) 2022 Armin Wolf <W_Armin@gmx.de>
> + */
> +
> +#define pr_format(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <acpi/battery.h>
> +#include <linux/acpi.h>
> +#include <linux/debugfs.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/kstrtox.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/limits.h>
> +#include <linux/power_supply.h>
> +#include <linux/seq_file.h>
> +#include <linux/sysfs.h>
> +#include <linux/wmi.h>
> +
> +#define DRIVER_NAME	"dell-wmi-ddv"
> +
> +#define DELL_DDV_SUPPORTED_INTERFACE 2
> +#define DELL_DDV_GUID	"8A42EA14-4F2A-FD45-6422-0087F7A7E608"
> +
> +enum dell_ddv_method {
> +	DELL_DDV_BATTERY_DESIGN_CAPACITY	= 0x01,
> +	DELL_DDV_BATTERY_FULL_CHARGE_CAPACITY	= 0x02,
> +	DELL_DDV_BATTERY_MANUFACTURE_NAME	= 0x03,
> +	DELL_DDV_BATTERY_MANUFACTURE_DATE	= 0x04,
> +	DELL_DDV_BATTERY_SERIAL_NUMBER		= 0x05,
> +	DELL_DDV_BATTERY_CHEMISTRY_VALUE	= 0x06,
> +	DELL_DDV_BATTERY_TEMPERATURE		= 0x07,
> +	DELL_DDV_BATTERY_CURRENT		= 0x08,
> +	DELL_DDV_BATTERY_VOLTAGE		= 0x09,
> +	DELL_DDV_BATTERY_MANUFACTURER_ACCESS	= 0x0A,
> +	DELL_DDV_BATTERY_RELATIVE_CHARGE_STATE	= 0x0B,
> +	DELL_DDV_BATTERY_CYCLE_COUNT		= 0x0C,
> +	DELL_DDV_BATTERY_EPPID			= 0x0D,
> +	DELL_DDV_BATTERY_RAW_ANALYTICS_START	= 0x0E,
> +	DELL_DDV_BATTERY_RAW_ANALYTICS		= 0x0F,
> +	DELL_DDV_BATTERY_DESIGN_VOLTAGE		= 0x10,
> +
> +	DELL_DDV_INTERFACE_VERSION		= 0x12,
> +
> +	DELL_DDV_FAN_SENSOR_INFORMATION		= 0x20,
> +	DELL_DDV_THERMAL_SENSOR_INFORMATION	= 0x22,
> +};
> +
> +struct dell_wmi_ddv_data {
> +	struct device_attribute temp_attr, eppid_attr;
> +	struct wmi_device *wdev;
> +};
> +
> +static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv_method method, u32 arg,
> +				   union acpi_object **result, acpi_object_type type)
> +{
> +	struct acpi_buffer out = { ACPI_ALLOCATE_BUFFER, NULL };
> +	const struct acpi_buffer in = {
> +		.length = sizeof(arg),
> +		.pointer = &arg,
> +	};
> +	union acpi_object *obj;
> +	acpi_status ret;
> +
> +	ret = wmidev_evaluate_method(wdev, 0x0, method, &in, &out);
> +	if (ACPI_FAILURE(ret))
> +		return -EIO;
> +
> +	obj = out.pointer;
> +	if (!obj)
> +		return -ENODATA;
> +
> +	if (obj->type != type) {
> +		kfree(obj);
> +		return -EIO;
> +	}
> +
> +	*result = obj;
> +
> +	return 0;
> +}
> +
> +static int dell_wmi_ddv_query_integer(struct wmi_device *wdev, enum dell_ddv_method method,
> +				      u32 arg, u32 *res)
> +{
> +	union acpi_object *obj;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_type(wdev, method, arg, &obj, ACPI_TYPE_INTEGER);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (obj->integer.value <= U32_MAX)
> +		*res = (u32)obj->integer.value;
> +	else
> +		ret = -ERANGE;
> +
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_ddv_query_buffer(struct wmi_device *wdev, enum dell_ddv_method method,
> +				     u32 arg, union acpi_object **result)
> +{
> +	union acpi_object *obj;
> +	u64 buffer_size;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_type(wdev, method, arg, &obj, ACPI_TYPE_PACKAGE);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (obj->package.count != 2)
> +		goto err_free;
> +
> +	if (obj->package.elements[0].type != ACPI_TYPE_INTEGER)
> +		goto err_free;
> +
> +	buffer_size = obj->package.elements[0].integer.value;
> +
> +	if (obj->package.elements[1].type != ACPI_TYPE_BUFFER)
> +		goto err_free;
> +
> +	if (buffer_size != obj->package.elements[1].buffer.length) {
> +		dev_warn(&wdev->dev,
> +			 FW_WARN "ACPI buffer size (%llu) does not match WMI buffer size (%d)\n",
> +			 buffer_size, obj->package.elements[1].buffer.length);
> +
> +		goto err_free;
> +	}
> +
> +	*result = obj;
> +
> +	return 0;
> +
> +err_free:
> +	kfree(obj);
> +
> +	return -EIO;
> +}
> +
> +static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_ddv_method method,
> +				     u32 arg, union acpi_object **result)
> +{
> +	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRING);
> +}
> +
> +static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *index)
> +{
> +	const char *uid_str = acpi_device_uid(acpi_dev);
> +
> +	if (!uid_str)
> +		return -ENODEV;
> +
> +	return kstrtou32(uid_str, 10, index);
> +}
> +
> +static ssize_t temp_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dell_wmi_ddv_data *data = container_of(attr, struct dell_wmi_ddv_data, temp_attr);
> +	u32 index, value;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_battery_index(to_acpi_device(dev->parent), &index);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = dell_wmi_ddv_query_integer(data->wdev, DELL_DDV_BATTERY_TEMPERATURE, index, &value);
> +	if (ret < 0)
> +		return ret;
> +
> +	return sysfs_emit(buf, "%d\n", DIV_ROUND_CLOSEST(value, 10));
> +}
> +
> +static ssize_t eppid_show(struct device *dev, struct device_attribute *attr, char *buf)
> +{
> +	struct dell_wmi_ddv_data *data = container_of(attr, struct dell_wmi_ddv_data, eppid_attr);
> +	union acpi_object *obj;
> +	u32 index;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_battery_index(to_acpi_device(dev->parent), &index);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = dell_wmi_ddv_query_string(data->wdev, DELL_DDV_BATTERY_EPPID, index, &obj);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = sysfs_emit(buf, "%s\n", obj->string.pointer);
> +
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_ddv_add_battery(void *drvdata, struct power_supply *battery)
> +{
> +	struct dell_wmi_ddv_data *data = drvdata;
> +	u32 index;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_battery_index(to_acpi_device(battery->dev.parent), &index);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = device_create_file(&battery->dev, &data->temp_attr);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = device_create_file(&battery->dev, &data->eppid_attr);
> +	if (ret < 0) {
> +		device_remove_file(&battery->dev, &data->temp_attr);
> +
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int dell_wmi_ddv_remove_battery(void *drvdata, struct power_supply *battery)
> +{
> +	struct dell_wmi_ddv_data *data = drvdata;
> +
> +	device_remove_file(&battery->dev, &data->temp_attr);
> +	device_remove_file(&battery->dev, &data->eppid_attr);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_battery_hook_ops dell_wmi_ddv_battery_hook_ops = {
> +	.add_battery = dell_wmi_ddv_add_battery,
> +	.remove_battery = dell_wmi_ddv_remove_battery,
> +};
> +
> +static void dell_wmi_ddv_battery_remove(void *data)
> +{
> +	struct acpi_battery_hook *hook = data;
> +
> +	battery_hook_unregister(hook);
> +}
> +
> +static int dell_wmi_ddv_battery_add(struct dell_wmi_ddv_data *data)
> +{
> +	struct acpi_battery_hook *hook;
> +
> +	sysfs_attr_init(&data->temp_attr.attr);
> +	data->temp_attr.attr.name = "temp";
> +	data->temp_attr.attr.mode = 0444;
> +	data->temp_attr.show = temp_show;
> +
> +	sysfs_attr_init(&data->eppid_attr.attr);
> +	data->eppid_attr.attr.name = "eppid";
> +	data->eppid_attr.attr.mode = 0444;
> +	data->eppid_attr.show = eppid_show;
> +
> +	hook = battery_hook_register("DELL Battery Extension", data,
> +				     &dell_wmi_ddv_battery_hook_ops);
> +	if (IS_ERR(hook))
> +		return PTR_ERR(hook);
> +
> +	return devm_add_action_or_reset(&data->wdev->dev, dell_wmi_ddv_battery_remove, hook);
> +}
> +
> +static int dell_wmi_ddv_buffer_read(struct seq_file *seq, enum dell_ddv_method method)
> +{
> +	struct device *dev = seq->private;
> +	struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
> +	union acpi_object *obj;
> +	union acpi_object buf;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_buffer(data->wdev, method, 0, &obj);
> +	if (ret < 0)
> +		return ret;
> +
> +	buf = obj->package.elements[1];
> +	ret = seq_write(seq, buf.buffer.pointer, buf.buffer.length);
> +	kfree(obj);
> +
> +	return ret;
> +}
> +
> +static int dell_wmi_ddv_fan_read(struct seq_file *seq, void *offset)
> +{
> +	return dell_wmi_ddv_buffer_read(seq, DELL_DDV_FAN_SENSOR_INFORMATION);
> +}
> +
> +static int dell_wmi_ddv_temp_read(struct seq_file *seq, void *offset)
> +{
> +	return dell_wmi_ddv_buffer_read(seq, DELL_DDV_THERMAL_SENSOR_INFORMATION);
> +}
> +
> +static void dell_wmi_ddv_debugfs_remove(void *data)
> +{
> +	struct dentry *entry = data;
> +
> +	debugfs_remove(entry);
> +}
> +
> +static void dell_wmi_ddv_debugfs_init(struct wmi_device *wdev)
> +{
> +	struct dentry *entry;
> +	char name[64];
> +
> +	scnprintf(name, ARRAY_SIZE(name), "%s-%s", DRIVER_NAME, dev_name(&wdev->dev));
> +	entry = debugfs_create_dir(name, NULL);
> +
> +	debugfs_create_devm_seqfile(&wdev->dev, "fan_sensor_information", entry,
> +				    dell_wmi_ddv_fan_read);
> +	debugfs_create_devm_seqfile(&wdev->dev, "thermal_sensor_information", entry,
> +				    dell_wmi_ddv_temp_read);
> +
> +	devm_add_action_or_reset(&wdev->dev, dell_wmi_ddv_debugfs_remove, entry);
> +}
> +
> +static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *context)
> +{
> +	struct dell_wmi_ddv_data *data;
> +	u32 version;
> +	int ret;
> +
> +	ret = dell_wmi_ddv_query_integer(wdev, DELL_DDV_INTERFACE_VERSION, 0, &version);
> +	if (ret < 0)
> +		return ret;
> +
> +	dev_dbg(&wdev->dev, "WMI interface version: %d\n", version);
> +	if (version != DELL_DDV_SUPPORTED_INTERFACE)
> +		return -ENODEV;
> +
> +	data = devm_kzalloc(&wdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(&wdev->dev, data);
> +	data->wdev = wdev;
> +
> +	dell_wmi_ddv_debugfs_init(wdev);
> +
> +	return dell_wmi_ddv_battery_add(data);
> +}
> +
> +static const struct wmi_device_id dell_wmi_ddv_id_table[] = {
> +	{ DELL_DDV_GUID, NULL },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(wmi, dell_wmi_ddv_id_table);
> +
> +static struct wmi_driver dell_wmi_ddv_driver = {
> +	.driver = {
> +		.name = DRIVER_NAME,
> +	},
> +	.id_table = dell_wmi_ddv_id_table,
> +	.probe = dell_wmi_ddv_probe,
> +};
> +module_wmi_driver(dell_wmi_ddv_driver);
> +
> +MODULE_AUTHOR("Armin Wolf <W_Armin@gmx.de>");
> +MODULE_DESCRIPTION("Dell WMI sensor driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
> index aff23309b5d3..f307d8c5c6c3 100644
> --- a/drivers/platform/x86/wmi.c
> +++ b/drivers/platform/x86/wmi.c
> @@ -108,6 +108,7 @@ MODULE_DEVICE_TABLE(acpi, wmi_device_ids);
>  /* allow duplicate GUIDs as these device drivers use struct wmi_driver */
>  static const char * const allow_duplicates[] = {
>  	"05901221-D566-11D1-B2F0-00A0C9062910",	/* wmi-bmof */
> +	"8A42EA14-4F2A-FD45-6422-0087F7A7E608",	/* dell-wmi-ddv */
>  	NULL
>  };
> 
> --
> 2.30.2
> 

