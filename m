Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43CD65B664D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiIMDwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIMDwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:52:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13FBB46D96;
        Mon, 12 Sep 2022 20:52:19 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D0e1UZ020192;
        Tue, 13 Sep 2022 03:51:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=V62/TT+de5aqTnak0RqhuYQyzzUE8pABgfSX9tJ+bY4=;
 b=cdxnWHWUHbkcc/rFV/inTvUAX5xyizNAo9U3PRoQpLXz1lI8Ejf9z11ro7pX++v+SVNA
 +0l7tTShJxCaJchkL6bXq2FmJIqwE85XZcOhA+MYWQTOiJYpgg2TKPhezB3C+2KfEdHX
 xkYdIq5RLnpOMdrAt2fbb/k0flHZCzIUO1zetdCnLFmsGSj6iQxabmu9t/qTUTIeBY9B
 llLACfd62Qm2PyZeWdp0Pm8P2zhiBNGld6De0cvE1oN3eFNKSWJJJsuakMcovGFuY/8o
 36sxxzJKCM2Ci68IskbwzfTmzfV2uebGbp7C+Igzov3R449ITdj8c5cGJpeCKYtdpa1T sg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgk3bdyd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 03:51:49 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D3pmuF022223
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 03:51:48 GMT
Received: from [10.110.52.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 20:51:47 -0700
Message-ID: <4dd3417e-59c0-be93-59f8-a04dfff20d49@quicinc.com>
Date:   Mon, 12 Sep 2022 20:51:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] soc: qcom: apr: Add check for idr_alloc
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220913023003.1677467-1-jiasheng@iscas.ac.cn>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220913023003.1677467-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MinEvAK-fIfAxlT28nFEpqb7yb8IWXAB
X-Proofpoint-GUID: MinEvAK-fIfAxlT28nFEpqb7yb8IWXAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_16,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=834 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130017
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2022 7:30 PM, Jiasheng Jiang wrote:
> As idr_alloc() can return negative numbers,
> it should be better to check the return value and
> deal with the exception.
> 
> Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>   drivers/soc/qcom/apr.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index b4046f393575..1b73ce9b4f9a 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -454,8 +454,12 @@ static int apr_add_device(struct device *dev, struct device_node *np,
>   	adev->dev.driver = NULL;
>   
>   	spin_lock(&apr->svcs_lock);
> -	idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
> +	ret = idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
>   	spin_unlock(&apr->svcs_lock);
> +	if (ret < 0) {
> +		kfree(adev);
> +		return ret;
> +	}

for consistency suggest you follow the same error logic as the 
device_register() failure just below, call dev_err() and put_device()

