Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7213E6BCD02
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjCPKkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCPKko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:40:44 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1694ABAC1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:40:41 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id i6so1261885ybu.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678963241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EtNq1+jJMoLN/skSQueisKVB6DYjskjubYgFF/Up0Y4=;
        b=m+csTfckuemcu2FLx7GpbimeDWtrSuIkY/duC2HlsmpyyTw90mWTqqEDjC4gLBa24F
         59f0sBa+cqAcN3SI47zahrYHQkhRJfucwxmGqx1zOkR7/rh/6emkSqOpBFeI3STSrxZ1
         FtV4cGXyA7suZJHNaTA39HMSmwrp8AVXgWkx6cN7N0J/IFRjj07HzkVTFnuf61WV8uas
         +lLUhfQlMtTaMLNOiZxnWxoqpnzLTWHa/O9KMyYpsVaNZ4fBAacPRTZPOrheLs3aY+TQ
         cs/fYmMv1esqimWXVKUa/g4smQ7RJhX/UhdJWUXv0m0+X3sWLPL0jNXFJPg3BmDFG6DX
         kmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678963241;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EtNq1+jJMoLN/skSQueisKVB6DYjskjubYgFF/Up0Y4=;
        b=B6fgAfxt79rGi0l8wDgmlNy3pwAf/OpSStr/0sXRxl/6EWG2sV03Zgpf+OtkCmvTU1
         gJBwuaDXka7WRE70FQPC9kx/OuGP2eu4uvjQM/xQsz6HIBY+i5AUqCnuoC1n1N7QHBq/
         Ee29eeLcKlQyk6pyoMqz1DMqIaLGNVH+8Ni3wGA7GS8f/E2y6e7H+5zaE9nDGrfxO3r5
         IW98u751NdVRFt4UREoOf1g8oXUraVF/k4VXIDdBz+WVxJrppSnOKirILCVzHZspDXpU
         iXGsCiDPhn0G1G9TJ93/Knk22UVUWh1lHBmxHkY15EJDXfcsNbtqgUHyCoiob6V/fFwk
         Gv3g==
X-Gm-Message-State: AO0yUKVP+L+F85Wt/qPIZOGtRFLZtfLuNef3U+AOY9YwTjkgBE2JOHLw
        pejWHVxoLJyny39z3OQ+VX/Kyj/5eOWN2RVk5TdIZQ==
X-Google-Smtp-Source: AK7set+59A5NlZvJmqGsf3MsKKHEw69O7LP7o0G5BwyPkvthSjZEU/hEa8SrcNXcgGepBBo5bwK7PLVRWtoHcKd2IcQ=
X-Received: by 2002:a5b:108:0:b0:8bb:dfe8:a33b with SMTP id
 8-20020a5b0108000000b008bbdfe8a33bmr27653000ybx.9.1678963241065; Thu, 16 Mar
 2023 03:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230316082627.19279-1-quic_vboma@quicinc.com> <20230316082627.19279-2-quic_vboma@quicinc.com>
In-Reply-To: <20230316082627.19279-2-quic_vboma@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 16 Mar 2023 12:40:30 +0200
Message-ID: <CAA8EJpq5VeiyG_xa4G8Y91Kw0v5ZcNjEqJ4vOM0mUkH6SW=o+w@mail.gmail.com>
Subject: Re: [PATCH] venus: Add support for min/max qp range.
To:     quic_vboma@quicinc.com
Cc:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Mar 2023 at 10:27, <quic_vboma@quicinc.com> wrote:
>
> From: Viswanath Boma <quic_vboma@quicinc.com>
>
> This change enables the support on firmware. Client's qp range
> values will be set at session level by the driver.
>
> Signed-off-by: Viswanath Boma <quic_vboma@quicinc.com>
> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
> ---
>  drivers/media/platform/qcom/venus/hfi_cmds.c  | 27 +++++++++++-
>  .../media/platform/qcom/venus/hfi_helper.h    | 18 ++++++++
>  drivers/media/platform/qcom/venus/venc.c      | 41 +++++++++++++++----
>  3 files changed, 77 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c b/drivers/media/platform/qcom/venus/hfi_cmds.c
> index 930b743f225e..98ad4f4fba0a 100644
> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
> @@ -1189,6 +1189,7 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
>                              void *cookie, u32 ptype, void *pdata)
>  {
>         void *prop_data;
> +       int ret = 0;
>
>         if (!pkt || !cookie || !pdata)
>                 return -EINVAL;
> @@ -1257,7 +1258,31 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
>                 pkt->shdr.hdr.size += sizeof(u32) + sizeof(*tm);
>                 break;
>         }
> +       case HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2: {
> +               struct hfi_quantization_range_v2 *in = pdata, *range = prop_data;
> +               u32 min_qp, max_qp;
>
> +               min_qp = in->min_qp.qp_packed;
> +               max_qp = in->max_qp.qp_packed;
> +
> +               /* We'll be packing in the qp, so make sure we
> +                * won't be losing data when masking
> +                */
> +               if (min_qp > 0xff || max_qp > 0xff) {
> +                       ret = -ERANGE;

Do you need any processing after the switchase? Can you just return
-ERANGE here?

> +                       break;
> +               }
> +               range->min_qp.layer_id = 0xFF;
> +               range->max_qp.layer_id = 0xFF;
> +               range->min_qp.qp_packed = (min_qp & 0xFF) | ((min_qp & 0xFF) << 8) |
> +                       ((min_qp & 0xFF) << 16);
> +               range->max_qp.qp_packed = (max_qp & 0xFF) | ((max_qp & 0xFF) << 8) |
> +                       ((max_qp & 0xFF) << 16);
> +               range->min_qp.enable = 7;
> +               range->max_qp.enable = 7;
> +               pkt->shdr.hdr.size += sizeof(u32) + sizeof(*range);
> +               break;
> +       }
>         case HFI_PROPERTY_CONFIG_VENC_MAX_BITRATE:
>         case HFI_PROPERTY_CONFIG_VDEC_POST_LOOP_DEBLOCKER:
>         case HFI_PROPERTY_PARAM_BUFFER_ALLOC_MODE:
> @@ -1269,7 +1294,7 @@ pkt_session_set_property_4xx(struct hfi_session_set_property_pkt *pkt,
>                 return pkt_session_set_property_3xx(pkt, cookie, ptype, pdata);
>         }
>
> -       return 0;
> +       return ret;
>  }
>
>  static int
> diff --git a/drivers/media/platform/qcom/venus/hfi_helper.h b/drivers/media/platform/qcom/venus/hfi_helper.h
> index d2d6719a2ba4..105792a68060 100644
> --- a/drivers/media/platform/qcom/venus/hfi_helper.h
> +++ b/drivers/media/platform/qcom/venus/hfi_helper.h
> @@ -487,6 +487,11 @@
>  #define HFI_PROPERTY_PARAM_VENC_SESSION_QP                     0x2005006
>  #define HFI_PROPERTY_PARAM_VENC_MPEG4_AC_PREDICTION            0x2005007
>  #define HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE               0x2005008
> +/*
> + * Note: HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2 is
> + * specific to HFI_VERSION_6XX and HFI_VERSION_4XX only
> + */
> +#define HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2            0x2005009
>  #define HFI_PROPERTY_PARAM_VENC_MPEG4_TIME_RESOLUTION          0x2005009
>  #define HFI_PROPERTY_PARAM_VENC_MPEG4_SHORT_HEADER             0x200500a
>  #define HFI_PROPERTY_PARAM_VENC_MPEG4_HEADER_EXTENSION         0x200500b
> @@ -827,6 +832,19 @@ struct hfi_quantization_range {
>         u32 layer_id;
>  };
>
> +struct hfi_quantization_v2 {
> +       u32 qp_packed;
> +       u32 layer_id;
> +       u32 enable;
> +       u32 reserved[3];
> +};
> +
> +struct hfi_quantization_range_v2 {
> +       struct hfi_quantization_v2 min_qp;
> +       struct hfi_quantization_v2 max_qp;
> +       u32 reserved[4];
> +};
> +
>  #define HFI_LTR_MODE_DISABLE   0x0
>  #define HFI_LTR_MODE_MANUAL    0x1
>  #define HFI_LTR_MODE_PERIODIC  0x2
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index cdb12546c4fa..b01da4c1d47a 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -617,6 +617,7 @@ static int venc_set_properties(struct venus_inst *inst)
>         struct hfi_idr_period idrp;
>         struct hfi_quantization quant;
>         struct hfi_quantization_range quant_range;
> +       struct hfi_quantization_range_v2 quant_range_v2;
>         struct hfi_enable en;
>         struct hfi_ltr_mode ltr_mode;
>         struct hfi_intra_refresh intra_refresh = {};
> @@ -825,16 +826,40 @@ static int venc_set_properties(struct venus_inst *inst)
>         if (ret)
>                 return ret;
>
> -       ptype = HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE;
> -       if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
> -               quant_range.min_qp = ctr->hevc_min_qp;
> -               quant_range.max_qp = ctr->hevc_max_qp;
> +       if (inst->core->res->hfi_version == HFI_VERSION_4XX ||
> +           inst->core->res->hfi_version == HFI_VERSION_6XX) {
> +               ptype = HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE_V2;
> +
> +               if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
> +                       quant_range_v2.min_qp.qp_packed = ctr->hevc_min_qp;
> +                       quant_range_v2.max_qp.qp_packed = ctr->hevc_max_qp;
> +               } else if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_VP8) {
> +                       quant_range_v2.min_qp.qp_packed = ctr->vp8_min_qp;
> +                       quant_range_v2.max_qp.qp_packed = ctr->vp8_max_qp;
> +               } else {
> +                       quant_range_v2.min_qp.qp_packed = ctr->h264_min_qp;
> +                       quant_range_v2.max_qp.qp_packed = ctr->h264_max_qp;
> +               }
> +
> +               ret = hfi_session_set_property(inst, ptype, &quant_range_v2);
>         } else {
> -               quant_range.min_qp = ctr->h264_min_qp;
> -               quant_range.max_qp = ctr->h264_max_qp;
> +               ptype = HFI_PROPERTY_PARAM_VENC_SESSION_QP_RANGE;
> +
> +               if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_HEVC) {
> +                       quant_range.min_qp = ctr->hevc_min_qp;
> +                       quant_range.max_qp = ctr->hevc_max_qp;
> +               } else if (inst->fmt_cap->pixfmt == V4L2_PIX_FMT_VP8) {
> +                       quant_range.min_qp = ctr->vp8_min_qp;
> +                       quant_range.max_qp = ctr->vp8_max_qp;
> +               } else {
> +                       quant_range.min_qp = ctr->h264_min_qp;
> +                       quant_range.max_qp = ctr->h264_max_qp;
> +               }
> +
> +               quant_range.layer_id = 0;
> +               ret = hfi_session_set_property(inst, ptype, &quant_range);
>         }
> -       quant_range.layer_id = 0;
> -       ret = hfi_session_set_property(inst, ptype, &quant_range);
> +
>         if (ret)
>                 return ret;
>
> --
> 2.17.1
>


-- 
With best wishes
Dmitry
