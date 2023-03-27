Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B980F6C9B81
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 08:46:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjC0Gqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 02:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232356AbjC0Gqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 02:46:49 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C7849E6;
        Sun, 26 Mar 2023 23:46:40 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32R5PDt4022835;
        Mon, 27 Mar 2023 06:46:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=GmozCoh1OO4sUpHU5imMX3MSULoHp3Cr9bwCUFL8NUk=;
 b=C5xlM8X9j7JFYxZ/bbHd9VuPccap7ruYbDRgLmPpkzmU98QbeWfsPU1Nd+bTtBW2nJof
 LUiJrVpbrRZHc+dX9hHib3Zf5Z9fuQ4AFNfz7CJIHUDDvaQhGWK5kSUv7xL9w1wyo6si
 ftGjggeIkgat8xPgPYyWmslBPrdcACry+kBQij0R42UAbbimIJa+8MxUQ6NzNNWFO1qz
 UYanvmHWHphFpc823TJE2FfTtmdjToH4ByjoHFFiKHXeKdqB6ws2hlS51ZAzSKRF/07i
 mPy3BHtU7Bju3tgPvp3MiIxtG0Sxv3LAlcz+N7b9STWf55I3EgYWq6BijwPaXcCpJFZN vA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pht50uj3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 06:46:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32R6kO68021300
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Mar 2023 06:46:24 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Mar
 2023 23:46:19 -0700
Message-ID: <97b04ae0-7337-4bfc-9762-de5213b0fefd@quicinc.com>
Date:   Mon, 27 Mar 2023 14:46:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 03/11] coresight-tpdm: Initialize DSB subunit
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
        <linux-arm-msm@vger.kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
References: <1679551448-19160-1-git-send-email-quic_taozha@quicinc.com>
 <1679551448-19160-4-git-send-email-quic_taozha@quicinc.com>
 <65bb7624-9d57-1056-61fd-ae840728ecd6@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <65bb7624-9d57-1056-61fd-ae840728ecd6@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: feABl6dz-X82k9ocLeaaFo-YGw1dU1qa
X-Proofpoint-ORIG-GUID: feABl6dz-X82k9ocLeaaFo-YGw1dU1qa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303270055
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

On 3/23/2023 10:23 PM, Suzuki K Poulose wrote:
> On 23/03/2023 06:04, Tao Zhang wrote:
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
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 58 
>> +++++++++++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tpdm.h | 17 ++++++++
>>   2 files changed, 70 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index f4854af..5e1e2ba 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,17 +20,59 @@
>>     DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>   +static int tpdm_init_datasets(struct tpdm_drvdata *drvdata)
>
>
>> +{
>> +    if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>> +        if (!drvdata->dsb) {
>> +            drvdata->dsb = devm_kzalloc(drvdata->dev,
>> +                            sizeof(*drvdata->dsb), GFP_KERNEL);
>> +            if (!drvdata->dsb)
>> +                return -ENOMEM;
>
> Please do not club init/allocation of datasets to "resetting" the
> datasets. Why don't we move the allocation to tpmd_datasets_setup() ?
> And this function could simply be called :
>
> tpdm_reset_datasets()
>
> and can be called from the tpdm_datasets_setup() too.
>
I will update this in the next patch series.
>
>> +        } else
>> +            memset(drvdata->dsb, 0, sizeof(struct dsb_dataset));
>> +
>> +        drvdata->dsb->trig_ts = true;
>> +        drvdata->dsb->trig_type = false;
>> +    }
>> +
>> +    return 0;
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
> Do we really need a function for this ? How is it different from 
> trig_ts ?

"trig_type" is for setting trigger type, and "trig_ts" is for setting 
trigger

timestamp. These two variables are configured in two different registers.

Do you mean we don't need to wrap it as a function here?

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
>> +        val &= ~TPDM_DSB_TIER_XTRIG_TSENAB;
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
>> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
>> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete Single
>> + * Bit(DSB). This function will initialize the configuration according
>> + * to the dataset type supported by the TPDM.
>> + */
>>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>>   {
>>       CS_UNLOCK(drvdata->base);
>> @@ -110,15 +152,13 @@ static const struct coresight_ops tpdm_cs_ops = {
>>       .source_ops    = &tpdm_source_ops,
>>   };
>>   -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>> +static void tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 pidr;
>>   -    CS_UNLOCK(drvdata->base);
>
> Why is this removed ?
We only need to read the register here, don't need to unlock the 
registers here, right?
>
>>       /*  Get the datasets present on the TPDM. */
>>       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>>       drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>> -    CS_LOCK(drvdata->base);
>>   }
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
>> @@ -216,7 +259,12 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>           return PTR_ERR(drvdata->csdev);
>>         spin_lock_init(&drvdata->spinlock);
>> -    tpdm_init_default_data(drvdata);
>> +    ret = tpdm_init_datasets(drvdata);
>
> Couldn't this be done before the coresight_register() ? As such
> I don't see any dependency on having a csdev ?

I will update this in the next patch series.


Tao

>
> Suzuki
