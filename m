Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7389965EE20
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234162AbjAEOBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjAEOBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:01:24 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B2B3F100;
        Thu,  5 Jan 2023 05:59:49 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 305Cqnfb026123;
        Thu, 5 Jan 2023 13:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eOaz6M9U7Alce1fryFahL8buzJAW89ygJQ6DdWeXm30=;
 b=BqKZ/WBXTVzbNPcmrFEQsT3KLH30BXSG6JFJodlS6wvtaDcO82orPvRBPkYus4gAC1zZ
 0krgvRLDS2CWauzrq08rj8c+oiJsZsKQki26bObIgZlMH9FOd8Avym+8qP5xinvlIhnZ
 c8k+ZFixpOAPNABXutg+rO4/3yXqU6zDbXQElOpRpnIDwZumpWQt5IYIIBy8471JQ/LL
 xK33yLZeeRgh4Z5rx6xkYP0zgWsgbnsngUj6gxp35YF8geyboka6n+c63ZUoxBd9zwlb
 kxjSgyjHkiZZyPM/I9GhnnDv+97rqbl1FViQP8jN4piqev3RpzGbUkIEwDITc20KFbcZ Hw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mwj4p9f2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Jan 2023 13:59:34 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 305DxX8E009124
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Jan 2023 13:59:33 GMT
Received: from [10.253.32.88] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 5 Jan 2023
 05:59:30 -0800
Message-ID: <04155aa3-c153-1d95-94da-b482acea048f@quicinc.com>
Date:   Thu, 5 Jan 2023 21:59:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] coresight: cti: Add PM runtime call in enable_store
Content-Language: en-US
To:     James Clark <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei <quic_tingweiz@quicinc.com>,
        "Yuanfang Zhang" <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        "Hao Zhang" <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20221224141700.20891-1-quic_jinlmao@quicinc.com>
 <9a86f7cd-2dce-f27a-af21-d64318ca3ef7@arm.com>
 <990b948f-11b3-2463-2d0c-be9d30d10328@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <990b948f-11b3-2463-2d0c-be9d30d10328@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8Ha-Mtv_b7sOTyOLkOZvuNt4n0SAL_z3
X-Proofpoint-ORIG-GUID: 8Ha-Mtv_b7sOTyOLkOZvuNt4n0SAL_z3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-05_04,2023-01-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=692 malwarescore=0
 phishscore=0 lowpriorityscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301050110
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/5/2023 9:55 PM, James Clark wrote:
>
> On 04/01/2023 13:11, James Clark wrote:
>>
>> On 24/12/2022 14:17, Mao Jinlong wrote:
>>> In commit 6746eae4bbad ("coresight: cti: Fix hang in cti_disable_hw()")
>>> PM runtime calls are removed from cti_enable_hw/cti_disable_hw. When
>>> enabling CTI by writing enable sysfs node, clock for accessing CTI
>>> register won't be enabled. Device will crash due to register access
>>> issue. Add PM runtime call in enable_store to fix this issue.
>>>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-cti-sysfs.c | 11 +++++++++--
>>>   1 file changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>>> index 6d59c815ecf5..b1ed424ae043 100644
>>> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>>> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>>> @@ -108,10 +108,17 @@ static ssize_t enable_store(struct device *dev,
>>>   	if (ret)
>>>   		return ret;
>>>   
>>> -	if (val)
>>> +	if (val) {
>>> +		ret = pm_runtime_resume_and_get(dev->parent);
>>> +		if (ret)
>>> +			return ret;
>>>   		ret = cti_enable(drvdata->csdev);
>>> -	else
>>> +		if (ret)
>>> +			pm_runtime_put(dev->parent);
>>> +	} else {
>>>   		ret = cti_disable(drvdata->csdev);
>>> +		pm_runtime_put(dev->parent);
>> Hi Jinlong,
>>
>> This new pm_runtime_put() causes this when writing 0 to enable:
>>
>>    [  483.253814] coresight-cti 23020000.cti: Runtime PM usage count
>> underflow!
>>
>> Maybe we can modify cti_disable_hw() to return a value to indicate that
>> the disable actually happened, and only then call pm_runtime_put().
>>
>> I suppose you could also check in the store function if it was already
>> enabled first, but then I don't know what kind of locking that would
>> need? cti_disable_hw() already seems to have a couple of locks, so maybe
>> the return value solution is easiest.
>>
> We've also just seen another issue where multiple calls to
> cti_disable_hw() can cause enable_req_count to go negative. I'm going to
> work on a few fixes (including yours) to make sure that it's complete
> and post it shortly.
Ok, Thank you, James.
>
> James
