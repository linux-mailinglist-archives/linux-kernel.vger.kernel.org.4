Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6736E50FE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 21:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbjDQTcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 15:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjDQTcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 15:32:03 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 930253593
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:31:53 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id e13so9670855qvd.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 12:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20221208.gappssmtp.com; s=20221208; t=1681759912; x=1684351912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LxT1uxSrIu8DWa+7EsCRmjZd24DTrWHsnPYh1d21/mQ=;
        b=PnQvXS1xTF72ZEcr1CXE9ytfVRjuB5594wZUUNlSBd3Bcxvaz3EQ9xFTh/lZWcGTdK
         ZYD488VahbDpnJIXkkX3cseIfTudLGxoacsYD1i0Cg9tTr/gINmTw7oFD6yoQQWisO/z
         /pN7HeDQSOASna6RBZhmt5GK1s1GbPpv+hCrJvYKhns6LuogcijLCadGtQgyV2NXI2+U
         UMNVjrAoiTjfObP7cONpTv66T+IsZweBp1wvIM6Mojivlo8nguF5Npr93IORtj/1a0wr
         /8UgeoaIzPMa95TluFaORLge8/KoZ4jpRHjeAKDUU1x9y3RJmTV0pYlMW7LQQUgk6cz2
         o/Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681759912; x=1684351912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LxT1uxSrIu8DWa+7EsCRmjZd24DTrWHsnPYh1d21/mQ=;
        b=XpWCue2SXtNHMx/qOUDWmasHVzy1e8s3mwVSFSQUrVIsQiskX2pkfgpNPyRc6xzr8P
         mENGe2Jqh+2Jucjr0Ap4SoE4qks171aH/19HpIL+JkCZR4ltKuKR3rbMcL2mAeSt380N
         hzWjVNcR9IsukpBrIRMqGm7PUDY9bl3eIhA0zekUsja+9zMDLI5Ivip5qm5WzpOcL0cx
         RMzAcndMzQPP87vJqHqUYf3f5SWggxsXQhnoTYmuR9Hm6eoLWLYeHbww4bpbErVQLNIk
         +ynat5jt9TBIINOazp7u/2W3e2WTU9vZg8mo5j2Mc3Ys1mC3rWwAh4iKOPx2j1v23mtd
         0TDA==
X-Gm-Message-State: AAQBX9fUncyWBuznFk4KkYcMiAe3595yneGk4245/kWlXSeVA2lHlpio
        wYMKUHXPhHbJeG8ITd8qhYpbnA==
X-Google-Smtp-Source: AKy350Z761z3b5w1ZM0MJ0BsVT8K7QH2VLsnaaYzgkkqkwI64TsmZEfMsPK4iWBVThIVedsHU1K4ug==
X-Received: by 2002:ad4:5c41:0:b0:5ef:8c85:6c5e with SMTP id a1-20020ad45c41000000b005ef8c856c5emr549587qva.42.1681759912389;
        Mon, 17 Apr 2023 12:31:52 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:15:199e::580])
        by smtp.gmail.com with ESMTPSA id m7-20020a0ce8c7000000b005ef4de2cc3bsm1000733qvo.138.2023.04.17.12.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 12:31:51 -0700 (PDT)
Message-ID: <f96d25754d8811b0dde2ce40b94536c8421e1ecb.camel@ndufresne.ca>
Subject: Re: [PATCH v17 08/14] media: amphion: add v4l2 m2m vpu decoder
 stateful driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org,
        shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de
Cc:     hverkuil-cisco@xs4all.nl, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, aisheng.dong@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Mon, 17 Apr 2023 15:31:50 -0400
In-Reply-To: <c38c16d150b72d6b0d45988d4ec5a6ab5045a164.1645615976.git.ming.qian@nxp.com>
References: <cover.1645615976.git.ming.qian@nxp.com>
         <c38c16d150b72d6b0d45988d4ec5a6ab5045a164.1645615976.git.ming.qian@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

I started to work on proper resolution change support in GStreamer [1], its=
 not
ready yet, but hopefully this can land soon. The current implementation you=
r
team have contributed have many shortcoming and issues.

While testing various methods, I stumble across an interesting behaviour of=
 your
driver, see comment inline.

[1] https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/443=
7

Le mercredi 23 f=C3=A9vrier 2022 =C3=A0 19:40 +0800, Ming Qian a =C3=A9crit=
=C2=A0:
> This consists of video decoder implementation plus decoder controls.
>=20
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Signed-off-by: Shijie Qin <shijie.qin@nxp.com>
> Signed-off-by: Zhou Peng <eagle.zhou@nxp.com>
> Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
>  drivers/media/platform/amphion/vdec.c | 1691 +++++++++++++++++++++++++
>  1 file changed, 1691 insertions(+)
>  create mode 100644 drivers/media/platform/amphion/vdec.c
>=20
> diff --git a/drivers/media/platform/amphion/vdec.c b/drivers/media/platfo=
rm/amphion/vdec.c
> new file mode 100644
> index 000000000000..24ce5ea8ebf7
> --- /dev/null
> +++ b/drivers/media/platform/amphion/vdec.c
> @@ -0,0 +1,1691 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020-2021 NXP
> + */
> +
> +#include <linux/init.h>
> +#include <linux/interconnect.h>
> +#include <linux/ioctl.h>
> +#include <linux/list.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/vmalloc.h>
> +#include <linux/videodev2.h>
> +#include <media/v4l2-device.h>
> +#include <media/v4l2-event.h>
> +#include <media/v4l2-mem2mem.h>
> +#include <media/v4l2-ioctl.h>
> +#include <media/videobuf2-v4l2.h>
> +#include <media/videobuf2-dma-contig.h>
> +#include <media/videobuf2-vmalloc.h>
> +#include "vpu.h"
> +#include "vpu_defs.h"
> +#include "vpu_core.h"
> +#include "vpu_helpers.h"
> +#include "vpu_v4l2.h"
> +#include "vpu_cmds.h"
> +#include "vpu_rpc.h"
> +
> +#define VDEC_FRAME_DEPTH		256
> +#define VDEC_MIN_BUFFER_CAP		8
> +
> +struct vdec_fs_info {
> +	char name[8];
> +	u32 type;
> +	u32 max_count;
> +	u32 req_count;
> +	u32 count;
> +	u32 index;
> +	u32 size;
> +	struct vpu_buffer buffer[32];
> +	u32 tag;
> +};
> +
> +struct vdec_t {
> +	u32 seq_hdr_found;
> +	struct vpu_buffer udata;
> +	struct vpu_decode_params params;
> +	struct vpu_dec_codec_info codec_info;
> +	enum vpu_codec_state state;
> +
> +	struct vpu_vb2_buffer *slots[VB2_MAX_FRAME];
> +	u32 req_frame_count;
> +	struct vdec_fs_info mbi;
> +	struct vdec_fs_info dcp;
> +	u32 seq_tag;
> +
> +	bool reset_codec;
> +	bool fixed_fmt;
> +	u32 decoded_frame_count;
> +	u32 display_frame_count;
> +	u32 sequence;
> +	u32 eos_received;
> +	bool is_source_changed;
> +	u32 source_change;
> +	u32 drain;
> +	u32 ts_pre_count;
> +	u32 frame_depth;
> +	s64 ts_start;
> +	s64 ts_input;
> +	s64 timestamp;
> +};
> +
> +static const struct vpu_format vdec_formats[] =3D {
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_NV12M_8L128,
> +		.num_planes =3D 2,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_NV12M_10BE_8L128,
> +		.num_planes =3D 2,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_H264,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_H264_MVC,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_HEVC,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_VC1_ANNEX_G,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_VC1_ANNEX_L,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_MPEG2,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_MPEG4,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_XVID,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_VP8,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{
> +		.pixfmt =3D V4L2_PIX_FMT_H263,
> +		.num_planes =3D 1,
> +		.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
> +		.flags =3D V4L2_FMT_FLAG_DYN_RESOLUTION
> +	},
> +	{0, 0, 0, 0},
> +};
> +
> +static const struct v4l2_ctrl_ops vdec_ctrl_ops =3D {
> +	.g_volatile_ctrl =3D vpu_helper_g_volatile_ctrl,
> +};
> +
> +static int vdec_ctrl_init(struct vpu_inst *inst)
> +{
> +	struct v4l2_ctrl *ctrl;
> +	int ret;
> +
> +	ret =3D v4l2_ctrl_handler_init(&inst->ctrl_handler, 20);
> +	if (ret)
> +		return ret;
> +
> +	ctrl =3D v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
> +				 V4L2_CID_MIN_BUFFERS_FOR_CAPTURE, 1, 32, 1, 2);
> +	if (ctrl)
> +		ctrl->flags |=3D V4L2_CTRL_FLAG_VOLATILE;
> +
> +	ctrl =3D v4l2_ctrl_new_std(&inst->ctrl_handler, &vdec_ctrl_ops,
> +				 V4L2_CID_MIN_BUFFERS_FOR_OUTPUT, 1, 32, 1, 2);
> +	if (ctrl)
> +		ctrl->flags |=3D V4L2_CTRL_FLAG_VOLATILE;
> +
> +	ret =3D v4l2_ctrl_handler_setup(&inst->ctrl_handler);
> +	if (ret) {
> +		dev_err(inst->dev, "[%d] setup ctrls fail, ret =3D %d\n", inst->id, re=
t);
> +		v4l2_ctrl_handler_free(&inst->ctrl_handler);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void vdec_set_last_buffer_dequeued(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	if (vdec->eos_received) {
> +		if (!vpu_set_last_buffer_dequeued(inst))
> +			vdec->eos_received--;
> +	}
> +}
> +
> +static void vdec_handle_resolution_change(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vb2_queue *q;
> +
> +	if (!inst->fh.m2m_ctx)
> +		return;
> +
> +	if (inst->state !=3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
> +		return;
> +	if (!vdec->source_change)
> +		return;
> +
> +	q =3D v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
> +	if (!list_empty(&q->done_list))
> +		return;
>=20
>=20
>=20
>=20

Here you wait for userspace to dequeue all the capture buffers. This extra
effort is not required by the spec. But what is required by the spec is tha=
t you
should initiate a drain of the capture queue. Please find below a quote fro=
m the
spec:


> 2. The decoder will then process and decode all remaining buffers from be=
fore
> the resolution change point.
>
>    The last buffer from before the change must be marked with the
>    V4L2_BUF_FLAG_LAST flag, similarly to the Drain sequence above.


>=20
>=20
> +
> +	vdec->source_change--;
> +	vpu_notify_source_change(inst);
> +}
> +
> +static int vdec_update_state(struct vpu_inst *inst, enum vpu_codec_state=
 state, u32 force)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	enum vpu_codec_state pre_state =3D inst->state;
> +
> +	if (state =3D=3D VPU_CODEC_STATE_SEEK) {
> +		if (inst->state =3D=3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
> +			vdec->state =3D inst->state;
> +		else
> +			vdec->state =3D VPU_CODEC_STATE_ACTIVE;
> +	}
> +	if (inst->state !=3D VPU_CODEC_STATE_SEEK || force)
> +		inst->state =3D state;
> +	else if (state =3D=3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
> +		vdec->state =3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE;
> +
> +	if (inst->state !=3D pre_state)
> +		vpu_trace(inst->dev, "[%d] %d -> %d\n", inst->id, pre_state, inst->sta=
te);
> +
> +	if (inst->state =3D=3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
> +		vdec_handle_resolution_change(inst);
> +
> +	return 0;
> +}
> +
> +static int vdec_querycap(struct file *file, void *fh, struct v4l2_capabi=
lity *cap)
> +{
> +	strscpy(cap->driver, "amphion-vpu", sizeof(cap->driver));
> +	strscpy(cap->card, "amphion vpu decoder", sizeof(cap->card));
> +	strscpy(cap->bus_info, "platform: amphion-vpu", sizeof(cap->bus_info));
> +
> +	return 0;
> +}
> +
> +static int vdec_enum_fmt(struct file *file, void *fh, struct v4l2_fmtdes=
c *f)
> +{
> +	struct vpu_inst *inst =3D to_inst(file);
> +	struct vdec_t *vdec =3D inst->priv;
> +	const struct vpu_format *fmt;
> +	int ret =3D -EINVAL;
> +
> +	vpu_inst_lock(inst);
> +	if (!V4L2_TYPE_IS_OUTPUT(f->type) && vdec->fixed_fmt) {
> +		if (f->index =3D=3D 0) {
> +			f->pixelformat =3D inst->cap_format.pixfmt;
> +			f->flags =3D inst->cap_format.flags;
> +			ret =3D 0;
> +		}
> +	} else {
> +		fmt =3D vpu_helper_enum_format(inst, f->type, f->index);
> +		memset(f->reserved, 0, sizeof(f->reserved));
> +		if (!fmt)
> +			goto exit;
> +
> +		f->pixelformat =3D fmt->pixfmt;
> +		f->flags =3D fmt->flags;
> +		ret =3D 0;
> +	}
> +
> +exit:
> +	vpu_inst_unlock(inst);
> +	return ret;
> +}
> +
> +static int vdec_g_fmt(struct file *file, void *fh, struct v4l2_format *f=
)
> +{
> +	struct vpu_inst *inst =3D to_inst(file);
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct v4l2_pix_format_mplane *pixmp =3D &f->fmt.pix_mp;
> +	struct vpu_format *cur_fmt;
> +	int i;
> +
> +	cur_fmt =3D vpu_get_format(inst, f->type);
> +
> +	pixmp->pixelformat =3D cur_fmt->pixfmt;
> +	pixmp->num_planes =3D cur_fmt->num_planes;
> +	pixmp->width =3D cur_fmt->width;
> +	pixmp->height =3D cur_fmt->height;
> +	pixmp->field =3D cur_fmt->field;
> +	pixmp->flags =3D cur_fmt->flags;
> +	for (i =3D 0; i < pixmp->num_planes; i++) {
> +		pixmp->plane_fmt[i].bytesperline =3D cur_fmt->bytesperline[i];
> +		pixmp->plane_fmt[i].sizeimage =3D cur_fmt->sizeimage[i];
> +	}
> +
> +	f->fmt.pix_mp.colorspace =3D vdec->codec_info.color_primaries;
> +	f->fmt.pix_mp.xfer_func =3D vdec->codec_info.transfer_chars;
> +	f->fmt.pix_mp.ycbcr_enc =3D vdec->codec_info.matrix_coeffs;
> +	f->fmt.pix_mp.quantization =3D vdec->codec_info.full_range;
> +
> +	return 0;
> +}
> +
> +static int vdec_try_fmt(struct file *file, void *fh, struct v4l2_format =
*f)
> +{
> +	struct vpu_inst *inst =3D to_inst(file);
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vpu_try_fmt_common(inst, f);
> +
> +	vpu_inst_lock(inst);
> +	if (vdec->fixed_fmt) {
> +		f->fmt.pix_mp.colorspace =3D vdec->codec_info.color_primaries;
> +		f->fmt.pix_mp.xfer_func =3D vdec->codec_info.transfer_chars;
> +		f->fmt.pix_mp.ycbcr_enc =3D vdec->codec_info.matrix_coeffs;
> +		f->fmt.pix_mp.quantization =3D vdec->codec_info.full_range;
> +	} else {
> +		f->fmt.pix_mp.colorspace =3D V4L2_COLORSPACE_DEFAULT;
> +		f->fmt.pix_mp.xfer_func =3D V4L2_XFER_FUNC_DEFAULT;
> +		f->fmt.pix_mp.ycbcr_enc =3D V4L2_YCBCR_ENC_DEFAULT;
> +		f->fmt.pix_mp.quantization =3D V4L2_QUANTIZATION_DEFAULT;
> +	}
> +	vpu_inst_unlock(inst);
> +
> +	return 0;
> +}
> +
> +static int vdec_s_fmt_common(struct vpu_inst *inst, struct v4l2_format *=
f)
> +{
> +	struct v4l2_pix_format_mplane *pixmp =3D &f->fmt.pix_mp;
> +	const struct vpu_format *fmt;
> +	struct vpu_format *cur_fmt;
> +	struct vb2_queue *q;
> +	struct vdec_t *vdec =3D inst->priv;
> +	int i;
> +
> +	if (!inst->fh.m2m_ctx)
> +		return -EINVAL;
> +
> +	q =3D v4l2_m2m_get_vq(inst->fh.m2m_ctx, f->type);
> +	if (!q)
> +		return -EINVAL;
> +	if (vb2_is_busy(q))
> +		return -EBUSY;
> +
> +	fmt =3D vpu_try_fmt_common(inst, f);
> +	if (!fmt)
> +		return -EINVAL;
> +
> +	cur_fmt =3D vpu_get_format(inst, f->type);
> +	if (V4L2_TYPE_IS_OUTPUT(f->type) && inst->state !=3D VPU_CODEC_STATE_DE=
INIT) {
> +		if (cur_fmt->pixfmt !=3D fmt->pixfmt) {
> +			vdec->reset_codec =3D true;
> +			vdec->fixed_fmt =3D false;
> +		}
> +	}
> +	cur_fmt->pixfmt =3D fmt->pixfmt;
> +	if (V4L2_TYPE_IS_OUTPUT(f->type) || !vdec->fixed_fmt) {
> +		cur_fmt->num_planes =3D fmt->num_planes;
> +		cur_fmt->flags =3D fmt->flags;
> +		cur_fmt->width =3D pixmp->width;
> +		cur_fmt->height =3D pixmp->height;
> +		for (i =3D 0; i < fmt->num_planes; i++) {
> +			cur_fmt->sizeimage[i] =3D pixmp->plane_fmt[i].sizeimage;
> +			cur_fmt->bytesperline[i] =3D pixmp->plane_fmt[i].bytesperline;
> +		}
> +		if (pixmp->field !=3D V4L2_FIELD_ANY)
> +			cur_fmt->field =3D pixmp->field;
> +	} else {
> +		pixmp->num_planes =3D cur_fmt->num_planes;
> +		pixmp->width =3D cur_fmt->width;
> +		pixmp->height =3D cur_fmt->height;
> +		for (i =3D 0; i < pixmp->num_planes; i++) {
> +			pixmp->plane_fmt[i].bytesperline =3D cur_fmt->bytesperline[i];
> +			pixmp->plane_fmt[i].sizeimage =3D cur_fmt->sizeimage[i];
> +		}
> +		pixmp->field =3D cur_fmt->field;
> +	}
> +
> +	if (!vdec->fixed_fmt) {
> +		if (V4L2_TYPE_IS_OUTPUT(f->type)) {
> +			vdec->params.codec_format =3D cur_fmt->pixfmt;
> +			vdec->codec_info.color_primaries =3D f->fmt.pix_mp.colorspace;
> +			vdec->codec_info.transfer_chars =3D f->fmt.pix_mp.xfer_func;
> +			vdec->codec_info.matrix_coeffs =3D f->fmt.pix_mp.ycbcr_enc;
> +			vdec->codec_info.full_range =3D f->fmt.pix_mp.quantization;
> +		} else {
> +			vdec->params.output_format =3D cur_fmt->pixfmt;
> +			inst->crop.left =3D 0;
> +			inst->crop.top =3D 0;
> +			inst->crop.width =3D cur_fmt->width;
> +			inst->crop.height =3D cur_fmt->height;
> +		}
> +	}
> +
> +	vpu_trace(inst->dev, "[%d] %c%c%c%c %dx%d\n", inst->id,
> +		  f->fmt.pix_mp.pixelformat,
> +		  f->fmt.pix_mp.pixelformat >> 8,
> +		  f->fmt.pix_mp.pixelformat >> 16,
> +		  f->fmt.pix_mp.pixelformat >> 24,
> +		  f->fmt.pix_mp.width,
> +		  f->fmt.pix_mp.height);
> +
> +	return 0;
> +}
> +
> +static int vdec_s_fmt(struct file *file, void *fh, struct v4l2_format *f=
)
> +{
> +	struct vpu_inst *inst =3D to_inst(file);
> +	struct v4l2_pix_format_mplane *pixmp =3D &f->fmt.pix_mp;
> +	struct vdec_t *vdec =3D inst->priv;
> +	int ret =3D 0;
> +
> +	vpu_inst_lock(inst);
> +	ret =3D vdec_s_fmt_common(inst, f);
> +	if (ret)
> +		goto exit;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(f->type) && !vdec->fixed_fmt) {
> +		struct v4l2_format fc;
> +
> +		memset(&fc, 0, sizeof(fc));
> +		fc.type =3D inst->cap_format.type;
> +		fc.fmt.pix_mp.pixelformat =3D inst->cap_format.pixfmt;
> +		fc.fmt.pix_mp.width =3D pixmp->width;
> +		fc.fmt.pix_mp.height =3D pixmp->height;
> +		vdec_s_fmt_common(inst, &fc);
> +	}
> +
> +	f->fmt.pix_mp.colorspace =3D vdec->codec_info.color_primaries;
> +	f->fmt.pix_mp.xfer_func =3D vdec->codec_info.transfer_chars;
> +	f->fmt.pix_mp.ycbcr_enc =3D vdec->codec_info.matrix_coeffs;
> +	f->fmt.pix_mp.quantization =3D vdec->codec_info.full_range;
> +
> +exit:
> +	vpu_inst_unlock(inst);
> +	return ret;
> +}
> +
> +static int vdec_g_selection(struct file *file, void *fh, struct v4l2_sel=
ection *s)
> +{
> +	struct vpu_inst *inst =3D to_inst(file);
> +
> +	if (s->type !=3D V4L2_BUF_TYPE_VIDEO_CAPTURE && s->type !=3D V4L2_BUF_T=
YPE_VIDEO_CAPTURE_MPLANE)
> +		return -EINVAL;
> +
> +	switch (s->target) {
> +	case V4L2_SEL_TGT_COMPOSE:
> +	case V4L2_SEL_TGT_COMPOSE_DEFAULT:
> +	case V4L2_SEL_TGT_COMPOSE_PADDED:
> +		s->r =3D inst->crop;
> +		break;
> +	case V4L2_SEL_TGT_COMPOSE_BOUNDS:
> +		s->r.left =3D 0;
> +		s->r.top =3D 0;
> +		s->r.width =3D inst->cap_format.width;
> +		s->r.height =3D inst->cap_format.height;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int vdec_drain(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	if (!inst->fh.m2m_ctx)
> +		return 0;
> +
> +	if (!vdec->drain)
> +		return 0;
> +
> +	if (v4l2_m2m_num_src_bufs_ready(inst->fh.m2m_ctx))
> +		return 0;
> +
> +	if (!vdec->params.frame_count) {
> +		vpu_set_last_buffer_dequeued(inst);
> +		return 0;
> +	}
> +
> +	vpu_iface_add_scode(inst, SCODE_PADDING_EOS);
> +	vdec->params.end_flag =3D 1;
> +	vpu_iface_set_decode_params(inst, &vdec->params, 1);
> +	vdec->drain =3D 0;
> +	vpu_trace(inst->dev, "[%d] frame_count =3D %d\n", inst->id, vdec->param=
s.frame_count);
> +
> +	return 0;
> +}
> +
> +static int vdec_cmd_start(struct vpu_inst *inst)
> +{
> +	switch (inst->state) {
> +	case VPU_CODEC_STATE_STARTED:
> +	case VPU_CODEC_STATE_DRAIN:
> +	case VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE:
> +		vdec_update_state(inst, VPU_CODEC_STATE_ACTIVE, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +	vpu_process_capture_buffer(inst);
> +	return 0;
> +}
> +
> +static int vdec_cmd_stop(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vpu_trace(inst->dev, "[%d]\n", inst->id);
> +
> +	if (inst->state =3D=3D VPU_CODEC_STATE_DEINIT) {
> +		vpu_set_last_buffer_dequeued(inst);
> +	} else {
> +		vdec->drain =3D 1;
> +		vdec_drain(inst);
> +	}
> +
> +	return 0;
> +}
> +
> +static int vdec_decoder_cmd(struct file *file, void *fh, struct v4l2_dec=
oder_cmd *cmd)
> +{
> +	struct vpu_inst *inst =3D to_inst(file);
> +	int ret;
> +
> +	ret =3D v4l2_m2m_ioctl_try_decoder_cmd(file, fh, cmd);
> +	if (ret)
> +		return ret;
> +
> +	vpu_inst_lock(inst);
> +	switch (cmd->cmd) {
> +	case V4L2_DEC_CMD_START:
> +		vdec_cmd_start(inst);
> +		break;
> +	case V4L2_DEC_CMD_STOP:
> +		vdec_cmd_stop(inst);
> +		break;
> +	default:
> +		break;
> +	}
> +	vpu_inst_unlock(inst);
> +
> +	return 0;
> +}
> +
> +static int vdec_subscribe_event(struct v4l2_fh *fh, const struct v4l2_ev=
ent_subscription *sub)
> +{
> +	switch (sub->type) {
> +	case V4L2_EVENT_EOS:
> +		return v4l2_event_subscribe(fh, sub, 0, NULL);
> +	case V4L2_EVENT_SOURCE_CHANGE:
> +		return v4l2_src_change_event_subscribe(fh, sub);
> +	case V4L2_EVENT_CTRL:
> +		return v4l2_ctrl_subscribe_event(fh, sub);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct v4l2_ioctl_ops vdec_ioctl_ops =3D {
> +	.vidioc_querycap               =3D vdec_querycap,
> +	.vidioc_enum_fmt_vid_cap       =3D vdec_enum_fmt,
> +	.vidioc_enum_fmt_vid_out       =3D vdec_enum_fmt,
> +	.vidioc_g_fmt_vid_cap_mplane   =3D vdec_g_fmt,
> +	.vidioc_g_fmt_vid_out_mplane   =3D vdec_g_fmt,
> +	.vidioc_try_fmt_vid_cap_mplane =3D vdec_try_fmt,
> +	.vidioc_try_fmt_vid_out_mplane =3D vdec_try_fmt,
> +	.vidioc_s_fmt_vid_cap_mplane   =3D vdec_s_fmt,
> +	.vidioc_s_fmt_vid_out_mplane   =3D vdec_s_fmt,
> +	.vidioc_g_selection            =3D vdec_g_selection,
> +	.vidioc_try_decoder_cmd        =3D v4l2_m2m_ioctl_try_decoder_cmd,
> +	.vidioc_decoder_cmd            =3D vdec_decoder_cmd,
> +	.vidioc_subscribe_event        =3D vdec_subscribe_event,
> +	.vidioc_unsubscribe_event      =3D v4l2_event_unsubscribe,
> +	.vidioc_reqbufs                =3D v4l2_m2m_ioctl_reqbufs,
> +	.vidioc_create_bufs	       =3D v4l2_m2m_ioctl_create_bufs,
> +	.vidioc_prepare_buf	       =3D v4l2_m2m_ioctl_prepare_buf,
> +	.vidioc_querybuf               =3D v4l2_m2m_ioctl_querybuf,
> +	.vidioc_qbuf                   =3D v4l2_m2m_ioctl_qbuf,
> +	.vidioc_expbuf                 =3D v4l2_m2m_ioctl_expbuf,
> +	.vidioc_dqbuf                  =3D v4l2_m2m_ioctl_dqbuf,
> +	.vidioc_streamon               =3D v4l2_m2m_ioctl_streamon,
> +	.vidioc_streamoff              =3D v4l2_m2m_ioctl_streamoff,
> +};
> +
> +static bool vdec_check_ready(struct vpu_inst *inst, unsigned int type)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(type)) {
> +		if (vdec->ts_pre_count >=3D vdec->frame_depth)
> +			return false;
> +		return true;
> +	}
> +
> +	if (vdec->req_frame_count)
> +		return true;
> +
> +	return false;
> +}
> +
> +static int vdec_frame_decoded(struct vpu_inst *inst, void *arg)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vpu_dec_pic_info *info =3D arg;
> +	struct vpu_vb2_buffer *vpu_buf;
> +	struct vb2_v4l2_buffer *vbuf;
> +	int ret =3D 0;
> +
> +	if (!info || info->id >=3D ARRAY_SIZE(vdec->slots))
> +		return -EINVAL;
> +
> +	vpu_inst_lock(inst);
> +	vpu_buf =3D vdec->slots[info->id];
> +	if (!vpu_buf) {
> +		dev_err(inst->dev, "[%d] decoded invalid frame[%d]\n", inst->id, info-=
>id);
> +		ret =3D -EINVAL;
> +		goto exit;
> +	}
> +	vbuf =3D &vpu_buf->m2m_buf.vb;
> +	if (vpu_get_buffer_state(vbuf) =3D=3D VPU_BUF_STATE_DECODED)
> +		dev_info(inst->dev, "[%d] buf[%d] has been decoded\n", inst->id, info-=
>id);
> +	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_DECODED);
> +	vdec->decoded_frame_count++;
> +	if (vdec->ts_pre_count >=3D info->consumed_count)
> +		vdec->ts_pre_count -=3D info->consumed_count;
> +	else
> +		vdec->ts_pre_count =3D 0;
> +exit:
> +	vpu_inst_unlock(inst);
> +
> +	return ret;
> +}
> +
> +static struct vpu_vb2_buffer *vdec_find_buffer(struct vpu_inst *inst, u3=
2 luma)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vdec->slots); i++) {
> +		if (!vdec->slots[i])
> +			continue;
> +		if (luma =3D=3D vdec->slots[i]->luma)
> +			return vdec->slots[i];
> +	}
> +
> +	return NULL;
> +}
> +
> +static void vdec_buf_done(struct vpu_inst *inst, struct vpu_frame_info *=
frame)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vpu_vb2_buffer *vpu_buf;
> +	struct vb2_v4l2_buffer *vbuf;
> +	u32 sequence;
> +
> +	if (!frame)
> +		return;
> +
> +	vpu_inst_lock(inst);
> +	sequence =3D vdec->sequence++;
> +	vpu_buf =3D vdec_find_buffer(inst, frame->luma);
> +	vpu_inst_unlock(inst);
> +	if (!vpu_buf) {
> +		dev_err(inst->dev, "[%d] can't find buffer, id =3D %d, addr =3D 0x%x\n=
",
> +			inst->id, frame->id, frame->luma);
> +		return;
> +	}
> +	if (frame->skipped) {
> +		dev_dbg(inst->dev, "[%d] frame skip\n", inst->id);
> +		return;
> +	}
> +
> +	vbuf =3D &vpu_buf->m2m_buf.vb;
> +	if (vbuf->vb2_buf.index !=3D frame->id)
> +		dev_err(inst->dev, "[%d] buffer id(%d, %d) dismatch\n",
> +			inst->id, vbuf->vb2_buf.index, frame->id);
> +
> +	if (vpu_get_buffer_state(vbuf) !=3D VPU_BUF_STATE_DECODED)
> +		dev_err(inst->dev, "[%d] buffer(%d) ready without decoded\n", inst->id=
, frame->id);
> +	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_READY);
> +	vb2_set_plane_payload(&vbuf->vb2_buf, 0, inst->cap_format.sizeimage[0])=
;
> +	vb2_set_plane_payload(&vbuf->vb2_buf, 1, inst->cap_format.sizeimage[1])=
;
> +	vbuf->vb2_buf.timestamp =3D frame->timestamp;
> +	vbuf->field =3D inst->cap_format.field;
> +	vbuf->sequence =3D sequence;
> +	dev_dbg(inst->dev, "[%d][OUTPUT TS]%32lld\n", inst->id, frame->timestam=
p);
> +
> +	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> +	vpu_inst_lock(inst);
> +	vdec->timestamp =3D frame->timestamp;
> +	vdec->display_frame_count++;
> +	vpu_inst_unlock(inst);
> +	dev_dbg(inst->dev, "[%d] decoded : %d, display : %d, sequence : %d\n",
> +		inst->id, vdec->decoded_frame_count, vdec->display_frame_count, vdec->=
sequence);
> +}
> +
> +static void vdec_stop_done(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vpu_inst_lock(inst);
> +	vdec_update_state(inst, VPU_CODEC_STATE_DEINIT, 0);
> +	vdec->seq_hdr_found =3D 0;
> +	vdec->req_frame_count =3D 0;
> +	vdec->reset_codec =3D false;
> +	vdec->fixed_fmt =3D false;
> +	vdec->params.end_flag =3D 0;
> +	vdec->drain =3D 0;
> +	vdec->ts_pre_count =3D 0;
> +	vdec->timestamp =3D VPU_INVALID_TIMESTAMP;
> +	vdec->ts_start =3D VPU_INVALID_TIMESTAMP;
> +	vdec->ts_input =3D VPU_INVALID_TIMESTAMP;
> +	vdec->params.frame_count =3D 0;
> +	vdec->decoded_frame_count =3D 0;
> +	vdec->display_frame_count =3D 0;
> +	vdec->sequence =3D 0;
> +	vdec->eos_received =3D 0;
> +	vdec->is_source_changed =3D false;
> +	vdec->source_change =3D 0;
> +	vpu_inst_unlock(inst);
> +}
> +
> +static bool vdec_check_source_change(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	const struct vpu_format *fmt;
> +	int i;
> +
> +	if (!inst->fh.m2m_ctx)
> +		return false;
> +
> +	if (!vb2_is_streaming(v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx)))
> +		return true;
> +	fmt =3D vpu_helper_find_format(inst, inst->cap_format.type, vdec->codec=
_info.pixfmt);
> +	if (inst->cap_format.pixfmt !=3D vdec->codec_info.pixfmt)
> +		return true;
> +	if (inst->cap_format.width !=3D vdec->codec_info.decoded_width)
> +		return true;
> +	if (inst->cap_format.height !=3D vdec->codec_info.decoded_height)
> +		return true;
> +	if (vpu_get_num_buffers(inst, inst->cap_format.type) < inst->min_buffer=
_cap)
> +		return true;
> +	if (inst->crop.left !=3D vdec->codec_info.offset_x)
> +		return true;
> +	if (inst->crop.top !=3D vdec->codec_info.offset_y)
> +		return true;
> +	if (inst->crop.width !=3D vdec->codec_info.width)
> +		return true;
> +	if (inst->crop.height !=3D vdec->codec_info.height)
> +		return true;
> +	if (fmt && inst->cap_format.num_planes !=3D fmt->num_planes)
> +		return true;
> +	for (i =3D 0; i < inst->cap_format.num_planes; i++) {
> +		if (inst->cap_format.bytesperline[i] !=3D vdec->codec_info.bytesperlin=
e[i])
> +			return true;
> +		if (inst->cap_format.sizeimage[i] !=3D vdec->codec_info.sizeimage[i])
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void vdec_init_fmt(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	const struct vpu_format *fmt;
> +	int i;
> +
> +	fmt =3D vpu_helper_find_format(inst, inst->cap_format.type, vdec->codec=
_info.pixfmt);
> +	inst->out_format.width =3D vdec->codec_info.width;
> +	inst->out_format.height =3D vdec->codec_info.height;
> +	inst->cap_format.width =3D vdec->codec_info.decoded_width;
> +	inst->cap_format.height =3D vdec->codec_info.decoded_height;
> +	inst->cap_format.pixfmt =3D vdec->codec_info.pixfmt;
> +	if (fmt) {
> +		inst->cap_format.num_planes =3D fmt->num_planes;
> +		inst->cap_format.flags =3D fmt->flags;
> +	}
> +	for (i =3D 0; i < inst->cap_format.num_planes; i++) {
> +		inst->cap_format.bytesperline[i] =3D vdec->codec_info.bytesperline[i];
> +		inst->cap_format.sizeimage[i] =3D vdec->codec_info.sizeimage[i];
> +	}
> +	if (vdec->codec_info.progressive)
> +		inst->cap_format.field =3D V4L2_FIELD_NONE;
> +	else
> +		inst->cap_format.field =3D V4L2_FIELD_SEQ_BT;
> +	if (vdec->codec_info.color_primaries =3D=3D V4L2_COLORSPACE_DEFAULT)
> +		vdec->codec_info.color_primaries =3D V4L2_COLORSPACE_REC709;
> +	if (vdec->codec_info.transfer_chars =3D=3D V4L2_XFER_FUNC_DEFAULT)
> +		vdec->codec_info.transfer_chars =3D V4L2_XFER_FUNC_709;
> +	if (vdec->codec_info.matrix_coeffs =3D=3D V4L2_YCBCR_ENC_DEFAULT)
> +		vdec->codec_info.matrix_coeffs =3D V4L2_YCBCR_ENC_709;
> +	if (vdec->codec_info.full_range =3D=3D V4L2_QUANTIZATION_DEFAULT)
> +		vdec->codec_info.full_range =3D V4L2_QUANTIZATION_LIM_RANGE;
> +}
> +
> +static void vdec_init_crop(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	inst->crop.left =3D vdec->codec_info.offset_x;
> +	inst->crop.top =3D vdec->codec_info.offset_y;
> +	inst->crop.width =3D vdec->codec_info.width;
> +	inst->crop.height =3D vdec->codec_info.height;
> +}
> +
> +static void vdec_init_mbi(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vdec->mbi.size =3D vdec->codec_info.mbi_size;
> +	vdec->mbi.max_count =3D ARRAY_SIZE(vdec->mbi.buffer);
> +	scnprintf(vdec->mbi.name, sizeof(vdec->mbi.name), "mbi");
> +	vdec->mbi.type =3D MEM_RES_MBI;
> +	vdec->mbi.tag =3D vdec->seq_tag;
> +}
> +
> +static void vdec_init_dcp(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vdec->dcp.size =3D vdec->codec_info.dcp_size;
> +	vdec->dcp.max_count =3D ARRAY_SIZE(vdec->dcp.buffer);
> +	scnprintf(vdec->dcp.name, sizeof(vdec->dcp.name), "dcp");
> +	vdec->dcp.type =3D MEM_RES_DCP;
> +	vdec->dcp.tag =3D vdec->seq_tag;
> +}
> +
> +static void vdec_request_one_fs(struct vdec_fs_info *fs)
> +{
> +	fs->req_count++;
> +	if (fs->req_count > fs->max_count)
> +		fs->req_count =3D fs->max_count;
> +}
> +
> +static int vdec_alloc_fs_buffer(struct vpu_inst *inst, struct vdec_fs_in=
fo *fs)
> +{
> +	struct vpu_buffer *buffer;
> +
> +	if (!fs->size)
> +		return -EINVAL;
> +
> +	if (fs->count >=3D fs->req_count)
> +		return -EINVAL;
> +
> +	buffer =3D &fs->buffer[fs->count];
> +	if (buffer->virt && buffer->length >=3D fs->size)
> +		return 0;
> +
> +	vpu_free_dma(buffer);
> +	buffer->length =3D fs->size;
> +	return vpu_alloc_dma(inst->core, buffer);
> +}
> +
> +static void vdec_alloc_fs(struct vpu_inst *inst, struct vdec_fs_info *fs=
)
> +{
> +	int ret;
> +
> +	while (fs->count < fs->req_count) {
> +		ret =3D vdec_alloc_fs_buffer(inst, fs);
> +		if (ret)
> +			break;
> +		fs->count++;
> +	}
> +}
> +
> +static void vdec_clear_fs(struct vdec_fs_info *fs)
> +{
> +	u32 i;
> +
> +	if (!fs)
> +		return;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(fs->buffer); i++)
> +		vpu_free_dma(&fs->buffer[i]);
> +	memset(fs, 0, sizeof(*fs));
> +}
> +
> +static int vdec_response_fs(struct vpu_inst *inst, struct vdec_fs_info *=
fs)
> +{
> +	struct vpu_fs_info info;
> +	int ret;
> +
> +	if (fs->index >=3D fs->count)
> +		return 0;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.id =3D fs->index;
> +	info.type =3D fs->type;
> +	info.tag =3D fs->tag;
> +	info.luma_addr =3D fs->buffer[fs->index].phys;
> +	info.luma_size =3D fs->buffer[fs->index].length;
> +	ret =3D vpu_session_alloc_fs(inst, &info);
> +	if (ret)
> +		return ret;
> +
> +	fs->index++;
> +	return 0;
> +}
> +
> +static int vdec_response_frame_abnormal(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vpu_fs_info info;
> +
> +	if (!vdec->req_frame_count)
> +		return 0;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.type =3D MEM_RES_FRAME;
> +	info.tag =3D vdec->seq_tag + 0xf0;
> +	vpu_session_alloc_fs(inst, &info);
> +	vdec->req_frame_count--;
> +
> +	return 0;
> +}
> +
> +static int vdec_response_frame(struct vpu_inst *inst, struct vb2_v4l2_bu=
ffer *vbuf)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vpu_vb2_buffer *vpu_buf;
> +	struct vpu_fs_info info;
> +	int ret;
> +
> +	if (inst->state !=3D VPU_CODEC_STATE_ACTIVE)
> +		return -EINVAL;
> +
> +	if (!vdec->req_frame_count)
> +		return -EINVAL;
> +
> +	if (!vbuf)
> +		return -EINVAL;
> +
> +	if (vdec->slots[vbuf->vb2_buf.index]) {
> +		dev_err(inst->dev, "[%d] repeat alloc fs %d\n",
> +			inst->id, vbuf->vb2_buf.index);
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(inst->dev, "[%d] state =3D %d, alloc fs %d, tag =3D 0x%x\n",
> +		inst->id, inst->state, vbuf->vb2_buf.index, vdec->seq_tag);
> +	vpu_buf =3D to_vpu_vb2_buffer(vbuf);
> +
> +	memset(&info, 0, sizeof(info));
> +	info.id =3D vbuf->vb2_buf.index;
> +	info.type =3D MEM_RES_FRAME;
> +	info.tag =3D vdec->seq_tag;
> +	info.luma_addr =3D vpu_get_vb_phy_addr(&vbuf->vb2_buf, 0);
> +	info.luma_size =3D inst->cap_format.sizeimage[0];
> +	info.chroma_addr =3D vpu_get_vb_phy_addr(&vbuf->vb2_buf, 1);
> +	info.chromau_size =3D inst->cap_format.sizeimage[1];
> +	info.bytesperline =3D inst->cap_format.bytesperline[0];
> +	ret =3D vpu_session_alloc_fs(inst, &info);
> +	if (ret)
> +		return ret;
> +
> +	vpu_buf->tag =3D info.tag;
> +	vpu_buf->luma =3D info.luma_addr;
> +	vpu_buf->chroma_u =3D info.chromau_size;
> +	vpu_buf->chroma_v =3D 0;
> +	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_INUSE);
> +	vdec->slots[info.id] =3D vpu_buf;
> +	vdec->req_frame_count--;
> +
> +	return 0;
> +}
> +
> +static void vdec_response_fs_request(struct vpu_inst *inst, bool force)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	int i;
> +	int ret;
> +
> +	if (force) {
> +		for (i =3D vdec->req_frame_count; i > 0; i--)
> +			vdec_response_frame_abnormal(inst);
> +		return;
> +	}
> +
> +	for (i =3D vdec->req_frame_count; i > 0; i--) {
> +		ret =3D vpu_process_capture_buffer(inst);
> +		if (ret)
> +			break;
> +		if (vdec->eos_received)
> +			break;
> +	}
> +
> +	for (i =3D vdec->mbi.index; i < vdec->mbi.count; i++) {
> +		if (vdec_response_fs(inst, &vdec->mbi))
> +			break;
> +		if (vdec->eos_received)
> +			break;
> +	}
> +	for (i =3D vdec->dcp.index; i < vdec->dcp.count; i++) {
> +		if (vdec_response_fs(inst, &vdec->dcp))
> +			break;
> +		if (vdec->eos_received)
> +			break;
> +	}
> +}
> +
> +static void vdec_response_fs_release(struct vpu_inst *inst, u32 id, u32 =
tag)
> +{
> +	struct vpu_fs_info info;
> +
> +	memset(&info, 0, sizeof(info));
> +	info.id =3D id;
> +	info.tag =3D tag;
> +	vpu_session_release_fs(inst, &info);
> +}
> +
> +static void vdec_recycle_buffer(struct vpu_inst *inst, struct vb2_v4l2_b=
uffer *vbuf)
> +{
> +	if (!inst->fh.m2m_ctx)
> +		return;
> +	if (vbuf->vb2_buf.state !=3D VB2_BUF_STATE_ACTIVE)
> +		return;
> +	if (vpu_find_buf_by_idx(inst, vbuf->vb2_buf.type, vbuf->vb2_buf.index))
> +		return;
> +	v4l2_m2m_buf_queue(inst->fh.m2m_ctx, vbuf);
> +}
> +
> +static void vdec_clear_slots(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vpu_vb2_buffer *vpu_buf;
> +	struct vb2_v4l2_buffer *vbuf;
> +	int i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(vdec->slots); i++) {
> +		if (!vdec->slots[i])
> +			continue;
> +
> +		vpu_buf =3D vdec->slots[i];
> +		vbuf =3D &vpu_buf->m2m_buf.vb;
> +
> +		vdec_recycle_buffer(inst, vbuf);
> +		vdec->slots[i]->state =3D VPU_BUF_STATE_IDLE;
> +		vdec->slots[i] =3D NULL;
> +	}
> +}
> +
> +static void vdec_event_seq_hdr(struct vpu_inst *inst, struct vpu_dec_cod=
ec_info *hdr)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vpu_inst_lock(inst);
> +	memcpy(&vdec->codec_info, hdr, sizeof(vdec->codec_info));
> +
> +	vpu_trace(inst->dev, "[%d] %d x %d, crop : (%d, %d) %d x %d, %d, %d\n",
> +		  inst->id,
> +		  vdec->codec_info.decoded_width,
> +		  vdec->codec_info.decoded_height,
> +		  vdec->codec_info.offset_x,
> +		  vdec->codec_info.offset_y,
> +		  vdec->codec_info.width,
> +		  vdec->codec_info.height,
> +		  hdr->num_ref_frms,
> +		  hdr->num_dpb_frms);
> +	inst->min_buffer_cap =3D hdr->num_ref_frms + hdr->num_dpb_frms;
> +	vdec->is_source_changed =3D vdec_check_source_change(inst);
> +	vdec_init_fmt(inst);
> +	vdec_init_crop(inst);
> +	vdec_init_mbi(inst);
> +	vdec_init_dcp(inst);
> +	if (!vdec->seq_hdr_found) {
> +		vdec->seq_tag =3D vdec->codec_info.tag;
> +		if (vdec->is_source_changed) {
> +			vdec_update_state(inst, VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE, 0);
> +			vpu_notify_source_change(inst);
> +			vdec->is_source_changed =3D false;
> +		}
> +	}
> +	if (vdec->seq_tag !=3D vdec->codec_info.tag) {
> +		vdec_response_fs_request(inst, true);
> +		vpu_trace(inst->dev, "[%d] seq tag change: %d -> %d\n",
> +			  inst->id, vdec->seq_tag, vdec->codec_info.tag);
> +	}
> +	vdec->seq_hdr_found++;
> +	vdec->fixed_fmt =3D true;
> +	vpu_inst_unlock(inst);
> +}
> +
> +static void vdec_event_resolution_change(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vpu_trace(inst->dev, "[%d]\n", inst->id);
> +	vpu_inst_lock(inst);
> +	vdec->seq_tag =3D vdec->codec_info.tag;
> +	vdec_clear_fs(&vdec->mbi);
> +	vdec_clear_fs(&vdec->dcp);
> +	vdec_clear_slots(inst);
> +	vdec_init_mbi(inst);
> +	vdec_init_dcp(inst);
> +	if (vdec->is_source_changed) {
> +		vdec_update_state(inst, VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE, 0);
> +		vdec->source_change++;
> +		vdec_handle_resolution_change(inst);
> +		vdec->is_source_changed =3D false;
> +	}
> +	vpu_inst_unlock(inst);
> +}
> +
> +static void vdec_event_req_fs(struct vpu_inst *inst, struct vpu_fs_info =
*fs)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	if (!fs)
> +		return;
> +
> +	vpu_inst_lock(inst);
> +
> +	switch (fs->type) {
> +	case MEM_RES_FRAME:
> +		vdec->req_frame_count++;
> +		break;
> +	case MEM_RES_MBI:
> +		vdec_request_one_fs(&vdec->mbi);
> +		break;
> +	case MEM_RES_DCP:
> +		vdec_request_one_fs(&vdec->dcp);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	vdec_alloc_fs(inst, &vdec->mbi);
> +	vdec_alloc_fs(inst, &vdec->dcp);
> +
> +	vdec_response_fs_request(inst, false);
> +
> +	vpu_inst_unlock(inst);
> +}
> +
> +static void vdec_evnet_rel_fs(struct vpu_inst *inst, struct vpu_fs_info =
*fs)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vpu_vb2_buffer *vpu_buf;
> +	struct vb2_v4l2_buffer *vbuf;
> +
> +	if (!fs || fs->id >=3D ARRAY_SIZE(vdec->slots))
> +		return;
> +	if (fs->type !=3D MEM_RES_FRAME)
> +		return;
> +
> +	if (fs->id >=3D vpu_get_num_buffers(inst, inst->cap_format.type)) {
> +		dev_err(inst->dev, "[%d] invalid fs(%d) to release\n", inst->id, fs->i=
d);
> +		return;
> +	}
> +
> +	vpu_inst_lock(inst);
> +	vpu_buf =3D vdec->slots[fs->id];
> +	vdec->slots[fs->id] =3D NULL;
> +
> +	if (!vpu_buf) {
> +		dev_dbg(inst->dev, "[%d] fs[%d] has bee released\n", inst->id, fs->id)=
;
> +		goto exit;
> +	}
> +
> +	vbuf =3D &vpu_buf->m2m_buf.vb;
> +	if (vpu_get_buffer_state(vbuf) =3D=3D VPU_BUF_STATE_DECODED) {
> +		dev_dbg(inst->dev, "[%d] frame skip\n", inst->id);
> +		vdec->sequence++;
> +	}
> +
> +	vdec_response_fs_release(inst, fs->id, vpu_buf->tag);
> +	if (vpu_get_buffer_state(vbuf) !=3D VPU_BUF_STATE_READY)
> +		vdec_recycle_buffer(inst, vbuf);
> +
> +	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
> +	vpu_process_capture_buffer(inst);
> +
> +exit:
> +	vpu_inst_unlock(inst);
> +}
> +
> +static void vdec_event_eos(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vpu_trace(inst->dev, "[%d] input : %d, decoded : %d, display : %d, sequ=
ence : %d\n",
> +		  inst->id,
> +		  vdec->params.frame_count,
> +		  vdec->decoded_frame_count,
> +		  vdec->display_frame_count,
> +		  vdec->sequence);
> +	vpu_inst_lock(inst);
> +	vdec->eos_received++;
> +	vdec->fixed_fmt =3D false;
> +	inst->min_buffer_cap =3D VDEC_MIN_BUFFER_CAP;
> +	vdec_update_state(inst, VPU_CODEC_STATE_DRAIN, 0);
> +	vdec_set_last_buffer_dequeued(inst);
> +	vpu_inst_unlock(inst);
> +}
> +
> +static void vdec_event_notify(struct vpu_inst *inst, u32 event, void *da=
ta)
> +{
> +	switch (event) {
> +	case VPU_MSG_ID_SEQ_HDR_FOUND:
> +		vdec_event_seq_hdr(inst, data);
> +		break;
> +	case VPU_MSG_ID_RES_CHANGE:
> +		vdec_event_resolution_change(inst);
> +		break;
> +	case VPU_MSG_ID_FRAME_REQ:
> +		vdec_event_req_fs(inst, data);
> +		break;
> +	case VPU_MSG_ID_FRAME_RELEASE:
> +		vdec_evnet_rel_fs(inst, data);
> +		break;
> +	case VPU_MSG_ID_PIC_EOS:
> +		vdec_event_eos(inst);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static int vdec_process_output(struct vpu_inst *inst, struct vb2_buffer =
*vb)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vb2_v4l2_buffer *vbuf;
> +	struct vpu_rpc_buffer_desc desc;
> +	s64 timestamp;
> +	u32 free_space;
> +	int ret;
> +
> +	vbuf =3D to_vb2_v4l2_buffer(vb);
> +	dev_dbg(inst->dev, "[%d] dec output [%d] %d : %ld\n",
> +		inst->id, vbuf->sequence, vb->index, vb2_get_plane_payload(vb, 0));
> +
> +	if (inst->state =3D=3D VPU_CODEC_STATE_DEINIT)
> +		return -EINVAL;
> +	if (vdec->reset_codec)
> +		return -EINVAL;
> +
> +	if (inst->state =3D=3D VPU_CODEC_STATE_STARTED)
> +		vdec_update_state(inst, VPU_CODEC_STATE_ACTIVE, 0);
> +
> +	ret =3D vpu_iface_get_stream_buffer_desc(inst, &desc);
> +	if (ret)
> +		return ret;
> +
> +	free_space =3D vpu_helper_get_free_space(inst);
> +	if (free_space < vb2_get_plane_payload(vb, 0) + 0x40000)
> +		return -ENOMEM;
> +
> +	timestamp =3D vb->timestamp;
> +	if (timestamp >=3D 0 && vdec->ts_start < 0)
> +		vdec->ts_start =3D timestamp;
> +	if (vdec->ts_input < timestamp)
> +		vdec->ts_input =3D timestamp;
> +
> +	ret =3D vpu_iface_input_frame(inst, vb);
> +	if (ret < 0)
> +		return -ENOMEM;
> +
> +	dev_dbg(inst->dev, "[%d][INPUT  TS]%32lld\n", inst->id, vb->timestamp);
> +	vdec->ts_pre_count++;
> +	vdec->params.frame_count++;
> +
> +	v4l2_m2m_src_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
> +	vpu_set_buffer_state(vbuf, VPU_BUF_STATE_IDLE);
> +	v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> +
> +	if (vdec->drain)
> +		vdec_drain(inst);
> +
> +	return 0;
> +}
> +
> +static int vdec_process_capture(struct vpu_inst *inst, struct vb2_buffer=
 *vb)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> +	int ret;
> +
> +	if (inst->state =3D=3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
> +		return -EINVAL;
> +	if (vdec->reset_codec)
> +		return -EINVAL;
> +
> +	ret =3D vdec_response_frame(inst, vbuf);
> +	if (ret)
> +		return ret;
> +	v4l2_m2m_dst_buf_remove_by_buf(inst->fh.m2m_ctx, vbuf);
> +	return 0;
> +}
> +
> +static void vdec_on_queue_empty(struct vpu_inst *inst, u32 type)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(type))
> +		return;
> +
> +	vdec_handle_resolution_change(inst);
> +	if (vdec->eos_received)
> +		vdec_set_last_buffer_dequeued(inst);
> +}
> +
> +static void vdec_abort(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	struct vpu_rpc_buffer_desc desc;
> +	int ret;
> +
> +	vpu_trace(inst->dev, "[%d] state =3D %d\n", inst->id, inst->state);
> +	vpu_iface_add_scode(inst, SCODE_PADDING_ABORT);
> +	vdec->params.end_flag =3D 1;
> +	vpu_iface_set_decode_params(inst, &vdec->params, 1);
> +
> +	vpu_session_abort(inst);
> +
> +	ret =3D vpu_iface_get_stream_buffer_desc(inst, &desc);
> +	if (!ret)
> +		vpu_iface_update_stream_buffer(inst, desc.rptr, 1);
> +
> +	vpu_session_rst_buf(inst);
> +	vpu_trace(inst->dev, "[%d] input : %d, decoded : %d, display : %d, sequ=
ence : %d\n",
> +		  inst->id,
> +		  vdec->params.frame_count,
> +		  vdec->decoded_frame_count,
> +		  vdec->display_frame_count,
> +		  vdec->sequence);
> +	vdec->params.end_flag =3D 0;
> +	vdec->drain =3D 0;
> +	vdec->ts_pre_count =3D 0;
> +	vdec->timestamp =3D VPU_INVALID_TIMESTAMP;
> +	vdec->ts_start =3D VPU_INVALID_TIMESTAMP;
> +	vdec->ts_input =3D VPU_INVALID_TIMESTAMP;
> +	vdec->params.frame_count =3D 0;
> +	vdec->decoded_frame_count =3D 0;
> +	vdec->display_frame_count =3D 0;
> +	vdec->sequence =3D 0;
> +}
> +
> +static void vdec_stop(struct vpu_inst *inst, bool free)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	vdec_clear_slots(inst);
> +	if (inst->state !=3D VPU_CODEC_STATE_DEINIT)
> +		vpu_session_stop(inst);
> +	vdec_clear_fs(&vdec->mbi);
> +	vdec_clear_fs(&vdec->dcp);
> +	if (free) {
> +		vpu_free_dma(&vdec->udata);
> +		vpu_free_dma(&inst->stream_buffer);
> +	}
> +	vdec_update_state(inst, VPU_CODEC_STATE_DEINIT, 1);
> +	vdec->reset_codec =3D false;
> +}
> +
> +static void vdec_release(struct vpu_inst *inst)
> +{
> +	if (inst->id !=3D VPU_INST_NULL_ID)
> +		vpu_trace(inst->dev, "[%d]\n", inst->id);
> +	vpu_inst_lock(inst);
> +	vdec_stop(inst, true);
> +	vpu_inst_unlock(inst);
> +}
> +
> +static void vdec_cleanup(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec;
> +
> +	if (!inst)
> +		return;
> +
> +	vdec =3D inst->priv;
> +	if (vdec)
> +		vfree(vdec);
> +	inst->priv =3D NULL;
> +	vfree(inst);
> +}
> +
> +static void vdec_init_params(struct vdec_t *vdec)
> +{
> +	vdec->params.frame_count =3D 0;
> +	vdec->params.end_flag =3D 0;
> +}
> +
> +static int vdec_start(struct vpu_inst *inst)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	int stream_buffer_size;
> +	int ret;
> +
> +	if (inst->state !=3D VPU_CODEC_STATE_DEINIT)
> +		return 0;
> +
> +	vpu_trace(inst->dev, "[%d]\n", inst->id);
> +	if (!vdec->udata.virt) {
> +		vdec->udata.length =3D 0x1000;
> +		ret =3D vpu_alloc_dma(inst->core, &vdec->udata);
> +		if (ret) {
> +			dev_err(inst->dev, "[%d] alloc udata fail\n", inst->id);
> +			goto error;
> +		}
> +	}
> +
> +	if (!inst->stream_buffer.virt) {
> +		stream_buffer_size =3D vpu_iface_get_stream_buffer_size(inst->core);
> +		if (stream_buffer_size > 0) {
> +			inst->stream_buffer.length =3D stream_buffer_size;
> +			ret =3D vpu_alloc_dma(inst->core, &inst->stream_buffer);
> +			if (ret) {
> +				dev_err(inst->dev, "[%d] alloc stream buffer fail\n", inst->id);
> +				goto error;
> +			}
> +			inst->use_stream_buffer =3D true;
> +		}
> +	}
> +
> +	if (inst->use_stream_buffer)
> +		vpu_iface_config_stream_buffer(inst, &inst->stream_buffer);
> +	vpu_iface_init_instance(inst);
> +	vdec->params.udata.base =3D vdec->udata.phys;
> +	vdec->params.udata.size =3D vdec->udata.length;
> +	ret =3D vpu_iface_set_decode_params(inst, &vdec->params, 0);
> +	if (ret) {
> +		dev_err(inst->dev, "[%d] set decode params fail\n", inst->id);
> +		goto error;
> +	}
> +
> +	vdec_init_params(vdec);
> +	ret =3D vpu_session_start(inst);
> +	if (ret) {
> +		dev_err(inst->dev, "[%d] start fail\n", inst->id);
> +		goto error;
> +	}
> +
> +	vdec_update_state(inst, VPU_CODEC_STATE_STARTED, 0);
> +
> +	return 0;
> +error:
> +	vpu_free_dma(&vdec->udata);
> +	vpu_free_dma(&inst->stream_buffer);
> +	return ret;
> +}
> +
> +static int vdec_start_session(struct vpu_inst *inst, u32 type)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	int ret =3D 0;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(type)) {
> +		if (vdec->reset_codec)
> +			vdec_stop(inst, false);
> +		if (inst->state =3D=3D VPU_CODEC_STATE_DEINIT) {
> +			ret =3D vdec_start(inst);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	if (V4L2_TYPE_IS_OUTPUT(type)) {
> +		if (inst->state =3D=3D VPU_CODEC_STATE_SEEK)
> +			vdec_update_state(inst, vdec->state, 1);
> +		vdec->eos_received =3D 0;
> +		vpu_process_output_buffer(inst);
> +	} else {
> +		vdec_cmd_start(inst);
> +	}
> +	if (inst->state =3D=3D VPU_CODEC_STATE_ACTIVE)
> +		vdec_response_fs_request(inst, false);
> +
> +	return ret;
> +}
> +
> +static int vdec_stop_session(struct vpu_inst *inst, u32 type)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +
> +	if (inst->state =3D=3D VPU_CODEC_STATE_DEINIT)
> +		return 0;
> +
> +	if (V4L2_TYPE_IS_OUTPUT(type)) {
> +		vdec_update_state(inst, VPU_CODEC_STATE_SEEK, 0);
> +		vdec->drain =3D 0;
> +	} else {
> +		if (inst->state !=3D VPU_CODEC_STATE_DYAMIC_RESOLUTION_CHANGE)
> +			vdec_abort(inst);
> +
> +		vdec->eos_received =3D 0;
> +		vdec_clear_slots(inst);
> +	}
> +
> +	return 0;
> +}
> +
> +static int vdec_get_debug_info(struct vpu_inst *inst, char *str, u32 siz=
e, u32 i)
> +{
> +	struct vdec_t *vdec =3D inst->priv;
> +	int num =3D -1;
> +
> +	switch (i) {
> +	case 0:
> +		num =3D scnprintf(str, size,
> +				"req_frame_count =3D %d\ninterlaced =3D %d\n",
> +				vdec->req_frame_count,
> +				vdec->codec_info.progressive ? 0 : 1);
> +		break;
> +	case 1:
> +		num =3D scnprintf(str, size,
> +				"mbi: size =3D 0x%x request =3D %d, alloc =3D %d, response =3D %d\n"=
,
> +				vdec->mbi.size,
> +				vdec->mbi.req_count,
> +				vdec->mbi.count,
> +				vdec->mbi.index);
> +		break;
> +	case 2:
> +		num =3D scnprintf(str, size,
> +				"dcp: size =3D 0x%x request =3D %d, alloc =3D %d, response =3D %d\n"=
,
> +				vdec->dcp.size,
> +				vdec->dcp.req_count,
> +				vdec->dcp.count,
> +				vdec->dcp.index);
> +		break;
> +	case 3:
> +		num =3D scnprintf(str, size, "input_frame_count =3D %d\n", vdec->param=
s.frame_count);
> +		break;
> +	case 4:
> +		num =3D scnprintf(str, size, "decoded_frame_count =3D %d\n", vdec->dec=
oded_frame_count);
> +		break;
> +	case 5:
> +		num =3D scnprintf(str, size, "display_frame_count =3D %d\n", vdec->dis=
play_frame_count);
> +		break;
> +	case 6:
> +		num =3D scnprintf(str, size, "sequence =3D %d\n", vdec->sequence);
> +		break;
> +	case 7:
> +		num =3D scnprintf(str, size, "drain =3D %d, eos =3D %d, source_change =
=3D %d\n",
> +				vdec->drain, vdec->eos_received, vdec->source_change);
> +		break;
> +	case 8:
> +		num =3D scnprintf(str, size, "ts_pre_count =3D %d, frame_depth =3D %d\=
n",
> +				vdec->ts_pre_count, vdec->frame_depth);
> +		break;
> +	case 9:
> +		num =3D scnprintf(str, size, "fps =3D %d/%d\n",
> +				vdec->codec_info.frame_rate.numerator,
> +				vdec->codec_info.frame_rate.denominator);
> +		break;
> +	case 10:
> +	{
> +		s64 timestamp =3D vdec->timestamp;
> +		s64 ts_start =3D vdec->ts_start;
> +		s64 ts_input =3D vdec->ts_input;
> +
> +		num =3D scnprintf(str, size, "timestamp =3D %9lld.%09lld(%9lld.%09lld,=
 %9lld.%09lld)\n",
> +				timestamp / NSEC_PER_SEC,
> +				timestamp % NSEC_PER_SEC,
> +				ts_start / NSEC_PER_SEC,
> +				ts_start % NSEC_PER_SEC,
> +				ts_input / NSEC_PER_SEC,
> +				ts_input % NSEC_PER_SEC);
> +	}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return num;
> +}
> +
> +static struct vpu_inst_ops vdec_inst_ops =3D {
> +	.ctrl_init =3D vdec_ctrl_init,
> +	.check_ready =3D vdec_check_ready,
> +	.buf_done =3D vdec_buf_done,
> +	.get_one_frame =3D vdec_frame_decoded,
> +	.stop_done =3D vdec_stop_done,
> +	.event_notify =3D vdec_event_notify,
> +	.release =3D vdec_release,
> +	.cleanup =3D vdec_cleanup,
> +	.start =3D vdec_start_session,
> +	.stop =3D vdec_stop_session,
> +	.process_output =3D vdec_process_output,
> +	.process_capture =3D vdec_process_capture,
> +	.on_queue_empty =3D vdec_on_queue_empty,
> +	.get_debug_info =3D vdec_get_debug_info,
> +	.wait_prepare =3D vpu_inst_unlock,
> +	.wait_finish =3D vpu_inst_lock,
> +};
> +
> +static void vdec_init(struct file *file)
> +{
> +	struct vpu_inst *inst =3D to_inst(file);
> +	struct vdec_t *vdec;
> +	struct v4l2_format f;
> +
> +	vdec =3D inst->priv;
> +	vdec->frame_depth =3D VDEC_FRAME_DEPTH;
> +	vdec->timestamp =3D VPU_INVALID_TIMESTAMP;
> +	vdec->ts_start =3D VPU_INVALID_TIMESTAMP;
> +	vdec->ts_input =3D VPU_INVALID_TIMESTAMP;
> +
> +	memset(&f, 0, sizeof(f));
> +	f.type =3D V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE;
> +	f.fmt.pix_mp.pixelformat =3D V4L2_PIX_FMT_H264;
> +	f.fmt.pix_mp.width =3D 1280;
> +	f.fmt.pix_mp.height =3D 720;
> +	f.fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> +	vdec_s_fmt(file, &inst->fh, &f);
> +
> +	memset(&f, 0, sizeof(f));
> +	f.type =3D V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE;
> +	f.fmt.pix_mp.pixelformat =3D V4L2_PIX_FMT_NV12M_8L128;
> +	f.fmt.pix_mp.width =3D 1280;
> +	f.fmt.pix_mp.height =3D 720;
> +	f.fmt.pix_mp.field =3D V4L2_FIELD_NONE;
> +	vdec_s_fmt(file, &inst->fh, &f);
> +}
> +
> +static int vdec_open(struct file *file)
> +{
> +	struct vpu_inst *inst;
> +	struct vdec_t *vdec;
> +	int ret;
> +
> +	inst =3D vzalloc(sizeof(*inst));
> +	if (!inst)
> +		return -ENOMEM;
> +
> +	vdec =3D vzalloc(sizeof(*vdec));
> +	if (!vdec) {
> +		vfree(inst);
> +		return -ENOMEM;
> +	}
> +
> +	inst->ops =3D &vdec_inst_ops;
> +	inst->formats =3D vdec_formats;
> +	inst->type =3D VPU_CORE_TYPE_DEC;
> +	inst->priv =3D vdec;
> +
> +	ret =3D vpu_v4l2_open(file, inst);
> +	if (ret)
> +		return ret;
> +
> +	vdec->fixed_fmt =3D false;
> +	inst->min_buffer_cap =3D VDEC_MIN_BUFFER_CAP;
> +	vdec_init(file);
> +
> +	return 0;
> +}
> +
> +static __poll_t vdec_poll(struct file *file, poll_table *wait)
> +{
> +	struct vpu_inst *inst =3D to_inst(file);
> +	struct vb2_queue *src_q, *dst_q;
> +	__poll_t ret;
> +
> +	ret =3D v4l2_m2m_fop_poll(file, wait);
> +	src_q =3D v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
> +	dst_q =3D v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
> +	if (vb2_is_streaming(src_q) && !vb2_is_streaming(dst_q))
> +		ret &=3D (~EPOLLERR);
> +	if (!src_q->error && !dst_q->error &&
> +	    (vb2_is_streaming(src_q) && list_empty(&src_q->queued_list)) &&
> +	    (vb2_is_streaming(dst_q) && list_empty(&dst_q->queued_list)))
> +		ret &=3D (~EPOLLERR);
> +
> +	return ret;
> +}
> +
> +static const struct v4l2_file_operations vdec_fops =3D {
> +	.owner =3D THIS_MODULE,
> +	.open =3D vdec_open,
> +	.release =3D vpu_v4l2_close,
> +	.unlocked_ioctl =3D video_ioctl2,
> +	.poll =3D vdec_poll,
> +	.mmap =3D v4l2_m2m_fop_mmap,
> +};
> +
> +const struct v4l2_ioctl_ops *vdec_get_ioctl_ops(void)
> +{
> +	return &vdec_ioctl_ops;
> +}
> +
> +const struct v4l2_file_operations *vdec_get_fops(void)
> +{
> +	return &vdec_fops;
> +}

