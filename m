Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F686EF570
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 15:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241168AbjDZNWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 09:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240655AbjDZNWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 09:22:43 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F40C26AC;
        Wed, 26 Apr 2023 06:22:37 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:199e::580])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16058660324E;
        Wed, 26 Apr 2023 14:22:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1682515355;
        bh=LYw47Dbwfdx3acXpftGtZjbJu+9LHOYzTp5nWowe5MA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HsiPGzeH6C7IzKqUwCn8MiO9c0kUFRnf5gYdDeoryr7LeDDBeiB5qDBnn10vWR0Rg
         3G80WzwVRXSLCcz8Hif9vghzx+y/l0DYeDTUdb3nfOroPxMT9lchTM9pijs0CKOGog
         CT09BN9JJsVU2CRt9gjPs49ORg6OuYV42kSN3D67i10S55HM0P7cH3NxlvLPoGcqzf
         VhFQi8kPTE3OhRNN/KyhdAvEdDk6zSM0KFCE+3vMuP6gnfl3xrHBYZwcljNSNQdNIW
         CD2AOrSthtRujK/4Vvm9ZEEOEo/o0d0Ub4wxjKR+FquY9LfOaaurgP8JuV7Zd2HrmS
         DcVc92ZuE+v7Q==
Message-ID: <45ae879edfcf1cc09474e865ff07d4fdd92b9477.camel@collabora.com>
Subject: Re: [PATCH v11 3/6] media: chips-media: wave5: Add the v4l2 layer
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Robert Beckett <bob.beckett@collabora.com>
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org
Date:   Wed, 26 Apr 2023 09:22:26 -0400
In-Reply-To: <ba00ab71-3e5c-b471-c6e2-a01073788389@xs4all.nl>
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
         <20221207121350.66217-4-sebastian.fricke@collabora.com>
         <ba00ab71-3e5c-b471-c6e2-a01073788389@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0 (3.48.0-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian, Hans,

Le lundi 12 d=C3=A9cembre 2022 =C3=A0 15:19 +0100, Hans Verkuil a =C3=A9cri=
t=C2=A0:
> Hi Sebastian,
>=20
> Some review comments below.
>=20
> FYI: if you can post a v12 by Thursday, then I'll run that through my dai=
ly build
> setup to check for smatch, sparse, etc. issues.
>=20
> The next three weeks I'm on vacation, so it will be on hold until I'm bac=
k.
>=20
> Regards,
>=20
> 	Hans
>=20
> On 07/12/2022 13:13, Sebastian Fricke wrote:
> > From: Nas Chung <nas.chung@chipsnmedia.com>
> >=20
> > Add the decoder and encoder implementing the v4l2
> > API. This patch also adds the Makefile and the VIDEO_WAVE_VPU config
> >=20
> > Signed-off-by: Robert Beckett <bob.beckett@collabora.com>
> > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> > ---
> >  drivers/media/platform/chips-media/Kconfig    |    1 +
> >  drivers/media/platform/chips-media/Makefile   |    1 +
> >  .../media/platform/chips-media/wave5/Kconfig  |   12 +
> >  .../media/platform/chips-media/wave5/Makefile |   10 +
> >  .../platform/chips-media/wave5/wave5-helper.c |  175 ++
> >  .../platform/chips-media/wave5/wave5-helper.h |   28 +
> >  .../chips-media/wave5/wave5-vpu-dec.c         | 1429 ++++++++++++++
> >  .../chips-media/wave5/wave5-vpu-enc.c         | 1746 +++++++++++++++++
> >  .../platform/chips-media/wave5/wave5-vpu.c    |  362 ++++
> >  .../platform/chips-media/wave5/wave5-vpu.h    |   72 +
> >  10 files changed, 3836 insertions(+)
> >  create mode 100644 drivers/media/platform/chips-media/wave5/Kconfig
> >  create mode 100644 drivers/media/platform/chips-media/wave5/Makefile
> >  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-help=
er.c
> >  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-help=
er.h
> >  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-=
dec.c
> >  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu-=
enc.c
> >  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.=
c
> >  create mode 100644 drivers/media/platform/chips-media/wave5/wave5-vpu.=
h
> >=20
>=20
> <snip>
>=20
> > +static int wave5_vpu_dec_querycap(struct file *file, void *fh, struct =
v4l2_capability *cap)
> > +{
> > +	strscpy(cap->driver, VPU_DEC_DRV_NAME, sizeof(cap->driver));
> > +	strscpy(cap->card, VPU_DEC_DRV_NAME, sizeof(cap->card));
> > +	strscpy(cap->bus_info, "platform:" VPU_DEC_DRV_NAME, sizeof(cap->bus_=
info));
>=20
> No need to set bus_info, the core will fill this in for you these days (a=
t least
> for platform and PCI(e) devices).
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_enum_framesizes(struct file *f, void *fh, str=
uct v4l2_frmsizeenum *fsize)
> > +{
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	if (fsize->index)
> > +		return -EINVAL;
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt(fsize->pixel_format, dec_fmt_list[VPU_=
FMT_TYPE_CODEC]);
> > +	if (!vpu_fmt) {
> > +		vpu_fmt =3D wave5_find_vpu_fmt(fsize->pixel_format, dec_fmt_list[VPU=
_FMT_TYPE_RAW]);
> > +		if (!vpu_fmt)
> > +			return -EINVAL;
> > +	}
> > +
> > +	fsize->type =3D V4L2_FRMSIZE_TYPE_CONTINUOUS;
> > +	fsize->stepwise.min_width =3D vpu_fmt->min_width;
> > +	fsize->stepwise.max_width =3D vpu_fmt->max_width;
> > +	fsize->stepwise.step_width =3D 1;
> > +	fsize->stepwise.min_height =3D vpu_fmt->min_height;
> > +	fsize->stepwise.max_height =3D vpu_fmt->max_height;
> > +	fsize->stepwise.step_height =3D 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_enum_fmt_cap(struct file *file, void *fh, str=
uct v4l2_fmtdesc *f)
> > +{
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt_by_idx(f->index, dec_fmt_list[VPU_FMT_=
TYPE_RAW]);
> > +	if (!vpu_fmt)
> > +		return -EINVAL;
> > +
> > +	f->pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> > +	f->flags =3D 0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_try_fmt_cap(struct file *file, void *fh, stru=
ct v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	dev_dbg(inst->dev->dev,
> > +		"%s: fourcc: %u width: %u height: %u nm planes: %u colorspace: %u fi=
eld: %u\n",
> > +		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix=
_mp.height,
> > +		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.fi=
eld);
> > +
> > +	if (f->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +		return -EINVAL;
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, dec_fmt_lis=
t[VPU_FMT_TYPE_RAW]);
> > +	if (!vpu_fmt) {
> > +		f->fmt.pix_mp.pixelformat =3D inst->dst_fmt.pixelformat;
> > +		f->fmt.pix_mp.num_planes =3D inst->dst_fmt.num_planes;
> > +		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->dst_fmt.width, inst->dst_=
fmt.height);
> > +	} else {
> > +		int width =3D clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt=
->max_width);
> > +		int height =3D clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_=
fmt->max_height);
> > +		const struct v4l2_format_info *info =3D v4l2_format_info(vpu_fmt->v4=
l2_pix_fmt);
> > +
> > +		f->fmt.pix_mp.pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> > +		f->fmt.pix_mp.num_planes =3D info->mem_planes;
> > +		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
> > +	}
> > +
> > +	f->fmt.pix_mp.flags =3D 0;
> > +	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> > +	f->fmt.pix_mp.colorspace =3D inst->colorspace;
> > +	f->fmt.pix_mp.ycbcr_enc =3D inst->ycbcr_enc;
> > +	f->fmt.pix_mp.hsv_enc =3D inst->hsv_enc;
> > +	f->fmt.pix_mp.quantization =3D inst->quantization;
> > +	f->fmt.pix_mp.xfer_func =3D inst->xfer_func;
> > +	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_s_fmt_cap(struct file *file, void *fh, struct=
 v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	int i, ret;
> > +
> > +	dev_dbg(inst->dev->dev,
> > +		"%s: fourcc: %u width: %u height: %u num_planes: %u colorspace: %u f=
ield: %u\n",
> > +		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix=
_mp.height,
> > +		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.fi=
eld);
> > +
> > +	ret =3D wave5_vpu_dec_try_fmt_cap(file, fh, f);
> > +	if (ret)
> > +		return ret;
> > +
> > +	inst->dst_fmt.width =3D f->fmt.pix_mp.width;
> > +	inst->dst_fmt.height =3D f->fmt.pix_mp.height;
> > +	inst->dst_fmt.pixelformat =3D f->fmt.pix_mp.pixelformat;
> > +	inst->dst_fmt.field =3D f->fmt.pix_mp.field;
> > +	inst->dst_fmt.flags =3D f->fmt.pix_mp.flags;
> > +	inst->dst_fmt.num_planes =3D f->fmt.pix_mp.num_planes;
> > +	for (i =3D 0; i < inst->dst_fmt.num_planes; i++) {
> > +		inst->dst_fmt.plane_fmt[i].bytesperline =3D f->fmt.pix_mp.plane_fmt[=
i].bytesperline;
> > +		inst->dst_fmt.plane_fmt[i].sizeimage =3D f->fmt.pix_mp.plane_fmt[i].=
sizeimage;
> > +	}
> > +
> > +	if (inst->dst_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12 ||
> > +	    inst->dst_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12M) {
> > +		inst->cbcr_interleave =3D true;
> > +		inst->nv21 =3D false;
> > +	} else if (inst->dst_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21 ||
> > +		   inst->dst_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21M) {
> > +		inst->cbcr_interleave =3D true;
> > +		inst->nv21 =3D true;
> > +	} else {
> > +		inst->cbcr_interleave =3D false;
> > +		inst->nv21 =3D false;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_g_fmt_cap(struct file *file, void *fh, struct=
 v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	int i;
> > +
> > +	f->fmt.pix_mp.width =3D inst->dst_fmt.width;
> > +	f->fmt.pix_mp.height =3D inst->dst_fmt.height;
> > +	f->fmt.pix_mp.pixelformat =3D inst->dst_fmt.pixelformat;
> > +	f->fmt.pix_mp.field =3D inst->dst_fmt.field;
> > +	f->fmt.pix_mp.flags =3D inst->dst_fmt.flags;
> > +	f->fmt.pix_mp.num_planes =3D inst->dst_fmt.num_planes;
> > +	for (i =3D 0; i < f->fmt.pix_mp.num_planes; i++) {
> > +		f->fmt.pix_mp.plane_fmt[i].bytesperline =3D inst->dst_fmt.plane_fmt[=
i].bytesperline;
> > +		f->fmt.pix_mp.plane_fmt[i].sizeimage =3D inst->dst_fmt.plane_fmt[i].=
sizeimage;
> > +	}
> > +
> > +	f->fmt.pix_mp.colorspace =3D inst->colorspace;
> > +	f->fmt.pix_mp.ycbcr_enc =3D inst->ycbcr_enc;
> > +	f->fmt.pix_mp.hsv_enc =3D inst->hsv_enc;
> > +	f->fmt.pix_mp.quantization =3D inst->quantization;
> > +	f->fmt.pix_mp.xfer_func =3D inst->xfer_func;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_enum_fmt_out(struct file *file, void *fh, str=
uct v4l2_fmtdesc *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: index: %u\n", __func__, f->index);
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt_by_idx(f->index, dec_fmt_list[VPU_FMT_=
TYPE_CODEC]);
> > +	if (!vpu_fmt)
> > +		return -EINVAL;
> > +
> > +	f->pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> > +	f->flags =3D 0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_try_fmt_out(struct file *file, void *fh, stru=
ct v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	dev_dbg(inst->dev->dev,
> > +		"%s: fourcc: %u width: %u height: %u num_planes: %u colorspace: %u f=
ield: %u\n",
> > +		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix=
_mp.height,
> > +		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.colorspace, f->fmt.pix_mp.fi=
eld);
> > +
> > +	if (f->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +		return -EINVAL;
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, dec_fmt_lis=
t[VPU_FMT_TYPE_CODEC]);
> > +	if (!vpu_fmt) {
> > +		f->fmt.pix_mp.pixelformat =3D inst->src_fmt.pixelformat;
> > +		f->fmt.pix_mp.num_planes =3D inst->src_fmt.num_planes;
> > +		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_=
fmt.height);
> > +	} else {
> > +		int width =3D clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt=
->max_width);
> > +		int height =3D clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_=
fmt->max_height);
> > +
> > +		f->fmt.pix_mp.pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> > +		f->fmt.pix_mp.num_planes =3D 1;
> > +		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
> > +	}
> > +
> > +	f->fmt.pix_mp.flags =3D 0;
> > +	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> > +	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_s_fmt_out(struct file *file, void *fh, struct=
 v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	int i, ret;
> > +
> > +	dev_dbg(inst->dev->dev,
> > +		"%s: fourcc: %u width: %u height: %u num_planes: %u field: %u\n",
> > +		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix=
_mp.height,
> > +		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
> > +
> > +	ret =3D wave5_vpu_dec_try_fmt_out(file, fh, f);
> > +	if (ret)
> > +		return ret;
> > +
> > +	inst->src_fmt.width =3D f->fmt.pix_mp.width;
> > +	inst->src_fmt.height =3D f->fmt.pix_mp.height;
> > +	inst->src_fmt.pixelformat =3D f->fmt.pix_mp.pixelformat;
> > +	inst->src_fmt.field =3D f->fmt.pix_mp.field;
> > +	inst->src_fmt.flags =3D f->fmt.pix_mp.flags;
> > +	inst->src_fmt.num_planes =3D f->fmt.pix_mp.num_planes;
> > +	for (i =3D 0; i < inst->src_fmt.num_planes; i++) {
> > +		inst->src_fmt.plane_fmt[i].bytesperline =3D f->fmt.pix_mp.plane_fmt[=
i].bytesperline;
> > +		inst->src_fmt.plane_fmt[i].sizeimage =3D f->fmt.pix_mp.plane_fmt[i].=
sizeimage;
> > +	}
> > +
> > +	inst->colorspace =3D f->fmt.pix_mp.colorspace;
> > +	inst->ycbcr_enc =3D f->fmt.pix_mp.ycbcr_enc;
> > +	inst->hsv_enc =3D f->fmt.pix_mp.hsv_enc;
> > +	inst->quantization =3D f->fmt.pix_mp.quantization;
> > +	inst->xfer_func =3D f->fmt.pix_mp.xfer_func;
> > +
> > +	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_=
mp.height);
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_g_selection(struct file *file, void *fh, stru=
ct v4l2_selection *s)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %u | target: %u\n", __func__, s->t=
ype, s->target);
> > +
> > +	if (s->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
> > +		return -EINVAL;
> > +	switch (s->target) {
> > +	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> > +	case V4L2_SEL_TGT_COMPOSE_PADDED:
> > +		s->r.left =3D 0;
> > +		s->r.top =3D 0;
> > +		s->r.width =3D inst->dst_fmt.width;
> > +		s->r.height =3D inst->dst_fmt.height;
> > +		break;
> > +	case V4L2_SEL_TGT_COMPOSE:
> > +	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> > +		s->r.left =3D 0;
> > +		s->r.top =3D 0;
> > +		if (inst->state > VPU_INST_STATE_OPEN) {
> > +			s->r.width =3D inst->conf_win_width;
> > +			s->r.height =3D inst->conf_win_height;
> > +		} else {
> > +			s->r.width =3D inst->src_fmt.width;
> > +			s->r.height =3D inst->src_fmt.height;
> > +		}
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_s_selection(struct file *file, void *fh, stru=
ct v4l2_selection *s)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +
> > +	if (s->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE)
> > +		return -EINVAL;
> > +
> > +	if (s->target !=3D V4L2_SEL_TGT_COMPOSE)
> > +		return -EINVAL;
> > +
> > +	dev_dbg(inst->dev->dev, "V4L2_SEL_TGT_COMPOSE w: %u h: %u\n",
> > +		s->r.width, s->r.height);
> > +
> > +	s->r.left =3D 0;
> > +	s->r.top =3D 0;
> > +	s->r.width =3D inst->dst_fmt.width;
> > +	s->r.height =3D inst->dst_fmt.height;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_dec_decoder_cmd(struct file *file, void *fh, stru=
ct v4l2_decoder_cmd *dc)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	int ret;
> > +
> > +	dev_dbg(inst->dev->dev, "decoder command: %u\n", dc->cmd);
> > +
> > +	ret =3D v4l2_m2m_ioctl_try_decoder_cmd(file, fh, dc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!wave5_vpu_both_queues_are_streaming(inst))
> > +		return 0;
> > +
> > +	switch (dc->cmd) {
> > +	case V4L2_DEC_CMD_STOP:
> > +		inst->state =3D VPU_INST_STATE_STOP;
> > +
> > +		ret =3D wave5_vpu_dec_update_bitstream_buffer(inst, 0);
> > +		if (ret) {
> > +			dev_err(inst->dev->dev,
> > +				"Setting EOS for the bitstream, fail: %d\n", ret);
> > +			return ret;
> > +		}
> > +		break;
> > +	case V4L2_DEC_CMD_START:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct v4l2_ioctl_ops wave5_vpu_dec_ioctl_ops =3D {
> > +	.vidioc_querycap =3D wave5_vpu_dec_querycap,
> > +	.vidioc_enum_framesizes =3D wave5_vpu_dec_enum_framesizes,
> > +
> > +	.vidioc_enum_fmt_vid_cap	=3D wave5_vpu_dec_enum_fmt_cap,
> > +	.vidioc_s_fmt_vid_cap_mplane =3D wave5_vpu_dec_s_fmt_cap,
> > +	.vidioc_g_fmt_vid_cap_mplane =3D wave5_vpu_dec_g_fmt_cap,
> > +	.vidioc_try_fmt_vid_cap_mplane =3D wave5_vpu_dec_try_fmt_cap,
> > +
> > +	.vidioc_enum_fmt_vid_out	=3D wave5_vpu_dec_enum_fmt_out,
> > +	.vidioc_s_fmt_vid_out_mplane =3D wave5_vpu_dec_s_fmt_out,
> > +	.vidioc_g_fmt_vid_out_mplane =3D wave5_vpu_g_fmt_out,
> > +	.vidioc_try_fmt_vid_out_mplane =3D wave5_vpu_dec_try_fmt_out,
> > +
> > +	.vidioc_g_selection =3D wave5_vpu_dec_g_selection,
> > +	.vidioc_s_selection =3D wave5_vpu_dec_s_selection,
> > +
> > +	.vidioc_reqbufs =3D v4l2_m2m_ioctl_reqbufs,
> > +	.vidioc_querybuf =3D v4l2_m2m_ioctl_querybuf,
> > +	.vidioc_create_bufs =3D v4l2_m2m_ioctl_create_bufs,
> > +	.vidioc_prepare_buf =3D v4l2_m2m_ioctl_prepare_buf,
> > +	.vidioc_qbuf =3D v4l2_m2m_ioctl_qbuf,
> > +	.vidioc_expbuf =3D v4l2_m2m_ioctl_expbuf,
> > +	.vidioc_dqbuf =3D v4l2_m2m_ioctl_dqbuf,
> > +	.vidioc_streamon =3D v4l2_m2m_ioctl_streamon,
> > +	.vidioc_streamoff =3D v4l2_m2m_ioctl_streamoff,
> > +
> > +	.vidioc_try_decoder_cmd =3D v4l2_m2m_ioctl_try_decoder_cmd,
> > +	.vidioc_decoder_cmd =3D wave5_vpu_dec_decoder_cmd,
> > +
> > +	.vidioc_subscribe_event =3D wave5_vpu_subscribe_event,
> > +	.vidioc_unsubscribe_event =3D v4l2_event_unsubscribe,
> > +};
> > +
> > +static int wave5_vpu_dec_s_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +	struct vpu_instance *inst =3D wave5_ctrl_to_vpu_inst(ctrl);
> > +
> > +	dev_dbg(inst->dev->dev, "%s: name: %s | value: %d\n",
> > +		__func__, ctrl->name, ctrl->val);
> > +
> > +	switch (ctrl->id) {
> > +	case V4L2_CID_VPU_THUMBNAIL_MODE:
> > +		inst->thumbnail_mode =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MIN_BUFFERS_FOR_CAPTURE:
> > +		break;
>=20
> This case can be dropped: this control is a read-only control, so it can =
never
> be set and this op will never be called.
>=20
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct v4l2_ctrl_ops wave5_vpu_dec_ctrl_ops =3D {
> > +	.s_ctrl =3D wave5_vpu_dec_s_ctrl,
> > +};
> > +
> > +static const struct v4l2_ctrl_config wave5_vpu_thumbnail_mode =3D {
> > +	.ops =3D &wave5_vpu_dec_ctrl_ops,
> > +	.id =3D V4L2_CID_VPU_THUMBNAIL_MODE,
> > +	.name =3D "thumbnail mode",
>=20
> Capitalize: "Thumbnail Mode".
>=20
> It's not documented, so that needs to be added. Document it either in
> Documentation/userspace-api/media/drivers or in a public header where
> this control is defined (see e.g. include/uapi/linux/aspeed-video.h).
>=20
> Also, it's defined as:
>=20
> #define V4L2_CID_VPU_THUMBNAIL_MODE (V4L2_CID_USER_BASE + 0x1001)
>=20
> But you need to reserve a range of controls for this driver in
> include/uapi/linux/v4l2-controls.h (see e.g. V4L2_CID_USER_ASPEED_BASE).
>=20
> > +	.type =3D V4L2_CTRL_TYPE_BOOLEAN,
> > +	.def =3D 0,
> > +	.min =3D 0,
> > +	.max =3D 1,
> > +	.step =3D 1,
> > +	.flags =3D V4L2_CTRL_FLAG_WRITE_ONLY,
>=20
> Why is this WRITE_ONLY? That's weird.
>=20
> > +};
> > +
> > +static void wave5_set_default_dec_openparam(struct dec_open_param *ope=
n_param)
> > +{
> > +	open_param->bitstream_mode =3D BS_MODE_INTERRUPT;
> > +	open_param->stream_endian =3D VPU_STREAM_ENDIAN;
> > +	open_param->frame_endian =3D VPU_FRAME_ENDIAN;
> > +}
> > +
> > +static int wave5_vpu_dec_queue_setup(struct vb2_queue *q, unsigned int=
 *num_buffers,
> > +				     unsigned int *num_planes, unsigned int sizes[],
> > +				     struct device *alloc_devs[])
> > +{
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
> > +	struct v4l2_pix_format_mplane inst_format =3D
> > +		(q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt :=
 inst->dst_fmt;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type:=
 %u\n", __func__,
> > +		*num_buffers, *num_planes, q->type);
> > +
> > +	if (*num_planes) {
> > +		if (inst_format.num_planes !=3D *num_planes)
> > +			return -EINVAL;
> > +
> > +		for (i =3D 0; i < *num_planes; i++) {
> > +			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
> > +				return -EINVAL;
> > +		}
> > +	} else {
> > +		*num_planes =3D inst_format.num_planes;
> > +
> > +		if (*num_planes =3D=3D 1) {
> > +			sizes[0] =3D inst_format.width * inst_format.height * 3 / 2;
> > +			if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +				sizes[0] =3D inst_format.plane_fmt[0].sizeimage;
> > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u\n", __func__, sizes[0]);
> > +		} else if (*num_planes =3D=3D 2) {
> > +			sizes[0] =3D inst_format.width * inst_format.height;
> > +			sizes[1] =3D inst_format.width * inst_format.height / 2;
> > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u\n",
> > +				__func__, sizes[0], sizes[1]);
> > +		} else if (*num_planes =3D=3D 3) {
> > +			sizes[0] =3D inst_format.width * inst_format.height;
> > +			sizes[1] =3D inst_format.width * inst_format.height / 4;
> > +			sizes[2] =3D inst_format.width * inst_format.height / 4;
> > +			dev_dbg(inst->dev->dev, "%s: size[0]: %u | size[1]: %u | size[2]: %=
u\n",
> > +				__func__, sizes[0], sizes[1], sizes[2]);
> > +		}
> > +	}
> > +
>=20
> So what happens below if you call REQBUFS followed by CREATE_BUFS some ti=
me later?
> I'm not sure if this is all correct. Certainly the last else doesn't look=
 right to me.

I'm quite sure this driver can't in current state=C2=A0support create bufs =
on capture
queue, as it does not have code to register the capture buffer against firm=
ware.
I suspect this is largely untested enabled feature. This must be reworked o=
r
removed.

>=20
> > +	if (inst->state =3D=3D VPU_INST_STATE_NONE && q->type =3D=3D V4L2_BUF=
_TYPE_VIDEO_OUTPUT_MPLANE) {
> > +		struct dec_open_param open_param;
> > +
> > +		memset(&open_param, 0, sizeof(struct dec_open_param));
> > +		wave5_set_default_dec_openparam(&open_param);
> > +
> > +		inst->bitstream_vbuf.size =3D ALIGN(inst->src_fmt.plane_fmt[0].sizei=
mage, 1024) * 4;
> > +		ret =3D wave5_vdi_allocate_dma_memory(inst->dev, &inst->bitstream_vb=
uf);
> > +		if (ret) {
> > +			dev_dbg(inst->dev->dev, "%s: alloc bitstream of size %zu fail: %d\n=
",
> > +				__func__, inst->bitstream_vbuf.size, ret);
> > +			return ret;
> > +		}
> > +
> > +		inst->std =3D wave5_to_vpu_codstd(inst->src_fmt.pixelformat);
> > +		if (inst->std =3D=3D STD_UNKNOWN) {
> > +			dev_warn(inst->dev->dev, "unsupported pixelformat: %.4s\n",
> > +				 (char *)&inst->src_fmt.pixelformat);
> > +			ret =3D -EINVAL;
> > +			goto free_bitstream_vbuf;
> > +		}
> > +		open_param.bitstream_buffer =3D inst->bitstream_vbuf.daddr;
> > +		open_param.bitstream_buffer_size =3D inst->bitstream_vbuf.size;
> > +
> > +		ret =3D wave5_vpu_dec_open(inst, &open_param);
> > +		if (ret) {
> > +			dev_dbg(inst->dev->dev, "%s: wave5_vpu_dec_open, fail: %d\n",
> > +				__func__, ret);
> > +			goto free_bitstream_vbuf;
> > +		}
> > +
> > +		inst->state =3D VPU_INST_STATE_OPEN;
> > +
> > +		if (inst->thumbnail_mode)
> > +			wave5_vpu_dec_give_command(inst, ENABLE_DEC_THUMBNAIL_MODE, NULL);
> > +
> > +	} else if (inst->state =3D=3D VPU_INST_STATE_INIT_SEQ &&
> > +		   q->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
>=20
> I'm fairly certain you can get here twice by calling CREATE_BUFS while al=
ready streaming.
>=20
> > +		u32 non_linear_num;
> > +		u32 fb_stride, fb_height;
> > +		u32 luma_size, chroma_size;
> > +
> > +		if (*num_buffers > inst->min_dst_buf_count &&
> > +		    *num_buffers < WAVE5_MAX_FBS)
>=20
> Since this driver supports create_bufs, the correct check here is
> q->num_buffers + *num_buffers.
>=20
> > +			inst->dst_buf_count =3D *num_buffers;
>=20
> I think this is set too early, if there is an error below, then
> dst_buf_count has been updated, when it shouldn't.
>=20
> > +
> > +		*num_buffers =3D inst->dst_buf_count;
> > +		non_linear_num =3D inst->dst_buf_count;
> > +
> > +		for (i =3D 0; i < non_linear_num; i++) {
> > +			struct frame_buffer *frame =3D &inst->frame_buf[i];
> > +			struct vpu_buf *vframe =3D &inst->frame_vbuf[i];
> > +
> > +			fb_stride =3D inst->dst_fmt.width;
> > +			fb_height =3D ALIGN(inst->dst_fmt.height, 32);
> > +			luma_size =3D fb_stride * fb_height;
> > +			chroma_size =3D ALIGN(fb_stride / 2, 16) * fb_height;
> > +
> > +			vframe->size =3D luma_size + chroma_size;
> > +			ret =3D wave5_vdi_allocate_dma_memory(inst->dev, vframe);
> > +			if (ret) {
> > +				dev_dbg(inst->dev->dev,
> > +					"%s: Allocating FBC buf of size %zu, fail: %d\n",
> > +					__func__, vframe->size, ret);
>=20
> Shouldn't earlier allocs that succeeded be freed here?
>=20
> > +				return ret;
> > +			}
> > +
> > +			frame->buf_y =3D vframe->daddr;
> > +			frame->buf_cb =3D vframe->daddr + luma_size;
> > +			frame->buf_cr =3D (dma_addr_t)-1;
> > +			frame->size =3D vframe->size;
> > +			frame->width =3D inst->src_fmt.width;
> > +			frame->stride =3D fb_stride;
> > +			frame->map_type =3D COMPRESSED_FRAME_MAP;
> > +			frame->update_fb_info =3D true;
> > +		}
> > +	} else if (inst->state =3D=3D VPU_INST_STATE_STOP &&
> > +		   q->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE) {
> > +		*num_buffers =3D 0;
>=20
> Why?
>=20
> It's odd anyway, you can do a STREAMON, stream for a while, then STREAMOF=
F,
> add more buffers and do STREAMON again. I'm not sure this will work in th=
is
> driver.
>=20
> > +	}
> > +
> > +	return 0;
> > +
> > +free_bitstream_vbuf:
> > +	wave5_vdi_free_dma_memory(inst->dev, &inst->bitstream_vbuf);
> > +	return ret;
> > +}
> > +
> > +static int wave5_vpu_dec_start_streaming_open(struct vpu_instance *ins=
t)
> > +{
> > +	struct dec_initial_info initial_info;
> > +	int ret =3D 0;
> > +
> > +	memset(&initial_info, 0, sizeof(struct dec_initial_info));
> > +
> > +	ret =3D wave5_vpu_dec_issue_seq_init(inst);
> > +	if (ret) {
> > +		dev_dbg(inst->dev->dev, "%s: wave5_vpu_dec_issue_seq_init, fail: %d\=
n",
> > +			__func__, ret);
> > +		return ret;
> > +	}
> > +
> > +	if (wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT) < 0)
> > +		dev_dbg(inst->dev->dev, "%s: failed to call vpu_wait_interrupt()\n",=
 __func__);
> > +
> > +	ret =3D wave5_vpu_dec_complete_seq_init(inst, &initial_info);
> > +	if (ret) {
> > +		dev_dbg(inst->dev->dev, "%s: vpu_dec_complete_seq_init, fail: %d, re=
ason: %u\n",
> > +			__func__, ret, initial_info.seq_init_err_reason);
> > +	} else {
> > +		static const struct v4l2_event vpu_event_src_ch =3D {
> > +			.type =3D V4L2_EVENT_SOURCE_CHANGE,
> > +			.u.src_change.changes =3D V4L2_EVENT_SRC_CH_RESOLUTION,
> > +		};
> > +		struct v4l2_ctrl *ctrl;
> > +
> > +		dev_dbg(inst->dev->dev, "%s: width: %u height: %u profile: %u | minb=
uffer: %u\n",
> > +			__func__, initial_info.pic_width, initial_info.pic_height,
> > +			initial_info.profile, initial_info.min_frame_buffer_count);
> > +
> > +		inst->state =3D VPU_INST_STATE_INIT_SEQ;
> > +		inst->min_dst_buf_count =3D initial_info.min_frame_buffer_count + 1;
> > +		inst->dst_buf_count =3D inst->min_dst_buf_count;
> > +
> > +		inst->conf_win_width =3D initial_info.pic_width - initial_info.pic_c=
rop_rect.right;
> > +		inst->conf_win_height =3D initial_info.pic_height - initial_info.pic=
_crop_rect.bottom;
> > +
> > +		ctrl =3D v4l2_ctrl_find(&inst->v4l2_ctrl_hdl,
> > +				      V4L2_CID_MIN_BUFFERS_FOR_CAPTURE);
> > +		if (ctrl)
> > +			v4l2_ctrl_s_ctrl(ctrl, inst->min_dst_buf_count);
> > +
> > +		if (initial_info.pic_width !=3D inst->src_fmt.width ||
> > +		    initial_info.pic_height !=3D inst->src_fmt.height) {
> > +			wave5_update_pix_fmt(&inst->src_fmt, initial_info.pic_width,
> > +					     initial_info.pic_height);
> > +			wave5_update_pix_fmt(&inst->dst_fmt, initial_info.pic_width,
> > +					     initial_info.pic_height);
> > +		}
> > +		v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_src_ch);
> > +
> > +		wave5_handle_src_buffer(inst);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int wave5_vpu_dec_start_streaming_seek(struct vpu_instance *ins=
t)
> > +{
> > +	struct dec_initial_info initial_info;
> > +	struct dec_param pic_param;
> > +	struct dec_output_info dec_output_info;
> > +	int ret =3D 0;
> > +	u32 fail_res =3D 0;
> > +
> > +	memset(&pic_param, 0, sizeof(struct dec_param));
> > +
> > +	ret =3D wave5_vpu_dec_start_one_frame(inst, &pic_param, &fail_res);
> > +	if (ret && fail_res !=3D WAVE5_SYSERR_QUEUEING_FAIL) {
> > +		struct vb2_v4l2_buffer *src_buf;
> > +
> > +		src_buf =3D v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
> > +		inst->state =3D VPU_INST_STATE_STOP;
> > +		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
> > +		dev_dbg(inst->dev->dev, "%s: wave5_vpu_dec_start_one_frame\n", __fun=
c__);
> > +		return ret;
> > +	}
> > +
> > +	if (wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT) < 0)
> > +		dev_dbg(inst->dev->dev, "%s: failed to call vpu_wait_interrupt()\n",=
 __func__);
> > +
> > +	ret =3D wave5_vpu_dec_get_output_info(inst, &dec_output_info);
> > +	if (ret) {
> > +		dev_dbg(inst->dev->dev, "%s: wave5_vpu_dec_get_output_info, fail: %d=
\n",
> > +			__func__, ret);
> > +		return ret;
> > +	}
> > +
> > +	if (dec_output_info.sequence_changed) {
> > +		static const struct v4l2_event vpu_event_src_ch =3D {
> > +			.type =3D V4L2_EVENT_SOURCE_CHANGE,
> > +			.u.src_change.changes =3D V4L2_EVENT_SRC_CH_RESOLUTION,
> > +		};
> > +		struct v4l2_ctrl *ctrl;
> > +
> > +		wave5_vpu_dec_give_command(inst, DEC_RESET_FRAMEBUF_INFO, NULL);
> > +		wave5_vpu_dec_give_command(inst, DEC_GET_SEQ_INFO, &initial_info);
> > +
> > +		dev_dbg(inst->dev->dev, "%s: width: %u height: %u profile: %u | minb=
uffer: %u\n",
> > +			__func__, initial_info.pic_width, initial_info.pic_height,
> > +			initial_info.profile, initial_info.min_frame_buffer_count);
> > +
> > +		inst->min_dst_buf_count =3D initial_info.min_frame_buffer_count + 1;
> > +		inst->dst_buf_count =3D inst->min_dst_buf_count;
> > +
> > +		inst->conf_win_width =3D initial_info.pic_width - initial_info.pic_c=
rop_rect.right;
> > +		inst->conf_win_height =3D initial_info.pic_height - initial_info.pic=
_crop_rect.bottom;
> > +
> > +		ctrl =3D v4l2_ctrl_find(&inst->v4l2_ctrl_hdl,
> > +				      V4L2_CID_MIN_BUFFERS_FOR_CAPTURE);
> > +		if (ctrl)
> > +			v4l2_ctrl_s_ctrl(ctrl, inst->min_dst_buf_count);
> > +
> > +		if (initial_info.pic_width !=3D inst->src_fmt.width ||
> > +		    initial_info.pic_height !=3D inst->src_fmt.height) {
> > +			wave5_update_pix_fmt(&inst->src_fmt, initial_info.pic_width,
> > +					     initial_info.pic_height);
> > +			wave5_update_pix_fmt(&inst->dst_fmt, initial_info.pic_width,
> > +					     initial_info.pic_height);
> > +		}
> > +		v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_src_ch);
> > +
> > +		wave5_handle_src_buffer(inst);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void wave5_vpu_dec_buf_queue_src(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(vb->vb2_queue);
> > +	struct vpu_buffer *vpu_buf =3D wave5_to_vpu_buf(vbuf);
> > +
> > +	vpu_buf->consumed =3D false;
> > +	vbuf->sequence =3D inst->queued_src_buf_num++;
> > +
> > +	if (inst->state =3D=3D VPU_INST_STATE_PIC_RUN) {
> > +		wave5_handle_bitstream_buffer(inst);
> > +		inst->ops->start_process(inst);
> > +	}
> > +}
> > +
> > +static void wave5_vpu_dec_buf_queue_dst(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(vb->vb2_queue);
> > +	int ret;
> > +
> > +	vbuf->sequence =3D inst->queued_dst_buf_num++;
> > +	ret =3D wave5_vpu_dec_clr_disp_flag(inst, vb->index);
> > +	if (ret) {
> > +		dev_dbg(inst->dev->dev,
> > +			"%s: Clearing the display flag of buffer index: %u, fail: %d\n",
> > +			__func__, vb->index, ret);
> > +	}
> > +
> > +	if (inst->state =3D=3D VPU_INST_STATE_INIT_SEQ) {
> > +		dma_addr_t buf_addr_y =3D 0, buf_addr_cb =3D 0, buf_addr_cr =3D 0;
> > +		u32 buf_size =3D 0;
> > +		u32 non_linear_num =3D inst->dst_buf_count;
> > +		u32 fb_stride =3D inst->dst_fmt.width;
> > +		u32 luma_size =3D fb_stride * inst->dst_fmt.height;
> > +		u32 chroma_size =3D (fb_stride / 2) * (inst->dst_fmt.height / 2);
> > +
> > +		if (inst->dst_fmt.num_planes =3D=3D 1) {
> > +			buf_size =3D vb2_plane_size(&vbuf->vb2_buf, 0);
> > +			buf_addr_y =3D vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
> > +			buf_addr_cb =3D buf_addr_y + luma_size;
> > +			buf_addr_cr =3D buf_addr_cb + chroma_size;
> > +		} else if (inst->dst_fmt.num_planes =3D=3D 2) {
> > +			buf_size =3D vb2_plane_size(&vbuf->vb2_buf, 0) +
> > +				vb2_plane_size(&vbuf->vb2_buf, 1);
> > +			buf_addr_y =3D vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
> > +			buf_addr_cb =3D vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 1);
> > +			buf_addr_cr =3D buf_addr_cb + chroma_size;
> > +		} else if (inst->dst_fmt.num_planes =3D=3D 3) {
> > +			buf_size =3D vb2_plane_size(&vbuf->vb2_buf, 0) +
> > +				vb2_plane_size(&vbuf->vb2_buf, 1) +
> > +				vb2_plane_size(&vbuf->vb2_buf, 2);
> > +			buf_addr_y =3D vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 0);
> > +			buf_addr_cb =3D vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 1);
> > +			buf_addr_cr =3D vb2_dma_contig_plane_dma_addr(&vbuf->vb2_buf, 2);
> > +		}
> > +		inst->frame_buf[vb->index + non_linear_num].buf_y =3D buf_addr_y;
> > +		inst->frame_buf[vb->index + non_linear_num].buf_cb =3D buf_addr_cb;
> > +		inst->frame_buf[vb->index + non_linear_num].buf_cr =3D buf_addr_cr;
> > +		inst->frame_buf[vb->index + non_linear_num].size =3D buf_size;
> > +		inst->frame_buf[vb->index + non_linear_num].width =3D inst->src_fmt.=
width;
> > +		inst->frame_buf[vb->index + non_linear_num].stride =3D fb_stride;
> > +		inst->frame_buf[vb->index + non_linear_num].map_type =3D LINEAR_FRAM=
E_MAP;
> > +		inst->frame_buf[vb->index + non_linear_num].update_fb_info =3D true;
> > +	}
> > +
> > +	if (!vb2_is_streaming(vb->vb2_queue))
> > +		return;
> > +
> > +	if (inst->state =3D=3D VPU_INST_STATE_STOP && inst->eos =3D=3D FALSE)
> > +		inst->ops->start_process(inst);
> > +}
> > +
> > +static void wave5_vpu_dec_buf_queue(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(vb->vb2_queue);
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %4u index: %4u size: ([0]=3D%4lu, =
[1]=3D%4lu, [2]=3D%4lu)\n",
> > +		__func__, vb->type, vb->index, vb2_plane_size(&vbuf->vb2_buf, 0),
> > +		vb2_plane_size(&vbuf->vb2_buf, 1), vb2_plane_size(&vbuf->vb2_buf, 2)=
);
> > +
> > +	v4l2_m2m_buf_queue(inst->v4l2_fh.m2m_ctx, vbuf);
> > +
> > +	if (vb->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +		wave5_vpu_dec_buf_queue_src(vb);
> > +	else if (vb->type =3D=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +		wave5_vpu_dec_buf_queue_dst(vb);
> > +}
> > +
> > +static int wave5_vpu_dec_start_streaming(struct vb2_queue *q, unsigned=
 int count)
> > +{
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
> > +	int ret =3D 0;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> > +
> > +	if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > +		wave5_handle_bitstream_buffer(inst);
> > +		if (inst->state =3D=3D VPU_INST_STATE_OPEN)
> > +			ret =3D wave5_vpu_dec_start_streaming_open(inst);
> > +		else if (inst->state =3D=3D VPU_INST_STATE_INIT_SEQ)
> > +			ret =3D wave5_vpu_dec_start_streaming_seek(inst);
> > +
> > +		if (ret) {
> > +			struct vb2_v4l2_buffer *buf;
> > +
> > +			while ((buf =3D v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx))) {
> > +				dev_dbg(inst->dev->dev, "%s: (Multiplanar) buf type %4d | index %4=
d\n",
> > +					    __func__, buf->vb2_buf.type, buf->vb2_buf.index);
> > +				v4l2_m2m_buf_done(buf, VB2_BUF_STATE_QUEUED);
> > +			}
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void wave5_vpu_dec_stop_streaming(struct vb2_queue *q)
> > +{
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
> > +	struct vb2_v4l2_buffer *buf;
> > +	bool check_cmd =3D TRUE;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> > +
> > +	while (check_cmd) {
> > +		struct queue_status_info q_status;
> > +		struct dec_output_info dec_output_info;
> > +
> > +		wave5_vpu_dec_give_command(inst, DEC_GET_QUEUE_STATUS, &q_status);
> > +
> > +		if (q_status.instance_queue_count + q_status.report_queue_count =3D=
=3D 0)
> > +			break;
> > +
> > +		if (wave5_vpu_wait_interrupt(inst, VPU_DEC_TIMEOUT) < 0)
> > +			break;
> > +
> > +		if (wave5_vpu_dec_get_output_info(inst, &dec_output_info))
> > +			dev_dbg(inst->dev->dev, "Getting decoding results from fw, fail\n")=
;
> > +	}
> > +
> > +	if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > +		while ((buf =3D v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx))) {
> > +			dev_dbg(inst->dev->dev, "%s: (Multiplanar) buf type %4u | index %4u=
\n",
> > +				__func__, buf->vb2_buf.type, buf->vb2_buf.index);
> > +			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
> > +		}
> > +		inst->queued_src_buf_num =3D 0;
> > +	} else {
> > +		unsigned int i;
> > +		int ret;
> > +		dma_addr_t rd_ptr, wr_ptr;
> > +
> > +		while ((buf =3D v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx))) {
> > +			u32 plane;
> > +
> > +			dev_dbg(inst->dev->dev, "%s: buf type %4u | index %4u\n",
> > +				__func__, buf->vb2_buf.type, buf->vb2_buf.index);
> > +
> > +			for (plane =3D 0; plane < inst->dst_fmt.num_planes; plane++)
> > +				vb2_set_plane_payload(&buf->vb2_buf, plane, 0);
> > +
> > +			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
> > +		}
> > +
> > +		for (i =3D 0; i < inst->dst_buf_count; i++) {
> > +			ret =3D wave5_vpu_dec_set_disp_flag(inst, i);
> > +			if (ret) {
> > +				dev_dbg(inst->dev->dev,
> > +					"%s: Setting display flag of buf index: %u, fail: %d\n",
> > +					__func__, i, ret);
> > +			}
> > +		}
> > +
> > +		ret =3D wave5_vpu_dec_get_bitstream_buffer(inst, &rd_ptr, &wr_ptr, N=
ULL);
> > +		if (ret) {
> > +			dev_err(inst->dev->dev,
> > +				"Getting bitstream buf, fail: %d\n", ret);
> > +			return;
> > +		}
> > +		ret =3D wave5_vpu_dec_set_rd_ptr(inst, wr_ptr, TRUE);
> > +		if (ret) {
> > +			dev_err(inst->dev->dev,
> > +				"Setting read pointer for the decoder, fail: %d\n", ret);
> > +			return;
> > +		}
> > +		if (inst->eos) {
> > +			inst->eos =3D FALSE;
> > +			inst->state =3D VPU_INST_STATE_INIT_SEQ;
> > +		}
> > +		inst->queued_dst_buf_num =3D 0;
> > +	}
> > +}
> > +
> > +static const struct vb2_ops wave5_vpu_dec_vb2_ops =3D {
> > +	.queue_setup =3D wave5_vpu_dec_queue_setup,
> > +	.wait_prepare =3D vb2_ops_wait_prepare,
> > +	.wait_finish =3D vb2_ops_wait_finish,
> > +	.buf_queue =3D wave5_vpu_dec_buf_queue,
> > +	.start_streaming =3D wave5_vpu_dec_start_streaming,
> > +	.stop_streaming =3D wave5_vpu_dec_stop_streaming,
> > +};
> > +
> > +static void wave5_set_default_format(struct v4l2_pix_format_mplane *sr=
c_fmt,
> > +				     struct v4l2_pix_format_mplane *dst_fmt)
> > +{
> > +	unsigned int dst_pix_fmt =3D dec_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_p=
ix_fmt;
> > +	const struct v4l2_format_info *dst_fmt_info =3D v4l2_format_info(dst_=
pix_fmt);
> > +
> > +	src_fmt->pixelformat =3D dec_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix=
_fmt;
> > +	src_fmt->field =3D V4L2_FIELD_NONE;
> > +	src_fmt->flags =3D 0;
> > +	src_fmt->num_planes =3D 1;
> > +	wave5_update_pix_fmt(src_fmt, 720, 480);
> > +
> > +	dst_fmt->pixelformat =3D dst_pix_fmt;
> > +	dst_fmt->field =3D V4L2_FIELD_NONE;
> > +	dst_fmt->flags =3D 0;
> > +	dst_fmt->num_planes =3D dst_fmt_info->mem_planes;
> > +	wave5_update_pix_fmt(dst_fmt, 736, 480);
> > +}
> > +
> > +static int wave5_vpu_dec_queue_init(void *priv, struct vb2_queue *src_=
vq, struct vb2_queue *dst_vq)
> > +{
> > +	return wave5_vpu_queue_init(priv, src_vq, dst_vq, &wave5_vpu_dec_vb2_=
ops);
> > +}
> > +
> > +static const struct vpu_instance_ops wave5_vpu_dec_inst_ops =3D {
> > +	.start_process =3D wave5_vpu_dec_start_decode,
> > +	.stop_process =3D wave5_vpu_dec_stop_decode,
> > +	.finish_process =3D wave5_vpu_dec_finish_decode,
> > +};
> > +
> > +static void wave5_vpu_dec_device_run(void *priv)
> > +{
> > +	struct vpu_instance *inst =3D priv;
> > +
> > +	inst->ops->start_process(inst);
> > +
> > +	inst->state =3D VPU_INST_STATE_PIC_RUN;
> > +}
> > +
> > +static void wave5_vpu_dec_job_abort(void *priv)
> > +{
> > +	struct vpu_instance *inst =3D priv;
> > +
> > +	inst->ops->stop_process(inst);
> > +}
> > +
> > +static const struct v4l2_m2m_ops wave5_vpu_dec_m2m_ops =3D {
> > +	.device_run =3D wave5_vpu_dec_device_run,
> > +	.job_abort =3D wave5_vpu_dec_job_abort,
> > +};
> > +
> > +static int wave5_vpu_open_dec(struct file *filp)
> > +{
> > +	struct video_device *vdev =3D video_devdata(filp);
> > +	struct vpu_device *dev =3D video_drvdata(filp);
> > +	struct vpu_instance *inst =3D NULL;
> > +	int ret =3D 0;
> > +
> > +	inst =3D kzalloc(sizeof(*inst), GFP_KERNEL);
> > +	if (!inst)
> > +		return -ENOMEM;
> > +
> > +	inst->dev =3D dev;
> > +	inst->type =3D VPU_INST_TYPE_DEC;
> > +	inst->ops =3D &wave5_vpu_dec_inst_ops;
> > +
> > +	v4l2_fh_init(&inst->v4l2_fh, vdev);
> > +	filp->private_data =3D &inst->v4l2_fh;
> > +	v4l2_fh_add(&inst->v4l2_fh);
> > +
> > +	INIT_LIST_HEAD(&inst->list);
> > +	list_add_tail(&inst->list, &dev->instances);
> > +
> > +	inst->v4l2_m2m_dev =3D v4l2_m2m_init(&wave5_vpu_dec_m2m_ops);
> > +	if (IS_ERR(inst->v4l2_m2m_dev)) {
> > +		ret =3D PTR_ERR(inst->v4l2_m2m_dev);
> > +		dev_err(inst->dev->dev, "v4l2_m2m_init, fail: %d\n", ret);
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	inst->v4l2_fh.m2m_ctx =3D
> > +		v4l2_m2m_ctx_init(inst->v4l2_m2m_dev, inst, wave5_vpu_dec_queue_init=
);
> > +	if (IS_ERR(inst->v4l2_fh.m2m_ctx)) {
> > +		ret =3D PTR_ERR(inst->v4l2_fh.m2m_ctx);
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	v4l2_ctrl_handler_init(&inst->v4l2_ctrl_hdl, 10);
> > +	v4l2_ctrl_new_custom(&inst->v4l2_ctrl_hdl, &wave5_vpu_thumbnail_mode,=
 NULL);
> > +	v4l2_ctrl_new_std(&inst->v4l2_ctrl_hdl, &wave5_vpu_dec_ctrl_ops,
> > +			  V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 1);
> > +
> > +	if (inst->v4l2_ctrl_hdl.error) {
> > +		ret =3D -ENODEV;
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	inst->v4l2_fh.ctrl_handler =3D &inst->v4l2_ctrl_hdl;
> > +	v4l2_ctrl_handler_setup(&inst->v4l2_ctrl_hdl);
> > +
> > +	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
> > +	inst->colorspace =3D V4L2_COLORSPACE_REC709;
> > +	inst->ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
> > +	inst->hsv_enc =3D 0;
> > +	inst->quantization =3D V4L2_QUANTIZATION_DEFAULT;
> > +	inst->xfer_func =3D V4L2_XFER_FUNC_DEFAULT;
> > +
> > +	init_completion(&inst->irq_done);
> > +	ret =3D kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL);
> > +	if (ret) {
> > +		dev_err(inst->dev->dev, "failed to allocate fifo\n");
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	inst->id =3D ida_alloc(&inst->dev->inst_ida, GFP_KERNEL);
> > +	if (inst->id < 0) {
> > +		dev_warn(inst->dev->dev, "Allocating instance ID, fail: %d\n", inst-=
>id);
> > +		ret =3D inst->id;
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	return 0;
> > +
> > +cleanup_inst:
> > +	wave5_cleanup_instance(inst);
> > +	return ret;
> > +}
> > +
> > +static int wave5_vpu_dec_release(struct file *filp)
> > +{
> > +	return wave5_vpu_release_device(filp, wave5_vpu_dec_close, "decoder")=
;
> > +}
> > +
> > +static const struct v4l2_file_operations wave5_vpu_dec_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.open =3D wave5_vpu_open_dec,
> > +	.release =3D wave5_vpu_dec_release,
> > +	.unlocked_ioctl =3D video_ioctl2,
> > +	.poll =3D v4l2_m2m_fop_poll,
> > +	.mmap =3D v4l2_m2m_fop_mmap,
> > +};
> > +
> > +int wave5_vpu_dec_register_device(struct vpu_device *dev)
> > +{
> > +	struct video_device *vdev_dec;
> > +	int ret;
> > +
> > +	vdev_dec =3D devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_dec), GFP_K=
ERNEL);
> > +	if (!vdev_dec)
> > +		return -ENOMEM;
> > +
> > +	dev->video_dev_dec =3D vdev_dec;
> > +
> > +	strscpy(vdev_dec->name, VPU_DEC_DEV_NAME, sizeof(vdev_dec->name));
> > +	vdev_dec->fops =3D &wave5_vpu_dec_fops;
> > +	vdev_dec->ioctl_ops =3D &wave5_vpu_dec_ioctl_ops;
> > +	vdev_dec->release =3D video_device_release_empty;
> > +	vdev_dec->v4l2_dev =3D &dev->v4l2_dev;
> > +	vdev_dec->vfl_dir =3D VFL_DIR_M2M;
> > +	vdev_dec->device_caps =3D V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAM=
ING;
> > +	vdev_dec->lock =3D &dev->dev_lock;
> > +
> > +	ret =3D video_register_device(vdev_dec, VFL_TYPE_VIDEO, -1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	video_set_drvdata(vdev_dec, dev);
> > +
> > +	return 0;
> > +}
> > +
> > +void wave5_vpu_dec_unregister_device(struct vpu_device *dev)
> > +{
> > +	video_unregister_device(dev->video_dev_dec);
> > +}
> > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c b=
/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > new file mode 100644
> > index 000000000000..285111c2d9cd
> > --- /dev/null
> > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > @@ -0,0 +1,1746 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +/*
> > + * Wave5 series multi-standard codec IP - encoder interface
> > + *
> > + * Copyright (C) 2021 CHIPS&MEDIA INC
> > + */
> > +
> > +#include "wave5-helper.h"
> > +
> > +#define VPU_ENC_DEV_NAME "C&M Wave5 VPU encoder"
> > +#define VPU_ENC_DRV_NAME "wave5-enc"
> > +
> > +static const struct vpu_format enc_fmt_list[FMT_TYPES][MAX_FMTS] =3D {
> > +	[VPU_FMT_TYPE_CODEC] =3D {
> > +		{
> > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_HEVC,
> > +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> > +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> > +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> > +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> > +		},
> > +		{
> > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_H264,
> > +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> > +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> > +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> > +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> > +		},
> > +	},
> > +	[VPU_FMT_TYPE_RAW] =3D {
> > +		{
> > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV420,
> > +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> > +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> > +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> > +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> > +		},
> > +		{
> > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV12,
> > +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> > +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> > +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> > +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> > +		},
> > +		{
> > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV21,
> > +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> > +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> > +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> > +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> > +		},
> > +		{
> > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV420M,
> > +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> > +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> > +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> > +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> > +		},
> > +		{
> > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV12M,
> > +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> > +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> > +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> > +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> > +		},
> > +		{
> > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV21M,
> > +			.max_width =3D W5_MAX_ENC_PIC_WIDTH,
> > +			.min_width =3D W5_MIN_ENC_PIC_WIDTH,
> > +			.max_height =3D W5_MAX_ENC_PIC_HEIGHT,
> > +			.min_height =3D W5_MIN_ENC_PIC_HEIGHT,
> > +		},
> > +	}
> > +};
> > +
> > +static enum wave_std wave5_to_vpu_wavestd(unsigned int v4l2_pix_fmt)
> > +{
> > +	switch (v4l2_pix_fmt) {
> > +	case V4L2_PIX_FMT_H264:
> > +		return W_AVC_ENC;
> > +	case V4L2_PIX_FMT_HEVC:
> > +		return W_HEVC_ENC;
> > +	default:
> > +		return STD_UNKNOWN;
> > +	}
> > +}
> > +
> > +static struct vb2_v4l2_buffer *wave5_get_valid_src_buf(struct vpu_inst=
ance *inst)
> > +{
> > +	struct v4l2_m2m_buffer *v4l2_m2m_buf;
> > +
> > +	v4l2_m2m_for_each_src_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
> > +		struct vb2_v4l2_buffer *vb2_v4l2_buf;
> > +		struct vpu_buffer *vpu_buf =3D NULL;
> > +
> > +		vb2_v4l2_buf =3D &v4l2_m2m_buf->vb;
> > +		vpu_buf =3D wave5_to_vpu_buf(vb2_v4l2_buf);
> > +
> > +		if (!vpu_buf->consumed) {
> > +			dev_dbg(inst->dev->dev, "%s: src buf (index: %u) has not been consu=
med\n",
> > +				__func__, vb2_v4l2_buf->vb2_buf.index);
> > +			return vb2_v4l2_buf;
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static struct vb2_v4l2_buffer *wave5_get_valid_dst_buf(struct vpu_inst=
ance *inst)
> > +{
> > +	struct v4l2_m2m_buffer *v4l2_m2m_buf;
> > +
> > +	v4l2_m2m_for_each_dst_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
> > +		struct vb2_v4l2_buffer *vb2_v4l2_buf;
> > +		struct vpu_buffer *vpu_buf =3D NULL;
> > +
> > +		vb2_v4l2_buf =3D &v4l2_m2m_buf->vb;
> > +		vpu_buf =3D wave5_to_vpu_buf(vb2_v4l2_buf);
> > +
> > +		if (!vpu_buf->consumed) {
> > +			dev_dbg(inst->dev->dev, "%s: dst buf (index: %u) has not been consu=
med\n",
> > +				__func__, vb2_v4l2_buf->vb2_buf.index);
> > +			return vb2_v4l2_buf;
> > +		}
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +static void wave5_update_pix_fmt(struct v4l2_pix_format_mplane *pix_mp=
, unsigned int width,
> > +				 unsigned int height)
> > +{
> > +	switch (pix_mp->pixelformat) {
> > +	case V4L2_PIX_FMT_YUV420:
> > +	case V4L2_PIX_FMT_NV12:
> > +	case V4L2_PIX_FMT_NV21:
> > +		pix_mp->width =3D width;
> > +		pix_mp->height =3D height;
> > +		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> > +		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height * 3 =
/ 2;
> > +		break;
> > +	case V4L2_PIX_FMT_YUV420M:
> > +		pix_mp->width =3D width;
> > +		pix_mp->height =3D height;
> > +		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> > +		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height;
> > +		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32) / 2;
> > +		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height / 4;
> > +		pix_mp->plane_fmt[2].bytesperline =3D round_up(width, 32) / 2;
> > +		pix_mp->plane_fmt[2].sizeimage =3D round_up(width, 32) * height / 4;
> > +		break;
> > +	case V4L2_PIX_FMT_NV12M:
> > +	case V4L2_PIX_FMT_NV21M:
> > +		pix_mp->width =3D width;
> > +		pix_mp->height =3D height;
> > +		pix_mp->plane_fmt[0].bytesperline =3D round_up(width, 32);
> > +		pix_mp->plane_fmt[0].sizeimage =3D round_up(width, 32) * height;
> > +		pix_mp->plane_fmt[1].bytesperline =3D round_up(width, 32);
> > +		pix_mp->plane_fmt[1].sizeimage =3D round_up(width, 32) * height / 2;
> > +		break;
> > +	default:
> > +		pix_mp->width =3D width;
> > +		pix_mp->height =3D height;
> > +		pix_mp->plane_fmt[0].bytesperline =3D 0;
> > +		pix_mp->plane_fmt[0].sizeimage =3D width * height;
> > +		break;
> > +	}
> > +}
> > +
> > +static void wave5_vpu_enc_start_encode(struct vpu_instance *inst)
> > +{
> > +	u32 max_cmd_q =3D 0;
> > +
> > +	max_cmd_q =3D (inst->src_buf_count < COMMAND_QUEUE_DEPTH) ?
> > +		inst->src_buf_count : COMMAND_QUEUE_DEPTH;
> > +
> > +	if (inst->state =3D=3D VPU_INST_STATE_STOP)
> > +		max_cmd_q =3D 1;
> > +
> > +	while (max_cmd_q) {
> > +		struct vb2_v4l2_buffer *src_buf;
> > +		struct vb2_v4l2_buffer *dst_buf;
> > +		struct vpu_buffer *src_vbuf;
> > +		struct vpu_buffer *dst_vbuf;
> > +		struct frame_buffer frame_buf;
> > +		struct enc_param pic_param;
> > +		u32 stride =3D ALIGN(inst->dst_fmt.width, 32);
> > +		u32 luma_size =3D (stride * inst->dst_fmt.height);
> > +		u32 chroma_size =3D ((stride / 2) * (inst->dst_fmt.height / 2));
> > +		u32 fail_res;
> > +		int ret;
> > +
> > +		memset(&pic_param, 0, sizeof(struct enc_param));
> > +		memset(&frame_buf, 0, sizeof(struct frame_buffer));
> > +
> > +		src_buf =3D wave5_get_valid_src_buf(inst);
> > +		dst_buf =3D wave5_get_valid_dst_buf(inst);
> > +
> > +		if (!dst_buf) {
> > +			dev_dbg(inst->dev->dev, "%s: No valid dst buf\n", __func__);
> > +			break;
> > +		}
> > +
> > +		dst_vbuf =3D wave5_to_vpu_buf(dst_buf);
> > +		pic_param.pic_stream_buffer_addr =3D
> > +			vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0);
> > +		pic_param.pic_stream_buffer_size =3D
> > +			vb2_plane_size(&dst_buf->vb2_buf, 0);
> > +
> > +		if (!src_buf) {
> > +			dev_dbg(inst->dev->dev, "%s: No valid src buf\n", __func__);
> > +			if (inst->state =3D=3D VPU_INST_STATE_STOP)
> > +				pic_param.src_end_flag =3D true;
> > +			else
> > +				break;
> > +		} else {
> > +			src_vbuf =3D wave5_to_vpu_buf(src_buf);
> > +			if (inst->src_fmt.num_planes =3D=3D 1) {
> > +				frame_buf.buf_y =3D
> > +					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
> > +				frame_buf.buf_cb =3D frame_buf.buf_y + luma_size;
> > +				frame_buf.buf_cr =3D frame_buf.buf_cb + chroma_size;
> > +			} else if (inst->src_fmt.num_planes =3D=3D 2) {
> > +				frame_buf.buf_y =3D
> > +					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
> > +				frame_buf.buf_cb =3D
> > +					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 1);
> > +				frame_buf.buf_cr =3D frame_buf.buf_cb + chroma_size;
> > +			} else if (inst->src_fmt.num_planes =3D=3D 3) {
> > +				frame_buf.buf_y =3D
> > +					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 0);
> > +				frame_buf.buf_cb =3D
> > +					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 1);
> > +				frame_buf.buf_cr =3D
> > +					vb2_dma_contig_plane_dma_addr(&src_buf->vb2_buf, 2);
> > +			}
> > +			frame_buf.stride =3D stride;
> > +			pic_param.src_idx =3D src_buf->vb2_buf.index;
> > +		}
> > +
> > +		pic_param.source_frame =3D &frame_buf;
> > +		pic_param.code_option.implicit_header_encode =3D 1;
> > +		ret =3D wave5_vpu_enc_start_one_frame(inst, &pic_param, &fail_res);
> > +		if (ret) {
> > +			if (fail_res =3D=3D WAVE5_SYSERR_QUEUEING_FAIL)
> > +				break;
> > +
> > +			dev_dbg(inst->dev->dev, "%s: wave5_vpu_enc_start_one_frame fail: %d=
\n",
> > +				__func__, ret);
> > +			src_buf =3D v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx);
> > +			if (!src_buf) {
> > +				dev_dbg(inst->dev->dev,
> > +					"%s: Removing src buf failed, the queue is empty\n",
> > +					__func__);
> > +				continue;
> > +			}
> > +			dst_buf =3D v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx);
> > +			if (!dst_buf) {
> > +				dev_dbg(inst->dev->dev,
> > +					"%s: Removing dst buf failed, the queue is empty\n",
> > +					__func__);
> > +				continue;
> > +			}
> > +			inst->state =3D VPU_INST_STATE_STOP;
> > +			v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_ERROR);
> > +			v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_ERROR);
> > +		} else {
> > +			dev_dbg(inst->dev->dev, "%s: wave5_vpu_enc_start_one_frame success\=
n",
> > +				__func__);
> > +			if (src_buf)
> > +				src_vbuf->consumed =3D true;
> > +			if (dst_buf)
> > +				dst_vbuf->consumed =3D true;
> > +		}
> > +
> > +		max_cmd_q--;
> > +	}
> > +}
> > +
> > +static void wave5_vpu_enc_stop_encode(struct vpu_instance *inst)
> > +{
> > +	inst->state =3D VPU_INST_STATE_STOP;
> > +
> > +	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
> > +}
> > +
> > +static void wave5_vpu_enc_finish_encode(struct vpu_instance *inst)
> > +{
> > +	int ret;
> > +	struct enc_output_info enc_output_info;
> > +	u32 irq_status;
> > +	struct vb2_v4l2_buffer *dst_buf =3D NULL;
> > +	struct v4l2_m2m_buffer *v4l2_m2m_buf =3D NULL;
> > +
> > +	if (kfifo_out(&inst->irq_status, &irq_status, sizeof(int)))
> > +		wave5_vpu_clear_interrupt_ex(inst, irq_status);
> > +
> > +	ret =3D wave5_vpu_enc_get_output_info(inst, &enc_output_info);
> > +	if (ret) {
> > +		dev_dbg(inst->dev->dev,
> > +			"%s: vpu_enc_get_output_info fail: %d  reason: %u | info: %u\n",
> > +			__func__, ret, enc_output_info.error_reason, enc_output_info.warn_i=
nfo);
> > +		return;
> > +	}
> > +
> > +	v4l2_m2m_for_each_dst_buf(inst->v4l2_fh.m2m_ctx, v4l2_m2m_buf) {
> > +		dst_buf =3D &v4l2_m2m_buf->vb;
> > +		if (enc_output_info.bitstream_buffer =3D=3D
> > +			vb2_dma_contig_plane_dma_addr(&dst_buf->vb2_buf, 0))
> > +			break;
> > +	}
> > +
> > +	if (enc_output_info.enc_src_idx >=3D 0) {
> > +		struct vb2_v4l2_buffer *src_buf =3D
> > +			v4l2_m2m_src_buf_remove_by_idx(inst->v4l2_fh.m2m_ctx,
> > +						       enc_output_info.enc_src_idx);
> > +
> > +		inst->timestamp =3D src_buf->vb2_buf.timestamp;
> > +		v4l2_m2m_buf_done(src_buf, VB2_BUF_STATE_DONE);
> > +	}
> > +
> > +	if (enc_output_info.recon_frame_index =3D=3D RECON_IDX_FLAG_ENC_END) =
{
> > +		static const struct v4l2_event vpu_event_eos =3D {
> > +			.type =3D V4L2_EVENT_EOS
> > +		};
> > +
> > +		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, 0);
> > +		dst_buf->vb2_buf.timestamp =3D inst->timestamp;
> > +		dst_buf->field =3D V4L2_FIELD_NONE;
> > +		dst_buf->flags |=3D V4L2_BUF_FLAG_LAST;
> > +		v4l2_m2m_dst_buf_remove_by_buf(inst->v4l2_fh.m2m_ctx, dst_buf);
> > +		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
> > +
> > +		inst->state =3D VPU_INST_STATE_PIC_RUN;
> > +		v4l2_event_queue_fh(&inst->v4l2_fh, &vpu_event_eos);
> > +
> > +		v4l2_m2m_job_finish(inst->v4l2_m2m_dev, inst->v4l2_fh.m2m_ctx);
> > +	} else {
> > +		vb2_set_plane_payload(&dst_buf->vb2_buf, 0, enc_output_info.bitstrea=
m_size);
> > +
> > +		dst_buf->vb2_buf.timestamp =3D inst->timestamp;
> > +		dst_buf->field =3D V4L2_FIELD_NONE;
> > +		if (enc_output_info.pic_type =3D=3D PIC_TYPE_I) {
> > +			if (enc_output_info.enc_vcl_nut =3D=3D 19 ||
> > +			    enc_output_info.enc_vcl_nut =3D=3D 20)
> > +				dst_buf->flags |=3D V4L2_BUF_FLAG_KEYFRAME;
> > +			else
> > +				dst_buf->flags |=3D V4L2_BUF_FLAG_PFRAME;
> > +		} else if (enc_output_info.pic_type =3D=3D PIC_TYPE_P) {
> > +			dst_buf->flags |=3D V4L2_BUF_FLAG_PFRAME;
> > +		} else if (enc_output_info.pic_type =3D=3D PIC_TYPE_B) {
> > +			dst_buf->flags |=3D V4L2_BUF_FLAG_BFRAME;
> > +		}
> > +
> > +		v4l2_m2m_dst_buf_remove_by_buf(inst->v4l2_fh.m2m_ctx, dst_buf);
> > +		v4l2_m2m_buf_done(dst_buf, VB2_BUF_STATE_DONE);
> > +
> > +		dev_dbg(inst->dev->dev, "%s: frame_cycle %8u\n",
> > +			__func__, enc_output_info.frame_cycle);
> > +	}
> > +}
> > +
> > +static int wave5_vpu_enc_querycap(struct file *file, void *fh, struct =
v4l2_capability *cap)
> > +{
> > +	strscpy(cap->driver, VPU_ENC_DRV_NAME, sizeof(cap->driver));
> > +	strscpy(cap->card, VPU_ENC_DRV_NAME, sizeof(cap->card));
> > +	strscpy(cap->bus_info, "platform:" VPU_ENC_DRV_NAME, sizeof(cap->bus_=
info));
>=20
> Can be dropped.
>=20
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_enum_framesizes(struct file *f, void *fh, str=
uct v4l2_frmsizeenum *fsize)
> > +{
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	if (fsize->index)
> > +		return -EINVAL;
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt(fsize->pixel_format, enc_fmt_list[VPU_=
FMT_TYPE_CODEC]);
> > +	if (!vpu_fmt) {
> > +		vpu_fmt =3D wave5_find_vpu_fmt(fsize->pixel_format, enc_fmt_list[VPU=
_FMT_TYPE_RAW]);
> > +		if (!vpu_fmt)
> > +			return -EINVAL;
> > +	}
> > +
> > +	fsize->type =3D V4L2_FRMSIZE_TYPE_CONTINUOUS;
> > +	fsize->stepwise.min_width =3D vpu_fmt->min_width;
> > +	fsize->stepwise.max_width =3D vpu_fmt->max_width;
> > +	fsize->stepwise.step_width =3D 1;
> > +	fsize->stepwise.min_height =3D vpu_fmt->min_height;
> > +	fsize->stepwise.max_height =3D vpu_fmt->max_height;
> > +	fsize->stepwise.step_height =3D 1;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_enum_fmt_cap(struct file *file, void *fh, str=
uct v4l2_fmtdesc *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: index: %u\n", __func__, f->index);
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt_by_idx(f->index, enc_fmt_list[VPU_FMT_=
TYPE_CODEC]);
> > +	if (!vpu_fmt)
> > +		return -EINVAL;
> > +
> > +	f->pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> > +	f->flags =3D 0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_try_fmt_cap(struct file *file, void *fh, stru=
ct v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_plan=
es: %u field: %u\n",
> > +		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix=
_mp.height,
> > +		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
> > +
> > +	if (f->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE)
> > +		return -EINVAL;
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, enc_fmt_lis=
t[VPU_FMT_TYPE_CODEC]);
> > +	if (!vpu_fmt) {
> > +		f->fmt.pix_mp.pixelformat =3D inst->dst_fmt.pixelformat;
> > +		f->fmt.pix_mp.num_planes =3D inst->dst_fmt.num_planes;
> > +		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->dst_fmt.width, inst->dst_=
fmt.height);
> > +	} else {
> > +		int width =3D clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt=
->max_width);
> > +		int height =3D clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_=
fmt->max_height);
> > +
> > +		f->fmt.pix_mp.pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> > +		f->fmt.pix_mp.num_planes =3D 1;
> > +		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
> > +	}
> > +
> > +	f->fmt.pix_mp.flags =3D 0;
> > +	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> > +	f->fmt.pix_mp.colorspace =3D inst->colorspace;
> > +	f->fmt.pix_mp.ycbcr_enc =3D inst->ycbcr_enc;
> > +	f->fmt.pix_mp.hsv_enc =3D inst->hsv_enc;
> > +	f->fmt.pix_mp.quantization =3D inst->quantization;
> > +	f->fmt.pix_mp.xfer_func =3D inst->xfer_func;
> > +	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_s_fmt_cap(struct file *file, void *fh, struct=
 v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	int i, ret;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_plan=
es: %u field: %u\n",
> > +		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix=
_mp.height,
> > +		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
> > +
> > +	ret =3D wave5_vpu_enc_try_fmt_cap(file, fh, f);
> > +	if (ret)
> > +		return ret;
> > +
> > +	inst->dst_fmt.width =3D f->fmt.pix_mp.width;
> > +	inst->dst_fmt.height =3D f->fmt.pix_mp.height;
> > +	inst->dst_fmt.pixelformat =3D f->fmt.pix_mp.pixelformat;
> > +	inst->dst_fmt.field =3D f->fmt.pix_mp.field;
> > +	inst->dst_fmt.flags =3D f->fmt.pix_mp.flags;
> > +	inst->dst_fmt.num_planes =3D f->fmt.pix_mp.num_planes;
> > +	for (i =3D 0; i < inst->dst_fmt.num_planes; i++) {
> > +		inst->dst_fmt.plane_fmt[i].bytesperline =3D f->fmt.pix_mp.plane_fmt[=
i].bytesperline;
> > +		inst->dst_fmt.plane_fmt[i].sizeimage =3D f->fmt.pix_mp.plane_fmt[i].=
sizeimage;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_g_fmt_cap(struct file *file, void *fh, struct=
 v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	int i;
> > +
> > +	f->fmt.pix_mp.width =3D inst->dst_fmt.width;
> > +	f->fmt.pix_mp.height =3D inst->dst_fmt.height;
> > +	f->fmt.pix_mp.pixelformat =3D inst->dst_fmt.pixelformat;
> > +	f->fmt.pix_mp.field =3D inst->dst_fmt.field;
> > +	f->fmt.pix_mp.flags =3D inst->dst_fmt.flags;
> > +	f->fmt.pix_mp.num_planes =3D inst->dst_fmt.num_planes;
> > +	for (i =3D 0; i < f->fmt.pix_mp.num_planes; i++) {
> > +		f->fmt.pix_mp.plane_fmt[i].bytesperline =3D inst->dst_fmt.plane_fmt[=
i].bytesperline;
> > +		f->fmt.pix_mp.plane_fmt[i].sizeimage =3D inst->dst_fmt.plane_fmt[i].=
sizeimage;
> > +	}
> > +
> > +	f->fmt.pix_mp.colorspace =3D inst->colorspace;
> > +	f->fmt.pix_mp.ycbcr_enc =3D inst->ycbcr_enc;
> > +	f->fmt.pix_mp.hsv_enc =3D inst->hsv_enc;
> > +	f->fmt.pix_mp.quantization =3D inst->quantization;
> > +	f->fmt.pix_mp.xfer_func =3D inst->xfer_func;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_enum_fmt_out(struct file *file, void *fh, str=
uct v4l2_fmtdesc *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: index: %u\n", __func__, f->index);
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt_by_idx(f->index, enc_fmt_list[VPU_FMT_=
TYPE_RAW]);
> > +	if (!vpu_fmt)
> > +		return -EINVAL;
> > +
> > +	f->pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> > +	f->flags =3D 0;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_try_fmt_out(struct file *file, void *fh, stru=
ct v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	const struct vpu_format *vpu_fmt;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_plan=
es: %u field: %u\n",
> > +		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix=
_mp.height,
> > +		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
> > +
> > +	if (f->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +		return -EINVAL;
> > +
> > +	vpu_fmt =3D wave5_find_vpu_fmt(f->fmt.pix_mp.pixelformat, enc_fmt_lis=
t[VPU_FMT_TYPE_RAW]);
> > +	if (!vpu_fmt) {
> > +		f->fmt.pix_mp.pixelformat =3D inst->src_fmt.pixelformat;
> > +		f->fmt.pix_mp.num_planes =3D inst->src_fmt.num_planes;
> > +		wave5_update_pix_fmt(&f->fmt.pix_mp, inst->src_fmt.width, inst->src_=
fmt.height);
> > +	} else {
> > +		int width =3D clamp(f->fmt.pix_mp.width, vpu_fmt->min_width, vpu_fmt=
->max_width);
> > +		int height =3D clamp(f->fmt.pix_mp.height, vpu_fmt->min_height, vpu_=
fmt->max_height);
> > +		const struct v4l2_format_info *info =3D v4l2_format_info(vpu_fmt->v4=
l2_pix_fmt);
> > +
> > +		f->fmt.pix_mp.pixelformat =3D vpu_fmt->v4l2_pix_fmt;
> > +		f->fmt.pix_mp.num_planes =3D info->mem_planes;
> > +		wave5_update_pix_fmt(&f->fmt.pix_mp, width, height);
> > +	}
> > +
> > +	f->fmt.pix_mp.flags =3D 0;
> > +	f->fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> > +	memset(&f->fmt.pix_mp.reserved, 0, sizeof(f->fmt.pix_mp.reserved));
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_s_fmt_out(struct file *file, void *fh, struct=
 v4l2_format *f)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	int i, ret;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: fourcc: %u width: %u height: %u num_plan=
es: %u field: %u\n",
> > +		__func__, f->fmt.pix_mp.pixelformat, f->fmt.pix_mp.width, f->fmt.pix=
_mp.height,
> > +		f->fmt.pix_mp.num_planes, f->fmt.pix_mp.field);
> > +
> > +	ret =3D wave5_vpu_enc_try_fmt_out(file, fh, f);
> > +	if (ret)
> > +		return ret;
> > +
> > +	inst->src_fmt.width =3D f->fmt.pix_mp.width;
> > +	inst->src_fmt.height =3D f->fmt.pix_mp.height;
> > +	inst->src_fmt.pixelformat =3D f->fmt.pix_mp.pixelformat;
> > +	inst->src_fmt.field =3D f->fmt.pix_mp.field;
> > +	inst->src_fmt.flags =3D f->fmt.pix_mp.flags;
> > +	inst->src_fmt.num_planes =3D f->fmt.pix_mp.num_planes;
> > +	for (i =3D 0; i < inst->src_fmt.num_planes; i++) {
> > +		inst->src_fmt.plane_fmt[i].bytesperline =3D f->fmt.pix_mp.plane_fmt[=
i].bytesperline;
> > +		inst->src_fmt.plane_fmt[i].sizeimage =3D f->fmt.pix_mp.plane_fmt[i].=
sizeimage;
> > +	}
> > +
> > +	if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12 ||
> > +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12M) {
> > +		inst->cbcr_interleave =3D true;
> > +		inst->nv21 =3D false;
> > +	} else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21 ||
> > +		   inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21M) {
> > +		inst->cbcr_interleave =3D true;
> > +		inst->nv21 =3D true;
> > +	} else {
> > +		inst->cbcr_interleave =3D false;
> > +		inst->nv21 =3D false;
> > +	}
> > +
> > +	inst->colorspace =3D f->fmt.pix_mp.colorspace;
> > +	inst->ycbcr_enc =3D f->fmt.pix_mp.ycbcr_enc;
> > +	inst->hsv_enc =3D f->fmt.pix_mp.hsv_enc;
> > +	inst->quantization =3D f->fmt.pix_mp.quantization;
> > +	inst->xfer_func =3D f->fmt.pix_mp.xfer_func;
> > +
> > +	wave5_update_pix_fmt(&inst->dst_fmt, f->fmt.pix_mp.width, f->fmt.pix_=
mp.height);
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_g_selection(struct file *file, void *fh, stru=
ct v4l2_selection *s)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %u | target: %u\n", __func__, s->t=
ype, s->target);
> > +
> > +	if (s->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT) {
> > +		switch (s->target) {
> > +		case V4L2_SEL_TGT_CROP_DEFAULT:
> > +		case V4L2_SEL_TGT_CROP_BOUNDS:
> > +			s->r.left =3D 0;
> > +			s->r.top =3D 0;
> > +			s->r.width =3D inst->dst_fmt.width;
> > +			s->r.height =3D inst->dst_fmt.height;
> > +			break;
> > +		case V4L2_SEL_TGT_CROP:
> > +			s->r.left =3D 0;
> > +			s->r.top =3D 0;
> > +			s->r.width =3D inst->dst_fmt.width;
> > +			s->r.height =3D inst->dst_fmt.height;
> > +			dev_dbg(inst->dev->dev, "%s: V4L2_SEL_TGT_CROP width: %u | height: =
%u\n",
> > +				__func__, s->r.width, s->r.height);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	} else {
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_s_selection(struct file *file, void *fh, stru=
ct v4l2_selection *s)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +
> > +	if (s->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT)
> > +		return -EINVAL;
> > +
> > +	if (s->target !=3D V4L2_SEL_TGT_CROP)
> > +		return -EINVAL;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: V4L2_SEL_TGT_CROP width: %u | height: %u=
\n",
> > +		__func__, s->r.width, s->r.height);
> > +
> > +	s->r.left =3D 0;
> > +	s->r.top =3D 0;
> > +	s->r.width =3D inst->src_fmt.width;
> > +	s->r.height =3D inst->src_fmt.height;
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_encoder_cmd(struct file *file, void *fh, stru=
ct v4l2_encoder_cmd *ec)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +	int ret;
> > +
> > +	ret =3D v4l2_m2m_ioctl_try_encoder_cmd(file, fh, ec);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (!wave5_vpu_both_queues_are_streaming(inst))
> > +		return 0;
> > +
> > +	switch (ec->cmd) {
> > +	case V4L2_ENC_CMD_STOP:
> > +		inst->state =3D VPU_INST_STATE_STOP;
> > +		inst->ops->start_process(inst);
> > +		break;
> > +	case V4L2_ENC_CMD_START:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_g_parm(struct file *file, void *fh, struct v4=
l2_streamparm *a)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, a->type);
> > +
> > +	if (a->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT && a->type !=3D V4L2_BUF_=
TYPE_VIDEO_OUTPUT_MPLANE)
> > +		return -EINVAL;
> > +
> > +	a->parm.output.capability =3D V4L2_CAP_TIMEPERFRAME;
> > +	a->parm.output.timeperframe.numerator =3D 1;
> > +	a->parm.output.timeperframe.denominator =3D inst->frame_rate;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: numerator: %u | denominator: %u\n",
> > +		__func__, a->parm.output.timeperframe.numerator,
> > +		a->parm.output.timeperframe.denominator);
> > +
> > +	return 0;
> > +}
> > +
> > +static int wave5_vpu_enc_s_parm(struct file *file, void *fh, struct v4=
l2_streamparm *a)
> > +{
> > +	struct vpu_instance *inst =3D wave5_to_vpu_inst(fh);
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, a->type);
> > +
> > +	if (a->type !=3D V4L2_BUF_TYPE_VIDEO_OUTPUT && a->type !=3D V4L2_BUF_=
TYPE_VIDEO_OUTPUT_MPLANE)
> > +		return -EINVAL;
> > +
> > +	a->parm.output.capability =3D V4L2_CAP_TIMEPERFRAME;
> > +	if (a->parm.output.timeperframe.denominator && a->parm.output.timeper=
frame.numerator) {
> > +		inst->frame_rate =3D a->parm.output.timeperframe.denominator /
> > +				   a->parm.output.timeperframe.numerator;
> > +	} else {
> > +		a->parm.output.timeperframe.numerator =3D 1;
> > +		a->parm.output.timeperframe.denominator =3D inst->frame_rate;
> > +	}
> > +
> > +	dev_dbg(inst->dev->dev, "%s: numerator: %u | denominator: %u\n",
> > +		__func__, a->parm.output.timeperframe.numerator,
> > +		a->parm.output.timeperframe.denominator);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct v4l2_ioctl_ops wave5_vpu_enc_ioctl_ops =3D {
> > +	.vidioc_querycap =3D wave5_vpu_enc_querycap,
> > +	.vidioc_enum_framesizes =3D wave5_vpu_enc_enum_framesizes,
> > +
> > +	.vidioc_enum_fmt_vid_cap	=3D wave5_vpu_enc_enum_fmt_cap,
> > +	.vidioc_s_fmt_vid_cap_mplane =3D wave5_vpu_enc_s_fmt_cap,
> > +	.vidioc_g_fmt_vid_cap_mplane =3D wave5_vpu_enc_g_fmt_cap,
> > +	.vidioc_try_fmt_vid_cap_mplane =3D wave5_vpu_enc_try_fmt_cap,
> > +
> > +	.vidioc_enum_fmt_vid_out	=3D wave5_vpu_enc_enum_fmt_out,
> > +	.vidioc_s_fmt_vid_out_mplane =3D wave5_vpu_enc_s_fmt_out,
> > +	.vidioc_g_fmt_vid_out_mplane =3D wave5_vpu_g_fmt_out,
> > +	.vidioc_try_fmt_vid_out_mplane =3D wave5_vpu_enc_try_fmt_out,
> > +
> > +	.vidioc_g_selection =3D wave5_vpu_enc_g_selection,
> > +	.vidioc_s_selection =3D wave5_vpu_enc_s_selection,
> > +
> > +	.vidioc_g_parm =3D wave5_vpu_enc_g_parm,
> > +	.vidioc_s_parm =3D wave5_vpu_enc_s_parm,
> > +
> > +	.vidioc_reqbufs =3D v4l2_m2m_ioctl_reqbufs,
> > +	.vidioc_querybuf =3D v4l2_m2m_ioctl_querybuf,
> > +	.vidioc_create_bufs =3D v4l2_m2m_ioctl_create_bufs,
> > +	.vidioc_prepare_buf =3D v4l2_m2m_ioctl_prepare_buf,
> > +	.vidioc_qbuf =3D v4l2_m2m_ioctl_qbuf,
> > +	.vidioc_expbuf =3D v4l2_m2m_ioctl_expbuf,
> > +	.vidioc_dqbuf =3D v4l2_m2m_ioctl_dqbuf,
> > +	.vidioc_streamon =3D v4l2_m2m_ioctl_streamon,
> > +	.vidioc_streamoff =3D v4l2_m2m_ioctl_streamoff,
> > +
> > +	.vidioc_try_encoder_cmd =3D v4l2_m2m_ioctl_try_encoder_cmd,
> > +	.vidioc_encoder_cmd =3D wave5_vpu_enc_encoder_cmd,
> > +
> > +	.vidioc_subscribe_event =3D wave5_vpu_subscribe_event,
> > +	.vidioc_unsubscribe_event =3D v4l2_event_unsubscribe,
> > +};
> > +
> > +static int wave5_vpu_enc_s_ctrl(struct v4l2_ctrl *ctrl)
> > +{
> > +	struct vpu_instance *inst =3D wave5_ctrl_to_vpu_inst(ctrl);
> > +
> > +	dev_dbg(inst->dev->dev, "%s: name: %s | value: %d\n", __func__, ctrl-=
>name, ctrl->val);
> > +
> > +	switch (ctrl->id) {
> > +	case V4L2_CID_HFLIP:
> > +		inst->mirror_direction |=3D (ctrl->val << 1);
> > +		break;
> > +	case V4L2_CID_VFLIP:
> > +		inst->mirror_direction |=3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_ROTATE:
> > +		inst->rot_angle =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_VBV_SIZE:
> > +		inst->vbv_buf_size =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_BITRATE_MODE:
> > +		switch (ctrl->val) {
> > +		case V4L2_MPEG_VIDEO_BITRATE_MODE_VBR:
> > +			inst->rc_mode =3D 0;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_BITRATE_MODE_CBR:
> > +			inst->rc_mode =3D 1;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_BITRATE:
> > +		inst->bit_rate =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_GOP_SIZE:
> > +		inst->enc_param.avc_idr_period =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE:
> > +		inst->enc_param.independ_slice_mode =3D ctrl->val;
> > +		inst->enc_param.avc_slice_mode =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_MB:
> > +		inst->enc_param.independ_slice_mode_arg =3D ctrl->val;
> > +		inst->enc_param.avc_slice_arg =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE:
> > +		inst->rc_enable =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE:
> > +		inst->enc_param.mb_level_rc_enable =3D ctrl->val;
> > +		inst->enc_param.cu_level_rc_enable =3D ctrl->val;
> > +		inst->enc_param.hvs_qp_enable =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_PROFILE:
> > +		switch (ctrl->val) {
> > +		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN:
> > +			inst->enc_param.profile =3D HEVC_PROFILE_MAIN;
> > +			inst->bit_depth =3D 8;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_STILL_PICTURE:
> > +			inst->enc_param.profile =3D HEVC_PROFILE_STILLPICTURE;
> > +			inst->enc_param.en_still_picture =3D 1;
> > +			inst->bit_depth =3D 8;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10:
> > +			inst->enc_param.profile =3D HEVC_PROFILE_MAIN10;
> > +			inst->bit_depth =3D 10;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_LEVEL:
> > +		switch (ctrl->val) {
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_1:
> > +			inst->enc_param.level =3D 10 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_2:
> > +			inst->enc_param.level =3D 20 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_2_1:
> > +			inst->enc_param.level =3D 21 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_3:
> > +			inst->enc_param.level =3D 30 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_3_1:
> > +			inst->enc_param.level =3D 31 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_4:
> > +			inst->enc_param.level =3D 40 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_4_1:
> > +			inst->enc_param.level =3D 41 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5:
> > +			inst->enc_param.level =3D 50 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1:
> > +			inst->enc_param.level =3D 51 * 3;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LEVEL_5_2:
> > +			inst->enc_param.level =3D 52 * 3;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP:
> > +		inst->enc_param.min_qp_i =3D ctrl->val;
> > +		inst->enc_param.min_qp_p =3D ctrl->val;
> > +		inst->enc_param.min_qp_b =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP:
> > +		inst->enc_param.max_qp_i =3D ctrl->val;
> > +		inst->enc_param.max_qp_p =3D ctrl->val;
> > +		inst->enc_param.max_qp_b =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP:
> > +		inst->enc_param.intra_qp =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE:
> > +		switch (ctrl->val) {
> > +		case V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_DISABLED:
> > +			inst->enc_param.disable_deblk =3D 1;
> > +			inst->enc_param.sao_enable =3D 0;
> > +			inst->enc_param.lf_cross_slice_boundary_enable =3D 0;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_ENABLED:
> > +			inst->enc_param.disable_deblk =3D 0;
> > +			inst->enc_param.sao_enable =3D 1;
> > +			inst->enc_param.lf_cross_slice_boundary_enable =3D 1;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDAR=
Y:
> > +			inst->enc_param.disable_deblk =3D 0;
> > +			inst->enc_param.sao_enable =3D 1;
> > +			inst->enc_param.lf_cross_slice_boundary_enable =3D 0;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_LF_BETA_OFFSET_DIV2:
> > +		inst->enc_param.beta_offset_div2 =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_LF_TC_OFFSET_DIV2:
> > +		inst->enc_param.tc_offset_div2 =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_REFRESH_TYPE:
> > +		switch (ctrl->val) {
> > +		case V4L2_MPEG_VIDEO_HEVC_REFRESH_NONE:
> > +			inst->enc_param.decoding_refresh_type =3D 0;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_REFRESH_CRA:
> > +			inst->enc_param.decoding_refresh_type =3D 1;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_HEVC_REFRESH_IDR:
> > +			inst->enc_param.decoding_refresh_type =3D 2;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_REFRESH_PERIOD:
> > +		inst->enc_param.intra_period =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_LOSSLESS_CU:
> > +		inst->enc_param.lossless_enable =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_CONST_INTRA_PRED:
> > +		inst->enc_param.const_intra_pred_flag =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_WAVEFRONT:
> > +		inst->enc_param.wpp_enable =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_STRONG_SMOOTHING:
> > +		inst->enc_param.strong_intra_smooth_enable =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_MAX_NUM_MERGE_MV_MINUS1:
> > +		inst->enc_param.max_num_merge =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_HEVC_TMV_PREDICTION:
> > +		inst->enc_param.tmvp_enable =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_PROFILE:
> > +		switch (ctrl->val) {
> > +		case V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE:
> > +		case V4L2_MPEG_VIDEO_H264_PROFILE_CONSTRAINED_BASELINE:
> > +			inst->enc_param.profile =3D H264_PROFILE_BP;
> > +			inst->bit_depth =3D 8;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_PROFILE_MAIN:
> > +			inst->enc_param.profile =3D H264_PROFILE_MP;
> > +			inst->bit_depth =3D 8;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_PROFILE_EXTENDED:
> > +			inst->enc_param.profile =3D H264_PROFILE_EXTENDED;
> > +			inst->bit_depth =3D 8;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH:
> > +			inst->enc_param.profile =3D H264_PROFILE_HP;
> > +			inst->bit_depth =3D 8;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_10:
> > +			inst->enc_param.profile =3D H264_PROFILE_HIGH10;
> > +			inst->bit_depth =3D 10;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_422:
> > +			inst->enc_param.profile =3D H264_PROFILE_HIGH422;
> > +			inst->bit_depth =3D 10;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE:
> > +			inst->enc_param.profile =3D H264_PROFILE_HIGH444;
> > +			inst->bit_depth =3D 10;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_LEVEL:
> > +		switch (ctrl->val) {
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_1_0:
> > +			inst->enc_param.level =3D 10;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_1B:
> > +			inst->enc_param.level =3D 9;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_1_1:
> > +			inst->enc_param.level =3D 11;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_1_2:
> > +			inst->enc_param.level =3D 12;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_1_3:
> > +			inst->enc_param.level =3D 13;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_2_0:
> > +			inst->enc_param.level =3D 20;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_2_1:
> > +			inst->enc_param.level =3D 21;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_2_2:
> > +			inst->enc_param.level =3D 22;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_3_0:
> > +			inst->enc_param.level =3D 30;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_3_1:
> > +			inst->enc_param.level =3D 31;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_3_2:
> > +			inst->enc_param.level =3D 32;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_4_0:
> > +			inst->enc_param.level =3D 40;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_4_1:
> > +			inst->enc_param.level =3D 41;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_4_2:
> > +			inst->enc_param.level =3D 42;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_5_0:
> > +			inst->enc_param.level =3D 50;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LEVEL_5_1:
> > +			inst->enc_param.level =3D 51;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_MIN_QP:
> > +		inst->enc_param.min_qp_i =3D ctrl->val;
> > +		inst->enc_param.min_qp_p =3D ctrl->val;
> > +		inst->enc_param.min_qp_b =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_MAX_QP:
> > +		inst->enc_param.max_qp_i =3D ctrl->val;
> > +		inst->enc_param.max_qp_p =3D ctrl->val;
> > +		inst->enc_param.max_qp_b =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP:
> > +		inst->enc_param.intra_qp =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_MODE:
> > +		switch (ctrl->val) {
> > +		case V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED:
> > +			inst->enc_param.disable_deblk =3D 1;
> > +			inst->enc_param.lf_cross_slice_boundary_enable =3D 1;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_ENABLED:
> > +			inst->enc_param.disable_deblk =3D 0;
> > +			inst->enc_param.lf_cross_slice_boundary_enable =3D 1;
> > +			break;
> > +		case V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUNDAR=
Y:
> > +			inst->enc_param.disable_deblk =3D 0;
> > +			inst->enc_param.lf_cross_slice_boundary_enable =3D 0;
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA:
> > +		inst->enc_param.beta_offset_div2 =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA:
> > +		inst->enc_param.tc_offset_div2 =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM:
> > +		inst->enc_param.transform8x8_enable =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION:
> > +		inst->enc_param.const_intra_pred_flag =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET:
> > +		inst->enc_param.chroma_cb_qp_offset =3D ctrl->val;
> > +		inst->enc_param.chroma_cr_qp_offset =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_I_PERIOD:
> > +		inst->enc_param.intra_period =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE:
> > +		inst->enc_param.entropy_coding_mode =3D ctrl->val;
> > +		break;
> > +	case V4L2_CID_MIN_BUFFERS_FOR_OUTPUT:
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct v4l2_ctrl_ops wave5_vpu_enc_ctrl_ops =3D {
> > +	.s_ctrl =3D wave5_vpu_enc_s_ctrl,
> > +};
> > +
> > +static void wave5_set_enc_openparam(struct enc_open_param *open_param,
> > +				    struct vpu_instance *inst)
> > +{
> > +	struct enc_wave_param input =3D inst->enc_param;
> > +	u32 num_ctu_row =3D ALIGN(inst->dst_fmt.height, 64) / 64;
> > +	u32 num_mb_row =3D ALIGN(inst->dst_fmt.height, 16) / 16;
> > +
> > +	open_param->wave_param.gop_preset_idx =3D PRESET_IDX_IPP_SINGLE;
> > +	open_param->wave_param.hvs_qp_scale =3D 2;
> > +	open_param->wave_param.hvs_max_delta_qp =3D 10;
> > +	open_param->wave_param.skip_intra_trans =3D 1;
> > +	open_param->wave_param.intra_nx_n_enable =3D 1;
> > +	open_param->wave_param.nr_intra_weight_y =3D 7;
> > +	open_param->wave_param.nr_intra_weight_cb =3D 7;
> > +	open_param->wave_param.nr_intra_weight_cr =3D 7;
> > +	open_param->wave_param.nr_inter_weight_y =3D 4;
> > +	open_param->wave_param.nr_inter_weight_cb =3D 4;
> > +	open_param->wave_param.nr_inter_weight_cr =3D 4;
> > +	open_param->wave_param.rdo_skip =3D 1;
> > +	open_param->wave_param.lambda_scaling_enable =3D 1;
> > +
> > +	open_param->stream_endian =3D VPU_STREAM_ENDIAN;
> > +	open_param->source_endian =3D VPU_SOURCE_ENDIAN;
> > +	open_param->line_buf_int_en =3D true;
> > +	open_param->pic_width =3D inst->dst_fmt.width;
> > +	open_param->pic_height =3D inst->dst_fmt.height;
> > +	open_param->frame_rate_info =3D inst->frame_rate;
> > +	open_param->rc_enable =3D inst->rc_enable;
> > +	if (inst->rc_enable) {
> > +		open_param->wave_param.initial_rc_qp =3D -1;
> > +		open_param->wave_param.rc_weight_param =3D 16;
> > +		open_param->wave_param.rc_weight_buf =3D 128;
> > +	}
> > +	open_param->wave_param.mb_level_rc_enable =3D input.mb_level_rc_enabl=
e;
> > +	open_param->wave_param.cu_level_rc_enable =3D input.cu_level_rc_enabl=
e;
> > +	open_param->wave_param.hvs_qp_enable =3D input.hvs_qp_enable;
> > +	open_param->bit_rate =3D inst->bit_rate;
> > +	open_param->vbv_buffer_size =3D inst->vbv_buf_size;
> > +	if (inst->rc_mode =3D=3D 0)
> > +		open_param->vbv_buffer_size =3D 3000;
> > +	open_param->wave_param.profile =3D input.profile;
> > +	open_param->wave_param.en_still_picture =3D input.en_still_picture;
> > +	open_param->wave_param.level =3D input.level;
> > +	open_param->wave_param.internal_bit_depth =3D inst->bit_depth;
> > +	open_param->wave_param.intra_qp =3D input.intra_qp;
> > +	open_param->wave_param.min_qp_i =3D input.min_qp_i;
> > +	open_param->wave_param.max_qp_i =3D input.max_qp_i;
> > +	open_param->wave_param.min_qp_p =3D input.min_qp_p;
> > +	open_param->wave_param.max_qp_p =3D input.max_qp_p;
> > +	open_param->wave_param.min_qp_b =3D input.min_qp_b;
> > +	open_param->wave_param.max_qp_b =3D input.max_qp_b;
> > +	open_param->wave_param.disable_deblk =3D input.disable_deblk;
> > +	open_param->wave_param.lf_cross_slice_boundary_enable =3D
> > +		input.lf_cross_slice_boundary_enable;
> > +	open_param->wave_param.tc_offset_div2 =3D input.tc_offset_div2;
> > +	open_param->wave_param.beta_offset_div2 =3D input.beta_offset_div2;
> > +	open_param->wave_param.decoding_refresh_type =3D input.decoding_refre=
sh_type;
> > +	open_param->wave_param.intra_period =3D input.intra_period;
> > +	if (inst->std =3D=3D W_HEVC_ENC) {
> > +		if (input.intra_period =3D=3D 0) {
> > +			open_param->wave_param.decoding_refresh_type =3D DEC_REFRESH_TYPE_I=
DR;
> > +			open_param->wave_param.intra_period =3D input.avc_idr_period;
> > +		}
> > +	} else {
> > +		open_param->wave_param.avc_idr_period =3D input.avc_idr_period;
> > +	}
> > +	open_param->wave_param.entropy_coding_mode =3D input.entropy_coding_m=
ode;
> > +	open_param->wave_param.lossless_enable =3D input.lossless_enable;
> > +	open_param->wave_param.const_intra_pred_flag =3D input.const_intra_pr=
ed_flag;
> > +	open_param->wave_param.wpp_enable =3D input.wpp_enable;
> > +	open_param->wave_param.strong_intra_smooth_enable =3D input.strong_in=
tra_smooth_enable;
> > +	open_param->wave_param.max_num_merge =3D input.max_num_merge;
> > +	open_param->wave_param.tmvp_enable =3D input.tmvp_enable;
> > +	open_param->wave_param.transform8x8_enable =3D input.transform8x8_ena=
ble;
> > +	open_param->wave_param.chroma_cb_qp_offset =3D input.chroma_cb_qp_off=
set;
> > +	open_param->wave_param.chroma_cr_qp_offset =3D input.chroma_cr_qp_off=
set;
> > +	open_param->wave_param.independ_slice_mode =3D input.independ_slice_m=
ode;
> > +	open_param->wave_param.independ_slice_mode_arg =3D input.independ_sli=
ce_mode_arg;
> > +	open_param->wave_param.avc_slice_mode =3D input.avc_slice_mode;
> > +	open_param->wave_param.avc_slice_arg =3D input.avc_slice_arg;
> > +	open_param->wave_param.intra_mb_refresh_mode =3D input.intra_mb_refre=
sh_mode;
> > +	if (input.intra_mb_refresh_mode !=3D REFRESH_MB_MODE_NONE) {
> > +		if (num_mb_row >=3D input.intra_mb_refresh_arg)
> > +			open_param->wave_param.intra_mb_refresh_arg =3D
> > +				num_mb_row / input.intra_mb_refresh_arg;
> > +		else
> > +			open_param->wave_param.intra_mb_refresh_arg =3D num_mb_row;
> > +	}
> > +	open_param->wave_param.intra_refresh_mode =3D input.intra_refresh_mod=
e;
> > +	if (input.intra_refresh_mode !=3D 0) {
> > +		if (num_ctu_row >=3D input.intra_refresh_arg)
> > +			open_param->wave_param.intra_refresh_arg =3D
> > +				num_ctu_row / input.intra_refresh_arg;
> > +		else
> > +			open_param->wave_param.intra_refresh_arg =3D num_ctu_row;
> > +	}
> > +}
> > +
> > +static int wave5_vpu_enc_queue_setup(struct vb2_queue *q, unsigned int=
 *num_buffers,
> > +				     unsigned int *num_planes, unsigned int sizes[],
> > +				     struct device *alloc_devs[])
> > +{
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
> > +	struct v4l2_pix_format_mplane inst_format =3D
> > +		(q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) ? inst->src_fmt :=
 inst->dst_fmt;
> > +	unsigned int i;
> > +	int ret;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: num_buffers: %u | num_planes: %u | type:=
 %u\n", __func__,
> > +		*num_buffers, *num_planes, q->type);
> > +
> > +	if (*num_planes) {
> > +		if (inst_format.num_planes !=3D *num_planes)
> > +			return -EINVAL;
> > +
> > +		for (i =3D 0; i < *num_planes; i++) {
> > +			if (sizes[i] < inst_format.plane_fmt[i].sizeimage)
> > +				return -EINVAL;
> > +		}
> > +	} else {
> > +		*num_planes =3D inst_format.num_planes;
> > +		for (i =3D 0; i < *num_planes; i++) {
> > +			sizes[i] =3D inst_format.plane_fmt[i].sizeimage;
> > +			dev_dbg(inst->dev->dev, "%s: size[%u]: %u\n", __func__, i, sizes[i]=
);
> > +		}
> > +	}
> > +
> > +	dev_dbg(inst->dev->dev, "%s: size: %u\n", __func__, sizes[0]);
> > +
>=20
> Same concerns here as for the queue_setup in the decoder.
>=20
> > +	if (inst->state =3D=3D VPU_INST_STATE_NONE && q->type =3D=3D V4L2_BUF=
_TYPE_VIDEO_OUTPUT_MPLANE) {
> > +		unsigned int non_linear_num =3D 0;
> > +		u32 fb_stride =3D 0;
> > +		u32 fb_height =3D 0;
> > +		struct enc_open_param open_param;
> > +		struct enc_initial_info initial_info;
> > +		struct v4l2_ctrl *ctrl;
> > +
> > +		memset(&open_param, 0, sizeof(struct enc_open_param));
> > +
> > +		inst->std =3D wave5_to_vpu_wavestd(inst->dst_fmt.pixelformat);
> > +		if (inst->std =3D=3D STD_UNKNOWN) {
> > +			dev_warn(inst->dev->dev, "unsupported pixelformat: %.4s\n",
> > +				 (char *)&inst->dst_fmt.pixelformat);
> > +			return -EINVAL;
> > +		}
> > +
> > +		wave5_set_enc_openparam(&open_param, inst);
> > +
> > +		ret =3D wave5_vpu_enc_open(inst, &open_param);
> > +		if (ret) {
> > +			dev_dbg(inst->dev->dev, "%s: wave5_vpu_enc_open, fail: %d\n",
> > +				__func__, ret);
> > +			return ret;
> > +		}
> > +
> > +		inst->state =3D VPU_INST_STATE_OPEN;
> > +
> > +		if (inst->mirror_direction) {
> > +			wave5_vpu_enc_give_command(inst, ENABLE_MIRRORING, NULL);
> > +			wave5_vpu_enc_give_command(inst, SET_MIRROR_DIRECTION,
> > +						   &inst->mirror_direction);
> > +		}
> > +		if (inst->rot_angle) {
> > +			wave5_vpu_enc_give_command(inst, ENABLE_ROTATION, NULL);
> > +			wave5_vpu_enc_give_command(inst, SET_ROTATION_ANGLE, &inst->rot_ang=
le);
> > +		}
> > +
> > +		ret =3D wave5_vpu_enc_issue_seq_init(inst);
> > +		if (ret) {
> > +			dev_dbg(inst->dev->dev, "%s: wave5_vpu_enc_issue_seq_init, fail: %d=
\n",
> > +				__func__, ret);
> > +			return ret;
> > +		}
> > +
> > +		if (wave5_vpu_wait_interrupt(inst, VPU_ENC_TIMEOUT) < 0) {
> > +			dev_dbg(inst->dev->dev, "%s: wave5_vpu_wait_interrupt failed\n", __=
func__);
> > +			return -EINVAL;
> > +		}
> > +
> > +		ret =3D wave5_vpu_enc_complete_seq_init(inst, &initial_info);
> > +		if (ret)
> > +			return ret;
> > +
> > +		dev_dbg(inst->dev->dev, "%s: min_frame_buffer: %u | min_source_buffe=
r: %u\n",
> > +			__func__, initial_info.min_frame_buffer_count,
> > +			initial_info.min_src_frame_count);
> > +		inst->state =3D VPU_INST_STATE_INIT_SEQ;
> > +		inst->min_src_buf_count =3D initial_info.min_src_frame_count +
> > +					  COMMAND_QUEUE_DEPTH;
> > +
> > +		ctrl =3D v4l2_ctrl_find(&inst->v4l2_ctrl_hdl,
> > +				      V4L2_CID_MIN_BUFFERS_FOR_OUTPUT);
> > +		if (ctrl)
> > +			v4l2_ctrl_s_ctrl(ctrl, inst->min_src_buf_count);
> > +
> > +		inst->min_dst_buf_count =3D initial_info.min_frame_buffer_count;
> > +		inst->src_buf_count =3D inst->min_src_buf_count;
> > +
> > +		if (*num_buffers > inst->src_buf_count)
> > +			inst->src_buf_count =3D *num_buffers;
> > +
> > +		*num_buffers =3D inst->src_buf_count;
> > +		non_linear_num =3D inst->min_dst_buf_count;
> > +
> > +		fb_stride =3D ALIGN(inst->dst_fmt.width, 32);
> > +		fb_height =3D ALIGN(inst->dst_fmt.height, 32);
> > +
> > +		for (i =3D 0; i < non_linear_num; i++) {
> > +			u32 luma_size =3D fb_stride * fb_height;
> > +			u32 chroma_size =3D ALIGN(fb_stride / 2, 16) * fb_height;
> > +
> > +			inst->frame_vbuf[i].size =3D luma_size + chroma_size;
> > +			ret =3D wave5_vdi_allocate_dma_memory(inst->dev, &inst->frame_vbuf[=
i]);
> > +			if (ret < 0) {
> > +				dev_dbg(inst->dev->dev, "%s: failed to allocate FBC buffer %zu\n",
> > +					__func__, inst->frame_vbuf[i].size);
> > +				goto free_buffers;
> > +			}
> > +
> > +			inst->frame_buf[i].buf_y =3D inst->frame_vbuf[i].daddr;
> > +			inst->frame_buf[i].buf_cb =3D (dma_addr_t)-1;
> > +			inst->frame_buf[i].buf_cr =3D (dma_addr_t)-1;
> > +			inst->frame_buf[i].update_fb_info =3D true;
> > +			inst->frame_buf[i].size =3D inst->frame_vbuf[i].size;
> > +		}
> > +
> > +		ret =3D wave5_vpu_enc_register_frame_buffer(inst, non_linear_num, fb=
_stride,
> > +							  fb_height, COMPRESSED_FRAME_MAP);
> > +		if (ret) {
> > +			dev_dbg(inst->dev->dev,
> > +				"%s: wave5_vpu_enc_register_frame_buffer, fail: %d\n",
> > +				__func__, ret);
> > +			goto free_buffers;
> > +		}
> > +
> > +		inst->state =3D VPU_INST_STATE_PIC_RUN;
> > +	}
> > +
> > +	if (inst->state =3D=3D VPU_INST_STATE_INIT_SEQ &&
> > +	    q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > +		*num_buffers =3D inst->src_buf_count;
> > +		dev_dbg(inst->dev->dev, "%s: src buf num: %u", __func__, *num_buffer=
s);
> > +	}
> > +
> > +	return 0;
> > +
> > +free_buffers:
> > +	for (i =3D 0; i < inst->min_dst_buf_count; i++)
> > +		wave5_vdi_free_dma_memory(inst->dev, &inst->frame_vbuf[i]);
> > +	return ret;
> > +}
> > +
> > +static void wave5_vpu_enc_buf_queue(struct vb2_buffer *vb)
> > +{
> > +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(vb->vb2_queue);
> > +	struct vpu_buffer *vpu_buf =3D wave5_to_vpu_buf(vbuf);
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %4u index: %4u size: ([0]=3D%4lu, =
[1]=3D%4lu, [2]=3D%4lu)\n",
> > +		__func__, vb->type, vb->index, vb2_plane_size(&vbuf->vb2_buf, 0),
> > +		vb2_plane_size(&vbuf->vb2_buf, 1), vb2_plane_size(&vbuf->vb2_buf, 2)=
);
> > +
> > +	if (vb->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE)
> > +		vbuf->sequence =3D inst->queued_src_buf_num++;
> > +	else
> > +		vbuf->sequence =3D inst->queued_dst_buf_num++;
> > +
> > +	vpu_buf->consumed =3D FALSE;
> > +	v4l2_m2m_buf_queue(inst->v4l2_fh.m2m_ctx, vbuf);
> > +
> > +	if (vb2_start_streaming_called(vb->vb2_queue))
> > +		inst->ops->start_process(inst);
> > +}
> > +
> > +static void wave5_vpu_enc_stop_streaming(struct vb2_queue *q)
> > +{
> > +	struct vpu_instance *inst =3D vb2_get_drv_priv(q);
> > +	struct vb2_v4l2_buffer *buf;
> > +	bool check_cmd =3D true;
> > +
> > +	dev_dbg(inst->dev->dev, "%s: type: %u\n", __func__, q->type);
> > +
> > +	if (wave5_vpu_both_queues_are_streaming(inst))
> > +		inst->state =3D VPU_INST_STATE_STOP;
> > +
> > +	while (check_cmd) {
> > +		struct queue_status_info q_status;
> > +		struct enc_output_info enc_output_info;
> > +
> > +		wave5_vpu_enc_give_command(inst, ENC_GET_QUEUE_STATUS, &q_status);
> > +
> > +		if (q_status.instance_queue_count + q_status.report_queue_count =3D=
=3D 0)
> > +			break;
> > +
> > +		if (wave5_vpu_wait_interrupt(inst, VPU_ENC_TIMEOUT) < 0)
> > +			break;
> > +
> > +		if (wave5_vpu_enc_get_output_info(inst, &enc_output_info))
> > +			dev_dbg(inst->dev->dev, "Getting encoding results from fw, fail\n")=
;
> > +	}
> > +
> > +	if (q->type =3D=3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE) {
> > +		while ((buf =3D v4l2_m2m_src_buf_remove(inst->v4l2_fh.m2m_ctx))) {
> > +			dev_dbg(inst->dev->dev, "%s: buf type %4u | index %4u\n",
> > +				__func__, buf->vb2_buf.type, buf->vb2_buf.index);
> > +			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
> > +		}
> > +	} else {
> > +		while ((buf =3D v4l2_m2m_dst_buf_remove(inst->v4l2_fh.m2m_ctx))) {
> > +			dev_dbg(inst->dev->dev, "%s: buf type %4u | index %4u\n",
> > +				__func__, buf->vb2_buf.type, buf->vb2_buf.index);
> > +			vb2_set_plane_payload(&buf->vb2_buf, 0, 0);
> > +			v4l2_m2m_buf_done(buf, VB2_BUF_STATE_ERROR);
> > +		}
> > +	}
> > +}
> > +
> > +static const struct vb2_ops wave5_vpu_enc_vb2_ops =3D {
> > +	.queue_setup =3D wave5_vpu_enc_queue_setup,
> > +	.wait_prepare =3D vb2_ops_wait_prepare,
> > +	.wait_finish =3D vb2_ops_wait_finish,
> > +	.buf_queue =3D wave5_vpu_enc_buf_queue,
> > +	.stop_streaming =3D wave5_vpu_enc_stop_streaming,
> > +};
> > +
> > +static void wave5_set_default_format(struct v4l2_pix_format_mplane *sr=
c_fmt,
> > +				     struct v4l2_pix_format_mplane *dst_fmt)
> > +{
> > +	unsigned int src_pix_fmt =3D enc_fmt_list[VPU_FMT_TYPE_RAW][0].v4l2_p=
ix_fmt;
> > +	const struct v4l2_format_info *src_fmt_info =3D v4l2_format_info(src_=
pix_fmt);
> > +
> > +	src_fmt->pixelformat =3D src_pix_fmt;
> > +	src_fmt->field =3D V4L2_FIELD_NONE;
> > +	src_fmt->flags =3D 0;
> > +	src_fmt->num_planes =3D src_fmt_info->mem_planes;
> > +	wave5_update_pix_fmt(src_fmt, 416, 240);
> > +
> > +	dst_fmt->pixelformat =3D enc_fmt_list[VPU_FMT_TYPE_CODEC][0].v4l2_pix=
_fmt;
> > +	dst_fmt->field =3D V4L2_FIELD_NONE;
> > +	dst_fmt->flags =3D 0;
> > +	dst_fmt->num_planes =3D 1;
> > +	wave5_update_pix_fmt(dst_fmt, 416, 240);
> > +}
> > +
> > +static int wave5_vpu_enc_queue_init(void *priv, struct vb2_queue *src_=
vq, struct vb2_queue *dst_vq)
> > +{
> > +	return wave5_vpu_queue_init(priv, src_vq, dst_vq, &wave5_vpu_enc_vb2_=
ops);
> > +}
> > +
> > +static const struct vpu_instance_ops wave5_vpu_enc_inst_ops =3D {
> > +	.start_process =3D wave5_vpu_enc_start_encode,
> > +	.stop_process =3D wave5_vpu_enc_stop_encode,
> > +	.finish_process =3D wave5_vpu_enc_finish_encode,
> > +};
> > +
> > +static void wave5_vpu_enc_device_run(void *priv)
> > +{
> > +	struct vpu_instance *inst =3D priv;
> > +
> > +	inst->ops->start_process(inst);
> > +}
> > +
> > +static int wave5_vpu_enc_job_ready(void *priv)
> > +{
> > +	struct vpu_instance *inst =3D priv;
> > +
> > +	if (inst->state =3D=3D VPU_INST_STATE_STOP)
> > +		return 0;
> > +
> > +	return 1;
> > +}
> > +
> > +static void wave5_vpu_enc_job_abort(void *priv)
> > +{
> > +	struct vpu_instance *inst =3D priv;
> > +
> > +	inst->ops->stop_process(inst);
> > +}
> > +
> > +static const struct v4l2_m2m_ops wave5_vpu_enc_m2m_ops =3D {
> > +	.device_run =3D wave5_vpu_enc_device_run,
> > +	.job_ready =3D wave5_vpu_enc_job_ready,
> > +	.job_abort =3D wave5_vpu_enc_job_abort,
> > +};
> > +
> > +static int wave5_vpu_open_enc(struct file *filp)
> > +{
> > +	struct video_device *vdev =3D video_devdata(filp);
> > +	struct vpu_device *dev =3D video_drvdata(filp);
> > +	struct vpu_instance *inst =3D NULL;
> > +	struct v4l2_ctrl_handler *v4l2_ctrl_hdl;
> > +	int ret =3D 0;
> > +
> > +	inst =3D kzalloc(sizeof(*inst), GFP_KERNEL);
> > +	if (!inst)
> > +		return -ENOMEM;
> > +	v4l2_ctrl_hdl =3D &inst->v4l2_ctrl_hdl;
> > +
> > +	inst->dev =3D dev;
> > +	inst->type =3D VPU_INST_TYPE_ENC;
> > +	inst->ops =3D &wave5_vpu_enc_inst_ops;
> > +
> > +	v4l2_fh_init(&inst->v4l2_fh, vdev);
> > +	filp->private_data =3D &inst->v4l2_fh;
> > +	v4l2_fh_add(&inst->v4l2_fh);
> > +
> > +	INIT_LIST_HEAD(&inst->list);
> > +	list_add_tail(&inst->list, &dev->instances);
> > +
> > +	inst->v4l2_m2m_dev =3D v4l2_m2m_init(&wave5_vpu_enc_m2m_ops);
> > +	if (IS_ERR(inst->v4l2_m2m_dev)) {
> > +		ret =3D PTR_ERR(inst->v4l2_m2m_dev);
> > +		dev_err(inst->dev->dev, "v4l2_m2m_init, fail: %d\n", ret);
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	inst->v4l2_fh.m2m_ctx =3D
> > +		v4l2_m2m_ctx_init(inst->v4l2_m2m_dev, inst, wave5_vpu_enc_queue_init=
);
> > +	if (IS_ERR(inst->v4l2_fh.m2m_ctx)) {
> > +		ret =3D PTR_ERR(inst->v4l2_fh.m2m_ctx);
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	v4l2_ctrl_handler_init(v4l2_ctrl_hdl, 50);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_HEVC_PROFILE,
> > +			       V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN_10, 0,
> > +			       V4L2_MPEG_VIDEO_HEVC_PROFILE_MAIN);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_HEVC_LEVEL,
> > +			       V4L2_MPEG_VIDEO_HEVC_LEVEL_5_1, 0,
> > +			       V4L2_MPEG_VIDEO_HEVC_LEVEL_1);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_MIN_QP,
> > +			  0, 63, 1, 8);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_MAX_QP,
> > +			  0, 63, 1, 51);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_I_FRAME_QP,
> > +			  0, 63, 1, 30);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE,
> > +			       V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUN=
DARY, 0,
> > +			       V4L2_MPEG_VIDEO_HEVC_LOOP_FILTER_MODE_ENABLED);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_LF_BETA_OFFSET_DIV2,
> > +			  -6, 6, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_LF_TC_OFFSET_DIV2,
> > +			  -6, 6, 1, 0);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_HEVC_REFRESH_TYPE,
> > +			       V4L2_MPEG_VIDEO_HEVC_REFRESH_IDR, 0,
> > +			       V4L2_MPEG_VIDEO_HEVC_REFRESH_CRA);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_REFRESH_PERIOD,
> > +			  0, 2047, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_LOSSLESS_CU,
> > +			  0, 1, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_CONST_INTRA_PRED,
> > +			  0, 1, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_WAVEFRONT,
> > +			  0, 1, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_STRONG_SMOOTHING,
> > +			  0, 1, 1, 1);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_MAX_NUM_MERGE_MV_MINUS1,
> > +			  1, 2, 1, 2);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_HEVC_TMV_PREDICTION,
> > +			  0, 1, 1, 1);
> > +
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_H264_PROFILE,
> > +			       V4L2_MPEG_VIDEO_H264_PROFILE_HIGH_444_PREDICTIVE, 0,
> > +			       V4L2_MPEG_VIDEO_H264_PROFILE_BASELINE);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_H264_LEVEL,
> > +			       V4L2_MPEG_VIDEO_H264_LEVEL_5_1, 0,
> > +			       V4L2_MPEG_VIDEO_H264_LEVEL_1_0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_MIN_QP,
> > +			  0, 63, 1, 8);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_MAX_QP,
> > +			  0, 63, 1, 51);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_I_FRAME_QP,
> > +			  0, 63, 1, 30);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_MODE,
> > +			       V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_DISABLED_AT_SLICE_BOUN=
DARY, 0,
> > +			       V4L2_MPEG_VIDEO_H264_LOOP_FILTER_MODE_ENABLED);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_ALPHA,
> > +			  -6, 6, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_LOOP_FILTER_BETA,
> > +			  -6, 6, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_8X8_TRANSFORM,
> > +			  0, 1, 1, 1);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_CONSTRAINED_INTRA_PREDICTION,
> > +			  0, 1, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_CHROMA_QP_INDEX_OFFSET,
> > +			  -12, 12, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_H264_I_PERIOD,
> > +			  0, 2047, 1, 0);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_H264_ENTROPY_MODE,
> > +			       V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CABAC, 0,
> > +			       V4L2_MPEG_VIDEO_H264_ENTROPY_MODE_CAVLC);
> > +
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_HFLIP,
> > +			  0, 1, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_VFLIP,
> > +			  0, 1, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_ROTATE,
> > +			  0, 270, 90, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_VBV_SIZE,
> > +			  10, 3000, 1, 3000);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_BITRATE_MODE,
> > +			       V4L2_MPEG_VIDEO_BITRATE_MODE_CBR, 0,
> > +			       V4L2_MPEG_VIDEO_BITRATE_MODE_CBR);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_BITRATE,
> > +			  0, 700000000, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_GOP_SIZE,
> > +			  0, 2047, 1, 0);
> > +	v4l2_ctrl_new_std_menu(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			       V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MODE,
> > +			       V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_MAX_MB, 0,
> > +			       V4L2_MPEG_VIDEO_MULTI_SLICE_MODE_SINGLE);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_MULTI_SLICE_MAX_MB,
> > +			  0, 0xFFFF, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_FRAME_RC_ENABLE,
> > +			  0, 1, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MPEG_VIDEO_MB_RC_ENABLE,
> > +			  0, 1, 1, 0);
> > +	v4l2_ctrl_new_std(v4l2_ctrl_hdl, &wave5_vpu_enc_ctrl_ops,
> > +			  V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 1);
> > +
> > +	if (v4l2_ctrl_hdl->error) {
> > +		ret =3D -ENODEV;
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	inst->v4l2_fh.ctrl_handler =3D v4l2_ctrl_hdl;
> > +	v4l2_ctrl_handler_setup(v4l2_ctrl_hdl);
> > +
> > +	wave5_set_default_format(&inst->src_fmt, &inst->dst_fmt);
> > +	inst->colorspace =3D V4L2_COLORSPACE_REC709;
> > +	inst->ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
> > +	inst->hsv_enc =3D 0;
> > +	inst->quantization =3D V4L2_QUANTIZATION_DEFAULT;
> > +	inst->xfer_func =3D V4L2_XFER_FUNC_DEFAULT;
> > +	inst->frame_rate =3D 30;
> > +
> > +	init_completion(&inst->irq_done);
> > +	ret =3D kfifo_alloc(&inst->irq_status, 16 * sizeof(int), GFP_KERNEL);
> > +	if (ret) {
> > +		dev_err(inst->dev->dev, "Allocating fifo, fail: %d\n", ret);
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	inst->id =3D ida_alloc(&inst->dev->inst_ida, GFP_KERNEL);
> > +	if (inst->id < 0) {
> > +		dev_warn(inst->dev->dev, "Allocating instance ID, fail: %d\n", inst-=
>id);
> > +		ret =3D inst->id;
> > +		goto cleanup_inst;
> > +	}
> > +
> > +	return 0;
> > +
> > +cleanup_inst:
> > +	wave5_cleanup_instance(inst);
> > +	return ret;
> > +}
> > +
> > +static int wave5_vpu_enc_release(struct file *filp)
> > +{
> > +	return wave5_vpu_release_device(filp, wave5_vpu_enc_close, "encoder")=
;
> > +}
> > +
> > +static const struct v4l2_file_operations wave5_vpu_enc_fops =3D {
> > +	.owner =3D THIS_MODULE,
> > +	.open =3D wave5_vpu_open_enc,
> > +	.release =3D wave5_vpu_enc_release,
> > +	.unlocked_ioctl =3D video_ioctl2,
> > +	.poll =3D v4l2_m2m_fop_poll,
> > +	.mmap =3D v4l2_m2m_fop_mmap,
> > +};
> > +
> > +int wave5_vpu_enc_register_device(struct vpu_device *dev)
> > +{
> > +	struct video_device *vdev_enc;
> > +	int ret;
> > +
> > +	vdev_enc =3D devm_kzalloc(dev->v4l2_dev.dev, sizeof(*vdev_enc), GFP_K=
ERNEL);
> > +	if (!vdev_enc)
> > +		return -ENOMEM;
> > +
> > +	dev->video_dev_enc =3D vdev_enc;
> > +
> > +	strscpy(vdev_enc->name, VPU_ENC_DEV_NAME, sizeof(vdev_enc->name));
> > +	vdev_enc->fops =3D &wave5_vpu_enc_fops;
> > +	vdev_enc->ioctl_ops =3D &wave5_vpu_enc_ioctl_ops;
> > +	vdev_enc->release =3D video_device_release_empty;
> > +	vdev_enc->v4l2_dev =3D &dev->v4l2_dev;
> > +	vdev_enc->vfl_dir =3D VFL_DIR_M2M;
> > +	vdev_enc->device_caps =3D V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAM=
ING;
> > +	vdev_enc->lock =3D &dev->dev_lock;
> > +
> > +	ret =3D video_register_device(vdev_enc, VFL_TYPE_VIDEO, -1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	video_set_drvdata(vdev_enc, dev);
> > +
> > +	return 0;
> > +}
> > +
> > +void wave5_vpu_enc_unregister_device(struct vpu_device *dev)
> > +{
> > +	video_unregister_device(dev->video_dev_enc);
> > +}
> > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.c b/dri=
vers/media/platform/chips-media/wave5/wave5-vpu.c
> > new file mode 100644
> > index 000000000000..9c602168cffc
> > --- /dev/null
> > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.c
> > @@ -0,0 +1,362 @@
> > +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> > +/*
> > + * Wave5 series multi-standard codec IP - platform driver
> > + *
> > + * Copyright (C) 2021 CHIPS&MEDIA INC
> > + */
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/clk.h>
> > +#include <linux/of_address.h>
> > +#include <linux/firmware.h>
> > +#include <linux/interrupt.h>
> > +#include "wave5-vpu.h"
> > +#include "wave5-regdefine.h"
> > +#include "wave5-vpuconfig.h"
> > +#include "wave5.h"
> > +
> > +#define VPU_PLATFORM_DEVICE_NAME "vdec"
> > +#define VPU_CLK_NAME "vcodec"
> > +
> > +#define WAVE5_IS_ENC BIT(0)
> > +#define WAVE5_IS_DEC BIT(1)
> > +
> > +struct wave5_match_data {
> > +	int flags;
> > +	const char *fw_name;
> > +};
> > +
> > +int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int t=
imeout)
> > +{
> > +	int ret;
> > +
> > +	ret =3D wait_for_completion_timeout(&inst->irq_done,
> > +					  msecs_to_jiffies(timeout));
> > +	if (!ret)
> > +		return -ETIMEDOUT;
> > +
> > +	reinit_completion(&inst->irq_done);
> > +
> > +	return 0;
> > +}
> > +
> > +static void wave5_vpu_get_interrupt_for_inst(struct vpu_instance *inst=
, u32 status)
> > +{
> > +	struct vpu_device *dev =3D inst->dev;
> > +	u32 seq_done;
> > +	u32 cmd_done;
> > +	int val;
> > +
> > +	seq_done =3D wave5_vdi_readl(dev, W5_RET_SEQ_DONE_INSTANCE_INFO);
> > +	cmd_done =3D wave5_vdi_readl(dev, W5_RET_QUEUE_CMD_DONE_INST);
> > +
> > +	if (status & BIT(INT_WAVE5_INIT_SEQ)) {
> > +		if (seq_done & BIT(inst->id)) {
> > +			seq_done &=3D ~BIT(inst->id);
> > +			wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO, seq_do=
ne);
> > +			val =3D BIT(INT_WAVE5_INIT_SEQ);
> > +			kfifo_in(&inst->irq_status, &val, sizeof(int));
> > +		}
> > +	}
> > +	if (status & BIT(INT_WAVE5_ENC_SET_PARAM)) {
> > +		if (seq_done & BIT(inst->id)) {
> > +			seq_done &=3D ~BIT(inst->id);
> > +			wave5_vdi_write_register(dev, W5_RET_SEQ_DONE_INSTANCE_INFO, seq_do=
ne);
> > +			val =3D BIT(INT_WAVE5_ENC_SET_PARAM);
> > +			kfifo_in(&inst->irq_status, &val, sizeof(int));
> > +		}
> > +	}
> > +	if (status & BIT(INT_WAVE5_DEC_PIC) ||
> > +	    status & BIT(INT_WAVE5_ENC_PIC)) {
> > +		if (cmd_done & BIT(inst->id)) {
> > +			cmd_done &=3D ~BIT(inst->id);
> > +			wave5_vdi_write_register(dev, W5_RET_QUEUE_CMD_DONE_INST, cmd_done)=
;
> > +			val =3D BIT(INT_WAVE5_DEC_PIC);
> > +			kfifo_in(&inst->irq_status, &val, sizeof(int));
> > +		}
> > +	}
> > +}
> > +
> > +static irqreturn_t wave5_vpu_irq(int irq, void *dev_id)
> > +{
> > +	struct vpu_device *dev =3D dev_id;
> > +
> > +	if (wave5_vdi_readl(dev, W5_VPU_VPU_INT_STS)) {
> > +		struct vpu_instance *inst;
> > +		u32 irq_status =3D wave5_vdi_readl(dev, W5_VPU_VINT_REASON);
> > +
> > +		list_for_each_entry(inst, &dev->instances, list) {
> > +			wave5_vpu_get_interrupt_for_inst(inst, irq_status);
> > +		}
> > +
> > +		wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_CLR, irq_status);
> > +		wave5_vdi_write_register(dev, W5_VPU_VINT_CLEAR, 0x1);
> > +
> > +		return IRQ_WAKE_THREAD;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static irqreturn_t wave5_vpu_irq_thread(int irq, void *dev_id)
> > +{
> > +	struct vpu_device *dev =3D dev_id;
> > +	struct vpu_instance *inst;
> > +	int irq_status, ret;
> > +	u32 val;
> > +
> > +	list_for_each_entry(inst, &dev->instances, list) {
> > +		while (kfifo_len(&inst->irq_status)) {
> > +			struct vpu_instance *curr;
> > +
> > +			curr =3D v4l2_m2m_get_curr_priv(inst->v4l2_m2m_dev);
> > +			if (curr) {
> > +				inst->ops->finish_process(inst);
> > +			} else {
> > +				ret =3D kfifo_out(&inst->irq_status, &irq_status, sizeof(int));
> > +				if (!ret)
> > +					break;
> > +
> > +				val =3D wave5_vdi_readl(dev, W5_VPU_VINT_REASON_USR);
> > +				val &=3D ~irq_status;
> > +				wave5_vdi_write_register(dev, W5_VPU_VINT_REASON_USR, val);
> > +				complete(&inst->irq_done);
> > +			}
> > +		}
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +static int wave5_vpu_load_firmware(struct device *dev, const char *fw_=
name)
> > +{
> > +	const struct firmware *fw;
> > +	int ret;
> > +	u32 revision;
> > +	unsigned int product_id;
> > +
> > +	ret =3D request_firmware(&fw, fw_name, dev);
> > +	if (ret) {
> > +		dev_err(dev, "request_firmware, fail: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret =3D wave5_vpu_init_with_bitcode(dev, (u8 *)fw->data, fw->size);
> > +	if (ret) {
> > +		dev_err(dev, "vpu_init_with_bitcode, fail: %d\n", ret);
> > +		goto release_fw;
> > +	}
> > +	release_firmware(fw);
> > +
> > +	ret =3D wave5_vpu_get_version_info(dev, &revision, &product_id);
> > +	if (ret) {
> > +		dev_err(dev, "vpu_get_version_info fail: %d\n", ret);
> > +		goto err_without_release;
> > +	}
> > +
> > +	dev_dbg(dev, "%s: enum product_id: %08x, fw revision: %u\n",
> > +		__func__, product_id, revision);
> > +
> > +	return 0;
> > +
> > +release_fw:
> > +	release_firmware(fw);
> > +err_without_release:
> > +	return ret;
> > +}
> > +
> > +static int wave5_vpu_probe(struct platform_device *pdev)
> > +{
> > +	int ret;
> > +	struct vpu_device *dev;
> > +	struct device_node *np;
> > +	const struct wave5_match_data *match_data;
> > +	struct resource sram;
> > +
> > +	match_data =3D device_get_match_data(&pdev->dev);
> > +	if (!match_data) {
> > +		dev_err(&pdev->dev, "missing device match data\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* physical addresses limited to 32 bits */
> > +	dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +	dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
> > +
> > +	dev =3D devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> > +	if (!dev)
> > +		return -ENOMEM;
> > +
> > +	dev->vdb_register =3D devm_platform_ioremap_resource(pdev, 0);
> > +	if (IS_ERR(dev->vdb_register))
> > +		return PTR_ERR(dev->vdb_register);
> > +	ida_init(&dev->inst_ida);
> > +
> > +	mutex_init(&dev->dev_lock);
> > +	mutex_init(&dev->hw_lock);
> > +	dev_set_drvdata(&pdev->dev, dev);
> > +	dev->dev =3D &pdev->dev;
> > +
> > +	ret =3D devm_clk_bulk_get_all(&pdev->dev, &dev->clks);
> > +
> > +	/* continue without clock, assume externally managed */
> > +	if (ret < 0) {
> > +		dev_warn(&pdev->dev, "Getting clocks, fail: %d\n", ret);
> > +		ret =3D 0;
> > +	}
> > +	dev->num_clks =3D ret;
> > +
> > +	ret =3D clk_bulk_prepare_enable(dev->num_clks, dev->clks);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Enabling clocks, fail: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	np =3D of_parse_phandle(pdev->dev.of_node, "sram", 0);
> > +	if (!np) {
> > +		dev_warn(&pdev->dev, "sram node not found\n");
> > +	} else {
> > +		ret =3D of_address_to_resource(np, 0, &sram);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "sram resource not available\n");
> > +			goto err_put_node;
> > +		}
> > +		dev->sram_buf.daddr =3D sram.start;
> > +		dev->sram_buf.size =3D resource_size(&sram);
> > +		dev_dbg(&pdev->dev, "%s: sram daddr: %pad, size: 0x%lx\n",
> > +			__func__, &dev->sram_buf.daddr, dev->sram_buf.size);
> > +	}
> > +
> > +	dev->product_code =3D wave5_vdi_readl(dev, VPU_PRODUCT_CODE_REGISTER)=
;
> > +	ret =3D wave5_vdi_init(&pdev->dev);
> > +	if (ret < 0) {
> > +		dev_err(&pdev->dev, "wave5_vdi_init, fail: %d\n", ret);
> > +		goto err_clk_dis;
> > +	}
> > +	dev->product =3D wave5_vpu_get_product_id(dev);
> > +
> > +	INIT_LIST_HEAD(&dev->instances);
> > +	ret =3D v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "v4l2_device_register, fail: %d\n", ret);
> > +		goto err_vdi_release;
> > +	}
> > +
> > +	if (match_data->flags & WAVE5_IS_DEC) {
> > +		ret =3D wave5_vpu_dec_register_device(dev);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "wave5_vpu_dec_register_device, fail: %d\n", re=
t);
> > +			goto err_v4l2_unregister;
> > +		}
> > +	}
> > +	if (match_data->flags & WAVE5_IS_ENC) {
> > +		ret =3D wave5_vpu_enc_register_device(dev);
> > +		if (ret) {
> > +			dev_err(&pdev->dev, "wave5_vpu_enc_register_device, fail: %d\n", re=
t);
> > +			goto err_dec_unreg;
> > +		}
> > +	}
> > +
> > +	dev->irq =3D platform_get_irq(pdev, 0);
> > +	if (dev->irq < 0) {
> > +		dev_err(&pdev->dev, "failed to get irq resource\n");
> > +		ret =3D -ENXIO;
> > +		goto err_enc_unreg;
> > +	}
> > +
> > +	ret =3D devm_request_threaded_irq(&pdev->dev, dev->irq, wave5_vpu_irq=
,
> > +					wave5_vpu_irq_thread, 0, "vpu_irq", dev);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Register interrupt handler, fail: %d\n", ret);
> > +		goto err_enc_unreg;
> > +	}
> > +
> > +	ret =3D wave5_vpu_load_firmware(&pdev->dev, match_data->fw_name);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "wave5_vpu_load_firmware, fail: %d\n", ret);
> > +		goto err_enc_unreg;
> > +	}
> > +
> > +	dev_dbg(&pdev->dev, "Added wave5 driver with caps: %s %s and product =
code: 0x%x\n",
> > +		(match_data->flags & WAVE5_IS_ENC) ? "'ENCODE'" : "",
> > +		(match_data->flags & WAVE5_IS_DEC) ? "'DECODE'" : "",
> > +		dev->product_code);
> > +	return 0;
> > +
> > +err_enc_unreg:
> > +	if (match_data->flags & WAVE5_IS_ENC)
> > +		wave5_vpu_enc_unregister_device(dev);
> > +err_dec_unreg:
> > +	if (match_data->flags & WAVE5_IS_DEC)
> > +		wave5_vpu_dec_unregister_device(dev);
> > +err_v4l2_unregister:
> > +	v4l2_device_unregister(&dev->v4l2_dev);
> > +err_vdi_release:
> > +	wave5_vdi_release(&pdev->dev);
> > +err_clk_dis:
> > +	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> > +err_put_node:
> > +	of_node_put(np);
> > +
> > +	return ret;
> > +}
> > +
> > +static int wave5_vpu_remove(struct platform_device *pdev)
> > +{
> > +	struct vpu_device *dev =3D dev_get_drvdata(&pdev->dev);
> > +
> > +	clk_bulk_disable_unprepare(dev->num_clks, dev->clks);
> > +	wave5_vpu_enc_unregister_device(dev);
> > +	wave5_vpu_dec_unregister_device(dev);
> > +	v4l2_device_unregister(&dev->v4l2_dev);
> > +	wave5_vdi_release(&pdev->dev);
> > +	ida_destroy(&dev->inst_ida);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct wave5_match_data wave511_data =3D {
> > +	.flags =3D WAVE5_IS_DEC,
> > +	.fw_name =3D "wave511_dec_fw.bin",
> > +};
> > +
> > +static const struct wave5_match_data wave521_data =3D {
> > +	.flags =3D WAVE5_IS_ENC,
> > +	.fw_name =3D "wave521_enc_fw.bin",
> > +};
> > +
> > +static const struct wave5_match_data wave521c_data =3D {
> > +	.flags =3D WAVE5_IS_ENC | WAVE5_IS_DEC,
> > +	.fw_name =3D "wave521c_codec_fw.bin",
> > +};
> > +
> > +static const struct wave5_match_data default_match_data =3D {
> > +	.flags =3D WAVE5_IS_ENC | WAVE5_IS_DEC,
> > +	.fw_name =3D "chagall.bin",
> > +};
> > +
> > +static const struct of_device_id wave5_dt_ids[] =3D {
> > +	{ .compatible =3D "cnm,cm511-vpu", .data =3D &wave511_data },
> > +	{ .compatible =3D "cnm,cm517-vpu", .data =3D &default_match_data },
> > +	{ .compatible =3D "cnm,cm521-vpu", .data =3D &wave521_data },
> > +	{ .compatible =3D "cnm,cm521c-vpu", .data =3D &wave521c_data },
> > +	{ .compatible =3D "cnm,cm521c-dual-vpu", .data =3D &wave521c_data },
> > +	{ .compatible =3D "cnm,cm521e1-vpu", .data =3D &default_match_data },
> > +	{ .compatible =3D "cnm,cm537-vpu", .data =3D &default_match_data },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, wave5_dt_ids);
> > +
> > +static struct platform_driver wave5_vpu_driver =3D {
> > +	.driver =3D {
> > +		.name =3D VPU_PLATFORM_DEVICE_NAME,
> > +		.of_match_table =3D of_match_ptr(wave5_dt_ids),
> > +		},
> > +	.probe =3D wave5_vpu_probe,
> > +	.remove =3D wave5_vpu_remove,
> > +};
> > +
> > +module_platform_driver(wave5_vpu_driver);
> > +MODULE_DESCRIPTION("chips&media VPU V4L2 driver");
> > +MODULE_LICENSE("Dual BSD/GPL");
> > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu.h b/dri=
vers/media/platform/chips-media/wave5/wave5-vpu.h
> > new file mode 100644
> > index 000000000000..7156d8c3fee4
> > --- /dev/null
> > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu.h
> > @@ -0,0 +1,72 @@
> > +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> > +/*
> > + * Wave5 series multi-standard codec IP - basic types
> > + *
> > + * Copyright (C) 2021 CHIPS&MEDIA INC
> > + */
> > +#ifndef __VPU_DRV_H__
> > +#define __VPU_DRV_H__
> > +
> > +#include <media/v4l2-ctrls.h>
> > +#include <media/v4l2-ioctl.h>
> > +#include <media/v4l2-event.h>
> > +#include <media/v4l2-fh.h>
> > +#include <media/videobuf2-v4l2.h>
> > +#include <media/videobuf2-dma-contig.h>
> > +#include <media/videobuf2-vmalloc.h>
> > +#include "wave5-vpuconfig.h"
> > +#include "wave5-vpuapi.h"
> > +
> > +#define VPU_BUF_SYNC_TO_DEVICE 0
> > +#define VPU_BUF_SYNC_FROM_DEVICE 1
> > +
> > +struct vpu_buffer {
> > +	struct v4l2_m2m_buffer v4l2_m2m_buf;
> > +	bool                   consumed;
> > +};
> > +
> > +enum vpu_fmt_type {
> > +	VPU_FMT_TYPE_CODEC =3D 0,
> > +	VPU_FMT_TYPE_RAW   =3D 1
> > +};
> > +
> > +struct vpu_format {
> > +	unsigned int v4l2_pix_fmt;
> > +	unsigned int max_width;
> > +	unsigned int min_width;
> > +	unsigned int max_height;
> > +	unsigned int min_height;
> > +};
> > +
> > +static inline struct vpu_instance *wave5_to_vpu_inst(struct v4l2_fh *v=
fh)
> > +{
> > +	return container_of(vfh, struct vpu_instance, v4l2_fh);
> > +}
> > +
> > +static inline struct vpu_instance *wave5_ctrl_to_vpu_inst(struct v4l2_=
ctrl *vctrl)
> > +{
> > +	return container_of(vctrl->handler, struct vpu_instance, v4l2_ctrl_hd=
l);
> > +}
> > +
> > +static inline struct vpu_buffer *wave5_to_vpu_buf(struct vb2_v4l2_buff=
er *vbuf)
> > +{
> > +	return container_of(vbuf, struct vpu_buffer, v4l2_m2m_buf.vb);
> > +}
> > +
> > +int wave5_vpu_wait_interrupt(struct vpu_instance *inst, unsigned int t=
imeout);
> > +
> > +int  wave5_vpu_dec_register_device(struct vpu_device *dev);
> > +void wave5_vpu_dec_unregister_device(struct vpu_device *dev);
> > +int  wave5_vpu_enc_register_device(struct vpu_device *dev);
> > +void wave5_vpu_enc_unregister_device(struct vpu_device *dev);
> > +static inline bool wave5_vpu_both_queues_are_streaming(struct vpu_inst=
ance *inst)
> > +{
> > +	struct vb2_queue *vq_cap =3D
> > +		v4l2_m2m_get_vq(inst->v4l2_fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_CAPTURE_M=
PLANE);
> > +	struct vb2_queue *vq_out =3D
> > +		v4l2_m2m_get_vq(inst->v4l2_fh.m2m_ctx, V4L2_BUF_TYPE_VIDEO_OUTPUT_MP=
LANE);
> > +
> > +	return vb2_is_streaming(vq_cap) && vb2_is_streaming(vq_out);
> > +}
> > +
> > +#endif
>=20
> Regards,
>=20
> 	Hans

