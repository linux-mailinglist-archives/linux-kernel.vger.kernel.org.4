Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C69B6F44B7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:09:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbjEBNJf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234012AbjEBNJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:09:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D684EF7;
        Tue,  2 May 2023 06:09:26 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 342Btr6M020977;
        Tue, 2 May 2023 13:09:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Per2UUiTroh2CJvOG4mI7mJYEEH8Ygu7mjGdo5v0RwM=;
 b=J/w7VDPPyPo4QBqCc3mCOwZCGonAxEOoI1r8SUGbs5HE7F0ZCUI13mLdc4P7QShPwPHq
 Z7Y8DPU6HCw6+n9+ecziwaLYWRM3s3pamdJGn+08+pzagr29hjxUR8fm9zz8xd8yRqtK
 Qo6RnJR4WVfGQVVfkPBDy1AiJ2EgNMoAakRR2lD6/a3BWWM8tSsTTAoLISG3oLzCqVdS
 AzdArPHpJRNp9nCOSNJ+uKz7an/Gm0b9DENGJul40vMoi+/d/MI9SJDt+dS2TBlK30zI
 JdtFmwTVEOuq7lan/MzYTJm+0essDzQl2FZO/rboqoxmXEFJBIhPGSsc6okBYR5VzJf2 ag== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qawct8vab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 May 2023 13:09:21 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 342D9AmB029492
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 2 May 2023 13:09:10 GMT
Received: from [10.50.15.186] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Tue, 2 May 2023
 06:09:06 -0700
Message-ID: <921b7030-58d8-4a18-d52b-c3d153891deb@quicinc.com>
Date:   Tue, 2 May 2023 18:38:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] venus: add support for 10 bit decoding.
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     <linux-media@vger.kernel.org>, <stanimir.k.varbanov@gmail.com>,
        <quic_vgarodia@quicinc.com>, <agross@kernel.org>,
        <andersson@kernel.org>, <mchehab@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <1682492417-20496-1-git-send-email-quic_dikshita@quicinc.com>
 <4434859f-a5b2-a9da-8dad-3f2c4f48cd27@linaro.org>
 <CAA8EJprKLxeHO98TayzaS-U+O9JYvVe1zDKU+XPmrKxkQ_Sp3w@mail.gmail.com>
Content-Language: en-US
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <CAA8EJprKLxeHO98TayzaS-U+O9JYvVe1zDKU+XPmrKxkQ_Sp3w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HiwzFEeBNDNmCvOHX1uRumOoJ8vi_AcR
X-Proofpoint-GUID: HiwzFEeBNDNmCvOHX1uRumOoJ8vi_AcR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-02_08,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305020112
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/2/2023 5:51 PM, Dmitry Baryshkov wrote:
> On Tue, 2 May 2023 at 14:53, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>>
>>
>> On 26.04.2023 09:00, Dikshita Agarwal wrote:
>>> - Add support for V4L2_PIX_FMT_P010 color format.
>>> - Add handling of bit depth change from firmware.
>>> - Return P010 as preferred format for 10 bit decode.
>> Sounds like this should be 3 separate patches, preferably with
>> some insight in each commit message.
> Absolutely. I think there were several 'split one patch per feature'
> feedbacks for the previous series.

Sure Konrad and Dmitry, I will try to split this change into separate 
patches.

Thanks,

Dikshita

>> Konrad
>>> Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
>>> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
>>> ---
>>>   drivers/media/platform/qcom/venus/helpers.c        | 25 ++++++++++++++++++++++
>>>   drivers/media/platform/qcom/venus/hfi_plat_bufs.h  |  3 +++
>>>   .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   |  9 +++++++-
>>>   drivers/media/platform/qcom/venus/vdec.c           | 18 +++++++++++++---
>>>   4 files changed, 51 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
>>> index ab6a29f..193215c 100644
>>> --- a/drivers/media/platform/qcom/venus/helpers.c
>>> +++ b/drivers/media/platform/qcom/venus/helpers.c
>>> @@ -612,6 +612,8 @@ static u32 to_hfi_raw_fmt(u32 v4l2_fmt)
>>>                return HFI_COLOR_FORMAT_NV12_UBWC;
>>>        case V4L2_PIX_FMT_QC10C:
>>>                return HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
>>> +     case V4L2_PIX_FMT_P010:
>>> +             return HFI_COLOR_FORMAT_P010;
>>>        default:
>>>                break;
>>>        }
>>> @@ -639,12 +641,16 @@ static int platform_get_bufreq(struct venus_inst *inst, u32 buftype,
>>>        if (is_dec) {
>>>                params.width = inst->width;
>>>                params.height = inst->height;
>>> +             params.out_width = inst->out_width;
>>> +             params.out_height = inst->out_height;
>>>                params.codec = inst->fmt_out->pixfmt;
>>>                params.hfi_color_fmt = to_hfi_raw_fmt(inst->fmt_cap->pixfmt);
>>>                params.dec.max_mbs_per_frame = mbs_per_frame_max(inst);
>>>                params.dec.buffer_size_limit = 0;
>>>                params.dec.is_secondary_output =
>>>                        inst->opb_buftype == HFI_BUFFER_OUTPUT2;
>>> +             if (params.dec.is_secondary_output)
>>> +                     params.hfi_dpb_color_fmt = inst->dpb_fmt;
>>>                params.dec.is_interlaced =
>>>                        inst->pic_struct != HFI_INTERLACE_FRAME_PROGRESSIVE;
>>>        } else {
>>> @@ -1764,6 +1770,25 @@ int venus_helper_get_out_fmts(struct venus_inst *inst, u32 v4l2_fmt,
>>>        if (!caps)
>>>                return -EINVAL;
>>>
>>> +     if (inst->bit_depth == VIDC_BITDEPTH_10 &&
>>> +         inst->session_type == VIDC_SESSION_TYPE_DEC) {
>>> +             found_ubwc =
>>> +                     find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
>>> +                                        HFI_COLOR_FORMAT_YUV420_TP10_UBWC);
>>> +             found = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT2,
>>> +                                        fmt);
>>> +             if (found_ubwc && found) {
>>> +                     /*
>>> +                      * Hard-code DPB buffers to be 10bit UBWC
>>> +                      * until V4L2 is able to expose compressed/tiled
>>> +                      * formats to applications.
>>> +                      */
>>> +                     *out_fmt = HFI_COLOR_FORMAT_YUV420_TP10_UBWC;
>>> +                     *out2_fmt = fmt;
>>> +                     return 0;
>>> +             }
>>> +     }
>>> +
>>>        if (ubwc) {
>>>                ubwc_fmt = fmt | HFI_COLOR_FORMAT_UBWC_BASE;
>>>                found_ubwc = find_fmt_from_caps(caps, HFI_BUFFER_OUTPUT,
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
>>> index 52a51a3..25e6074 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
>>> +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs.h
>>> @@ -12,8 +12,11 @@
>>>   struct hfi_plat_buffers_params {
>>>        u32 width;
>>>        u32 height;
>>> +     u32 out_width;
>>> +     u32 out_height;
>>>        u32 codec;
>>>        u32 hfi_color_fmt;
>>> +     u32 hfi_dpb_color_fmt;
>>>        enum hfi_version version;
>>>        u32 num_vpp_pipes;
>>>        union {
>>> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
>>> index ea25c45..08caab1 100644
>>> --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
>>> +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
>>> @@ -1185,6 +1185,7 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
>>>        enum hfi_version version = params->version;
>>>        u32 codec = params->codec;
>>>        u32 width = params->width, height = params->height, out_min_count;
>>> +     u32 out_width = params->out_width, out_height = params->out_height;
>>>        struct dec_bufsize_ops *dec_ops;
>>>        bool is_secondary_output = params->dec.is_secondary_output;
>>>        bool is_interlaced = params->dec.is_interlaced;
>>> @@ -1235,7 +1236,13 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
>>>                bufreq->count_min = out_min_count;
>>>                bufreq->size =
>>>                        venus_helper_get_framesz_raw(params->hfi_color_fmt,
>>> -                                                  width, height);
>>> +                                                  out_width, out_height);
>>> +
>>> +             if (buftype == HFI_BUFFER_OUTPUT &&
>>> +                 params->dec.is_secondary_output)
>>> +                     bufreq->size =
>>> +                             venus_helper_get_framesz_raw(params->hfi_dpb_color_fmt,
>>> +                                                          out_width, out_height);
>>>        } else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
>>>                bufreq->size = dec_ops->scratch(width, height, is_interlaced);
>>>        } else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH_1(version)) {
>>> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
>>> index 4ceaba3..99d0e96 100644
>>> --- a/drivers/media/platform/qcom/venus/vdec.c
>>> +++ b/drivers/media/platform/qcom/venus/vdec.c
>>> @@ -43,6 +43,10 @@ static const struct venus_format vdec_formats[] = {
>>>                .num_planes = 1,
>>>                .type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>>>        }, {
>>> +             .pixfmt = V4L2_PIX_FMT_P010,
>>> +             .num_planes = 1,
>>> +             .type = V4L2_BUF_TYPE_VIDEO_CAPTURE_MPLANE,
>>> +     }, {
>>>                .pixfmt = V4L2_PIX_FMT_MPEG4,
>>>                .num_planes = 1,
>>>                .type = V4L2_BUF_TYPE_VIDEO_OUTPUT_MPLANE,
>>> @@ -697,6 +701,9 @@ static int vdec_set_work_route(struct venus_inst *inst)
>>>   }
>>>
>>>   #define is_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_UBWC_BASE))
>>> +#define is_10bit_ubwc_fmt(fmt) (!!((fmt) & HFI_COLOR_FORMAT_10_BIT_BASE & \
>>> +                                 HFI_COLOR_FORMAT_UBWC_BASE))
>>> +
>>>
>>>   static int vdec_output_conf(struct venus_inst *inst)
>>>   {
>>> @@ -744,7 +751,7 @@ static int vdec_output_conf(struct venus_inst *inst)
>>>                inst->opb_fmt = out2_fmt;
>>>                inst->dpb_buftype = HFI_BUFFER_OUTPUT;
>>>                inst->dpb_fmt = out_fmt;
>>> -     } else if (is_ubwc_fmt(out2_fmt)) {
>>> +     } else if (is_ubwc_fmt(out2_fmt) || is_10bit_ubwc_fmt(out_fmt)) {
>>>                inst->opb_buftype = HFI_BUFFER_OUTPUT;
>>>                inst->opb_fmt = out_fmt;
>>>                inst->dpb_buftype = HFI_BUFFER_OUTPUT2;
>>> @@ -1420,7 +1427,7 @@ static void vdec_buf_done(struct venus_inst *inst, unsigned int buf_type,
>>>   static void vdec_event_change(struct venus_inst *inst,
>>>                              struct hfi_event_data *ev_data, bool sufficient)
>>>   {
>>> -     static const struct v4l2_event ev = {
>>> +     struct v4l2_event ev = {
>>>                .type = V4L2_EVENT_SOURCE_CHANGE,
>>>                .u.src_change.changes = V4L2_EVENT_SRC_CH_RESOLUTION };
>>>        struct device *dev = inst->core->dev_dec;
>>> @@ -1461,8 +1468,13 @@ static void vdec_event_change(struct venus_inst *inst,
>>>        inst->out_width = ev_data->width;
>>>        inst->out_height = ev_data->height;
>>>
>>> -     if (inst->bit_depth != ev_data->bit_depth)
>>> +     if (inst->bit_depth != ev_data->bit_depth) {
>>>                inst->bit_depth = ev_data->bit_depth;
>>> +             if (inst->bit_depth == VIDC_BITDEPTH_10)
>>> +                     inst->fmt_cap = &vdec_formats[3];
>>> +             else
>>> +                     inst->fmt_cap = &vdec_formats[0];
>>> +     }
>>>
>>>        if (inst->pic_struct != ev_data->pic_struct)
>>>                inst->pic_struct = ev_data->pic_struct;
>
>
