Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054E06E1567
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:49:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjDMTtt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:49:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMTts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:49:48 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF981FC1;
        Thu, 13 Apr 2023 12:49:47 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19413660320A;
        Thu, 13 Apr 2023 20:49:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681415386;
        bh=33ztFNKOpkHxAjMI2GtUpgW6g+FEs/sAItMi5JB2yj4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DymNRe6sOeOrsjk1oMDLD4c5cnhnTp1ty2+svjZCB2wYXz5rRygi4I4I1NXUAjDZT
         cEky83h8kJBh0l2dqrvO7/IxMAcQ81im+9tb5Yb+QFKAmIxQI3szMzsjwdT+dY0EHE
         c16kUP8Rmf9Z+CRxqSJ0hll8taVbpj4vo4d7Fng5pbjH4srCroCdKSuThjjsrGfRrg
         bolya6Ong11I3FcKkdSBUNZsUaKxDRaMc7HL3ynjnxkX6HT+ZfxeBi3CDP8fgmKq95
         63qS1reGyYZDfTbmoAkG0VhK/5rfKE68EX9+P6DFb15zmENwVLEiBdcbr1I12eu8FI
         gnhP5EoiXcYhg==
Message-ID: <c81a218076a40228630ad192efa8d3a9079013e4.camel@collabora.com>
Subject: Re: [PATCH v2] media: verisilicon: Fix crash when probing encoder
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Thu, 13 Apr 2023 15:49:36 -0400
In-Reply-To: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
References: <20230413104756.356695-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

cause I sent a Rb on old one after v2 was sent, the extra cleanup make sens=
e to
me.

Le jeudi 13 avril 2023 =C3=A0 12:47 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> ctx->vpu_dst_fmt is no more initialized before calling hantro_try_fmt()
> so assigne it to vpu_fmt led to crash the kernel.
> Like for decoder case use 'fmt' as format for encoder and clean up
> the code.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst form=
ats in reset functions")


Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
> version 2:
> - Remove useless vpu_fmt.
>=20
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 8f1414085f47..d71f79471396 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -275,7 +275,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ct=
x,
>  			  struct v4l2_pix_format_mplane *pix_mp,
>  			  enum v4l2_buf_type type)
>  {
> -	const struct hantro_fmt *fmt, *vpu_fmt;
> +	const struct hantro_fmt *fmt;
>  	bool capture =3D V4L2_TYPE_IS_CAPTURE(type);
>  	bool coded;
> =20
> @@ -295,11 +295,7 @@ static int hantro_try_fmt(const struct hantro_ctx *c=
tx,
> =20
>  	if (coded) {
>  		pix_mp->num_planes =3D 1;
> -		vpu_fmt =3D fmt;
> -	} else if (ctx->is_encoder) {
> -		vpu_fmt =3D ctx->vpu_dst_fmt;
> -	} else {
> -		vpu_fmt =3D fmt;
> +	} else if (!ctx->is_encoder) {
>  		/*
>  		 * Width/height on the CAPTURE end of a decoder are ignored and
>  		 * replaced by the OUTPUT ones.
> @@ -311,7 +307,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ct=
x,
>  	pix_mp->field =3D V4L2_FIELD_NONE;
> =20
>  	v4l2_apply_frmsize_constraints(&pix_mp->width, &pix_mp->height,
> -				       &vpu_fmt->frmsize);
> +				       &fmt->frmsize);
> =20
>  	if (!coded) {
>  		/* Fill remaining fields */
> --=20
> 2.34.1
>=20
>=20

