Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E88E7097C8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjESM5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 08:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjESM5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 08:57:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F080810D9;
        Fri, 19 May 2023 05:56:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-25367154308so1302051a91.1;
        Fri, 19 May 2023 05:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684500986; x=1687092986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpZrNQDGTtPUMP/vHDnUWdZkCwNhA/mH8CwnzCMagT4=;
        b=fAqwa1TrHDE27YNsm+OxdPJpPon2040rvZd0bfP3IuGqMJyr0CHSlauJGDnkOF78Rj
         TrU0aMt+/tHZZ27prD3E4f7nTk61SqeNTQcunLA16GBXv9Zwum3lXrmn+PdM5qGfwlCV
         Wp48NZuuumrBYARM6EjIsgkvaMER8MxbaTDgtCcApGibnStFvNGroLHOYrcRqBHs6UuC
         2TomoRTn8N67HwUlYJ8XLZA3cM7LcuAdijZMNfiLYImoJeu3BGSOCqhtOwZFRvVCatHv
         KKQHuOzD+tM/sq8y9Md0ieVxRS2sa3BjlaZUWDUq5Fms3IxN2eCw1YvUdEBrt0O1nwZP
         MoOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684500986; x=1687092986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GpZrNQDGTtPUMP/vHDnUWdZkCwNhA/mH8CwnzCMagT4=;
        b=HRPK/3S1UVbrN6vscvqCBhj6ZGkAo81H6AEreex5iEQuWpGyIsvwWuiI58XcvIKAP9
         Q/CjsR7J3dT0LP3P5iocPXYfmCdL1QMtvb2lHrNfk61pjIjMbjgH0jXFauf4+5uNRS8z
         A60YcDQVNKcOjhbKrKmnizupFTND1zHQ4/HvyRR12nqeeJAbBMl3ste9sn45ceBNhRyZ
         JPWgTdKA1Pwjo09Dn+yEioJS9vgcXOPfnOFgLCGHBICKq7tGTbKoAJy/fN8aC7UrP33+
         qEFKq1WhG10w5SkK40ae6Hz+QmfyGvEfqTxxjNajSAvhWJV1Rvy2cXLR2er7QtYZWSCB
         sEcQ==
X-Gm-Message-State: AC+VfDy4NPAxuIYlyJRIgo4e3+xSfqQhlybVUiKEJmkR5NwBxrWQMs2c
        Mv4KNoRuGANRl3agyaoCDAE=
X-Google-Smtp-Source: ACHHUZ51ySpkmK2HtsnH7+7U7JC5UtvWLL3FRMKLnA4Fc092eCA9wLpCf26MsfivM+zDvCuzQcAyNg==
X-Received: by 2002:a17:90b:300f:b0:250:3bc3:2b09 with SMTP id hg15-20020a17090b300f00b002503bc32b09mr2104517pjb.12.1684500986211;
        Fri, 19 May 2023 05:56:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e4-20020a17090a4a0400b00250cf4e7d25sm1396303pjh.41.2023.05.19.05.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 05:56:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 19 May 2023 05:56:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Aleksa Savic <savicaleksa83@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, main@ehvag.de,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Add support for
 Aquacomputer Leakshield
Message-ID: <50a17124-7bb8-4868-987a-08d4988747fb@roeck-us.net>
References: <20230516164213.7938-1-savicaleksa83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516164213.7938-1-savicaleksa83@gmail.com>
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

On Tue, May 16, 2023 at 06:42:13PM +0200, Aleksa Savic wrote:
> Extend aquacomputer_d5next driver to expose various hardware sensors of the
> Aquacomputer Leakshield leak prevention system, which communicates
> through a proprietary USB HID protocol. Implemented by Noah Bergbauer [1].
> 
> Two temperature sensors are exposed, along with pressure (current, min, max
> and target), reservoir volume (total and filled), pump speed and flow. Pump
> speed and flow values are user provided and allow the Leakshield to
> optimize its operation. Writing them to the device is subject of future
> patches.
> 
> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/pull/41
> 
> Originally-from: Noah Bergbauer <main@ehvag.de>
> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
> ---
>  Documentation/hwmon/aquacomputer_d5next.rst |   9 ++
>  drivers/hwmon/aquacomputer_d5next.c         | 117 ++++++++++++++++++--
>  2 files changed, 118 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/hwmon/aquacomputer_d5next.rst b/Documentation/hwmon/aquacomputer_d5next.rst
> index 14b37851af0c..94dc2d93d180 100644
> --- a/Documentation/hwmon/aquacomputer_d5next.rst
> +++ b/Documentation/hwmon/aquacomputer_d5next.rst
> @@ -12,6 +12,7 @@ Supported devices:
>  * Aquacomputer Octo fan controller
>  * Aquacomputer Quadro fan controller
>  * Aquacomputer High Flow Next sensor
> +* Aquacomputer Leakshield leak prevention system
>  * Aquacomputer Aquastream XT watercooling pump
>  * Aquacomputer Aquastream Ultimate watercooling pump
>  * Aquacomputer Poweradjust 3 fan controller
> @@ -57,6 +58,11 @@ The High Flow Next exposes +5V voltages, water quality, conductivity and flow re
>  A temperature sensor can be connected to it, in which case it provides its reading
>  and an estimation of the dissipated/absorbed power in the liquid cooling loop.
>  
> +The Leakshield exposes two temperature sensors and coolant pressure (current, min, max and
> +target readings). It also exposes the estimated reservoir volume and how much of it is
> +filled with coolant. Pump RPM and flow can be set to enhance on-device calculations,
> +but this is not yet implemented here.
> +
>  The Aquastream XT pump exposes temperature readings for the coolant, external sensor
>  and fan IC. It also exposes pump and fan speeds (in RPM), voltages, as well as pump
>  current.
> @@ -83,6 +89,9 @@ Sysfs entries
>  temp[1-20]_input Physical/virtual temperature sensors (in millidegrees Celsius)
>  temp[1-8]_offset Temperature sensor correction offset (in millidegrees Celsius)
>  fan[1-8]_input   Pump/fan speed (in RPM) / Flow speed (in dL/h)
> +fan1_min         Minimal fan speed (in RPM)
> +fan1_max         Maximal fan speed (in RPM)
> +fan1_target      Target fan speed (in RPM)
>  fan5_pulses      Quadro flow sensor pulses
>  power[1-8]_input Pump/fan power (in micro Watts)
>  in[0-7]_input    Pump/fan voltage (in milli Volts)
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index a4fcd4ebf76c..a981f7086114 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
>   * hwmon driver for Aquacomputer devices (D5 Next, Farbwerk, Farbwerk 360, Octo,
> - * Quadro, High Flow Next, Aquaero, Aquastream Ultimate)
> + * Quadro, High Flow Next, Aquaero, Aquastream Ultimate, Leakshield)
>   *
>   * Aquacomputer devices send HID reports (with ID 0x01) every second to report
>   * sensor values, except for devices that communicate through the
> @@ -29,6 +29,7 @@
>  #define USB_PRODUCT_ID_FARBWERK360	0xf010
>  #define USB_PRODUCT_ID_OCTO		0xf011
>  #define USB_PRODUCT_ID_HIGHFLOWNEXT	0xf012
> +#define USB_PRODUCT_ID_LEAKSHIELD	0xf014
>  #define USB_PRODUCT_ID_AQUASTREAMXT	0xf0b6
>  #define USB_PRODUCT_ID_AQUASTREAMULT	0xf00b
>  #define USB_PRODUCT_ID_POWERADJUST3	0xf0bd
> @@ -36,7 +37,7 @@
>  enum kinds {
>  	d5next, farbwerk, farbwerk360, octo, quadro,
>  	highflownext, aquaero, poweradjust3, aquastreamult,
> -	aquastreamxt
> +	aquastreamxt, leakshield
>  };
>  
>  static const char *const aqc_device_names[] = {
> @@ -46,6 +47,7 @@ static const char *const aqc_device_names[] = {
>  	[octo] = "octo",
>  	[quadro] = "quadro",
>  	[highflownext] = "highflownext",
> +	[leakshield] = "leakshield",
>  	[aquastreamxt] = "aquastreamxt",
>  	[aquaero] = "aquaero",
>  	[aquastreamult] = "aquastreamultimate",
> @@ -93,7 +95,7 @@ static u8 aquaero_secondary_ctrl_report[] = {
>  #define AQC_FIRMWARE_VERSION		0xD
>  
>  #define AQC_SENSOR_SIZE			0x02
> -#define AQC_TEMP_SENSOR_DISCONNECTED	0x7FFF
> +#define AQC_SENSOR_NA			0x7FFF

This would have to be a separate change.

Guenter
