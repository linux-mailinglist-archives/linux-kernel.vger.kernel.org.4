Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ED56DDF0E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjDKPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbjDKPKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:10:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095215580;
        Tue, 11 Apr 2023 08:10:04 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7251866031E9;
        Tue, 11 Apr 2023 16:10:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681225802;
        bh=9k0Jg8J3GXt++MWesXKsmmD95MWnsCWKoCRHApxXOqQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DanWJQXoIwJYObxFPoA/64lTcHUulE/JUcch3sRCJSiz+oCKHFJ29H39zzl2NcrU3
         Y6jcFkkBCUEoaW3//FTfSqnYpoOU0PxIJn6Ll+z03LVZdcNUhDzghC38kxxs3lITvD
         VA3qHQEhvWLB5BVB+cwwxTxGQ3QTUD8R7PE0RgwPqWmjAocUCZecVa27TplEe/BWrM
         6CMcRvBJj+wU29kLDlJVaQWwXkFMRKoK8URjmZmGuKWSLExO/XITGIFHMplKs3PXJv
         KooLCcdgVy7WktSNadwKClb0T1s7n4XjnutzNHzxByGc3Wq3IMPsoYpTYu/S8ojvQs
         MUKgCC9LHcBfw==
Message-ID: <3352700c4545e9c8cc35fd698f17e52259f31c3b.camel@collabora.com>
Subject: Re: [PATCH v5 06/13] media: verisilicon: Check AV1 bitstreams bit
 depth
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil-cisco@xs4all.nl
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Tue, 11 Apr 2023 11:09:52 -0400
In-Reply-To: <20230330154043.1250736-7-benjamin.gaignard@collabora.com>
References: <20230330154043.1250736-1-benjamin.gaignard@collabora.com>
         <20230330154043.1250736-7-benjamin.gaignard@collabora.com>
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
> The driver supports 8 and 10 bits bitstreams, make sure to discard
> other cases.
> It could happens that userland test if V4L2_CID_STATELESS_AV1_SEQUENCE
> exists without setting bit_depth field in this case use
> HANTRO_DEFAULT_BIT_DEPTH value.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  .../media/platform/verisilicon/hantro_drv.c   | 36 +++++++++++++++++++
>  .../media/platform/verisilicon/hantro_v4l2.c  |  4 +++
>  2 files changed, 40 insertions(+)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/me=
dia/platform/verisilicon/hantro_drv.c
> index 74641c972f1e..71bd68e63859 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -275,7 +275,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>  		/* We only support profile 0 */
>  		if (dec_params->profile !=3D 0)
>  			return -EINVAL;
> +	} else if (ctrl->id =3D=3D V4L2_CID_STATELESS_AV1_SEQUENCE) {
> +		const struct v4l2_ctrl_av1_sequence *sequence =3D ctrl->p_new.p_av1_se=
quence;
> +
> +		if (sequence->bit_depth !=3D 8 && sequence->bit_depth !=3D 10)
> +			return -EINVAL;
>  	}
> +
>  	return 0;
>  }
> =20
> @@ -346,6 +352,30 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl=
)
>  	return 0;
>  }
> =20
> +static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
> +{
> +	struct hantro_ctx *ctx;
> +
> +	ctx =3D container_of(ctrl->handler,
> +			   struct hantro_ctx, ctrl_handler);
> +
> +	switch (ctrl->id) {
> +	case V4L2_CID_STATELESS_AV1_SEQUENCE:
> +	{
> +		int bit_depth =3D ctrl->p_new.p_av1_sequence->bit_depth;
> +
> +		if (ctx->bit_depth =3D=3D bit_depth)
> +			return 0;
> +
> +		return hantro_reset_raw_fmt(ctx, bit_depth);
> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static const struct v4l2_ctrl_ops hantro_ctrl_ops =3D {
>  	.try_ctrl =3D hantro_try_ctrl,
>  };
> @@ -363,6 +393,11 @@ static const struct v4l2_ctrl_ops hantro_hevc_ctrl_o=
ps =3D {
>  	.s_ctrl =3D hantro_hevc_s_ctrl,
>  };
> =20
> +static const struct v4l2_ctrl_ops hantro_av1_ctrl_ops =3D {
> +	.try_ctrl =3D hantro_try_ctrl,
> +	.s_ctrl =3D hantro_av1_s_ctrl,
> +};
> +
>  #define HANTRO_JPEG_ACTIVE_MARKERS	(V4L2_JPEG_ACTIVE_MARKER_APP0 | \
>  					 V4L2_JPEG_ACTIVE_MARKER_COM | \
>  					 V4L2_JPEG_ACTIVE_MARKER_DQT | \
> @@ -540,6 +575,7 @@ static const struct hantro_ctrl controls[] =3D {
>  		.codec =3D HANTRO_AV1_DECODER,
>  		.cfg =3D {
>  			.id =3D V4L2_CID_STATELESS_AV1_SEQUENCE,
> +			.ops =3D &hantro_av1_ctrl_ops,
>  		},
>  	}, {
>  		.codec =3D HANTRO_AV1_DECODER,
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 7ed2dfd4aefa..e2a8838f75f0 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -86,6 +86,10 @@ hantro_check_depth_match(const struct hantro_fmt *fmt,=
 int bit_depth)
>  	if (!fmt->match_depth && !fmt->postprocessed)
>  		return true;
> =20
> +	/* 0 means default depth, which is 8 */
> +	if (!bit_depth)
> +		bit_depth =3D HANTRO_DEFAULT_BIT_DEPTH;
> +
>  	fmt_depth =3D hantro_get_format_depth(fmt->fourcc);
> =20
>  	/*

