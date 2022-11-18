Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FBE62F6B5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242053AbiKROAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241108AbiKROAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:00:02 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A681370192
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 06:00:00 -0800 (PST)
X-KPN-MessageId: c34d9545-6748-11ed-888a-005056992ed3
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id c34d9545-6748-11ed-888a-005056992ed3;
        Fri, 18 Nov 2022 14:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=3ZTIZrlQy6tIDXDJIDu2NCrcPK3B0Wx5EvlOVVY9zSc=;
        b=fTKl7N4/C4uGKKu4f4APHngBJBRyaTfSr5pthQ2C6+voB0Rm0nwtJ7rhIZFvBV7KQpoWCm/kmAkci
         h4/e2d0sJ7FdAqdvqUzxg6wUHutfSBCrOgnkqo8b/pnxUTBdqei4CmKCH4M7H5V/uVbKgilEP3tbJh
         XvLlQN5DIEhqbqJtOaqs3DuKi/yutJrHyxfM2LEuCxXc8uz+ZL12ZejFpBNUdgeopa663qc8Ew7ySZ
         rOjPhSrtzKzjSumJZPlTwRpi6ZhDdvmCKFy5yEZMHcvnuW0R9iGm6wJ9QO9IhJya3DosSV2OOEW+x6
         Q1PZpNm3TsJ4DICfHvqUKl6wLhtyIbQ==
X-KPN-MID: 33|9SHzWYl570sL3QL2F2TzO5sm7WfIlDqqkfwWlgmKr3Mn9MWsYuqojJ+8D1DJfU3
 bb3cwUl1eW4kgC80/BBDHplO0pbiZHnPSonjmOdlcgvw=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|6HNrUcqY+Z97rrHv00YgQM93rAOEwSUGEvvOfrzzORiDiH61r+SJmvm99m5lm7n
 X9/fUGVJBUShGGGq/AKm/VA==
X-Originating-IP: 173.38.220.59
Received: from [10.47.77.219] (unknown [173.38.220.59])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 49250849-6749-11ed-9b28-00505699d6e5;
        Fri, 18 Nov 2022 14:59:58 +0100 (CET)
Message-ID: <5b77b349-16d2-e020-e4a7-43815088e1b8@xs4all.nl>
Date:   Fri, 18 Nov 2022 14:59:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] media: amphion: check and cancel vpu before release
Content-Language: en-US
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <afd6674a68c02d25cdd57a70db8135217c70a358.1667289237.git.ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <afd6674a68c02d25cdd57a70db8135217c70a358.1667289237.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ming,

On 11/1/22 09:05, Ming Qian wrote:
> driver need to cancel vpu before releasing the vpu instance,
> but it doesn't want to release the m2m_ctx before
> the release callback of instance is called,
> as driver may access the m2m_ctx in handling some event
> which may be received in releasing instance.
> 
> check and cancel the unstopped instance before release.
> 
> Fixes: d91d7bc85062 ("media: amphion: release m2m ctx when releasing vpu instance")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> ---
>  drivers/media/platform/amphion/vpu_v4l2.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/media/platform/amphion/vpu_v4l2.c b/drivers/media/platform/amphion/vpu_v4l2.c
> index 99ad2f1c5a53..845fc53d8937 100644
> --- a/drivers/media/platform/amphion/vpu_v4l2.c
> +++ b/drivers/media/platform/amphion/vpu_v4l2.c
> @@ -767,6 +767,23 @@ int vpu_v4l2_open(struct file *file, struct vpu_inst *inst)
>  	return ret;
>  }
>  
> +static void vpu_v4l2_check_and_cancel(struct file *file, struct vpu_inst *inst)
> +{
> +	struct vb2_queue *vq;
> +
> +	vpu_inst_lock(inst);
> +
> +	vq = v4l2_m2m_get_src_vq(inst->fh.m2m_ctx);
> +	if (vb2_is_streaming(vq))
> +		v4l2_m2m_streamoff(file, inst->fh.m2m_ctx, vq->type);
> +
> +	vq = v4l2_m2m_get_dst_vq(inst->fh.m2m_ctx);
> +	if (vb2_is_streaming(vq))
> +		v4l2_m2m_streamoff(file, inst->fh.m2m_ctx, vq->type);
> +
> +	vpu_inst_unlock(inst);

This feels weird. This is normally done in v4l2_m2m_ctx_release(), so
if you need to do this here, doesn't that mean perhaps that the order
of releasing things should be changed? I.e., first call v4l2_m2m_ctx_release()
and only afterwards release the vpu instance.

In other words, are you just fixing the symptom rather than the actual
cause?

Regards,

	Hans

> +}
> +
>  int vpu_v4l2_close(struct file *file)
>  {
>  	struct vpu_dev *vpu = video_drvdata(file);
> @@ -774,6 +791,7 @@ int vpu_v4l2_close(struct file *file)
>  
>  	vpu_trace(vpu->dev, "tgid = %d, pid = %d, inst = %p\n", inst->tgid, inst->pid, inst);
>  
> +	vpu_v4l2_check_and_cancel(file, inst);
>  	call_void_vop(inst, release);
>  	vpu_inst_unregister(inst);
>  	vpu_inst_put(inst);

