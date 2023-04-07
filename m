Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C816DAFE9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:54:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbjDGPyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDGPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:54:18 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3356EAB;
        Fri,  7 Apr 2023 08:54:17 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-17fcc07d6c4so31977957fac.8;
        Fri, 07 Apr 2023 08:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680882857; x=1683474857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Utrmt87/lvg+g4etr9fQILoL0w88HzDoqi2Ru46qUPk=;
        b=o0/qFzatw0XuLbTEw8yp/m0U6CXUDcz+urrbqYGJmooStr83eR6WkSY1dJS/6Sw8IF
         KrOgDS9KzsLU/0UfYPvA17xjNnyadU7o5N0AiMWy1CP0EXvlEzKhpfwkaSLK3rskO/gp
         nzUiH3CSXqwuPOngsBh0ZTdjySRkvwB1zLA0sKLMP24uku2YZNXRWRmJdtJVGCwAtRsj
         fkOgVWi4kB/9vMeivU++xLY7m2trwrUQOLpub20sSurOu5sDXxvy1QOpkp0ekb9cKKyr
         DnxdQlgYO/29SONMNHp7xGzBLfCMACJpwLTnWZtbqg+kUCIT8Wum8tlAPhTuGhB+k/HP
         C3qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680882857; x=1683474857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Utrmt87/lvg+g4etr9fQILoL0w88HzDoqi2Ru46qUPk=;
        b=rnR4MLw2s9vBueiBSU2UcM9fNsSP2CqfgIpVCdqbzS7QgYIWfhuZvOfVJo7qXVsZ3X
         cBR4Q47k8Ti2mFJF1HAdV98/Zz9EjfaePV1ufpql8wLv1vKde8WL9deQXNT0dnzruuYC
         zCWfSyO0i3TD6sYB8oEPQPi/Ry97eV7nlQrBOwc5ficslsn81VNYy2T6dOO9yicL9lwA
         oDVXo72aW83VAfRAcSIABRLYkmwkhqhGoG+v2xuRqtwJFlgG5DHJkjEI7oDzBhe7oMP/
         8xe1vwx1Oz2hLXu856ipyywpzkAoq2S+hE7gfCozWAPk+7PDMncKHOoE+QUQbbNabXW2
         rYwQ==
X-Gm-Message-State: AAQBX9fz5f9QFPj6oSKWPtM3vGQMozDyD5vSrLT/JmChpiovP5keti1q
        x4GfMvf904cojwRTuqQUkEo=
X-Google-Smtp-Source: AKy350Ysoe57s+DVzestQ+7uGRw8gyaZbfkee61FtumTVTC1uLb7QV3bmoGrOM3yH6TZuRduLJXrIw==
X-Received: by 2002:a05:6870:4799:b0:177:9789:b0ad with SMTP id c25-20020a056870479900b001779789b0admr4484677oaq.22.1680882857044;
        Fri, 07 Apr 2023 08:54:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id bd16-20020a056871b31000b0016e8726f0d4sm1763309oac.3.2023.04.07.08.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 08:54:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 7 Apr 2023 08:54:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Eugene Shalygin <eugene.shalygin@gmail.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] hwmon: (asus-ec-sensors) add ROG STRIX Z390-F GAMING
Message-ID: <9a224c5a-adca-4802-b7d8-4b743ec47e76@roeck-us.net>
References: <20230405224339.358675-1-eugene.shalygin@gmail.com>
 <20230405224339.358675-3-eugene.shalygin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405224339.358675-3-eugene.shalygin@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 12:43:39AM +0200, Eugene Shalygin wrote:
> The definition comes from a LHM PR [1], and the mutex path from
> the ACPI dump, kindly provided by the PR author [2]
> 
> [1] https://github.com/LibreHardwareMonitor/LibreHardwareMonitor/pull/1031
> [2] https://github.com/zeule/asus-ec-sensors/issues/36
> 
> Signed-off-by: Eugene Shalygin <eugene.shalygin@gmail.com>

Applied.

Thanks,
Guenter

> ---
>  Documentation/hwmon/asus_ec_sensors.rst |  1 +
>  drivers/hwmon/asus-ec-sensors.c         | 10 ++++++++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/hwmon/asus_ec_sensors.rst b/Documentation/hwmon/asus_ec_sensors.rst
> index f1c9b1e11268..c92c1d3839e4 100644
> --- a/Documentation/hwmon/asus_ec_sensors.rst
> +++ b/Documentation/hwmon/asus_ec_sensors.rst
> @@ -22,6 +22,7 @@ Supported boards:
>   * ROG STRIX X570-E GAMING WIFI II
>   * ROG STRIX X570-F GAMING
>   * ROG STRIX X570-I GAMING
> + * ROG STRIX Z390-F GAMING
>   * ROG STRIX Z690-A GAMING WIFI D4
>   * ROG ZENITH II EXTREME
>   * ROG ZENITH II EXTREME ALPHA
> diff --git a/drivers/hwmon/asus-ec-sensors.c b/drivers/hwmon/asus-ec-sensors.c
> index 594fe7241111..e5be0cf472fc 100644
> --- a/drivers/hwmon/asus-ec-sensors.c
> +++ b/drivers/hwmon/asus-ec-sensors.c
> @@ -408,6 +408,14 @@ static const struct ec_board_info board_info_strix_x570_i_gaming = {
>  	.family = family_amd_500_series,
>  };
>  
> +static const struct ec_board_info board_info_strix_z390_f_gaming = {
> +	.sensors = SENSOR_TEMP_CHIPSET | SENSOR_TEMP_VRM |
> +		SENSOR_TEMP_T_SENSOR |
> +		SENSOR_FAN_CPU_OPT,
> +	.mutex_path = ASUS_HW_ACCESS_MUTEX_ASMX,
> +	.family = family_intel_300_series,
> +};
> +
>  static const struct ec_board_info board_info_strix_z690_a_gaming_wifi_d4 = {
>  	.sensors = SENSOR_TEMP_T_SENSOR | SENSOR_TEMP_VRM,
>  	.mutex_path = ASUS_HW_ACCESS_MUTEX_RMTW_ASMX,
> @@ -473,6 +481,8 @@ static const struct dmi_system_id dmi_table[] = {
>  					&board_info_strix_x570_f_gaming),
>  	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX X570-I GAMING",
>  					&board_info_strix_x570_i_gaming),
> +	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z390-F GAMING",
> +					&board_info_strix_z390_f_gaming),
>  	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG STRIX Z690-A GAMING WIFI D4",
>  					&board_info_strix_z690_a_gaming_wifi_d4),
>  	DMI_EXACT_MATCH_ASUS_BOARD_NAME("ROG ZENITH II EXTREME",
