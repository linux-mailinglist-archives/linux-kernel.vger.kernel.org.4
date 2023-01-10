Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0F86638F7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 06:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237072AbjAJF6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 00:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjAJF4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 00:56:45 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA75D38AEF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 21:56:24 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30A4Y13V024098;
        Tue, 10 Jan 2023 05:56:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tKK01sNeyDqonUUO5XpsTyUXK4IEwjCbW2BsKTbWGVU=;
 b=fhe/Cbdcdsi+RINBywWUrRnHIT28V+FO10Ji4udRTfsLl7C+rLatAfRdAebKEct7X75R
 EcSJcQb+j+c5vyid7u/P4j54tRWbMgCBsTy/x3AnwielACKVl0LJX7sFWX69uCWEhVl/
 Ti+KltEfpUjPkH4JGQ36DG/GYruPkrarlSxKN7zY4H9S2/YOmf8qKTepAAbDq1rsv8pe
 N8xjnQZNIfxIoerrjDl4CgBfahKqSJbyCD3OPcSVWOVQSZo+uvBDPWCjKRcXUt0hsUzM
 mmx+dG0N1xK1Aj2CapxjH3CY7kx2jUeJVLMT0VlzfTos5J2TJhV25S6jceZS1Ydf6bpa Rg== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3n113p04m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 05:56:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30A5u7YA021507
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Jan 2023 05:56:07 GMT
Received: from [10.253.38.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 9 Jan 2023
 21:56:04 -0800
Message-ID: <487a882b-8c88-095a-b6b2-d76fddcaecc6@quicinc.com>
Date:   Tue, 10 Jan 2023 13:56:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v2 2/3] coresight: cti: Add PM runtime call in
 enable_store
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        <coresight@lists.linaro.org>, <mike.leach@linaro.org>
CC:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230106152331.1374973-1-james.clark@arm.com>
 <20230106152331.1374973-3-james.clark@arm.com>
 <91bd54ff-f1e3-aa6b-8446-ad73916be6a7@arm.com>
From:   Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <91bd54ff-f1e3-aa6b-8446-ad73916be6a7@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tQ-g6InbOYmjdjBa7oyNrCum85qnywyq
X-Proofpoint-ORIG-GUID: tQ-g6InbOYmjdjBa7oyNrCum85qnywyq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_01,2023-01-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 adultscore=0
 suspectscore=0 mlxlogscore=963 impostorscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301100037
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/10/2023 12:47 AM, Suzuki K Poulose wrote:
> On 06/01/2023 15:23, James Clark wrote:
>> From: Mao Jinlong <quic_jinlmao@quicinc.com>
>>
>> In commit 6746eae4bbad ("coresight: cti: Fix hang in cti_disable_hw()")
>> PM runtime calls are removed from cti_enable_hw/cti_disable_hw. When
>> enabling CTI by writing enable sysfs node, clock for accessing CTI
>> register won't be enabled. Device will crash due to register access
>> issue. Add PM runtime call in enable_store to fix this issue.
>>
>> Fixes: 6746eae4bbad ("coresight: cti: Fix hang in cti_disable_hw()")
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> [Change to only call pm_runtime_put if a disable happened]
>> Signed-off-by: James Clark <james.clark@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-cti-sysfs.c | 13 +++++++++++--
>>   1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c 
>> b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>> index 6d59c815ecf5..71e7a8266bb3 100644
>> --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>> +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
>> @@ -108,10 +108,19 @@ static ssize_t enable_store(struct device *dev,
>>       if (ret)
>>           return ret;
>>   -    if (val)
>> +    if (val) {
>> +        ret = pm_runtime_resume_and_get(dev->parent);
>> +        if (ret)
>> +            return ret;
>>           ret = cti_enable(drvdata->csdev);
>> -    else
>> +        if (ret)
>> +            pm_runtime_put(dev->parent);
>> +    } else {
>>           ret = cti_disable(drvdata->csdev);
>> +        if (!ret)
>> +            pm_runtime_put(dev->parent);
>> +    }
>> +
>>       if (ret)
>>           return ret;
>>       return size;
>
> Looks good to me.
>
> @Mao Jinolong,
>
> Are you able to test the patches 1 & 2 and confirm they solve your 
> issue ?

Hi Suzuki,

Tested from my side. Patch 1 & 2 can solve the issue when enable CTI by 
writing 1 to enable sysfs node.

Thanks
Jinlong Mao
>
> Suzuki


