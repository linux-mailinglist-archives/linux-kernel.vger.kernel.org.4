Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA355B7A52
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbiIMS6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiIMS5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:57:35 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3B45808E;
        Tue, 13 Sep 2022 11:50:07 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28DIka5A029430;
        Tue, 13 Sep 2022 18:49:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=wNi6RKW5dQklqMq9XujCeoXV4kvvSM063Pz5aOM3Kmg=;
 b=NACVsCPYFnBr1TBECvgA27JTy57ipyr+2jO0hZrO9ICMAwXT/w2TGsTp6bauFEWCm5SF
 tUNWwxcyc0M6mq2zoXL9r49Ywil7T5/h2GbqIVOAcOwLaatGV40lCTENNgx0f/i/+Uro
 9S45ADCk1duICii/5T6KTTsnY8VD1+h0fN5why770J/0Nu+3L7eTN417AbQmPcmHloxX
 QD4nMef8gYNGK9wFxB9yHQ6znjSwTxsZKuxfH6j5Rk+nes+OD8JOdqRXyy+CU1Ear8yH
 /7rdB6NaQC5YcG79nBLIoLopenYZzz3wskc3IiffWP0woydaYx0e6wKpSYLty3zzs3e0 7Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jjy0c8287-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 18:49:37 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28DIXvoE021593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 18:33:57 GMT
Received: from [10.110.52.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 13 Sep
 2022 11:33:56 -0700
Message-ID: <9453502b-9dcd-7815-877f-8907f1d15481@quicinc.com>
Date:   Tue, 13 Sep 2022 11:33:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v3] soc: qcom: apr: Add check and kfree
Content-Language: en-US
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220913080635.1733565-1-jiasheng@iscas.ac.cn>
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <20220913080635.1733565-1-jiasheng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: I121wAbIZf3HysHyJli95Gr52oIhYp6w
X-Proofpoint-GUID: I121wAbIZf3HysHyJli95Gr52oIhYp6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_09,2022-09-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=832 priorityscore=1501
 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209130086
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/13/2022 1:06 AM, Jiasheng Jiang wrote:
> As idr_alloc() and of_property_read_string_index can return negative
> numbers, it should be better to check the return value and deal with
> the exception.
> Moreover, if device_register() fails, the adev should also be freed in
> order to avoid memory leak.
> Therefore, it should be better to use goto statement to deal with the
> exception.
> 
> Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog:
> 
> v2 -> v3:
> 
> 1. Change the title and use goto statement to deal with the exception.
> 
> v1 -> v2:
> 
> 1. Add dev_err and put_device in order to maintain the code consistency.
> ---
>   drivers/soc/qcom/apr.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
> index b4046f393575..b1a197155b2d 100644
> --- a/drivers/soc/qcom/apr.c
> +++ b/drivers/soc/qcom/apr.c
> @@ -454,20 +454,34 @@ static int apr_add_device(struct device *dev, struct device_node *np,
>   	adev->dev.driver = NULL;
>   
>   	spin_lock(&apr->svcs_lock);
> -	idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
> +	ret = idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
>   	spin_unlock(&apr->svcs_lock);
> +	if (ret < 0) {
> +		dev_err(dev, "idr_alloc failed: %d\n", ret);
> +		goto error;
> +	}
>   
> -	of_property_read_string_index(np, "qcom,protection-domain",
> -				      1, &adev->service_path);
> +	ret = of_property_read_string_index(np, "qcom,protection-domain",
> +					    1, &adev->service_path);
> +	if (ret < 0) {
> +		dev_err(dev, "of_property_read_string_index failed: %d\n", ret);
> +		goto error;
> +	}
>   
>   	dev_info(dev, "Adding APR/GPR dev: %s\n", dev_name(&adev->dev));
>   
>   	ret = device_register(&adev->dev);
>   	if (ret) {
>   		dev_err(dev, "device_register failed: %d\n", ret);
> -		put_device(&adev->dev);
> +		goto error;
>   	}
>   
> +	goto end;
> +
> +error:
> +	put_device(&adev->dev);
> +	kfree(adev);

isn't this a double free since put_device() will free adev?

> +end:
>   	return ret;
>   }
>   

