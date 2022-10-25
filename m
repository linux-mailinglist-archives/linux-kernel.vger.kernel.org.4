Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376C660CFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 17:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbiJYPAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 11:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiJYPAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 11:00:06 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92BD820343;
        Tue, 25 Oct 2022 08:00:02 -0700 (PDT)
Received: (Authenticated sender: paul.kocialkowski@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 46C1FE0006;
        Tue, 25 Oct 2022 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1666710001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4uMbjYj8dN19a1ZhsZb+uHoXrmGlTaA0A9W+9Yri6ig=;
        b=HdLJZ0tmYxUsZlHif4mOZsXvKQGwWl47bzzHl2iulv6T5FSRFrud9rzvtaLu5e275kcwYq
        u8Om6HhdBEzGWdD7wIk0DbwyaoWHscXopexT2U5eiAB5aKELD2NgsvCGQy0NZbWDiWSD3h
        mxafiP4Xd0KN9i9wy29Oyd6LT1rni52ozt9Wh6RhR4lw9OAFrSfRT6g0uQOCCtr9NMMfUZ
        edlhZ0RydtiXME4FDgSBjEeDvyjTwA7ZhU3oacH6QUhwUqx+1q4Mk7KZofBNXcA6p0Y5fL
        B7Vg8ZZavvZ3FcfpCpDZB423VAXNjjLnTt9qMrVYEr+/8PG6JuQMraPBBJ5tiQ==
Date:   Tue, 25 Oct 2022 16:59:57 +0200
From:   Paul Kocialkowski <paul.kocialkowski@bootlin.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     mripard@kernel.org, mchehab@kernel.org, gregkh@linuxfoundation.org,
        wens@csie.org, samuel@sholland.org, hverkuil-cisco@xs4all.nl,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/11] media: cedrus: set codec ops immediately
Message-ID: <Y1f57R7SUPHsS7Lv@aptenodytes>
References: <20221024201515.34129-1-jernej.skrabec@gmail.com>
 <20221024201515.34129-7-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="oD2NMcpZjd/EqoUz"
Content-Disposition: inline
In-Reply-To: <20221024201515.34129-7-jernej.skrabec@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oD2NMcpZjd/EqoUz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Mon 24 Oct 22, 22:15, Jernej Skrabec wrote:
> We'll need codec ops soon after output format is set in following
> commits. Let's move current codec setup to set output format callback.
> While at it, let's remove one level of indirection by changing
> current_codec to point to codec ops structure directly.

This looks much better, thanks!

Acked-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Cheers,

Paul

> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c   |  5 ---
>  drivers/staging/media/sunxi/cedrus/cedrus.h   |  3 +-
>  .../staging/media/sunxi/cedrus/cedrus_dec.c   |  4 +-
>  .../staging/media/sunxi/cedrus/cedrus_hw.c    |  6 +--
>  .../staging/media/sunxi/cedrus/cedrus_video.c | 44 ++++++++-----------
>  5 files changed, 25 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.c
> index 023566b02dc5..8cfe47574c39 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -455,11 +455,6 @@ static int cedrus_probe(struct platform_device *pdev)
>  		return ret;
>  	}
> =20
> -	dev->dec_ops[CEDRUS_CODEC_MPEG2] =3D &cedrus_dec_ops_mpeg2;
> -	dev->dec_ops[CEDRUS_CODEC_H264] =3D &cedrus_dec_ops_h264;
> -	dev->dec_ops[CEDRUS_CODEC_H265] =3D &cedrus_dec_ops_h265;
> -	dev->dec_ops[CEDRUS_CODEC_VP8] =3D &cedrus_dec_ops_vp8;
> -
>  	mutex_init(&dev->dev_mutex);
> =20
>  	INIT_DELAYED_WORK(&dev->watchdog_work, cedrus_watchdog);
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.h b/drivers/stagin=
g/media/sunxi/cedrus/cedrus.h
> index 7a1619967513..0b082b1fae22 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.h
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.h
> @@ -126,7 +126,7 @@ struct cedrus_ctx {
> =20
>  	struct v4l2_pix_format		src_fmt;
>  	struct v4l2_pix_format		dst_fmt;
> -	enum cedrus_codec		current_codec;
> +	struct cedrus_dec_ops		*current_codec;
> =20
>  	struct v4l2_ctrl_handler	hdl;
>  	struct v4l2_ctrl		**ctrls;
> @@ -185,7 +185,6 @@ struct cedrus_dev {
>  	struct platform_device	*pdev;
>  	struct device		*dev;
>  	struct v4l2_m2m_dev	*m2m_dev;
> -	struct cedrus_dec_ops	*dec_ops[CEDRUS_CODEC_LAST];
> =20
>  	/* Device file mutex */
>  	struct mutex		dev_mutex;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c b/drivers/st=
aging/media/sunxi/cedrus/cedrus_dec.c
> index e7f7602a5ab4..fbbf9e6f0f50 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_dec.c
> @@ -94,7 +94,7 @@ void cedrus_device_run(void *priv)
> =20
>  	cedrus_dst_format_set(dev, &ctx->dst_fmt);
> =20
> -	error =3D dev->dec_ops[ctx->current_codec]->setup(ctx, &run);
> +	error =3D ctx->current_codec->setup(ctx, &run);
>  	if (error)
>  		v4l2_err(&ctx->dev->v4l2_dev,
>  			 "Failed to setup decoding job: %d\n", error);
> @@ -110,7 +110,7 @@ void cedrus_device_run(void *priv)
>  		schedule_delayed_work(&dev->watchdog_work,
>  				      msecs_to_jiffies(2000));
> =20
> -		dev->dec_ops[ctx->current_codec]->trigger(ctx);
> +		ctx->current_codec->trigger(ctx);
>  	} else {
>  		v4l2_m2m_buf_done_and_job_finish(ctx->dev->m2m_dev,
>  						 ctx->fh.m2m_ctx,
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c b/drivers/sta=
ging/media/sunxi/cedrus/cedrus_hw.c
> index a6470a89851e..c3387cd1e80f 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_hw.c
> @@ -132,12 +132,12 @@ static irqreturn_t cedrus_irq(int irq, void *data)
>  		return IRQ_NONE;
>  	}
> =20
> -	status =3D dev->dec_ops[ctx->current_codec]->irq_status(ctx);
> +	status =3D ctx->current_codec->irq_status(ctx);
>  	if (status =3D=3D CEDRUS_IRQ_NONE)
>  		return IRQ_NONE;
> =20
> -	dev->dec_ops[ctx->current_codec]->irq_disable(ctx);
> -	dev->dec_ops[ctx->current_codec]->irq_clear(ctx);
> +	ctx->current_codec->irq_disable(ctx);
> +	ctx->current_codec->irq_clear(ctx);
> =20
>  	if (status =3D=3D CEDRUS_IRQ_ERROR)
>  		state =3D VB2_BUF_STATE_ERROR;
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus_video.c b/drivers/=
staging/media/sunxi/cedrus/cedrus_video.c
> index 04b7b87ef0b7..3591bf9d7d9c 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus_video.c
> @@ -335,6 +335,21 @@ static int cedrus_s_fmt_vid_out_p(struct cedrus_ctx =
*ctx,
>  		break;
>  	}
> =20
> +	switch (ctx->src_fmt.pixelformat) {
> +	case V4L2_PIX_FMT_MPEG2_SLICE:
> +		ctx->current_codec =3D &cedrus_dec_ops_mpeg2;
> +		break;
> +	case V4L2_PIX_FMT_H264_SLICE:
> +		ctx->current_codec =3D &cedrus_dec_ops_h264;
> +		break;
> +	case V4L2_PIX_FMT_HEVC_SLICE:
> +		ctx->current_codec =3D &cedrus_dec_ops_h265;
> +		break;
> +	case V4L2_PIX_FMT_VP8_FRAME:
> +		ctx->current_codec =3D &cedrus_dec_ops_vp8;
> +		break;
> +	}
> +
>  	/* Propagate format information to capture. */
>  	ctx->dst_fmt.colorspace =3D pix_fmt->colorspace;
>  	ctx->dst_fmt.xfer_func =3D pix_fmt->xfer_func;
> @@ -493,34 +508,13 @@ static int cedrus_start_streaming(struct vb2_queue =
*vq, unsigned int count)
>  	struct cedrus_dev *dev =3D ctx->dev;
>  	int ret =3D 0;
> =20
> -	switch (ctx->src_fmt.pixelformat) {
> -	case V4L2_PIX_FMT_MPEG2_SLICE:
> -		ctx->current_codec =3D CEDRUS_CODEC_MPEG2;
> -		break;
> -
> -	case V4L2_PIX_FMT_H264_SLICE:
> -		ctx->current_codec =3D CEDRUS_CODEC_H264;
> -		break;
> -
> -	case V4L2_PIX_FMT_HEVC_SLICE:
> -		ctx->current_codec =3D CEDRUS_CODEC_H265;
> -		break;
> -
> -	case V4L2_PIX_FMT_VP8_FRAME:
> -		ctx->current_codec =3D CEDRUS_CODEC_VP8;
> -		break;
> -
> -	default:
> -		return -EINVAL;
> -	}
> -
>  	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
>  		ret =3D pm_runtime_resume_and_get(dev->dev);
>  		if (ret < 0)
>  			goto err_cleanup;
> =20
> -		if (dev->dec_ops[ctx->current_codec]->start) {
> -			ret =3D dev->dec_ops[ctx->current_codec]->start(ctx);
> +		if (ctx->current_codec->start) {
> +			ret =3D ctx->current_codec->start(ctx);
>  			if (ret)
>  				goto err_pm;
>  		}
> @@ -542,8 +536,8 @@ static void cedrus_stop_streaming(struct vb2_queue *v=
q)
>  	struct cedrus_dev *dev =3D ctx->dev;
> =20
>  	if (V4L2_TYPE_IS_OUTPUT(vq->type)) {
> -		if (dev->dec_ops[ctx->current_codec]->stop)
> -			dev->dec_ops[ctx->current_codec]->stop(ctx);
> +		if (ctx->current_codec->stop)
> +			ctx->current_codec->stop(ctx);
> =20
>  		pm_runtime_put(dev->dev);
>  	}
> --=20
> 2.38.1
>=20

--=20
Paul Kocialkowski, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

--oD2NMcpZjd/EqoUz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEJZpWjZeIetVBefti3cLmz3+fv9EFAmNX+e0ACgkQ3cLmz3+f
v9Gh2AgAhZG4wZU9V8QjHESBxFjr2JG0F0DF3rM1ySGskU1UazP7+OPBFB//PrqC
JuDQEtTyNMA5XvfinkUtKVa6P3l0A5TKhxqigNZFTEt3vEey8Juqp8sMsvgIcbK/
nbv1LwGU5hovWKNrsdbhP1DE2hpXNdHQLij6EjGSoK+CxaSBrvLJFL1mHbtCf9sU
IHqIGFjG/qwcU49EN7u4jh0Dr1I93dq6GJGBt05qARkETTb4cZE96YAmXFpQnFSU
rOwWJFgI7uflvuvJwP8ApJEW1CZEXhL+8RQ7IssCnBebmdAqwLlVcUIua3SNMrXR
zvQI4wc66mag2oG7CClXwZFEQZ3+fA==
=g8u3
-----END PGP SIGNATURE-----

--oD2NMcpZjd/EqoUz--
