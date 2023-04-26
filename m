Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C736EF3FA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 14:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240784AbjDZMG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 08:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240267AbjDZMGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 08:06:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B695B85;
        Wed, 26 Apr 2023 05:06:23 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6420A660036F;
        Wed, 26 Apr 2023 13:06:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682510782;
        bh=OfMlzuTrSWbL6RmSjUOMVmGVdnb1BVtFW+nmxN56VS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DPPysip393PCjfe9Jv+L2SXJuYsGGsHvvK1XWXBikxECYbVFvi/PhDIaAeepxrAL7
         +wJpLFS1g8wTc4+JN6TZYN4waXDzKuSCrFSe3UPdGsalhSBUGqqMWAbSASbRC0hSW3
         AODPeJIo40uTfCCReDOlt15TyZCnMp0yEA6AEhkqlYUuxbXrzQoxHX/qPeUX8MOEdr
         eKD9lPe+MzEvZrNTxRJziSdAgghr//60ohBw/K9jvUEPgjHfVUQ26TERUBZ2QlWsoI
         kTEze4VfJf0ahBK+l+o6Ht28PDMQZmwAp4oU3WEkBZ3hX+ugF17r7KN+TpWLYFpC0r
         jQVZrI6+fNDRQ==
Message-ID: <0c8d08e2-770a-1ec2-e990-1d48bfc0eac6@collabora.com>
Date:   Wed, 26 Apr 2023 14:06:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RESEND v3 6/9] drm/mediatek: Add gamma support different
 bank_size for other SoC
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220912013006.27541-1-jason-jh.lin@mediatek.com>
 <20220912013006.27541-7-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220912013006.27541-7-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/09/22 03:30, Jason-JH.Lin ha scritto:
> Add multiple bank support for mt8195.
> If bank size is 0 which means no bank support.
> 
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 45 +++++++++++++----------
>   1 file changed, 26 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> index be82d15a5204..45da2b6206c8 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> @@ -21,6 +21,7 @@
>   #define GAMMA_LUT_EN					BIT(1)
>   #define GAMMA_DITHERING					BIT(2)
>   #define DISP_GAMMA_SIZE				0x0030
> +#define DISP_GAMMA_BANK				0x0100
>   #define DISP_GAMMA_LUT				0x0700
>   
>   #define LUT_10BIT_MASK				0x03ff
> @@ -33,6 +34,7 @@ struct mtk_disp_gamma_data {
>   	bool lut_diff;
>   	u16 lut_size;
>   	u8 lut_bits;
> +	u16 bank_size;
>   };
>   
>   /*
> @@ -75,9 +77,10 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
>   	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
>   	bool lut_diff = false;
>   	u16 lut_size = LUT_SIZE_DEFAULT;
> +	u16 bank_size = lut_size;

Just use gamma->data->bank_size directly, as platform data is always present.

>   	u8 lut_bits = LUT_BITS_DEFAULT;
>   	u8 shift_bits;
> -	unsigned int i, reg;
> +	unsigned int i, j, reg, bank_num;
>   	struct drm_color_lut *lut;
>   	void __iomem *lut_base;
>   	u32 word, mask;
> @@ -87,8 +90,10 @@ void mtk_gamma_set_common(struct device *dev, void __iomem *regs, struct drm_crt
>   		lut_diff = gamma->data->lut_diff;
>   		lut_size = gamma->data->lut_size;
>   		lut_bits = gamma->data->lut_bits;
> +		bank_size = gamma->data->bank_size;

You shall set bank_size = 512 to MT8173 and MT8183, otherwise they break, as this
will set bank_size to 0.

>   	}
>   
> +	bank_num = lut_size / bank_size;
>   	shift_bits = LUT_INPUT_BITS - lut_bits;
>   	mask = GENMASK(lut_bits - 1, 0);
>   

Regards,
Angelo

