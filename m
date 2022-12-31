Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E00D865A3C6
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbiLaLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiLaLlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:41:01 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB6F6452;
        Sat, 31 Dec 2022 03:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672486841; bh=Kg+7jETs1FE4LoaTLeVpujIhHEsvh+vDZX6MHC2NZ6k=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=sTv5AfY1opiHxSQI01PJk9cNsf/ih8HASZsAY66GvWVjNtAkziYmtSw8xUAPWkUZB
         wnuea+WCxxL+TzYNhxpAOd9vAcjVYF1Xf67n4DldTPxxIbthVQrl46vd5Bg4xDK761
         edywFbXUcv6TMEoAnF0av7XOM43ivHlIKNIYzHkpLflkxYClrGMS/vRo92LGDTSCgX
         w9QK8dCFi9B3hHG70IeFixuntw/h5clzMJpxepbfbV5/dvHdAsuO7/GO7kAgBVGPt/
         pRbi9AmrUHsYepHGAKCgsBPZqTFOHdzPG/bpvaAQ0iwSB3tFN3snYLvdX4lWI7Nu5L
         9FcTF0iNGKang==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [141.30.226.129] ([141.30.226.129]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MAONd-1p5pac2W79-00Bwa5; Sat, 31
 Dec 2022 12:40:41 +0100
Subject: Re: [PATCH 2/3] hwmon: (ftsteutates) Convert to
 devm_hwmon_device_register_with_info()
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221224041855.83981-1-W_Armin@gmx.de>
 <20221224041855.83981-3-W_Armin@gmx.de>
 <20221224151835.GA569106@roeck-us.net>
From:   Armin Wolf <W_Armin@gmx.de>
Message-ID: <b0bfb455-f702-7ac8-230f-01c8e4aa2be3@gmx.de>
Date:   Sat, 31 Dec 2022 12:40:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20221224151835.GA569106@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:jl6Z/8qF/Hwo3aTrrkZ9jttuSRf3p0OhFNbAvSAYD5KAXm8SYLC
 W2YitbDC61Vz23rFZpA4SymiGzHvyBeIgBiYa2qlM/MP+MMojVXnLoKH3m8BxBPsDdZ/sud
 1LTfvWqXyHvq8OBmM8IEVcypULpsRre6bdWYfSJcH0oLp4/sUs3CfRShKHPP8ycUekW+xIu
 nzFgmhrr+Td14tnu95BpA==
UI-OutboundReport: notjunk:1;M01:P0:gbbqVVh0KkI=;9goYoxfpVc738K+Gb+mNa+JcSci
 8XJmRQZ6NzMd9BzAfNyZhddHCWoj4G3v6ohP+j5aiA66hinmnWiglhfTe3jMtRYcgCefpmJzQ
 ApwgZx3a1quDUwGeCSk7RGDU7PNf3wNljTpUPjfxHPwEMALXlIezy1oqUCANyNeUFAdb18aFT
 Avds8kV+B57PHyzz3eEFh59BrzJbhae6LAQzSaOxGRtGUZdIrwFBORlexif+FKwr6QC+lGZ8f
 J7tYImHuzhk/o//+O39dR5DLWjhN3YkbGIfTtQHe6FsvzoJDYzZe8rrtoGgyAJgec2xD6ouh/
 OwK5GvXTbfRTfFpz3nvAMurlkMc6On7tnSy0HB48Fzwvby5ez3AwkWaOBAL4w2s2ZkImNdF2T
 mOFAbQOCddqwkqWYfnGt7kFaBW2bCbo9/xtuu1Nw1v6ituNJfK7JtlmvMv+reTzMrWUwknxMA
 h6U01JwPJwgBQg3aAHHMB8uyAh0beSLAok2TXDhqXK4QBCMtUS3kCThTwSAO42SdXDFBiq+uV
 sOIndPoOBAJ+Ji2JeYN+9X8LAg4uekevrdp1VNRGzOxelMdNUBf8ix6obrFvVdsbDz4vqTh7C
 6EKaCYtSk0u70/uWiOSp1o87adWQ3+45Z++OvA+mu35IflZfzYJfJh2uGPetVg3QGElNf+ALx
 SP3QRM4POhwZAIqccWmBmul2fl4GZBqRKEujVLhxRa+rltoSQ/byvz/u6lfV+Ln+Dp4tHX1W0
 qRY+cu4O2hBANQUxw/UNadVAg6kpSUFW8J9Z4MBvekNTsGzWLzzt1YD4rJETo4sqyGajsibC1
 kwlq8MvgGEdIzL8oNokkU1enjYs5mF79I2zC7wDBuyTc221bCKEDpqVBX3Rg4/xILxacMH36J
 mnYDl97IUDHYsl3GsU944zDmdFMEGVKFiDqfDHgheL6M647v6WVFqqwuvxVDvJiokpvg8tLnX
 MMg1IUTKAQvl3ts37xFBdvaM4Ko=
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.12.22 um 16:18 schrieb Guenter Roeck:

> On Sat, Dec 24, 2022 at 05:18:54AM +0100, Armin Wolf wrote:
>> Convert driver to use devm_hwmon_device_register_with_info()
>> to reduce module size by 40%. The non-standard fan_source
>> attribute is replaced with the standard pwmX_auto_channels_temp
>> attribute and its special behaviour being documented.
>> Also export fan present status as fanX_fault.
> There are multiple changes in this patch which are not related
> to the actual conversion. Please split into separate patches for
> each functional change.
>
> While I agree with the fan_source -> pwmX_auto_channels_temp
> change, it needs to be done separately after the conversion,
> because it is an ABI change which we may have to undo if someone
> complains.
>
> "export fan present status as fanX_fault" also needs to be a
> separate patch.
>
> In this context, normally alarms are supposed to auto-clear
> after reading an attribute, if the condition no longer exists.
> Is it really necessary to explicitly clear the condition, or
> would it be possible to auto-clear it after reading the attribute ?
>
> Thanks,
> Guenter

According to the datasheet, the alarm flags are "sticky" and need to
be reset explicitly. Unfortunately, the BMC does not immediately reassign
those flags in case of the alarm condition being present, but does this at
the next "poll cycle". In order to emulate auto-clearable alarms, the driver
would have to constantly poll the BMC, which would still glitch since we do
not know the duration of a "poll cycle".

Other than that, we could:
- introduce sticky alarm attributes ("fanX_alarm_sticky", ...)
- keep it as it is

Armin Wolf

>> Tested on a Fujitsu DS3401-B1.
>>
>> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
>> ---
>>   Documentation/hwmon/ftsteutates.rst |   5 +
>>   drivers/hwmon/ftsteutates.c         | 546 ++++++++++------------------
>>   2 files changed, 207 insertions(+), 344 deletions(-)
>>
>> diff --git a/Documentation/hwmon/ftsteutates.rst b/Documentation/hwmon/ftsteutates.rst
>> index 198fa8e2819d..b3bfec36661d 100644
>> --- a/Documentation/hwmon/ftsteutates.rst
>> +++ b/Documentation/hwmon/ftsteutates.rst
>> @@ -22,6 +22,11 @@ enhancements. It can monitor up to 4 voltages, 16 temperatures and
>>   8 fans. It also contains an integrated watchdog which is currently
>>   implemented in this driver.
>>
>> +The ``pwmX_auto_channels_temp`` attributes show which temperature sensor
>> +is currently driving which fan channel. This value might dynamically change
>> +during runtime depending on the temperature sensor selected by
>> +the fan control circuit.
>> +
>>   The 4 voltages require a board-specific multiplier, since the BMC can
>>   only measure voltages up to 3.3V and thus relies on voltage dividers.
>>   Consult your motherboard manual for details.
>> diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
>> index ffa0bb364877..66ff8d69a0de 100644
>> --- a/drivers/hwmon/ftsteutates.c
>> +++ b/drivers/hwmon/ftsteutates.c
>> @@ -6,9 +6,7 @@
>>    *		  Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>
>>    */
>>   #include <linux/err.h>
>> -#include <linux/fs.h>
>>   #include <linux/hwmon.h>
>> -#include <linux/hwmon-sysfs.h>
>>   #include <linux/i2c.h>
>>   #include <linux/init.h>
>>   #include <linux/jiffies.h>
>> @@ -16,8 +14,6 @@
>>   #include <linux/module.h>
>>   #include <linux/mutex.h>
>>   #include <linux/slab.h>
>> -#include <linux/sysfs.h>
>> -#include <linux/uaccess.h>
>>   #include <linux/watchdog.h>
>>
>>   #define FTS_DEVICE_ID_REG		0x0000
>> @@ -340,376 +336,240 @@ static int fts_watchdog_init(struct fts_data *data)
>>   	return watchdog_register_device(&data->wdd);
>>   }
>>
>> -/*****************************************************************************/
>> -/* SysFS handler functions						     */
>> -/*****************************************************************************/
>> -static ssize_t in_value_show(struct device *dev,
>> -			     struct device_attribute *devattr, char *buf)
>> -{
>> -	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	int value, err;
>> -
>> -	err = fts_update_device(data);
>> -	if (err < 0)
>> -		return err;
>> -
>> -	value = DIV_ROUND_CLOSEST(data->volt[index] * 3300, 255);
>> -
>> -	return sprintf(buf, "%d\n", value);
>> -}
>> -
>> -static ssize_t temp_value_show(struct device *dev,
>> -			       struct device_attribute *devattr, char *buf)
>> -{
>> -	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	int value, err;
>> -
>> -	err = fts_update_device(data);
>> -	if (err < 0)
>> -		return err;
>> -
>> -	value = (data->temp_input[index] - 64) * 1000;
>> -
>> -	return sprintf(buf, "%d\n", value);
>> -}
>> -
>> -static ssize_t temp_fault_show(struct device *dev,
>> -			       struct device_attribute *devattr, char *buf)
>> -{
>> -	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	int err;
>> -
>> -	err = fts_update_device(data);
>> -	if (err < 0)
>> -		return err;
>> -
>> -	/* 00h Temperature = Sensor Error */
>> -	return sprintf(buf, "%d\n", data->temp_input[index] == 0);
>> -}
>> -
>> -static ssize_t temp_alarm_show(struct device *dev,
>> -			       struct device_attribute *devattr, char *buf)
>> +static umode_t fts_is_visible(const void *devdata, enum hwmon_sensor_types type, u32 attr,
>> +			      int channel)
>>   {
>> -	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	int err;
>> -
>> -	err = fts_update_device(data);
>> -	if (err < 0)
>> -		return err;
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		switch (attr) {
>> +		case hwmon_temp_input:
>> +		case hwmon_temp_fault:
>> +			return 0444;
>> +		case hwmon_temp_alarm:
>> +			return 0644;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	case hwmon_fan:
>> +		switch (attr) {
>> +		case hwmon_fan_input:
>> +		case hwmon_fan_fault:
>> +			return 0444;
>> +		case hwmon_fan_alarm:
>> +			return 0644;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	case hwmon_pwm:
>> +	case hwmon_in:
>> +		return 0444;
>> +	default:
>> +		break;
>> +	}
>>
>> -	return sprintf(buf, "%u\n", !!(data->temp_alarm & BIT(index)));
>> +	return 0;
>>   }
>>
>> -static ssize_t
>> -temp_alarm_store(struct device *dev, struct device_attribute *devattr,
>> -		 const char *buf, size_t count)
>> +static int fts_read(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
>> +		    long *val)
>>   {
>>   	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	long ret;
>> +	int ret = fts_update_device(data);
>>
>> -	ret = fts_update_device(data);
>>   	if (ret < 0)
>>   		return ret;
>>
>> -	if (kstrtoul(buf, 10, &ret) || ret != 0)
>> -		return -EINVAL;
>> -
>> -	mutex_lock(&data->update_lock);
>> -	ret = fts_read_byte(data->client, FTS_REG_TEMP_CONTROL(index));
>> -	if (ret < 0)
>> -		goto error;
>> -
>> -	ret = fts_write_byte(data->client, FTS_REG_TEMP_CONTROL(index),
>> -			     ret | 0x1);
>> -	if (ret < 0)
>> -		goto error;
>> -
>> -	data->valid = false;
>> -	ret = count;
>> -error:
>> -	mutex_unlock(&data->update_lock);
>> -	return ret;
>> -}
>> -
>> -static ssize_t fan_value_show(struct device *dev,
>> -			      struct device_attribute *devattr, char *buf)
>> -{
>> -	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	int value, err;
>> -
>> -	err = fts_update_device(data);
>> -	if (err < 0)
>> -		return err;
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		switch (attr) {
>> +		case hwmon_temp_input:
>> +			*val = (data->temp_input[channel] - 64) * 1000;
>>
>> -	value = data->fan_input[index] * 60;
>> +			return 0;
>> +		case hwmon_temp_alarm:
>> +			*val = !!(data->temp_alarm & BIT(channel));
>>
>> -	return sprintf(buf, "%d\n", value);
>> -}
>> +			return 0;
>> +		case hwmon_temp_fault:
>> +			/* 00h Temperature = Sensor Error */;
>> +			*val = (data->temp_input[channel] == 0);
>>
>> -static ssize_t fan_source_show(struct device *dev,
>> -			       struct device_attribute *devattr, char *buf)
>> -{
>> -	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	int err;
>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	case hwmon_fan:
>> +		switch (attr) {
>> +		case hwmon_fan_input:
>> +			*val = data->fan_input[channel] * 60;
>>
>> -	err = fts_update_device(data);
>> -	if (err < 0)
>> -		return err;
>> +			return 0;
>> +		case hwmon_fan_alarm:
>> +			*val = !!(data->fan_alarm & BIT(channel));
>>
>> -	return sprintf(buf, "%u\n", data->fan_source[index]);
>> -}
>> +			return 0;
>> +		case hwmon_fan_fault:
>> +			*val = !(data->fan_present & BIT(channel));
>>
>> -static ssize_t fan_alarm_show(struct device *dev,
>> -			      struct device_attribute *devattr, char *buf)
>> -{
>> -	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	int err;
>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	case hwmon_pwm:
>> +		switch (attr) {
>> +		case hwmon_pwm_auto_channels_temp:
>> +			if (data->fan_source[channel] == 0xff)
>> +				*val = 0;
>> +			else
>> +				*val = BIT(data->fan_source[channel]);
>> +
>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	case hwmon_in:
>> +		switch (attr) {
>> +		case hwmon_in_input:
>> +			*val = DIV_ROUND_CLOSEST(data->volt[channel] * 3300, 255);
>>
>> -	err = fts_update_device(data);
>> -	if (err < 0)
>> -		return err;
>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>>
>> -	return sprintf(buf, "%d\n", !!(data->fan_alarm & BIT(index)));
>> +	return -EOPNOTSUPP;
>>   }
>>
>> -static ssize_t
>> -fan_alarm_store(struct device *dev, struct device_attribute *devattr,
>> -		const char *buf, size_t count)
>> +static int fts_write(struct device *dev, enum hwmon_sensor_types type, u32 attr, int channel,
>> +		     long val)
>>   {
>>   	struct fts_data *data = dev_get_drvdata(dev);
>> -	int index = to_sensor_dev_attr(devattr)->index;
>> -	long ret;
>> +	int ret = fts_update_device(data);
>>
>> -	ret = fts_update_device(data);
>>   	if (ret < 0)
>>   		return ret;
>>
>> -	if (kstrtoul(buf, 10, &ret) || ret != 0)
>> -		return -EINVAL;
>> -
>> -	mutex_lock(&data->update_lock);
>> -	ret = fts_read_byte(data->client, FTS_REG_FAN_CONTROL(index));
>> -	if (ret < 0)
>> -		goto error;
>> -
>> -	ret = fts_write_byte(data->client, FTS_REG_FAN_CONTROL(index),
>> -			     ret | 0x1);
>> -	if (ret < 0)
>> -		goto error;
>> +	switch (type) {
>> +	case hwmon_temp:
>> +		switch (attr) {
>> +		case hwmon_temp_alarm:
>> +			if (val)
>> +				return -EINVAL;
>> +
>> +			mutex_lock(&data->update_lock);
>> +			ret = fts_read_byte(data->client, FTS_REG_TEMP_CONTROL(channel));
>> +			if (ret >= 0)
>> +				ret = fts_write_byte(data->client, FTS_REG_TEMP_CONTROL(channel),
>> +						     ret | 0x1);
>> +			if (ret >= 0)
>> +				data->valid = false;
>> +
>> +			mutex_unlock(&data->update_lock);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	case hwmon_fan:
>> +		switch (attr) {
>> +		case hwmon_fan_alarm:
>> +			if (val)
>> +				return -EINVAL;
>> +
>> +			mutex_lock(&data->update_lock);
>> +			ret = fts_read_byte(data->client, FTS_REG_FAN_CONTROL(channel));
>> +			if (ret >= 0)
>> +				ret = fts_write_byte(data->client, FTS_REG_FAN_CONTROL(channel),
>> +						     ret | 0x1);
>> +			if (ret >= 0)
>> +				data->valid = false;
>> +
>> +			mutex_unlock(&data->update_lock);
>> +			if (ret < 0)
>> +				return ret;
>> +
>> +			return 0;
>> +		default:
>> +			break;
>> +		}
>> +		break;
>> +	default:
>> +		break;
>> +	}
>>
>> -	data->valid = false;
>> -	ret = count;
>> -error:
>> -	mutex_unlock(&data->update_lock);
>> -	return ret;
>> +	return -EOPNOTSUPP;
>>   }
>>
>> -/*****************************************************************************/
>> -/* SysFS structs							     */
>> -/*****************************************************************************/
>> -
>> -/* Temperature sensors */
>> -static SENSOR_DEVICE_ATTR_RO(temp1_input, temp_value, 0);
>> -static SENSOR_DEVICE_ATTR_RO(temp2_input, temp_value, 1);
>> -static SENSOR_DEVICE_ATTR_RO(temp3_input, temp_value, 2);
>> -static SENSOR_DEVICE_ATTR_RO(temp4_input, temp_value, 3);
>> -static SENSOR_DEVICE_ATTR_RO(temp5_input, temp_value, 4);
>> -static SENSOR_DEVICE_ATTR_RO(temp6_input, temp_value, 5);
>> -static SENSOR_DEVICE_ATTR_RO(temp7_input, temp_value, 6);
>> -static SENSOR_DEVICE_ATTR_RO(temp8_input, temp_value, 7);
>> -static SENSOR_DEVICE_ATTR_RO(temp9_input, temp_value, 8);
>> -static SENSOR_DEVICE_ATTR_RO(temp10_input, temp_value, 9);
>> -static SENSOR_DEVICE_ATTR_RO(temp11_input, temp_value, 10);
>> -static SENSOR_DEVICE_ATTR_RO(temp12_input, temp_value, 11);
>> -static SENSOR_DEVICE_ATTR_RO(temp13_input, temp_value, 12);
>> -static SENSOR_DEVICE_ATTR_RO(temp14_input, temp_value, 13);
>> -static SENSOR_DEVICE_ATTR_RO(temp15_input, temp_value, 14);
>> -static SENSOR_DEVICE_ATTR_RO(temp16_input, temp_value, 15);
>> -
>> -static SENSOR_DEVICE_ATTR_RO(temp1_fault, temp_fault, 0);
>> -static SENSOR_DEVICE_ATTR_RO(temp2_fault, temp_fault, 1);
>> -static SENSOR_DEVICE_ATTR_RO(temp3_fault, temp_fault, 2);
>> -static SENSOR_DEVICE_ATTR_RO(temp4_fault, temp_fault, 3);
>> -static SENSOR_DEVICE_ATTR_RO(temp5_fault, temp_fault, 4);
>> -static SENSOR_DEVICE_ATTR_RO(temp6_fault, temp_fault, 5);
>> -static SENSOR_DEVICE_ATTR_RO(temp7_fault, temp_fault, 6);
>> -static SENSOR_DEVICE_ATTR_RO(temp8_fault, temp_fault, 7);
>> -static SENSOR_DEVICE_ATTR_RO(temp9_fault, temp_fault, 8);
>> -static SENSOR_DEVICE_ATTR_RO(temp10_fault, temp_fault, 9);
>> -static SENSOR_DEVICE_ATTR_RO(temp11_fault, temp_fault, 10);
>> -static SENSOR_DEVICE_ATTR_RO(temp12_fault, temp_fault, 11);
>> -static SENSOR_DEVICE_ATTR_RO(temp13_fault, temp_fault, 12);
>> -static SENSOR_DEVICE_ATTR_RO(temp14_fault, temp_fault, 13);
>> -static SENSOR_DEVICE_ATTR_RO(temp15_fault, temp_fault, 14);
>> -static SENSOR_DEVICE_ATTR_RO(temp16_fault, temp_fault, 15);
>> -
>> -static SENSOR_DEVICE_ATTR_RW(temp1_alarm, temp_alarm, 0);
>> -static SENSOR_DEVICE_ATTR_RW(temp2_alarm, temp_alarm, 1);
>> -static SENSOR_DEVICE_ATTR_RW(temp3_alarm, temp_alarm, 2);
>> -static SENSOR_DEVICE_ATTR_RW(temp4_alarm, temp_alarm, 3);
>> -static SENSOR_DEVICE_ATTR_RW(temp5_alarm, temp_alarm, 4);
>> -static SENSOR_DEVICE_ATTR_RW(temp6_alarm, temp_alarm, 5);
>> -static SENSOR_DEVICE_ATTR_RW(temp7_alarm, temp_alarm, 6);
>> -static SENSOR_DEVICE_ATTR_RW(temp8_alarm, temp_alarm, 7);
>> -static SENSOR_DEVICE_ATTR_RW(temp9_alarm, temp_alarm, 8);
>> -static SENSOR_DEVICE_ATTR_RW(temp10_alarm, temp_alarm, 9);
>> -static SENSOR_DEVICE_ATTR_RW(temp11_alarm, temp_alarm, 10);
>> -static SENSOR_DEVICE_ATTR_RW(temp12_alarm, temp_alarm, 11);
>> -static SENSOR_DEVICE_ATTR_RW(temp13_alarm, temp_alarm, 12);
>> -static SENSOR_DEVICE_ATTR_RW(temp14_alarm, temp_alarm, 13);
>> -static SENSOR_DEVICE_ATTR_RW(temp15_alarm, temp_alarm, 14);
>> -static SENSOR_DEVICE_ATTR_RW(temp16_alarm, temp_alarm, 15);
>> -
>> -static struct attribute *fts_temp_attrs[] = {
>> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp2_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp3_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp4_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp5_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp6_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp7_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp8_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp9_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp10_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp11_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp12_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp13_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp14_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp15_input.dev_attr.attr,
>> -	&sensor_dev_attr_temp16_input.dev_attr.attr,
>> -
>> -	&sensor_dev_attr_temp1_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp2_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp3_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp4_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp5_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp6_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp7_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp8_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp9_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp10_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp11_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp12_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp13_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp14_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp15_fault.dev_attr.attr,
>> -	&sensor_dev_attr_temp16_fault.dev_attr.attr,
>> -
>> -	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp2_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp3_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp4_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp5_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp6_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp7_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp8_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp9_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp10_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp11_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp12_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp13_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp14_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp15_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_temp16_alarm.dev_attr.attr,
>> -	NULL
>> -};
>> -
>> -/* Fans */
>> -static SENSOR_DEVICE_ATTR_RO(fan1_input, fan_value, 0);
>> -static SENSOR_DEVICE_ATTR_RO(fan2_input, fan_value, 1);
>> -static SENSOR_DEVICE_ATTR_RO(fan3_input, fan_value, 2);
>> -static SENSOR_DEVICE_ATTR_RO(fan4_input, fan_value, 3);
>> -static SENSOR_DEVICE_ATTR_RO(fan5_input, fan_value, 4);
>> -static SENSOR_DEVICE_ATTR_RO(fan6_input, fan_value, 5);
>> -static SENSOR_DEVICE_ATTR_RO(fan7_input, fan_value, 6);
>> -static SENSOR_DEVICE_ATTR_RO(fan8_input, fan_value, 7);
>> -
>> -static SENSOR_DEVICE_ATTR_RO(fan1_source, fan_source, 0);
>> -static SENSOR_DEVICE_ATTR_RO(fan2_source, fan_source, 1);
>> -static SENSOR_DEVICE_ATTR_RO(fan3_source, fan_source, 2);
>> -static SENSOR_DEVICE_ATTR_RO(fan4_source, fan_source, 3);
>> -static SENSOR_DEVICE_ATTR_RO(fan5_source, fan_source, 4);
>> -static SENSOR_DEVICE_ATTR_RO(fan6_source, fan_source, 5);
>> -static SENSOR_DEVICE_ATTR_RO(fan7_source, fan_source, 6);
>> -static SENSOR_DEVICE_ATTR_RO(fan8_source, fan_source, 7);
>> -
>> -static SENSOR_DEVICE_ATTR_RW(fan1_alarm, fan_alarm, 0);
>> -static SENSOR_DEVICE_ATTR_RW(fan2_alarm, fan_alarm, 1);
>> -static SENSOR_DEVICE_ATTR_RW(fan3_alarm, fan_alarm, 2);
>> -static SENSOR_DEVICE_ATTR_RW(fan4_alarm, fan_alarm, 3);
>> -static SENSOR_DEVICE_ATTR_RW(fan5_alarm, fan_alarm, 4);
>> -static SENSOR_DEVICE_ATTR_RW(fan6_alarm, fan_alarm, 5);
>> -static SENSOR_DEVICE_ATTR_RW(fan7_alarm, fan_alarm, 6);
>> -static SENSOR_DEVICE_ATTR_RW(fan8_alarm, fan_alarm, 7);
>> -
>> -static struct attribute *fts_fan_attrs[] = {
>> -	&sensor_dev_attr_fan1_input.dev_attr.attr,
>> -	&sensor_dev_attr_fan2_input.dev_attr.attr,
>> -	&sensor_dev_attr_fan3_input.dev_attr.attr,
>> -	&sensor_dev_attr_fan4_input.dev_attr.attr,
>> -	&sensor_dev_attr_fan5_input.dev_attr.attr,
>> -	&sensor_dev_attr_fan6_input.dev_attr.attr,
>> -	&sensor_dev_attr_fan7_input.dev_attr.attr,
>> -	&sensor_dev_attr_fan8_input.dev_attr.attr,
>> -
>> -	&sensor_dev_attr_fan1_source.dev_attr.attr,
>> -	&sensor_dev_attr_fan2_source.dev_attr.attr,
>> -	&sensor_dev_attr_fan3_source.dev_attr.attr,
>> -	&sensor_dev_attr_fan4_source.dev_attr.attr,
>> -	&sensor_dev_attr_fan5_source.dev_attr.attr,
>> -	&sensor_dev_attr_fan6_source.dev_attr.attr,
>> -	&sensor_dev_attr_fan7_source.dev_attr.attr,
>> -	&sensor_dev_attr_fan8_source.dev_attr.attr,
>> -
>> -	&sensor_dev_attr_fan1_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_fan2_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_fan3_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_fan4_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_fan5_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_fan6_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_fan7_alarm.dev_attr.attr,
>> -	&sensor_dev_attr_fan8_alarm.dev_attr.attr,
>> -	NULL
>> +static const struct hwmon_ops fts_ops = {
>> +	.is_visible = fts_is_visible,
>> +	.read = fts_read,
>> +	.write = fts_write,
>>   };
>>
>> -/* Voltages */
>> -static SENSOR_DEVICE_ATTR_RO(in1_input, in_value, 0);
>> -static SENSOR_DEVICE_ATTR_RO(in2_input, in_value, 1);
>> -static SENSOR_DEVICE_ATTR_RO(in3_input, in_value, 2);
>> -static SENSOR_DEVICE_ATTR_RO(in4_input, in_value, 3);
>> -static struct attribute *fts_voltage_attrs[] = {
>> -	&sensor_dev_attr_in1_input.dev_attr.attr,
>> -	&sensor_dev_attr_in2_input.dev_attr.attr,
>> -	&sensor_dev_attr_in3_input.dev_attr.attr,
>> -	&sensor_dev_attr_in4_input.dev_attr.attr,
>> +static const struct hwmon_channel_info *fts_info[] = {
>> +	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
>> +	HWMON_CHANNEL_INFO(temp,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT,
>> +			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT
>> +			   ),
>> +	HWMON_CHANNEL_INFO(fan,
>> +			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
>> +			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
>> +			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
>> +			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
>> +			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
>> +			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
>> +			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
>> +			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT
>> +			   ),
>> +	HWMON_CHANNEL_INFO(pwm,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP,
>> +			   HWMON_PWM_AUTO_CHANNELS_TEMP
>> +			   ),
>> +	HWMON_CHANNEL_INFO(in,
>> +			   HWMON_I_INPUT,
>> +			   HWMON_I_INPUT,
>> +			   HWMON_I_INPUT,
>> +			   HWMON_I_INPUT
>> +			   ),
>>   	NULL
>>   };
>>
>> -static const struct attribute_group fts_voltage_attr_group = {
>> -	.attrs = fts_voltage_attrs
>> -};
>> -
>> -static const struct attribute_group fts_temp_attr_group = {
>> -	.attrs = fts_temp_attrs
>> -};
>> -
>> -static const struct attribute_group fts_fan_attr_group = {
>> -	.attrs = fts_fan_attrs
>> -};
>> -
>> -static const struct attribute_group *fts_attr_groups[] = {
>> -	&fts_voltage_attr_group,
>> -	&fts_temp_attr_group,
>> -	&fts_fan_attr_group,
>> -	NULL
>> +static const struct hwmon_chip_info fts_chip_info = {
>> +	.ops = &fts_ops,
>> +	.info = fts_info,
>>   };
>>
>>   /*****************************************************************************/
>> @@ -800,10 +660,8 @@ static int fts_probe(struct i2c_client *client)
>>   		return err;
>>   	revision = err;
>>
>> -	hwmon_dev = devm_hwmon_device_register_with_groups(&client->dev,
>> -							   "ftsteutates",
>> -							   data,
>> -							   fts_attr_groups);
>> +	hwmon_dev = devm_hwmon_device_register_with_info(&client->dev, "ftsteutates", data,
>> +							 &fts_chip_info, NULL);
>>   	if (IS_ERR(hwmon_dev))
>>   		return PTR_ERR(hwmon_dev);
>>
>> --
>> 2.30.2
>>
