Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5057669C67
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:33:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjAMPdI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:33:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjAMPcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:32:09 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C02E177D1C;
        Fri, 13 Jan 2023 07:25:57 -0800 (PST)
Received: from [IPV6:2a01:e0a:120:3210:299b:2170:fef0:26ee] (unknown [IPv6:2a01:e0a:120:3210:299b:2170:fef0:26ee])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: benjamin.gaignard)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2B4326602DD6;
        Fri, 13 Jan 2023 15:25:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1673623556;
        bh=6vMpGC4QuNECsrWfSd/DR/10cnqSErEuJDg0yULogko=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NOogRgsJ9d7LGA6zPXR6S3iXbusslL7xAsB35lPxVdKdc6tbP05EJ5kMCoWnYerJh
         VjeBbYGQaOhLm1NnU53nVeaam/htx7TmEc1zJ3qfRIYDnyGlQzllIT9bKHMnYMInoI
         NmU9In4JKQTCf/04uXcNgKPWeEqrhKrW8TceIUzf03BpYNViGUXkI1D9x1COIxK8wW
         wGAklUacizq86PIblFWOe0c2O4/wvrk4iUTiOJ14IMy7IehBvUFRWiQKFuDYRBOTeM
         03yM0gqTjCgWP7i5YTuZCyBBHrxG4c+drP9PqN+ofhmzDbCS48O1FH4B5gONDDEIAZ
         WHAgJBmhs0jbg==
Message-ID: <6d05e9c0-e7c1-b4b5-668b-5644510a6cec@collabora.com>
Date:   Fri, 13 Jan 2023 16:25:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] media: verisilicon: HEVC: Only propose 10 bits
 compatible pixels formats
Content-Language: en-US
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Cc:     p.zabel@pengutronix.de, mchehab@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.co.uk, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230113131257.661079-1-benjamin.gaignard@collabora.com>
 <CAAEAJfAnoe+rL=9yFV1crhoaFa9uWaaJq3nCeS+QZPLi_xnsOw@mail.gmail.com>
From:   Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <CAAEAJfAnoe+rL=9yFV1crhoaFa9uWaaJq3nCeS+QZPLi_xnsOw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Le 13/01/2023 à 15:12, Ezequiel Garcia a écrit :
> Hi Benjamin,
>
> On Fri, Jan 13, 2023 at 10:13 AM Benjamin Gaignard
> <benjamin.gaignard@collabora.com> wrote:
>> When decoding a 10bits bitstreams HEVC driver should only expose
>> 10bits pixel formats.
>> To fulfill this requirement it is needed to call hantro_reset_raw_fmt()
>> when bit depth change and to correctly set match_depth in pixel formats
>> enumeration.
>>
>> Fixes: dc39473d0340 ("media: hantro: imx8m: Enable 10bit decoding")
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> ---
>> version 2:
>> - Also remove struct hantro_ctx *ctx variable in hantro_try_ctrl()
>>
>>   .../media/platform/verisilicon/hantro_drv.c   | 40 +++++++++++++++----
>>   .../media/platform/verisilicon/hantro_v4l2.c  |  2 +-
>>   .../media/platform/verisilicon/hantro_v4l2.h  |  1 +
>>   .../media/platform/verisilicon/imx8m_vpu_hw.c |  2 +
>>   4 files changed, 36 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
>> index 8cb4a68c9119..e824e87618db 100644
>> --- a/drivers/media/platform/verisilicon/hantro_drv.c
>> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
>> @@ -251,11 +251,6 @@ queue_init(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq)
>>
>>   static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>>   {
>> -       struct hantro_ctx *ctx;
>> -
>> -       ctx = container_of(ctrl->handler,
>> -                          struct hantro_ctx, ctrl_handler);
>> -
> This change is unrelated to this commit.

It is because ctx is no more used in this function.

>
>>          if (ctrl->id == V4L2_CID_STATELESS_H264_SPS) {
>>                  const struct v4l2_ctrl_h264_sps *sps = ctrl->p_new.p_h264_sps;
>>
>> @@ -274,8 +269,6 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>>                  if (sps->bit_depth_luma_minus8 != 0 && sps->bit_depth_luma_minus8 != 2)
>>                          /* Only 8-bit and 10-bit are supported */
>>                          return -EINVAL;
>> -
>> -               ctx->bit_depth = sps->bit_depth_luma_minus8 + 8;
>>          } else if (ctrl->id == V4L2_CID_STATELESS_VP9_FRAME) {
>>                  const struct v4l2_ctrl_vp9_frame *dec_params = ctrl->p_new.p_vp9_frame;
>>
>> @@ -286,6 +279,32 @@ static int hantro_try_ctrl(struct v4l2_ctrl *ctrl)
>>          return 0;
>>   }
>>
>> +static int hantro_hevc_s_ctrl(struct v4l2_ctrl *ctrl)
>> +{
>> +       struct hantro_ctx *ctx;
>> +
>> +       ctx = container_of(ctrl->handler,
>> +                          struct hantro_ctx, ctrl_handler);
>> +
>> +       vpu_debug(1, "s_ctrl: id = %d, val = %d\n", ctrl->id, ctrl->val);
>> +
>> +       switch (ctrl->id) {
>> +       case V4L2_CID_STATELESS_HEVC_SPS:
>> +               const struct v4l2_ctrl_hevc_sps *sps = ctrl->p_new.p_hevc_sps;
>> +               int bit_depth = sps->bit_depth_luma_minus8 + 8;
>> +
>> +               if (ctx->bit_depth != bit_depth) {
>> +                       ctx->bit_depth = bit_depth;
>> +                       hantro_reset_raw_fmt(ctx);
> We need to propagate the EBUSY error from hantro_set_fmt_cap,
> to hantro_reset_raw_fmt, so this operation can fail if the capture
> queue has buffers allocated.
>
> Keep in mind, we have to make sure the hantro_ctx state
> remains unchanged when the operation fails.
>
> The entire hantro_v4l2.c format negotiation is done without this
> case in mind (controls can change the format enumeration),
> so this new case needs some refactoring.

I will change hantro_reset_raw_fmt() prototype to:
int hantro_reset_raw_fmt(struct hantro_ctx *ctx);
so I will be able to return the result of hantro_set_fmt_out()
or hantro_set_fmt_cap() when setting the control.

Does that sound correct for you ?

Regards,
Benjamin

>
> I also think we need v4l2-compliance tests for it.
>
> Thanks!
> Ezequiel
>
>
>> +               }
>> +               break;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>   static int hantro_jpeg_s_ctrl(struct v4l2_ctrl *ctrl)
>>   {
>>          struct hantro_ctx *ctx;
>> @@ -328,6 +347,11 @@ static const struct v4l2_ctrl_ops hantro_ctrl_ops = {
>>          .try_ctrl = hantro_try_ctrl,
>>   };
>>
>> +static const struct v4l2_ctrl_ops hantro_hevc_ctrl_ops = {
>> +       .s_ctrl = hantro_hevc_s_ctrl,
>> +       .try_ctrl = hantro_try_ctrl,
>> +};
>> +
>>   static const struct v4l2_ctrl_ops hantro_jpeg_ctrl_ops = {
>>          .s_ctrl = hantro_jpeg_s_ctrl,
>>   };
>> @@ -470,7 +494,7 @@ static const struct hantro_ctrl controls[] = {
>>                  .codec = HANTRO_HEVC_DECODER,
>>                  .cfg = {
>>                          .id = V4L2_CID_STATELESS_HEVC_SPS,
>> -                       .ops = &hantro_ctrl_ops,
>> +                       .ops = &hantro_hevc_ctrl_ops,
>>                  },
>>          }, {
>>                  .codec = HANTRO_HEVC_DECODER,
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.c b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> index 2c7a805289e7..0025e049dd26 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.c
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.c
>> @@ -398,7 +398,7 @@ hantro_reset_encoded_fmt(struct hantro_ctx *ctx)
>>                  hantro_set_fmt_out(ctx, fmt);
>>   }
>>
>> -static void
>> +void
>>   hantro_reset_raw_fmt(struct hantro_ctx *ctx)
>>   {
>>          const struct hantro_fmt *raw_vpu_fmt;
>> diff --git a/drivers/media/platform/verisilicon/hantro_v4l2.h b/drivers/media/platform/verisilicon/hantro_v4l2.h
>> index 64f6f57e9d7a..f642560aed93 100644
>> --- a/drivers/media/platform/verisilicon/hantro_v4l2.h
>> +++ b/drivers/media/platform/verisilicon/hantro_v4l2.h
>> @@ -21,6 +21,7 @@
>>   extern const struct v4l2_ioctl_ops hantro_ioctl_ops;
>>   extern const struct vb2_ops hantro_queue_ops;
>>
>> +void hantro_reset_raw_fmt(struct hantro_ctx *ctx);
>>   void hantro_reset_fmts(struct hantro_ctx *ctx);
>>   int hantro_get_format_depth(u32 fourcc);
>>   const struct hantro_fmt *
>> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> index b390228fd3b4..f850d8bddef6 100644
>> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
>> @@ -152,6 +152,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
>>          {
>>                  .fourcc = V4L2_PIX_FMT_NV12,
>>                  .codec_mode = HANTRO_MODE_NONE,
>> +               .match_depth = true,
>>                  .postprocessed = true,
>>                  .frmsize = {
>>                          .min_width = FMT_MIN_WIDTH,
>> @@ -165,6 +166,7 @@ static const struct hantro_fmt imx8m_vpu_g2_postproc_fmts[] = {
>>          {
>>                  .fourcc = V4L2_PIX_FMT_P010,
>>                  .codec_mode = HANTRO_MODE_NONE,
>> +               .match_depth = true,
>>                  .postprocessed = true,
>>                  .frmsize = {
>>                          .min_width = FMT_MIN_WIDTH,
>> --
>> 2.34.1
>>
