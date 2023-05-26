Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0111C7120BE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 09:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242112AbjEZHQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 03:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjEZHQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 03:16:41 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCA1114;
        Fri, 26 May 2023 00:16:39 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q4JFNk012586;
        Fri, 26 May 2023 07:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TX2/jwscArCevXeQn7fam6BW0rIQMTxf/D2bdpLbDwU=;
 b=jy80hvP2k7SKkRWkOo5sKXMecTecH9k72Ults7cv5gdfOlUPGQfBf9PpqkADcdf/g03Y
 xADAAUDYQdPqfkENgDF4W8Yzk5ttvInFfvWYEEzUXpQj2o78ctTesF4IYbtrwg59t46T
 F0KcLj4PfnESWpuwEXrcQV61Fqu2VjNw+2iB5bEeB1Glj2p0X2t37fN4yU49JuBa0/Hb
 wwtJg/zc7l6Ik2YX6B2E7S3goO6limql0l1vKLhze7k6uDJ4XZDZTwiuAlAM9Eftm6o4
 TVgErE/d+Lvo6T4k2jXtgrvk39bsP0DU3Z/RK1uZpn27rzxUX8kzPq27WCTLmtBQv+Dr 8A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt02ab2ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:16:06 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34Q7FqMd016916
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 07:15:52 GMT
Received: from [10.50.56.118] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 00:15:46 -0700
Message-ID: <26940075-e49c-3d45-0fda-3de5c79663a5@quicinc.com>
Date:   Fri, 26 May 2023 12:45:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 16/17] media: venus: Use newly-introduced
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
References: <20230228-topic-venus-v3-0-6092ae43b58f@linaro.org>
 <20230228-topic-venus-v3-16-6092ae43b58f@linaro.org>
From:   Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230228-topic-venus-v3-16-6092ae43b58f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bSnPQv68TvlPddpE5hn0Nh9TkJ82ItEx
X-Proofpoint-ORIG-GUID: bSnPQv68TvlPddpE5hn0Nh9TkJ82ItEx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 mlxscore=0 phishscore=0 adultscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260061
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/2023 2:44 AM, Konrad Dybcio wrote:
> Now that we have a way which is independent of the HFI version to set
> the correct fields in hfi_buffer_requirements, use it!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/helpers.c        |  5 +++--
>  .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 22 +++++++++++-----------
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/helpers.c b/drivers/media/platform/qcom/venus/helpers.c
> index 1ce2624abc12..0268129ab9ac 100644
> --- a/drivers/media/platform/qcom/venus/helpers.c
> +++ b/drivers/media/platform/qcom/venus/helpers.c
> @@ -667,6 +667,7 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
>  			    struct hfi_buffer_requirements *req)
>  {
>  	u32 ptype = HFI_PROPERTY_CONFIG_BUFFER_REQUIREMENTS;
> +	enum hfi_version ver = inst->core->res->hfi_version;
>  	union hfi_get_property hprop;
>  	unsigned int i;
>  	int ret;
> @@ -674,12 +675,12 @@ int venus_helper_get_bufreq(struct venus_inst *inst, u32 type,
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
> index a9be31ec6927..5eb4032bc551 100644
> --- a/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> +++ b/drivers/media/platform/qcom/venus/hfi_plat_bufs_v6.c
> @@ -1214,25 +1214,25 @@ static int bufreq_dec(struct hfi_plat_buffers_params *params, u32 buftype,
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
to set hold_count for non V4 targets, hfi_bufreq_set_hold_count() should be
called as well.
> +	hfi_bufreq_set_count_min(bufreq, version, 1);
> +	hfi_bufreq_set_count_min_host(bufreq, version, 1);
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
>  	} else if (buftype == HFI_BUFFER_OUTPUT ||
>  		   buftype == HFI_BUFFER_OUTPUT2) {
> -		bufreq->count_min = out_min_count;
> +		hfi_bufreq_set_count_min(bufreq, version, out_min_count);
>  		bufreq->size =
>  			venus_helper_get_framesz_raw(params->hfi_color_fmt,
>  						     width, height);
> @@ -1264,7 +1264,7 @@ static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
>  	u32 work_mode = params->enc.work_mode;
>  	u32 rc_type = params->enc.rc_type;
>  	u32 num_vpp_pipes = params->num_vpp_pipes;
> -	u32 num_ref;
> +	u32 num_ref, count_min;
>  
>  	switch (codec) {
>  	case V4L2_PIX_FMT_H264:
> @@ -1284,21 +1284,21 @@ static int bufreq_enc(struct hfi_plat_buffers_params *params, u32 buftype,
>  
>  	bufreq->type = buftype;
>  	bufreq->region_size = 0;
> -	bufreq->count_min = 1;
>  	bufreq->count_actual = 1;
> -	bufreq->hold_count = 1;
same comment here.

- Dikshita
> +	hfi_bufreq_set_count_min(bufreq, version, 1);
> +	hfi_bufreq_set_count_min_host(bufreq, version, 1);
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
