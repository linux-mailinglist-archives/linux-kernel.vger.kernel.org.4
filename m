Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D316686A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234936AbjALWMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240653AbjALWMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:12:12 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34619E6B;
        Thu, 12 Jan 2023 14:05:02 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 08AE66602D54;
        Thu, 12 Jan 2023 22:04:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673561100;
        bh=kOMVDEXFq4/gJd+K2tgHZJAO1f2esFq2DYX+6vdRSME=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jTJwiwx1kGgVw040EUc71KP3qzQwb/pnOcE9d4QeMePOM5AOIkF+pindkJ//d0UxZ
         y+LIpX2giSWXkyZBoH+c/PNkbg/O9st9Q2evDqxVqMM21r9BDhd8PAXjG4fJHfnKD8
         MxNeZyUFdK6LquUUlaJ6SZqaKvk7Vb9vC8qHkESKI7TdntYJff04PjLo9W+joRoFsG
         4yhUYO4U0pjgx/Rnnx198Q3XLjCHL+bx34DQQg+yzL+DomcijYwaPcZioEmiQGNW+g
         VaYFitW4EERtpdOGTFFEjb2wc4+fK74Gxha97ZGwDcN61qz2MOyIAihRcxZtfD6M/m
         cZa4ONR9dJqEQ==
Message-ID: <6827059d3b3158bf2f8dfb2346a7e854d2a533a3.camel@collabora.com>
Subject: Re: [PATCH v2 11/12] staging: media: rkvdec: Enable S_CTRL IOCTL
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        Jonas Karlman <jonas@kwiboo.se>,
        Alex Bee <knaerzche@gmail.com>,
        Collabora Kernel-domain <kernel@collabora.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>
Date:   Thu, 12 Jan 2023 17:04:48 -0500
In-Reply-To: <CAAEAJfDm3FBUkacR+tRVYnEbO8g43RT_L89WQuZjRi-Kwn7CYA@mail.gmail.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
         <20230101-patch-series-v2-6-2-rc1-v2-11-fa1897efac14@collabora.com>
         <CAAEAJfDm3FBUkacR+tRVYnEbO8g43RT_L89WQuZjRi-Kwn7CYA@mail.gmail.com>
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

Le jeudi 12 janvier 2023 =C3=A0 12:09 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> Hi Sebastian,
>=20
> On Thu, Jan 12, 2023 at 9:57 AM Sebastian Fricke
> <sebastian.fricke@collabora.com> wrote:
> >=20
> > Enable user-space to set the SPS of the current byte-stream on the
> > decoder. This action will enable the decoder to pick the optimal
> > pixel-format for the capture queue, whenever it is required.
> >=20
> > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> > ---
> >  drivers/staging/media/rkvdec/rkvdec.c | 81 +++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 81 insertions(+)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec.c b/drivers/staging/me=
dia/rkvdec/rkvdec.c
> > index b303c6e0286d..3d413c5ad1d2 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec.c
> > @@ -93,6 +93,79 @@ static int rkvdec_get_sps_attributes(struct rkvdec_c=
tx *ctx, void *sps,
> >         return 0;
> >  }
> >=20
> > +static int rkvdec_set_sps(struct rkvdec_ctx *ctx, struct v4l2_ctrl *ct=
rl)
> > +{
> > +       struct v4l2_pix_format_mplane *pix_mp;
> > +       struct sps_attributes attributes =3D {0};
> > +       void *new_sps =3D NULL;
> > +
> > +       /*
> > +        * SPS structures are not filled until the control handler is s=
et up
> > +        */
> > +       if (!ctx->fh.ctrl_handler)
> > +               return 0;
>=20
> The control handler is embedded in the context, and the fh.ctrl_handler
> is initialized when the context is returned.
>=20
> You cannot have a context without a control handler (see hantro_open).
>=20
> > +
> > +       switch (ctrl->id) {
> > +       case V4L2_CID_STATELESS_H264_SPS:
> > +               new_sps =3D (void *)ctrl->p_new.p_h264_sps;
> > +               break;
> > +       case V4L2_CID_STATELESS_HEVC_SPS:
> > +               new_sps =3D (void *)ctrl->p_new.p_hevc_sps;
> > +               break;
> > +       default:
> > +               dev_err(ctx->dev->dev, "Unsupported stateless control I=
D: %x\n", ctrl->id);
> > +               return -EINVAL;
> > +       };
> > +       rkvdec_get_sps_attributes(ctx, new_sps, &attributes);
> > +
> > +       /*
> > +        * Providing an empty SPS is valid but we do not store it.
> > +        */
> > +       if (attributes.width =3D=3D 0 && attributes.height =3D=3D 0)
> > +               return 0;
> > +
> > +       pix_mp =3D &ctx->decoded_fmt.fmt.pix_mp;
> > +
> > +       /*
> > +        * SPS must match the provided format dimension, if it doesn't =
userspace has to
> > +        * first reset the output format
>=20
> This comment says it's a mismatch check, but the check is checking for
> "larger than".
>=20
> Other than that, the general idea looks good, can you rework the series t=
o avoid
> the extra storage of the SPS control in the context?

I'm not fan, but the careless alignment code states that the coded size can=
not
be lower then 64x64, but while running the conformance, there is bunch of f=
iles
that have coded dimensions lower. And here's the reason why its not =3D=3D.=
 I don't
really like this, but confusing allocation padding and coded size capabilit=
y
seems to be deep down into rkvdec driver design.

If I only look at the FMT(OUTPUT) behaviour, anything < 64x64 is strictly n=
ot
supported by the driver, this the interpretation ffmpeg request code have, =
and
they are actually right. GStreamer simply does not check anything, and try
(there is not validation code there yet, and I don't want to add any until =
we
figure-out a solution).

>=20
> Thanks,
> Ezequiel
>=20
> > +        */
> > +       if ((attributes.width > pix_mp->width) || (attributes.height > =
pix_mp->height)) {
> > +               dev_err(ctx->dev->dev,
> > +                       "Dimension mismatch. [%s SPS] W: %d, H: %d, [Fo=
rmat] W: %d, H: %d)\n",
> > +                       ctrl->id =3D=3D V4L2_CID_STATELESS_HEVC_SPS ? "=
HEVC" : "H264",
> > +                       attributes.width, attributes.height, pix_mp->wi=
dth, pix_mp->height);
> > +               return -EINVAL;
> > +       }
> > +
> > +       if (ctx->sps && pix_mp->pixelformat =3D=3D rkvdec_get_valid_fmt=
(ctx)) {
> > +               /*
> > +                * Userspace is allowed to change the SPS at any point,=
 if the
> > +                * pixel format doesn't differ from the format in the c=
ontext,
> > +                * just accept the change even if buffers are queued
> > +                */
> > +               ctx->sps =3D new_sps;
> > +       } else {
> > +               /*
> > +                * Do not accept changing the SPS, while buffers are qu=
eued,
> > +                * when the new SPS would cause switching the CAPTURE p=
ixel format
> > +                */
> > +               if (pix_mp->pixelformat !=3D rkvdec_get_valid_fmt(ctx))=
 {
> > +                       if (rkvdec_queue_busy(ctx, V4L2_BUF_TYPE_VIDEO_=
CAPTURE_MPLANE))
> > +                               return -EBUSY;
> > +               }
> > +               ctx->sps =3D new_sps;
> > +               /*
> > +                * For the initial SPS setting and when the pixel forma=
t is
> > +                * changed adjust the pixel format stored in the contex=
t
> > +                */
> > +               pix_mp->pixelformat =3D rkvdec_get_valid_fmt(ctx);
> > +               rkvdec_fill_decoded_pixfmt(ctx, pix_mp);
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> >  static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
> >  {
> >         struct rkvdec_ctx *ctx =3D container_of(ctrl->handler, struct r=
kvdec_ctx, ctrl_hdl);
> > @@ -104,8 +177,16 @@ static int rkvdec_try_ctrl(struct v4l2_ctrl *ctrl)
> >         return 0;
> >  }
> >=20
> > +static int rkvdec_s_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +       struct rkvdec_ctx *ctx =3D container_of(ctrl->handler, struct r=
kvdec_ctx, ctrl_hdl);
> > +
> > +       return rkvdec_set_sps(ctx, ctrl);
> > +}
> > +
> >  static const struct v4l2_ctrl_ops rkvdec_ctrl_ops =3D {
> >         .try_ctrl =3D rkvdec_try_ctrl,
> > +       .s_ctrl =3D rkvdec_s_ctrl,
> >  };
> >=20
> >  static const struct rkvdec_ctrl_desc rkvdec_h264_ctrl_descs[] =3D {
> >=20
> > --
> > 2.25.1

