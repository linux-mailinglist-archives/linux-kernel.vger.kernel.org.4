Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D227279BD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234864AbjFHIMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbjFHIMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:12:31 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FCE2700
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:12:29 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-465db156268so65299e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686211948; x=1688803948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cAiwpr4ZhLz8drmLYbFRJeJlB43Bw/gRsi8DXM2zl1Q=;
        b=IEpW9QFjXmCUJ9pMxaLKoDnKjHHCSS3HNrFXVJ6GB6w8VcCMmyyIITHm+Wq6agO0oV
         hhdPy6bo6ftpC5VEPT5yRIlvkChqHqzbct/Gu0Ciobgb5knyJ4ubr3jM2JsNgPmyKWre
         crohC1Y0fr8/2j+WplE2CQbon9ggtXVIBX5J4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686211948; x=1688803948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAiwpr4ZhLz8drmLYbFRJeJlB43Bw/gRsi8DXM2zl1Q=;
        b=FX6SC+LXSEE2fo7QtzlyllItGUGlqiUTn1RA/FVI0FUPWikxZjW87lWBlO1ROHytYM
         G+QFJ+m28t3YD0qMMQmAHPo2eUfODYJ6GT/a3cRqe/gyItlI/xOWD5AJQdZCynoUF6fk
         2/anfJHHeQO909mgaxskasESuowrm31JTF93T6wAoW+6CI0ays3ysD31QOiCs0+rqR0B
         f2vgVO+pPXb5S3T/NIpqSxmTfnwW/xPw3iynUuBS/2/hUQRHCma8XKdRHwaFMEj6nWtU
         Qy29pmpP6j3gnc7kap5KjLXxq3tz2Mkdx23Dy6KurEwi86eT6cXJ+PKBE0Lys+x3EnBG
         1XAA==
X-Gm-Message-State: AC+VfDxOfwnIFSJGlAKfvrxQKcLJ1IUUasxb4QYTCAGzd6crNBNyQHYH
        bzwVbpShgrucImtlMLQHty7H7tljR1Il5CKSIvZxsPNueGj48YSx
X-Google-Smtp-Source: ACHHUZ5e8GVd8y3ZD62t7YDa8qhdFbbtx2TZYiko3UVhh75VOZ/O5sXvSx8DnVAwYChCLw2M/6dhxEaJm5woLCMH9Cc=
X-Received: by 2002:a1f:41ce:0:b0:456:a3bc:3daf with SMTP id
 o197-20020a1f41ce000000b00456a3bc3dafmr2820852vka.9.1686211947817; Thu, 08
 Jun 2023 01:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230607205714.510012-1-nfraprado@collabora.com> <20230607205714.510012-4-nfraprado@collabora.com>
In-Reply-To: <20230607205714.510012-4-nfraprado@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 8 Jun 2023 16:12:16 +0800
Message-ID: <CAGXv+5HHARvkCYfjPjRKgyWuzv-Dt215z1=yA+_tw4hyasdGQA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] media: mediatek: vcodec: Read HW active status
 from clock
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 4:57=E2=80=AFAM N=C3=ADcolas F. R. A. Prado
<nfraprado@collabora.com> wrote:
>
> Remove the requirement of a VDEC_SYS reg iospace. To achieve that, rely
> on the "active" clock being passed through the DT, and read its status
> during IRQ handling to check whether the HW is active.
>
> The old behavior is still present when reg-names aren't supplied, as to
> keep backward compatibility.
>
> Signed-off-by: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>
> ---
>
> (no changes since v1)
>
>  .../mediatek/vcodec/mtk_vcodec_dec_drv.c      | 59 +++++++++++++++----
>  .../mediatek/vcodec/mtk_vcodec_dec_hw.c       | 20 +++++--
>  .../mediatek/vcodec/mtk_vcodec_dec_pm.c       | 12 +++-
>  .../platform/mediatek/vcodec/mtk_vcodec_drv.h |  1 +
>  4 files changed, 74 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c =
b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> index 9c652beb3f19..8038472fb67b 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_drv.c
> @@ -16,6 +16,7 @@
>  #include <media/v4l2-mem2mem.h>
>  #include <media/videobuf2-dma-contig.h>
>  #include <media/v4l2-device.h>
> +#include <linux/clk-provider.h>

                   ^^^^^^^^^^^^^^

This seems like a violation of the API separation.

>  #include "mtk_vcodec_drv.h"
>  #include "mtk_vcodec_dec.h"
> @@ -38,22 +39,29 @@ static int mtk_vcodec_get_hw_count(struct mtk_vcodec_=
dev *dev)
>         }
>  }
>
> +static bool mtk_vcodec_is_hw_active(struct mtk_vcodec_dev *dev)
> +{
> +       u32 cg_status =3D 0;
> +
> +       if (!dev->reg_base[VDEC_SYS])
> +               return __clk_is_enabled(dev->pm.vdec_active_clk);

AFAIK this is still around for clk drivers that haven't moved to clk_hw.
It shouldn't be used by clock consumers. Would it be better to just pass
a syscon?

ChenYu


> +
> +       cg_status =3D readl(dev->reg_base[VDEC_SYS]);
> +       return (cg_status & VDEC_HW_ACTIVE) =3D=3D 0;
> +}
> +
>  static irqreturn_t mtk_vcodec_dec_irq_handler(int irq, void *priv)
>  {
>         struct mtk_vcodec_dev *dev =3D priv;
>         struct mtk_vcodec_ctx *ctx;
> -       u32 cg_status =3D 0;
>         unsigned int dec_done_status =3D 0;
>         void __iomem *vdec_misc_addr =3D dev->reg_base[VDEC_MISC] +
>                                         VDEC_IRQ_CFG_REG;
>
>         ctx =3D mtk_vcodec_get_curr_ctx(dev, MTK_VDEC_CORE);
>
> -       /* check if HW active or not */
> -       cg_status =3D readl(dev->reg_base[0]);
> -       if ((cg_status & VDEC_HW_ACTIVE) !=3D 0) {
> -               mtk_v4l2_err("DEC ISR, VDEC active is not 0x0 (0x%08x)",
> -                            cg_status);
> +       if (!mtk_vcodec_is_hw_active(dev)) {
> +               mtk_v4l2_err("DEC ISR, VDEC active is not 0x0");
>                 return IRQ_HANDLED;
>         }
>
> @@ -82,6 +90,25 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcodec_=
dev *dev)
>  {
>         struct platform_device *pdev =3D dev->plat_dev;
>         int reg_num, i;
> +       struct resource *res;
> +       bool no_vdecsys_reg =3D false;
> +       static const char * const mtk_dec_reg_names[] =3D {
> +               "misc",
> +               "ld",
> +               "top",
> +               "cm",
> +               "ad",
> +               "av",
> +               "pp",
> +               "hwd",
> +               "hwq",
> +               "hwb",
> +               "hwg"
> +       };
> +
> +       res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "misc"=
);
> +       if (res)
> +               no_vdecsys_reg =3D true;
>
>         /* Sizeof(u32) * 4 bytes for each register base. */
>         reg_num =3D of_property_count_elems_of_size(pdev->dev.of_node, "r=
eg",
> @@ -91,12 +118,22 @@ static int mtk_vcodec_get_reg_bases(struct mtk_vcode=
c_dev *dev)
>                 return -EINVAL;
>         }
>
> -       for (i =3D 0; i < reg_num; i++) {
> -               dev->reg_base[i] =3D devm_platform_ioremap_resource(pdev,=
 i);
> -               if (IS_ERR(dev->reg_base[i]))
> -                       return PTR_ERR(dev->reg_base[i]);
> +       if (!no_vdecsys_reg) {
> +               for (i =3D 0; i < reg_num; i++) {
> +                       dev->reg_base[i] =3D devm_platform_ioremap_resour=
ce(pdev, i);
> +                       if (IS_ERR(dev->reg_base[i]))
> +                               return PTR_ERR(dev->reg_base[i]);
>
> -               mtk_v4l2_debug(2, "reg[%d] base=3D%p", i, dev->reg_base[i=
]);
> +                       mtk_v4l2_debug(2, "reg[%d] base=3D%p", i, dev->re=
g_base[i]);
> +               }
> +       } else {
> +               for (i =3D 0; i < reg_num; i++) {
> +                       dev->reg_base[i+1] =3D devm_platform_ioremap_reso=
urce_byname(pdev, mtk_dec_reg_names[i]);
> +                       if (IS_ERR(dev->reg_base[i+1]))
> +                               return PTR_ERR(dev->reg_base[i+1]);
> +
> +                       mtk_v4l2_debug(2, "reg[%d] base=3D%p", i+1, dev->=
reg_base[i+1]);
> +               }
>         }
>
>         return 0;
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> index b753bf54ebd9..4e786821015d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_hw.c
> @@ -11,6 +11,7 @@
>  #include <linux/of_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
> +#include <linux/clk-provider.h>
>
>  #include "mtk_vcodec_drv.h"
>  #include "mtk_vcodec_dec.h"
> @@ -63,22 +64,29 @@ static int mtk_vdec_hw_prob_done(struct mtk_vcodec_de=
v *vdec_dev)
>         return 0;
>  }
>
> +static bool mtk_vcodec_is_hw_active(struct mtk_vdec_hw_dev *dev)
> +{
> +       u32 cg_status;
> +
> +       if (!dev->reg_base[VDEC_HW_SYS])
> +               return __clk_is_enabled(dev->pm.vdec_active_clk);
> +
> +       cg_status =3D readl(dev->reg_base[VDEC_HW_SYS]);
> +       return (cg_status & VDEC_HW_ACTIVE) =3D=3D 0;
> +}
> +
>  static irqreturn_t mtk_vdec_hw_irq_handler(int irq, void *priv)
>  {
>         struct mtk_vdec_hw_dev *dev =3D priv;
>         struct mtk_vcodec_ctx *ctx;
> -       u32 cg_status;
>         unsigned int dec_done_status;
>         void __iomem *vdec_misc_addr =3D dev->reg_base[VDEC_HW_MISC] +
>                                         VDEC_IRQ_CFG_REG;
>
>         ctx =3D mtk_vcodec_get_curr_ctx(dev->main_dev, dev->hw_idx);
>
> -       /* check if HW active or not */
> -       cg_status =3D readl(dev->reg_base[VDEC_HW_SYS]);
> -       if (cg_status & VDEC_HW_ACTIVE) {
> -               mtk_v4l2_err("vdec active is not 0x0 (0x%08x)",
> -                            cg_status);
> +       if (!mtk_vcodec_is_hw_active(dev)) {
> +               mtk_v4l2_err("vdec active is not 0x0");
>                 return IRQ_HANDLED;
>         }
>
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c b=
/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> index 777d445999e9..53e621965950 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_dec_pm.c
> @@ -51,6 +51,9 @@ int mtk_vcodec_init_dec_clk(struct platform_device *pde=
v, struct mtk_vcodec_pm *
>                                 clk_info->clk_name);
>                         return PTR_ERR(clk_info->vcodec_clk);
>                 }
> +
> +               if (strcmp(clk_info->clk_name, "active") =3D=3D 0)
> +                       pm->vdec_active_clk =3D clk_info->vcodec_clk;
>         }
>
>         return 0;
> @@ -84,6 +87,9 @@ static void mtk_vcodec_dec_clock_on(struct mtk_vcodec_p=
m *pm)
>
>         dec_clk =3D &pm->vdec_clk;
>         for (i =3D 0; i < dec_clk->clk_num; i++) {
> +               if (strcmp(dec_clk->clk_info[i].clk_name, "active") =3D=
=3D 0)
> +                       continue;
> +
>                 ret =3D clk_prepare_enable(dec_clk->clk_info[i].vcodec_cl=
k);
>                 if (ret) {
>                         mtk_v4l2_err("clk_prepare_enable %d %s fail %d", =
i,
> @@ -104,8 +110,12 @@ static void mtk_vcodec_dec_clock_off(struct mtk_vcod=
ec_pm *pm)
>         int i;
>
>         dec_clk =3D &pm->vdec_clk;
> -       for (i =3D dec_clk->clk_num - 1; i >=3D 0; i--)
> +       for (i =3D dec_clk->clk_num - 1; i >=3D 0; i--) {
> +               if (strcmp(dec_clk->clk_info[i].clk_name, "active") =3D=
=3D 0)
> +                       continue;
> +
>                 clk_disable_unprepare(dec_clk->clk_info[i].vcodec_clk);
> +       }
>  }
>
>  static void mtk_vcodec_dec_enable_irq(struct mtk_vcodec_dev *vdec_dev, i=
nt hw_idx)
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h b/dr=
ivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> index 9acab54fd650..180e74c69042 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_drv.h
> @@ -208,6 +208,7 @@ struct mtk_vcodec_pm {
>         struct mtk_vcodec_clk   vdec_clk;
>         struct mtk_vcodec_clk   venc_clk;
>         struct device   *dev;
> +       struct clk *vdec_active_clk;
>  };
>
>  /**
> --
> 2.41.0
>
>
