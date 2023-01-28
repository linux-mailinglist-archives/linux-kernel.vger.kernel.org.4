Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA28567F7ED
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 14:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjA1NN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 08:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjA1NNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 08:13:25 -0500
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6514E9038;
        Sat, 28 Jan 2023 05:13:23 -0800 (PST)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-15b9c93848dso9941356fac.1;
        Sat, 28 Jan 2023 05:13:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BWubGOw7QBjF8YdSc1/ZZp3WUWMpDjO6sFvplfMEm9k=;
        b=XNkYIJMN4OhgEf9hMGRelmYieIBO+69zciaVr4owZzo/3htvDI5nZ9keOzrz3Jw1ix
         5RIN7Dal4NYWjniYzXp4I5hzbHWTY1CsbzXtH1D2bCCswGbDEmX1vlo/K/PwP/8g2Z2c
         pzerHIbfGDS5tHaATTEkZCmlrPFOeAuGQ+XnzD4kWfkCBc7hhLrQpqnM3Qa4VuGe1TRE
         ItN2nqqlkjzFS7Au/d2xYgriK2L24oUHpSWV6Me+xj1C0Mj8kyj3iIKtuQcdv1AMDa4D
         Nm9UmktsQh0VyPAAZSXby2Ny0YfinsIzu9VxnJ9u/7j1l3UwM1/R8SHwzWZ+54u7Pti8
         /aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BWubGOw7QBjF8YdSc1/ZZp3WUWMpDjO6sFvplfMEm9k=;
        b=OYhoI5gUcPplhUfaaFKOrAsopBf9o15qiBKhuZ2kS2H+MEUpQsnKfrttU/PMwldJ6v
         R9yGjn8nIp35B4ky1EPt1nN3vE4trCvjdWYQzuq1IgfbnHuTDKqK+yJgwurRk+xmoWI+
         SuyJZIKE3dByfNsjZuc5xDcSbZHNU2aaY8dQnE9z3vBABD+7l6Vd11gPfsAeuzHWK3mG
         EWo9VBSkKTkY47ff9HHj1JVd2W90R6XR6ZNCvzFGoFyfkKykcp3ZE0CjE5DLn5biFb5p
         lFswIyTJ2vvWjlTGWHySXI9+sfv1srigUZCO9NvdJ4Ow2Lr01g/Be8BQWU4d6jzo5WRK
         7x3A==
X-Gm-Message-State: AO0yUKUtVZx8JeMXoovlyUdf88nhK8qUIslx6voryZMoQESzfi/YWiWo
        6tnlv4jZj/YsSXLK8jYQTElCp8TohO4=
X-Google-Smtp-Source: AK7set9xqIHpprZ5w04lHrD0r+/pLFksX4VsNK2whk1AdLIzfQqlyMkhrZjv2n9uJZ5+nc+2Nt1vkQ==
X-Received: by 2002:a05:6870:5689:b0:163:88f9:2c56 with SMTP id p9-20020a056870568900b0016388f92c56mr1803757oao.13.1674911601909;
        Sat, 28 Jan 2023 05:13:21 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id qk5-20020a056870cd0500b0013b92b3ac64sm3117424oab.3.2023.01.28.05.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 05:13:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 28 Jan 2023 05:13:19 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Kees Cook <keescook@chromium.org>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] lm85: Bounds check to_sensor_dev_attr()->index usage
Message-ID: <20230128131319.GA4173006@roeck-us.net>
References: <20230127223744.never.113-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127223744.never.113-kees@kernel.org>
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

On Fri, Jan 27, 2023 at 02:37:45PM -0800, Kees Cook wrote:
> The index into various register arrays was not bounds checked. Add
> checking. Seen under GCC 13:
> 
> drivers/hwmon/lm85.c: In function 'pwm_auto_pwm_minctl_store':
> drivers/hwmon/lm85.c:1110:26: warning: array subscript [0, 31] is outside array bounds of 'struct lm85_autofan[3]' [-Warray-bounds=]
>  1110 |         if (data->autofan[nr].min_off)
>       |             ~~~~~~~~~~~~~^~~~
> drivers/hwmon/lm85.c:317:29: note: while referencing 'autofan'
>   317 |         struct lm85_autofan autofan[3];
>       |                             ^~~~~~~
> 

This is a false positive. The value can never be >= 3.
It is derived from the last value of the following
SENSOR_DEVICE_ATTR_RW() entries.

I resist making changes like this to the code just because
the compiler can not determine the range of a variable.
It blows up code size amd makes it hard to read just to
make the compiler happy.

Guenter

> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  drivers/hwmon/lm85.c        | 221 +++++++++++++++++++++++++++---------
>  include/linux/hwmon-sysfs.h |   2 +-
>  2 files changed, 167 insertions(+), 56 deletions(-)
> 
> diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
> index 8d33c2484755..367a77660dda 100644
> --- a/drivers/hwmon/lm85.c
> +++ b/drivers/hwmon/lm85.c
> @@ -552,29 +552,40 @@ static struct lm85_data *lm85_update_device(struct device *dev)
>  static ssize_t fan_show(struct device *dev, struct device_attribute *attr,
>  			char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->fan))
> +		val = FAN_FROM_REG(data->fan[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t fan_min_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", FAN_FROM_REG(data->fan_min[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->fan_min))
> +		val = FAN_FROM_REG(data->fan_min[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t fan_min_store(struct device *dev,
>  			     struct device_attribute *attr, const char *buf,
>  			     size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	unsigned long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->fan_min))
> +		return -EINVAL;
> +
>  	err = kstrtoul(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -683,20 +694,27 @@ static SENSOR_DEVICE_ATTR_RO(fan4_alarm, alarm, 13);
>  static ssize_t pwm_show(struct device *dev, struct device_attribute *attr,
>  			char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", PWM_FROM_REG(data->pwm[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->pwm))
> +		val = PWM_FROM_REG(data->pwm[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
>  			 const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	unsigned long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->pwm))
> +		return -EINVAL;
> +
>  	err = kstrtoul(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -711,11 +729,12 @@ static ssize_t pwm_store(struct device *dev, struct device_attribute *attr,
>  static ssize_t pwm_enable_show(struct device *dev,
>  			       struct device_attribute *attr, char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	int pwm_zone, enable;
> +	int pwm_zone = -1, enable;
>  
> -	pwm_zone = ZONE_FROM_REG(data->autofan[nr].config);
> +	if (nr < ARRAY_SIZE(data->autofan))
> +		pwm_zone = ZONE_FROM_REG(data->autofan[nr].config);
>  	switch (pwm_zone) {
>  	case -1:	/* PWM is always at 100% */
>  		enable = 0;
> @@ -734,13 +753,16 @@ static ssize_t pwm_enable_store(struct device *dev,
>  				struct device_attribute *attr,
>  				const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	u8 config;
>  	unsigned long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->autofan))
> +		return -EINVAL;
> +
>  	err = kstrtoul(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -777,10 +799,13 @@ static ssize_t pwm_enable_store(struct device *dev,
>  static ssize_t pwm_freq_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
>  	int freq;
>  
> +	if (nr >= ARRAY_SIZE(data->pwm_freq))
> +		return -EINVAL;
> +
>  	if (IS_ADT7468_HFPWM(data))
>  		freq = 22500;
>  	else
> @@ -794,12 +819,15 @@ static ssize_t pwm_freq_store(struct device *dev,
>  			      struct device_attribute *attr, const char *buf,
>  			      size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	unsigned long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->pwm_freq))
> +		return -EINVAL;
> +
>  	err = kstrtoul(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -843,10 +871,13 @@ static SENSOR_DEVICE_ATTR_RW(pwm3_freq, pwm_freq, 2);
>  static ssize_t in_show(struct device *dev, struct device_attribute *attr,
>  		       char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", INSEXT_FROM_REG(nr, data->in[nr],
> -						    data->in_ext[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->in))
> +		val = INSEXT_FROM_REG(nr, data->in[nr], data->in_ext[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t in_min_show(struct device *dev, struct device_attribute *attr,
> @@ -854,18 +885,25 @@ static ssize_t in_min_show(struct device *dev, struct device_attribute *attr,
>  {
>  	int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", INS_FROM_REG(nr, data->in_min[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->in_min))
> +		val = INS_FROM_REG(nr, data->in_min[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->in_min))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -880,20 +918,27 @@ static ssize_t in_min_store(struct device *dev, struct device_attribute *attr,
>  static ssize_t in_max_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", INS_FROM_REG(nr, data->in_max[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->in_max))
> +		val = INS_FROM_REG(nr, data->in_max[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t in_max_store(struct device *dev, struct device_attribute *attr,
>  			    const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->in_max))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -935,30 +980,40 @@ static SENSOR_DEVICE_ATTR_RW(in7_max, in_max, 7);
>  static ssize_t temp_show(struct device *dev, struct device_attribute *attr,
>  			 char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMPEXT_FROM_REG(data->temp[nr],
> -						     data->temp_ext[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->temp))
> +		val = TEMPEXT_FROM_REG(data->temp[nr], data->temp_ext[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t temp_min_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_min[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->temp_min))
> +		val = TEMP_FROM_REG(data->temp_min[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t temp_min_store(struct device *dev,
>  			      struct device_attribute *attr, const char *buf,
>  			      size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->temp_min))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -976,21 +1031,28 @@ static ssize_t temp_min_store(struct device *dev,
>  static ssize_t temp_max_show(struct device *dev,
>  			     struct device_attribute *attr, char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_max[nr]));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->temp_max))
> +		val = TEMP_FROM_REG(data->temp_max[nr]);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t temp_max_store(struct device *dev,
>  			      struct device_attribute *attr, const char *buf,
>  			      size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->temp_max))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -1021,21 +1083,28 @@ static ssize_t pwm_auto_channels_show(struct device *dev,
>  				      struct device_attribute *attr,
>  				      char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", ZONE_FROM_REG(data->autofan[nr].config));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->autofan))
> +		val = ZONE_FROM_REG(data->autofan[nr].config);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t pwm_auto_channels_store(struct device *dev,
>  				       struct device_attribute *attr,
>  				       const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->autofan))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -1052,21 +1121,28 @@ static ssize_t pwm_auto_channels_store(struct device *dev,
>  static ssize_t pwm_auto_pwm_min_show(struct device *dev,
>  				     struct device_attribute *attr, char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", PWM_FROM_REG(data->autofan[nr].min_pwm));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->autofan))
> +		val = PWM_FROM_REG(data->autofan[nr].min_pwm);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t pwm_auto_pwm_min_store(struct device *dev,
>  				      struct device_attribute *attr,
>  				      const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	unsigned long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->autofan))
> +		return -EINVAL;
> +
>  	err = kstrtoul(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -1083,22 +1159,29 @@ static ssize_t pwm_auto_pwm_minctl_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", data->autofan[nr].min_off);
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->autofan))
> +		val = data->autofan[nr].min_off;
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t pwm_auto_pwm_minctl_store(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	u8 tmp;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->autofan))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -1130,23 +1213,30 @@ static ssize_t temp_auto_temp_off_show(struct device *dev,
>  				       struct device_attribute *attr,
>  				       char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit) -
> -		HYST_FROM_REG(data->zone[nr].hyst));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->zone))
> +		val = TEMP_FROM_REG(data->zone[nr].limit) -
> +			HYST_FROM_REG(data->zone[nr].hyst);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t temp_auto_temp_off_store(struct device *dev,
>  					struct device_attribute *attr,
>  					const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	int min;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->zone))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -1170,21 +1260,28 @@ static ssize_t temp_auto_temp_min_show(struct device *dev,
>  				       struct device_attribute *attr,
>  				       char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->zone))
> +		val = TEMP_FROM_REG(data->zone[nr].limit);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t temp_auto_temp_min_store(struct device *dev,
>  					struct device_attribute *attr,
>  					const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->zone))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -1194,7 +1291,7 @@ static ssize_t temp_auto_temp_min_store(struct device *dev,
>  	lm85_write_value(client, LM85_REG_AFAN_LIMIT(nr),
>  		data->zone[nr].limit);
>  
> -/* Update temp_auto_max and temp_auto_range */
> +	/* Update temp_auto_max and temp_auto_range */
>  	data->zone[nr].range = RANGE_TO_REG(
>  		TEMP_FROM_REG(data->zone[nr].max_desired) -
>  		TEMP_FROM_REG(data->zone[nr].limit));
> @@ -1210,23 +1307,30 @@ static ssize_t temp_auto_temp_max_show(struct device *dev,
>  				       struct device_attribute *attr,
>  				       char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].limit) +
> -		RANGE_FROM_REG(data->zone[nr].range));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->zone))
> +		val = TEMP_FROM_REG(data->zone[nr].limit) +
> +			RANGE_FROM_REG(data->zone[nr].range);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t temp_auto_temp_max_store(struct device *dev,
>  					struct device_attribute *attr,
>  					const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	int min;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->zone))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> @@ -1247,21 +1351,28 @@ static ssize_t temp_auto_temp_crit_show(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = lm85_update_device(dev);
> -	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->zone[nr].critical));
> +	int val = 0;
> +
> +	if (nr < ARRAY_SIZE(data->zone))
> +		val = TEMP_FROM_REG(data->zone[nr].critical);
> +	return sprintf(buf, "%d\n", val);
>  }
>  
>  static ssize_t temp_auto_temp_crit_store(struct device *dev,
>  					 struct device_attribute *attr,
>  					 const char *buf, size_t count)
>  {
> -	int nr = to_sensor_dev_attr(attr)->index;
> +	unsigned int nr = to_sensor_dev_attr(attr)->index;
>  	struct lm85_data *data = dev_get_drvdata(dev);
>  	struct i2c_client *client = data->client;
>  	long val;
>  	int err;
>  
> +	if (nr >= ARRAY_SIZE(data->zone))
> +		return -EINVAL;
> +
>  	err = kstrtol(buf, 10, &val);
>  	if (err)
>  		return err;
> diff --git a/include/linux/hwmon-sysfs.h b/include/linux/hwmon-sysfs.h
> index d896713359cd..f0505d10bfad 100644
> --- a/include/linux/hwmon-sysfs.h
> +++ b/include/linux/hwmon-sysfs.h
> @@ -10,7 +10,7 @@
>  #include <linux/device.h>
>  #include <linux/kstrtox.h>
>  
> -struct sensor_device_attribute{
> +struct sensor_device_attribute {
>  	struct device_attribute dev_attr;
>  	int index;
>  };
> -- 
> 2.34.1
> 
