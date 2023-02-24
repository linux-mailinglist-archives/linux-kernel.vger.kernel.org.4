Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BB26A1835
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjBXIqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbjBXIqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:46:23 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DBD8663A2D;
        Fri, 24 Feb 2023 00:46:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 741C4C14;
        Fri, 24 Feb 2023 00:47:00 -0800 (PST)
Received: from [192.168.1.79] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3C0093F703;
        Fri, 24 Feb 2023 00:46:15 -0800 (PST)
Message-ID: <4e0673e7-5685-ad1b-2fac-4ae544caefeb@arm.com>
Date:   Fri, 24 Feb 2023 08:46:05 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 11/11] drm/panfrost: Add support for Mali on the MT8186
 SoC
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, alyssa.rosenzweig@collabora.com,
        matthias.bgg@gmail.com, robh@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
 <20230223133440.80941-12-angelogioacchino.delregno@collabora.com>
Content-Language: en-GB
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20230223133440.80941-12-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/02/2023 13:34, AngeloGioacchino Del Regno wrote:
> MediaTek MT8186 has a Mali-G52 MC2 2EE (Bifrost): add a new compatible
> and platform data using the same supplies list as "mt8183_b" (only one
> regulator), and a new pm_domains list with only two power domains.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_drv.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
> index 14cdeaeeb5c4..e4053bf84c62 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_drv.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
> @@ -679,6 +679,14 @@ static const struct panfrost_compatible mediatek_mt8183_b_data = {
>  	.pm_domain_names = mediatek_mt8183_pm_domains,
>  };
>  
> +static const char * const mediatek_mt8186_pm_domains[] = { "core0", "core1" };
> +static const struct panfrost_compatible mediatek_mt8186_data = {
> +	.num_supplies = ARRAY_SIZE(mediatek_mt8183_b_supplies) - 1,
> +	.supply_names = mediatek_mt8183_b_supplies,
> +	.num_pm_domains = ARRAY_SIZE(mediatek_mt8186_pm_domains),
> +	.pm_domain_names = mediatek_mt8186_pm_domains,
> +};
> +
>  static const char * const mediatek_mt8192_supplies[] = { "mali", NULL };
>  static const char * const mediatek_mt8192_pm_domains[] = { "core0", "core1", "core2",
>  							   "core3", "core4" };
> @@ -708,6 +716,7 @@ static const struct of_device_id dt_match[] = {
>  	{ .compatible = "arm,mali-valhall-jm", .data = &default_data, },
>  	{ .compatible = "mediatek,mt8183-mali", .data = &mediatek_mt8183_data },
>  	{ .compatible = "mediatek,mt8183b-mali", .data = &mediatek_mt8183_b_data },
> +	{ .compatible = "mediatek,mt8186-mali", .data = &mediatek_mt8186_data },
>  	{ .compatible = "mediatek,mt8192-mali", .data = &mediatek_mt8192_data },
>  	{}
>  };

