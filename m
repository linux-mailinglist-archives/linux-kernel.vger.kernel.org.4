Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F636735A15
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 16:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjFSOxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 10:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSOxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 10:53:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94059B9;
        Mon, 19 Jun 2023 07:53:50 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:c623::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C89126605835;
        Mon, 19 Jun 2023 15:53:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1687186429;
        bh=niF9buWzQfwlsD8+0WxDqigxgGldCwE0sdhB490duRw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=RhrO/fhYzcvZx98RzqYQEiLJ3TrEGalMfd8nk6+RGKBrbPebHnFya2IPl8ACCknPs
         z12yy74T+6f7Sr3fQp9PkczyG7btBA7Qx0gAGvujtPx/gmlyNiQg8SEO3Ztl9SkJov
         +pkyG1pldjVC9wxwggOYh7cXTwHAmIlwM9iPc5hQYOzk0gwOHH6nw65EnDeJiKF/7n
         AVXPXrjemTJIWP9FBpeC/AKcxiStQbs7Vl4wp/6paBHeMnf4UF/qHRBMJGN64nJptg
         sPQ3ol+T2wK117drQlXHia3H3Paz6M7SmZ8Kg4m1ybskgaiEdn847LrjSg64B9sbRG
         YQY+mzwOXewQg==
Message-ID: <e6a1ed5937c3a2182ba6b7a90572f905a62269f3.camel@collabora.com>
Subject: Re: [PATCH v3,03/11] media: mediatek: vcodec: re-write shared
 interface
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Yunfei Dong <yunfei.dong@mediatek.com>,
        =?ISO-8859-1?Q?N=EDcolas?= "F . R . A . Prado" 
        <nfraprado@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Nathan Hebert <nhebert@chromium.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Fritz Koenig <frkoenig@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Mon, 19 Jun 2023 10:53:38 -0400
In-Reply-To: <20230617103255.20239-4-yunfei.dong@mediatek.com>
References: <20230617103255.20239-1-yunfei.dong@mediatek.com>
         <20230617103255.20239-4-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yunfei,


Le samedi 17 juin 2023 =C3=A0 18:32 +0800, Yunfei Dong a =C3=A9crit=C2=A0:
> Re-write shared interface which encoder and decoder used at
> the same time. Using the common struct as the parameter of
> these interface in order to remove the depedency.
>=20
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  .../mediatek/vcodec/mtk_vcodec_intr.c         | 30 ++++++++++++-------
>  .../mediatek/vcodec/mtk_vcodec_intr.h         |  3 +-
>  .../mediatek/vcodec/mtk_vcodec_util.c         | 19 +++++-------
>  .../mediatek/vcodec/mtk_vcodec_util.h         |  9 ++----
>  .../mediatek/vcodec/vdec/vdec_vp8_if.c        | 14 ++++-----
>  .../mediatek/vcodec/venc/venc_h264_if.c       |  2 +-
>  .../mediatek/vcodec/venc/venc_vp8_if.c        |  2 +-
>  7 files changed, 39 insertions(+), 40 deletions(-)
>=20
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> index 552b4c93d972..daa44f635727 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.c
> @@ -11,32 +11,40 @@
>  #include "mtk_vcodec_intr.h"
>  #include "mtk_vcodec_util.h"
> =20
> -int mtk_vcodec_wait_for_done_ctx(struct mtk_vcodec_ctx *ctx,
> -				 int command, unsigned int timeout_ms,
> +int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int t=
imeout_ms,
>  				 unsigned int hw_id)
>  {
> +	struct mtk_vcodec_ctx *ctx =3D priv;
>  	long timeout_jiff, ret;
> -	int status =3D 0;
> +	int status =3D 0, ctx_id, ctx_type;
> +	int *ctx_int_cond, *ctx_int_type;
> +	wait_queue_head_t *ctx_queue;
> +
> +	ctx_id =3D ctx->id;
> +	ctx_type =3D ctx->type;
> +	ctx_int_cond =3D ctx->int_cond;
> +	ctx_int_type =3D ctx->int_type;
> +	ctx_queue =3D ctx->queue;
> =20
>  	timeout_jiff =3D msecs_to_jiffies(timeout_ms);
> -	ret =3D wait_event_interruptible_timeout(ctx->queue[hw_id],
> -					       ctx->int_cond[hw_id],
> +	ret =3D wait_event_interruptible_timeout(ctx_queue[hw_id],
> +					       ctx_int_cond[hw_id],
>  					       timeout_jiff);
> =20
>  	if (!ret) {
>  		status =3D -1;	/* timeout */
>  		mtk_v4l2_err("[%d] cmd=3D%d, type=3D%d, dec timeout=3D%ums (%d %d)",
> -			     ctx->id, command, ctx->type, timeout_ms,
> -			     ctx->int_cond[hw_id], ctx->int_type[hw_id]);
> +			     ctx_id, command, ctx_type, timeout_ms,
> +			     ctx_int_cond[hw_id], ctx_int_type[hw_id]);
>  	} else if (-ERESTARTSYS =3D=3D ret) {
>  		status =3D -1;
>  		mtk_v4l2_err("[%d] cmd=3D%d, type=3D%d, dec inter fail (%d %d)",
> -			     ctx->id, command, ctx->type,
> -			     ctx->int_cond[hw_id], ctx->int_type[hw_id]);
> +			     ctx_id, command, ctx_type,
> +			     ctx_int_cond[hw_id], ctx_int_type[hw_id]);
>  	}
> =20
> -	ctx->int_cond[hw_id] =3D 0;
> -	ctx->int_type[hw_id] =3D 0;
> +	ctx_int_cond[hw_id] =3D 0;
> +	ctx_int_type[hw_id] =3D 0;
> =20
>  	return status;
>  }
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
> index 9681f492813b..11bf0ef94d5d 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_intr.h
> @@ -12,8 +12,7 @@
>  struct mtk_vcodec_ctx;

You have a forward declaration here.

> =20
>  /* timeout is ms */
> -int mtk_vcodec_wait_for_done_ctx(struct mtk_vcodec_ctx *ctx,
> -				 int command, unsigned int timeout_ms,
> +int mtk_vcodec_wait_for_done_ctx(void *priv, int command, unsigned int t=
imeout_ms,
>  				 unsigned int hw_id);

So has the CTX is only uses has a pointer, its hard to follow why you need =
to
hide the type here. At least its not clear to me how this helps with the go=
al
set in the commit message and would simply like to understand before giving=
 an
r-b.

> =20
>  #endif /* _MTK_VCODEC_INTR_H_ */
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> index f214e6f67005..847e321f4fcc 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.c
> @@ -21,24 +21,20 @@ int mtk_v4l2_dbg_level;
>  EXPORT_SYMBOL(mtk_v4l2_dbg_level);
>  #endif
> =20
> -void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
> -					unsigned int reg_idx)
> +void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned =
int reg_idx)
>  {
> -	struct mtk_vcodec_ctx *ctx =3D (struct mtk_vcodec_ctx *)data;
> -
> -	if (!data || reg_idx >=3D NUM_MAX_VCODEC_REG_BASE) {
> +	if (reg_idx >=3D NUM_MAX_VCODEC_REG_BASE) {
>  		mtk_v4l2_err("Invalid arguments, reg_idx=3D%d", reg_idx);
>  		return NULL;
>  	}
> -	return ctx->dev->reg_base[reg_idx];
> +	return reg_base[reg_idx];
>  }
>  EXPORT_SYMBOL(mtk_vcodec_get_reg_addr);
> =20
> -int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
> -			struct mtk_vcodec_mem *mem)
> +int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem)
>  {
>  	unsigned long size =3D mem->size;
> -	struct mtk_vcodec_ctx *ctx =3D (struct mtk_vcodec_ctx *)data;
> +	struct mtk_vcodec_ctx *ctx =3D priv;
>  	struct device *dev =3D &ctx->dev->plat_dev->dev;
> =20
>  	mem->va =3D dma_alloc_coherent(dev, size, &mem->dma_addr, GFP_KERNEL);
> @@ -57,11 +53,10 @@ int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
>  }
>  EXPORT_SYMBOL(mtk_vcodec_mem_alloc);
> =20
> -void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
> -			struct mtk_vcodec_mem *mem)
> +void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem)
>  {
>  	unsigned long size =3D mem->size;
> -	struct mtk_vcodec_ctx *ctx =3D (struct mtk_vcodec_ctx *)data;
> +	struct mtk_vcodec_ctx *ctx =3D priv;
>  	struct device *dev =3D &ctx->dev->plat_dev->dev;
> =20
>  	if (!mem->va) {
> diff --git a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h b/d=
rivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> index 88d389b65f13..827937bcb4b4 100644
> --- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> +++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_util.h
> @@ -68,12 +68,9 @@ extern int mtk_vcodec_dbg;
>  #define mtk_vcodec_debug_enter(h)  mtk_vcodec_debug(h, "+")
>  #define mtk_vcodec_debug_leave(h)  mtk_vcodec_debug(h, "-")
> =20
> -void __iomem *mtk_vcodec_get_reg_addr(struct mtk_vcodec_ctx *data,
> -				unsigned int reg_idx);
> -int mtk_vcodec_mem_alloc(struct mtk_vcodec_ctx *data,
> -				struct mtk_vcodec_mem *mem);
> -void mtk_vcodec_mem_free(struct mtk_vcodec_ctx *data,
> -				struct mtk_vcodec_mem *mem);
> +void __iomem *mtk_vcodec_get_reg_addr(void __iomem **reg_base, unsigned =
int reg_idx);
> +int mtk_vcodec_mem_alloc(void *priv, struct mtk_vcodec_mem *mem);
> +void mtk_vcodec_mem_free(void *priv, struct mtk_vcodec_mem *mem);
>  void mtk_vcodec_set_curr_ctx(struct mtk_vcodec_dev *vdec_dev,
>  			     struct mtk_vcodec_ctx *ctx, int hw_idx);
>  struct mtk_vcodec_ctx *mtk_vcodec_get_curr_ctx(struct mtk_vcodec_dev *vd=
ec_dev,
> diff --git a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> index 88c046731754..5edbccc9ae68 100644
> --- a/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/vdec/vdec_vp8_if.c
> @@ -167,13 +167,13 @@ struct vdec_vp8_inst {
> =20
>  static void get_hw_reg_base(struct vdec_vp8_inst *inst)
>  {
> -	inst->reg_base.top =3D mtk_vcodec_get_reg_addr(inst->ctx, VDEC_TOP);
> -	inst->reg_base.cm =3D mtk_vcodec_get_reg_addr(inst->ctx, VDEC_CM);
> -	inst->reg_base.hwd =3D mtk_vcodec_get_reg_addr(inst->ctx, VDEC_HWD);
> -	inst->reg_base.sys =3D mtk_vcodec_get_reg_addr(inst->ctx, VDEC_SYS);
> -	inst->reg_base.misc =3D mtk_vcodec_get_reg_addr(inst->ctx, VDEC_MISC);
> -	inst->reg_base.ld =3D mtk_vcodec_get_reg_addr(inst->ctx, VDEC_LD);
> -	inst->reg_base.hwb =3D mtk_vcodec_get_reg_addr(inst->ctx, VDEC_HWB);
> +	inst->reg_base.top =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base=
, VDEC_TOP);
> +	inst->reg_base.cm =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base,=
 VDEC_CM);
> +	inst->reg_base.hwd =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base=
, VDEC_HWD);
> +	inst->reg_base.sys =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base=
, VDEC_SYS);
> +	inst->reg_base.misc =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_bas=
e, VDEC_MISC);
> +	inst->reg_base.ld =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base,=
 VDEC_LD);
> +	inst->reg_base.hwb =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base=
, VDEC_HWB);
>  }
> =20
>  static void write_hw_segmentation_data(struct vdec_vp8_inst *inst)
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c b=
/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> index 60fd165c0d94..10365c95ebbe 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_h264_if.c
> @@ -612,7 +612,7 @@ static int h264_enc_init(struct mtk_vcodec_ctx *ctx)
>  	inst->ctx =3D ctx;
>  	inst->vpu_inst.ctx =3D ctx;
>  	inst->vpu_inst.id =3D is_ext ? SCP_IPI_VENC_H264 : IPI_VENC_H264;
> -	inst->hw_base =3D mtk_vcodec_get_reg_addr(inst->ctx, VENC_SYS);
> +	inst->hw_base =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VEN=
C_SYS);
> =20
>  	mtk_vcodec_debug_enter(inst);
> =20
> diff --git a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c b/=
drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> index 56ce58f761f1..73ebc35d7c99 100644
> --- a/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> +++ b/drivers/media/platform/mediatek/vcodec/venc/venc_vp8_if.c
> @@ -336,7 +336,7 @@ static int vp8_enc_init(struct mtk_vcodec_ctx *ctx)
>  	inst->ctx =3D ctx;
>  	inst->vpu_inst.ctx =3D ctx;
>  	inst->vpu_inst.id =3D IPI_VENC_VP8;
> -	inst->hw_base =3D mtk_vcodec_get_reg_addr(inst->ctx, VENC_LT_SYS);
> +	inst->hw_base =3D mtk_vcodec_get_reg_addr(inst->ctx->dev->reg_base, VEN=
C_LT_SYS);
> =20
>  	mtk_vcodec_debug_enter(inst);
> =20

