Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A335EF066
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 10:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbiI2I02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 04:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235469AbiI2I0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 04:26:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4E109778
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 01:26:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 76E7066022A4;
        Thu, 29 Sep 2022 09:26:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664439973;
        bh=KWUoXXAk6o0BCBiAsiGqrnHSb/eXnc4H+xT7gm5rr6c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lctdJjd3YIz0jsS7WT5B+VBKJKB1m3r95Q6IpGrU1RYiFo0WJYcOWbfpHz69nHark
         55T7CDlYAHhnfHS8tkKNHirgzQ7zmZatrRJSNHQHjvXzD+07bxsgdVA4evDMrIjyhA
         jYd/ojiwuNNs1qm0+Orej6yIZFcAJ9PwNPbn52tKMcseLaGkmXEtH49VywHTM/yXuU
         V31bgXhA8m4JkB5uNct6Q3ebmaA1w2F/hOj28qr4QBxjMtYs/jqkgMVNkrYBpxENIr
         JRuto3vGG1inYX0GcPM1rTU+36AxgZtmNYB2kXUEhelsCxGrZrzirKLdXhlnQp4Crq
         NN70nw6jqNMHw==
Message-ID: <050439a2-bd54-54ec-10da-ff8d3a2b50ca@collabora.com>
Date:   Thu, 29 Sep 2022 10:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 5/8] soc: mediatek: mtk-svs: Move SoC specific functions
 to new files
Content-Language: en-US
To:     matthias.bgg@kernel.org, roger.lu@mediatek.com,
        jia-wei.chang@mediatek.com
Cc:     nfraprado@collabora.com, khilman@baylibre.com,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
References: <20220928155519.31977-1-matthias.bgg@kernel.org>
 <20220928155519.31977-6-matthias.bgg@kernel.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220928155519.31977-6-matthias.bgg@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 28/09/22 17:55, matthias.bgg@kernel.org ha scritto:
> From: Matthias Brugger <matthias.bgg@gmail.com>
> 
> With every SoC added to the driver, it grows. Move SoC specific
> callbacks to a new source files.
> 
> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
> 
>   drivers/soc/mediatek/Makefile         |   3 +-
>   drivers/soc/mediatek/mt8183-svs.h     | 113 ++++
>   drivers/soc/mediatek/mt8192-svs.h     |  64 ++
>   drivers/soc/mediatek/mtk-svs-mt8183.c | 234 ++++++++
>   drivers/soc/mediatek/mtk-svs-mt8192.c | 100 ++++
>   drivers/soc/mediatek/mtk-svs.c        | 831 ++------------------------
>   drivers/soc/mediatek/mtk-svs.h        | 279 +++++++++
>   7 files changed, 837 insertions(+), 787 deletions(-)
>   create mode 100644 drivers/soc/mediatek/mt8183-svs.h
>   create mode 100644 drivers/soc/mediatek/mt8192-svs.h
>   create mode 100644 drivers/soc/mediatek/mtk-svs-mt8183.c
>   create mode 100644 drivers/soc/mediatek/mtk-svs-mt8192.c
>   create mode 100644 drivers/soc/mediatek/mtk-svs.h
> 
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
> index 0e9e703c931a..851131638644 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -7,4 +7,5 @@ obj-$(CONFIG_MTK_SCPSYS) += mtk-scpsys.o
>   obj-$(CONFIG_MTK_SCPSYS_PM_DOMAINS) += mtk-pm-domains.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mmsys.o
>   obj-$(CONFIG_MTK_MMSYS) += mtk-mutex.o
> -obj-$(CONFIG_MTK_SVS) += mtk-svs.o
> +mtk_svs-objs := mtk-svs.o mtk-svs-mt8183.o mtk-svs-mt8192.o
> +obj-$(CONFIG_MTK_SVS) += mtk_svs.o
> diff --git a/drivers/soc/mediatek/mt8183-svs.h b/drivers/soc/mediatek/mt8183-svs.h
> new file mode 100644
> index 000000000000..89c0deb9fb11
> --- /dev/null
> +++ b/drivers/soc/mediatek/mt8183-svs.h
> @@ -0,0 +1,113 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef __DRV_SVS_MT8183_H
> +#define __DRV_SVS_MT8183_H
> +

Please avoid implicit header inclusion (here and in mt8192-svs.h).

#include "mtk-svs.h"

Cheers,
Angelo


