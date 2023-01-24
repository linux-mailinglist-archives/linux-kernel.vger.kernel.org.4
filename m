Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E9679B58
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 15:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234826AbjAXOQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 09:16:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbjAXOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 09:16:20 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F329B47EFE;
        Tue, 24 Jan 2023 06:16:17 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E444D66018E4;
        Tue, 24 Jan 2023 14:16:14 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674569776;
        bh=s47CGVJ4e+M+0waJGcv4TlZkKgbgs+1KN4fTvbSmCw4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=T5quUrXp5EMyS+m5En1TAtvR5bnV7h56/mMlGRbDIVb8fKHyJM8J4llOCgQOM0Oa8
         QyO15DDdK3DACIHrjbDozZc/ubjiKB/ht4WipqKrT0TqHt12Aoq9Y9iox/ZQFwn8LH
         pZIDRWLouYq6SIjK68Fo9hQyx5Mj0489Y8e0rzmruf9na0Vk86FwKtHZs+D3Bf6RUt
         qlrkeQOfTaQlVYilurRa+1eLgB3WJWEYUJYBwgB1Sczbsh3gQYhzNTCtDqGOadgoDL
         M3oMSTa0jBZ6DcWAXQtYiN8OFI8di113yfBn9w9O43oWFjAZQFerh28pjUr6i4QszG
         Dfr6WPpIZACAw==
Message-ID: <b31a3327aa2a500c6509f8f54632954bf2cea19b.camel@collabora.com>
Subject: Re: [PATCH v3 1/7] media: Add P010 tiled format
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jernej Skrabec <jernej.skrabec@gmail.com>,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de
Cc:     mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        benjamin.gaignard@collabora.com, gregkh@linuxfoundation.org,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Date:   Tue, 24 Jan 2023 09:16:06 -0500
In-Reply-To: <20220706182901.78949-2-jernej.skrabec@gmail.com>
References: <20220706182901.78949-1-jernej.skrabec@gmail.com>
         <20220706182901.78949-2-jernej.skrabec@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel, Benjamin,

Le mercredi 06 juillet 2022 =C3=A0 20:28 +0200, Jernej Skrabec a =C3=A9crit=
=C2=A0:
> From: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>=20
> Add P010 tiled format
>=20
> Tested-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

I just tested Hantro G2 myself, and that highlights that this was not reall=
y
tested. I believe no-one had written software detiler to verify this, so te=
sted
meant something like "its producing data". In fact, it seems that P010_4L4 =
is
not a pixel formats, at least not one covered by Hantro driver.

I've dumped the tiled data, and the per tile format is not made of 16bit
components, but instead its similar to Rockchip format, where 4 pixels are
packed  over. As part of the AV1 driver writing, I made a detiler for that
format.

https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3447

Let's be more careful next time, pixels formats are frozen into our API, an=
d
there is a lot of them already, lets not invent any.

Hans, what should we do about this one ? I can split off the NV12_10LE40_4L=
4
format from the AV1 patchset, and port G2 to use that instead. That would l=
eave
behind P010_4L4 as unused (actually unexistant). Any better ideas ? Perhaps=
 we
could steal the fourcc, its not terribly meaningful, and make P010_4L4 an a=
lias
?

Nicolas

> Signed-off-by: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> [rebased, updated pixel format name and added description]
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> ---
>  .../media/v4l/pixfmt-yuv-planar.rst            | 18 +++++++++++++++---
>  drivers/media/v4l2-core/v4l2-common.c          |  1 +
>  drivers/media/v4l2-core/v4l2-ioctl.c           |  1 +
>  include/uapi/linux/videodev2.h                 |  1 +
>  4 files changed, 18 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index a900ff66911a..faba259a2b92 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -116,6 +116,13 @@ All components are stored with the same number of bi=
ts per component.
>        - Cb, Cr
>        - Yes
>        - Linear
> +    * - V4L2_PIX_FMT_P010_4L4
> +      - 'T010'
> +      - 10
> +      - 4:2:0
> +      - Cb, Cr
> +      - Yes
> +      - 4x4 tiles
>      * - V4L2_PIX_FMT_NV16
>        - 'NV16'
>        - 8
> @@ -528,11 +535,12 @@ number of lines as the luma plane.
>        - Cr\ :sub:`33`
> =20
>  .. _V4L2_PIX_FMT_P010:
> +.. _V4L2-PIX-FMT-P010-4L4:
> =20
> -P010
> -----
> +P010 and tiled P010
> +-------------------
> =20
> -Like NV12 with 10 bits per component, expanded to 16 bits.
> +P010 is like NV12 with 10 bits per component, expanded to 16 bits.
>  Data in the 10 high bits, zeros in the 6 low bits, arranged in little en=
dian order.
> =20
>  .. flat-table:: Sample 4x4 P010 Image
> @@ -570,6 +578,10 @@ Data in the 10 high bits, zeros in the 6 low bits, a=
rranged in little endian ord
>        - Cb\ :sub:`11`
>        - Cr\ :sub:`11`
> =20
> +``V4L2_PIX_FMT_P010_4L4`` stores pixels in 4x4 tiles, and stores tiles l=
inearly
> +in memory. The line stride must be aligned to multiple of 8 and image he=
ight to
> +a multiple of 4. The layouts of the luma and chroma planes are identical=
.
> +
>  .. raw:: latex
> =20
>      \endgroup
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 1e38ad8906a2..e0fbe6ba4b6c 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -278,6 +278,7 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
> =20
>  		/* Tiled YUV formats */
>  		{ .format =3D V4L2_PIX_FMT_NV12_4L4, .pixel_enc =3D V4L2_PIXEL_ENC_YUV=
, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .hdiv =3D=
 2, .vdiv =3D 2 },
> +		{ .format =3D V4L2_PIX_FMT_P010_4L4, .pixel_enc =3D V4L2_PIXEL_ENC_YUV=
, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 2, 4, 0, 0 }, .hdiv =3D=
 2, .vdiv =3D 2 },
> =20
>  		/* YUV planar formats, non contiguous variant */
>  		{ .format =3D V4L2_PIX_FMT_YUV420M, .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 3, .comp_planes =3D 3, .bpp =3D { 1, 1, 1, 0 }, .hdiv =3D =
2, .vdiv =3D 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index e2526701294e..7aa3af389b51 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1310,6 +1310,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  	case V4L2_PIX_FMT_NV12_4L4:	descr =3D "Y/CbCr 4:2:0 (4x4 Linear)"; brea=
k;
>  	case V4L2_PIX_FMT_NV12_16L16:	descr =3D "Y/CbCr 4:2:0 (16x16 Linear)"; =
break;
>  	case V4L2_PIX_FMT_NV12_32L32:   descr =3D "Y/CbCr 4:2:0 (32x32 Linear)"=
; break;
> +	case V4L2_PIX_FMT_P010_4L4:	descr =3D "10-bit Y/CbCr 4:2:0 (4x4 Linear)=
"; break;
>  	case V4L2_PIX_FMT_NV12M:	descr =3D "Y/CbCr 4:2:0 (N-C)"; break;
>  	case V4L2_PIX_FMT_NV21M:	descr =3D "Y/CrCb 4:2:0 (N-C)"; break;
>  	case V4L2_PIX_FMT_NV16M:	descr =3D "Y/CbCr 4:2:2 (N-C)"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 5311ac4fde35..32bedeb04152 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -630,6 +630,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_NV12_4L4 v4l2_fourcc('V', 'T', '1', '2')   /* 12  Y=
/CbCr 4:2:0  4x4 tiles */
>  #define V4L2_PIX_FMT_NV12_16L16 v4l2_fourcc('H', 'M', '1', '2') /* 12  Y=
/CbCr 4:2:0 16x16 tiles */
>  #define V4L2_PIX_FMT_NV12_32L32 v4l2_fourcc('S', 'T', '1', '2') /* 12  Y=
/CbCr 4:2:0 32x32 tiles */
> +#define V4L2_PIX_FMT_P010_4L4 v4l2_fourcc('T', '0', '1', '0') /* 12  Y/C=
bCr 4:2:0 10-bit 4x4 macroblocks */
> =20
>  /* Tiled YUV formats, non contiguous planes */
>  #define V4L2_PIX_FMT_NV12MT  v4l2_fourcc('T', 'M', '1', '2') /* 12  Y/Cb=
Cr 4:2:0 64x32 tiles */

