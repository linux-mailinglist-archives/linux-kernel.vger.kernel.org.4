Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87BF69D3E3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 20:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjBTTKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 14:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjBTTKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 14:10:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC265B80;
        Mon, 20 Feb 2023 11:10:04 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net [192.222.136.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EEF336602122;
        Mon, 20 Feb 2023 19:00:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676919642;
        bh=9KbPu9ClBtXXtJ67tRgMCXKSz44W/ZY6hNUVAXZP8LY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PMDkvc3TkIEoLNDHPdF2zuahmykU2BBwE/6uXHc1qodP5KvpXD5gRInJdvRrhBPFb
         YlSKlaAufRMcoV8oWqQgUJrjJrHzYGce4VEKNJBEqTTatZ3TggR3ObafiZHDtc2XHc
         Zf3gYkg7PpZoYDT5Jv92lEcoZ9RN7/cu9SCPCuQhyQFJL1QDlwSyVCTV+G+0waY3OA
         voYGrouYUg/RpGWjmu+clt6b5rpsvUpz+1vl8spC6LSABacR7PIedxFgfajDEsUku3
         joaHujiLGkrKqUHU8PYt8Ap+F7/6imz63vSwK7DHKXTv6HGdzYjwYyPdb4QInVUfu3
         XRHa1c6S0ly0A==
Message-ID: <6997fe5cbcfef626340ce4d85095eadb7bc63067.camel@collabora.com>
Subject: Re: [PATCH v4 06/12] media: verisilicon: Check AV1 bitstreams bit
 depth
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, heiko@sntech.de,
        hverkuil@xs4all.nl, jernej.skrabec@gmail.com,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Date:   Mon, 20 Feb 2023 14:00:32 -0500
In-Reply-To: <c4d355d5-5e14-8eba-1944-fc26b1050cf5@collabora.com>
References: <20230214140557.537984-1-benjamin.gaignard@collabora.com>
         <20230214140557.537984-7-benjamin.gaignard@collabora.com>
         <CAAEAJfDihZND+1FSzFxT86j9u6h-wH6uMMNh7BiaEWQWtSpk=Q@mail.gmail.com>
         <c4d355d5-5e14-8eba-1944-fc26b1050cf5@collabora.com>
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

Le lundi 20 f=C3=A9vrier 2023 =C3=A0 17:24 +0100, Benjamin Gaignard a =C3=
=A9crit=C2=A0:
> Le 18/02/2023 =C3=A0 14:11, Ezequiel Garcia a =C3=A9crit=C2=A0:
> > On Tue, Feb 14, 2023 at 11:06 AM Benjamin Gaignard
> > <benjamin.gaignard@collabora.com> wrote:
> > > The driver supports 8 and 10 bits bitstreams, make sure to discard
> > > other cases.
> > > It could happens that userland test if V4L2_CID_STATELESS_AV1_SEQUENC=
E
> > > exists without setting bit_depth field in this case use
> > > HANTRO_DEFAULT_BIT_DEPTH value.
> > >=20
> > This shouldn't happen.
> >=20
> > If the bit_depth argument in hantro_check_depth_match()
> > can be set unchecked by userspace, we have done something wrong!!
> >=20
> > Are you sure that userspace can do a S_CTRL with an invalid bit-depth?
> > The try_or_set_cluster() function seems to always call try_ctrl before =
s_ctrl.
>=20
> I have dump the stack when AV1 sequence bit depth =3D 0 in s_ctrl.
> It is happening when opening the driver, v4l2 setup the ctrls by calling =
__v4l2_ctrl_handler_setup()
> this led to call hantro_av1_s_ctrl() with empty structure.
>=20
> For other codecs isn't a problem because bit depth is coded with a minus =
8 value (ie: 8 bits =3D 0)
> while for AV1 it is the real value (ie: 8 bits =3D 8).

Shouldn't this be fixed in v4l2-ctrls-core.c / std_init_compound() ? This i=
s
what we do for VP9:


	case V4L2_CTRL_TYPE_VP9_FRAME:
		p_vp9_frame =3D p;
		p_vp9_frame->profile =3D 0;
		p_vp9_frame->bit_depth =3D 8;
		p_vp9_frame->flags |=3D V4L2_VP9_FRAME_FLAG_X_SUBSAMPLING |
			V4L2_VP9_FRAME_FLAG_Y_SUBSAMPLING;
		break;


>=20
> [   88.478751] Hardware name: Radxa Rock 5A Board (DT)
> [   88.479184] Call trace:
> [   88.479406]  dump_backtrace.part.0+0xdc/0xf0
> [   88.479796]  show_stack+0x18/0x30
> [   88.480099]  dump_stack_lvl+0x68/0x84
> [   88.480431]  dump_stack+0x18/0x34
> [   88.480732]  hantro_av1_s_ctrl+0x7c/0xcc [hantro_vpu]
> [   88.481211]  __v4l2_ctrl_handler_setup+0x120/0x154
> [   88.481643]  v4l2_ctrl_handler_setup+0x2c/0x50
> [   88.482043]  hantro_open+0x138/0x204 [hantro_vpu]
> [   88.482490]  v4l2_open+0xa8/0x124
> [   88.482794]  chrdev_open+0xc0/0x22c
> [   88.483114]  do_dentry_open+0x13c/0x490
> [   88.483464]  vfs_open+0x2c/0x40
> [   88.483749]  path_openat+0x878/0xe50
> [   88.484074]  do_filp_open+0x80/0x130
> [   88.484399]  do_sys_openat2+0xb4/0x170
> [   88.484736]  __arm64_sys_openat+0x60/0xb0
> [   88.485097]  invoke_syscall+0x48/0x114
> [   88.485437]  el0_svc_common.constprop.0+0x44/0xfc
> [   88.485860]  do_el0_svc+0x3c/0xc0
> [   88.486163]  el0_svc+0x2c/0x84
> [   88.486441]  el0t_64_sync_handler+0xbc/0x140
> [   88.486826]  el0t_64_sync+0x190/0x194
>=20
> Regards,
> Benjamin
>=20
> >=20
> > Thanks,
> > Ezequiel
> >=20
> > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > > ---
> > > version 4:
> > > - This patch is the result of squashing "Save bit depth for AV1 decod=
er"
> > >    and "Check AV1 bitstreams bit depth" of version 3 + adapation to
> > >    "[PATCH v8 0/6] media: verisilicon: HEVC: fix 10bits handling" ser=
ies.
> > >=20
> > >   .../media/platform/verisilicon/hantro_drv.c   | 36 ++++++++++++++++=
+++
> > >   .../media/platform/verisilicon/hantro_v4l2.c  |  4 +++
> > >   2 files changed, 40 insertions(+)
> > >=20
> > > diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/driver=
s/media/platform/verisilicon/hantro_drv.c
> > > index bc1a85456142..666cd46902da 100644
> > > --- a/drivers/media/platform/verisilicon/hantro_drv.c
> > > +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> > > @@ -275,7 +275,13 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctr=
l)
> > >                  /* We only support profile 0 */
> > >                  if (dec_params->profile !=3D 0)
> > >                          return -EINVAL;
> > > +       } else if (ctrl->id =3D=3D V4L2_CID_STATELESS_AV1_SEQUENCE) {
> > > +               const struct v4l2_ctrl_av1_sequence *sequence =3D ctr=
l->p_new.p_av1_sequence;
> > > +
> > > +               if (sequence->bit_depth !=3D 8 && sequence->bit_depth=
 !=3D 10)
> > > +                       return -EINVAL;
> > >          }
> > > +
> > >          return 0;
> > >   }
> > >=20
> > > @@ -348,6 +354,30 @@ static int hantro_hevc_s_ctrl(struct v4l2_ctrl *=
ctrl)
> > >          return 0;
> > >   }
> > >=20
> > > +static int hantro_av1_s_ctrl(struct v4l2_ctrl *ctrl)
> > > +{
> > > +       struct hantro_ctx *ctx;
> > > +
> > > +       ctx =3D container_of(ctrl->handler,
> > > +                          struct hantro_ctx, ctrl_handler);
> > > +
> > > +       switch (ctrl->id) {
> > > +       case V4L2_CID_STATELESS_AV1_SEQUENCE:
> > > +       {
> > > +               int bit_depth =3D ctrl->p_new.p_av1_sequence->bit_dep=
th;
> > > +
> > > +               if (ctx->bit_depth =3D=3D bit_depth)
> > > +                       return 0;
> > > +
> > > +               return hantro_reset_raw_fmt(ctx, bit_depth);
> > > +       }
> > > +       default:
> > > +               return -EINVAL;
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > >   static const struct v4l2_ctrl_ops hantro_ctrl_ops =3D {
> > >          .try_ctrl =3D hantro_try_ctrl,
> > >   };
> > > @@ -365,6 +395,11 @@ static const struct v4l2_ctrl_ops hantro_hevc_ct=
rl_ops =3D {
> > >          .s_ctrl =3D hantro_hevc_s_ctrl,
> > >   };
> > >=20
> > > +static const struct v4l2_ctrl_ops hantro_av1_ctrl_ops =3D {
> > > +       .try_ctrl =3D hantro_try_ctrl,
> > > +       .s_ctrl =3D hantro_av1_s_ctrl,
> > > +};
> > > +
> > >   #define HANTRO_JPEG_ACTIVE_MARKERS     (V4L2_JPEG_ACTIVE_MARKER_APP=
0 | \
> > >                                           V4L2_JPEG_ACTIVE_MARKER_COM=
 | \
> > >                                           V4L2_JPEG_ACTIVE_MARKER_DQT=
 | \
> > > @@ -542,6 +577,7 @@ static const struct hantro_ctrl controls[] =3D {
> > >                  .codec =3D HANTRO_AV1_DECODER,
> > >                  .cfg =3D {
> > >                          .id =3D V4L2_CID_STATELESS_AV1_SEQUENCE,
> > > +                       .ops =3D &hantro_av1_ctrl_ops,
> > >                  },
> > >          }, {
> > >                  .codec =3D HANTRO_AV1_DECODER,
> > > diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drive=
rs/media/platform/verisilicon/hantro_v4l2.c
> > > index 992c5baa929f..7e74e47c9a89 100644
> > > --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
> > > @@ -86,6 +86,10 @@ hantro_check_depth_match(const struct hantro_fmt *=
fmt, int bit_depth)
> > >          if (!fmt->match_depth && !fmt->postprocessed)
> > >                  return true;
> > >=20
> > > +       /* 0 means default depth, which is 8 */
> > > +       if (!bit_depth)
> > > +               bit_depth =3D HANTRO_DEFAULT_BIT_DEPTH;
> > > +
> > >          fmt_depth =3D hantro_get_format_depth(fmt->fourcc);
> > >=20
> > >          /*
> > > --
> > > 2.34.1
> > >=20

