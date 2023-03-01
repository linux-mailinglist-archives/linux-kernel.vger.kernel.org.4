Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCA136A677A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 06:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjCAF6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 00:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCAF6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 00:58:09 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F271A6589;
        Tue, 28 Feb 2023 21:58:07 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3215Locq028054;
        Wed, 1 Mar 2023 05:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=sJHkVNLDe4q7NjkF+zztXSzaH3pkD4GmEBSv7lNGWIc=;
 b=M6USLWnxQhJ/efSei0PbDLvGutHZohkDiJvsmh8vOBbabf44lWFqNF0JtyyXD1JeejXX
 IPZvzAktfbFQr0C3+dF5Y5lwxDj04MFk5VypeSVizbA5KoT93RePUL9b7ugmd5bQeHs4
 7Vca54uO+HKa3Z3rKTYnwPh793JQKY0X1O3Yx8Zne+iqNR4Bk2TZz4xvB2F+3BFAlPnD
 mTMNYOTYOo+ugm0gbWDguzGP0YpJCiKievyX6dv8QU+7YPR4DzcImO+aMAMexK+L024u
 6SIp5Pa9HLldDfHXE2ZhLueGdS/tZ619tETvO9mnfrK2BIb08fyTN8Q9rbqkU2+cSnQU +g== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1f7n311c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 05:57:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3215vf5f024830
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 05:57:41 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Feb
 2023 21:57:36 -0800
Message-ID: <f95a452e-089b-b92b-d5e5-941db4d64c9c@quicinc.com>
Date:   Wed, 1 Mar 2023 13:57:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 3/9] coresight-tpdm: Initialize DSB subunit
 configuration
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
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        Tao Zhang <taozha@qti.qualcomm.com>
References: <1674114105-16651-1-git-send-email-quic_taozha@quicinc.com>
 <1674114105-16651-4-git-send-email-quic_taozha@quicinc.com>
 <ba7dba61-9fa1-1b6f-c95e-2c23d8f9c2d4@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <ba7dba61-9fa1-1b6f-c95e-2c23d8f9c2d4@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: betb3lZ9JqFh0Z7Zln9KEHA3bTPqYcSQ
X-Proofpoint-ORIG-GUID: betb3lZ9JqFh0Z7Zln9KEHA3bTPqYcSQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_02,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 adultscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2303010045
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi，

在 2/28/2023 7:16 PM, Suzuki K Poulose 写道:
> On 19/01/2023 07:41, Tao Zhang wrote:
>> DSB subunit need to be configured in enablement and disablement.
>> A struct that specifics associated to dsb dataset is needed. It
>> saves the configuration and parameters of the dsb datasets. This
>> change is to add this struct and initialize the configuration of
>> DSB subunit.
>
> Please could add a line about the type of things you can do with DSB.
> e.g, Timestamp, trigger type etc ? The description seems to be 
> describing the code, rather than the functionality of the code.
>
Sure, I will add more information according to your advice in the next 
version of the patch.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
>
> As pointed out on the previous response by someone else, please fix the
> above to single.
>
>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 57 
>> ++++++++++++++++++++++++++--
>>   drivers/hwtracing/coresight/coresight-tpdm.h | 17 +++++++++
>>   2 files changed, 70 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index d85ca96..6befc87 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -24,13 +24,35 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>   {
>>       u32 val;
>>   +    val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>> +    /* Set trigger timestamp */
>> +    if (drvdata->dsb->trig_ts)
>> +        val |= TPDM_DSB_XTRIG_TSENAB;
>> +    else
>> +        val &= ~TPDM_DSB_XTRIG_TSENAB;
>> +    writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>> +
>> +    val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +    /* Set trigger type */
>> +    if (drvdata->dsb->trig_type)
>> +        val |= TPDM_DSB_TRIG_TYPE;
>> +    else
>> +        val &= ~TPDM_DSB_TRIG_TYPE;
>> +    writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>> +
>>       /* Set the enable bit of DSB control register to 1 */
>>       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>>       val |= TPDM_DSB_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>
> Do they have to be written out separately ? Why not combine the value 
> updates to the TPDM_DSB_CR ?
>
Sure, I will combine the value in the next version of the patch.
>
>>   }
>>   -/* TPDM enable operations */
>> +/* TPDM enable operations
>
> Minor nit: Comment style issues.
>
>
>> + * The TPDM or Monitor serves as data collection component for various
>> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
>> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
>> + * Bit(DSB). This function will initialize the configuration according
>> + * to the dataset type supported by the TPDM.
>> + */
>>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>>   {
>>       CS_UNLOCK(drvdata->base);
>> @@ -110,15 +132,33 @@ static const struct coresight_ops tpdm_cs_ops = {
>>       .source_ops    = &tpdm_source_ops,
>>   };
>>   -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>> +static void tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 pidr;
>>   -    CS_UNLOCK(drvdata->base);
>>       /*  Get the datasets present on the TPDM. */
>>       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>>       drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>> -    CS_LOCK(drvdata->base);
>> +}
>> +
>> +static int tpdm_datasets_alloc(struct tpdm_drvdata *drvdata)
>> +{
>> +    if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>> +        drvdata->dsb = devm_kzalloc(drvdata->dev, 
>> sizeof(*drvdata->dsb),
>> +                        GFP_KERNEL);
>> +        if (!drvdata->dsb)
>> +            return -ENOMEM;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>
> Couldn't this be moved into the init_default_data() ?
>
>> +static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>> +{
>> +    if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>> +        drvdata->dsb->trig_ts = true;
>> +        drvdata->dsb->trig_type = false;
>
>
>
>> +    }
>>   }
>
> It looks a bit silly to move the initialisation to a separate 
> function. Please could you fold this to tpdm_datasets_alloc() and may 
> be even
> rename that function to tpdm_init_datasets() ?
Sure, I will update the code according to your advice in the next 
version of the patch.
>
> Suzuki
>
>>     /*
>> @@ -181,6 +221,7 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>       struct coresight_platform_data *pdata;
>>       struct tpdm_drvdata *drvdata;
>>       struct coresight_desc desc = { 0 };
>> +    int ret;
>>         pdata = coresight_get_platform_data(dev);
>>       if (IS_ERR(pdata))
>> @@ -200,6 +241,8 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>         drvdata->base = base;
>>   +    tpdm_datasets_setup(drvdata);
>> +
>>       /* Set up coresight component description */
>>       desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>>       if (!desc.name)
>> @@ -216,7 +259,13 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>           return PTR_ERR(drvdata->csdev);
>>         spin_lock_init(&drvdata->spinlock);
>> +    ret = tpdm_datasets_alloc(drvdata);
>> +    if (ret) {
>> +        coresight_unregister(drvdata->csdev);
>> +        return ret;
>> +    }
>>       tpdm_init_default_data(drvdata);
>> +
>>       /* Decrease pm refcount when probe is done.*/
>>       pm_runtime_put(&adev->dev);
>>   diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 5438540..3ad1be5 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -11,8 +11,14 @@
>>     /* DSB Subunit Registers */
>>   #define TPDM_DSB_CR        (0x780)
>> +#define TPDM_DSB_TIER        (0x784)
>> +
>>   /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>> +/* Enable bit for DSB subunit trigger timestamp */
>> +#define TPDM_DSB_XTRIG_TSENAB        BIT(1)
>> +/* Enable bit for DSB subunit trigger type */
>> +#define TPDM_DSB_TRIG_TYPE        BIT(12)
>>     /* TPDM integration test registers */
>>   #define TPDM_ITATBCNTRL        (0xEF0)
>> @@ -41,6 +47,16 @@
>>   #define TPDM_PIDR0_DS_DSB    BIT(1)
>>     /**
>> + * struct dsb_dataset - specifics associated to dsb dataset
>> + * @trig_ts:          Enable/Disable trigger timestamp.
>> + * @trig_type:        Enable/Disable trigger type.
>> + */
>> +struct dsb_dataset {
>> +    bool            trig_ts;
>> +    bool            trig_type;
>> +};
>> +
>> +/**
>>    * struct tpdm_drvdata - specifics associated to an TPDM component
>>    * @base:       memory mapped base address for this component.
>>    * @dev:        The device entity associated to this component.
>> @@ -57,6 +73,7 @@ struct tpdm_drvdata {
>>       spinlock_t        spinlock;
>>       bool            enable;
>>       unsigned long        datasets;
>> +    struct dsb_dataset    *dsb;
>>   };
>>     #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
>
