Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05E9361F18D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 12:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbiKGLKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 06:10:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiKGLKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 06:10:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4EB183A4;
        Mon,  7 Nov 2022 03:09:30 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7DBCB6601FAA;
        Mon,  7 Nov 2022 11:09:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667819368;
        bh=3+hQs9VHQA+nTYY5byObobXjo39vdKrxEvf02IpmXUE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bxB5RRvKO4DSosZ9cHjzG7jHLzq5OAyxZQIfjtyCIb0A7ERl6SEoroCKpmDDyvyfb
         g5Kwegwvs1sq/qMY7l4ruYFPYHSkLVRjXGVPSCZfY3J27XBB9pCqWQA0ENttlQdKsp
         HfhnjHOftYpw7rG7dFoXrsqNIHitfFoh1aFW3WL9GjtbwFpjRaMumTewT5xoMEC42H
         wbIAEqK56Nb4h2vb2obmpQYN0fMnsv9zEN4LGBZlghpKFvR0hSvhnrhz9v1uekaAwu
         TKKIu7Axs6aD2WUE1YSu2hr9qPlA/XWQsIso9NPOOZjNrQ6PyeI4NFM6PKYcNZ9ibT
         wMRRcfioQgOKQ==
Message-ID: <f8e05f55-635c-f63c-9624-f8ccadcd1add@collabora.com>
Date:   Mon, 7 Nov 2022 12:09:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 04/12] drm/mediatek: extract common functions from the
 mtk hdmi driver
Content-Language: en-US
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, CK Hu <ck.hu@mediatek.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org, stuart.lee@mediatek.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        mac.shen@mediatek.com, linux-phy@lists.infradead.org
References: <20220919-v3-0-a803f2660127@baylibre.com>
 <20220919-v3-4-a803f2660127@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220919-v3-4-a803f2660127@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/11/22 15:09, Guillaume Ranquet ha scritto:
> Create a common "framework" that can be used to add support for
> different hdmi IPs within the mediatek range of products.
> 
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---
>   drivers/gpu/drm/mediatek/Makefile          |   3 +-
>   drivers/gpu/drm/mediatek/mtk_hdmi.c        | 620 ++---------------------------
>   drivers/gpu/drm/mediatek/mtk_hdmi.h        |  16 +
>   drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 433 ++++++++++++++++++++
>   drivers/gpu/drm/mediatek/mtk_hdmi_common.h | 221 ++++++++++
>   5 files changed, 704 insertions(+), 589 deletions(-)
> 

..snip..

> diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
> new file mode 100644
> index 000000000000..3f08d37b1af0
> --- /dev/null
> +++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c

..snip..

> +
> +int mtk_hdmi_setup_avi_infoframe(struct mtk_hdmi *hdmi, u8 *buffer, size_t bufsz,
> +				 struct drm_display_mode *mode)

warning: no previous prototype for ‘mtk_hdmi_setup_avi_infoframe’ 
[-Wmissing-prototypes]

Please fix.

Thanks,
Angelo
