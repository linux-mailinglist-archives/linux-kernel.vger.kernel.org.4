Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F00667EA73
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 17:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjA0QKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 11:10:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbjA0QKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 11:10:05 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CE04693;
        Fri, 27 Jan 2023 08:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674835779; bh=uyJveMpk82TKaHROMhT7xvss9MAzN1r7FsM0w1Bf8mE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=heW4ql425iaJFOmu/N9myFWQGJAntMwyZywbcfFahPJCk4ang0/VDoJWHKLyUvT0M
         LHEgDOR0vDKLGpFWWOCP9tWN1HeXsIp97vhG/X6bxFa6y8sdkj5lPxvL5o477e3it3
         7scuLbKHXGe95tmZsqW/R3b2CgacOyLuWaKtbL+7N1zMpd9hdJzPOVnXOnCDVNYHY6
         t4y3iY5jUPKpOmSlNe//EfM230pivEIXa+1uSObsz2eTcbTblvOw6KyScQJCQNB7MG
         e90v3fA34zlzGHYcm8A0EYSFuj7iWIdVAyZxe/ufoufJuRMiD1Sbu3FrwmA32xuKJs
         x2Jl7EPMkYVlA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1pJUxY0zk7-008eT8; Fri, 27
 Jan 2023 17:09:39 +0100
Subject: Re: [PATCH 5/5] platform/x86: dell-ddv: Add hwmon support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     hdegoede@redhat.com, markgross@kernel.org, jdelvare@suse.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126194021.381092-1-W_Armin@gmx.de>
 <20230126194021.381092-6-W_Armin@gmx.de>
 <20230127130815.GA3911997@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <d425820d-f0ce-4349-1b99-1b3d78ac2495@gmx.de>
Date:   Fri, 27 Jan 2023 17:09:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20230127130815.GA3911997@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:cai3jXRiNmL65R1Nb2rCVvc+Xj/5oQOk6y5fJRm5TPqghk7Y44N
 SkFKY33oV8DSGOthvvjfUXQ6apgpgt7CmIg5SfwPEqcK9uA0ztYCn3hTrF+JFn33J62cm1+
 5+b8gYgwdTZ8LoHPvIM6kCFi+rNkjLmOdr+otLvXk+zeK6xB22R4Hxl/FHb2oWIo2FLg2rN
 BI2WXnBBD6b4OijoCkBiA==
UI-OutboundReport: notjunk:1;M01:P0:hdgl9dZMBSI=;9PLT8yWE/JqSuZUlqjaaApzkN86
 6F7T+rq11MyG7yJ2/5Mkk2qnqaNNcvwPaXkbyE2XyOMkKuI6lQ4sdcj7EZqpgSRwoNTy0/nG0
 Hqj15unwSoDiD9QVIaYyraeUoqQ2FppPqJAKLA5DiFRvPQAYK9JL7aCkpDj9K8JPm52p76WO9
 Z4XJk7K34SeIz9enya0DtCX1SRzIgkdeku8HWFWj3hozEOg8eO9dkths3lIWXJ2PMJGczWa1k
 79qc19Rh2pMnHjDvPb4GQsQ42ROPQwT3XJTtW+bxu0VqtaQguhXXG0K4YCBP7iokmFm4G4Lzq
 F4Ugf1x/AGrrx0HMaMJX0mL5r2FcEoQKHavQOmGSQgwyo40AhlsjBtvTJkMqgcWGF6FfYP0za
 uIJ+hvK6ugd+U7/WmHm2Xfl+12TzHbBdwtWx4t3d3bHmPIzcIfaaQvDTD0RUa0exw9dEhf2yF
 v5/H/RN+hF3swbbl6WKExmH71OJ/cRHK6Sxe2+xpgZxJD5YGPDnN3NxAVLHaQPbZ/ElLSubxk
 GA7eJKkxAaDGkqtCYfiqb1qudzc6e2crkLOw6/WS1TPe+mSJUWLdrOsJkpsm1TruN4x/YTFs7
 a2c/zB/NhOOZqBZkHxjaZ17B8J+ZoO/fKrTVo+fhVB26ZvJwSY7o5OaVdGrsum9CdJAkizWAZ
 8V06ecXO/qv37G2hMV09Xc2QojZf5P/GYeeLxl0vkNgYKdP79jc9dwJzWtbSSFHOX2P+cj+xB
 DV+ymchMEA8JNPQRmqGN/TlUl44aa9js85v9iK5f9wPOnCG1YfvfGZTX3K50oD/SFnjKHiQOM
 Q1ZnE+Vy/Y8ni1dJJRC3WaO5Ox2R+dMtImEO5TBdPP+1Lcu2hXrkhVwYouv2HD674XnSkdGKH
 STM1tCGW01XvkWLA4gMMWfbaYtYvpoIhVcDS40LmJfSHz4jtB8Ql0lumPAj0OLO1A4Gh0XzYQ
 AcICDsTHEjJTtix1BE8dhaROz0Y=
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.01.23 um 14:08 schrieb Guenter Roeck:

> On Thu, Jan 26, 2023 at 08:40:21PM +0100, Armin Wolf wrote:
>> Thanks to bugreport 216655 on bugzilla triggered by the
>> dell-smm-hwmon driver, the contents of the sensor buffers
>> could be almost completely decoded.
>> Add an hwmon interface for exposing the fan and thermal
>> sensor values. The debugfs interface remains in place to
>> aid in reverse-engineering of unknown sensor types
>> and the thermal buffer.
>>
>> Tested-by: Anton=C3=ADn Skala <skala.antonin@gmail.com>
>> Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   drivers/platform/x86/dell/Kconfig        |   1 +
>>   drivers/platform/x86/dell/dell-wmi-ddv.c | 435 ++++++++++++++++++++++=
-
>>   2 files changed, 435 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/d=
ell/Kconfig
>> index d319de8f2132..21a74b63d9b1 100644
>> --- a/drivers/platform/x86/dell/Kconfig
>> +++ b/drivers/platform/x86/dell/Kconfig
>> @@ -194,6 +194,7 @@ config DELL_WMI_DDV
>>   	default m
>>   	depends on ACPI_BATTERY
>>   	depends on ACPI_WMI
>> +	depends on HWMON
> Not sure if adding such a dependency is a good idea.
> Up to the maintainer to decide. Personally I would prefer
> something like
> 	depends on HWMON || HWMON=3Dn
> and some conditionals in the code, as it is done with other drivers
> outside the hwmon directory.
>
Good point, i will include this in the next patch revision.

>>   	help
>>   	  This option adds support for WMI-based sensors like
>>   	  battery temperature sensors found on some Dell notebooks.
>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platfor=
m/x86/dell/dell-wmi-ddv.c
>> index 9695bf493ea6..5b30bb85199e 100644
>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>> @@ -13,6 +13,7 @@
>>   #include <linux/dev_printk.h>
>>   #include <linux/errno.h>
>>   #include <linux/kernel.h>
>> +#include <linux/hwmon.h>
>>   #include <linux/kstrtox.h>
>>   #include <linux/math.h>
>>   #include <linux/module.h>
>> @@ -21,10 +22,13 @@
>>   #include <linux/printk.h>
>>   #include <linux/seq_file.h>
>>   #include <linux/sysfs.h>
>> +#include <linux/types.h>
>>   #include <linux/wmi.h>
>>
>>   #include <acpi/battery.h>
>>
>> +#include <asm/unaligned.h>
>> +
>>   #define DRIVER_NAME	"dell-wmi-ddv"
>>
>>   #define DELL_DDV_SUPPORTED_VERSION_MIN	2
>> @@ -63,6 +67,29 @@ enum dell_ddv_method {
>>   	DELL_DDV_THERMAL_SENSOR_INFORMATION	=3D 0x22,
>>   };
>>
>> +struct fan_sensor_entry {
>> +	u8 type;
>> +	__le16 rpm;
>> +} __packed;
>> +
>> +struct thermal_sensor_entry {
>> +	u8 type;
>> +	s8 now;
>> +	s8 min;
>> +	s8 max;
>> +	u8 unknown;
>> +} __packed;
>> +
>> +struct combined_channel_info {
>> +	struct hwmon_channel_info info;
>> +	u32 config[];
>> +};
>> +
>> +struct combined_chip_info {
>> +	struct hwmon_chip_info chip;
>> +	const struct hwmon_channel_info *info[];
>> +};
>> +
>>   struct dell_wmi_ddv_data {
>>   	struct acpi_battery_hook hook;
>>   	struct device_attribute temp_attr;
>> @@ -70,6 +97,24 @@ struct dell_wmi_ddv_data {
>>   	struct wmi_device *wdev;
>>   };
>>
>> +static const char * const fan_labels[] =3D {
>> +	"CPU Fan",
>> +	"Chassis Motherboard Fan",
>> +	"Video Fan",
>> +	"Power Supply Fan",
>> +	"Chipset Fan",
>> +	"Memory Fan",
>> +	"PCI Fan",
>> +	"HDD Fan",
>> +};
>> +
>> +static const char * const fan_dock_labels[] =3D {
>> +	"Docking Chassis/Motherboard Fan",
>> +	"Docking Video Fan",
>> +	"Docking Power Supply Fan",
>> +	"Docking Chipset Fan",
>> +};
>> +
>>   static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell=
_ddv_method method, u32 arg,
>>   				   union acpi_object **result, acpi_object_type type)
>>   {
>> @@ -171,6 +216,386 @@ static int dell_wmi_ddv_query_string(struct wmi_d=
evice *wdev, enum dell_ddv_meth
>>   	return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_=
STRING);
>>   }
>>
>> +static int dell_wmi_ddv_query_sensors(struct wmi_device *wdev, enum de=
ll_ddv_method method,
>> +				      size_t entry_size, union acpi_object **result, u64 *count)
>> +{
>> +	union acpi_object *obj;
>> +	u64 buffer_size;
>> +	u8 *buffer;
>> +	int ret;
>> +
>> +	ret =3D dell_wmi_ddv_query_buffer(wdev, method, 0, &obj);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	buffer_size =3D obj->package.elements[0].integer.value;
>> +	buffer =3D obj->package.elements[1].buffer.pointer;
>> +	if (buffer_size % entry_size !=3D 1 || buffer[buffer_size - 1] !=3D 0=
xff) {
>> +		kfree(obj);
>> +
> Stray empty line
>
>> +		return -ENOMSG;
>> +	}
>> +
>> +	*count =3D (buffer_size - 1) / entry_size;
>> +	*result =3D obj;
>> +
>> +	return 0;
>> +}
>> +
>> +static umode_t dell_wmi_ddv_is_visible(const void *drvdata, enum hwmon=
_sensor_types type, u32 attr,
>> +				       int channel)
>> +{
>> +	return 0444;
>> +}
>> +
>> +static int dell_wmi_ddv_fan_read_channel(struct dell_wmi_ddv_data *dat=
a, u32 attr, int channel,
>> +					 long *val)
>> +{
>> +	struct fan_sensor_entry *entry;
>> +	union acpi_object *obj;
>> +	u64 count;
>> +	int ret;
>> +
>> +	ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_IN=
FORMATION,
>> +					 sizeof(*entry), &obj, &count);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	entry =3D (struct fan_sensor_entry *)obj->package.elements[1].buffer.=
pointer;
>> +	if (count > channel) {
>> +		switch (attr) {
>> +		case hwmon_fan_input:
>> +			*val =3D get_unaligned_le16(&entry[channel].rpm);
>> +
> Another stray empty line. I see that "empty line before return or break"
> is common. Looks odd to me, and I don't see the point (it confuses
> the code flow for me and lets my brain focus on the empty line instead
> of the code in question), but I guess that is PoV. I won't comment on
> it further and let the maintainer decide.
>
>> +			break;
>> +		default:
>> +			ret =3D -EOPNOTSUPP;
>> +		}
>> +	} else {
>> +		ret =3D -ENXIO;
>> +	}
> Error handling should come first.
>> +
>> +	kfree(obj);
>> +
>> +	return ret;
>> +}
>> +
>> +static int dell_wmi_ddv_temp_read_channel(struct dell_wmi_ddv_data *da=
ta, u32 attr, int channel,
>> +					  long *val)
>> +{
>> +	struct thermal_sensor_entry *entry;
>> +	union acpi_object *obj;
>> +	u64 count;
>> +	int ret;
>> +
>> +	ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSO=
R_INFORMATION,
>> +					 sizeof(*entry), &obj, &count);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	entry =3D (struct thermal_sensor_entry *)obj->package.elements[1].buf=
fer.pointer;
>> +	if (count > channel) {
> This is a bit of Joda programming. It is really "channel < count",
> ie the requested channel number is in the range of channels reported
> by the WMI code. PoV, of course, but I find that the above makes the
> code more difficult to read.
>> +		switch (attr) {
>> +		case hwmon_temp_input:
>> +			*val =3D entry[channel].now * 1000;
>> +
>> +			break;
>> +		case hwmon_temp_min:
>> +			*val =3D entry[channel].min * 1000;
>> +
>> +			break;
>> +		case hwmon_temp_max:
>> +			*val =3D entry[channel].max * 1000;
>> +
>> +			break;
>> +		default:
>> +			ret =3D -EOPNOTSUPP;
> break; missing
>
>> +		}
>> +	} else {
>> +		ret =3D -ENXIO;
>> +	}
> Same as above - error handling should come first.
>
>> +
>> +	kfree(obj);
>> +
>> +	return ret;
>> +}
>> +
>> +static int dell_wmi_ddv_read(struct device *dev, enum hwmon_sensor_typ=
es type, u32 attr,
>> +			     int channel, long *val)
>> +{
>> +	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
>> +
>> +	switch (type) {
>> +	case hwmon_fan:
>> +		return dell_wmi_ddv_fan_read_channel(data, attr, channel, val);
>> +	case hwmon_temp:
>> +		return dell_wmi_ddv_temp_read_channel(data, attr, channel, val);
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static int dell_wmi_ddv_fan_read_string(struct dell_wmi_ddv_data *data=
, int channel,
>> +					const char **str)
>> +{
>> +	struct fan_sensor_entry *entry;
>> +	union acpi_object *obj;
>> +	u64 count;
>> +	u8 type;
>> +	int ret;
>> +
>> +	ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_IN=
FORMATION,
>> +					 sizeof(*entry), &obj, &count);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	entry =3D (struct fan_sensor_entry *)obj->package.elements[1].buffer.=
pointer;
>> +	if (count > channel) {
>> +		type =3D entry[channel].type;
>> +
>> +		switch (type) {
>> +		case 0x00 ... 0x07:
>> +			*str =3D fan_labels[type];
>> +
>> +			break;
>> +		case 0x11 ... 0x14:
>> +			*str =3D fan_dock_labels[type - 0x11];
>> +
>> +			break;
>> +		default:
>> +			*str =3D "Unknown Fan";
> break; missing.
>
>> +		}
>> +	} else {
>> +		ret =3D -ENXIO;
>> +	}
> And again.
>
>> +
>> +	kfree(obj);
>> +
>> +	return ret;
>> +}
>> +
>> +static int dell_wmi_ddv_temp_read_string(struct dell_wmi_ddv_data *dat=
a, int channel,
>> +					 const char **str)
>> +{
>> +	struct thermal_sensor_entry *entry;
>> +	union acpi_object *obj;
>> +	u64 count;
>> +	int ret;
>> +
>> +	ret =3D dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSO=
R_INFORMATION,
>> +					 sizeof(*entry), &obj, &count);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	entry =3D (struct thermal_sensor_entry *)obj->package.elements[1].buf=
fer.pointer;
>> +	if (count > channel) {
>> +		switch (entry[channel].type) {
>> +		case 0x00:
>> +			*str =3D "CPU";
>> +
>> +			break;
>> +		case 0x11:
>> +			*str =3D "Video";
>> +
>> +			break;
>> +		case 0x22:
>> +			*str =3D "Memory"; // sometimes called DIMM
> Personally I don't permit C++ style comments in a hwmon driver
> unless _all_ comments are C++ style. Just a remark here.
>
>> +
>> +			break;
>> +		case 0x33:
>> +			*str =3D "Other";
>> +
>> +			break;
>> +		case 0x44:
>> +			*str =3D "Ambient"; // sometimes called SKIN
>> +
>> +			break;
>> +		case 0x52:
>> +			*str =3D "SODIMM";
>> +
>> +			break;
>> +		case 0x55:
>> +			*str =3D "HDD";
>> +
>> +			break;
>> +		case 0x62:
>> +			*str =3D "SODIMM 2";
>> +
>> +			break;
>> +		case 0x73:
>> +			*str =3D "NB";
>> +
>> +			break;
>> +		case 0x83:
>> +			*str =3D "Charger";
>> +
>> +			break;
>> +		case 0xbb:
>> +			*str =3D "Memory 3";
>> +
>> +			break;
>> +		default:
>> +			*str =3D "Unknown";
> break; missing
> Ok, I guess this is on purpose. I personally don't permit
> that since it always leaves the question if it was on purpose or not.
>
>> +		}
>> +	} else {
>> +		ret =3D -ENXIO;
>> +	}
>> +
>> +	kfree(obj);
>> +
>> +	return ret;
>> +}
>> +
>> +static int dell_wmi_ddv_read_string(struct device *dev, enum hwmon_sen=
sor_types type, u32 attr,
>> +				    int channel, const char **str)
>> +{
>> +	struct dell_wmi_ddv_data *data =3D dev_get_drvdata(dev);
>> +
>> +	switch (type) {
>> +	case hwmon_fan:
>> +		switch (attr) {
>> +		case hwmon_fan_label:
>> +			return dell_wmi_ddv_fan_read_string(data, channel, str);
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	case hwmon_temp:
>> +		switch (attr) {
>> +		case hwmon_temp_label:
>> +			return dell_wmi_ddv_temp_read_string(data, channel, str);
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return -EOPNOTSUPP;
>> +}
>> +
>> +static const struct hwmon_ops dell_wmi_ddv_ops =3D {
>> +	.is_visible =3D dell_wmi_ddv_is_visible,
>> +	.read =3D dell_wmi_ddv_read,
>> +	.read_string =3D dell_wmi_ddv_read_string,
>> +};
>> +
>> +static struct hwmon_channel_info *dell_wmi_ddv_channel_create(struct d=
evice *dev, u64 count,
>> +							      enum hwmon_sensor_types type,
>> +							      u32 config)
>> +{
>> +	struct combined_channel_info *cinfo;
>> +	int i;
>> +
>> +	cinfo =3D devm_kzalloc(dev, struct_size(cinfo, config, count + 1), GF=
P_KERNEL);
>> +	if (!cinfo)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	cinfo->info.type =3D type;
>> +	cinfo->info.config =3D cinfo->config;
>> +
>> +	for (i =3D 0; i < count; i++)
>> +		cinfo->config[i] =3D config;
>> +
>> +	return &cinfo->info;
>> +}
>> +
>> +static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi=
_device *wdev,
>> +							    enum dell_ddv_method method,
>> +							    size_t entry_size,
>> +							    enum hwmon_sensor_types type,
>> +							    u32 config)
>> +{
>> +	union acpi_object *obj;
>> +	u64 count;
>> +	int ret;
>> +
>> +	ret =3D dell_wmi_ddv_query_sensors(wdev, method, entry_size, &obj, &c=
ount);
>> +	if (ret < 0)
>> +		return ERR_PTR(ret);
>> +
>> +	kfree(obj);
>> +
>> +	if (!count)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	return dell_wmi_ddv_channel_create(&wdev->dev, count, type, config);
>> +}
>> +
>> +static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
>> +{
>> +	struct wmi_device *wdev =3D data->wdev;
>> +	struct combined_chip_info *cinfo;
>> +	struct device *hdev;
>> +	int index =3D 0;
>> +	int ret;
>> +
>> +	if (!devres_open_group(&wdev->dev, dell_wmi_ddv_hwmon_add, GFP_KERNEL=
))
>> +		return -ENOMEM;
>> +
>> +	cinfo =3D devm_kzalloc(&wdev->dev, struct_size(cinfo, info, 4), GFP_K=
ERNEL);
>> +	if (!cinfo) {
>> +		ret =3D -ENOMEM;
>> +
>> +		goto err_release;
>> +	}
>> +
>> +	cinfo->chip.ops =3D &dell_wmi_ddv_ops;
>> +	cinfo->chip.info =3D cinfo->info;
>> +
>> +	cinfo->info[index] =3D dell_wmi_ddv_channel_create(&wdev->dev, 1, hwm=
on_chip,
>> +							 HWMON_C_REGISTER_TZ);
>> +
>> +	if (IS_ERR(cinfo->info[index])) {
>> +		ret =3D PTR_ERR(cinfo->info[index]);
>> +
>> +		goto err_release;
>> +	}
>> +
>> +	index++;
>> +
>> +	cinfo->info[index] =3D dell_wmi_ddv_channel_init(wdev, DELL_DDV_FAN_S=
ENSOR_INFORMATION,
>> +						       sizeof(struct fan_sensor_entry), hwmon_fan,
>> +						       (HWMON_F_INPUT | HWMON_F_LABEL));
>> +	if (!IS_ERR(cinfo->info[index]))
>> +		index++;
>> +
>> +	cinfo->info[index] =3D dell_wmi_ddv_channel_init(wdev, DELL_DDV_THERM=
AL_SENSOR_INFORMATION,
>> +						       sizeof(struct thermal_sensor_entry),
>> +						       hwmon_temp, (HWMON_T_INPUT | HWMON_T_MIN |
>> +						       HWMON_T_MAX | HWMON_T_LABEL));
>> +	if (!IS_ERR(cinfo->info[index]))
>> +		index++;
>> +
>> +	if (!index) {
>> +		ret =3D -ENODEV;
>> +
>> +		goto err_release;
>> +	}
>> +
>> +	cinfo->info[index] =3D NULL;
>> +
>> +	hdev =3D devm_hwmon_device_register_with_info(&wdev->dev, "dell_ddv",=
 data, &cinfo->chip,
>> +						    NULL);
>> +	if (IS_ERR(hdev)) {
>> +		ret =3D PTR_ERR(hdev);
>> +
>> +		goto err_release;
>> +	}
>> +
>> +	devres_close_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
>> +
>> +	return 0;
>> +
>> +err_release:
>> +	devres_release_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
>> +
>> +	return ret;
>> +}
>> +
>>   static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u=
32 *index)
>>   {
>>   	const char *uid_str;
>> @@ -370,7 +795,15 @@ static int dell_wmi_ddv_probe(struct wmi_device *w=
dev, const void *context)
>>
>>   	dell_wmi_ddv_debugfs_init(wdev);
>>
>> -	return dell_wmi_ddv_battery_add(data);
>> +	ret =3D dell_wmi_ddv_hwmon_add(data);
>> +	if (ret < 0)
>> +		dev_dbg(&wdev->dev, "Unable to register hwmon interface: %d\n", ret)=
;
>> +
>> +	ret =3D dell_wmi_ddv_battery_add(data);
>> +	if (ret < 0)
>> +		dev_dbg(&wdev->dev, "Unable to register acpi battery hook: %d\n", re=
t);
>> +
> This used to be an error, but no longer is. Not my call to make
> if this is acceptable, just pointing it out.

I decided to not treat the battery hook as essential function anymore beca=
use
the battery hook and hwmon functionality are more or less disconnected fro=
m
each other, so having the driver abort probing just because one functional=
ity
could not be initialized seemed unreasonable to me.

I already thought about putting the battery hook and hwmon functionality i=
nto
separate drivers, with the main driver registering a MFD device or somethi=
ng similar.
Because apart from some generic routines, both functions are not connected=
 in any way.

Is it acceptable to split the driver for such a thing?

Armin Wolf

>> +	return 0;
>>   }
>>
>>   static const struct wmi_device_id dell_wmi_ddv_id_table[] =3D {
>> --
>> 2.30.2
>>
