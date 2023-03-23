Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140E56C66F9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 12:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbjCWLoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 07:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWLn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 07:43:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C141043F;
        Thu, 23 Mar 2023 04:43:58 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3519366030B7;
        Thu, 23 Mar 2023 11:43:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1679571836;
        bh=40CudmEZ80ffRNlrSfZD49rg1pKabWucP0ROERdjI/c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=l+7QJ5qUCIJ7KE1zlge63WJbhjG9XmELWynJnChfqRAbIxyTMI9jKFkfVrJPnutrP
         sAWxqyt4BvQQoVobctCM6gsP8PXEYEp9Lb+cb1GWoJ5wm6TW/cYfdIUJ8HK5GMzBMG
         lJXq7fU2M4Fv6l7oN+4jUz4Vk+uhxp97D+1RIvBetDNOQEWT3AvpbU1fAeESQSiH+9
         G4EBgB12nIf8tEYeXP11TKmaTfrPIk5DSotjqtLJYGG5S4RwKmwECz5mcyw/NYKYTo
         MuvhYEnkS6vFtEAfc188XreHClWI9e/zNIKVC0h2gLRV4+daeo1R+zoadEs5Dmf60Z
         veJGurWztwB1Q==
Message-ID: <9e08ad33-ef86-6e49-2ef8-f697d2b82f04@collabora.com>
Date:   Thu, 23 Mar 2023 12:43:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] cpufreq: mediatek: guard error paths to avoid kernel
 panic
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Sam Shih <sam.shih@mediatek.com>, John Crispin <john@phrozen.org>
References: <ZBwyN7NwZ2zqHygr@makrotopia.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <ZBwyN7NwZ2zqHygr@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/03/23 12:04, Daniel Golle ha scritto:
> Guard pointer access in error path of mtk_cpu_dvfs_info_init() to
> make sure info->proc_reg and info->sram_reg are valid pointers before
> accessing them, which would result in kernel panic e.g. in case of
> them being set to -EPROBE_DEFER.
> 
> Fixes: 4b9ceb757bbb ("cpufreq: mediatek: Enable clocks and regulators")
> Reported-by: Sam Shih <sam.shih@mediatek.com>
> Suggested-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   drivers/cpufreq/mediatek-cpufreq.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 4466d0c91a6a..980a31ddd0f2 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -579,10 +579,12 @@ static int mtk_cpu_dvfs_info_init(struct mtk_cpu_dvfs_info *info, int cpu)
>   	dev_pm_opp_of_cpumask_remove_table(&info->cpus);
>   
>   out_free_resources:
> -	if (regulator_is_enabled(info->proc_reg))
> -		regulator_disable(info->proc_reg);
> -	if (info->sram_reg && regulator_is_enabled(info->sram_reg))
> -		regulator_disable(info->sram_reg);
> +	if (!IS_ERR(info->proc_reg))
> +		if (regulator_is_enabled(info->proc_reg))
> +			regulator_disable(info->proc_reg);
> +	if (!IS_ERR(info->sram_reg))

For both, actually, if you suspect that (xxxx)_reg may be NULL, then you should
use IS_ERR_OR_NULL() instead...

> +		if (info->sram_reg && regulator_is_enabled(info->sram_reg))

...otherwise, here it's useless to check if it's not NULL?

Regards,
Angelo

