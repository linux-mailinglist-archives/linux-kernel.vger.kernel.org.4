Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C9872AEEC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 23:08:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbjFJVIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 17:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFJVIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 17:08:14 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164A130F8;
        Sat, 10 Jun 2023 14:08:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b3c0c476d1so102195ad.1;
        Sat, 10 Jun 2023 14:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686431292; x=1689023292;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jNiRGMSuLNUcxaGgcH4VOovPdg8f2l42Oq+cMP6fQW4=;
        b=hIBbAlma7TEwmvU3Y1v7REMQbHvysCYceryUCZ+WkYsw4KyikYrw4IrCW8s+OyUipT
         WtXy1TnIrDYdMAmJphWv1w+3kzbL/IoPouDRQnCm7P/SV17WrJjc9tRJIAc+5Xe3w+Xt
         EygO9Cbmg3Qp3ey9/fPwtZylkE0eHXiTkKTbcRLKbMpyIljc7m+cZGFoie411Kwhhy9J
         BP5dyXFL9i1RmEr48JNBKN2koRohE+ALos4iOgn0jVK4SHPCzT8tqXMr/1+2VkWuqwTF
         QHwKPLPXoVFCyKyhdLEzqK9t/HZAK5re+fA1Am/lUgheA8nj5xfj3h4K40OFICw3o97r
         k/HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686431292; x=1689023292;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNiRGMSuLNUcxaGgcH4VOovPdg8f2l42Oq+cMP6fQW4=;
        b=TzWH5pjELu5hZUNmO/9XVSkv0bHlFhCFvozyekMqKjX2TnXflkAgc2xVvKhBzapRYf
         CIqQfwNaE8s+AVRVGe9jUBNw9Aux9pEJteIgtJcFl1Ays7erWqWqH/G8sHpSBtZJXfzg
         501+0Gya+SnGFNum8Bu9v+KPPK8WKtKHfmyp20s+7nfonUJymtk2zc7jNkAl7P9Basqv
         aqx1fCPt/uRcwFu3PmV8Vcniglh8caKA6pYpG3jthUyqF8fxMGx7WwUQih3mXwmP27Oz
         hVCPdIxkXl10x+52y1AW5VplgT1zREv0mdh1mbdNtxthshLSPIxYwfejLh/O0Nmltfwx
         glXA==
X-Gm-Message-State: AC+VfDwTDuI75uj0EoyPvb+J2v9YjaoxTNGo1w7Ndcf/0mnnw/IjewJb
        wNpBoyu+n0r9v2eZCBmoD9Q=
X-Google-Smtp-Source: ACHHUZ500h2q7vZ/MjKw1/brYi/Bftm4hW9KWPeEEKOSpBrFXNOBEo9n3F0COC2Ngy2yiDvvoxIDZw==
X-Received: by 2002:a17:903:283:b0:1b2:28ca:d38 with SMTP id j3-20020a170903028300b001b228ca0d38mr3197727plr.10.1686431292425;
        Sat, 10 Jun 2023 14:08:12 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b001b01547d0e8sm5371686plf.142.2023.06.10.14.08.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Jun 2023 14:08:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f4d49b1b-0c42-e38b-c92f-93261045546c@roeck-us.net>
Date:   Sat, 10 Jun 2023 14:08:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     =?UTF-8?Q?Joaqu=c3=adn_Ignacio_Aramend=c3=ada?= 
        <samsagax@gmail.com>
Cc:     derekjohn.clark@gmail.com, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230610192400.80611-2-samsagax@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (oxp-sensors) Add tt_toggle attribute on
 supported boards
In-Reply-To: <20230610192400.80611-2-samsagax@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/23 12:23, Joaquín Ignacio Aramendía wrote:
> OneXPlayer boards from the last generation (both for OneXPlayer and AOK
> ZOE brands) have a toggle in the EC to switch the "Turbo/Silent" button
> into a different keyboard event.
> 
> Add a means to use that "Turbo button takeover" function and expose it
> to userspace in a custom sysfs `tt_toggle` attribute. It can be read to
> take the current state. Write 1|0 to activate the function. The specific
> keycode is dependent on the board but can be checked by running
> `evtest` utility.
> 
> Newer BIOS on the OneXPlayer added this function aside from string changes.
> Add a board enum to differentiate it from the old OneXplayer Mini AMD BIOS.
> 
> Currently known supported boards:
> - AOK ZOE A1
> - OneXPlayer Mini AMD (only newer BIOS version supported)
> - OneXPlayer Mini Pro
> 
> Signed-off-by: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> ---
> v2 changes:
> - Attach the attribute to the platform device as per review
> - Make the attribute return status 0|1 instead of read value
> ---
>   Documentation/hwmon/oxp-sensors.rst |  16 ++++
>   drivers/hwmon/oxp-sensors.c         | 142 +++++++++++++++++++++++++++-
>   2 files changed, 157 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/hwmon/oxp-sensors.rst b/Documentation/hwmon/oxp-sensors.rst
> index 4ab442301415..131c89fad03a 100644
> --- a/Documentation/hwmon/oxp-sensors.rst
> +++ b/Documentation/hwmon/oxp-sensors.rst
> @@ -19,6 +19,11 @@ out the EC registers and values to write to since the EC layout and model is
>   different. Aya Neo devices preceding the AIR may not be supportable as the EC
>   model is different and do not appear to have manual control capabilities.
>   
> +Some models have a toggle for changing the behaviour of the "Turbo/Silent"
> +button of the device. It will change the key event that it triggers with
> +a flip of the `tt_toggle` attribute. See below for boards that support this
> +function.
> +
>   Supported devices
>   -----------------
>   
> @@ -33,6 +38,11 @@ Currently the driver supports the following handhelds:
>    - OneXPlayer mini AMD
>    - OneXPlayer mini AMD PRO
>   
> +"Turbo/Silent" button behaviour toggle is only supported on:
> + - AOK ZOE A1
> + - OneXPlayer mini AMD (only with updated alpha BIOS)
> + - OneXPlayer mini AMD PRO
> +
>   Sysfs entries
>   -------------
>   
> @@ -49,3 +59,9 @@ pwm1
>     Read Write. Read this attribute to see current duty cycle in the range [0-255].
>     When pwm1_enable is set to "1" (manual) write any value in the range [0-255]
>     to set fan speed.
> +
> +tt_toggle
> +  Read Write. Read this attribute to check the status of the turbo/silent
> +  button behaviour function. Write "1" to activate the switch and "0" to
> +  deactivate it. The specific keycodes and behaviour is specific to the device
> +  both with this function on and off.

Mention that this attribute is attached to the platform device.

> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index 0ec7588610ad..59e4e906ced5 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -47,15 +47,29 @@ enum oxp_board {
>   	aya_neo_air_pro,
>   	aya_neo_geek,
>   	oxp_mini_amd,
> +	oxp_mini_amd_a07,
>   	oxp_mini_amd_pro,
>   };
>   
>   static enum oxp_board board;
>   
> +/* Fan reading and PWM */
>   #define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
>   #define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
>   #define OXP_SENSOR_PWM_REG		0x4B /* PWM reading is 1 register long */
>   
> +/* Turbo button takeover function
> + * Older boards have different values and EC registers
> + * for the same function
> + */
> +#define OXP_OLD_TURBO_SWITCH_REG	0x1E
> +#define OXP_OLD_TURBO_TAKE_VAL		0x01
> +#define OXP_OLD_TURBO_RETURN_VAL	0x00
> +
> +#define OXP_TURBO_SWITCH_REG		0xF1
> +#define OXP_TURBO_TAKE_VAL		0x40
> +#define OXP_TURBO_RETURN_VAL		0x00
> +
>   static const struct dmi_system_id dmi_table[] = {
>   	{
>   		.matches = {
> @@ -104,7 +118,7 @@ static const struct dmi_system_id dmi_table[] = {
>   			DMI_MATCH(DMI_BOARD_VENDOR, "ONE-NETBOOK"),
>   			DMI_EXACT_MATCH(DMI_BOARD_NAME, "ONEXPLAYER mini A07"),
>   		},
> -		.driver_data = (void *)oxp_mini_amd,
> +		.driver_data = (void *)oxp_mini_amd_a07,
>   	},
>   	{
>   		.matches = {
> @@ -156,6 +170,112 @@ static int write_to_ec(u8 reg, u8 value)
>   	return ret;
>   }
>   
> +/* Turbo button toggle functions */
> +static int tt_toggle_enable(void)
> +{
> +	u8 reg;
> +	u8 val;
> +
> +	switch (board) {
> +	case oxp_mini_amd_a07:
> +		reg = OXP_OLD_TURBO_SWITCH_REG;
> +		val = OXP_OLD_TURBO_TAKE_VAL;
> +		break;
> +	case oxp_mini_amd_pro:
> +	case aok_zoe_a1:
> +		reg = OXP_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_TAKE_VAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return write_to_ec(reg, val);
> +}
> +
> +static int tt_toggle_disable(void)
> +{
> +	u8 reg;
> +	u8 val;
> +
> +	switch (board) {
> +	case oxp_mini_amd_a07:
> +		reg = OXP_OLD_TURBO_SWITCH_REG;
> +		val = OXP_OLD_TURBO_RETURN_VAL;
> +		break;
> +	case oxp_mini_amd_pro:
> +	case aok_zoe_a1:
> +		reg = OXP_TURBO_SWITCH_REG;
> +		val = OXP_TURBO_RETURN_VAL;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return write_to_ec(reg, val);
> +}
> +
> +/* Callbacks for turbo toggle attribute */
> +static ssize_t tt_toggle_store(struct device *dev,
> +			       struct device_attribute *attr, const char *buf,
> +			       size_t count)
> +{
> +	int rval;
> +	unsigned int value;
> +
> +	rval = kstrtouint(buf, 10, &value);
> +	if (rval)
> +		return rval;

Please use kstrtobool().

> +
> +	switch (value) {
> +	case 0:
> +		rval = tt_toggle_disable();
> +		if (rval)
> +			return rval;
> +		return count;
> +	case 1:
> +		rval = tt_toggle_enable();
> +		if (rval)
> +			return rval;
> +		return count;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t tt_toggle_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	int retval;
> +	u8 reg;
> +	long val;
> +	int status;
> +
> +	switch (board) {
> +	case oxp_mini_amd_a07:
> +		reg = OXP_OLD_TURBO_SWITCH_REG;
> +		break;
> +	case oxp_mini_amd_pro:
> +	case aok_zoe_a1:
> +		reg = OXP_TURBO_SWITCH_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	retval = read_from_ec(reg, 1, &val);
> +	if (retval)
> +		return retval;
> +
> +	if (val)
> +		status = 1;
> +	else
> +		status = 0;
> +
> +	return sysfs_emit(buf, "%d\n", status);

	return sysfs_emit(buf, "%d\n", !!val);

is much simpler.

> +}
> +
> +static DEVICE_ATTR_RW(tt_toggle);
> +
> +/* PWM enable/disable functions */
>   static int oxp_pwm_enable(void)
>   {
>   	return write_to_ec(OXP_SENSOR_PWM_ENABLE_REG, 0x01);
> @@ -206,6 +326,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>   			case aya_neo_air_pro:
>   			case aya_neo_geek:
>   			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
>   				*val = (*val * 255) / 100;
>   				break;
>   			case oxp_mini_amd_pro:
> @@ -247,6 +368,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>   			case aya_neo_air_pro:
>   			case aya_neo_geek:
>   			case oxp_mini_amd:
> +			case oxp_mini_amd_a07:
>   				val = (val * 100) / 255;
>   				break;
>   			case aok_zoe_a1:
> @@ -274,6 +396,13 @@ static const struct hwmon_channel_info * const oxp_platform_sensors[] = {
>   	NULL,
>   };
>   
> +static struct attribute *oxp_ec_attrs[] = {
> +	&dev_attr_tt_toggle.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(oxp_ec);
> +
>   static const struct hwmon_ops oxp_ec_hwmon_ops = {
>   	.is_visible = oxp_ec_hwmon_is_visible,
>   	.read = oxp_platform_read,
> @@ -291,6 +420,7 @@ static int oxp_platform_probe(struct platform_device *pdev)
>   	const struct dmi_system_id *dmi_entry;
>   	struct device *dev = &pdev->dev;
>   	struct device *hwdev;
> +	int ret;
>   
>   	/*
>   	 * Have to check for AMD processor here because DMI strings are the
> @@ -305,6 +435,16 @@ static int oxp_platform_probe(struct platform_device *pdev)
>   
>   	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
>   
> +	switch (board) {
> +	case aok_zoe_a1:
> +	case oxp_mini_amd_a07:
> +	case oxp_mini_amd_pro:
> +		ret = devm_device_add_groups(dev, oxp_ec_groups);
> +		if (ret)
> +			return ret;
		break;

> +	default:

		break;

> +	}
> +
>   	hwdev = devm_hwmon_device_register_with_info(dev, "oxpec", NULL,
>   						     &oxp_ec_chip_info, NULL);
>   

