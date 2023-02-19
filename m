Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E609869C104
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 15:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjBSOzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 09:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbjBSOze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 09:55:34 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361B7F765;
        Sun, 19 Feb 2023 06:55:33 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id r9so124099ill.5;
        Sun, 19 Feb 2023 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KwmK5KQzC8E3tWMkOZrrgOWxh7okCCfk9Y6DD4ae72M=;
        b=MEwQ2PjiCDvXOWgh1cnD2qSuLcV5xqTaPqMEZMdxsbaj2OnkYydQRXm1+8Yma3rQOM
         6ulmq1aGV8TJbsD10ecysR2GL2VmSOG3idEF9Kd+UPxFc9EUXIvaDQDppmMRpQWtJsnR
         reJN195ycfVXWnR9TH6vZHKKnRqpCVLOVaj+pbn/yoAE9HmLCrpAM98JF5twf4Q/tKdr
         8Y3ZKygj5+Id+/hzr+eVJfLiCTyoj7xzqDKIPxokVFLIFvh31FFMRwlXSIszoFWHcXPx
         C1tWmnu3lxC0GuuKA2wlU98czsS/jiBWV9B15UsYcei9UzCPlTMRfIYCw9Rot0Kd1W/E
         3CBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KwmK5KQzC8E3tWMkOZrrgOWxh7okCCfk9Y6DD4ae72M=;
        b=LKnpzGclHxEK6oFZAr2JY1wim12wON4bVlfheHAHWPOGyzQ22ChWkNUwLQCdvHQl0O
         L4rFwJCXHp1XFNRDntY4rXVStVgywrlG+9RRqf3xst3yO3kUHpn4xCRu934K6SVZN3re
         +pbF13571QQGk+ZZaUXSFcgGDRue5wZFPvlItM1tS6jqjz0DYZ85BIrY1MQEbGDY0+46
         8BLrukNWAbdojD4F2a9dVdMeNJUIr5YnGtqk4i6r9QpOq7rq/dCjWoQ84trMtfK5fp/B
         SwB5IqSQJ7QHIgBcouN7VFzCgQrN/YS6FjAPgu2lpr5/UdlXe2U0+NZZHG4+ivGsbY0t
         WPTw==
X-Gm-Message-State: AO0yUKVNuIe1CY0PDW5arl7WhHK3BWbmaM5TmAjWtIOndz1PBzeTC67o
        Hn/q5JK0FPBH8HtJCF0aZ6o=
X-Google-Smtp-Source: AK7set8CkRD1RCEAi28aea5UbeVNY5AkvbI+/3iVbT7oXM5yCvdPM8vlpzpRtQFnLWA5a5yrlT9akA==
X-Received: by 2002:a05:6e02:219b:b0:314:20e6:133c with SMTP id j27-20020a056e02219b00b0031420e6133cmr1939074ila.3.1676818532553;
        Sun, 19 Feb 2023 06:55:32 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t1-20020a92cc41000000b0031599ce31ccsm811482ilq.86.2023.02.19.06.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 06:55:31 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 19 Feb 2023 06:55:30 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        "open list:HARDWARE MONITORING" <linux-hwmon@vger.kernel.org>
Subject: Re: [PATCH v1 09/17] thermal: Add a thermal zone id accessor
Message-ID: <20230219145530.GA4084160@roeck-us.net>
References: <20230219143657.241542-1-daniel.lezcano@linaro.org>
 <20230219143657.241542-10-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230219143657.241542-10-daniel.lezcano@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 03:36:49PM +0100, Daniel Lezcano wrote:
> In order to get the thermal zone id but without directly accessing the
> thermal zone device structure, add an accessor.
> 
> Use the accessor from the hwmon_scmi
> 
> No functional change intented.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/scmi-hwmon.c     | 2 +-
>  drivers/thermal/thermal_core.c | 6 ++++++
>  include/linux/thermal.h        | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/scmi-hwmon.c b/drivers/hwmon/scmi-hwmon.c
> index 7951b6026f48..036b56a535c1 100644
> --- a/drivers/hwmon/scmi-hwmon.c
> +++ b/drivers/hwmon/scmi-hwmon.c
> @@ -220,7 +220,7 @@ static int scmi_thermal_sensor_register(struct device *dev,
>  			sensor->name);
>  	} else {
>  		dev_dbg(dev, "Sensor '%s' attached to thermal zone ID:%d\n",
> -			sensor->name, tzd->id);
> +			sensor->name, thermal_zone_device_get_id(tzd));
>  	}
>  
>  	return 0;
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index 05e5a6bda695..e06c76b38c04 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -1384,6 +1384,12 @@ void *thermal_zone_device_get_data(struct thermal_zone_device *tzd)
>  }
>  EXPORT_SYMBOL_GPL(thermal_zone_device_get_data);
>  
> +int thermal_zone_device_get_id(struct thermal_zone_device *tzd)
> +{
> +	return tzd->id;
> +}
> +EXPORT_SYMBOL_GPL(thermal_zone_device_get_id);
> +
>  /**
>   * thermal_zone_device_unregister - removes the registered thermal zone device
>   * @tz: the thermal zone device to remove
> diff --git a/include/linux/thermal.h b/include/linux/thermal.h
> index 724b95662da9..9e5c7f2f7b05 100644
> --- a/include/linux/thermal.h
> +++ b/include/linux/thermal.h
> @@ -367,6 +367,8 @@ thermal_zone_device_register_with_trips(const char *, struct thermal_trip *, int
>  
>  void *thermal_zone_device_get_data(struct thermal_zone_device *tzd);
>  
> +int thermal_zone_device_get_id(struct thermal_zone_device *tzd);
> +
>  int thermal_zone_bind_cooling_device(struct thermal_zone_device *, int,
>  				     struct thermal_cooling_device *,
>  				     unsigned long, unsigned long,
> -- 
> 2.34.1
> 
