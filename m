Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872AC658DBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233498AbiL2OCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 09:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233494AbiL2OCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 09:02:14 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A4E1014;
        Thu, 29 Dec 2022 06:02:13 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id e17-20020a9d7311000000b00678202573f1so11500904otk.8;
        Thu, 29 Dec 2022 06:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXArgKaUTK7bUwW6m7GDFoDzl4YNyLjGSKQdPTwGKDc=;
        b=YbmDz38jMg2x1DyCeETQir8cvipSZBLgO+Qf4O8Jjj69FIVqhQFv5gEogQhiiNQFIl
         BLAc6nMInVsHHyzmN7ITL8TBArcA73g02Lm5njnD27L3btjH9NHoUG1XU3LmAJqjFukb
         jTbJHjEekRJ0jjCmRAHRdXKoN/xSogSQ2bVoV8DpDmZCuVNZ3WPnA/JVPEpYFYgKIZcl
         4y7crh9J1KloYZux3BGudvihEmjFmSzv32ux2eYxl+iqv3OcVKfQvFFW0ClsPp1tOUaY
         87naRsZN7fHbJ3rtSLGndML7E2La7W+8XtdEV5F2E1vSl2MgG0ZRUVM4NLzDxC+IT43H
         RZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXArgKaUTK7bUwW6m7GDFoDzl4YNyLjGSKQdPTwGKDc=;
        b=Vv+LPt75PLyAnNXaYl2oBQioSHoewqlkFbEUA3RbMVp7d48t85EaaXVdwnlO7m4fwQ
         gW5w+L/CSZ0EAH1XB/7lDyAaYRFlHdGgGX0N8qPJUvtcDDg5uhTyeWZWTFYe+G0nanka
         0Vq0IGX5HvfTx0+Ht3UVfdn59hnn5i2Jf8tgeuBs8GrwawJ8JwJuiPRa22jjE8WNeMaH
         3nF1MN9egSFlfT7r3iXUlo1WABPtz6NY5qZe76qRgBhkj20LaTkWUu8JAFeIkVqhLWOL
         x1RBg/TJcPGZIo74Fr2FsQATrEbTiUKaN69IFMUscbAXvgkNSEhlCB0435wFOpW2biyj
         AqVw==
X-Gm-Message-State: AFqh2koQZWyyDu00dECjUOAboi38cYv8PspzVEq1Hcfbd2FkIfpi41vE
        T+DK6+1tkEiXk48tuAo5Ue/0ZBNCOUU=
X-Google-Smtp-Source: AMrXdXsUXRUtYQ88aZCCv9lGBIB5KT/VKtNTqv7oxkvC2NYthzkFdSreqy32Dti8ybeAoUEon1xKIw==
X-Received: by 2002:a05:6830:d6:b0:670:5fd6:4c2e with SMTP id x22-20020a05683000d600b006705fd64c2emr15937144oto.31.1672322533283;
        Thu, 29 Dec 2022 06:02:13 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e20-20020a0568301f3400b0066e820696edsm8983251oth.13.2022.12.29.06.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 06:02:12 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 29 Dec 2022 06:02:11 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Saravanan Sekar <saravanan@linumiz.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, marten.lindahl@axis.com,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] hwmon: pm_bus: core: Add min_uV in pmbus
 regulator helper macro
Message-ID: <20221229140211.GA17976@roeck-us.net>
References: <20221207173716.123223-1-saravanan@linumiz.com>
 <20221207173716.123223-2-saravanan@linumiz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207173716.123223-2-saravanan@linumiz.com>
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

On Wed, Dec 07, 2022 at 06:37:13PM +0100, Saravanan Sekar wrote:
> Some regulator operates in a range of voltage which should not allow
> below the lower threshold.
> 
> Signed-off-by: Saravanan Sekar <saravanan@linumiz.com>

Applied to hwmon-next.

> ---
>  drivers/hwmon/pmbus/ltc2978.c | 16 ++++++++--------
>  drivers/hwmon/pmbus/pmbus.h   |  5 +++--
>  2 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/ltc2978.c b/drivers/hwmon/pmbus/ltc2978.c
> index 6d2592731ba3..406a36885ef3 100644
> --- a/drivers/hwmon/pmbus/ltc2978.c
> +++ b/drivers/hwmon/pmbus/ltc2978.c
> @@ -569,14 +569,14 @@ MODULE_DEVICE_TABLE(i2c, ltc2978_id);
>  #define LTC2978_N_VOLTAGES	((LTC2978_MAX_UV / LTC2978_UV_STEP) + 1)
>  
>  static const struct regulator_desc ltc2978_reg_desc[] = {
> -	PMBUS_REGULATOR_STEP("vout", 0, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
> -	PMBUS_REGULATOR_STEP("vout", 1, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
> -	PMBUS_REGULATOR_STEP("vout", 2, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
> -	PMBUS_REGULATOR_STEP("vout", 3, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
> -	PMBUS_REGULATOR_STEP("vout", 4, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
> -	PMBUS_REGULATOR_STEP("vout", 5, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
> -	PMBUS_REGULATOR_STEP("vout", 6, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
> -	PMBUS_REGULATOR_STEP("vout", 7, LTC2978_N_VOLTAGES, LTC2978_UV_STEP),
> +	PMBUS_REGULATOR_STEP("vout", 0, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
> +	PMBUS_REGULATOR_STEP("vout", 1, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
> +	PMBUS_REGULATOR_STEP("vout", 2, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
> +	PMBUS_REGULATOR_STEP("vout", 3, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
> +	PMBUS_REGULATOR_STEP("vout", 4, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
> +	PMBUS_REGULATOR_STEP("vout", 5, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
> +	PMBUS_REGULATOR_STEP("vout", 6, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
> +	PMBUS_REGULATOR_STEP("vout", 7, LTC2978_N_VOLTAGES, LTC2978_UV_STEP, 0),
>  };
>  
>  static const struct regulator_desc ltc2978_reg_desc_default[] = {
> diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
> index 10fb17879f8e..713ea7915425 100644
> --- a/drivers/hwmon/pmbus/pmbus.h
> +++ b/drivers/hwmon/pmbus/pmbus.h
> @@ -464,7 +464,7 @@ struct pmbus_driver_info {
>  extern const struct regulator_ops pmbus_regulator_ops;
>  
>  /* Macros for filling in array of struct regulator_desc */
> -#define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step)  \
> +#define PMBUS_REGULATOR_STEP(_name, _id, _voltages, _step, _min_uV)  \
>  	[_id] = {						\
>  		.name = (_name # _id),				\
>  		.id = (_id),					\
> @@ -475,9 +475,10 @@ extern const struct regulator_ops pmbus_regulator_ops;
>  		.owner = THIS_MODULE,				\
>  		.n_voltages = _voltages,			\
>  		.uV_step = _step,				\
> +		.min_uV = _min_uV,				\
>  	}
>  
> -#define PMBUS_REGULATOR(_name, _id)	PMBUS_REGULATOR_STEP(_name, _id, 0, 0)
> +#define PMBUS_REGULATOR(_name, _id)   PMBUS_REGULATOR_STEP(_name, _id, 0, 0, 0)
>  
>  /* Function declarations */
>  
