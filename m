Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E7771070F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 10:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239374AbjEYINi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239233AbjEYINc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 04:13:32 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE1E6B;
        Thu, 25 May 2023 01:13:13 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P8346L002689;
        Thu, 25 May 2023 08:13:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=kzKB8Wp7DjuOYhHLVOhTtM0p7bx4Gzr9kevGg3pmfa8=;
 b=iZ04b8Vhuu4/8a2cDGN/HhE05pJWGL2nor4xL0/s5HjX7TO1H9Bh0X0kUjN+1VxXqh6b
 Ntv2+z9oNpipsUok/iwR7/48ibU8I3MyGTQ38L2RdNtmq4gYSj5J4vzQf+wdcF1wzsA2
 UdQnfonhzOA0NsnVX18vpNf61f+K2My/00sKxkF2LaIniEdU3EWrSatStFHOZr6yi5CR
 r/z5OByWYENDi/1JPeUAEyZ1UvEIha3J5wS0uF3A5QIceGq4kOjiqGgW/oMqEn5nf7t+
 3pnQQlg9D0a3252h2d7+dLPTVtRKQ9SkTswNkI2Xod17me0b0xfT4kOAfzcYHM2LXyjj Ug== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt27n078y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 08:13:01 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34P8D0HU004032
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 08:13:00 GMT
Received: from [10.253.35.57] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 01:12:55 -0700
Message-ID: <92b73ba2-00c5-9f18-ed27-a302f4e79bb2@quicinc.com>
Date:   Thu, 25 May 2023 16:12:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 03/11] coresight-tpdm: Initialize DSB subunit
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1682586037-25973-1-git-send-email-quic_taozha@quicinc.com>
 <1682586037-25973-4-git-send-email-quic_taozha@quicinc.com>
 <db575b8f-12e9-dab5-c7f6-b524cbce64d9@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <db575b8f-12e9-dab5-c7f6-b524cbce64d9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BK311cghrnofA7PuIn-m35GtUZd36ZVk
X-Proofpoint-GUID: BK311cghrnofA7PuIn-m35GtUZd36ZVk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_04,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250067
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2023 9:42 PM, Suzuki K Poulose wrote:
> On 27/04/2023 10:00, Tao Zhang wrote:
>> DSB is used for monitoring “events”. Events are something that
>> occurs at some point in time. It could be a state decode, the
>> act of writing/reading a particular address, a FIFO being empty,
>> etc. This decoding of the event desired is done outside TPDM.
>> DSB subunit need to be configured in enablement and disablement.
>> A struct that specifics associated to dsb dataset is needed. It
>> saves the configuration and parameters of the dsb datasets. This
>> change is to add this struct and initialize the configuration of
>> DSB subunit.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 60 
>> +++++++++++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tpdm.h | 17 ++++++++
>>   2 files changed, 72 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index ba1867f..6f8a8ab 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,17 +20,51 @@
>>     DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>   +static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>> +{
>> +    if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>> +        memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
>> +
>> +        drvdata->dsb->trig_ts = true;
>> +        drvdata->dsb->trig_type = false;
>> +    }
>> +}
>> +
>> +static void set_trigger_type(struct tpdm_drvdata *drvdata, u32 *val)
>> +{
>> +    if (drvdata->dsb->trig_type)
>> +        *val |= TPDM_DSB_CR_TRIG_TYPE;
>> +    else
>> +        *val &= ~TPDM_DSB_CR_TRIG_TYPE;
>> +}
>> +
>
> Given this is not reused, we could simply inline it in the caller
> to avoid creating a confusion, like other operations ?
Sure, I will update it in the next patch series.
>
>>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 val;
>>   -    /* Set the enable bit of DSB control register to 1 */
>> +    val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>> +    /* Set trigger timestamp */
>> +    if (drvdata->dsb->trig_ts)
>> +        val |= TPDM_DSB_TIER_XTRIG_TSENAB;
>> +    else
>> +        val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;,
>> +    writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>> +
>>       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +    /* Set trigger type */
>> +    set_trigger_type(drvdata, &val);
>> +    /* Set the enable bit of DSB control register to 1 */
>>       val |= TPDM_DSB_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>   }
>>     /* TPDM enable operations */
>> +/* The TPDM or Monitor serves as data collection component for various
>
> minor nit: Please could you extend the existing comment than adding a
> new multi-line comment ?
Sure, I will update it in the next patch series.
>
>> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
>> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
>> + * Bit(DSB). This function will initialize the configuration according
>> + * to the dataset type supported by the TPDM.
>> + */
>>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>>   {
>>       CS_UNLOCK(drvdata->base);
>> @@ -110,15 +144,24 @@ static const struct coresight_ops tpdm_cs_ops = {
>>       .source_ops    = &tpdm_source_ops,
>>   };
>>   -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>> +static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 pidr;
>>   -    CS_UNLOCK(drvdata->base);
>>       /*  Get the datasets present on the TPDM. */
>>       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>>       drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>> -    CS_LOCK(drvdata->base);
>
> Why are we removing the CS_{UN,}LOCK here ?

CS_UNLOCK is used before writing data to Coresight registers. Here this 
function

doesn't need to write data to any registers, so I remove the 
CS_{UN,}LOCK here.


Best,

Tao

>
> Rest looks OK to me.
>
> Suzuki
>
>> +
>> +    if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>> +        if (!drvdata->dsb) {
>> +            drvdata->dsb = devm_kzalloc(drvdata->dev,
>> +                            sizeof(*drvdata->dsb), GFP_KERNEL);
>> +            if (!drvdata->dsb)
>> +                return -ENOMEM;
>> +        }
>> +    }
>> +
>> +    return 0;
>>   }
>>     /*
>> @@ -181,6 +224,7 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>       struct coresight_platform_data *pdata;
>>       struct tpdm_drvdata *drvdata;
>>       struct coresight_desc desc = { 0 };
>> +    int ret;
>>         pdata = coresight_get_platform_data(dev);
>>       if (IS_ERR(pdata))
>> @@ -200,6 +244,12 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>         drvdata->base = base;
>>   +    ret = tpdm_datasets_setup(drvdata);
>> +    if (ret)
>> +        return ret;
>> +
>> +    tpdm_reset_datasets(drvdata);
>> +
>>       /* Set up coresight component description */
>>       desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>>       if (!desc.name)
>> @@ -216,7 +266,7 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>           return PTR_ERR(drvdata->csdev);
>>         spin_lock_init(&drvdata->spinlock);
>> -    tpdm_init_default_data(drvdata);
>> +
>>       /* Decrease pm refcount when probe is done.*/
>>       pm_runtime_put(&adev->dev);
>>   diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 5438540..68f33bd 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -11,8 +11,14 @@
>>     /* DSB Subunit Registers */
>>   #define TPDM_DSB_CR        (0x780)
>> +#define TPDM_DSB_TIER        (0x784)
>> +
>>   /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>> +/* Enable bit for DSB subunit trigger type */
>> +#define TPDM_DSB_CR_TRIG_TYPE        BIT(12)
>> +/* Enable bit for DSB subunit trigger timestamp */
>> +#define TPDM_DSB_TIER_XTRIG_TSENAB        BIT(1)
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
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
