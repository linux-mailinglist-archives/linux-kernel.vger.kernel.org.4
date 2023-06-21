Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15545738959
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233122AbjFUPeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 11:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjFUPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 11:33:59 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B8310F1;
        Wed, 21 Jun 2023 08:33:56 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668730696a4so2249007b3a.1;
        Wed, 21 Jun 2023 08:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687361636; x=1689953636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mYvkPhnApBEhP7OfX+actzCs4+6n+d0feuoR4H/35oA=;
        b=Zpw4W086uA6clMZfxzb9gGyEFY69SqQF2jSbhYTif5OncqnPMgP8Llk2Q2zw5y9ybn
         Ti+1+cnBhWbICOY5mbmbLcXjSbyr12Y8Ot+4Z/nQ/Lm+wtBDS3H9ZZYrKQ7Xncxcesf2
         OoWrH01FaN9nke6+VGm4BQS2Je5cSww9KZ3WaZBav36MdHyl9anFsl8e7Ngrzrfzvh7w
         oyw5NsT3A4/iIz9EwGrlFOWb5mUot1wXY4hdU64FM59mrzh/5Frt70sHrqTY6O854z/1
         HYKQMGzAqTbz5HATuW7AiUCtf2Kph7ZbnuFDqhGPInZi1gj5j8vYmdNNEwkbnCmjq9Be
         CTYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687361636; x=1689953636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mYvkPhnApBEhP7OfX+actzCs4+6n+d0feuoR4H/35oA=;
        b=fYsfEBV7Mz46S4DTBXdIkTTW3h2hizrxvj6Z4MCGZckeA/rD22tNwxt1BHhAm2c9gq
         bOK/faklifk/nnpZYPNPdCaxZPJ2zSRzFWptTOjz8ai37u0EVLW50XRxGL5HEpoAf+Kc
         7NlX3sON6WCIeoaYBopytV6XNW9Z/V3nvMd4kK0nVKM+MmMjGBrkg51EQC5awgVWOmYE
         8I0p8YKX8UZ1675+SaLMh4fEtbO4FDKMoywUhwIcwWRTpQEQ0in4QIq7Xqw/1d+lLIiS
         ov1uLAdeMPxEvVWcBJcMXEPqwba+b8j/vZcR2XTNguXyy8gG6tW5koLCqEaS1wOfurst
         +RSw==
X-Gm-Message-State: AC+VfDzRGv6QOK6RnJsrpaUOOJ7Htl+a50SfhHeM0hyIwwuMt8U+p87F
        Wbvr8f8PmXmf3sP9lCI78fE=
X-Google-Smtp-Source: ACHHUZ4LuamC39/n7FqkNYlJU0zdUA3M4wtwIs5WcISxKhBCj36LNrzOehI099i+Rnm+ldMOD3Zk1w==
X-Received: by 2002:a05:6a20:72ac:b0:10a:c09c:bd with SMTP id o44-20020a056a2072ac00b0010ac09c00bdmr11339131pzk.55.1687361635437;
        Wed, 21 Jun 2023 08:33:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k24-20020aa792d8000000b0064f76992905sm3034572pfa.202.2023.06.21.08.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 08:33:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 21 Jun 2023 08:33:52 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     JuenKit Yip <JuenKit_Yip@hotmail.com>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] hwmon: (sht3x) convert some of sysfs interface
 to hwmon
Message-ID: <7ececfd7-efff-4fa4-b4b7-05acf4bc4b26@roeck-us.net>
References: <DB4PR10MB6261A846EADE1C40A340E2C7925DA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB4PR10MB6261A846EADE1C40A340E2C7925DA@DB4PR10MB6261.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:59:36AM +0800, JuenKit Yip wrote:
> update_interval, temperature/humidity max/min and hyst
> were moved to new hwmon interface, and only heater and
> repeatability were reserved as non-stardard sysfs interface.
> 
> Signed-off-by: JuenKit Yip <JuenKit_Yip@hotmail.com>
> ---
>  drivers/hwmon/sht3x.c | 351 ++++++++++++++++++++++++++++--------------
>  1 file changed, 239 insertions(+), 112 deletions(-)
> 
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index bf1863061..31013b5b6 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -147,6 +147,37 @@ static const u16 mode_to_update_interval[] = {
>  	 100,
>  };
>  
> +static const struct hwmon_channel_info * const sht3x_channel_info[] = {
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT | HWMON_T_MIN |
> +				HWMON_T_MIN_HYST | HWMON_T_MAX |
> +				HWMON_T_MAX_HYST | HWMON_T_ALARM),
> +	HWMON_CHANNEL_INFO(humidity, HWMON_H_INPUT | HWMON_H_MIN |
> +				HWMON_H_MIN_HYST | HWMON_H_MAX |
> +				HWMON_H_MAX_HYST | HWMON_H_ALARM),
> +	NULL,
> +};
> +
> +static const struct i2c_device_id sht3x_ids[];
> +
> +static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
> +				u32 attr, int channel);
> +static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
> +		      u32 attr, int channel, long *val);
> +static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long val);
> +

No forward declarations, please.

> +static const struct hwmon_ops sht3x_ops = {
> +	.is_visible = sht3x_is_visible,
> +	.read = sht3x_read,
> +	.write = sht3x_write,
> +};
> +
> +static const struct hwmon_chip_info sht3x_chip_info = {
> +	.ops = &sht3x_ops,
> +	.info = sht3x_channel_info,
> +};
> +
>  struct sht3x_data {
>  	struct i2c_client *client;
>  	struct mutex i2c_lock; /* lock for sending i2c commands */
> @@ -277,26 +308,24 @@ static struct sht3x_data *sht3x_update_client(struct device *dev)
>  }
>  
>  /* sysfs attributes */

Those are no longer sysfs attributes.

> -static ssize_t temp1_input_show(struct device *dev,
> -				struct device_attribute *attr, char *buf)
> +static int temp1_input_show(struct device *dev)

Drop _show from functions which no longer show anything.

>  {
>  	struct sht3x_data *data = sht3x_update_client(dev);
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  
> -	return sprintf(buf, "%d\n", data->temperature);
> +	return data->temperature;
>  }
>  
> -static ssize_t humidity1_input_show(struct device *dev,
> -				    struct device_attribute *attr, char *buf)
> +static int humidity1_input_show(struct device *dev)
>  {
>  	struct sht3x_data *data = sht3x_update_client(dev);
>  
>  	if (IS_ERR(data))
>  		return PTR_ERR(data);
>  
> -	return sprintf(buf, "%u\n", data->humidity);
> +	return data->humidity;
>  }
>  
>  /*
> @@ -332,33 +361,24 @@ static int limits_update(struct sht3x_data *data)
>  	return ret;
>  }
>  
> -static ssize_t temp1_limit_show(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> +static int temp1_limit_show(struct device *dev, int index)
>  {
>  	struct sht3x_data *data = dev_get_drvdata(dev);
> -	u8 index = to_sensor_dev_attr(attr)->index;
> -	int temperature_limit = data->temperature_limits[index];
>  
> -	return sysfs_emit(buf, "%d\n", temperature_limit);
> +	return data->temperature_limits[index];
>  }
>  
> -static ssize_t humidity1_limit_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> +static ssize_t humidity1_limit_show(struct device *dev, int index)

Return value is int.

>  {
>  	struct sht3x_data *data = dev_get_drvdata(dev);
> -	u8 index = to_sensor_dev_attr(attr)->index;
> -	u32 humidity_limit = data->humidity_limits[index];
>  
> -	return sysfs_emit(buf, "%u\n", humidity_limit);
> +	return data->humidity_limits[index];
>  }
>  
>  /*
>   * limit_store must only be called with data_lock held
>   */
>  static size_t limit_store(struct device *dev,

Drop _store from functions which are no longer sysfs store functions.
Also, again, return values are int. Note that "size_t" is wrong
in the current code; it should have been ssize_t since it can
return a negative value.

> -			  size_t count,
>  			  u8 index,
>  			  int temperature,
>  			  u32 humidity)
> @@ -400,50 +420,42 @@ static size_t limit_store(struct device *dev,
>  
>  	data->temperature_limits[index] = temperature;
>  	data->humidity_limits[index] = humidity;
> -	return count;
> +	return 0;
>  }
>  
> -static ssize_t temp1_limit_store(struct device *dev,
> -				 struct device_attribute *attr,
> -				 const char *buf,
> -				 size_t count)
> +static int temp1_limit_store(struct device *dev, int index, const char *val)
>  {
>  	int temperature;
>  	int ret;
>  	struct sht3x_data *data = dev_get_drvdata(dev);
> -	u8 index = to_sensor_dev_attr(attr)->index;
>  
> -	ret = kstrtoint(buf, 0, &temperature);
> +	ret = kstrtoint(val, 0, &temperature);
>  	if (ret)
>  		return ret;
>  
>  	temperature = clamp_val(temperature, SHT3X_MIN_TEMPERATURE,
>  				SHT3X_MAX_TEMPERATURE);
>  	mutex_lock(&data->data_lock);
> -	ret = limit_store(dev, count, index, temperature,
> +	ret = limit_store(dev, index, temperature,
>  			  data->humidity_limits[index]);
>  	mutex_unlock(&data->data_lock);
>  
> -	return ret;
> +	return 0;

Ignore errors from limit_store() ? why ?

>  }
>  
> -static ssize_t humidity1_limit_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t count)
> +static ssize_t humidity1_limit_store(struct device *dev, int index, const char *val)
>  {
>  	u32 humidity;
>  	int ret;
>  	struct sht3x_data *data = dev_get_drvdata(dev);
> -	u8 index = to_sensor_dev_attr(attr)->index;
>  
> -	ret = kstrtou32(buf, 0, &humidity);
> +	ret = kstrtou32(val, 0, &humidity);
>  	if (ret)
>  		return ret;
>  
>  	humidity = clamp_val(humidity, SHT3X_MIN_HUMIDITY, SHT3X_MAX_HUMIDITY);
>  	mutex_lock(&data->data_lock);
> -	ret = limit_store(dev, count, index, data->temperature_limits[index],
> +	ret = limit_store(dev, index, data->temperature_limits[index],
>  			  humidity);
>  	mutex_unlock(&data->data_lock);
>  
> @@ -474,7 +486,6 @@ static void sht3x_select_command(struct sht3x_data *data)
>  }
>  
>  static int status_register_read(struct device *dev,
> -				struct device_attribute *attr,
>  				char *buffer, int length)
>  {
>  	int ret;
> @@ -487,34 +498,30 @@ static int status_register_read(struct device *dev,
>  	return ret;
>  }
>  
> -static ssize_t temp1_alarm_show(struct device *dev,
> -				struct device_attribute *attr,
> -				char *buf)
> +static int temp1_alarm_show(struct device *dev)
>  {
>  	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>  	int ret;
>  
> -	ret = status_register_read(dev, attr, buffer,
> +	ret = status_register_read(dev, buffer,
>  				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>  	if (ret)
>  		return ret;
>  
> -	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x04));
> +	return !!(buffer[0] & 0x04);
>  }
>  
> -static ssize_t humidity1_alarm_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> +static int humidity1_alarm_show(struct device *dev)
>  {
>  	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>  	int ret;
>  
> -	ret = status_register_read(dev, attr, buffer,
> +	ret = status_register_read(dev, buffer,
>  				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>  	if (ret)
>  		return ret;
>  
> -	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x08));
> +	return !!(buffer[0] & 0x08);
>  }
>  
>  static ssize_t heater_enable_show(struct device *dev,
> @@ -524,7 +531,7 @@ static ssize_t heater_enable_show(struct device *dev,
>  	char buffer[SHT3X_WORD_LEN + SHT3X_CRC8_LEN];
>  	int ret;
>  
> -	ret = status_register_read(dev, attr, buffer,
> +	ret = status_register_read(dev, buffer,
>  				   SHT3X_WORD_LEN + SHT3X_CRC8_LEN);
>  	if (ret)
>  		return ret;
> @@ -560,20 +567,14 @@ static ssize_t heater_enable_store(struct device *dev,
>  	return ret;
>  }
>  
> -static ssize_t update_interval_show(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> +static int update_interval_show(struct device *dev)
>  {
>  	struct sht3x_data *data = dev_get_drvdata(dev);
>  
> -	return sysfs_emit(buf, "%u\n",
> -			 mode_to_update_interval[data->mode]);
> +	return mode_to_update_interval[data->mode];
>  }
>  
> -static ssize_t update_interval_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf,
> -				     size_t count)
> +static int update_interval_store(struct device *dev, const char *val)
>  {
>  	u16 update_interval;
>  	u8 mode;
> @@ -582,7 +583,7 @@ static ssize_t update_interval_store(struct device *dev,
>  	struct sht3x_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  
> -	ret = kstrtou16(buf, 0, &update_interval);
> +	ret = kstrtou16(val, 0, &update_interval);
>  	if (ret)
>  		return ret;
>  
> @@ -592,7 +593,7 @@ static ssize_t update_interval_store(struct device *dev,
>  	/* mode did not change */
>  	if (mode == data->mode) {
>  		mutex_unlock(&data->data_lock);
> -		return count;
> +		return 0;
>  	}
>  
>  	mutex_lock(&data->i2c_lock);
> @@ -634,7 +635,7 @@ static ssize_t update_interval_store(struct device *dev,
>  	if (ret != SHT3X_CMD_LENGTH)
>  		return ret < 0 ? ret : -EIO;
>  
> -	return count;
> +	return 0;
>  }
>  
>  static ssize_t repeatability_show(struct device *dev,
> @@ -668,60 +669,191 @@ static ssize_t repeatability_store(struct device *dev,
>  	return count;
>  }
>  
> -static SENSOR_DEVICE_ATTR_RO(temp1_input, temp1_input, 0);
> -static SENSOR_DEVICE_ATTR_RO(humidity1_input, humidity1_input, 0);
> -static SENSOR_DEVICE_ATTR_RW(temp1_max, temp1_limit, limit_max);
> -static SENSOR_DEVICE_ATTR_RW(humidity1_max, humidity1_limit, limit_max);
> -static SENSOR_DEVICE_ATTR_RW(temp1_max_hyst, temp1_limit, limit_max_hyst);
> -static SENSOR_DEVICE_ATTR_RW(humidity1_max_hyst, humidity1_limit,
> -			     limit_max_hyst);
> -static SENSOR_DEVICE_ATTR_RW(temp1_min, temp1_limit, limit_min);
> -static SENSOR_DEVICE_ATTR_RW(humidity1_min, humidity1_limit, limit_min);
> -static SENSOR_DEVICE_ATTR_RW(temp1_min_hyst, temp1_limit, limit_min_hyst);
> -static SENSOR_DEVICE_ATTR_RW(humidity1_min_hyst, humidity1_limit,
> -			     limit_min_hyst);
> -static SENSOR_DEVICE_ATTR_RO(temp1_alarm, temp1_alarm, 0);
> -static SENSOR_DEVICE_ATTR_RO(humidity1_alarm, humidity1_alarm, 0);
>  static SENSOR_DEVICE_ATTR_RW(heater_enable, heater_enable, 0);
> -static SENSOR_DEVICE_ATTR_RW(update_interval, update_interval, 0);
>  static SENSOR_DEVICE_ATTR_RW(repeatability, repeatability, 0);
>  
>  static struct attribute *sht3x_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_max.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_max_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_min.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_min_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> -	&sensor_dev_attr_humidity1_alarm.dev_attr.attr,
>  	&sensor_dev_attr_heater_enable.dev_attr.attr,
> -	&sensor_dev_attr_update_interval.dev_attr.attr,
> -	&sensor_dev_attr_repeatability.dev_attr.attr,
> -	NULL
> -};
> -
> -static struct attribute *sts3x_attrs[] = {
> -	&sensor_dev_attr_temp1_input.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max.dev_attr.attr,
> -	&sensor_dev_attr_temp1_max_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min.dev_attr.attr,
> -	&sensor_dev_attr_temp1_min_hyst.dev_attr.attr,
> -	&sensor_dev_attr_temp1_alarm.dev_attr.attr,
> -	&sensor_dev_attr_heater_enable.dev_attr.attr,
> -	&sensor_dev_attr_update_interval.dev_attr.attr,
>  	&sensor_dev_attr_repeatability.dev_attr.attr,
>  	NULL
>  };
>  
>  ATTRIBUTE_GROUPS(sht3x);
> -ATTRIBUTE_GROUPS(sts3x);
>  
> -static const struct i2c_device_id sht3x_ids[];
> +static umode_t sht3x_is_visible(const void *data, enum hwmon_sensor_types type,
> +				u32 attr, int channel)
> +{
> +	const struct sht3x_data *chip_data = data;
> +	struct i2c_client *client = chip_data->client;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			return 0644;
> +		default:
> +			return -EINVAL;

			return 0;

> +		}
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +		case hwmon_temp_alarm:
> +			return 0444;
> +		case hwmon_temp_max:
> +		case hwmon_temp_max_hyst:
> +		case hwmon_temp_min:
> +		case hwmon_temp_min_hyst:
> +			return 0644;
> +		default:
> +			return -EINVAL;

			return 0;

> +		}
> +	case hwmon_humidity:
> +		if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
> +			return 0;
> +		switch (attr) {
> +		case hwmon_humidity_input:
> +		case hwmon_humidity_alarm:
> +			return 0444;
> +		case hwmon_humidity_max:
> +		case hwmon_humidity_max_hyst:
> +		case hwmon_humidity_min:
> +		case hwmon_humidity_min_hyst:
> +			return 0644;
> +		default:
> +			return -EINVAL;

			return 0;

> +		}
> +	default:
> +		return -EINVAL;

			returen 0;
> +	}
> +
> +	return -EINVAL;

	return 0;

Never gets here. FWIW, you might use break; above
instead of all those return 0; statements.

> +}
> +
> +static int sht3x_read(struct device *dev, enum hwmon_sensor_types type,
> +		      u32 attr, int channel, long *val)
> +{
> +	enum sht3x_limits index;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			*val = update_interval_show(dev);
> +			break;
> +		default:
> +			return -EINVAL;

				-EOPNOTSUPP
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			*val = temp1_input_show(dev);
> +			return 0;
> +		case hwmon_temp_alarm:
> +			*val = temp1_alarm_show(dev);
> +			return 0;
> +		case hwmon_temp_max:
> +			index = limit_max;
> +			break;
> +		case hwmon_temp_max_hyst:
> +			index = limit_max_hyst;
> +			break;
> +		case hwmon_temp_min:
> +			index = limit_min;
> +			break;
> +		case hwmon_temp_min_hyst:
> +			index = limit_min_hyst;
> +			break;
> +		default:
> +			return -EINVAL;

			-EOPNOTSUPP
> +		}
> +		*val = temp1_limit_show(dev, index);
> +		return 0;

Please be consistent. Either always return 0 in case statements or use break,
but do not mix the two.

> +	case hwmon_humidity:
> +		switch (attr) {
> +		case hwmon_humidity_input:
> +			*val = humidity1_input_show(dev);
> +			return 0;
> +		case hwmon_humidity_alarm:
> +			*val = humidity1_alarm_show(dev);
> +			return 0;
> +		case hwmon_humidity_max:
> +			index = limit_max;
> +			break;
> +		case hwmon_humidity_max_hyst:
> +			index = limit_max_hyst;
> +			break;
> +		case hwmon_humidity_min:
> +			index = limit_min;
> +			break;
> +		case hwmon_humidity_min_hyst:
> +			index = limit_min_hyst;
> +			break;
> +		default:
> +			return -EINVAL;
			-EOPNOTSUPP
> +		}
> +		*val = humidity1_limit_show(dev, index);
> +		return 0;
> +	default:
> +		return -EINVAL;

		-EOPNOTSUPP
> +	}
> +
> +	return 0;
> +}
> +
> +static int sht3x_write(struct device *dev, enum hwmon_sensor_types type,
> +		       u32 attr, int channel, long val)
> +{
> +	enum sht3x_limits index;
> +
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			return update_interval_store(dev, (const char *)&val);
> +		default:
> +			return -EINVAL;

			-EOPNOTSUPP
> +		}
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_max:
> +			index = limit_max;
> +			break;
> +		case hwmon_temp_max_hyst:
> +			index = limit_max_hyst;
> +			break;
> +		case hwmon_temp_min:
> +			index = limit_min;
> +			break;
> +		case hwmon_temp_min_hyst:
> +			index = limit_min_hyst;
> +			break;
> +		default:
> +			return -EINVAL;

			-EOPNOTSUPP

> +		}
> +		return temp1_limit_store(dev, index, (const char *)&val);
> +	case hwmon_humidity:
> +		switch (attr) {
> +		case hwmon_humidity_max:
> +			index = limit_max;
> +			break;
> +		case hwmon_humidity_max_hyst:
> +			index = limit_max_hyst;
> +			break;
> +		case hwmon_humidity_min:
> +			index = limit_min;
> +			break;
> +		case hwmon_humidity_min_hyst:
> +			index = limit_min_hyst;
> +			break;
> +		default:
> +			return -EINVAL;
			-EOPNOTSUPP
> +		}
> +		return humidity1_limit_store(dev, index, (const char *)val);
> +	default:
> +		return -EINVAL;
			-EOPNOTSUPP
> +	}
> +}
>  
>  static int sht3x_probe(struct i2c_client *client)
>  {
> @@ -730,7 +862,6 @@ static int sht3x_probe(struct i2c_client *client)
>  	struct device *hwmon_dev;
>  	struct i2c_adapter *adap = client->adapter;
>  	struct device *dev = &client->dev;
> -	const struct attribute_group **attribute_groups;
>  
>  	/*
>  	 * we require full i2c support since the sht3x uses multi-byte read and
> @@ -771,15 +902,11 @@ static int sht3x_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
>  
> -	if (i2c_match_id(sht3x_ids, client)->driver_data == sts3x)
> -		attribute_groups = sts3x_groups;
> -	else
> -		attribute_groups = sht3x_groups;
> -
> -	hwmon_dev = devm_hwmon_device_register_with_groups(dev,
> -							   client->name,
> -							   data,
> -							   attribute_groups);
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +							 client->name,
> +							 data,
> +							 &sht3x_chip_info,
> +							 sht3x_groups);

Shouldn't sht3x_groups only be added if the chip is sts3x ?

>  
>  	if (IS_ERR(hwmon_dev))
>  		dev_dbg(dev, "unable to register hwmon device\n");
> -- 
> 2.30.2
> 
