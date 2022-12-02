Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D196064040A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiLBKFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiLBKFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:05:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D3E391FD;
        Fri,  2 Dec 2022 02:05:01 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D1846601811;
        Fri,  2 Dec 2022 10:04:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669975499;
        bh=qXooxeaYPL0DnLqOyBm5Di9kxLBGZnJQo6KXGjxoNM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dCrSK40tOhEvndX0TcUkgQZ3tWruAWImx9aV5SS84xfjEhMgqsJjo91NpTc7Y+VzO
         CWpltP1YsvzKD9lYDuWqBq/z6V6MIHhQOnLYVbXDOhzx/HyuAgdxkrCqMou6hWDg7o
         JMxNCbipyYUYQISFWijvcvH5qFiDb3tO2yIuYVxvzyarPTNF2FPZGELUyvLCAW9HwE
         5lYWpEiilJOiq9BjLh3yHFoTvSTJB6pjgTqKrSX4docMHOlvPxRfAROjSqwWCyv94P
         b7szNmDxMNBgDhE6fNx58arGrxwxPogDy2MNWitrFi6jHIWasoYJitRXHov0d4Wvh4
         imJQRznN8IWuA==
Message-ID: <64ac15de-3324-6d48-5199-587f01b565e0@collabora.com>
Date:   Fri, 2 Dec 2022 11:04:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] cpufreq: mediatek: Raise proc and sram max voltage for
 MT7622/7623
Content-Language: en-US
To:     vincent@systemli.org
Cc:     rafael@kernel.org, matthias.bgg@gmail.com,
        jia-wei.chang@mediatek.com, rex-bc.chen@mediatek.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, frank-w@public-files.de,
        daniel@makrotopia.org, viresh.kumar@linaro.org
References: <20221202095227.167492-1-angelogioacchino.delregno@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221202095227.167492-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 02/12/22 10:52, AngeloGioacchino Del Regno ha scritto:
> During the addition of SRAM voltage tracking for CCI scaling, this
> driver got some voltage limits set for the vtrack algorithm: these
> were moved to platform data first, then enforced in a later commit
> 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
> using these as max values for the regulator_set_voltage() calls.
> 
> In this case, the vsram/vproc constraints for MT7622 and MT7623
> were supposed to be the same as MT2701 (and a number of other SoCs),
> but that turned out to be a mistake because the aforementioned two
> SoCs' maximum voltage for both VPROC and VPROC_SRAM is 1.36V.
> 
> Fix that by adding new platform data for MT7622/7623 declaring the
> right {proc,sram}_max_volt parameter.
> 
> Fixes: ead858bd128d ("cpufreq: mediatek: Move voltage limits to platform data")
> Fixes: 6a17b3876bc8 ("cpufreq: mediatek: Refine mtk_cpufreq_voltage_tracking()")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Hello Vincent,
in regard to the regression that you've (not so) recently reported, can you please
give this commit a try and check if this helps resolving your issue?

Many thanks,
Angelo

> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 13 +++++++++++--
>   1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 7f2680bc9a0f..f9a9f08c75c4 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -695,6 +695,15 @@ static const struct mtk_cpufreq_platform_data mt2701_platform_data = {
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
> @@ -717,8 +726,8 @@ static const struct mtk_cpufreq_platform_data mt8186_platform_data = {
>   static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>   	{ .compatible = "mediatek,mt2701", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt2712", .data = &mt2701_platform_data },
> -	{ .compatible = "mediatek,mt7622", .data = &mt2701_platform_data },
> -	{ .compatible = "mediatek,mt7623", .data = &mt2701_platform_data },
> +	{ .compatible = "mediatek,mt7622", .data = &mt7622_platform_data },
> +	{ .compatible = "mediatek,mt7623", .data = &mt7622_platform_data },
>   	{ .compatible = "mediatek,mt8167", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt817x", .data = &mt2701_platform_data },
>   	{ .compatible = "mediatek,mt8173", .data = &mt2701_platform_data },

