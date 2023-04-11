Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D285A6DDF1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjDKPLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjDKPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:11:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11778E77;
        Tue, 11 Apr 2023 08:10:52 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9EDD066031E0;
        Tue, 11 Apr 2023 16:10:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681225850;
        bh=FZ5Rda4k9osgauEPem0mQeUsr1gyDZRs1xZRSDCNgWc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CmtW4N9Faw/G8WYYjAikf8hxBWdbP29gxG7c3dBG8bC0yksmcxgigEFeTR1+Cb3gK
         /2VxBPAR9GCt58esLT8VTAAevfqRPgWuxRLOyQofWedbCa74dtLs/diV8L0uUf0a+y
         X3JUsqRvn15OhwBe9Ionnjb+KkaCIAl13M6H+Lpb3jXtzDkdccQD4DyKLmQt98e8Pe
         /BZ6nxkF73Zfr20RF2AwhwZMIT8GWZBYSGusltm1ck47tTJ78YVFN8LHHrC6IYw5r7
         bC2hKIEkiGFeYONozRcIo+Quf8T1zxqtOyM/PHSrPTkxAEnQf0r4Vte4pt3xoc8Gu5
         +bMFIZ5/uaJUA==
Message-ID: <ebae8a86a6af268daeb198d66fd940dc622e8aac.camel@collabora.com>
Subject: Re: [PATCH v5 07/13] media: verisilicon: Compute motion vectors
 size for AV1 frames
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 11 Apr 2023 11:10:41 -0400
In-Reply-To: <20230330154043.1250736-8-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
         <20230330154043.1250736-8-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 30 mars 2023 =C3=A0 17:40 +0200, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> Compute the additional space required to store motion vectors at
> the end of the frames buffers.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/verisilicon/hantro_hw.h      | 13 +++++++++++++
>  .../media/platform/verisilicon/hantro_postproc.c    |  3 +++
>  drivers/media/platform/verisilicon/hantro_v4l2.c    |  5 +++++
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/med=
ia/platform/verisilicon/hantro_hw.h
> index e83f0c523a30..bc61d4e051c7 100644
> --- a/drivers/media/platform/verisilicon/hantro_hw.h
> +++ b/drivers/media/platform/verisilicon/hantro_hw.h
> @@ -417,6 +417,19 @@ hantro_hevc_mv_size(unsigned int width, unsigned int=
 height)
>  	return width * height / 16;
>  }
> =20
> +static inline unsigned short hantro_av1_num_sbs(unsigned short dimension=
)
> +{
> +	return DIV_ROUND_UP(dimension, 64);
> +}
> +
> +static inline size_t
> +hantro_av1_mv_size(unsigned int width, unsigned int height)
> +{
> +	size_t num_sbs =3D hantro_av1_num_sbs(width) * hantro_av1_num_sbs(heigh=
t);
> +
> +	return ALIGN(num_sbs * 384, 16) * 2 + 512;
> +}
> +
>  int hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx);
>  int rockchip_vpu2_mpeg2_dec_run(struct hantro_ctx *ctx);
>  void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drive=
rs/media/platform/verisilicon/hantro_postproc.c
> index 6437423ccf3a..bb16af50719d 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -213,6 +213,9 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>  	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_HEVC_SLICE)
>  		buf_size +=3D hantro_hevc_mv_size(pix_mp.width,
>  						pix_mp.height);
> +	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_AV1_FRAME)
> +		buf_size +=3D hantro_av1_mv_size(pix_mp.width,
> +					       pix_mp.height);
> =20
>  	for (i =3D 0; i < num_buffers; ++i) {
>  		struct hantro_aux_buf *priv =3D &ctx->postproc.dec_q[i];
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index e2a8838f75f0..c218c9781e73 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -337,6 +337,11 @@ static int hantro_try_fmt(const struct hantro_ctx *c=
tx,
>  			pix_mp->plane_fmt[0].sizeimage +=3D
>  				hantro_hevc_mv_size(pix_mp->width,
>  						    pix_mp->height);
> +		else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_AV1_FRAME &&
> +			 !hantro_needs_postproc(ctx, fmt))
> +			pix_mp->plane_fmt[0].sizeimage +=3D
> +				hantro_av1_mv_size(pix_mp->width,
> +						   pix_mp->height);
>  	} else if (!pix_mp->plane_fmt[0].sizeimage) {
>  		/*
>  		 * For coded formats the application can specify

