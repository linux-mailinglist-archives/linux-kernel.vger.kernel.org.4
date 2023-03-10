Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5566B3AAA
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 10:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjCJJgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 04:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjCJJfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 04:35:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE79E3CFF
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 01:33:08 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64AF9660305C;
        Fri, 10 Mar 2023 09:32:38 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678440759;
        bh=LjZ/H1yvENw4kQILyRX+BuGBgVhVeRRqw9ZZ3x2z6Lg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n4m3XOtujNI0wBekC6tFT+w6CiJAMJ1jJ8bCGTrNkFT+T+42tocqiilxktRUEKwa0
         MylK9Rl9uvy4WvKVTFoSteMnXblXJI0Hzqx2lOclykxBqaTUENjFgQcNq9x+rMiBdI
         UqerTkByI39fbeGByTziQSiNu45/aJvIbi4Ccgz6V9nxFXbcqqhkZQvjpj/chw4pSw
         UFfIRuxKvCP7fl4gT67rUVo+35dPxaiatNbfPKPwPIGTOrY7Yem1z3QvzzIZVZCS8q
         3izr+kGoZiUwExPD0YnLc/B2a3NhxOl4nDYrvuWDkJhSJythgByNrgCY4N9cmdzKeh
         gxfKefewvLosA==
Message-ID: <18a8e134-6f16-51a5-e600-f68aa85118db@collabora.com>
Date:   Fri, 10 Mar 2023 10:32:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 3/3] cpufreq: mediatek: raise proc/sram max voltage for
 MT7622 and MT8516
Content-Language: en-US
To:     "jia-wei.chang" <jia-wei.chang@mediatek.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        hsinyi@google.com, Nick <vincent@systemli.org>,
        Dan Carpenter <error27@gmail.com>
References: <20230310051750.4745-1-jia-wei.chang@mediatek.com>
 <20230310051750.4745-4-jia-wei.chang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230310051750.4745-4-jia-wei.chang@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 10/03/23 06:17, jia-wei.chang ha scritto:
> From: "Jia-Wei Chang" <jia-wei.chang@mediatek.com>
> 
> Since the upper boundary of proc/sram voltage of MT7622 and MT8516 are
> 1350 mV and 1300 mV respectively, both are greater than the value of
> MT2701 1150 mV, we fix it by adding the corresponding platform data and
> specify proc/sram_max_volt to support MT7622 and MT8516 individually.
> 
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>
> Fixes: ead858bd128d ("cpufreq: mediatek: Move voltage limits to platform data")
> Fixes: 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
> Reported-by: Nick Hainke <vincent@systemli.org>
> Link: https://lore.kernel.org/lkml/75216e0c-9d36-7ada-1507-1bb4a91a3326@systemli.org/T/

that's 2/3 my patch, 1/3 your patch.....
...in that case, send my patch as it is and add one more for MT8516.

Regards,
Angelo

> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 26 ++++++++++++++++++++++----
>   1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index cb8b76f9c2c3..f6824d4bf85d 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -707,6 +707,15 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
>   	.ccifreq_supported = false,
>   };
>   
> +static const struct mtk_cpufreq_platform_data mt7622_platform_data = {
> +	.min_volt_shift = 100000,
> +	.max_volt_shift = 200000,
> +	.proc_max_volt = 1360000,
> +	.sram_min_volt = 0,
> +	.sram_max_volt = 1360000,
> +	.ccifreq_supported = false,
> +};
> +
>   static const struct mtk_cpufreq_platform_data mt8183_platform_data = {
>   	.min_volt_shift = 100000,
>   	.max_volt_shift = 200000,
> @@ -725,20 +734,29 @@ static const struct mtk_cpufreq_platform_data mt8186_platform_data = {
>   	.ccifreq_supported = true,
>   };
>   
> +static const struct mtk_cpufreq_platform_data mt8516_platform_data = {
> +	.min_volt_shift = 100000,
> +	.max_volt_shift = 200000,
> +	.proc_max_volt = 1310000,
> +	.sram_min_volt = 0,
> +	.sram_max_volt = 1310000,
> +	.ccifreq_supported = false,
> +};
> +
>   /* List of machines supported by this driver */
>   static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>   	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
> -	{ .compatible = "mediatek,mt7622", .data = &mt2701_platform_data },
> -	{ .compatible = "mediatek,mt7623", .data = &mt2701_platform_data },
> -	{ .compatible = "mediatek,mt8167", .data = &mt2701_platform_data },
> +	{ .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
> +	{ .compatible = "mediatek,mt7623", .data = &mt7622_platform_data },
> +	{ .compatible = "mediatek,mt8167", .data = &mt8516_platform_data },
>   	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt8176", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt8183", .data = &mt8183_platform_data },
>   	{ .compatible = "mediatek,mt8186", .data = &mt8186_platform_data },
>   	{ .compatible = "mediatek,mt8365", .data = &mt2701_platform_data },
> -	{ .compatible = "mediatek,mt8516", .data = &mt2701_platform_data },
> +	{ .compatible = "mediatek,mt8516", .data = &mt8516_platform_data },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, mtk_cpufreq_machines);

