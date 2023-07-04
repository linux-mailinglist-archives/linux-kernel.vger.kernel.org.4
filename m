Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 116F77472DF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 15:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231643AbjGDNjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 09:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjGDNjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 09:39:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDBEE6E;
        Tue,  4 Jul 2023 06:39:09 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b7f2239bfdso44440645ad.1;
        Tue, 04 Jul 2023 06:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688477949; x=1691069949;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yT9sQHHYP7xU96OTs/+MxI0u0T/k6DehjCmw2VCeWUA=;
        b=SPLnW0welDHduvgOWQiqcEDhOsraqfxSyZZNJJNqXkLPfBjbk9PmDINMFmYpvwmFZ1
         U1c1H58wAyDDRGWrU3SlmWI8tTumf4b8WimMY9MmpnxtIZN18W3c/wlcuFhDw99dvkvO
         f1LAjpAzZqUWpqoiRgZnSaEyHbqGAUWkXMtD+cmuCS5F0NcIfPUEfEaTYsk0SzUtmrH1
         fIxtazoOl+jdDV20Fics/D5jqmr43qDeErBgNEwS2w0z45iBiEdb4jSVfT/e6NTX+Quo
         n3iAjrqrTpAud2HHxFFQpf4ZfBtjKGMrPdUwkkZHBS5OpbUX9TZWXel4m3GwV6Gs0SiG
         5Xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688477949; x=1691069949;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yT9sQHHYP7xU96OTs/+MxI0u0T/k6DehjCmw2VCeWUA=;
        b=eJiMfHA17Z+rGhwODBy84oGs2Fc0n2Z7ioMGxoqnLIEYMx0XrNcR4+XsSZ2Q5d2Hl9
         c7GKaPK90A2PbI6fXyEUQai5DMVj8Ovd8A8vDa71MZzHu9jyjxsLh3uWjJhkIFoI3A5F
         szKNarwHwldtSDaCubLFqu5ivPXAEwzRs/BoswiT5cWETYa/TCV/cJUKc1/oJAwwCGSl
         eTekKc8KN3q08sdxuyXB+oCYcN1M/PulK9Wu7C8WIu2NF3Pbwvt+rdvbGGnqsVa2iptQ
         aL8840ZJNfGj+T5SXiC2BoPPrhnWiBZ9hYgAgWE9PlNyzRBjsgK+la3SaGKLg3VFhwOc
         yUmQ==
X-Gm-Message-State: ABy/qLaSGZFAY0R1559xNYsQD/MbRqRZYF/8uipfXnyZPvJ/KxadCl5X
        nrh1oN3lMroHLbto9UMi0N6Nx/Bu5Qc=
X-Google-Smtp-Source: APBJJlHQ5d8y62BeUAIaoJQ3bW3zfRoBSIXW7XqpN18X0yjal0yzeN7kLbxBXyG4zTR8MEcgE/9fpQ==
X-Received: by 2002:a17:902:dac7:b0:1b8:a56b:989d with SMTP id q7-20020a170902dac700b001b8a56b989dmr2472742plx.6.1688477949224;
        Tue, 04 Jul 2023 06:39:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iw13-20020a170903044d00b001b801044466sm15087177plb.114.2023.07.04.06.39.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 06:39:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a9c6c44c-21fb-9d42-9a6d-6685e110015d@roeck-us.net>
Date:   Tue, 4 Jul 2023 06:39:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hwmon@vger.kernel.org
Cc:     samsagax@gmail.com, linux-kernel@vger.kernel.org
References: <20230704131715.44454-5-gregkh@linuxfoundation.org>
 <20230704131715.44454-6-gregkh@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 1/3] hwmon: (oxp-sensors): remove static board variable
In-Reply-To: <20230704131715.44454-6-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 06:17, Greg Kroah-Hartman wrote:
> Drivers should not have a single static variable for the type of device
> they are bound to.  While this driver is really going to only have one
> device at a time in the system, remove the static variable and instead,
> look up the device type when needed.
> 

This is expensive. I think it would be much better to just move
the board type detection into the init code and not instantiate
the driver in the fist place if the board type is unknown.

We can handle the static variable separately if it really bothers
you that much.

> Cc: Joaquín Ignacio Aramendía <samsagax@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: linux-hwmon@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>   drivers/hwmon/oxp-sensors.c | 47 ++++++++++++++++++++-----------------
>   1 file changed, 25 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/hwmon/oxp-sensors.c b/drivers/hwmon/oxp-sensors.c
> index e1a907cae820..3bcba0c476c4 100644
> --- a/drivers/hwmon/oxp-sensors.c
> +++ b/drivers/hwmon/oxp-sensors.c
> @@ -48,10 +48,9 @@ enum oxp_board {
>   	oxp_mini_amd,
>   	oxp_mini_amd_a07,
>   	oxp_mini_amd_pro,
> +	UNKNOWN,
>   };
>   
> -static enum oxp_board board;
> -
>   /* Fan reading and PWM */
>   #define OXP_SENSOR_FAN_REG		0x76 /* Fan reading is 2 registers long */
>   #define OXP_SENSOR_PWM_ENABLE_REG	0x4A /* PWM enable is 1 register long */
> @@ -136,6 +135,24 @@ static const struct dmi_system_id dmi_table[] = {
>   	{},
>   };
>   
> +static enum oxp_board get_board_type(void)
> +{
> +	const struct dmi_system_id *dmi_entry;
> +
> +	/*
> +	 * Have to check for AMD processor here because DMI strings are the
> +	 * same between Intel and AMD boards, the only way to tell them apart
> +	 * is the CPU.
> +	 * Intel boards seem to have different EC registers and values to
> +	 * read/write.
> +	 */
> +	dmi_entry = dmi_first_match(dmi_table);
> +	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> +		return UNKNOWN;
> +
> +	return (enum oxp_board)(unsigned long)dmi_entry->driver_data;
> +}
> +
>   /* Helper functions to handle EC read/write */
>   static int read_from_ec(u8 reg, int size, long *val)
>   {
> @@ -182,7 +199,7 @@ static int tt_toggle_enable(void)
>   	u8 reg;
>   	u8 val;
>   
> -	switch (board) {
> +	switch (get_board_type()) {
>   	case oxp_mini_amd_a07:
>   		reg = OXP_OLD_TURBO_SWITCH_REG;
>   		val = OXP_OLD_TURBO_TAKE_VAL;
> @@ -203,7 +220,7 @@ static int tt_toggle_disable(void)
>   	u8 reg;
>   	u8 val;
>   
> -	switch (board) {
> +	switch (get_board_type()) {
>   	case oxp_mini_amd_a07:
>   		reg = OXP_OLD_TURBO_SWITCH_REG;
>   		val = OXP_OLD_TURBO_RETURN_VAL;
> @@ -249,7 +266,7 @@ static ssize_t tt_toggle_show(struct device *dev,
>   	u8 reg;
>   	long val;
>   
> -	switch (board) {
> +	switch (get_board_type()) {
>   	case oxp_mini_amd_a07:
>   		reg = OXP_OLD_TURBO_SWITCH_REG;
>   		break;
> @@ -315,7 +332,7 @@ static int oxp_platform_read(struct device *dev, enum hwmon_sensor_types type,
>   			ret = read_from_ec(OXP_SENSOR_PWM_REG, 1, val);
>   			if (ret)
>   				return ret;
> -			switch (board) {
> +			switch (get_board_type()) {
>   			case aya_neo_2:
>   			case aya_neo_air:
>   			case aya_neo_air_pro:
> @@ -357,7 +374,7 @@ static int oxp_platform_write(struct device *dev, enum hwmon_sensor_types type,
>   		case hwmon_pwm_input:
>   			if (val < 0 || val > 255)
>   				return -EINVAL;
> -			switch (board) {
> +			switch (get_board_type()) {
>   			case aya_neo_2:
>   			case aya_neo_air:
>   			case aya_neo_air_pro:
> @@ -412,25 +429,11 @@ static const struct hwmon_chip_info oxp_ec_chip_info = {
>   /* Initialization logic */
>   static int oxp_platform_probe(struct platform_device *pdev)
>   {
> -	const struct dmi_system_id *dmi_entry;
>   	struct device *dev = &pdev->dev;
>   	struct device *hwdev;
>   	int ret;
>   
> -	/*
> -	 * Have to check for AMD processor here because DMI strings are the
> -	 * same between Intel and AMD boards, the only way to tell them apart
> -	 * is the CPU.
> -	 * Intel boards seem to have different EC registers and values to
> -	 * read/write.
> -	 */
> -	dmi_entry = dmi_first_match(dmi_table);
> -	if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
> -		return -ENODEV;
> -
> -	board = (enum oxp_board)(unsigned long)dmi_entry->driver_data;
> -
> -	switch (board) {
> +	switch (get_board_type()) {

This now always registers the hwmon device, which really should not happen.

Guenter

>   	case aok_zoe_a1:
>   	case oxp_mini_amd_a07:
>   	case oxp_mini_amd_pro:

