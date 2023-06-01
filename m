Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8CD719668
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjFAJKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbjFAJJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:09:50 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A1AB3;
        Thu,  1 Jun 2023 02:09:48 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35156m4U010673;
        Thu, 1 Jun 2023 09:09:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=1qBwk0jpzvKsMcthroKqHY4AO2D06VgzZAxI2VMzpaU=;
 b=e5Gylk9fBW9BYFY2R75g6NqpOGaeMThQ58wW0vr6jMmhtdIMdyVYMvvcDJEkCBSsSQEQ
 v3ka5Yt7sGpsHMnxzRsi5YNxZMcQbDuT0vucpgZ8S8DUldX5oLmbzbf/15a1t2wmt4jV
 UzJVr3uGtaMgRNGAVQEVbRdwaTzGqaZXZtJtw/xsCjBBQur+RFK3+cf4LH/wQK6MnnFz
 CrX+wthHsaE2oERFy2jp+oz3rcY9IEsppUODABYhqBCLv9kjNbDLnpzhy9iBajHuJSqp
 uda/Y48OmSm7li5hMXR/GHUhxAeAUruP81XTtZL/Od5YwUdP0yDPVdS5+p7F/9WRkidA 6w== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxbx9hfan-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 09:09:13 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35198pLH022163
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 09:08:51 GMT
Received: from [10.216.48.115] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 02:08:46 -0700
Message-ID: <6d8d4ae5-6480-942e-3c75-348189f7ca84@quicinc.com>
Date:   Thu, 1 Jun 2023 14:38:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 01/17] media: venus: hfi_venus: Only consider
 sys_idle_indicator on V1
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Dikshita Agarwal <quic_dikshita@quicinc.com>
CC:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Marijn Suijten" <marijn.suijten@somainline.org>
References: <20230228-topic-venus-v4-0-feebb2f6e9b8@linaro.org>
 <20230228-topic-venus-v4-1-feebb2f6e9b8@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v4-1-feebb2f6e9b8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7wJKCcxVDeFP8B37KTKLPMHx7MfcphRJ
X-Proofpoint-ORIG-GUID: 7wJKCcxVDeFP8B37KTKLPMHx7MfcphRJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 mlxscore=0 adultscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306010082
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/30/2023 6:00 PM, Konrad Dybcio wrote:
> As per information from Qualcomm [1], this property is not really
> supported beyond msm8916 (HFI V1) and some newer HFI versions really
> dislike receiving it, going as far as crashing the device.
> 
> Only consider toggling it (via the module option) on HFIV1.
> While at it, get rid of the global static variable (which defaulted
> to zero) which was never explicitly assigned to for V1.
> 
> Note: [1] is a reply to the actual message in question, as lore did not
> properly receive some of the emails..
> 
> [1] https://lore.kernel.org/lkml/955cd520-3881-0c22-d818-13fe9a47e124@linaro.org/
> Fixes: 7ed9e0b3393c ("media: venus: hfi, vdec: v6 Add IS_V6() to existing IS_V4() if locations")
> Fixes: d96d3f30c0f2 ("[media] media: venus: hfi: add Venus HFI files")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>

> ---
>  drivers/media/platform/qcom/venus/hfi_venus.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index f0b46389e8d5..918a283bd890 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -131,7 +131,6 @@ struct venus_hfi_device {
>  
>  static bool venus_pkt_debug;
>  int venus_fw_debug = HFI_DEBUG_MSG_ERROR | HFI_DEBUG_MSG_FATAL;
> -static bool venus_sys_idle_indicator;
>  static bool venus_fw_low_power_mode = true;
>  static int venus_hw_rsp_timeout = 1000;
>  static bool venus_fw_coverage;
> @@ -927,17 +926,12 @@ static int venus_sys_set_default_properties(struct venus_hfi_device *hdev)
>  	if (ret)
>  		dev_warn(dev, "setting fw debug msg ON failed (%d)\n", ret);
>  
> -	/*
> -	 * Idle indicator is disabled by default on some 4xx firmware versions,
> -	 * enable it explicitly in order to make suspend functional by checking
> -	 * WFI (wait-for-interrupt) bit.
> -	 */
> -	if (IS_V4(hdev->core) || IS_V6(hdev->core))
> -		venus_sys_idle_indicator = true;
> -
> -	ret = venus_sys_set_idle_message(hdev, venus_sys_idle_indicator);
> -	if (ret)
> -		dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
> +	/* HFI_PROPERTY_SYS_IDLE_INDICATOR is not supported beyond 8916 (HFI V1) */
> +	if (IS_V1(hdev->core)) {
> +		ret = venus_sys_set_idle_message(hdev, false);
> +		if (ret)
> +			dev_warn(dev, "setting idle response ON failed (%d)\n", ret);
> +	}
>  
>  	ret = venus_sys_set_power_control(hdev, venus_fw_low_power_mode);
>  	if (ret)
> 
