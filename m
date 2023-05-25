Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C88710F0A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241384AbjEYPEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241117AbjEYPE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 11:04:27 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2352194;
        Thu, 25 May 2023 08:04:25 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:17:6c0::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D0516605840;
        Thu, 25 May 2023 16:04:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685027064;
        bh=XPtf6WeYqWwuZf1N8W0n3EFkjuNoDBrwxv6CSfaWIwM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=kGTnrNkMKaz11P8su34+ehIBVm7bNhWihILVDx/r16STOun0Nl0fvlHVRY5rq7+Tq
         ZPFy/KUgDCWu7+uYf4wFQnNw3FdA9IxYWW5/cInuVJvFbCthGwVj+m/yqWJjEAm+sj
         amGZ9zM++1VJK5eFN/t4oWHvnINLZLD0RJWeHBjh58i1l22glTo4HyPqfYd9ZM5SIq
         5xk/idqOSyUBPlOfZ9p6Qni1OxA1DcQRHu8fykw2dEoNbZ4xroA1wsVtKAZsX+8J1W
         jbCz0CoIg40HI0sJADyPU60QIcbg5fxeg0OP4es1cnZutq3Ua2SfkbSS+nYJfcbz3f
         FdtLTYJlDmbJw==
Message-ID: <61db9e3af85549896c3f8d408c10200bee59cc5b.camel@collabora.com>
Subject: Re: [PATCH v7 12/13] media: verisilicon: Enable AV1 decoder on
 rk3588
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Thu, 25 May 2023 11:04:13 -0400
In-Reply-To: <20230503083438.85139-13-benjamin.gaignard@collabora.com>
References: <20230503083438.85139-1-benjamin.gaignard@collabora.com>
         <20230503083438.85139-13-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1 (3.48.1-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 03 mai 2023 =C3=A0 10:34 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> Add rk3588 AV1 decoder to Hantro variant.
> The hardware support image from 64x64 up to 7680x4320
> by steps of 16 pixels.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/verisilicon/hantro_drv.c   |   1 +
>  .../media/platform/verisilicon/hantro_hw.h    |   2 +
>  .../platform/verisilicon/rockchip_vpu_hw.c    | 134 ++++++++++++++++++
>  3 files changed, 137 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index be1f06c21910..dd41a6de1a0c 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -713,6 +713,7 @@ static const struct of_device_id of_hantro_match[] =
=3D {
>  	{ .compatible =3D "rockchip,rk3399-vpu", .data =3D &rk3399_vpu_variant,=
 },
>  	{ .compatible =3D "rockchip,rk3568-vepu", .data =3D &rk3568_vepu_varian=
t, },
>  	{ .compatible =3D "rockchip,rk3568-vpu", .data =3D &rk3568_vpu_variant,=
 },
> +	{ .compatible =3D "rockchip,rk3588-av1-vpu", .data =3D &rk3588_vpu981_v=
ariant, },
>  #endif
>  #ifdef CONFIG_VIDEO_HANTRO_IMX8M
>  	{ .compatible =3D "nxp,imx8mm-vpu-g1", .data =3D &imx8mm_vpu_g1_variant=
, },
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/med=
ia/platform/verisilicon/hantro_hw.h
> index 021fad15d66f..7f33f7b07ce4 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -403,11 +403,13 @@ extern const struct hantro_variant rk3328_vpu_varia=
nt;
>  extern const struct hantro_variant rk3399_vpu_variant;
>  extern const struct hantro_variant rk3568_vepu_variant;
>  extern const struct hantro_variant rk3568_vpu_variant;
> +extern const struct hantro_variant rk3588_vpu981_variant;
>  extern const struct hantro_variant sama5d4_vdec_variant;
>  extern const struct hantro_variant sunxi_vpu_variant;
> =20
>  extern const struct hantro_postproc_ops hantro_g1_postproc_ops;
>  extern const struct hantro_postproc_ops hantro_g2_postproc_ops;
> +extern const struct hantro_postproc_ops rockchip_vpu981_postproc_ops;
> =20
>  extern const u32 hantro_vp8_dec_mc_filter[8][6];
> =20
> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drive=
rs/media/platform/verisilicon/rockchip_vpu_hw.c
> index 8de6fd2e8eef..816ffa905a4b 100644
> --- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> @@ -13,9 +13,13 @@
>  #include "hantro_g1_regs.h"
>  #include "hantro_h1_regs.h"
>  #include "rockchip_vpu2_regs.h"
> +#include "rockchip_vpu981_regs.h"
> =20
>  #define RK3066_ACLK_MAX_FREQ (300 * 1000 * 1000)
>  #define RK3288_ACLK_MAX_FREQ (400 * 1000 * 1000)
> +#define RK3588_ACLK_MAX_FREQ (300 * 1000 * 1000)
> +
> +#define ROCKCHIP_VPU981_MIN_SIZE 64
> =20
>  /*
>   * Supported formats.
> @@ -74,6 +78,37 @@ static const struct hantro_fmt rockchip_vpu1_postproc_=
fmts[] =3D {
>  	},
>  };
> =20
> +static const struct hantro_fmt rockchip_vpu981_postproc_fmts[] =3D {
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV12,
> +		.codec_mode =3D HANTRO_MODE_NONE,
> +		.match_depth =3D true,
> +		.postprocessed =3D true,
> +		.frmsize =3D {
> +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_width =3D FMT_UHD_WIDTH,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_height =3D FMT_UHD_HEIGHT,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_P010,
> +		.codec_mode =3D HANTRO_MODE_NONE,
> +		.match_depth =3D true,
> +		.postprocessed =3D true,
> +		.frmsize =3D {
> +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_width =3D FMT_UHD_WIDTH,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_height =3D FMT_UHD_HEIGHT,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +};
> +
>  static const struct hantro_fmt rk3066_vpu_dec_fmts[] =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
> @@ -277,6 +312,48 @@ static const struct hantro_fmt rk3399_vpu_dec_fmts[]=
 =3D {
>  	},
>  };
> =20
> +static const struct hantro_fmt rockchip_vpu981_dec_fmts[] =3D {
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV12_4L4,
> +		.codec_mode =3D HANTRO_MODE_NONE,
> +		.match_depth =3D true,
> +		.frmsize =3D {
> +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_width =3D FMT_UHD_WIDTH,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_height =3D FMT_UHD_HEIGHT,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_NV15_4L4,
> +		.codec_mode =3D HANTRO_MODE_NONE,
> +		.match_depth =3D true,
> +		.frmsize =3D {
> +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_width =3D FMT_UHD_WIDTH,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_height =3D FMT_UHD_HEIGHT,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +	{
> +		.fourcc =3D V4L2_PIX_FMT_AV1_FRAME,
> +		.codec_mode =3D HANTRO_MODE_AV1_DEC,
> +		.max_depth =3D 2,
> +		.frmsize =3D {
> +			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_width =3D FMT_UHD_WIDTH,
> +			.step_width =3D MB_DIM,
> +			.min_height =3D ROCKCHIP_VPU981_MIN_SIZE,
> +			.max_height =3D FMT_UHD_HEIGHT,
> +			.step_height =3D MB_DIM,
> +		},
> +	},
> +};
> +
>  static irqreturn_t rockchip_vpu1_vepu_irq(int irq, void *dev_id)
>  {
>  	struct hantro_dev *vpu =3D dev_id;
> @@ -331,6 +408,24 @@ static irqreturn_t rockchip_vpu2_vepu_irq(int irq, v=
oid *dev_id)
>  	return IRQ_HANDLED;
>  }
> =20
> +static irqreturn_t rk3588_vpu981_irq(int irq, void *dev_id)
> +{
> +	struct hantro_dev *vpu =3D dev_id;
> +	enum vb2_buffer_state state;
> +	u32 status;
> +
> +	status =3D vdpu_read(vpu, AV1_REG_INTERRUPT);
> +	state =3D (status & AV1_REG_INTERRUPT_DEC_RDY_INT) ?
> +		VB2_BUF_STATE_DONE : VB2_BUF_STATE_ERROR;
> +
> +	vdpu_write(vpu, 0, AV1_REG_INTERRUPT);
> +	vdpu_write(vpu, AV1_REG_CONFIG_DEC_CLK_GATE_E, AV1_REG_CONFIG);
> +
> +	hantro_irq_done(vpu, state);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static int rk3036_vpu_hw_init(struct hantro_dev *vpu)
>  {
>  	/* Bump ACLK to max. possible freq. to improve performance. */
> @@ -346,6 +441,13 @@ static int rk3066_vpu_hw_init(struct hantro_dev *vpu=
)
>  	return 0;
>  }
> =20
> +static int rk3588_vpu981_hw_init(struct hantro_dev *vpu)
> +{
> +	/* Bump ACLKs to max. possible freq. to improve performance. */
> +	clk_set_rate(vpu->clocks[0].clk, RK3588_ACLK_MAX_FREQ);
> +	return 0;
> +}
> +
>  static int rockchip_vpu_hw_init(struct hantro_dev *vpu)
>  {
>  	/* Bump ACLK to max. possible freq. to improve performance. */
> @@ -498,6 +600,14 @@ static const struct hantro_codec_ops rk3568_vepu_cod=
ec_ops[] =3D {
>  	},
>  };
> =20
> +static const struct hantro_codec_ops rk3588_vpu981_codec_ops[] =3D {
> +	[HANTRO_MODE_AV1_DEC] =3D {
> +		.run =3D rockchip_vpu981_av1_dec_run,
> +		.init =3D rockchip_vpu981_av1_dec_init,
> +		.exit =3D rockchip_vpu981_av1_dec_exit,
> +		.done =3D rockchip_vpu981_av1_dec_done,
> +	},
> +};
>  /*
>   * VPU variant.
>   */
> @@ -529,10 +639,18 @@ static const char * const rk3066_vpu_clk_names[] =
=3D {
>  	"aclk_vepu", "hclk_vepu"
>  };
> =20
> +static const struct hantro_irq rk3588_vpu981_irqs[] =3D {
> +	{ "vdpu", rk3588_vpu981_irq },
> +};
> +
>  static const char * const rockchip_vpu_clk_names[] =3D {
>  	"aclk", "hclk"
>  };
> =20
> +static const char * const rk3588_vpu981_vpu_clk_names[] =3D {
> +	"aclk", "hclk", "aclk_vdpu_root", "hclk_vdpu_root"
> +};
> +
>  /* VDPU1/VEPU1 */
> =20
>  const struct hantro_variant rk3036_vpu_variant =3D {
> @@ -678,3 +796,19 @@ const struct hantro_variant px30_vpu_variant =3D {
>  	.clk_names =3D rockchip_vpu_clk_names,
>  	.num_clocks =3D ARRAY_SIZE(rockchip_vpu_clk_names)
>  };
> +
> +const struct hantro_variant rk3588_vpu981_variant =3D {
> +	.dec_offset =3D 0x0,
> +	.dec_fmts =3D rockchip_vpu981_dec_fmts,
> +	.num_dec_fmts =3D ARRAY_SIZE(rockchip_vpu981_dec_fmts),
> +	.postproc_fmts =3D rockchip_vpu981_postproc_fmts,
> +	.num_postproc_fmts =3D ARRAY_SIZE(rockchip_vpu981_postproc_fmts),
> +	.postproc_ops =3D &rockchip_vpu981_postproc_ops,
> +	.codec =3D HANTRO_AV1_DECODER,
> +	.codec_ops =3D rk3588_vpu981_codec_ops,
> +	.irqs =3D rk3588_vpu981_irqs,
> +	.num_irqs =3D ARRAY_SIZE(rk3588_vpu981_irqs),
> +	.init =3D rk3588_vpu981_hw_init,
> +	.clk_names =3D rk3588_vpu981_vpu_clk_names,
> +	.num_clocks =3D ARRAY_SIZE(rk3588_vpu981_vpu_clk_names)
> +};

