Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703B7688909
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 22:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbjBBVaw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 16:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjBBVat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 16:30:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F27F697
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 13:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675373401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68G7Tu7aPcVfn4N7dRtLC8yfx8e8kO73ONxQiUtNPJE=;
        b=W5fk9LpQ8l8riLOnN9uc/8VbnaK/pgRUi7MK0NQddEPJpeMkwnfLX5BZ53IvD/JM7qIizq
        hpaGxc+P0PZODQYCSBPhlVJkLjd4B8CSCH1cO6kM3dDO7SNjobnHynKVMmTTZDuYCS7YCa
        G+Gn3RL2zmHE20LM2WuOriRCiEYrA/8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-wz6w-fu7OHK4ee5sIUZgLA-1; Thu, 02 Feb 2023 16:30:00 -0500
X-MC-Unique: wz6w-fu7OHK4ee5sIUZgLA-1
Received: by mail-ej1-f71.google.com with SMTP id bw6-20020a170906c1c600b0088e4f4830b1so2367205ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 13:30:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68G7Tu7aPcVfn4N7dRtLC8yfx8e8kO73ONxQiUtNPJE=;
        b=Gd5yQEF0x6NNz9PFKtOTB6EzYpEYzqBXSX5RrMUbxmbv28xg6h86J0LnQld02CE+GD
         SJjEdUwVMF0EksBtjljXTiypu5VRHCs7Sc0QMedlThIVSLslHc6xlD7hNPXsvmqrUPCN
         iwH9Wsp+ItEecH6t03/NDh7A+zPhYTKK8y4F9A1qLR7vgPfTnRSFmOKI3eziWaijF+QS
         6unlKNOvRsimgPCtvM6CP/dobAx0HPbsKNzLgMvos8old6HTvFt1f/k+tjwezEoPyGIR
         y68phNUiEiWbeqATocez1Xt2OW+LiP5Ja/F/9vGw3C6Q7gECcl20J2NI+55iaLzwejmr
         jrxA==
X-Gm-Message-State: AO0yUKUyzhJQmRg75OKazvN6ZqyUPUA40JMioWVNq1kxRoK9gdxlDuwl
        wDuBJEp7W9Hy7MKAy4X4ESYq/GfWRdKAgpOJcyIm9O+c65HJPVyT0PH+b95DIgdc+vwZoKucnn/
        TOjb05g14SFRoWCMT1dv5FSEr
X-Received: by 2002:aa7:d84d:0:b0:49c:96f9:417e with SMTP id f13-20020aa7d84d000000b0049c96f9417emr8278277eds.2.1675373398357;
        Thu, 02 Feb 2023 13:29:58 -0800 (PST)
X-Google-Smtp-Source: AK7set8P7uYy9K75CzpiLRGwkC0FHS9PlhilVxiuVPMomILhN/aaCSi9T+jilXQwsp2VJJUMe690mg==
X-Received: by 2002:aa7:d84d:0:b0:49c:96f9:417e with SMTP id f13-20020aa7d84d000000b0049c96f9417emr8278266eds.2.1675373398046;
        Thu, 02 Feb 2023 13:29:58 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id cq25-20020a056402221900b004a0afea4c9csm252682edb.18.2023.02.02.13.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 13:29:57 -0800 (PST)
Message-ID: <cf12d944-34ed-83ea-8570-3ce202e317ce@redhat.com>
Date:   Thu, 2 Feb 2023 22:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 5/5] platform/x86: dell-ddv: Add hwmon support
To:     Armin Wolf <W_Armin@gmx.de>, Guenter Roeck <linux@roeck-us.net>
Cc:     markgross@kernel.org, jdelvare@suse.com,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126194021.381092-1-W_Armin@gmx.de>
 <20230126194021.381092-6-W_Armin@gmx.de>
 <20230127130815.GA3911997@roeck-us.net>
 <d425820d-f0ce-4349-1b99-1b3d78ac2495@gmx.de>
 <91099107-73bf-8340-96a2-9a7ff1bfd4ad@gmx.de>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <91099107-73bf-8340-96a2-9a7ff1bfd4ad@gmx.de>
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

Hi,

On 2/2/23 22:12, Armin Wolf wrote:
> Am 27.01.23 um 17:09 schrieb Armin Wolf:
> 
>> Am 27.01.23 um 14:08 schrieb Guenter Roeck:
>>
>>> On Thu, Jan 26, 2023 at 08:40:21PM +0100, Armin Wolf wrote:
>>>> Thanks to bugreport 216655 on bugzilla triggered by the
>>>> dell-smm-hwmon driver, the contents of the sensor buffers
>>>> could be almost completely decoded.
>>>> Add an hwmon interface for exposing the fan and thermal
>>>> sensor values. The debugfs interface remains in place to
>>>> aid in reverse-engineering of unknown sensor types
>>>> and the thermal buffer.
>>>>
>>>> Tested-by: Antonín Skala <skala.antonin@gmail.com>
>>>> Tested-by: Gustavo Walbon <gustavowalbon@gmail.com>
>>>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>>>> ---
>>>>   drivers/platform/x86/dell/Kconfig        |   1 +
>>>>   drivers/platform/x86/dell/dell-wmi-ddv.c | 435 ++++++++++++++++++++++-
>>>>   2 files changed, 435 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/platform/x86/dell/Kconfig b/drivers/platform/x86/dell/Kconfig
>>>> index d319de8f2132..21a74b63d9b1 100644
>>>> --- a/drivers/platform/x86/dell/Kconfig
>>>> +++ b/drivers/platform/x86/dell/Kconfig
>>>> @@ -194,6 +194,7 @@ config DELL_WMI_DDV
>>>>       default m
>>>>       depends on ACPI_BATTERY
>>>>       depends on ACPI_WMI
>>>> +    depends on HWMON
>>> Not sure if adding such a dependency is a good idea.
>>> Up to the maintainer to decide. Personally I would prefer
>>> something like
>>>     depends on HWMON || HWMON=n
>>> and some conditionals in the code, as it is done with other drivers
>>> outside the hwmon directory.
>>>
>> Good point, i will include this in the next patch revision.
>>
>>>>       help
>>>>         This option adds support for WMI-based sensors like
>>>>         battery temperature sensors found on some Dell notebooks.
>>>> diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x86/dell/dell-wmi-ddv.c
>>>> index 9695bf493ea6..5b30bb85199e 100644
>>>> --- a/drivers/platform/x86/dell/dell-wmi-ddv.c
>>>> +++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
>>>> @@ -13,6 +13,7 @@
>>>>   #include <linux/dev_printk.h>
>>>>   #include <linux/errno.h>
>>>>   #include <linux/kernel.h>
>>>> +#include <linux/hwmon.h>
>>>>   #include <linux/kstrtox.h>
>>>>   #include <linux/math.h>
>>>>   #include <linux/module.h>
>>>> @@ -21,10 +22,13 @@
>>>>   #include <linux/printk.h>
>>>>   #include <linux/seq_file.h>
>>>>   #include <linux/sysfs.h>
>>>> +#include <linux/types.h>
>>>>   #include <linux/wmi.h>
>>>>
>>>>   #include <acpi/battery.h>
>>>>
>>>> +#include <asm/unaligned.h>
>>>> +
>>>>   #define DRIVER_NAME    "dell-wmi-ddv"
>>>>
>>>>   #define DELL_DDV_SUPPORTED_VERSION_MIN    2
>>>> @@ -63,6 +67,29 @@ enum dell_ddv_method {
>>>>       DELL_DDV_THERMAL_SENSOR_INFORMATION    = 0x22,
>>>>   };
>>>>
>>>> +struct fan_sensor_entry {
>>>> +    u8 type;
>>>> +    __le16 rpm;
>>>> +} __packed;
>>>> +
>>>> +struct thermal_sensor_entry {
>>>> +    u8 type;
>>>> +    s8 now;
>>>> +    s8 min;
>>>> +    s8 max;
>>>> +    u8 unknown;
>>>> +} __packed;
>>>> +
>>>> +struct combined_channel_info {
>>>> +    struct hwmon_channel_info info;
>>>> +    u32 config[];
>>>> +};
>>>> +
>>>> +struct combined_chip_info {
>>>> +    struct hwmon_chip_info chip;
>>>> +    const struct hwmon_channel_info *info[];
>>>> +};
>>>> +
>>>>   struct dell_wmi_ddv_data {
>>>>       struct acpi_battery_hook hook;
>>>>       struct device_attribute temp_attr;
>>>> @@ -70,6 +97,24 @@ struct dell_wmi_ddv_data {
>>>>       struct wmi_device *wdev;
>>>>   };
>>>>
>>>> +static const char * const fan_labels[] = {
>>>> +    "CPU Fan",
>>>> +    "Chassis Motherboard Fan",
>>>> +    "Video Fan",
>>>> +    "Power Supply Fan",
>>>> +    "Chipset Fan",
>>>> +    "Memory Fan",
>>>> +    "PCI Fan",
>>>> +    "HDD Fan",
>>>> +};
>>>> +
>>>> +static const char * const fan_dock_labels[] = {
>>>> +    "Docking Chassis/Motherboard Fan",
>>>> +    "Docking Video Fan",
>>>> +    "Docking Power Supply Fan",
>>>> +    "Docking Chipset Fan",
>>>> +};
>>>> +
>>>>   static int dell_wmi_ddv_query_type(struct wmi_device *wdev, enum dell_ddv_method method, u32 arg,
>>>>                      union acpi_object **result, acpi_object_type type)
>>>>   {
>>>> @@ -171,6 +216,386 @@ static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_ddv_meth
>>>>       return dell_wmi_ddv_query_type(wdev, method, arg, result, ACPI_TYPE_STRING);
>>>>   }
>>>>
>>>> +static int dell_wmi_ddv_query_sensors(struct wmi_device *wdev, enum dell_ddv_method method,
>>>> +                      size_t entry_size, union acpi_object **result, u64 *count)
>>>> +{
>>>> +    union acpi_object *obj;
>>>> +    u64 buffer_size;
>>>> +    u8 *buffer;
>>>> +    int ret;
>>>> +
>>>> +    ret = dell_wmi_ddv_query_buffer(wdev, method, 0, &obj);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    buffer_size = obj->package.elements[0].integer.value;
>>>> +    buffer = obj->package.elements[1].buffer.pointer;
>>>> +    if (buffer_size % entry_size != 1 || buffer[buffer_size - 1] != 0xff) {
>>>> +        kfree(obj);
>>>> +
>>> Stray empty line
>>>
>>>> +        return -ENOMSG;
>>>> +    }
>>>> +
>>>> +    *count = (buffer_size - 1) / entry_size;
>>>> +    *result = obj;
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static umode_t dell_wmi_ddv_is_visible(const void *drvdata, enum hwmon_sensor_types type, u32 attr,
>>>> +                       int channel)
>>>> +{
>>>> +    return 0444;
>>>> +}
>>>> +
>>>> +static int dell_wmi_ddv_fan_read_channel(struct dell_wmi_ddv_data *data, u32 attr, int channel,
>>>> +                     long *val)
>>>> +{
>>>> +    struct fan_sensor_entry *entry;
>>>> +    union acpi_object *obj;
>>>> +    u64 count;
>>>> +    int ret;
>>>> +
>>>> +    ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
>>>> +                     sizeof(*entry), &obj, &count);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    entry = (struct fan_sensor_entry *)obj->package.elements[1].buffer.pointer;
>>>> +    if (count > channel) {
>>>> +        switch (attr) {
>>>> +        case hwmon_fan_input:
>>>> +            *val = get_unaligned_le16(&entry[channel].rpm);
>>>> +
>>> Another stray empty line. I see that "empty line before return or break"
>>> is common. Looks odd to me, and I don't see the point (it confuses
>>> the code flow for me and lets my brain focus on the empty line instead
>>> of the code in question), but I guess that is PoV. I won't comment on
>>> it further and let the maintainer decide.
>>>
>>>> +            break;
>>>> +        default:
>>>> +            ret = -EOPNOTSUPP;
>>>> +        }
>>>> +    } else {
>>>> +        ret = -ENXIO;
>>>> +    }
>>> Error handling should come first.
>>>> +
>>>> +    kfree(obj);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int dell_wmi_ddv_temp_read_channel(struct dell_wmi_ddv_data *data, u32 attr, int channel,
>>>> +                      long *val)
>>>> +{
>>>> +    struct thermal_sensor_entry *entry;
>>>> +    union acpi_object *obj;
>>>> +    u64 count;
>>>> +    int ret;
>>>> +
>>>> +    ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
>>>> +                     sizeof(*entry), &obj, &count);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    entry = (struct thermal_sensor_entry *)obj->package.elements[1].buffer.pointer;
>>>> +    if (count > channel) {
>>> This is a bit of Joda programming. It is really "channel < count",
>>> ie the requested channel number is in the range of channels reported
>>> by the WMI code. PoV, of course, but I find that the above makes the
>>> code more difficult to read.
>>>> +        switch (attr) {
>>>> +        case hwmon_temp_input:
>>>> +            *val = entry[channel].now * 1000;
>>>> +
>>>> +            break;
>>>> +        case hwmon_temp_min:
>>>> +            *val = entry[channel].min * 1000;
>>>> +
>>>> +            break;
>>>> +        case hwmon_temp_max:
>>>> +            *val = entry[channel].max * 1000;
>>>> +
>>>> +            break;
>>>> +        default:
>>>> +            ret = -EOPNOTSUPP;
>>> break; missing
>>>
>>>> +        }
>>>> +    } else {
>>>> +        ret = -ENXIO;
>>>> +    }
>>> Same as above - error handling should come first.
>>>
>>>> +
>>>> +    kfree(obj);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int dell_wmi_ddv_read(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>>>> +                 int channel, long *val)
>>>> +{
>>>> +    struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
>>>> +
>>>> +    switch (type) {
>>>> +    case hwmon_fan:
>>>> +        return dell_wmi_ddv_fan_read_channel(data, attr, channel, val);
>>>> +    case hwmon_temp:
>>>> +        return dell_wmi_ddv_temp_read_channel(data, attr, channel, val);
>>>> +    default:
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static int dell_wmi_ddv_fan_read_string(struct dell_wmi_ddv_data *data, int channel,
>>>> +                    const char **str)
>>>> +{
>>>> +    struct fan_sensor_entry *entry;
>>>> +    union acpi_object *obj;
>>>> +    u64 count;
>>>> +    u8 type;
>>>> +    int ret;
>>>> +
>>>> +    ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
>>>> +                     sizeof(*entry), &obj, &count);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    entry = (struct fan_sensor_entry *)obj->package.elements[1].buffer.pointer;
>>>> +    if (count > channel) {
>>>> +        type = entry[channel].type;
>>>> +
>>>> +        switch (type) {
>>>> +        case 0x00 ... 0x07:
>>>> +            *str = fan_labels[type];
>>>> +
>>>> +            break;
>>>> +        case 0x11 ... 0x14:
>>>> +            *str = fan_dock_labels[type - 0x11];
>>>> +
>>>> +            break;
>>>> +        default:
>>>> +            *str = "Unknown Fan";
>>> break; missing.
>>>
>>>> +        }
>>>> +    } else {
>>>> +        ret = -ENXIO;
>>>> +    }
>>> And again.
>>>
>>>> +
>>>> +    kfree(obj);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int dell_wmi_ddv_temp_read_string(struct dell_wmi_ddv_data *data, int channel,
>>>> +                     const char **str)
>>>> +{
>>>> +    struct thermal_sensor_entry *entry;
>>>> +    union acpi_object *obj;
>>>> +    u64 count;
>>>> +    int ret;
>>>> +
>>>> +    ret = dell_wmi_ddv_query_sensors(data->wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
>>>> +                     sizeof(*entry), &obj, &count);
>>>> +    if (ret < 0)
>>>> +        return ret;
>>>> +
>>>> +    entry = (struct thermal_sensor_entry *)obj->package.elements[1].buffer.pointer;
>>>> +    if (count > channel) {
>>>> +        switch (entry[channel].type) {
>>>> +        case 0x00:
>>>> +            *str = "CPU";
>>>> +
>>>> +            break;
>>>> +        case 0x11:
>>>> +            *str = "Video";
>>>> +
>>>> +            break;
>>>> +        case 0x22:
>>>> +            *str = "Memory"; // sometimes called DIMM
>>> Personally I don't permit C++ style comments in a hwmon driver
>>> unless _all_ comments are C++ style. Just a remark here.
>>>
>>>> +
>>>> +            break;
>>>> +        case 0x33:
>>>> +            *str = "Other";
>>>> +
>>>> +            break;
>>>> +        case 0x44:
>>>> +            *str = "Ambient"; // sometimes called SKIN
>>>> +
>>>> +            break;
>>>> +        case 0x52:
>>>> +            *str = "SODIMM";
>>>> +
>>>> +            break;
>>>> +        case 0x55:
>>>> +            *str = "HDD";
>>>> +
>>>> +            break;
>>>> +        case 0x62:
>>>> +            *str = "SODIMM 2";
>>>> +
>>>> +            break;
>>>> +        case 0x73:
>>>> +            *str = "NB";
>>>> +
>>>> +            break;
>>>> +        case 0x83:
>>>> +            *str = "Charger";
>>>> +
>>>> +            break;
>>>> +        case 0xbb:
>>>> +            *str = "Memory 3";
>>>> +
>>>> +            break;
>>>> +        default:
>>>> +            *str = "Unknown";
>>> break; missing
>>> Ok, I guess this is on purpose. I personally don't permit
>>> that since it always leaves the question if it was on purpose or not.
>>>
>>>> +        }
>>>> +    } else {
>>>> +        ret = -ENXIO;
>>>> +    }
>>>> +
>>>> +    kfree(obj);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static int dell_wmi_ddv_read_string(struct device *dev, enum hwmon_sensor_types type, u32 attr,
>>>> +                    int channel, const char **str)
>>>> +{
>>>> +    struct dell_wmi_ddv_data *data = dev_get_drvdata(dev);
>>>> +
>>>> +    switch (type) {
>>>> +    case hwmon_fan:
>>>> +        switch (attr) {
>>>> +        case hwmon_fan_label:
>>>> +            return dell_wmi_ddv_fan_read_string(data, channel, str);
>>>> +        default:
>>>> +            break;
>>>> +        }
>>>> +        break;
>>>> +    case hwmon_temp:
>>>> +        switch (attr) {
>>>> +        case hwmon_temp_label:
>>>> +            return dell_wmi_ddv_temp_read_string(data, channel, str);
>>>> +        default:
>>>> +            break;
>>>> +        }
>>>> +        break;
>>>> +    default:
>>>> +        break;
>>>> +    }
>>>> +
>>>> +    return -EOPNOTSUPP;
>>>> +}
>>>> +
>>>> +static const struct hwmon_ops dell_wmi_ddv_ops = {
>>>> +    .is_visible = dell_wmi_ddv_is_visible,
>>>> +    .read = dell_wmi_ddv_read,
>>>> +    .read_string = dell_wmi_ddv_read_string,
>>>> +};
>>>> +
>>>> +static struct hwmon_channel_info *dell_wmi_ddv_channel_create(struct device *dev, u64 count,
>>>> +                                  enum hwmon_sensor_types type,
>>>> +                                  u32 config)
>>>> +{
>>>> +    struct combined_channel_info *cinfo;
>>>> +    int i;
>>>> +
>>>> +    cinfo = devm_kzalloc(dev, struct_size(cinfo, config, count + 1), GFP_KERNEL);
>>>> +    if (!cinfo)
>>>> +        return ERR_PTR(-ENOMEM);
>>>> +
>>>> +    cinfo->info.type = type;
>>>> +    cinfo->info.config = cinfo->config;
>>>> +
>>>> +    for (i = 0; i < count; i++)
>>>> +        cinfo->config[i] = config;
>>>> +
>>>> +    return &cinfo->info;
>>>> +}
>>>> +
>>>> +static struct hwmon_channel_info *dell_wmi_ddv_channel_init(struct wmi_device *wdev,
>>>> +                                enum dell_ddv_method method,
>>>> +                                size_t entry_size,
>>>> +                                enum hwmon_sensor_types type,
>>>> +                                u32 config)
>>>> +{
>>>> +    union acpi_object *obj;
>>>> +    u64 count;
>>>> +    int ret;
>>>> +
>>>> +    ret = dell_wmi_ddv_query_sensors(wdev, method, entry_size, &obj, &count);
>>>> +    if (ret < 0)
>>>> +        return ERR_PTR(ret);
>>>> +
>>>> +    kfree(obj);
>>>> +
>>>> +    if (!count)
>>>> +        return ERR_PTR(-ENODEV);
>>>> +
>>>> +    return dell_wmi_ddv_channel_create(&wdev->dev, count, type, config);
>>>> +}
>>>> +
>>>> +static int dell_wmi_ddv_hwmon_add(struct dell_wmi_ddv_data *data)
>>>> +{
>>>> +    struct wmi_device *wdev = data->wdev;
>>>> +    struct combined_chip_info *cinfo;
>>>> +    struct device *hdev;
>>>> +    int index = 0;
>>>> +    int ret;
>>>> +
>>>> +    if (!devres_open_group(&wdev->dev, dell_wmi_ddv_hwmon_add, GFP_KERNEL))
>>>> +        return -ENOMEM;
>>>> +
>>>> +    cinfo = devm_kzalloc(&wdev->dev, struct_size(cinfo, info, 4), GFP_KERNEL);
>>>> +    if (!cinfo) {
>>>> +        ret = -ENOMEM;
>>>> +
>>>> +        goto err_release;
>>>> +    }
>>>> +
>>>> +    cinfo->chip.ops = &dell_wmi_ddv_ops;
>>>> +    cinfo->chip.info = cinfo->info;
>>>> +
>>>> +    cinfo->info[index] = dell_wmi_ddv_channel_create(&wdev->dev, 1, hwmon_chip,
>>>> +                             HWMON_C_REGISTER_TZ);
>>>> +
>>>> +    if (IS_ERR(cinfo->info[index])) {
>>>> +        ret = PTR_ERR(cinfo->info[index]);
>>>> +
>>>> +        goto err_release;
>>>> +    }
>>>> +
>>>> +    index++;
>>>> +
>>>> +    cinfo->info[index] = dell_wmi_ddv_channel_init(wdev, DELL_DDV_FAN_SENSOR_INFORMATION,
>>>> +                               sizeof(struct fan_sensor_entry), hwmon_fan,
>>>> +                               (HWMON_F_INPUT | HWMON_F_LABEL));
>>>> +    if (!IS_ERR(cinfo->info[index]))
>>>> +        index++;
>>>> +
>>>> +    cinfo->info[index] = dell_wmi_ddv_channel_init(wdev, DELL_DDV_THERMAL_SENSOR_INFORMATION,
>>>> +                               sizeof(struct thermal_sensor_entry),
>>>> +                               hwmon_temp, (HWMON_T_INPUT | HWMON_T_MIN |
>>>> +                               HWMON_T_MAX | HWMON_T_LABEL));
>>>> +    if (!IS_ERR(cinfo->info[index]))
>>>> +        index++;
>>>> +
>>>> +    if (!index) {
>>>> +        ret = -ENODEV;
>>>> +
>>>> +        goto err_release;
>>>> +    }
>>>> +
>>>> +    cinfo->info[index] = NULL;
>>>> +
>>>> +    hdev = devm_hwmon_device_register_with_info(&wdev->dev, "dell_ddv", data, &cinfo->chip,
>>>> +                            NULL);
>>>> +    if (IS_ERR(hdev)) {
>>>> +        ret = PTR_ERR(hdev);
>>>> +
>>>> +        goto err_release;
>>>> +    }
>>>> +
>>>> +    devres_close_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
>>>> +
>>>> +    return 0;
>>>> +
>>>> +err_release:
>>>> +    devres_release_group(&wdev->dev, dell_wmi_ddv_hwmon_add);
>>>> +
>>>> +    return ret;
>>>> +}
>>>> +
>>>>   static int dell_wmi_ddv_battery_index(struct acpi_device *acpi_dev, u32 *index)
>>>>   {
>>>>       const char *uid_str;
>>>> @@ -370,7 +795,15 @@ static int dell_wmi_ddv_probe(struct wmi_device *wdev, const void *context)
>>>>
>>>>       dell_wmi_ddv_debugfs_init(wdev);
>>>>
>>>> -    return dell_wmi_ddv_battery_add(data);
>>>> +    ret = dell_wmi_ddv_hwmon_add(data);
>>>> +    if (ret < 0)
>>>> +        dev_dbg(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
>>>> +
>>>> +    ret = dell_wmi_ddv_battery_add(data);
>>>> +    if (ret < 0)
>>>> +        dev_dbg(&wdev->dev, "Unable to register acpi battery hook: %d\n", ret);
>>>> +
>>> This used to be an error, but no longer is. Not my call to make
>>> if this is acceptable, just pointing it out.
>>
>> I decided to not treat the battery hook as essential function anymore because
>> the battery hook and hwmon functionality are more or less disconnected from
>> each other, so having the driver abort probing just because one functionality
>> could not be initialized seemed unreasonable to me.
>>
>> I already thought about putting the battery hook and hwmon functionality into
>> separate drivers, with the main driver registering a MFD device or something similar.
>> Because apart from some generic routines, both functions are not connected in any way.
>>
>> Is it acceptable to split the driver for such a thing?
>>
>> Armin Wolf
>>
> Any thoughts about this? Otherwise i will just use conditionals.

I addressed this already in my earlier review of this (5/5) patch:

"""
I'm fine with not making either _add failing an error, but can we make this a dev_warn,
dev_dbg is a bit too low of a log-level for something which is not supposed to happen.

E.g. change this to:

	ret = dell_wmi_ddv_hwmon_add(data);
	if (ret && ret != -ENODEV)
		dev_warn(&wdev->dev, "Unable to register hwmon interface: %d\n", ret);
"""

IOW I agree to not have one of the _add() calls failing making probe() fail,
because as you say there are 2 independent calls and just because one does
not work does not mean we don't still want the other.

But as mentioned please change the logging to a warning (and make it
silent when ret == -ENODEV).

Regards,

Hans



