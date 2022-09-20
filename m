Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5154C5BE42A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 13:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiITLLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 07:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbiITLLn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 07:11:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193A912746;
        Tue, 20 Sep 2022 04:11:42 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 119786601F41;
        Tue, 20 Sep 2022 12:11:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663672300;
        bh=QSpSDTgYCpqgFq+O5bVL9KBXyxjvk1qUR8EKvHpwW60=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e/u8yuCL8pOpihKA+yEqSrBZAFKnJt1+3WV3WVVHWqL9sjeK0w/HabOuNuQjM5ZdG
         a7yx0xVV0Ri3EbQUDUJB79KC+2BgDdTCFZAcP8hle6RbibPIhM2QkLe+1XSuPxbDv+
         eApEkDjpEhr94a7oaqtQCp7ku5aaeR+33SmmLe5+f3Uqvs4sd4jjVjwLJf7/KxhqvU
         m8ppQ/8kheumqjbVTxvLrw6/gPYzE2IW9m1aJcIOaaZ3pz5lqRcU+U4+kf5pSDc54s
         pbIyF+h/9Cp2jLgufGA9GvqonCUrfDWqbvYM/TlXEuRZFJdSCpjzy+VtKTGAWYHBpO
         Fk/H+Wtug4PTg==
Message-ID: <b05f8687-8f34-c425-ed8e-56c8aeccdaf9@collabora.com>
Date:   Tue, 20 Sep 2022 13:11:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v1 12/17] drm/mediatek: hdmi: mt8195: add audio support
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Pablo Sun <pablo.sun@mediatek.com>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org
References: <20220919-v1-0-4844816c9808@baylibre.com>
 <20220919-v1-12-4844816c9808@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919-v1-12-4844816c9808@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 19/09/22 18:56, Guillaume Ranquet ha scritto:
> Add HDMI audio support for mt8195
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_mt8195_hdmi.c b/drivers/gpu/drm/mediatek/mtk_mt8195_hdmi.c
> index 39e07a6dd490..bb7593ea4c86 100644
> --- a/drivers/gpu/drm/mediatek/mtk_mt8195_hdmi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_mt8195_hdmi.c
> @@ -215,6 +215,26 @@ static void mtk_hdmi_hw_vid_black(struct mtk_hdmi *hdmi, bool black)
>   		mtk_hdmi_mask(hdmi, TOP_VMUTE_CFG1, 0, REG_VMUTE_EN);
>   }
>   
> +static void mtk_hdmi_hw_aud_mute(struct mtk_hdmi *hdmi)
> +{
> +	u32 val;
> +
> +	val = mtk_hdmi_read(hdmi, AIP_CTRL, &val);
> +

val_tx = AUD_MUTE_FIFO_EN;
if (val & DSD_EN)
	val_tx |= DSD_MUTE_DATA;

regmap_set_bits(regmap, AIP_TXCTRL, val_tx);

Easier, shorter.

> +	if (val & DSD_EN)
> +		mtk_hdmi_mask(hdmi, AIP_TXCTRL,
> +			      DSD_MUTE_DATA | AUD_MUTE_FIFO_EN,
> +			      DSD_MUTE_DATA | AUD_MUTE_FIFO_EN);
> +	else
> +		mtk_hdmi_mask(hdmi, AIP_TXCTRL, AUD_MUTE_FIFO_EN,
> +			      AUD_MUTE_FIFO_EN);
> +}

Regards,
Angelo

