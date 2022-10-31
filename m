Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F72613BF3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiJaRLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbiJaRK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:10:57 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAA12D19;
        Mon, 31 Oct 2022 10:10:56 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6884DE0002;
        Mon, 31 Oct 2022 17:10:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1667236254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FgnIkLL5dyFKRnBzwzNF+5kYDu1pg2dCQ9DQnUjuYL4=;
        b=cXyxrAcSoiJ34UrklxH5AJJxY81WhU8qyP2wx5SzdmiuLch2GUoc/VeVOvoWD3YQEY05Kp
        ww8cyHVWfY6/Rcezc0b2S3pG/KqAXzXCT8mbfjdAU6rur2FQIOrltmN0OE4MWdltKaXKn/
        FJl6p2eAd0V6Q6MV4WgJRJ3i314uwWkP/6IsDVItdbkhdutWyct/8OFlhs99FnildXFdQs
        1q8thvMmx0WmxcQnk6RuYfKfFw9rcjI4IklTFSfDkw4eWycR+1Soyi6OsBBo1z9FxxPKwC
        FS6LSQZ+IDu0RLRf6kALr8/WVOd2jbvwZ04V7S6ylU5txsGGGYLlDByuLl0zew==
Date:   Mon, 31 Oct 2022 18:10:53 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>, linux-rtc@vger.kernel.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] rtc: cros-ec: Limit RTC alarm range if needed
Message-ID: <Y2ABnbBGSJGM3gSS@mail.local>
References: <20221029005400.2712577-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221029005400.2712577-1-linux@roeck-us.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On 28/10/2022 17:54:00-0700, Guenter Roeck wrote:
> RTC chips on some older Chromebooks can only handle alarms less than 24
> hours in the future. Attempts to set an alarm beyond that range fails.
> The most severe impact of this limitation is that suspend requests fail
> if alarmtimer_suspend() tries to set an alarm for more than 24 hours
> in the future.
> 
> Try to set the real-time alarm to just below 24 hours if setting it to
> a larger value fails to work around the problem. While not perfect, it
> is better than just failing the call. A similar workaround is already
> implemented in the rtc-tps6586x driver.

I'm not super convinced this is actually better than failing the call
because your are implementing policy in the driver which is bad from a
user point of view. It would be way better to return -ERANGE and let
userspace select a better alarm time.
Do you have to know in advance which are the "older" chromebooks that
are affected?

> 
> Drop error messages in cros_ec_rtc_get() and cros_ec_rtc_set() since the
> calling code also logs an error and to avoid spurious error messages if
> setting the alarm ultimately succeeds.
> 
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/rtc/rtc-cros-ec.c | 35 ++++++++++++++++++++---------------
>  1 file changed, 20 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/rtc/rtc-cros-ec.c b/drivers/rtc/rtc-cros-ec.c
> index 887f5193e253..a3ec066d8066 100644
> --- a/drivers/rtc/rtc-cros-ec.c
> +++ b/drivers/rtc/rtc-cros-ec.c
> @@ -14,6 +14,8 @@
>  
>  #define DRV_NAME	"cros-ec-rtc"
>  
> +#define SECS_PER_DAY	(24 * 60 * 60)
> +
>  /**
>   * struct cros_ec_rtc - Driver data for EC RTC
>   *
> @@ -43,13 +45,8 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
>  	msg.msg.insize = sizeof(msg.data);
>  
>  	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
> -	if (ret < 0) {
> -		dev_err(cros_ec->dev,
> -			"error getting %s from EC: %d\n",
> -			command == EC_CMD_RTC_GET_VALUE ? "time" : "alarm",
> -			ret);
> +	if (ret < 0)
>  		return ret;
> -	}
>  
>  	*response = msg.data.time;
>  
> @@ -59,7 +56,7 @@ static int cros_ec_rtc_get(struct cros_ec_device *cros_ec, u32 command,
>  static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
>  			   u32 param)
>  {
> -	int ret = 0;
> +	int ret;
>  	struct {
>  		struct cros_ec_command msg;
>  		struct ec_response_rtc data;
> @@ -71,13 +68,8 @@ static int cros_ec_rtc_set(struct cros_ec_device *cros_ec, u32 command,
>  	msg.data.time = param;
>  
>  	ret = cros_ec_cmd_xfer_status(cros_ec, &msg.msg);
> -	if (ret < 0) {
> -		dev_err(cros_ec->dev, "error setting %s on EC: %d\n",
> -			command == EC_CMD_RTC_SET_VALUE ? "time" : "alarm",
> -			ret);
> +	if (ret < 0)
>  		return ret;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -190,8 +182,21 @@ static int cros_ec_rtc_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
>  
>  	ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM, alarm_offset);
>  	if (ret < 0) {
> -		dev_err(dev, "error setting alarm: %d\n", ret);
> -		return ret;
> +		if (ret == -EINVAL && alarm_offset >= SECS_PER_DAY) {
> +			/*
> +			 * RTC chips on some older Chromebooks can only handle
> +			 * alarms up to 24h in the future. Try to set an alarm
> +			 * below that limit to avoid suspend failures.
> +			 */
> +			ret = cros_ec_rtc_set(cros_ec, EC_CMD_RTC_SET_ALARM,
> +					      SECS_PER_DAY - 1);
> +		}
> +
> +		if (ret < 0) {
> +			dev_err(dev, "error setting alarm in %u seconds: %d\n",
> +				alarm_offset, ret);
> +			return ret;
> +		}
>  	}
>  
>  	return 0;
> -- 
> 2.36.2
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
