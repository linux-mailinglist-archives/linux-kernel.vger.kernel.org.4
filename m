Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D277196A2
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232376AbjFAJRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjFAJRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:17:15 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA329D;
        Thu,  1 Jun 2023 02:17:14 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3518FaVU021506;
        Thu, 1 Jun 2023 09:16:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=0stY+C59yyF/u3UKKInTfQ8mr5H8s/KKItx1LU3hSzg=;
 b=H7WdwUCcyEXebcXnl9CdEvvl3DKxMdac+ztOz0w0zPEp5x557orucxhUhMIb1u42l/gx
 +t8AEUo/s+DOfrE2zDnr6vMIkIY7ovVkLl4iyvnEpK3MEdCud4KSME33GEt6RoaxkxmX
 4RWyzxGYJi1W/vlJPyRfvsnYvLJlqg9ZDHLqXHIwQw3dhyEMbgfgpMBCX8jzY4KL4XRm
 LSE1JzyOsvKdy6286mnrdRbch6JXJTgRKYTQgg73Hl5AwLYmpv7K7upxZ8AFKfl645pH
 mBZ8mBEtlQaocwIgQV1Kf+bw1XKOSVlHL1YZ9G+kRFNhLUbzyguNVDy0vNI5mUdUTi2I mw== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qx81xa58m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Jun 2023 09:16:46 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3519GjPX023872
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 1 Jun 2023 09:16:45 GMT
Received: from [10.216.48.115] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 02:16:40 -0700
Message-ID: <9141f017-3c82-dc8d-d0d7-7834599f002a@quicinc.com>
Date:   Thu, 1 Jun 2023 14:46:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 12/17] media: venus: firmware: Sanitize per-VPU-version
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
 <20230228-topic-venus-v4-12-feebb2f6e9b8@linaro.org>
From:   Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <20230228-topic-venus-v4-12-feebb2f6e9b8@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: hNyHyqLoyDRrCrcA0vHh9PptOdfZNofY
X-Proofpoint-ORIG-GUID: hNyHyqLoyDRrCrcA0vHh9PptOdfZNofY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_06,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 adultscore=0 bulkscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306010082
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
> Replace the general IS_V6 checks with more specific VPU version checks.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>

> ---
>  drivers/media/platform/qcom/venus/firmware.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 572b649c56f3..ef07eea38d93 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -29,7 +29,7 @@ static void venus_reset_cpu(struct venus_core *core)
>  	u32 fw_size = core->fw.mapped_mem_size;
>  	void __iomem *wrapper_base;
>  
> -	if (IS_V6(core))
> +	if (IS_IRIS2_1(core))
>  		wrapper_base = core->wrapper_tz_base;
>  	else
>  		wrapper_base = core->wrapper_base;
> @@ -41,7 +41,7 @@ static void venus_reset_cpu(struct venus_core *core)
>  	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
>  	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>  
> -	if (IS_V6(core)) {
> +	if (IS_IRIS2_1(core)) {
>  		/* Bring XTSS out of reset */
>  		writel(0, wrapper_base + WRAPPER_TZ_XTSS_SW_RESET);
>  	} else {
> @@ -67,7 +67,7 @@ int venus_set_hw_state(struct venus_core *core, bool resume)
>  	if (resume) {
>  		venus_reset_cpu(core);
>  	} else {
> -		if (IS_V6(core))
> +		if (IS_IRIS2_1(core))
>  			writel(WRAPPER_XTSS_SW_RESET_BIT,
>  			       core->wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>  		else
> @@ -179,7 +179,7 @@ static int venus_shutdown_no_tz(struct venus_core *core)
>  	void __iomem *wrapper_base = core->wrapper_base;
>  	void __iomem *wrapper_tz_base = core->wrapper_tz_base;
>  
> -	if (IS_V6(core)) {
> +	if (IS_IRIS2_1(core)) {
>  		/* Assert the reset to XTSS */
>  		reg = readl(wrapper_tz_base + WRAPPER_TZ_XTSS_SW_RESET);
>  		reg |= WRAPPER_XTSS_SW_RESET_BIT;
> 
