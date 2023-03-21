Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAB66C348B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 15:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbjCUOm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 10:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjCUOm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 10:42:27 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D644D610;
        Tue, 21 Mar 2023 07:42:26 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id bf15so6995692iob.7;
        Tue, 21 Mar 2023 07:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679409746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mPHZAJ/4f0K+ZrgW1eaRgvJAnV5woW5J9CiZAelkEY=;
        b=P14fjCC8K0ZFXG1N71qzuKysqhqk2D1T4ohhzGYNupPn5JlcVbouPXVpZVHGW9LmoK
         QY51Dyk7sDTbnnULZT4+m4OeZJkjVHy4nBpZb0sESfSNN+s77TP2bJrfM6011w+7KHzh
         EJBBWpIm6iMx5LsBMRhVxh33ermcGREAJuLTxPm4aOxxXzAABqJFOD0A518OXgaGZdpG
         +3DCBtb7CCWvH2gkamobNaYXqJzm+8S1Grm4PyxjUyZApyAd0IqxJ8rIZbFERkpOWwnY
         9IRk25V2+uyhB3AFmObiZcKF5ozcuXJnbFsyBbQMvP2laBeaq4UC0mT8DXXV0h3WlyG0
         pbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679409746;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mPHZAJ/4f0K+ZrgW1eaRgvJAnV5woW5J9CiZAelkEY=;
        b=OEpC1wsYHuHFUgJddgjfF6My4p1A478YhlZ+aZ1pHEWr9dhz6HC7Q+AcT61f2lg8Gi
         q0fnJZEYUmP56y4qnxaRnPBTSEVl3mMGhsHdmtJjvNioc/1N/VEbG1tbnK2xHM81i8Af
         sDI4NQuwm3vxyG/GCfTnb7bibHc7Y+d+6I8UsYMKnTBpX2dBd5gySahyRkNEIefWZfA3
         nbXEFg2g5uVO2E/MvyOUUsG+MnuRNila6nyJDGehIQC0AIJvCgpEF/IXig9nV3J7ZYlq
         WUU+FW/79J4bD8cJOX0v1eq4mEDofwfNtAIOAfha6aIJvVXDyGbz2iljMQDY1yZ0MEcn
         ZQ1Q==
X-Gm-Message-State: AO0yUKVPLt+87v5Qo2EBdQO6FrZmxi1UqVadz7ltowqRzK8JBJYgtsLI
        Vf7vocbSEPFX0kF/Ar9m1WQ=
X-Google-Smtp-Source: AK7set8NNKp5yKnKnglKuRwfSaTDCAz9jQ2kweLIW2szz/T8DYHrBJehsD3eLsAHBfa+gLUD5CqpWQ==
X-Received: by 2002:a5d:8550:0:b0:74c:da4b:c4e4 with SMTP id b16-20020a5d8550000000b0074cda4bc4e4mr1807054ios.3.1679409746016;
        Tue, 21 Mar 2023 07:42:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p15-20020a056638216f00b00403089c2a1dsm4246541jak.108.2023.03.21.07.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 07:42:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 21 Mar 2023 07:42:24 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, Paul Fertser <fercerpav@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] hwmon: (peci/cputemp) Fix miscalculated DTS for SKX
Message-ID: <d30ea7f5-7b47-474f-8208-a87d0b2e1394@roeck-us.net>
References: <20230321090410.866766-1-iwona.winiarska@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321090410.866766-1-iwona.winiarska@intel.com>
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

On Tue, Mar 21, 2023 at 10:04:10AM +0100, Iwona Winiarska wrote:
> For Skylake, DTS temperature of the CPU is reported in S10.6 format
> instead of S8.8.
> 
> Reported-by: Paul Fertser <fercerpav@gmail.com>
> Link: https://lore.kernel.org/lkml/ZBhHS7v+98NK56is@home.paul.comp/
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>

Applied.

Thanks,
Guenter

> ---
>  drivers/hwmon/peci/cputemp.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/peci/cputemp.c b/drivers/hwmon/peci/cputemp.c
> index 30850a479f61..87d56f0fc888 100644
> --- a/drivers/hwmon/peci/cputemp.c
> +++ b/drivers/hwmon/peci/cputemp.c
> @@ -537,6 +537,12 @@ static const struct cpu_info cpu_hsx = {
>  	.thermal_margin_to_millidegree = &dts_eight_dot_eight_to_millidegree,
>  };
>  
> +static const struct cpu_info cpu_skx = {
> +	.reg		= &resolved_cores_reg_hsx,
> +	.min_peci_revision = 0x33,
> +	.thermal_margin_to_millidegree = &dts_ten_dot_six_to_millidegree,
> +};
> +
>  static const struct cpu_info cpu_icx = {
>  	.reg		= &resolved_cores_reg_icx,
>  	.min_peci_revision = 0x40,
> @@ -558,7 +564,7 @@ static const struct auxiliary_device_id peci_cputemp_ids[] = {
>  	},
>  	{
>  		.name = "peci_cpu.cputemp.skx",
> -		.driver_data = (kernel_ulong_t)&cpu_hsx,
> +		.driver_data = (kernel_ulong_t)&cpu_skx,
>  	},
>  	{
>  		.name = "peci_cpu.cputemp.icx",
