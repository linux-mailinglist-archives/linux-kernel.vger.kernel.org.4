Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E4B6E155D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:45:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjDMTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:45:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDMTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:45:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0B15FFC;
        Thu, 13 Apr 2023 12:45:23 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E6C14660320A;
        Thu, 13 Apr 2023 20:45:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681415121;
        bh=65eXoc0efoBylnM4mEtbMIJR7GoFbIdgHVmQ7dbjtnk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=I+T08/8nd/vNj+K+Ux+X4WiNDzGuUjSrBMEpbW7k4/3hnYSTxpLeafNIJsGUSDEPe
         0X/Avei0x9y4S97NGSWvoRGfiUNShH0iz719atXStwoFs4KyzHL8Ll3jkmJWM88sK/
         Oko4DKNAC7TdjjrMCvOZhQ2YR773HTcMQPcAFrZqZ9Kv+5dD5URTiPKfur462HKmjH
         /8aRVCF19v064IcuVLchBJGkGljSa1HNhReaq8wm3jj5SrPihJLtWtjcuKCVS6ypxc
         Du4jatv5B9kteDBrd45WTfrPEPcU9YWgs51Os1jbLbbIfCJRTHD7ZhyyAJLe7LlYFu
         KEnWgJvqNlPOA==
Message-ID: <e377a31f457e226eaa3d23f712696ddb3578ef6b.camel@collabora.com>
Subject: Re: [PATCH] media: verisilicon: Fix crash when probing encoder
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        mchehab@kernel.org, m.szyprowski@samsung.com
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Thu, 13 Apr 2023 15:45:10 -0400
In-Reply-To: <20230413070344.34803-1-benjamin.gaignard@collabora.com>
References: <20230413070344.34803-1-benjamin.gaignard@collabora.com>
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

Le jeudi 13 avril 2023 =C3=A0 09:03 +0200, Benjamin Gaignard a =C3=A9crit=
=C2=A0:
> ctx->vpu_dst_fmt is no more initialized before calling hantro_try_fmt()
> so assigne it to vpu_fmt led to crash the kernel.
> Like for decoder case use 'fmt' as vpu format for encoder and clean up
> the code.
>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Fixes: db6f68b51e5c ("media: verisilicon: Do not set context src/dst form=
ats in reset functions")

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

> ---
>  drivers/media/platform/verisilicon/hantro_v4l2.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/m=
edia/platform/verisilicon/hantro_v4l2.c
> index 8f1414085f47..51f528f36241 100644
> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> @@ -293,13 +293,11 @@ static int hantro_try_fmt(const struct hantro_ctx *=
ctx,
>  		pix_mp->pixelformat =3D fmt->fourcc;
>  	}
> =20
> +	vpu_fmt =3D fmt;
> +
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
> --=20
> 2.34.1
>=20
>=20

