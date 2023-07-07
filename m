Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D524974ACED
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjGGIcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjGGIcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:32:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A63B90;
        Fri,  7 Jul 2023 01:32:07 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 469A56606FCA;
        Fri,  7 Jul 2023 09:32:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1688718725;
        bh=t2rkCbgGEm+ru0kRuGpgrdPysXExXq3DnEOiku93jvQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ucl090laFkEUAlFDIM5irYbjHt5rA1HD4+cSbtY8egpSBKUfu19u9Jlq1Gt8QBPLs
         1mJ5lhSSTpB6Ol5oYTUEyBw+p/IcFoRsVM4l3OHxaPtWun1sADjlYcb18B0xAgBAAW
         5y5cLUsTFmUZ9RhHhDrd0jO/v5pY8aoUBWl/dAMgDnYeWzTacBnQ4Tao3iRZYjGlok
         CsMk3E4ztWsI50rAyQatyxgcSrDFUqLjxHhmCdY4ArGTVCwpiYSgOo//CScu88A9Y0
         tX8qtuUDI9AzwDdEexZyQWHxGPvYL3sfmNZhsg+rwxJ2WB0K8TEeTds0mnVXCuCc7M
         VbWvlZwpmNBvw==
Message-ID: <a08862e5-4e84-c3a8-b373-5fbff1e84704@collabora.com>
Date:   Fri, 7 Jul 2023 10:32:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Make readings
 valid in filtered mode
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706161509.204546-1-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230706161509.204546-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/07/23 18:14, Nícolas F. R. A. Prado ha scritto:
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
> 
> ---
> 
>   drivers/thermal/mediatek/lvts_thermal.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index 1e11defe4f35..b5fb1d8bc3d8 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -58,11 +58,11 @@
>   #define LVTS_PROTTC(__base)		(__base + 0x00CC)
>   #define LVTS_CLKEN(__base)		(__base + 0x00E4)
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
>   #define LVTS_TSSEL_CONF				0x13121110
>   #define LVTS_CALSCALE_CONF			0x300
>   #define LVTS_MONINT_CONF			0x9FBF7BDE
> @@ -257,6 +257,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>   	struct lvts_sensor *lvts_sensor = thermal_zone_device_priv(tz);
>   	void __iomem *msr = lvts_sensor->msr;
>   	u32 value;
> +	int rc;
>   
>   	/*
>   	 * Measurement registers:
> @@ -269,7 +270,7 @@ static int lvts_get_temp(struct thermal_zone_device *tz, int *temp)
>   	 * 16	: Valid temperature
>   	 * 15-0	: Raw temperature
>   	 */
> -	value = readl(msr);

#define LVTS_MSR_READ_TIMEOUT_US	400

then, either 240 like this...

#define LVTS_MSR_READ_WAIT_US		((LVTS_MSR_READ_TIMEOUT_US / 2) - 10)

..or 220 (if valid) like this..

#define LVTS_MSR_READ_WAIT_US		((LVTS_MSR_READ_TIMEOUT_US / 20) + \
					 (LVTS_MSR_READ_TIMEOUT_US / 2))

..or just "240-and-that's-it"

#define LVTS_MSR_READ_WAIT_US		240

	rc = readl_poll_timeout(msr, value, value & BIT(16),
				LVTS_MSR_READ_WAIT_US, LVTS_MSR_READ_TIMEOUT_US);

Cheers,
Angelo


