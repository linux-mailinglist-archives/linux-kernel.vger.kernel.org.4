Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84B0655063
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 13:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiLWMcL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 07:32:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236016AbiLWMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 07:32:09 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243F1140B9
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:32:07 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-3cbdd6c00adso64436107b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Dec 2022 04:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KtHScANyAZHZYw+qOTo+vcgx2fpdVnVrJrjhKa+73As=;
        b=mVRdmXQmaPWk77MvfIMd2Gzy5pYNLII5LzpaQQOv297nqzJmPTpViKOBU6lw4/K2x6
         zZXn8u1PFdRSV+6zR8Q1Osuw5kq2eDFG7mrtS3ZUAUHnqNqq5hUwzH0/1A+LXoPuwwyj
         rN0j7lBwlYSl/yxoKuCwVOQkeXpConY45N74xkDe3XRPLMs5so07Y6H21I+IBQvkCbpX
         yNQBjPhpd9kLq8PTAQN9QqD/6FVm50knYIr2U1zVE5wkD/qC72PSuLlB1+I3UcKKrymG
         IxnBH7n3xQgFw1IGiRaWu5RFuitSrMW34C8ncaxwjviHWsaGG7zdshmuIpDVHWfGz7ro
         GTRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KtHScANyAZHZYw+qOTo+vcgx2fpdVnVrJrjhKa+73As=;
        b=mNr7ioGYT0dqZE5j2iTeLwvKV3aDCx0CiigfQUxJsxLphu53UwPz6i+Tn8sgkm0Iol
         EVrMEM18a1kYoVrmy1Ua8iakmkXslKKsNgjCQA9SqdgoNs90PPtjFUyDU8B2I+B9jRh8
         JdhBCON5s5Pjz5N3XEZQe1+i6zVsws7WWD1LA3nT3QMTFll4gK6E2xuiXgvKTTT/oL3E
         cM/FZFjCeE5YSe9KoFsUjw7CVdur5gsKFwBU1FgAPowPjFlDZBrT/hdDiUXGKlIDkdaR
         rjF2r8k9wpY0st1co4sAn03qyayMvQWz80J/v3MGLL8NrxCi+UvrOFlEz0dqFzWmXFBU
         qYNA==
X-Gm-Message-State: AFqh2koZJ2MBhJ8YlkKztRVqy0d3VWD2cccBYrli72Jn3t08jIjMM7zn
        LC6tYFsStuqzAjR8/9AfpKdMGg==
X-Google-Smtp-Source: AMrXdXuaG6N4MhNXHs1n1XYL2frXr1/MtnDAVX/AjUzM4CIMuJ5zj6cKRRnwRNHoSRBvffGXcEE3qQ==
X-Received: by 2002:a05:7500:f8e:b0:ee:223b:ee71 with SMTP id km14-20020a0575000f8e00b000ee223bee71mr642072gab.5.1671798726128;
        Fri, 23 Dec 2022 04:32:06 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id t1-20020a37ea01000000b006fefa5f7fcesm2229444qkj.10.2022.12.23.04.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 04:32:05 -0800 (PST)
Message-ID: <be925c7e05dcb9935301243e24e4b79c8f6f58b4.camel@ndufresne.ca>
Subject: Re: [PATCH v2] venus: venc: add handling for VIDIOC_ENCODER_CMD
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        linux-media@vger.kernel.org, stanimir.k.varbanov@gmail.com,
        quic_vgarodia@quicinc.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Date:   Fri, 23 Dec 2022 07:32:04 -0500
In-Reply-To: <1671790573-6432-1-git-send-email-quic_dikshita@quicinc.com>
References: <1671790573-6432-1-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dikshita,

Le vendredi 23 d=C3=A9cembre 2022 =C3=A0 15:46 +0530, Dikshita Agarwal a =
=C3=A9crit=C2=A0:
> Add handling for below commands in encoder:
> 1. V4L2_ENC_CMD_STOP
> 2. V4L2_ENC_CMD_START
>=20
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/core.h |  9 +++++
>  drivers/media/platform/qcom/venus/venc.c | 63 ++++++++++++++++++++++++++=
++++++
>  2 files changed, 72 insertions(+)
>=20
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/pla=
tform/qcom/venus/core.h
> index 32551c2..d147154 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -317,6 +317,14 @@ enum venus_dec_state {
>  	VENUS_DEC_STATE_DRC		=3D 7,
>  };
> =20
> +enum venus_enc_state {
> +	VENUS_ENC_STATE_DEINIT		=3D 0,
> +	VENUS_ENC_STATE_INIT		=3D 1,
> +	VENUS_ENC_STATE_ENCODING	=3D 2,
> +	VENUS_ENC_STATE_STOPPED		=3D 3,
> +	VENUS_ENC_STATE_DRAIN		=3D 4,
> +};
> +
>  struct venus_ts_metadata {
>  	bool used;
>  	u64 ts_ns;
> @@ -428,6 +436,7 @@ struct venus_inst {
>  	u8 quantization;
>  	u8 xfer_func;
>  	enum venus_dec_state codec_state;
> +	enum venus_enc_state enc_state;
>  	wait_queue_head_t reconf_wait;
>  	unsigned int subscriptions;
>  	int buf_count;
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/pla=
tform/qcom/venus/venc.c
> index cdb1254..a7804b0 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -520,6 +520,46 @@ static int venc_subscribe_event(struct v4l2_fh *fh,
>  	}
>  }
> =20
> +static int
> +venc_encoder_cmd(struct file *file, void *fh, struct v4l2_encoder_cmd *c=
md)
> +{
> +	struct venus_inst *inst =3D to_inst(file);
> +	struct hfi_frame_data fdata =3D {0};
> +	int ret =3D 0;
> +
> +	ret =3D v4l2_m2m_ioctl_try_encoder_cmd(file, fh, cmd);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&inst->lock);
> +
> +	if (cmd->cmd =3D=3D V4L2_ENC_CMD_STOP &&
> +	    inst->enc_state =3D=3D VENUS_ENC_STATE_ENCODING) {
> +		/*
> +		 * Implement V4L2_ENC_CMD_STOP by enqueue an empty buffer on
> +		 * encoder input to signal EOS.
> +		 */
> +		if (!(inst->streamon_out && inst->streamon_cap))
> +			goto unlock;
> +
> +		fdata.buffer_type =3D HFI_BUFFER_INPUT;
> +		fdata.flags |=3D HFI_BUFFERFLAG_EOS;
> +		fdata.device_addr =3D 0xdeadb000;
> +
> +		ret =3D hfi_session_process_buf(inst, &fdata);
> +
> +		inst->enc_state =3D VENUS_ENC_STATE_DRAIN;
> +	} else if (cmd->cmd =3D=3D V4L2_ENC_CMD_START &&
> +		inst->enc_state =3D=3D VENUS_ENC_STATE_STOPPED) {
> +		vb2_clear_last_buffer_dequeued(&inst->fh.m2m_ctx->cap_q_ctx.q);
> +		inst->enc_state =3D VENUS_ENC_STATE_ENCODING;
> +	}
> +
> +unlock:
> +	mutex_unlock(&inst->lock);
> +	return ret;

I think you are missing a return value case. I would expect the driver to r=
eturn
EBUSY (or something similar) if we call START while in VENUS_ENC_STATE_DRAI=
N
here. I suspect the case of calling STOP while in DRAIN or STOPPED state is=
 fine
though, I'll leave it to you to analyse further.

regards,
Nicolas

> +}
> +
>  static const struct v4l2_ioctl_ops venc_ioctl_ops =3D {
>  	.vidioc_querycap =3D venc_querycap,
>  	.vidioc_enum_fmt_vid_cap =3D venc_enum_fmt,
> @@ -548,6 +588,7 @@ static const struct v4l2_ioctl_ops venc_ioctl_ops =3D=
 {
>  	.vidioc_subscribe_event =3D venc_subscribe_event,
>  	.vidioc_unsubscribe_event =3D v4l2_event_unsubscribe,
>  	.vidioc_try_encoder_cmd =3D v4l2_m2m_ioctl_try_encoder_cmd,
> +	.vidioc_encoder_cmd =3D venc_encoder_cmd,
>  };
> =20
>  static int venc_pm_get(struct venus_inst *inst)
> @@ -1196,6 +1237,8 @@ static int venc_start_streaming(struct vb2_queue *q=
, unsigned int count)
>  	if (ret)
>  		goto error;
> =20
> +	inst->enc_state =3D VENUS_ENC_STATE_ENCODING;
> +
>  	mutex_unlock(&inst->lock);
> =20
>  	return 0;
> @@ -1215,10 +1258,21 @@ static int venc_start_streaming(struct vb2_queue =
*q, unsigned int count)
>  static void venc_vb2_buf_queue(struct vb2_buffer *vb)
>  {
>  	struct venus_inst *inst =3D vb2_get_drv_priv(vb->vb2_queue);
> +	struct vb2_v4l2_buffer *vbuf =3D to_vb2_v4l2_buffer(vb);
> =20
>  	venc_pm_get_put(inst);
> =20
>  	mutex_lock(&inst->lock);
> +
> +	if (inst->enc_state =3D=3D VENUS_ENC_STATE_STOPPED) {
> +		vbuf->sequence =3D inst->sequence_cap++;
> +		vbuf->field =3D V4L2_FIELD_NONE;
> +		vb2_set_plane_payload(vb, 0, 0);
> +		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_DONE);
> +		mutex_unlock(&inst->lock);
> +		return;
> +	}
> +
>  	venus_helper_vb2_buf_queue(vb);
>  	mutex_unlock(&inst->lock);
>  }
> @@ -1260,6 +1314,10 @@ static void venc_buf_done(struct venus_inst *inst,=
 unsigned int buf_type,
>  		vb->planes[0].data_offset =3D data_offset;
>  		vb->timestamp =3D timestamp_us * NSEC_PER_USEC;
>  		vbuf->sequence =3D inst->sequence_cap++;
> +		if ((vbuf->flags & V4L2_BUF_FLAG_LAST) &&
> +		    inst->enc_state =3D=3D VENUS_ENC_STATE_DRAIN) {
> +			inst->enc_state =3D VENUS_ENC_STATE_STOPPED;
> +		}
>  	} else {
>  		vbuf->sequence =3D inst->sequence_out++;
>  	}
> @@ -1362,6 +1420,9 @@ static int venc_open(struct file *file)
>  	inst->core_acquired =3D false;
>  	inst->nonblock =3D file->f_flags & O_NONBLOCK;
> =20
> +	if (inst->enc_state =3D=3D VENUS_ENC_STATE_DEINIT)
> +		inst->enc_state =3D VENUS_ENC_STATE_INIT;
> +
>  	venus_helper_init_instance(inst);
> =20
>  	ret =3D venc_ctrl_init(inst);
> @@ -1424,6 +1485,8 @@ static int venc_close(struct file *file)
>  	v4l2_fh_del(&inst->fh);
>  	v4l2_fh_exit(&inst->fh);
> =20
> +	inst->enc_state =3D VENUS_ENC_STATE_DEINIT;
> +
>  	venc_pm_put(inst, false);
> =20
>  	kfree(inst);

