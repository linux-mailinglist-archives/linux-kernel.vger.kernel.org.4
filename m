Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC364711E64
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233446AbjEZDWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZDWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:22:33 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE08E6;
        Thu, 25 May 2023 20:22:31 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q2TwOw010612;
        Fri, 26 May 2023 03:22:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JkWX5L9gyKc/0W445AAyBxEbFhKF9nKxC5bGBMk75ns=;
 b=KYxocXxvAKtGMg0DOLrKQPuZzfcBhW515q0Aj2IHSFfH48igGATDq7sPUJKYQT+jTcd3
 yrUYKDT8cwlY6FhLadMSGDR5uYzKg9z5O00X7xP/jPsapvkOg9khjlXGdJzA8BsI2D4G
 M5KSGFw00szTu+g5Lz12M0vWX5m9d9qDCn4/0Qp6dH2uJBTC10EJCtol2fsT/nxOz57H
 l9g/QNwIrP3hUWIncfaoJ1Vd2v3k+uVZYHMx1MJTwHfOqgQ6a0XN4PqIFeR3o8eNZ/lQ
 R9FGWPeXYxcMfHk0I1EmC5RF84iWIxjOOCxD0wipXVrcelX6jtgbe4hAd2U/w+fdwdI0 KQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt1tqtda2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 03:22:08 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34Q3M78M023707
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 03:22:07 GMT
Received: from [10.253.77.32] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 20:22:02 -0700
Message-ID: <14a10466-3241-4375-f795-92cd155b27d7@quicinc.com>
Date:   Fri, 26 May 2023 11:22:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/11] coresight-tpda: Add DSB dataset support
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
 <1682586037-25973-3-git-send-email-quic_taozha@quicinc.com>
 <444bc278-a3e3-7d99-6020-7c3337371f66@arm.com>
 <9c4c4ea0-b5dd-d18a-fadf-cd3a65c2cf5a@quicinc.com>
 <9f414290-0219-302f-ca8b-231217e68efb@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <9f414290-0219-302f-ca8b-231217e68efb@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZFbvdBHDwdDCT61jFidt0osoooU-ic03
X-Proofpoint-GUID: ZFbvdBHDwdDCT61jFidt0osoooU-ic03
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 adultscore=0 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260028
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/25/2023 5:08 PM, Suzuki K Poulose wrote:
> On 25/05/2023 08:16, Tao Zhang wrote:
>>
>> On 5/23/2023 6:07 PM, Suzuki K Poulose wrote:
>>> On 27/04/2023 10:00, Tao Zhang wrote:
>>>> Read the DSB element size from the device tree. Set the register
>>>> bit that controls the DSB element size of the corresponding port.
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-core.c |  1 +
>>>>   drivers/hwtracing/coresight/coresight-tpda.c | 92 
>>>> +++++++++++++++++++++++++---
>>>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>>>   drivers/hwtracing/coresight/coresight-tpdm.c |  2 +-
>>>>   include/linux/coresight.h                    |  1 +
>>>>   5 files changed, 90 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>>> b/drivers/hwtracing/coresight/coresight-core.c
>>>> index 2af416b..f1eacbb 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>>> @@ -1092,6 +1092,7 @@ static int coresight_validate_source(struct 
>>>> coresight_device *csdev,
>>>>         if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>>>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>>>> +        subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
>>>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>>>>           dev_err(&csdev->dev, "wrong device subtype in %s\n", 
>>>> function);
>>>>           return -EINVAL;
>>>
>>> Please see the comment at the bottom.
>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> index 8d2b9d2..af9c72f 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> @@ -21,6 +21,56 @@
>>>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>>>   +/* Search and read element data size from the TPDM node in
>>>> + * the devicetree. Each input port of TPDA is connected to
>>>> + * a TPDM. Different TPDM supports different types of dataset,
>>>> + * and some may support more than one type of dataset.
>>>> + * Parameter "inport" is used to pass in the input port number
>>>> + * of TPDA, and it is set to 0 in the recursize call.
>>>> + * Parameter "parent" is used to pass in the original call.
>>>> + */
>>>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>>>> +               struct coresight_device *csdev, int inport, bool 
>>>> parent)
>>>> +{
>>>> +    static int nr_inport;
>>>> +    int i;
>>>> +    static bool tpdm_found;
>>>> +    struct coresight_device *in_csdev;
>>>> +
>>>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>>>> +        return -EINVAL;
>>>> +
>>>> +    if (parent) {
>>>> +        nr_inport = inport;
>>>> +        tpdm_found = false;
>>>> +    }
>>>> +
>>>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>>>> +        in_csdev = csdev->pdata->in_conns[i]->src_dev;
>>>> +        if (!in_csdev)
>>>> +            break;
>>>> +
>>>> +        if (parent)
>>>> +            if (csdev->pdata->in_conns[i]->dest_port != inport)
>>>> +                continue;
>>>> +
>>>> +        if (in_csdev->subtype.source_subtype
>>>
>>> We must match the in_csdev->type to be SOURCE && the subtype.
>> Sure, I will update it in the next patch series.
>>>
>>>> +                   == CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM) {
>>>> + of_property_read_u8(in_csdev->dev.parent->of_node,
>>>> +                    "qcom,dsb-element-size", 
>>>> &drvdata->dsb_esize[nr_inport]);
>>>> +            if (!tpdm_found)
>>>> +                tpdm_found = true;
>>>> +            else
>>>> +                dev_warn(drvdata->dev,
>>>> +                    "More than one TPDM is mapped to the TPDA 
>>>> input port %d.\n",
>>>> +                    nr_inport);
>>>
>>> When we know, we have found a source device, we don't need to recurse
>>> down and could simply 'continue' to the next one in the list and skip
>>> the call below.
>>
>> Actually, one input port on TPDA only can connect to one TPDM. In the 
>> current design, it will
>>
>> find out all the TPDMs on one input port and warn the users all the 
>> TPDMs it found. If we
>>
>> replace 'recurse down' as 'continue' here, it may not find some TPDMs 
>> that might be connected
>>
>> incorrectly.
>
>
> What do you mean ? When you enter the if () above, the in_csdev is a
> source and it is TPDM. There must be no input connections TPDM, i.e.
> in_csdev, so no need to go further up the connection chain looking at
> the in_csdev. The loop will continue to analyse this device (where we
> found one TPDM already) and detect any further duplicate TPDMs
> connected.

Got it. You're right.

I will update this in the next patch series as well.

>
> Suzuki
>
>
