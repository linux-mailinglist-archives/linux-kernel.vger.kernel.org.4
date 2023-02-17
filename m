Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4169A62D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjBQHhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjBQHhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:37:48 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCD55DE0E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:37:46 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id d66so4679850vsd.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P7w2nsj+BPyzWeqVlSJ1h+PblPLRF+B8VDDNr9VLL6Y=;
        b=H5L2d+NhIswiKXwwkO0FV43AoayGluXrnMNLZcrQte38M8LVO/AwQYO11kryqQtguB
         zUMoULjT9e+/wPTmU7FPBZaJe9GTgVUE827NMb+dFosXL9Ca2pscyHXSCGQJTJAGGb8/
         EnRfF7yqrLFshOXJqWF3u8yC2dMP8Tg2E8DZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7w2nsj+BPyzWeqVlSJ1h+PblPLRF+B8VDDNr9VLL6Y=;
        b=l8HvhMAiblMu3QyfoLJVZ7vWxZYVq/qUY1HxlB+1Cwfz7sHp9+XdfXCssOZ/aty7dZ
         LX9Kl5jJFLjP7K/vFcWAu5w1ug9Me5vaBZH16BJtPEczwybs1xN8vHTvzsaKuqkNWpeW
         a2A8z2kVKTVLm9jVXVWziHOgY/ssgsOHX1kT8nmXE19orGiKM3hXaa0A7x5iCLf3VEKA
         6InqNPeLN4y4CAyG10b/rFGnviWWxaxr98iS2ATgC7cfNHg0mNMYn3sGNWfW5pJR5xuA
         f5zbHP14foM90VggguW7GR2eAdyp2F/m8J0ttGruhfdhbfYuj3PLFHhUlLEZfYi64CzT
         WwfA==
X-Gm-Message-State: AO0yUKU/dgsaLrMZy7kpbPwMSBZa1K87G1ut9B+dIiO2mx5TSMGSA2Dd
        R/lAE6r90Xycig0t0lEPH1ljmfQPF7TQ6c7omq/ZGQ==
X-Google-Smtp-Source: AK7set8j7+F3ZFMEJGFoWnVWh6MfPilnGHfz77xcGdvx1oI3rzUkBVSr7gZdqtonaWqySsWjv0S8Z1IeLYtIP/tTnL8=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1603745vso.60.1676619465306; Thu, 16 Feb
 2023 23:37:45 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-38-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-38-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 15:37:34 +0800
Message-ID: <CAGXv+5Gf6idN3LMkei503cXnuxo7HNc8=8fG0jENVHDtxDg5jQ@mail.gmail.com>
Subject: Re: [PATCH v2 37/47] clk: mediatek: Split MT8195 clock drivers and
 allow module build
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@kernel.org>
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
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

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> MT8195 clock drivers were encapsulated in one single (and big) Kconfig
> option: there's no reason to do that, as it is totally unnecessary to
> build in all or none of them.
>
> Split them out: keep boot-critical clocks as bool and allow choosing
> non critical clocks as tristate.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  drivers/clk/mediatek/Kconfig  | 86 +++++++++++++++++++++++++++++++++++
>  drivers/clk/mediatek/Makefile | 20 +++++---
>  2 files changed, 99 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 45b7aea7648d..88937d111e98 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -692,6 +692,92 @@ config COMMON_CLK_MT8195
>          help
>            This driver supports MediaTek MT8195 clocks.
>
> +config COMMON_CLK_MT8195_APUSYS
> +       tristate "Clock driver for MediaTek MT8195 apusys"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 AI Processor Unit System clocks.
> +
> +config COMMON_CLK_MT8195_AUDSYS
> +       tristate "Clock driver for MediaTek MT8195 audsys"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 audsys clocks.
> +
> +config COMMON_CLK_MT8195_CAMSYS
> +       tristate "Clock driver for MediaTek MT8195 camsys"
> +       depends on COMMON_CLK_MT8195_VPPSYS

One other thing. If a Kconfig option immediately follows its dependency,
then it gets indented nicely in menuconfig, but only if.
If other options are interspersed, then the indentation gets reset.

So could you reorder the options to follow the dependency graph?

Also how you chose the dependencies should be mentioned in the commit log.
These are pure run time dependencies, not compile time nor link/load ones.

Last, I think an argument could be made against the proliferation of
Kconfig options, as it dramatically increases the combinations of
allrandconfigs. Maybe Arnd (who IIRC frequently runs allrandconfig)
could chime in on whether this is actually a concern or not.

> +       help
> +         This driver supports MediaTek MT8195 camsys and camsys_raw clocks.
> +
> +config COMMON_CLK_MT8195_IMGSYS
> +       tristate "Clock driver for MediaTek MT8195 imgsys"
> +       depends on COMMON_CLK_MT8195_VPPSYS
> +       help
> +         This driver supports MediaTek MT8195 imgsys and imgsys2 clocks.
> +
> +config COMMON_CLK_MT8195_IMP_IIC_WRAP
> +       tristate "Clock driver for MediaTek MT8195 imp_iic_wrap"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 I2C/I3C clocks.
> +
> +config COMMON_CLK_MT8195_IPESYS
> +       tristate "Clock driver for MediaTek MT8195 ipesys"
> +       depends on COMMON_CLK_MT8195_IMGSYS
> +       help
> +         This driver supports MediaTek MT8195 ipesys clocks.
> +
> +config COMMON_CLK_MT8195_MFGCFG
> +       tristate "Clock driver for MediaTek MT8195 mfgcfg"
> +       depends on COMMON_CLK_MT8195
> +       help
> +         This driver supports MediaTek MT8195 mfgcfg clocks.
> +
> +config COMMON_CLK_MT8195_VDOSYS
> +       tristate "Clock driver for MediaTek MT8195 vdosys"
> +       depends on COMMON_CLK_MT8195

Not sure why this option is here, out of order?

> +       help
> +         This driver supports MediaTek MT8195 vdosys0/1 (multimedia) clocks.

[...]

ChenYu
