Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7899C710ED0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 16:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241619AbjEYOzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 10:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbjEYOzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 10:55:22 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47EAEE46;
        Thu, 25 May 2023 07:55:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64d41763796so1685581b3a.2;
        Thu, 25 May 2023 07:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685026503; x=1687618503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uCaM2JNFCtKG5zLxpZ+ZrdBUNdhIbQe9rDZZxWDTm0o=;
        b=K8dzj/739d/ujSJP/A+QCCehRe8WMoGL6YZ/RFRApwU2njBswmdQ68GpsKiWFJlS4p
         l4EuTJWzLb/ovPlhPsQOezkb9XBXaN+t+PTBPwtJRQMQAgttGbbCts9RP/JH1Q/R/H5c
         yLJrNb96iF68KWRUO7WiIQx9mHOJPJEAYOBy03kDZgRKuLdJNHycfPSNUKRO4/iqjXsK
         +jqeGqEAkUthC+4HIKOgA/5Zc8F4Nj+U1ZdvmUy0knc6RNmY7jjCq7ZlptD+4uEtPKOy
         t1sMWOw/Xr3OchE3CnO0oWHyAmAZ6ZNjmogXhZc+b5srcQHBmT3dn+VKbrbONMNe94x4
         kHXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685026503; x=1687618503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCaM2JNFCtKG5zLxpZ+ZrdBUNdhIbQe9rDZZxWDTm0o=;
        b=Oy736iXCcYaG81N7Ime61FDkkyh/4q4EjuVBEuaQalkt5AM9O1pgeZeJ+3Ob99FrhQ
         HHRTzFM+7Qm0UlT7u37hmGeKEWeczYB2aE/dacArLUz+Ht2xxjYo18sVVzSEnFv4X5L/
         UskWxoAzkQsUeYLFm7zTpBYZz75+wIX/utPrC/Zrm1WjTD6SrryaekgXxp0HROSnv5Cf
         rbwIN89fNLXij/71iFucIr6sXCAHNm/BeqGsffxZMgYHWDxiElVxBTUcUj9v3UsVAWkt
         S14GKsoKnUw0VMmubEVIm7GuZQdU9ebHTkpMFuJzcLSkthmdLFJ9V3EpC+K1RDJMnstz
         ZVhw==
X-Gm-Message-State: AC+VfDwKX9FpEyU7YVdzNB5hrUqc/lbiPz529mYQAa5QiVrIRhgTfuEf
        2fqsDdEENGQdoHgHV0LgNi1vJC6aPh4=
X-Google-Smtp-Source: ACHHUZ4Ppg17A0pRt1jPFoMnXPU0an4fxQCgenC3vL/eYaL8Aq4EA3DSPGcBmSK8GSo2M0MG1C988w==
X-Received: by 2002:a05:6a00:10c4:b0:63d:47ab:65ed with SMTP id d4-20020a056a0010c400b0063d47ab65edmr9759325pfu.7.1685026503471;
        Thu, 25 May 2023 07:55:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z13-20020aa791cd000000b006413e6e7578sm1314061pfa.5.2023.05.25.07.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 07:55:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 25 May 2023 07:55:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Stop passing device structure
Message-ID: <3ccbd2d9-42f1-4270-9835-29911855cc79@roeck-us.net>
References: <20230525142652.41981-1-samsagax@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230525142652.41981-1-samsagax@gmail.com>
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

On Thu, May 25, 2023 at 11:26:52AM -0300, Joaquín Ignacio Aramendía wrote:
> We don't need to pass device structure to write_to_ec() so we remove
> that from the function declaration.
> The same is valid for pwm_enable() and pwm_disable() as we were passing
> the pointer to hand it off to write_to_ec().
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/oxp-sensors.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index a4ee757f879f..0ec7588610ad 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -141,7 +141,7 @@ static int read_from_ec(u8 reg, int size, long *val)
>  	return 0;
>  }
>  
> -static int write_to_ec(const struct device *dev, u8 reg, u8 value)
> +static int write_to_ec(u8 reg, u8 value)
>  {
>  	int ret;
>  
> @@ -156,14 +156,14 @@ static int write_to_ec(const struct device *dev, u8 reg, u8 value)
>  	return ret;
>  }
>  
> -static int oxp_pwm_enable(const struct device *dev)
> +static int oxp_pwm_enable(void)
>  {
> -	return write_to_ec(dev, OXP_SENSOR_PWM_ENABLE_REG, 0x01);
> +	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
>  }
>  
> -static int oxp_pwm_disable(const struct device *dev)
> +static int oxp_pwm_disable(void)
>  {
> -	return write_to_ec(dev, OXP_SENSOR_PWM_ENABLE_REG, 0x00);
> +	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x00);
>  }
>  
>  /* Callbacks for hwmon interface */
> @@ -234,9 +234,9 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  		switch (attr) {
>  		case hwmon_pwm_enable:
>  			if (val == 1)
> -				return oxp_pwm_enable(dev);
> +				return oxp_pwm_enable();
>  			else if (val == 0)
> -				return oxp_pwm_disable(dev);
> +				return oxp_pwm_disable();
>  			return -EINVAL;
>  		case hwmon_pwm_input:
>  			if (val < 0 || val > 255)
> @@ -254,7 +254,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  			default:
>  				break;
>  			}
> -			return write_to_ec(dev, OXP_SENSOR_PWM_REG, val);
> +			return write_to_ec(OXP_SENSOR_PWM_REG, val);
>  		default:
>  			break;
>  		}
