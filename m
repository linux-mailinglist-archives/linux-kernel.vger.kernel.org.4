Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81DF74AC52
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 09:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjGGHyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 03:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232608AbjGGHyA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 03:54:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB65B2
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 00:53:58 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso1397385ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 00:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688716438; x=1691308438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HQgfVl/i/AVcUS5ggc70MxFgfsFBmBSGVm2GhzJXRGM=;
        b=EY+mwitihR1BY0wiVH06ZwvPZB0vcDEEn4HC1LNgbbGW0oKYFmY/xs24morMGXUsr3
         jV/bx4/CxOmJaCIiln1tlZ+gG4y3QixOpNEEnx+9RihDs7Dkeh2hu9R+WjcULUPemcIj
         PBni27YtiE7DOpbwTUoRCcqMt1BLkGrrrVyTs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688716438; x=1691308438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQgfVl/i/AVcUS5ggc70MxFgfsFBmBSGVm2GhzJXRGM=;
        b=kncUGNWoXlHGQBhbinkeVAfafEnI9nenINNz29XFXtvUsY2GRcJg0SvePntH5CAn1g
         8KtMYzLvYREGu0Kni2IahlWPFqlFjZffTHmAGdnlUKUnoEAJr9xvVxLJdca4yIACxo7W
         DDm26q3bZZL9CeIhluv5J01SCHh6RYuw+fj3Ik10Gd9qlB4Qm6QgrS53rahrfTaaR8JM
         ACfiw2sVVZKTLuMzsZ5XQEZINDDyEyRw2EzCPEIZVNdeaJ6wVIQd/yAEItcBpT3i9Oyp
         Pvk9C0d31CYP9HhIBKgP79KSKf0i932c75DfJC68TFt/fDL4JMXP+X0u1somDm0KUkEd
         DYUQ==
X-Gm-Message-State: ABy/qLYIUGWx79ztY/IPRkkj+aNJCCYEbrXHa43Og5zC4t/1ewDEI0pA
        h6R0RvoTdaZ+xT6X10g2Qd3RNw==
X-Google-Smtp-Source: APBJJlF6RcNC5y+ljau2+G5q7B3VhzXd0PfFiNLMgLRX96g3mUA+FT12+Re08qem3DIVvI9ZeTddlw==
X-Received: by 2002:a17:903:120f:b0:1b3:cac7:19cd with SMTP id l15-20020a170903120f00b001b3cac719cdmr4804993plh.18.1688716438426;
        Fri, 07 Jul 2023 00:53:58 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:7493:8870:1e91:754])
        by smtp.gmail.com with ESMTPSA id u15-20020a170902e5cf00b001b1c3542f57sm2611449plf.103.2023.07.07.00.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 00:53:58 -0700 (PDT)
Date:   Fri, 7 Jul 2023 15:53:54 +0800
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     =?iso-8859-1?Q?N=EDcolas_F=2E_R=2E_A=2E?= Prado 
        <nfraprado@collabora.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Make readings
 valid in filtered mode
Message-ID: <20230707075354.GA1333497@google.com>
References: <20230706161509.204546-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230706161509.204546-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 12:14:33PM -0400, Nícolas F. R. A. Prado wrote:
> Currently, when a controller is configured to use filtered mode, thermal
> readings are valid only about 30% of the time.
> 
> Upon testing, it was noticed that lowering any of the interval settings
> resulted in an improved rate of valid data. The same was observed when
> decreasing the number of samples for each sensor (which also results in
> quicker measurements).
> 
> Retrying the read with a timeout longer than the time it takes to
> resample (about 344us with these settings and 4 sensors) also improves
> the rate.
> 
> Lower all timing settings to the minimum, configure the filtering to
> single sample, and poll the measurement register for at least one period
> to improve the data validity on filtered mode.  With these changes in
> place, out of 100000 reads, a single one failed, ie 99.999% of the data
> was valid.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>

on Hayato. Reading out the temperature is now quite reliable.

> 
> ---
> 
>  drivers/thermal/mediatek/lvts_thermal.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 1e11defe4f35..b5fb1d8bc3d8 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -58,11 +58,11 @@
>  #define LVTS_PROTTC(__base)		(__base + 0x00CC)
>  #define LVTS_CLKEN(__base)		(__base + 0x00E4)
>  
> -#define LVTS_PERIOD_UNIT			((118 * 1000) / (256 * 38))
> -#define LVTS_GROUP_INTERVAL			1
> -#define LVTS_FILTER_INTERVAL		1
> -#define LVTS_SENSOR_INTERVAL		1
> -#define LVTS_HW_FILTER				0x2
> +#define LVTS_PERIOD_UNIT			0
> +#define LVTS_GROUP_INTERVAL			0
> +#define LVTS_FILTER_INTERVAL		0
> +#define LVTS_SENSOR_INTERVAL		0
> +#define LVTS_HW_FILTER				0x0

This hunk conflicts with

    thermal/drivers/mediatek/lvts_thermal: Disable undesired interrupts

from your other series

>  #define LVTS_TSSEL_CONF				0x13121110
>  #define LVTS_CALSCALE_CONF			0x300
>  #define LVTS_MONINT_CONF			0x9FBF7BDE

on this line.

> @@ -257,6 +257,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>  	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
>  	void __iomem *msr = lvts_sensor->msr;
>  	u32 value;
> +	int rc;
>  
>  	/*
>  	 * Measurement registers:
> @@ -269,7 +270,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>  	 * 16	: Valid temperature
>  	 * 15-0	: Raw temperature
>  	 */
> -	value = readl(msr);
> +	rc = readl_poll_timeout(msr, value, value & BIT(16), 240, 400);
>  
>  	/*
>  	 * As the thermal zone temperature will read before the
> @@ -282,7 +283,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>  	 * functionning temperature and directly jump to a system
>  	 * shutdown.
>  	 */
> -	if (!(value & BIT(16)))
> +	if (rc)
>  		return -EAGAIN;
>  
>  	*temp = lvts_raw_to_temp(value & 0xFFFF);
> -- 
> 2.41.0
> 
