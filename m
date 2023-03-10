Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754366B3471
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 03:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbjCJC7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 21:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjCJC71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 21:59:27 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1475199C4;
        Thu,  9 Mar 2023 18:59:26 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32A144ig017880;
        Fri, 10 Mar 2023 02:59:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PQNfu/X6r67zDWRiVTp+9AqtoRJYT0YRdJwDIpafouM=;
 b=YhJRlgE+UATD4KmgyRCijgrk+02SEW4yB6bRR5TXBvPHgxwAsJvQnedMGXCp2moedcne
 jSXXuKvk0CVreF5i/CzE+7e75hhhak+6hVYsLw8inEyUzAU9KxLnZDmxbgym5aCaLbZm
 iM0pu+Ayg+d1O43Gq9OcSon+W5dqjCVrE5Yyj5C4mCac/cmF/MxdEFylIKXEW1xCL5pZ
 lfyz2lJoxwqnz/fqjcmYK4p8xY2O8NW6tof8L2nC7WlwjMx+G/2qLMKWPhVHxs4lfoA3
 k1NQPAvm/XBgwdgt5MNA61iIjs9JpcMdKwdX71njJTD2fuPR6BW0mTtcLyXY2Q/aZOqC Yg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p7nh2h0dr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 02:59:23 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32A2xM8t025015
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Mar 2023 02:59:22 GMT
Received: from [10.79.43.91] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 9 Mar 2023
 18:59:10 -0800
Message-ID: <c862a6ee-241a-0ff8-62a5-668ed6599ad9@quicinc.com>
Date:   Fri, 10 Mar 2023 08:28:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] firmware: qcom: scm: fix bogus irq error at probe
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Guru Das Srinagesh" <quic_gurus@quicinc.com>
References: <20230309111209.31606-1-johan+linaro@kernel.org>
From:   Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20230309111209.31606-1-johan+linaro@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LqWgyw-lRUHacweRThMVx-HXHzVv-JPF
X-Proofpoint-GUID: LqWgyw-lRUHacweRThMVx-HXHzVv-JPF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-09_14,2023-03-09_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 phishscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303100020
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Johan,

Thanks for the fix.

On 3/9/23 16:42, Johan Hovold wrote:
> A recent commit added support for an optional interrupt which is only
> available on some platforms.
> 
> Stop spamming the logs with bogus error messages on platforms that do
> not use this new optional resource:
> 
> 	qcom_scm firmware:scm: error -ENXIO: IRQ index 0 not found
> 
> Fixes: 6bf325992236 ("firmware: qcom: scm: Add wait-queue handling logic")
> Cc: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Cc: Sibi Sankar <quic_sibis@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Sibi Sankar <quic_sibis@quicinc.com>

> ---
>   drivers/firmware/qcom_scm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 468d4d5ab550..b1e11f85b805 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -1479,7 +1479,7 @@ static int qcom_scm_probe(struct platform_device *pdev)
>   
>   	init_completion(&__scm->waitq_comp);
>   
> -	irq = platform_get_irq(pdev, 0);
> +	irq = platform_get_irq_optional(pdev, 0);
>   	if (irq < 0) {
>   		if (irq != -ENXIO)
>   			return irq;
