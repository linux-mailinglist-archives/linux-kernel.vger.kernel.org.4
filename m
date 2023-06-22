Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9667C73A787
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 19:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231398AbjFVRmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 13:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFVRmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 13:42:38 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3249210B;
        Thu, 22 Jun 2023 10:42:34 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-666e5f0d60bso3834778b3a.3;
        Thu, 22 Jun 2023 10:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687455754; x=1690047754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dRrHNZ0gdnZdM0ACOxO/3qNYCqOgGosk9ulwRrnUwmg=;
        b=YdAYHB6iE2/FQMNzHTTRLfWiiYQCVXgAQkMx87nn3QpMJQ3Bmu6EJsPOYMVod8DRM5
         Db+HiXDO0D3qfWWb9Sb5qasKMkdIS1ivksFSM164ck44/wC0513LGO8PX1TEaVdtICic
         HigbuDpRd6TnWi44cYNqX8V+rd8Q8HNmj0S50aXFEZHpS7BqZbC58ORClmNaTozC+axm
         tNTN2kZLYGSyyyyy+/CXLJc0wBZoDWk+OGLVI729gi62libgx0yPsyEiyUZOc50kEHUJ
         RV88sdX1E/8uEE6jKag1NsnVpBE5qPqXJZ+tr/2FrBhS+2faJMmAlDcRm7UVxY23W81y
         0RBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687455754; x=1690047754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRrHNZ0gdnZdM0ACOxO/3qNYCqOgGosk9ulwRrnUwmg=;
        b=LvQLTxWaUFWCjpnZmzrjspJndbsv8cbWjB1jn5qbMYuXz/cR/5wRGg+i0rZ9BtrT2f
         a9XBrQZK/MUGwCP7so/vPmpwUVvYnvVoXf4aKk96Gnpv6FGS8kbA23+Zac+Oy2T6ba3h
         4Ncdr2LdtGXP1kD2CC3Zq4raQJorgVcTgsSI5pZ4HdD9+6aXZvZIJpRemTmXQWoiMxWI
         xD2/s3HrJYnnR6XSSn4Xk3RYb7MhE5BPbEJcq0DhnkEoH4ToT9+3HYqnR+mLqZMrFS9U
         xcEoIbsWIhNumo/uRn5j+mlQMN5M766FFa5o0v1Dkmx5wAtYNyaGw6N/85NToe2WboQX
         pFDg==
X-Gm-Message-State: AC+VfDxv8os1nT/205WFpcTow4hgmBWhzDvbTiDU8Af/Vb/Z6D1Z4eCU
        bStIWZ+wVZOQzHAHWkPtGGw=
X-Google-Smtp-Source: ACHHUZ7meNymoDTHSbH8dmFmFen/E1ff7QFXhwW1Y7ld0rrWwUwuYeNjFbMZsDAX8CtJURMErLgm9g==
X-Received: by 2002:a05:6a20:4313:b0:11e:e940:441e with SMTP id h19-20020a056a20431300b0011ee940441emr14260284pzk.25.1687455754045;
        Thu, 22 Jun 2023 10:42:34 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i1-20020a170902c94100b001b1a2bf5274sm5723442pla.22.2023.06.22.10.42.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 10:42:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 22 Jun 2023 10:42:31 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wilken Gottwalt <wilken.gottwalt@posteo.net>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] hwmon: corsair-psu: add support for reading PWM
 values and mode
Message-ID: <0eeef6b2-9c9c-4b1a-8538-eb8ef5b1d628@roeck-us.net>
References: <ZJSASByXpzoZ0XyH@monster.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJSASByXpzoZ0XyH@monster.localdomain>
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

On Thu, Jun 22, 2023 at 05:09:28PM +0000, Wilken Gottwalt wrote:
> Also updates the documentation accordingly.
> 
> Signed-off-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
> ---
> Changes in v2:
>   - removed cleanup and typo fixes, sticking to feature adding only
> ---

Applied to hwmon-next.

Note: The patch description should describe what the patch does,
which isn't just "Also updates the documentation accordingly."
I'll fix that up, but please keep in mind for later.

Thanks,
Guenter

>  Documentation/hwmon/corsair-psu.rst |  2 +
>  drivers/hwmon/corsair-psu.c         | 62 ++++++++++++++++++++++++++++-
>  2 files changed, 63 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/corsair-psu.rst b/Documentation/hwmon/corsair-psu.rst
> index c389bd21f4f2..fc798c3df1d0 100644
> --- a/Documentation/hwmon/corsair-psu.rst
> +++ b/Documentation/hwmon/corsair-psu.rst
> @@ -69,6 +69,8 @@ power1_input		Total power usage
>  power2_input		Power usage of the 12v psu rail
>  power3_input		Power usage of the 5v psu rail
>  power4_input		Power usage of the 3.3v psu rail
> +pwm1			PWM value, read only
> +pwm1_enable		PWM mode, read only
>  temp1_input		Temperature of the psu vrm component
>  temp1_crit		Temperature max cirtical value of the psu vrm component
>  temp2_input		Temperature of the psu case
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index dc24c566d08b..2389f605ca16 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -58,7 +58,8 @@
>  #define OCP_MULTI_RAIL		0x02
>  
>  #define PSU_CMD_SELECT_RAIL	0x00 /* expects length 2 */
> -#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40 /* the rest of the commands expect length 3 */
> +#define PSU_CMD_FAN_PWM		0x3B /* the rest of the commands expect length 3 */
> +#define PSU_CMD_RAIL_VOLTS_HCRIT 0x40
>  #define PSU_CMD_RAIL_VOLTS_LCRIT 0x44
>  #define PSU_CMD_RAIL_AMPS_HCRIT	0x46
>  #define PSU_CMD_TEMP_HCRIT	0x4F
> @@ -76,6 +77,7 @@
>  #define PSU_CMD_UPTIME		0xD2
>  #define PSU_CMD_OCPMODE		0xD8
>  #define PSU_CMD_TOTAL_WATTS	0xEE
> +#define PSU_CMD_FAN_PWM_ENABLE	0xF0
>  #define PSU_CMD_INIT		0xFE
>  
>  #define L_IN_VOLTS		"v_in"
> @@ -145,6 +147,14 @@ static int corsairpsu_linear11_to_int(const u16 val, const int scale)
>  	return (exp >= 0) ? (result << exp) : (result >> -exp);
>  }
>  
> +/* the micro-controller uses percentage values to control pwm */
> +static int corsairpsu_dutycycle_to_pwm(const long dutycycle)
> +{
> +	const int result = (256 << 16) / 100;
> +
> +	return (result * dutycycle) >> 16;
> +}
> +
>  static int corsairpsu_usb_cmd(struct corsairpsu_data *priv, u8 p0, u8 p1, u8 p2, void *data)
>  {
>  	unsigned long time;
> @@ -264,6 +274,24 @@ static int corsairpsu_get_value(struct corsairpsu_data *priv, u8 cmd, u8 rail, l
>  	case PSU_CMD_FAN:
>  		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1);
>  		break;
> +	case PSU_CMD_FAN_PWM_ENABLE:
> +		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1);
> +		/*
> +		 * 0 = automatic mode, means the micro-controller controls the fan using a plan
> +		 *     which can be modified, but changing this plan is not supported by this
> +		 *     driver, the matching PWM mode is automatic fan speed control = PWM 2
> +		 * 1 = fixed mode, fan runs at a fixed speed represented by a percentage
> +		 *     value 0-100, this matches the PWM manual fan speed control = PWM 1
> +		 * technically there is no PWM no fan speed control mode, it would be a combination
> +		 * of 1 at 100%
> +		 */
> +		if (*val == 0)
> +			*val = 2;
> +		break;
> +	case PSU_CMD_FAN_PWM:
> +		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1);
> +		*val = corsairpsu_dutycycle_to_pwm(*val);
> +		break;
>  	case PSU_CMD_RAIL_WATTS:
>  	case PSU_CMD_TOTAL_WATTS:
>  		*val = corsairpsu_linear11_to_int(tmp & 0xFFFF, 1000000);
> @@ -349,6 +377,18 @@ static umode_t corsairpsu_hwmon_fan_is_visible(const struct corsairpsu_data *pri
>  	}
>  }
>  
> +static umode_t corsairpsu_hwmon_pwm_is_visible(const struct corsairpsu_data *priv, u32 attr,
> +					       int channel)
> +{
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +	case hwmon_pwm_enable:
> +		return 0444;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static umode_t corsairpsu_hwmon_power_is_visible(const struct corsairpsu_data *priv, u32 attr,
>  						 int channel)
>  {
> @@ -416,6 +456,8 @@ static umode_t corsairpsu_hwmon_ops_is_visible(const void *data, enum hwmon_sens
>  		return corsairpsu_hwmon_temp_is_visible(priv, attr, channel);
>  	case hwmon_fan:
>  		return corsairpsu_hwmon_fan_is_visible(priv, attr, channel);
> +	case hwmon_pwm:
> +		return corsairpsu_hwmon_pwm_is_visible(priv, attr, channel);
>  	case hwmon_power:
>  		return corsairpsu_hwmon_power_is_visible(priv, attr, channel);
>  	case hwmon_in:
> @@ -447,6 +489,20 @@ static int corsairpsu_hwmon_temp_read(struct corsairpsu_data *priv, u32 attr, in
>  	return err;
>  }
>  
> +static int corsairpsu_hwmon_pwm_read(struct corsairpsu_data *priv, u32 attr, int channel, long *val)
> +{
> +	switch (attr) {
> +	case hwmon_pwm_input:
> +		return corsairpsu_get_value(priv, PSU_CMD_FAN_PWM, 0, val);
> +	case hwmon_pwm_enable:
> +		return corsairpsu_get_value(priv, PSU_CMD_FAN_PWM_ENABLE, 0, val);
> +	default:
> +		break;
> +	}
> +
> +	return -EOPNOTSUPP;
> +}
> +
>  static int corsairpsu_hwmon_power_read(struct corsairpsu_data *priv, u32 attr, int channel,
>  				       long *val)
>  {
> @@ -531,6 +587,8 @@ static int corsairpsu_hwmon_ops_read(struct device *dev, enum hwmon_sensor_types
>  		if (attr == hwmon_fan_input)
>  			return corsairpsu_get_value(priv, PSU_CMD_FAN, 0, val);
>  		return -EOPNOTSUPP;
> +	case hwmon_pwm:
> +		return corsairpsu_hwmon_pwm_read(priv, attr, channel, val);
>  	case hwmon_power:
>  		return corsairpsu_hwmon_power_read(priv, attr, channel, val);
>  	case hwmon_in:
> @@ -579,6 +637,8 @@ static const struct hwmon_channel_info * const corsairpsu_info[] = {
>  			   HWMON_T_INPUT | HWMON_T_LABEL | HWMON_T_CRIT),
>  	HWMON_CHANNEL_INFO(fan,
>  			   HWMON_F_INPUT | HWMON_F_LABEL),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT | HWMON_PWM_ENABLE),
>  	HWMON_CHANNEL_INFO(power,
>  			   HWMON_P_INPUT | HWMON_P_LABEL,
>  			   HWMON_P_INPUT | HWMON_P_LABEL,
