Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E673710861
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 11:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240563AbjEYJKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239477AbjEYJKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 05:10:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A1A19D;
        Thu, 25 May 2023 02:10:20 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P5wC9D026948;
        Thu, 25 May 2023 08:36:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=8XmZME8S/hSVxhMmXf5zce++tCkHuKRuDWiKPuahVH8=;
 b=gw6rijq9KdllokDqWGpqle5MnTTWxcyl7HcfYdrRC86S+q9YIYkbb+15B9jMZ54apZEG
 OqYU5xOctFUIvlnK76iuiDb4jT9wsTatlGhXXebnYuV7zmHLABlRdY+KHKGXLDDoFt+S
 3SOa3xTs27sW0GUvlof1+2a8ah21G0AYvI3jv45nTNUINeeufzTUroCY3nBaLxEqbkeg
 pEAsu5ChfZbCVZDmWyKFXpy3BNPHIvOjlrc9Zn0Duv98WXTruyJAxb7hRN5dyD7aC+oi
 obwCtZ6K4JZoaUMa9IoPUY6xfoh4I7iNUNxvQOxgB6gFhHz5XvFmXcCqlJoVyNgG9tUN jg== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qstg3s55d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 08:36:22 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34P8aLk8023260
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 08:36:21 GMT
Received: from [10.253.35.57] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 01:36:17 -0700
Message-ID: <597533f3-9920-1c48-423d-627812b2972d@quicinc.com>
Date:   Thu, 25 May 2023 16:36:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 04/11] coresight-tpdm: Add reset node to TPDM node
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-5-git-send-email-quic_taozha@quicinc.com>
 <0947825d-5c2f-0e75-cfe8-ef4c6fa8d502@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <0947825d-5c2f-0e75-cfe8-ef4c6fa8d502@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: vfeODFJK6-waFgmJm_3Cw2z-o8yCr3p_
X-Proofpoint-ORIG-GUID: vfeODFJK6-waFgmJm_3Cw2z-o8yCr3p_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_04,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 bulkscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 spamscore=0 clxscore=1015 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250071
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2023 10:53 PM, Suzuki K Poulose wrote:
> On 27/04/2023 10:00, Tao Zhang wrote:
>> TPDM device need a node to reset the configurations and status of
>> it. This change provides a node to reset the configurations and
>> disable the TPDM if it has been enabled.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 10 ++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 27 
>> ++++++++++++++++++++++
>>   2 files changed, 37 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 4a58e64..686bdde 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -11,3 +11,13 @@ Description:
>>           Accepts only one of the 2 values -  1 or 2.
>>           1 : Generate 64 bits data
>>           2 : Generate 32 bits data
>> +
>> +What:        /sys/bus/coresight/devices/<tpdm-name>/reset
>> +Date:        March 2023
>> +KernelVersion    6.3
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Reset the dataset of the tpdm, and disable the tpdm.
>> +
>> +        Accepts only one value -  1.
>> +        1 : Reset the dataset of the tpdm
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 6f8a8ab..2e64cfd 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -164,6 +164,32 @@ static int tpdm_datasets_setup(struct 
>> tpdm_drvdata *drvdata)
>>       return 0;
>>   }
>>   +static ssize_t reset_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    int ret = 0;
>> +    unsigned long val;
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    ret = kstrtoul(buf, 10, &val);
>> +    if (ret || val != 1)
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    tpdm_reset_datasets(drvdata);
>> +
>> +    spin_unlock(&drvdata->spinlock);
>> +
>> +    /* Disable tpdm if enabled */
>> +    if (drvdata->enable)
>> +        coresight_disable_source(drvdata->csdev, NULL);
>
> I am not really keen on doing this behind the back. What about the 
> path of components ? We could simply reject the request when the TPDA 
> is enabled and let the user alway follow :
>     1) Disable the TPDM manually via sysfs
>       2) Reset the TPDM.
>
> So, please remove the disable step here.

I will update this in the next patch series.

Best,

Tao

>
> Suzuki
>
>
>> +
>> +    return size;
>> +}
>> +static DEVICE_ATTR_WO(reset);
>> +
>>   /*
>>    * value 1: 64 bits test data
>>    * value 2: 32 bits test data
>> @@ -204,6 +230,7 @@ static ssize_t integration_test_store(struct 
>> device *dev,
>>   static DEVICE_ATTR_WO(integration_test);
>>     static struct attribute *tpdm_attrs[] = {
>> +    &dev_attr_reset.attr,
>>       &dev_attr_integration_test.attr,
>>       NULL,
>>   };
>
