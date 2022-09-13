Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31025B6656
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 06:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiIMEGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 00:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbiIMEF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 00:05:57 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15914F39C;
        Mon, 12 Sep 2022 21:05:55 -0700 (PDT)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D2j0W4009921;
        Tue, 13 Sep 2022 04:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Z9U03YyDHbx+gcRkIlD8WxYCfj176UeQNblaGIBziws=;
 b=nvktM4a/bB6ASvYHoX7cmTk22sqglU7B5VQYnhH8adls29BTCMJyZRzs3UFu13KV6cqB
 UKN3Lzz+KVXytiy5S8lfeIbzI5ICSUjkjYl04dhhcbYXfdW5r1vHr5wccBIWgu3A6hVF
 2uJ80ffkJBQ+Qi+ydVgu4/fI1jWeCS4934otYnbaQgZemAa/YOhDoY6SpicJq9JKE5lX
 5VDrwJdiD8jw8B9mtqB8y1tpbBW91ieD3M1MbZ8/seUJ+xfvKHQ3JT62hIMuWa8fRcI0
 PgA2A8xTGDSodE/yC08GyZBjI50gSxLYu82oxYZ6BIlJDrayKl3Jb5dly5hxjuvqs6E+ gA== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jgkve71ms-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:05:43 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28D45gJe022014
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Sep 2022 04:05:42 GMT
Received: from [10.110.52.115] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 12 Sep
 2022 21:05:41 -0700
Message-ID: <2607d08b-a10b-528b-83dc-c9c2029fca61@quicinc.com>
Date:   Mon, 12 Sep 2022 21:05:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] soc: qcom: apr: Add check for idr_alloc
Content-Language: en-US
From:   Jeff Johnson <quic_jjohnson@quicinc.com>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, <agross@kernel.org>,
        <bjorn.andersson@linaro.org>, <konrad.dybcio@somainline.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20220913023003.1677467-1-jiasheng@iscas.ac.cn>
 <4dd3417e-59c0-be93-59f8-a04dfff20d49@quicinc.com>
In-Reply-To: <4dd3417e-59c0-be93-59f8-a04dfff20d49@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: DhIG_s4CxypQZ7uOJW7BEYFfspUFufjG
X-Proofpoint-GUID: DhIG_s4CxypQZ7uOJW7BEYFfspUFufjG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-12_16,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 mlxlogscore=947 spamscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209130018
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/12/2022 8:51 PM, Jeff Johnson wrote:
> On 9/12/2022 7:30 PM, Jiasheng Jiang wrote:
>> As idr_alloc() can return negative numbers,
>> it should be better to check the return value and
>> deal with the exception.
>>
>> Fixes: 6adba21eb434 ("soc: qcom: Add APR bus driver")
>> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
>> ---
>>   drivers/soc/qcom/apr.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/apr.c b/drivers/soc/qcom/apr.c
>> index b4046f393575..1b73ce9b4f9a 100644
>> --- a/drivers/soc/qcom/apr.c
>> +++ b/drivers/soc/qcom/apr.c
>> @@ -454,8 +454,12 @@ static int apr_add_device(struct device *dev, 
>> struct device_node *np,
>>       adev->dev.driver = NULL;
>>       spin_lock(&apr->svcs_lock);
>> -    idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, GFP_ATOMIC);
>> +    ret = idr_alloc(&apr->svcs_idr, svc, svc_id, svc_id + 1, 
>> GFP_ATOMIC);
>>       spin_unlock(&apr->svcs_lock);
>> +    if (ret < 0) {
>> +        kfree(adev);
>> +        return ret;
>> +    }
> 
> for consistency suggest you follow the same error logic as the 
> device_register() failure just below, call dev_err() and put_device()
> 

in addition the of_property_read_string_index() that follows could also 
use error checking
