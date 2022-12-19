Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185AC651425
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbiLSUmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 15:42:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiLSUmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 15:42:37 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9CBF5D
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:42:35 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id h10so7013280qvq.7
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 12:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=inRemP8l8T0lJzsgX9r8VHvv2ljO5+mNrIR9f4Y4KPY=;
        b=blzh/78hYWyfNH0CYRrQGM5NaXRbBZ8BvRLLmkz0fd7CiS8LQGWiZ4lDnwecxgSFw8
         46GzvEvVtZ/CvJPEa3V0fxlh9pj+5JVOgcL/HZqP1dCsE1RVbUFyps+E482HuaNqe3X9
         nn4kuotIA9bR6tfy8Tj3/6DodRscd9ErPYWTmqeaJfcf7owU2qkX43W9aaN7NKcaTCmH
         HNX1tXEhoiW64LJkBQOwef5CLKMoxUrtG3enHmiikuHTBUlZA/4WOeh7Voz/L1jP4ulc
         vQkLTopFUKy/6v1WA/TUp9+KjHAd8ltaJ1/UOot3S0nzJ/pXDl3zSDoQNzM+VyJ/iHzB
         9Tmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=inRemP8l8T0lJzsgX9r8VHvv2ljO5+mNrIR9f4Y4KPY=;
        b=vHWYR75EvDBflaIMOBkRX0stZk/1OY1/tQ/Q1toqaj4Zo4G3mGYZ1KWgFDnmIIaBKn
         uTHbj+69hHfMdSfxLGnS8ZHpyqy1pvlSvYj+QZ0E1VvO9LoCZ2hb4erYEHrhIfmn+G3X
         uFDaX/7CvAefVuq+lapy8vd39THChom3iF200sN6QPKUWkX+9GHOwcaOdOAGC/aGoAN2
         PIy4bVj/im7ei3+xoKeP29ZDSaZdX8rjSpC+aRKcv0BXL8L9jXvbeZ4sNtiZrbVWCTBB
         QFo/rVZMnT0iyLqFRYtIRmKVAO5zjhRqds/8EIFf4dxMDcmbJ51ZuKPQnt+KOlJdIrYI
         5KpA==
X-Gm-Message-State: ANoB5plr7cNXLVllMOcH96yjHQiUQ+iASqB43p7iJuJXdtDBxnHGKQzY
        2KrTqziwG7L7pcSdlB5yCVgOaA==
X-Google-Smtp-Source: AA0mqf4SYwFIwGR65cN1wMfvs0LEu1yaJxKFNyFY9MUJ6uxERA72MHixsFX26tdJqFk6F/3XlTn39Q==
X-Received: by 2002:a05:6214:3c8e:b0:4c6:e0d0:6f51 with SMTP id ok14-20020a0562143c8e00b004c6e0d06f51mr63004918qvb.43.1671482555087;
        Mon, 19 Dec 2022 12:42:35 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id bi4-20020a05620a318400b006fb0e638f12sm7632463qkb.4.2022.12.19.12.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 12:42:34 -0800 (PST)
Message-ID: <44b06c15410e184e8e856a4a882d1b42a02fa8d2.camel@ndufresne.ca>
Subject: Re: [PATCH v1 5/9] media: verisilicon: Compute motion vectors size
 for AV1 frames
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        daniel.almeida@collabora.com, nicolas.dufresne@collabora.co.uk
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Mon, 19 Dec 2022 15:42:33 -0500
In-Reply-To: <20221219155616.848690-6-benjamin.gaignard@collabora.com>
References: <20221219155616.848690-1-benjamin.gaignard@collabora.com>
         <20221219155616.848690-6-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 19 d=C3=A9cembre 2022 =C3=A0 16:56 +0100, Benjamin Gaignard a =C3=
=A9crit=C2=A0:
> Compute the additional required to store motion vectors at

requires *space*, requires *buffer* ? I think this is missing a word.

> the end of the frames buffers.
>=20
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/media/platform/verisilicon/hantro_hw.h      | 13 +++++++++++++
>  .../media/platform/verisilicon/hantro_postproc.c    |  3 +++
>  drivers/media/platform/verisilicon/hantro_v4l2.c    |  5 +++++
>  3 files changed, 21 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_hw.h b/drivers/med=
ia/platform/verisilicon/hantro_hw.h
> index e83f0c523a30..8b3bc7e31395 100644
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
> +	return DIV_ROUND_UP(dimension, 64) + 1;

Why plus one ? I've tested locally with the logical DIV_ROUND_UP(dimension,=
 64),
and didn't see any difference. It then match hantro_vp_num_sbs(), so can't =
this
be shared ?

> +}
> +
> +static inline size_t
> +hantro_av1_mv_size(unsigned int width, unsigned int height)
> +{
> +	size_t num_sbs =3D hantro_av1_num_sbs(width) * hantro_av1_num_sbs(heigh=
t);
> +
> +	return ALIGN(num_sbs * 384, 16) + 512;

Shall the magic numbers be turned into defines ?

> +}
> +
>  int hantro_g1_mpeg2_dec_run(struct hantro_ctx *ctx);
>  int rockchip_vpu2_mpeg2_dec_run(struct hantro_ctx *ctx);
>  void hantro_mpeg2_dec_copy_qtable(u8 *qtable,
> diff --git a/drivers/media/platform/verisilicon/hantro_postproc.c b/drive=
rs/media/platform/verisilicon/hantro_postproc.c
> index 09d8cf942689..7dc39519a2ee 100644
> --- a/drivers/media/platform/verisilicon/hantro_postproc.c
> +++ b/drivers/media/platform/verisilicon/hantro_postproc.c
> @@ -213,6 +213,9 @@ int hantro_postproc_alloc(struct hantro_ctx *ctx)
>  	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_HEVC_SLICE)
>  		buf_size +=3D hantro_hevc_mv_size(pix_mp.width,
>  						pix_mp.height);
> +	else if (ctx->vpu_src_fmt->fourcc =3D=3D V4L2_PIX_FMT_AV1_FRAME)
> +		buf_size +=3D hantro_av1_mv_size(pix_mp.width,
> +					       pix_mp.height);

nit: Time to turn into a switch or use an ops ?

> =20
>  	for (i =3D 0; i < num_buffers; ++i) {
>  		struct hantro_aux_buf *priv =3D &ctx->postproc.dec_q[i];
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 2c7a805289e7..d41dcb108a6d 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -334,6 +334,11 @@ static int hantro_try_fmt(const struct hantro_ctx *c=
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

