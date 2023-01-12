Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31D366867C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 23:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240331AbjALWJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 17:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240327AbjALWId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 17:08:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459DC1EA;
        Thu, 12 Jan 2023 13:59:11 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B7526602D54;
        Thu, 12 Jan 2023 21:59:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673560749;
        bh=QNUS1EWqWeAuCxJFcUKOsOb/alY4Y2PQWCbxkVvG/j0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=jqjC/5PQ+7KFmswb7xkwz4HRRe4F2Z8G39l/wH9SpChntH5GQAaVaGSymGSc/7Jta
         +qFsTkiYXfg+VMfK5ZPVmOB1EKk/dQyrdL94x22X6cHOv8JM5wGD/GZAx/yod9O7bZ
         MVJgaq8dBrnP58pFrBN/GCaj/5StwRGd0rKszCoCuDvhq7q7JI/rwvfcCdeoJApYbB
         RrLVDR1FdjRUkPKUYY4vdQXFMKJ+DyCEy1u3yaq0tLzzRr/q+W+Jpk2dTzCe0ZDnHI
         ZrgvG8PTC07JIb8qgwWuByL9OnamJVjCjzw1ZD722E8DYwsfeQcWrgV8xkkRqSRbd1
         ttLrZs/BvAqjg==
Message-ID: <b0aca760a1c804d68cd95357b8adcafef0e78b25.camel@collabora.com>
Subject: Re: [PATCH v2 09/12] staging: media: rkvdec: h264: Add callbacks
 for h264
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
Date:   Thu, 12 Jan 2023 16:58:58 -0500
In-Reply-To: <CAAEAJfDkTX=EwDCs+uN0bFwMb_JhJfkQiwRR9+b-9v3cJnPTsw@mail.gmail.com>
References: <20230101-patch-series-v2-6-2-rc1-v2-0-fa1897efac14@collabora.com>
         <20230101-patch-series-v2-6-2-rc1-v2-9-fa1897efac14@collabora.com>
         <CAAEAJfDkTX=EwDCs+uN0bFwMb_JhJfkQiwRR9+b-9v3cJnPTsw@mail.gmail.com>
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

Le jeudi 12 janvier 2023 =C3=A0 12:21 -0300, Ezequiel Garcia a =C3=A9crit=
=C2=A0:
> On Thu, Jan 12, 2023 at 9:56 AM Sebastian Fricke
> <sebastian.fricke@collabora.com> wrote:
> >=20
> > Implement the valid format and sps validation callbacks for H264.
> > H264 already has a SPS validation function, adjust it to fit the
> > function the declaration and add error messages.
> > Additionally, add a function to fetch attributes from the SPS in a huma=
n
> > readable format to make the code more self documenting.
> >=20
> > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > ---
> >  drivers/staging/media/rkvdec/rkvdec-h264.c | 105 +++++++++++++++++++++=
+-------
> >  1 file changed, 80 insertions(+), 25 deletions(-)
> >=20
> > diff --git a/drivers/staging/media/rkvdec/rkvdec-h264.c b/drivers/stagi=
ng/media/rkvdec/rkvdec-h264.c
> > index 4fc167b42cf0..17b215874ddd 100644
> > --- a/drivers/staging/media/rkvdec/rkvdec-h264.c
> > +++ b/drivers/staging/media/rkvdec/rkvdec-h264.c
> > @@ -1026,40 +1026,80 @@ static int rkvdec_h264_adjust_fmt(struct rkvdec=
_ctx *ctx,
> >         return 0;
> >  }
> >=20
> > -static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx,
> > -                                   const struct v4l2_ctrl_h264_sps *sp=
s)
> > +/*
> > + * Convert some fields from the SPS structure into human readable attr=
ibutes.
> > + */
> > +static int rkvdec_h264_get_sps_attributes(struct rkvdec_ctx *ctx, void=
 *sps,
> > +                                         struct sps_attributes *attrib=
utes)
> > +{
> > +       struct v4l2_ctrl_h264_sps *h264_sps =3D sps;
> > +       unsigned int width =3D (h264_sps->pic_width_in_mbs_minus1 + 1) =
* 16;
> > +       unsigned int height =3D (h264_sps->pic_height_in_map_units_minu=
s1 + 1) * 16;
> > +       /*
> > +        * When frame_mbs_only_flag is not set, this is field height,
> > +        * which is half the final height (see (7-18) in the
> > +        * specification)
> > +        */
> > +       if (!(h264_sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
> > +               height *=3D 2;
> > +
> > +       attributes->width =3D width;
> > +       attributes->height =3D height;
> > +       attributes->luma_bitdepth =3D h264_sps->bit_depth_luma_minus8 +=
 8;
> > +       attributes->chroma_bitdepth =3D h264_sps->bit_depth_chroma_minu=
s8 + 8;
> > +       switch (h264_sps->chroma_format_idc) {
> > +       case 0:
> > +               attributes->subsampling =3D 400;
> > +               break;
> > +       case 1:
> > +               attributes->subsampling =3D 420;
> > +               break;
> > +       case 2:
> > +               attributes->subsampling =3D 422;
> > +               break;
> > +       case 3:
> > +               attributes->subsampling =3D 444;
> > +               break;
> > +       };
> > +       return 0;
> > +}
> > +
> > +static int rkvdec_h264_validate_sps(struct rkvdec_ctx *ctx, void *sps,
> > +                                   struct v4l2_pix_format_mplane *pix_=
mp)
> >  {
> > -       unsigned int width, height;
> > +       struct sps_attributes attributes =3D {0};
> > +
> > +       rkvdec_h264_get_sps_attributes(ctx, sps, &attributes);
> >=20
> >         /*
> >          * TODO: The hardware supports 10-bit and 4:2:2 profiles,
> >          * but it's currently broken in the driver.
> >          * Reject them for now, until it's fixed.
> >          */
> > -       if (sps->chroma_format_idc > 1)
> > -               /* Only 4:0:0 and 4:2:0 are supported */
> > +       if (attributes.subsampling > 420) {
> > +               dev_err(ctx->dev->dev,
> > +                       "Only 4:0:0 and 4:2:0 subsampling schemes are s=
upported, got: %d\n",
> > +                       attributes.subsampling);
> >                 return -EINVAL;
> > -       if (sps->bit_depth_luma_minus8 !=3D sps->bit_depth_chroma_minus=
8)
> > -               /* Luma and chroma bit depth mismatch */
> > +       }
> > +       if (attributes.luma_bitdepth !=3D attributes.chroma_bitdepth) {
> > +               dev_err(ctx->dev->dev,
> > +                       "Luma and chroma bit depth mismatch, luma %d, c=
hroma %d\n",
> > +                       attributes.luma_bitdepth, attributes.chroma_bit=
depth);
> >                 return -EINVAL;
> > -       if (sps->bit_depth_luma_minus8 !=3D 0)
> > -               /* Only 8-bit is supported */
> > +       }
> > +       if (attributes.luma_bitdepth !=3D 8) {
> > +               dev_err(ctx->dev->dev, "Only 8-bit H264 formats support=
ed, SPS %d\n",
> > +                       attributes.luma_bitdepth);
> >                 return -EINVAL;
> > +       }
> >=20
> > -       width =3D (sps->pic_width_in_mbs_minus1 + 1) * 16;
> > -       height =3D (sps->pic_height_in_map_units_minus1 + 1) * 16;
> > -
> > -       /*
> > -        * When frame_mbs_only_flag is not set, this is field height,
> > -        * which is half the final height (see (7-18) in the
> > -        * specification)
> > -        */
> > -       if (!(sps->flags & V4L2_H264_SPS_FLAG_FRAME_MBS_ONLY))
> > -               height *=3D 2;
> > -
> > -       if (width > ctx->coded_fmt.fmt.pix_mp.width ||
> > -           height > ctx->coded_fmt.fmt.pix_mp.height)
> > +       if (attributes.width > pix_mp->width || attributes.height > pix=
_mp->height) {
> > +               dev_err(ctx->dev->dev,
> > +                       "Incompatible SPS dimension, SPS %dx%d, Pixel f=
ormat %dx%d.",
> > +                       attributes.width, attributes.height, pix_mp->wi=
dth, pix_mp->height);
> >                 return -EINVAL;
> > +       }
> >=20
> >         return 0;
> >  }
> > @@ -1077,8 +1117,9 @@ static int rkvdec_h264_start(struct rkvdec_ctx *c=
tx)
> >         if (!ctrl)
> >                 return -EINVAL;
> >=20
> > -       ret =3D rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps);
> > -       if (ret)
> > +       ret =3D rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264_sps,
> > +                                      &ctx->coded_fmt.fmt.pix_mp);
>=20
> Not a problem with this patch, but I wonder why we accepted a validation
> in the start_streaming step.

Its something we've been discussing a lot lately Benjamin / Sebastian an I =
(in
person, sorry for that, but sometimes we work better off chats). This is
something none of the reviewers/authors seems to have actually cared about =
so
far. In stateless decoders  we have FMT(OUTPUT) that contains the coded siz=
e,
S_CTRL(SOME_HEADERS) which is restricted by the size in FMT(OUTPUT)
(restrictions depends on the codec, could be =3D=3D, or smaller) but also u=
sed to
create and limit what FMT(CAPTURE) can be.

One thing that raised, is that the width/height alignment has been careless=
ly
applied to OUTPUT and CAPTURE, saved by the fact the real value is in SPS, =
but
possibly leading to strange bugs. Notably we notice that some coded sizes
rejected by S_FMT(OUTOUT) still lead to working streamon and decode :-S.

The other aspect is validation. The initial thinking was that we can valida=
te
the SPS (SOME_HEADERS) directly when the control is set. But we found a gap=
,
userspace could come back and change the coded size in FMT(OUTPUT) to miss-=
match
the header. We can't reject that, since FMT(OUTPUT) should just always work=
s,
its the first step according to the doc. The doc does not impose closing th=
e
device and restarting from scratch (even though this is what our userspace
currently though). So in short, if the SPS coded size no longer match the O=
UTPUT
reported coded size, we needed to reject streamon, hence the validation the=
re.
Of course, there was some more mistakes done, like trying to validate when
executing a job, but I think all of these got caught at review.

On of the reflection we have, is that to be more "semantically" aligned wit=
h
V4L2 control framework, we should instead of this ensure the the SPS is alw=
ays
valid. But this is a bit of work for a usecase that no one needs. In short,
S_FMT(OUTPUT) would always reset the SPS by creating one that is valid and
maches the coded size (when the bitstream header have that, the reason its
duplicated is that we wanted to support light coding format which does not =
carry
that information in the bitstream). The FMT(CAPTURE) would also be reset to
something valid according to both.

Then we'd validate the SPS control against the FMT(OUTPUT) when set, and al=
ways
reset the FMT(CAPTURE) accordingly. This way, no more validation would be
required at streamon, since we ensure everything stay valid by discarding p=
ast
settings. Such a method needs careful thought, and remember a bit of work, =
but
it would help prevent further broken logic, for those who haven't noticed,
Hantro G2 HEVC decoder will pick NV12_4L4 by default when you pass a 10bit =
SPS,
cause no one noticed until today ... But that's not what the spec is expect=
ing,
as its not a "native" format for the bitstream. What I like about this prop=
osal
is that it would remove any remaining possible side effect from a previous
session, trully allowing for reuse of codec instance, but again, this is
theoritical, as long as you can't crash the driver (which the current valid=
ation
is about), its not a real bug, most userspace will just set everything all =
the
time with these CODEC.

Ok, this is getting long, but I just want to keep in mind this is multiple =
years
of accumulated  mistakes (or just delaying known limitation in driver desig=
ns),
we should probably not block features completely over getting this right
immediately, as all it does it makes the actual suffer longer. Though, we s=
hould
encourage cross-driver fixes whenever something is improved in one driver.

>=20
> At this point, the driver accepted all the format negotiations in try_fmt=
.
> It's difficult for applications to recover from this, as there would
> be no way to tell what failed,
> we would be returning EINVAL, which as per the spec is "buffer type is
> not supported,
> or no buffers have been allocated (memory mapping) or enqueued (output) y=
et.".
>=20
> I think it would really make a lot of sense to fix this now, instead of c=
ontinue
> abusing it. And also, I'd like to prevent a possible anti-pattern from
> spreading.
>=20
> Thanks!
> Ezequiel
>=20
> > +       if (ret < 0)
> >                 return ret;
> >=20
> >         h264_ctx =3D kzalloc(sizeof(*h264_ctx), GFP_KERNEL);
> > @@ -1175,10 +1216,21 @@ static int rkvdec_h264_run(struct rkvdec_ctx *c=
tx)
> >         return 0;
> >  }
> >=20
> > +static u32 rkvdec_h264_valid_fmt(struct rkvdec_ctx *ctx)
> > +{
> > +       /*
> > +        * Only 8 bit 4:0:0 and 4:2:0 formats supported for now.
> > +        * The SPS is validated at a different function thus we can ass=
ume that
> > +        * it is correct.
> > +        */
> > +       return V4L2_PIX_FMT_NV12;
> > +}
> > +
> >  static int rkvdec_h264_try_ctrl(struct rkvdec_ctx *ctx, struct v4l2_ct=
rl *ctrl)
> >  {
> >         if (ctrl->id =3D=3D V4L2_CID_STATELESS_H264_SPS)
> > -               return rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264=
_sps);
> > +               return rkvdec_h264_validate_sps(ctx, ctrl->p_new.p_h264=
_sps,
> > +                                               &ctx->coded_fmt.fmt.pix=
_mp);
> >=20
> >         return 0;
> >  }
> > @@ -1189,4 +1241,7 @@ const struct rkvdec_coded_fmt_ops rkvdec_h264_fmt=
_ops =3D {
> >         .stop =3D rkvdec_h264_stop,
> >         .run =3D rkvdec_h264_run,
> >         .try_ctrl =3D rkvdec_h264_try_ctrl,
> > +       .valid_fmt =3D rkvdec_h264_valid_fmt,
> > +       .sps_check =3D rkvdec_h264_validate_sps,
> > +       .get_sps_attributes =3D rkvdec_h264_get_sps_attributes,
> >  };
> >=20
> > --
> > 2.25.1

