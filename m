Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB36E6C9BB5
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 09:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbjC0HL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 03:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjC0HLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 03:11:25 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10364482;
        Mon, 27 Mar 2023 00:11:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R2Q6ZA001186;
        Mon, 27 Mar 2023 07:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=EXRlzh/rBQO3dxlb4NEK2QXdnyJZoEfzEISuMf/Iix8=;
 b=DCxWgtbF40uTohGqX4QdeCvdzQao8HD3XrfX8b7U+L9TEIIzPDABG3XtRnw+qJE9a3TY
 cYt7401YqCFIycLpvnhJcJRANvB/gRbpQ+uBnmbvei4WJQNXUT/KS2pY9yTMML91MF8U
 gWIdQNaikNWIU6Oi1BwmRLDvBI2O6m+EbaO90LBum1hp16HsYwPyGwd+v/j1isYSzoiP
 A+0ES8amQ1l3gUkaOCphdvytONcb5e6o+L/bjxEzWeZlsuRpHbI8HRCgXrLCXDuakhuj
 tpU7AZwBVNCDQCubHDD8DKEpYP1HjzQU5wZOOEmtqf/jveXzinyZMbJuT1huqAnyAFSQ yQ== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3phsrsbn3f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 07:11:12 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R7BC7m009475
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 07:11:12 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 27 Mar
 2023 00:11:07 -0700
Message-ID: <fd73a605-9d23-99a5-4abf-5442063c6f39@quicinc.com>
Date:   Mon, 27 Mar 2023 15:11:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 04/11] coresight-tpdm: Add reset node to TPDM node
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
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-5-git-send-email-quic_taozha@quicinc.com>
 <a7484268-49a5-632b-bfc2-8731de01d82b@arm.com>
 <4cde9235-e86a-73a0-5c6c-ac193328006b@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <4cde9235-e86a-73a0-5c6c-ac193328006b@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UTwmiRHHDPF6TwzGhv60l_CsbFP9Ku-5
X-Proofpoint-GUID: UTwmiRHHDPF6TwzGhv60l_CsbFP9Ku-5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2303270057
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On 3/23/2023 10:48 PM, Suzuki K Poulose wrote:
> On 23/03/2023 14:41, Suzuki K Poulose wrote:
>> On 23/03/2023 06:04, Tao Zhang wrote:
>>> TPDM device need a node to reset the configurations and status of
>>> it. This change provides a node to reset the configurations and
>>> disable the TPDM if it has been enabled.
>
> Please justify why this "do everything" magic knob is required
> when there are tunables for individual controls in the later
> patches.

We want to have a single knob that resets all the datasets, which saves the

need to configure the individual controls one by one. Since it is often 
necessary

to reset all the datasets, this knob will be more user-friendly.


Tao

>
> Suzuki
>
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-tpdm.c | 28 
>>> ++++++++++++++++++++++++++++
>>>   1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> index 5e1e2ba..104638d 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> @@ -161,6 +161,33 @@ static void tpdm_datasets_setup(struct 
>>> tpdm_drvdata *drvdata)
>>>       drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>>>   }
>>> +static ssize_t reset_store(struct device *dev,
>>> +                      struct device_attribute *attr,
>>> +                      const char *buf,
>>> +                      size_t size)
>>> +{
>>> +    int ret = 0;
>>> +    unsigned long val;
>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +
>>> +    ret = kstrtoul(buf, 10, &val);
>>> +    if (ret || val != 1)
>>> +        return -EINVAL;
>>> +
>>> +    spin_lock(&drvdata->spinlock);
>>> +    /* Reset all datasets to ZERO, and init the default data*/
>>> +    tpdm_init_datasets(drvdata);
>>
>> With the suggested rename in the previous patch, you wouldn't need
>> a comment here.
>>
>>> +
>>> +    spin_unlock(&drvdata->spinlock);
>>> +
>>
>>
>>> +    /* Disable tpdm if enabled */
>>> +    if (drvdata->enable)
>>> +        coresight_disable(drvdata->csdev);
>>
>> Couldn't this be done via disable_source ? Please don't overload
>> the sysfs handle.
>>
>>> +
>>> +    return size;
>>> +}
>>> +static DEVICE_ATTR_WO(reset);
>>
>> Documentation for the sysfs node please ?
>>
>> Suzuki
>>
>
