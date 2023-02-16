Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A7A699AB9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 18:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjBPRA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 12:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBPRAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 12:00:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F0D1731;
        Thu, 16 Feb 2023 09:00:23 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 69A3A66020E1;
        Thu, 16 Feb 2023 17:00:19 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676566821;
        bh=DO0zRY/SN2YP3EDp5S9LS38bcetUlw2AqR8pE8gxXC4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=l2hdDR/n4QJY55qMAxG+E6DI/t/rVpCKD131CGH7Mnw05erHRAqLArwneMJaRJX8W
         AGwhYEdhdBn0K5kCkQSz20AGZ7ulsjkXps0jBcc3U08JEGMaAvRhmZBknwfHYuo81l
         YJ41tpI5efWA4qqqq6aHr3FY48f8Z47lOGWDcetNsotsw8ay//qi9KWzUEnG/47koK
         yQeFjZVVpTE6SdNOPGJ+O55/q6VeXpkJdeJfuiBIWLEoUoijRCedpHsEMz7Auqh3hY
         gkOZZcA6t3Yd2PSSiWTWOUOuUIY/AWC5tsVH+iOc6tdTFm3Wh12TnFDhWEK68jAEIV
         S4fzFYcFaCGnA==
Message-ID: <c30fad90fcc48802b6f8be632789a5f034711797.camel@collabora.com>
Subject: Re: [PATCH v2 01/12] media: v4l2: Add NV15 pixel format
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hsia-Jun Li <Randy.Li@synaptics.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Thu, 16 Feb 2023 12:00:08 -0500
In-Reply-To: <aa85c526-da32-d108-f85e-5dcd2cc8c846@synaptics.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
         <20230101-patch-series-v2-6-2-rc1-v2-1-fa1897efac14@collabora.com>
         <aa85c526-da32-d108-f85e-5dcd2cc8c846@synaptics.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 16 f=C3=A9vrier 2023 =C3=A0 16:57 +0800, Hsia-Jun Li a =C3=A9crit=
=C2=A0:
>=20
> On 1/12/23 20:56, Sebastian Fricke wrote:
> > CAUTION: Email originated externally, do not click links or open attach=
ments unless you recognize the sender and know the content is safe.
> >=20
> >=20
> > From: Jonas Karlman <jonas@kwiboo.se>
> >=20
> > Add the NV15 pixel format used by the Rockchip Video Decoder for 10-bit=
 buffers.
> >=20
> I think this pixel format in the Rockchip platform supports multiple=20
> planes buffers. It is all right not to add more variant until the ext=20
> pixel format and buffer APIs are merged.
>=20
> I just want to mention the need of this.

Can you extend, I don't see that support in rkvdec driver (nor in mpp).

	/* config output base address */
	dst_addr =3D vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
	writel_relaxed(dst_addr, rkvdec->regs + RKVDEC_REG_DECOUT_BASE);

	reg =3D RKVDEC_Y_VIRSTRIDE(y_virstride / 16);
	writel_relaxed(reg, rkvdec->regs + RKVDEC_REG_Y_VIRSTRIDE);

	reg =3D RKVDEC_YUV_VIRSTRIDE(yuv_virstride / 16);
	writel_relaxed(reg, rkvdec->regs + RKVDEC_REG_YUV_VIRSTRIDE);

That looks like a base address and 2 strides only. For NV15M (multiple
allocation) you'd need 2 addresses. It could be that RGA or newer chip have=
 that
support, but as you know, we add formats only when actually using them.

regards,
Nicolas

> > NV15 is a packed 10-bit 4:2:0 Y/CbCr format similar to P010 and P210 bu=
t has no
> > padding between components. Instead, luminance and chrominance samples =
are grouped
> > into 4s so that each group is packed into an integer number of bytes:
> >=20
> > YYYY =3D UVUV =3D 4 * 10 bits =3D 40 bits =3D 5 bytes
> >=20
> > The '15' suffix refers to the optimum effective bits per pixel
> > which is achieved when the total number of luminance samples is a multi=
ple
> > of 8 for NV15.
> >=20
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > ---
> >   .../userspace-api/media/v4l/pixfmt-yuv-planar.rst  | 75 +++++++++++++=
+++++++++
> >   drivers/media/v4l2-core/v4l2-common.c              |  2 +
> >   drivers/media/v4l2-core/v4l2-ioctl.c               |  1 +
> >   include/uapi/linux/videodev2.h                     |  1 +
> >   4 files changed, 79 insertions(+)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rs=
t b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > index f1d5bb7b806d..7d8d228f8063 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > @@ -79,6 +79,13 @@ All components are stored with the same number of bi=
ts per component.
> >         - Cr, Cb
> >         - Yes
> >         - Linear
> > +    * - V4L2_PIX_FMT_NV15
> > +      - 'NV15'
> > +      - 15
> > +      - 4:2:0
> > +      - Cb, Cr
> > +      - Yes
> > +      - Linear
> >       * - V4L2_PIX_FMT_NV12M
> >         - 'NM12'
> >         - 8
> > @@ -183,6 +190,7 @@ horizontally.
> >=20
> >   .. _V4L2-PIX-FMT-NV12:
> >   .. _V4L2-PIX-FMT-NV21:
> > +.. _V4L2-PIX-FMT-NV15:
> >   .. _V4L2-PIX-FMT-NV12M:
> >   .. _V4L2-PIX-FMT-NV21M:
> >   .. _V4L2-PIX-FMT-P010:
> > @@ -586,6 +594,73 @@ Data in the 10 high bits, zeros in the 6 low bits,=
 arranged in little endian ord
> >         - Cb\ :sub:`11`
> >         - Cr\ :sub:`11`
> >=20
> > +.. _V4L2_PIX_FMT_NV15:
> > +
> > +NV15
> > +----
> > +
> > +Similar to P010, a semi-planar 10-bit Y/CbCr format, but all component=
s are
> > +packed without any padding between each other. As a side-effect, each =
group of
> > +4 components are stored over 5 bytes (YYYY or UVUV =3D 4 * 10 bits =3D=
 40 bits =3D 5
> > +bytes).
> > +
> > +.. flat-table:: Sample 4x4 NV15 Image
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +
> > +    * - start + 0:
> > +      - Y'\ :sub:`00`
> > +      - Y'\ :sub:`01`
> > +      - Y'\ :sub:`02`
> > +      - Y'\ :sub:`03`
> > +    * - start + 8:
> > +      - Y'\ :sub:`04`
> > +      - Y'\ :sub:`10`
> > +      - Y'\ :sub:`11`
> > +      - Y'\ :sub:`12`
> > +    * - start + 16:
> > +      - Y'\ :sub:`13`
> > +      - Y'\ :sub:`14`
> > +      - Y'\ :sub:`20`
> > +      - Y'\ :sub:`21`
> > +    * - start + 24:
> > +      - Y'\ :sub:`22`
> > +      - Y'\ :sub:`23`
> > +      - Y'\ :sub:`24`
> > +      - Y'\ :sub:`30`
> > +    * - start + 32:
> > +      - Y'\ :sub:`31`
> > +      - Y'\ :sub:`32`
> > +      - Y'\ :sub:`33`
> > +      - Y'\ :sub:`34`
> > +
> > +    * - start + 0:
> > +      - Cb\ :sub:`00`
> > +      - Cr\ :sub:`00`
> > +      - Cb\ :sub:`01`
> > +      - Cr\ :sub:`01`
> > +    * - start + 8:
> > +      - Cb\ :sub:`02`
> > +      - Cr\ :sub:`02`
> > +      - Cb\ :sub:`03`
> > +      - Cr\ :sub:`03`
> > +    * - start + 16:
> > +      - Cb\ :sub:`04`
> > +      - Cr\ :sub:`04`
> > +      - Cb\ :sub:`10`
> > +      - Cr\ :sub:`10`
> > +    * - start + 24:
> > +      - Cb\ :sub:`11`
> > +      - Cr\ :sub:`11`
> > +      - Cb\ :sub:`12`
> > +      - Cr\ :sub:`12`
> > +    * - start + 32:
> > +      - Cb\ :sub:`13`
> > +      - Cr\ :sub:`13`
> > +      - Cb\ :sub:`14`
> > +      - Cr\ :sub:`14`
> > +
> > +.. raw:: latex
> >=20
> >   Fully Planar YUV Formats
> >   =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2=
-core/v4l2-common.c
> > index 40f56e044640..be23e319fb3a 100644
> > --- a/drivers/media/v4l2-core/v4l2-common.c
> > +++ b/drivers/media/v4l2-core/v4l2-common.c
> > @@ -262,6 +262,8 @@ const struct v4l2_format_info *v4l2_format_info(u32=
 format)
> >                  /* YUV planar formats */
> >                  { .format =3D V4L2_PIX_FMT_NV12,    .pixel_enc =3D V4L=
2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0,=
 0 }, .hdiv =3D 2, .vdiv =3D 2 },
> >                  { .format =3D V4L2_PIX_FMT_NV21,    .pixel_enc =3D V4L=
2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0,=
 0 }, .hdiv =3D 2, .vdiv =3D 2 },
> > +               { .format =3D V4L2_PIX_FMT_NV15,    .pixel_enc =3D V4L2=
_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 5, 5, 0, =
0 }, .hdiv =3D 2, .vdiv =3D 2,
> > +                 .block_w =3D { 4, 2, 0, 0 }, .block_h =3D { 1, 1, 0, =
0 } },
> >                  { .format =3D V4L2_PIX_FMT_NV16,    .pixel_enc =3D V4L=
2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0,=
 0 }, .hdiv =3D 2, .vdiv =3D 1 },
> >                  { .format =3D V4L2_PIX_FMT_NV61,    .pixel_enc =3D V4L=
2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0,=
 0 }, .hdiv =3D 2, .vdiv =3D 1 },
> >                  { .format =3D V4L2_PIX_FMT_NV24,    .pixel_enc =3D V4L=
2_PIXEL_ENC_YUV, .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0,=
 0 }, .hdiv =3D 1, .vdiv =3D 1 },
> > diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-=
core/v4l2-ioctl.c
> > index 8e0a0ff62a70..1c80ad78ef00 100644
> > --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> > +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> > @@ -1343,6 +1343,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc =
*fmt)
> >          case V4L2_PIX_FMT_M420:         descr =3D "YUV 4:2:0 (M420)"; =
break;
> >          case V4L2_PIX_FMT_NV12:         descr =3D "Y/UV 4:2:0"; break;
> >          case V4L2_PIX_FMT_NV21:         descr =3D "Y/VU 4:2:0"; break;
> > +       case V4L2_PIX_FMT_NV15:         descr =3D "10-bit Y/UV 4:2:0 (P=
acked)"; break;
> >          case V4L2_PIX_FMT_NV16:         descr =3D "Y/UV 4:2:2"; break;
> >          case V4L2_PIX_FMT_NV61:         descr =3D "Y/VU 4:2:2"; break;
> >          case V4L2_PIX_FMT_NV24:         descr =3D "Y/UV 4:4:4"; break;
> > diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videod=
ev2.h
> > index 1befd181a4cc..e9731286dc77 100644
> > --- a/include/uapi/linux/videodev2.h
> > +++ b/include/uapi/linux/videodev2.h
> > @@ -621,6 +621,7 @@ struct v4l2_pix_format {
> >   /* two planes -- one Y, one Cr + Cb interleaved  */
> >   #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y=
/CbCr 4:2:0  */
> >   #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y=
/CrCb 4:2:0  */
> > +#define V4L2_PIX_FMT_NV15    v4l2_fourcc('N', 'V', '1', '5') /* 15  Y/=
CbCr 4:2:0 10-bit packed */
> >   #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y=
/CbCr 4:2:2  */
> >   #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y=
/CrCb 4:2:2  */
> >   #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y=
/CbCr 4:4:4  */
> >=20
> > --
> > 2.25.1
>=20

