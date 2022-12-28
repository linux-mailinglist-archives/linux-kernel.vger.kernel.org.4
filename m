Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2B7657DC4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 16:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbiL1Pqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 10:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234039AbiL1Pq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 10:46:28 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 929A814080;
        Wed, 28 Dec 2022 07:46:23 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id r2-20020a9d7cc2000000b006718a7f7fbaso10041499otn.2;
        Wed, 28 Dec 2022 07:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOHEPs2ASaFaM4UuELaDCcG6NnUi5FD8VN5Ownoh3RY=;
        b=mJJfvF//ABlfwtF4GSM3KaxeMZHS/IKVutZepN8JVJCyp4yyKSgby6na59W4dJKF7c
         94cVVr84R5LftybAlum+/UuAlSk5big7dr8uIpqEW3UvedaL+6EyVeYcPx+mx4baT4Yy
         O2OwumS+zAbkDHf5WiyWTTKzy5RVluhowb0OJbl3vYCMBm8qVFmwfv7Hlc+7QJGnbNl7
         KFUM5/U+jPZDExUa4RLZz9csRtVuCfryNTbnYCg/B6pqDRFo/6yBT46psH8q7Mu+qs1F
         lwZz3eMQVLfPLk4SakyvxZh1yi5a3mhaW39pFq0KoDRemVSvQ/ejAVrYId2HPoisyudM
         ITAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOHEPs2ASaFaM4UuELaDCcG6NnUi5FD8VN5Ownoh3RY=;
        b=6yqjDIIQLBwLe88ssePIHK4YAWES3VoNgH5VdK1S5eUoaQqZ/G9D2y/gDGzEKALCXQ
         dmSYXVqMnD+WTlecrDUkCT1q19LLFhN5o7wl/3pvsBnnfUdf7IE8qXvcPTpX2yFowBq6
         Bv8c8T5K2IxnCXndVI/czGPGVoYowhKXk86ZsTh71Fb1wFshxGmhY9z8wwHQTrthq7GF
         DI1gUcUNdbZW6Y64nnwq+gFu33bo2E7zf0Qhi8Vkw5tehlRG37iWfh9hfBDeVDSxcBrp
         IN7LbbSi5qLXlk7Hsr3UgGvBRZFSS+UjfrY4QSDDaeYFz2Qg0w30wbFCM77wS2FuisZ5
         TmNg==
X-Gm-Message-State: AFqh2kpgYRCq3DcSbP2LPGLWNEw9/F7FK2n+gcMmXZ16J7zlRP22oTVE
        Tu8FzhaSrTuDf21ZKtQoab7wj8V7fig=
X-Google-Smtp-Source: AMrXdXuBnNYdEGvaSar8SjL6Z4+WIhij+cstkVYKv3lyO7fyLTALuftpLz9LXLg5hUVk0UkCL9OHhQ==
X-Received: by 2002:a9d:538c:0:b0:670:6cfe:385 with SMTP id w12-20020a9d538c000000b006706cfe0385mr11861071otg.23.1672242382801;
        Wed, 28 Dec 2022 07:46:22 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m12-20020a9d400c000000b0066e80774203sm8037876ote.43.2022.12.28.07.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 07:46:22 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 28 Dec 2022 07:46:20 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Derek J. Clark" <derekjohn.clark@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        =?iso-8859-1?Q?Joaqu=EDn_Ignacio_Aramend=EDa?= <samsagax@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (oxp-sensors) Add AYANEO AIR and AIR Pro
Message-ID: <20221228154620.GA3600958@roeck-us.net>
References: <20221213225511.77442-1-derekjohn.clark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221213225511.77442-1-derekjohn.clark@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 02:55:11PM -0800, Derek J. Clark wrote:
> Adds support for the AYANEO AIR and AYANEO AIR Pro models of handheld

s/Adds/Add/

> devices. These devices use the same EC registers and logic as the One X
> Player mini AMD. Previous AYANEO models are not supported as they use a
> different EC and do not have the necessary fan speed write enable and
> setting registers. Tested on Aya Neo AIR. AIR Pro model EC functionality
> and DMI data were verified using command line tools by another user.
> 
> The added devices are:
> - AYANEO AIR (AMD 5560U)
> - AYANEO AIR Pro (AMD 5560U)
> - AYANEO AIR Pro (AMD 5825U)
> 
> Signed-off-by: Derek J. Clark <derekjohn.clark@gmail.com>
> ---
>  Documentation/hwmon/oxp-sensors.rst | 17 +++++----
>  MAINTAINERS                         |  6 ++++
>  drivers/hwmon/oxp-sensors.c         | 54 ++++++++++++++++++++++++-----
>  3 files changed, 63 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 39c588ec5c50..b93892c892c5 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -3,18 +3,21 @@
>  Kernel driver oxp-sensors
>  =========================
>  
> -Author:
> +Authors:
> +    - Derek John Clark <derekjohn.clark@gmail.com>
>      - Joaquín Ignacio Aramendía <samsagax@gmail.com>
>  
>  Description:
>  ------------
>  
> -One X Player devices from One Netbook provide fan readings and fan control
> -through its Embedded Controller.
> +Handheld devices from One Netbook and Aya Neo provide fan readings and fan
> +control through their Embedded Controllers.
>  
> -Currently only supports AMD boards from the One X Player and AOK ZOE lineup.
> -Intel boards could be supported if we could figure out the EC registers and
> -values to write to since the EC layout and model is different.
> +Currently only supports AMD boards from One X Player, AOK ZOE, and some Aya
> +Neo devices. One X PLayer Intel boards could be supported if we could figure
> +out the EC registers and values to write to since the EC layout and model is
> +different. Aya Neo devices preceding the AIR may not be usable as the EC model
> +is different and do not appear to have manual control capabiltities.
>  
>  Supported devices
>  -----------------
> @@ -22,6 +25,8 @@ Supported devices
>  Currently the driver supports the following handhelds:
>  
>   - AOK ZOE A1
> + - Aya Neo AIR
> + - Aya Neo AIR Pro
>   - OneXPlayer AMD
>   - OneXPlayer mini AMD
>   - OneXPlayer mini AMD PRO
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90220659206c..ba03a2983045 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -15345,6 +15345,12 @@ S:	Maintained
>  F:	drivers/mtd/nand/onenand/
>  F:	include/linux/mtd/onenand*.h
>  
> +ONEXPLAYER FAN DRIVER
> +M:	Derek John Clark <derekjohn.clark@gmail.com>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/oxp-sensors.c
> +
This doesn't make sense. Why add another entry for the same driver ?
Add yourself as second maintianer, no problem with that, but don't
add a second entry for the same driver.

>  ONEXPLAYER FAN DRIVER
>  M:	Joaquín Ignacio Aramendía <samsagax@gmail.com>
>  L:	linux-hwmon@vger.kernel.org
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index f84ec8f8eda9..7adc0199ea66 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -1,12 +1,12 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * Platform driver for OXP Handhelds that expose fan reading and control
> - * via hwmon sysfs.
> + * Platform driver for Handhelds that expose fan reading and control via

That is too generic. It is not a driver which supports _all_ handhelds.

> + * hwmon sysfs.
>   *
> - * Old boards have the same DMI strings and they are told appart by the
> - * boot cpu vendor (Intel/AMD). Currently only AMD boards are supported
> - * but the code is made to be simple to add other handheld boards in the
> - * future.
> + * Old OXP boards have the same DMI strings and they are told appart by
> + * the boot cpu vendor (Intel/AMD). Currently only AMD boards are
> + * supported but the code is made to be simple to add other handheld
> + * boards in the future.
>   * Fan control is provided via pwm interface in the range [0-255].
>   * Old AMD boards use [0-100] as range in the EC, the written value is
>   * scaled to accommodate for that. Newer boards like the mini PRO and
> @@ -42,6 +42,8 @@ static bool unlock_global_acpi_lock(void)
>  
>  enum oxp_board {
>  	aok_zoe_a1 = 1,
> +	aya_neo_air,
> +	aya_neo_air_pro,
>  	oxp_mini_amd,
>  	oxp_mini_amd_pro,
>  };
> @@ -60,6 +62,20 @@ static const struct dmi_system_id dmi_table[] = {
>  		},
>  		.driver_data = (void *) &(enum oxp_board) {aok_zoe_a1},
>  	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR"),
> +		},
> +		.driver_data = (void *) &(enum oxp_board) {aya_neo_air},
> +	},
> +	{
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "AYANEO"),
> +			DMI_EXACT_MATCH(DMI_BOARD_NAME, "AIR Pro"),
> +		},
> +		.driver_data = (void *) &(enum oxp_board) {aya_neo_air_pro},
> +	},
>  	{
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
> @@ -161,8 +177,19 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>  			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
>  			if (ret)
>  				return ret;
> -			if (board == oxp_mini_amd)
> +			switch (board) {
> +			case aok_zoe_a1:
> +				break;
> +			case aya_neo_air:
> +			case aya_neo_air_pro:
> +			case oxp_mini_amd:
>  				*val = (*val * 255) / 100;
> +				break;
> +			case oxp_mini_amd_pro:
> +				break;
> +			default:
> +				break;

case statements doing nothing can be bundled.

> +			}
>  			return 0;
>  		case hwmon_pwm_enable:
>  			return read_from_ec(OXP_SENSOR_PWM_ENABLE_REG, 1, val);
> @@ -191,8 +218,19 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>  		case hwmon_pwm_input:
>  			if (val < 0 || val > 255)
>  				return -EINVAL;
> -			if (board == oxp_mini_amd)
> +			switch (board) {
> +			case aok_zoe_a1:
> +				break;
> +			case aya_neo_air:
> +			case aya_neo_air_pro:
> +			case oxp_mini_amd:
>  				val = (val * 100) / 255;
> +				break;
> +			case oxp_mini_amd_pro:
> +				break;
> +			default:
> +				break;

Same as above.

> +			}
>  			return write_to_ec(dev, OXP_SENSOR_PWM_REG, val);
>  		default:
>  			break;
