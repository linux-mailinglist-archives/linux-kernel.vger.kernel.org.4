Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F82719740
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbjFAJkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjFAJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:40:25 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA01818C;
        Thu,  1 Jun 2023 02:40:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3517cRGl015717;
        Thu, 1 Jun 2023 09:39:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4niwuDJfbdAZvAjkQw3lg4yiatiTUKprN86ccKm4Fog=;
 b=FMbUWxR0T2BqriEfede7MR2VNnZfECZcpQq96CQ6I1230bBrZuhZXHgMsB18qauEtpg+
 vd4EhjphtMhayZYh6wNgs9DpG8zwlLYa5dO3swzENvkjxNPROg0WVMGZjDuweEM3ZGeN
 wjAczfeK0kW7O5PsCSw9SWpcCYLWqis0srD6XKgV+n7hvJDmEBwbVzVKaK+2IUbRbxVq
 v4MrIt77PwpQ5jt8Wg5GAjrD35E1NpbiLp6Oi4C61H6Qp2Y/xykGLhMotz36tSE3L1BI
 156SpNNCuU2zsI5+qQTaGNffv7/bcK4uBaEYcihMq5UK13v7So5CZlGPQVyQNl9ZUUN6 KA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qwx8qbknp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 09:39:31 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3519dUUD008114
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 09:39:30 GMT
Received: from [10.50.56.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 02:39:25 -0700
Message-ID: <574f6333-80b3-b54d-ef3c-12ba12114f5a@quicinc.com>
Date:   Thu, 1 Jun 2023 15:09:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4 16/17] media: venus: Use newly-introduced
 hfi_buffer_requirements accessors
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
 <20230228-topic-venus-v4-16-feebb2f6e9b8@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230228-topic-venus-v4-16-feebb2f6e9b8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -2CHr1l1NRWBfypP9JzVhzuS2X_aqMrM
X-Proofpoint-GUID: -2CHr1l1NRWBfypP9JzVhzuS2X_aqMrM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 spamscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010085
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/2023 6:00 PM, Konrad Dybcio wrote:
> Now that we have a way which is independent of the HFI version to set
> the correct fields in hfi_buffer_requirements, use it!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

> ---
>  drivers/media/platform/qcom/venus/helpers.c        |  5 +++--
>  .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 22 +++++++++++-----------
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index b70bd3dac4df..8295542e1a7c 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -668,6 +668,7 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
>  			    struct hfi_buffer_requirements *req)
>  {
>  	u32 ptype = HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS;
> +	enum hfi_version ver = inst->core->res->hfi_version;
>  	union hfi_get_property hprop;
>  	unsigned int i;
>  	int ret;
> @@ -675,12 +676,12 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
>  	memset(req, 0, sizeof(*req));
>  
>  	if (type == HFI_BUFFER_OUTPUT || type == HFI_BUFFER_OUTPUT2)
> -		req->count_min = inst->fw_min_cnt;
> +		hfi_bufreq_set_count_min(req, ver, inst->fw_min_cnt);
>  
>  	ret = platform_get_bufreq(inst, type, req);
>  	if (!ret) {
>  		if (type == HFI_BUFFER_OUTPUT || type == HFI_BUFFER_OUTPUT2)
> -			inst->fw_min_cnt = req->count_min;
> +			inst->fw_min_cnt = hfi_bufreq_get_count_min(req, ver);
>  		return 0;
>  	}
>  
> diff --git a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> index e97ff8cf6d64..f5a655973c08 100644
> --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> @@ -1215,24 +1215,24 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
>  
>  	out_min_count = output_buffer_count(VIDC_SESSION_TYPE_DEC, codec);
>  	/* Max of driver and FW count */
> -	out_min_count = max(out_min_count, bufreq->count_min);
> +	out_min_count = max(out_min_count, hfi_bufreq_get_count_min(bufreq, version));
>  
>  	bufreq->type = buftype;
>  	bufreq->region_size = 0;
> -	bufreq->count_min = 1;
>  	bufreq->count_actual = 1;
> -	bufreq->hold_count = 1;
> +	hfi_bufreq_set_count_min(bufreq, version, 1);
> +	hfi_bufreq_set_hold_count(bufreq, version, 1);
>  	bufreq->contiguous = 1;
>  	bufreq->alignment = 256;
>  
>  	if (buftype == HFI_BUFFER_INPUT) {
> -		bufreq->count_min = MIN_INPUT_BUFFERS;
> +		hfi_bufreq_set_count_min(bufreq, version, MIN_INPUT_BUFFERS);
>  		bufreq->size =
>  			calculate_dec_input_frame_size(width, height, codec,
>  						       max_mbs_per_frame,
>  						       buffer_size_limit);
>  	} else if (buftype == HFI_BUFFER_OUTPUT || buftype == HFI_BUFFER_OUTPUT2) {
> -		bufreq->count_min = out_min_count;
> +		hfi_bufreq_set_count_min(bufreq, version, out_min_count);
>  		bufreq->size =
>  			venus_helper_get_framesz_raw(params->hfi_color_fmt,
>  						     out_width, out_height);
> @@ -1269,7 +1269,7 @@ static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
>  	u32 work_mode = params->enc.work_mode;
>  	u32 rc_type = params->enc.rc_type;
>  	u32 num_vpp_pipes = params->num_vpp_pipes;
> -	u32 num_ref;
> +	u32 num_ref, count_min;
>  
>  	switch (codec) {
>  	case V4L2_PIX_FMT_H264:
> @@ -1289,21 +1289,21 @@ static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
>  
>  	bufreq->type = buftype;
>  	bufreq->region_size = 0;
> -	bufreq->count_min = 1;
>  	bufreq->count_actual = 1;
> -	bufreq->hold_count = 1;
> +	hfi_bufreq_set_count_min(bufreq, version, 1);
> +	hfi_bufreq_set_hold_count(bufreq, version, 1);
>  	bufreq->contiguous = 1;
>  	bufreq->alignment = 256;
>  
>  	if (buftype == HFI_BUFFER_INPUT) {
> -		bufreq->count_min = MIN_INPUT_BUFFERS;
> +		hfi_bufreq_set_count_min(bufreq, version, MIN_INPUT_BUFFERS);
>  		bufreq->size =
>  			venus_helper_get_framesz_raw(params->hfi_color_fmt,
>  						     width, height);
>  	} else if (buftype == HFI_BUFFER_OUTPUT ||
>  		   buftype == HFI_BUFFER_OUTPUT2) {
> -		bufreq->count_min =
> -			output_buffer_count(VIDC_SESSION_TYPE_ENC, codec);
> +		count_min = output_buffer_count(VIDC_SESSION_TYPE_ENC, codec);
> +		hfi_bufreq_set_count_min(bufreq, version, count_min);
>  		bufreq->size = calculate_enc_output_frame_size(width, height,
>  							       rc_type);
>  	} else if (buftype == HFI_BUFFER_INTERNAL_SCRATCH(version)) {
> 
