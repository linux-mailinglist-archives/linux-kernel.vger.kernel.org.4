Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4696421E0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 04:31:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiLEDbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 22:31:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiLEDbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 22:31:34 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F42B4BB;
        Sun,  4 Dec 2022 19:31:32 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-144b21f5e5fso76048fac.12;
        Sun, 04 Dec 2022 19:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kt9rTCq74XQ0BlAV39rbwFD9WNXvrNglm/Bw4BzuItM=;
        b=PxNd9DbnMgYsfKAPoEssI0BSH+Cas/MLgqiykVmvyC04RQmU6bQMH7/cpRDsK6ypMq
         4VqEGwq/kibLI5USYO0aiIA8cTlM+e1QnSj6zIlfTqUsHvXGZKrwoAiVWiy7FIdsy/GQ
         pcwox0evs3EhE+z5ttv4KMT+BCgdMUc5a9TKt3tLzZxiPksvEm18ycJ3bIVP6WxaZWJK
         DPK7QC+l4bgNkfuMNqdQPkBa2ETIyNWoL9/iyuNuVNBI3nA6+qCiJ8ipZo6kStwclKfo
         H2Vr2/WdPKVMwHIDcXEacjgMsXR35UbK8IuWPA4tXi8XH6wHcx5aWCDY3X/Fgx6WG7GG
         axbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kt9rTCq74XQ0BlAV39rbwFD9WNXvrNglm/Bw4BzuItM=;
        b=0dx9IyA5bbuX6O/q2Ox470lW0XAsHCOK5yMZaqvkNloTKsgogeD0alrwwPS2HKuEe5
         0fAOiGRCNBPdy0rJ1U4ioAgSgGCvnsbB5Mq0nqUA9iL98q/kgXoIrX4EKk7yz83fifqK
         3IEMAEcOcTjMxAfxBdMVcgFc7+QqX9qlTp5vDtvkjjwcdtIrab85azvPFhXXHLUNKe6q
         41SPrc0FLwNm/mQ9wrbqpjNICQYhInD93FHCPePXLr/LpF40M8J81p2BnpmWOJWR5oWM
         AQYQQEHCDbV+9y8Ekxqt8srR3rH5fp0xq8vn/XV0v4U+ptqOVuwgiczhXd9TDS685LoD
         sWXA==
X-Gm-Message-State: ANoB5plruYlQhhELG3cGbhUWypP+LersFAWzfZCVPgpx3nVJl4TXSZVk
        8ACfxg24IVjU7oQDVYK9YA0=
X-Google-Smtp-Source: AA0mqf5tCZSOrT9BxYiY8esv2BV/XDiW6Rsw+5+SxdWjs6LxoyBgaKMauxt1su2afO9vp6CQGhyFVQ==
X-Received: by 2002:a05:6871:721:b0:144:5571:52d0 with SMTP id f33-20020a056871072100b00144557152d0mr4820434oap.288.1670211092011;
        Sun, 04 Dec 2022 19:31:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f9-20020a4ace89000000b0049fd6bfde95sm6168841oos.26.2022.12.04.19.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 19:31:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 4 Dec 2022 19:31:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     ye.xingchen@zte.com.cn
Cc:     jdelvare@suse.com, guillaume.ligneul@gmail.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: use sysfs_emit() to instead of scnprintf()
Message-ID: <20221205033130.GA1908070@roeck-us.net>
References: <202212011130317080061@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212011130317080061@zte.com.cn>
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

On Thu, Dec 01, 2022 at 11:30:31AM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Replace the open-code with sysfs_emit() to simplify the code.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Applied to hwmon-next.

Thanks,
Guenter

> ---
>  drivers/hwmon/ds1621.c |  2 +-
>  drivers/hwmon/lm73.c   |  6 +++---
>  drivers/hwmon/sht3x.c  | 12 ++++++------
>  3 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/ds1621.c b/drivers/hwmon/ds1621.c
> index 0886abf6ebab..e803d6393b9e 100644
> --- a/drivers/hwmon/ds1621.c
> +++ b/drivers/hwmon/ds1621.c
> @@ -269,7 +269,7 @@ static ssize_t update_interval_show(struct device *dev,
>  				    struct device_attribute *da, char *buf)
>  {
>  	struct ds1621_data *data = dev_get_drvdata(dev);
> -	return scnprintf(buf, PAGE_SIZE, "%hu\n", data->update_interval);
> +	return sysfs_emit(buf, "%hu\n", data->update_interval);
>  }
> 
>  static ssize_t update_interval_store(struct device *dev,
> diff --git a/drivers/hwmon/lm73.c b/drivers/hwmon/lm73.c
> index 1346b3b3f463..b6433ae2d75c 100644
> --- a/drivers/hwmon/lm73.c
> +++ b/drivers/hwmon/lm73.c
> @@ -92,7 +92,7 @@ static ssize_t temp_show(struct device *dev, struct device_attribute *da,
>  	/* use integer division instead of equivalent right shift to
>  	   guarantee arithmetic shift and preserve the sign */
>  	temp = (((s16) err) * 250) / 32;
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", temp);
> +	return sysfs_emit(buf, "%d\n", temp);
>  }
> 
>  static ssize_t convrate_store(struct device *dev, struct device_attribute *da,
> @@ -137,7 +137,7 @@ static ssize_t convrate_show(struct device *dev, struct device_attribute *da,
>  	int res;
> 
>  	res = (data->ctrl & LM73_CTRL_RES_MASK) >> LM73_CTRL_RES_SHIFT;
> -	return scnprintf(buf, PAGE_SIZE, "%hu\n", lm73_convrates[res]);
> +	return sysfs_emit(buf, "%hu\n", lm73_convrates[res]);
>  }
> 
>  static ssize_t maxmin_alarm_show(struct device *dev,
> @@ -154,7 +154,7 @@ static ssize_t maxmin_alarm_show(struct device *dev,
>  	data->ctrl = ctrl;
>  	mutex_unlock(&data->lock);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", (ctrl >> attr->index) & 1);
> +	return sysfs_emit(buf, "%d\n", (ctrl >> attr->index) & 1);
> 
>  abort:
>  	mutex_unlock(&data->lock);
> diff --git a/drivers/hwmon/sht3x.c b/drivers/hwmon/sht3x.c
> index 3f279aa1cee5..8305e44d9ab2 100644
> --- a/drivers/hwmon/sht3x.c
> +++ b/drivers/hwmon/sht3x.c
> @@ -320,7 +320,7 @@ static ssize_t temp1_limit_show(struct device *dev,
>  	u8 index = to_sensor_dev_attr(attr)->index;
>  	int temperature_limit = data->temperature_limits[index];
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", temperature_limit);
> +	return sysfs_emit(buf, "%d\n", temperature_limit);
>  }
> 
>  static ssize_t humidity1_limit_show(struct device *dev,
> @@ -331,7 +331,7 @@ static ssize_t humidity1_limit_show(struct device *dev,
>  	u8 index = to_sensor_dev_attr(attr)->index;
>  	u32 humidity_limit = data->humidity_limits[index];
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n", humidity_limit);
> +	return sysfs_emit(buf, "%u\n", humidity_limit);
>  }
> 
>  /*
> @@ -483,7 +483,7 @@ static ssize_t temp1_alarm_show(struct device *dev,
>  	if (ret)
>  		return ret;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(buffer[0] & 0x04));
> +	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x04));
>  }
> 
>  static ssize_t humidity1_alarm_show(struct device *dev,
> @@ -498,7 +498,7 @@ static ssize_t humidity1_alarm_show(struct device *dev,
>  	if (ret)
>  		return ret;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(buffer[0] & 0x08));
> +	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x08));
>  }
> 
>  static ssize_t heater_enable_show(struct device *dev,
> @@ -513,7 +513,7 @@ static ssize_t heater_enable_show(struct device *dev,
>  	if (ret)
>  		return ret;
> 
> -	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(buffer[0] & 0x20));
> +	return sysfs_emit(buf, "%d\n", !!(buffer[0] & 0x20));
>  }
> 
>  static ssize_t heater_enable_store(struct device *dev,
> @@ -550,7 +550,7 @@ static ssize_t update_interval_show(struct device *dev,
>  {
>  	struct sht3x_data *data = dev_get_drvdata(dev);
> 
> -	return scnprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  			 mode_to_update_interval[data->mode]);
>  }
