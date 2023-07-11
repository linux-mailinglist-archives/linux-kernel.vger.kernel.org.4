Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E8174F8E1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbjGKUQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjGKUQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:16:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9882412F;
        Tue, 11 Jul 2023 13:16:23 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:10:88d9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C19656606F62;
        Tue, 11 Jul 2023 21:16:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1689106582;
        bh=ovmdJowpN42/SYoQ1qPuSx2Xrj+upHUIDUOy/UIexEo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P2wABV4/5DuKFdpMw5cXOR4VE6I17sU/p7+weZxlH9MHNQYCDBdrEu9jyQpS7ssdH
         yPWRFWIBh/xC04Azx3hbDfsT6s12cDRwHZUSbU9r6a8XUBXF9aDhkGvTR7EvzUXhxt
         lKrer9ywLoE8tQAeSO15tdQcyTTYdRB1BE7FOhoBHPZk1E1YXMjFmf7wYKqFfPzQB2
         rJ0cpVD/kMZW9AZ/zdmfQVyKD7gTiOwQRrgYEIZ43kAhHIdp593uEyftSzVYWZCx9f
         dkJUYSPdYipii3YJHBrP4nWagSe7jmQu19tjB74pOkp3kqAOCOBJ96ehnxeNXJQrkU
         BaHA6TBWTtwCg==
Message-ID: <c68c63924a2aed6c98818d3ad3b39e065cbd0b15.camel@collabora.com>
Subject: Re: [PATCH 1/3] media: mediatek: vcodec: Add capture format to
 support 10bit tile mode
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
        Steve Cho <stevecho@chromium.org>,
        Mingjia Zhang <mingjia.zhang@mediatek.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Date:   Tue, 11 Jul 2023 16:16:11 -0400
In-Reply-To: <20230711125749.15555-2-yunfei.dong@mediatek.com>
References: <20230711125749.15555-1-yunfei.dong@mediatek.com>
         <20230711125749.15555-2-yunfei.dong@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 11 juillet 2023 =C3=A0 20:57 +0800, Yunfei Dong a =C3=A9crit=C2=A0=
:
> From: Mingjia Zhang <mingjia.zhang@mediatek.com>
>=20
> Define one uncompressed capture format V4L2_PIX_FMT_MT2110T in order to
> support 10bit for AV1/VP9/HEVC in mt8195.
>=20
> Signed-off-by: Mingjia Zhang <mingjia.zhang@mediatek.com>
> Co-developed-by: Yunfei Dong <yunfei.dong@mediatek.com>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> ---
>  Documentation/userspace-api/media/v4l/pixfmt-reserved.rst | 8 ++++++++
>  drivers/media/v4l2-core/v4l2-common.c                     | 2 ++
>  drivers/media/v4l2-core/v4l2-ioctl.c                      | 1 +
>  include/uapi/linux/videodev2.h                            | 1 +
>  4 files changed, 12 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst b/=
Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> index 58f6ae25b2e7..b16a7257580c 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-reserved.rst
> @@ -275,6 +275,14 @@ please make a proposal on the linux-media mailing li=
st.
> =20
>          Decoder's implementation can be found here,
>          `aspeed_codec <https://github.com/AspeedTech-BMC/aspeed_codec/>`=
__
> +    * .. _V4L2-PIX-FMT-MT2110T:
> +
> +      - ``V4L2_PIX_FMT_MT2110T``
> +      - 'MT2110T'
> +      - Two-planar 10-Bit tile mode YVU420 format used by Mediatek MT819=
5, MT8188
> +        and more. This format have similitude with ``V4L2_PIX_FMT_MM21``=
.
> +        It remains an opaque intermediate format and it is used for VP9,=
 AV1
> +        and HEVC.

Documenting uncompressed video formats as "opaque" is always last resort in
V4L2. There is no justification here since this format is already implement=
ed in
software and pending in GStreamer (so its well understood format). I will t=
ry
and provide some better doc for you to include.

https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/3444

>  .. raw:: latex
> =20
>      \normalsize
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index bee1535b04d3..869fc09a210b 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -262,6 +262,8 @@ const struct v4l2_format_info *v4l2_format_info(u32 f=
ormat)
>  		{ .format =3D V4L2_PIX_FMT_VYUY,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 2, 0, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_Y212,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 4, 0, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_YUV48_12, .pixel_enc =3D V4L2_PIXEL_ENC_YUV=
, .mem_planes =3D 1, .comp_planes =3D 1, .bpp =3D { 6, 0, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 1, .vdiv =3D 1 },
> +		{ .format =3D V4L2_PIX_FMT_MT2110T, .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 2, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0 }, .bpp_div =
=3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2,
> +		  .block_w =3D { 16, 8, 0, 0 }, .block_h =3D { 32, 16, 0, 0 }},
> =20
>  		/* YUV planar formats */
>  		{ .format =3D V4L2_PIX_FMT_NV12,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 01ba27f2ef87..f465c0e3d6e3 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1508,6 +1508,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *f=
mt)
>  		case V4L2_PIX_FMT_QC10C:	descr =3D "QCOM Compressed 10-bit Format"; br=
eak;
>  		case V4L2_PIX_FMT_AJPG:		descr =3D "Aspeed JPEG"; break;
>  		case V4L2_PIX_FMT_AV1_FRAME:	descr =3D "AV1 Frame"; break;
> +		case V4L2_PIX_FMT_MT2110T:	descr =3D "Mediatek 10bit Tile Mode"; break=
;
>  		default:
>  			if (fmt->description[0])
>  				return;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index 3af6a82d0cad..8c7d71afbdc7 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -796,6 +796,7 @@ struct v4l2_pix_format {
>  #define V4L2_PIX_FMT_Z16      v4l2_fourcc('Z', '1', '6', ' ') /* Depth d=
ata 16-bit */
>  #define V4L2_PIX_FMT_MT21C    v4l2_fourcc('M', 'T', '2', '1') /* Mediate=
k compressed block mode  */
>  #define V4L2_PIX_FMT_MM21     v4l2_fourcc('M', 'M', '2', '1') /* Mediate=
k 8-bit block mode, two non-contiguous planes */
> +#define V4L2_PIX_FMT_MT2110T  v4l2_fourcc('M', 'T', '2', 'T') /* Mediate=
k 10-bit block tile mode */
>  #define V4L2_PIX_FMT_INZI     v4l2_fourcc('I', 'N', 'Z', 'I') /* Intel P=
lanar Greyscale 10-bit and Depth 16-bit */
>  #define V4L2_PIX_FMT_CNF4     v4l2_fourcc('C', 'N', 'F', '4') /* Intel 4=
-bit packed depth confidence information */
>  #define V4L2_PIX_FMT_HI240    v4l2_fourcc('H', 'I', '2', '4') /* BTTV 8-=
bit dithered RGB */

