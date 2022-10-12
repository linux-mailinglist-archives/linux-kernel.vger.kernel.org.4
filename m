Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54F475FCF08
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 01:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJLXqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 19:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLXqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 19:46:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06BD104518;
        Wed, 12 Oct 2022 16:46:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61EA0B8119D;
        Wed, 12 Oct 2022 23:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE5C433D7;
        Wed, 12 Oct 2022 23:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665618362;
        bh=+pfUEiIduhlBNqrU0eti7CXzRvmEWK6fBNSEQDXl2Z4=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ANOCASuA/JRNVv2hDArfLiUrCT0q/dFzdQGyWNdMIjZDsREUKUmCGWSHA44Vk1uoR
         ZmosuECpa04PalV+Y9Aw4sG8lvv4ab9bTjZ36jBAbD305L/slSuKlOBARK8pjtvbuF
         xIKDb+nu6ge6JeCXC98VFNoaa5qpqwG2W1ItzF2nJBa1cvuBVDxZwhioaTWjDG1MIB
         J6OzD7L+qDYGMLAqbUyxp0y6aA6B6gCcJbpyEAF/R7Ve39BSHKPjDc8R2I/fkqTktP
         kx/guGIEHszsDcmMgHuLL15Gf3qWuN3tu5BgpCSUV6AQBIscVMn+mIla1Osh6lcS5X
         lAEoVDJmnuVUw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20221007104842.13164-1-rex-bc.chen@mediatek.com>
References: <20221007104842.13164-1-rex-bc.chen@mediatek.com>
Subject: Re: [PATCH v5] reset: mediatek: Move mediatek system clock reset to reset folder
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     runyang.chen@mediatek.com, miles.chen@mediatek.com,
        wenst@chromium.org, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
To:     Bo-Chen Chen <rex-bc.chen@mediatek.com>, matthias.bgg@gmail.com,
        mturquette@baylibre.com, p.zabel@pengutronix.de
Date:   Wed, 12 Oct 2022 16:45:59 -0700
User-Agent: alot/0.10
Message-Id: <20221012234601.E1BE5C433D7@smtp.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bo-Chen Chen (2022-10-07 03:48:42)
> To manager mediatek system clock reset easier, we move the driver to
> drivers/reset.
>=20
> - Create reset/mediatek folder.
> - Move clk/mediatek/reset.c to reset/mediatek/reset-mediatek-sysclk.c
> - Because we don't want to build in unsed static variable (For example,
>   if we use mt8186, we don't want to build in the variable of MT8195.),
>   we use clk KConfig to do this.
> - Move reset data which are scattered around the mediatek drivers to
>   reset-mtxxxx.c.
> - For mtk clk drivers which support device, we can ues
>   mtk_reset_controller_register() to register reset controller using
>   auxiliary bus.
> - For mtk clk drivers which do not support device (only support
>   device_node), we use mtk_reset_{init/remove}_with_node to register
>   reset controller.
>=20
> Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
[...]
> diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
> index 843cea0c7a44..bcd073ada0e9 100644
> --- a/drivers/clk/mediatek/Kconfig
> +++ b/drivers/clk/mediatek/Kconfig
> @@ -8,6 +8,8 @@ menu "Clock driver for MediaTek SoC"
>  config COMMON_CLK_MEDIATEK
>         tristate
>         select RESET_CONTROLLER
> +       select RESET_MEDIATEK_SYSCLK

Is this select necessary?

> +       select AUXILIARY_BUS
>         help
>           MediaTek SoCs' clock support.
> =20
> diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mt=
k.c
> index d31f01d0ba1c..61b7ee23738a 100644
> --- a/drivers/clk/mediatek/clk-mtk.c
> +++ b/drivers/clk/mediatek/clk-mtk.c
> @@ -444,6 +444,63 @@ void mtk_clk_unregister_dividers(const struct mtk_cl=
k_divider *mcds, int num,
>  }
>  EXPORT_SYMBOL_GPL(mtk_clk_unregister_dividers);
> =20
> +static void mtk_reset_unregister_adev(void *_adev)
> +{
> +       struct auxiliary_device *adev =3D _adev;
> +
> +       auxiliary_device_delete(adev);
> +}
> +
> +static void mtk_reset_adev_release(struct device *dev)
> +{
> +       struct auxiliary_device *adev =3D to_auxiliary_dev(dev);
> +
> +       auxiliary_device_uninit(adev);
> +
> +       kfree(adev);
> +}
> +
> +static struct auxiliary_device *mtk_reset_adev_alloc(struct device *dev,=
 const char *name)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev =3D kzalloc(sizeof(*adev), GFP_KERNEL);
> +       if (!adev)
> +               return ERR_PTR(-ENOMEM);
> +
> +       adev->name =3D name;
> +       adev->dev.parent =3D dev;
> +       adev->dev.release =3D mtk_reset_adev_release;
> +
> +       ret =3D auxiliary_device_init(adev);
> +       if (ret) {
> +               kfree(adev);
> +               return ERR_PTR(ret);
> +       }
> +
> +       return adev;
> +}
> +
> +int mtk_reset_controller_register(struct device *dev, const char *name)
> +{
> +       struct auxiliary_device *adev;
> +       int ret;
> +
> +       adev =3D mtk_reset_adev_alloc(dev, name);
> +       if (IS_ERR(adev))
> +               return PTR_ERR(adev);
> +
> +       ret =3D auxiliary_device_add(adev);
> +       if (ret) {
> +               auxiliary_device_uninit(adev);
> +               return ret;
> +       }
> +
> +       return devm_add_action_or_reset(dev, mtk_reset_unregister_adev, a=
dev);
> +}
> +EXPORT_SYMBOL_GPL(mtk_reset_controller_register);
> +
>  int mtk_clk_simple_probe(struct platform_device *pdev)
>  {
>         const struct mtk_clk_desc *mcd;
> @@ -470,9 +527,8 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
> =20
>         platform_set_drvdata(pdev, clk_data);
> =20
> -       if (mcd->rst_desc) {
> -               r =3D mtk_register_reset_controller_with_dev(&pdev->dev,
> -                                                          mcd->rst_desc);
> +       if (mcd->rst_name) {
> +               r =3D mtk_reset_controller_register(&pdev->dev, mcd->rst_=
name);
>                 if (r)
>                         goto unregister_clks;
>         }

Can you split this part off to a different patch? It would make it
easier to review. And then you stack the reset part of the patch after
this.

> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mt=
k.h
> index 63ae7941aa92..9578643ef5a2 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -7,14 +7,14 @@
>  #ifndef __DRV_CLK_MTK_H
>  #define __DRV_CLK_MTK_H
> =20
> +#include <linux/auxiliary_bus.h>
>  #include <linux/clk-provider.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> +#include <linux/reset/reset-mediatek-sysclk.h>
>  #include <linux/spinlock.h>
>  #include <linux/types.h>
> =20
> -#include "reset.h"
> -
>  #define MAX_MUX_GATE_BIT       31
>  #define INVALID_MUX_GATE_BIT   (MAX_MUX_GATE_BIT + 1)
> =20
> @@ -195,10 +195,12 @@ void mtk_clk_unregister_ref2usb_tx(struct clk_hw *h=
w);
>  struct mtk_clk_desc {
>         const struct mtk_gate *clks;
>         size_t num_clks;
> -       const struct mtk_clk_rst_desc *rst_desc;
> +       char *rst_name;
>  };
> =20
>  int mtk_clk_simple_probe(struct platform_device *pdev);
>  int mtk_clk_simple_remove(struct platform_device *pdev);
> =20
> +int mtk_reset_controller_register(struct device *dev, const char *name);
> +
>  #endif /* __DRV_CLK_MTK_H */
> diff --git a/drivers/clk/mediatek/reset.c b/drivers/clk/mediatek/reset.c
> deleted file mode 100644
> index 290ceda84ce4..000000000000
> --- a/drivers/clk/mediatek/reset.c
> +++ /dev/null

This file could probably be deleted in yet another patch once nobody is
using it.
