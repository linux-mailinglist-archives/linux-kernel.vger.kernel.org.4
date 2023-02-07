Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14AD68D01D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjBGHHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjBGHHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:07:46 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029712D50
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:07:45 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id j1so2605691uan.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 23:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ryLOEKWbee+ndjps07t4kDI2Eg2FatHh2fvzWokSXBU=;
        b=eoZ6mKxOp2w6xUsUEooFANxsnzN/A6kMbr5e8jO18lPmqMXcrsWo3B88hanIbtdLAE
         0xFl1kDIp6B2Y6mHtnh+RrLHHU2iHC1HmSAeOtyo6DAd7O4MqxbGhU5dygKI8JAMdVEl
         yLi/knhfNvEXH9lE9ivUjFclZySG+12+smFQg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryLOEKWbee+ndjps07t4kDI2Eg2FatHh2fvzWokSXBU=;
        b=t2BvL1aoH/uFmSZFqFASvFpOCERLas93b5UmdLjff56VmwCHETsg0dasbiQyQmaUU2
         46+eygQFJ5J0/jwW3BpOJuK6wTq0JQEMhWS2dH9EaWyYn3eUn3Ayj6ahKvJFQ16mTZO+
         RlHChmFsA4dc2KHxnsV0XOxH3dVFpvb++FB/FeFak6dwwM6gQgxEsHd7HWzSFY3ZIT7b
         jhnrp4dtHbbeypj92eL0Em7HDM+uKjvHSoO/B4hb4DOq3mbI5FGWLHF67r4lM+EnP/Vy
         ztKO6UzkXPKM6CYyNaQKrGgbxfQ2R2WuRRG7zqDL/V+U7hJj9xvBe2dTm0+M4rhCedHB
         Q6rw==
X-Gm-Message-State: AO0yUKXhk0d8A2YiFDtPqXTGcZOI4vsHFOFDuden2zHMsiW36UevyN9V
        Dmse5qALDE0pZXTaA0RqBnuFh1M/Q3XlpdPk8w22aQ==
X-Google-Smtp-Source: AK7set/bGnKz5U9kIPIfo8WqyaYvhc91nHxy9RmnWyFXodO5/eIlBgd4lmr1uUB0s2fHTNklpOlu2qX7HHS/cqrlwlc=
X-Received: by 2002:ab0:3b90:0:b0:683:c74a:af60 with SMTP id
 p16-20020ab03b90000000b00683c74aaf60mr362260uaw.74.1675753664132; Mon, 06 Feb
 2023 23:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-9-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-9-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 15:07:33 +0800
Message-ID: <CAGXv+5GAHngx89bts_SMxh3kD=4kNP9LYLc-J3pixKojVs=GMg@mail.gmail.com>
Subject: Re: [PATCH v1 08/45] clk: mediatek: mt2712: Move apmixedsys clock
 driver to its own file
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> The only clock driver that does not support mtk_clk_simple_probe() is
> apmixedsys: in preparation for enabling module build of non-critical
> mt2712 clocks, move this to its own file.
> While at it, also fix some indentation issues in the PLLs table.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/Makefile                |   2 +-
>  drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 152 +++++++++++++++++
>  drivers/clk/mediatek/clk-mt2712.c            | 164 -------------------
>  3 files changed, 153 insertions(+), 165 deletions(-)
>  create mode 100644 drivers/clk/mediatek/clk-mt2712-apmixedsys.c
>
> diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
> index e5d018270ed0..3c7dd19cdddf 100644
> --- a/drivers/clk/mediatek/Makefile
> +++ b/drivers/clk/mediatek/Makefile
> @@ -38,7 +38,7 @@ obj-$(CONFIG_COMMON_CLK_MT2701_HIFSYS) += clk-mt2701-hif.o
>  obj-$(CONFIG_COMMON_CLK_MT2701_IMGSYS) += clk-mt2701-img.o
>  obj-$(CONFIG_COMMON_CLK_MT2701_MMSYS) += clk-mt2701-mm.o
>  obj-$(CONFIG_COMMON_CLK_MT2701_VDECSYS) += clk-mt2701-vdec.o
> -obj-$(CONFIG_COMMON_CLK_MT2712) += clk-mt2712.o
> +obj-$(CONFIG_COMMON_CLK_MT2712) += clk-mt2712.o clk-mt2712-apmixedsys.o
>  obj-$(CONFIG_COMMON_CLK_MT2712_BDPSYS) += clk-mt2712-bdp.o
>  obj-$(CONFIG_COMMON_CLK_MT2712_IMGSYS) += clk-mt2712-img.o
>  obj-$(CONFIG_COMMON_CLK_MT2712_JPGDECSYS) += clk-mt2712-jpgdec.o
> diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
> new file mode 100644
> index 000000000000..e841be3a02c9
> --- /dev/null
> +++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2017 MediaTek Inc.
> + * Copyright (c) 2023 Collabora Ltd.
> + * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> + */
> +#include <linux/clk.h>

Missed one. I think you would want <linux/clk-provider.h> instead?
And you could drop the header from drivers/clk/mediatek/clk-mt2712.c

ChenYu
