Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AC4652F45
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 11:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiLUKVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 05:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234519AbiLUKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 05:21:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA399B7D9;
        Wed, 21 Dec 2022 02:20:58 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EB446602CBE;
        Wed, 21 Dec 2022 10:20:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671618057;
        bh=4XAFAvREPt9mELPunubuWmSA1SRawFig707S7i4tp50=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L824nQQwaWZop8xOF/IUB0BVf5zE6Osn1O5fsLXd+eOrIxOAZBMuv/jfXG0fPJQQ0
         4uXxLaodRCsn/RQWdbdI97iIHvIC+ndpro0wiEe56Tea7uTQuR2qwpqsWH0z1GbcZR
         5QDxV0H1+rUA1D7LLlW55spD9A9EbCqbvycdJ1hHfdU3xqq3sHzVohhwHCuX9J7UF5
         Zea1OkPR/j6GuwFIXggmWKMrL0zASp7BAqsGfylBIy62LQiyUBUttD8iSRp5+n9boV
         6/P7NFLmB3pEIc+4WL00G8FNI/+y8E4PtfkSo6I16eGJvmzGCliE8PAcvHeD48auzm
         imZqL9D8bu7Sw==
Message-ID: <7cba92b5-b0fe-cb26-cdec-463a00657d29@collabora.com>
Date:   Wed, 21 Dec 2022 11:20:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/6] soc: mediatek: pm-domains: Add buck isolation
 setting in power domain
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ikjoon Jang <ikjn@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
References: <20221221034407.19605-1-allen-kh.cheng@mediatek.com>
 <20221221034407.19605-3-allen-kh.cheng@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221221034407.19605-3-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 21/12/22 04:44, Allen-KH Cheng ha scritto:
> In MT8192, we need to disable EXT_BUCK_ISO before turning on the ADSP
> power pm-domains (mtcmos).
> 
> Add the MTK_SCPD_EXT_BUCK_ISO flag to control the buck isolation
> setting in the mediatek power domain driver.
> 
> Fixes: 59b644b01cf4 ("soc: mediatek: Add MediaTek SCPSYS power domains")
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-pm-domains.c | 8 ++++++++
>   drivers/soc/mediatek/mtk-pm-domains.h | 1 +
>   2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-pm-domains.c b/drivers/soc/mediatek/mtk-pm-domains.c
> index 09e3c38b8466..63f1e183f645 100644
> --- a/drivers/soc/mediatek/mtk-pm-domains.c
> +++ b/drivers/soc/mediatek/mtk-pm-domains.c
> @@ -218,6 +218,10 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>   	if (ret)
>   		goto err_reg;
>   
> +	if (MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))

if (pd->data->ext_buck_iso_offs && MTK_SCPD_CAPS(pd, MTK_SCPD_EXT_BUCK_ISO))
	regmap_[...etc]

...so that we validate that ext_buck_iso_offs is actually present (as I
suppose that this is supposed to *never* be 0x0).

Regards,
Angelo
