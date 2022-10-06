Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C625F6369
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiJFJQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:16:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231363AbiJFJP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:15:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6868C449;
        Thu,  6 Oct 2022 02:15:55 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D1C966022F9;
        Thu,  6 Oct 2022 10:15:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665047754;
        bh=5fVE/DrwU8k543ezqYxJj3KgWv2kkl6AOAI2rFqsjAo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e/dPgR5hRXC9cYBOE61HPI5ZXHPIAHPs7oR/MtClhA0VGY3NUyN7WXK/Ou8KDMr/i
         ivaG5zxpTVw/4vCb9fSH2xgwHpyz/0i23X7DfDllM3K1KVp4q31BbiKH64bbpbab7J
         8NKs3HQdr/7LXOE+M1WLU4vlMsPF7PAjrDZ6Qp7EmVOIQqRvDIo15U7DuAEhJZ9jOM
         wADppJdVCRM2OHAskkBaUkJ3SKKNWTPOm215Ui0eymRq1BoQfWnYrxGxCOdYpWoXFi
         1cNLKSQxG28DxqKsAczJ9+jdp9JRzUEXle7qe6zCpsX8ALzMqWAuKMg4USaUKQdKc/
         rWaugsiUK28cg==
Message-ID: <3430472e-0da3-4e92-7e40-b5b9731db98e@collabora.com>
Date:   Thu, 6 Oct 2022 11:15:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 10/10] pinctrl: mediatek: Add MT6735 pinctrl driver
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221005174343.24240-1-y.oudjana@protonmail.com>
 <20221005174343.24240-11-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005174343.24240-11-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/10/22 19:43, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add a driver for the MediaTek MT6735 SoC pin controller. This driver
> also supports the pin controller on MT6735M, which lacks 6 physical
> pins (198-203) used for MSDC2 on MT6735.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   MAINTAINERS                                   |    8 +
>   drivers/pinctrl/mediatek/Kconfig              |    6 +
>   drivers/pinctrl/mediatek/Makefile             |    1 +
>   drivers/pinctrl/mediatek/pinctrl-mt6735.c     |  584 +++
>   drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h | 3993 +++++++++++++++++
>   5 files changed, 4592 insertions(+)
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mt6735.c
>   create mode 100644 drivers/pinctrl/mediatek/pinctrl-mtk-mt6735.h
> 

..snip..

> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6735.c b/drivers/pinctrl/mediatek/pinctrl-mt6735.c
> new file mode 100644
> index 000000000000..dd9dad9cb142
> --- /dev/null
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt6735.c
> @@ -0,0 +1,584 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022 Yassine Oudjana <y.oudjana@protonmail.com>
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "pinctrl-mtk-mt6735.h"
> +#include "pinctrl-paris.h"
> +

..snip..

> +
> +/* Pin group registers */
> +#define GPIO_IES	0x000
> +#define GPIO_SMT	0x010
> +#define GPIO_TDSEL0	0x020
> +#define	GPIO_TDSEL1	0x024

This is the only reason why I can't give you a Reviewed-by, and I'm sad about that.
Please fix that tabulation after #define.

> +#define GPIO_RDSEL0	0x028
> +#define GPIO_RDSEL1	0x02c
> +#define GPIO_PULLEN0	0x030
> +#define GPIO_PULLEN1	0x040
> +#define GPIO_PULLSEL0	0x050
> +#define GPIO_PULLSEL1	0x060
> +#define	GPIO_DRV0	0x070
> +#define	GPIO_DRV1	0x074

...and same here.

> +#define GPIO_PUPD0	0x080
> +#define GPIO_PUPD1	0x090
> +

Thanks,
Angelo
