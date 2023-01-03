Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E102F65C064
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236969AbjACNBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjACNBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:01:15 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27BD3242
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 05:01:14 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C8471516;
        Tue,  3 Jan 2023 05:01:55 -0800 (PST)
Received: from [10.1.196.40] (e121345-lin.cambridge.arm.com [10.1.196.40])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E6EC3F587;
        Tue,  3 Jan 2023 05:01:11 -0800 (PST)
Message-ID: <7897d4a6-bf43-becd-3437-7a254f38f6be@arm.com>
Date:   Tue, 3 Jan 2023 13:01:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/3] iommu/sound: Use component_match_add_of helper
To:     Sean Anderson <sean.anderson@seco.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Joerg Roedel <joro@8bytes.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Takashi Iwai <tiwai@suse.com>, Will Deacon <will@kernel.org>,
        Yong Wu <yong.wu@mediatek.com>, alsa-devel@alsa-project.org,
        iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221222233759.1934852-1-sean.anderson@seco.com>
 <20221222233759.1934852-3-sean.anderson@seco.com>
Content-Language: en-GB
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20221222233759.1934852-3-sean.anderson@seco.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

On 22/12/2022 11:37 pm, Sean Anderson wrote:
> Convert users of component_match_add_release with component_release_of
> and component_compare_of to component_match_add_of.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Mark Brown <broonie@kernel.org>
> ---
> 
> Changes in v2:
> - Split off from helper addition
> 
>   drivers/iommu/mtk_iommu.c    | 3 +--
>   drivers/iommu/mtk_iommu_v1.c | 3 +--
>   sound/soc/codecs/wcd938x.c   | 6 ++----
>   3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 2ab2ecfe01f8..483b7a9e4410 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -1079,8 +1079,7 @@ static int mtk_iommu_mm_dts_parse(struct device *dev, struct component_match **m
>   		}
>   		data->larb_imu[id].dev = &plarbdev->dev;
>   
> -		component_match_add_release(dev, match, component_release_of,
> -					    component_compare_of, larbnode);
> +		component_match_add_of(dev, match, larbnode);

I've long since given up trying to make sense of how the DRM tree works, 
but the conflicting change is definitely already in mainline:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=b5765a1b44bea9dfcae69c53ffeb4c689d0922a7

Thanks,
Robin.

>   	}
>   
>   	/* Get smi-(sub)-common dev from the last larb. */
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index 6e0e65831eb7..fb09ed6bf550 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -672,8 +672,7 @@ static int mtk_iommu_v1_probe(struct platform_device *pdev)
>   		}
>   		data->larb_imu[i].dev = &plarbdev->dev;
>   
> -		component_match_add_release(dev, &match, component_release_of,
> -					    component_compare_of, larbnode);
> +		component_match_add_of(dev, &match, larbnode);
>   	}
>   
>   	platform_set_drvdata(pdev, data);
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index aca06a4026f3..2f8444e54083 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -4474,8 +4474,7 @@ static int wcd938x_add_slave_components(struct wcd938x_priv *wcd938x,
>   	}
>   
>   	of_node_get(wcd938x->rxnode);
> -	component_match_add_release(dev, matchptr, component_release_of,
> -				    component_compare_of, wcd938x->rxnode);
> +	component_match_add_of(dev, matchptr, wcd938x->rxnode);
>   
>   	wcd938x->txnode = of_parse_phandle(np, "qcom,tx-device", 0);
>   	if (!wcd938x->txnode) {
> @@ -4483,8 +4482,7 @@ static int wcd938x_add_slave_components(struct wcd938x_priv *wcd938x,
>   		return -ENODEV;
>   	}
>   	of_node_get(wcd938x->txnode);
> -	component_match_add_release(dev, matchptr, component_release_of,
> -				    component_compare_of, wcd938x->txnode);
> +	component_match_add_of(dev, matchptr, wcd938x->txnode);
>   	return 0;
>   }
>   
