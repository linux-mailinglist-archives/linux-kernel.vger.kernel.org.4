Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972E371061C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235497AbjEYHRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjEYHRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:17:43 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F195010D4;
        Thu, 25 May 2023 00:17:21 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P6N41m010215;
        Thu, 25 May 2023 07:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=J0HPpo58NFHr4b68oS5eO5WiTpVbX9RgjHHCw93OrTA=;
 b=bSowd0zaCs3PkgVGzx5VZzODnYzZS4IcoFyGy4XVY7//PV5UhIBIqq+Rulr/OnPHaWQt
 KJPM2stg/cBnGnYzQn+9+3rlAUbamlya22pyzPR+Pe/tGG7L9FxBEzMIfOvKRQa+/DRk
 RUXuKrNlYyS8ZF7tzygYdlyaCAfK6HqXm3t0dDPxYptyZQLa9A3hz+lE1Ro2tSKSlZEZ
 N9xv9pkRNT9DBtZ8iSrJKs+lHD6MUtJC7++Vmwgtg0UD2p5GzE2spl59pcvVu5JNx1q9
 KTWx4mCmesu0fwqP7viKYz+sKU0aLE3h0LvwGS4VW0dZV1Jfow3Z7aEhyOYy15H9pNXL vQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt27n03pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 07:17:02 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34P7H2Ws029259
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 07:17:02 GMT
Received: from [10.253.35.57] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 00:16:57 -0700
Message-ID: <9c4c4ea0-b5dd-d18a-fadf-cd3a65c2cf5a@quicinc.com>
Date:   Thu, 25 May 2023 15:16:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/11] coresight-tpda: Add DSB dataset support
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
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <444bc278-a3e3-7d99-6020-7c3337371f66@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JmzYiXCK5fWXqgEStjrQu-tyKWAsZ8mU
X-Proofpoint-GUID: JmzYiXCK5fWXqgEStjrQu-tyKWAsZ8mU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_03,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 mlxlogscore=999 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1011 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250058
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2023 6:07 PM, Suzuki K Poulose wrote:
> On 27/04/2023 10:00, Tao Zhang wrote:
>> Read the DSB element size from the device tree. Set the register
>> bit that controls the DSB element size of the corresponding port.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-core.c |  1 +
>>   drivers/hwtracing/coresight/coresight-tpda.c | 92 
>> +++++++++++++++++++++++++---
>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>   drivers/hwtracing/coresight/coresight-tpdm.c |  2 +-
>>   include/linux/coresight.h                    |  1 +
>>   5 files changed, 90 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>> b/drivers/hwtracing/coresight/coresight-core.c
>> index 2af416b..f1eacbb 100644
>> --- a/drivers/hwtracing/coresight/coresight-core.c
>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>> @@ -1092,6 +1092,7 @@ static int coresight_validate_source(struct 
>> coresight_device *csdev,
>>         if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>> +        subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>>           dev_err(&csdev->dev, "wrong device subtype in %s\n", 
>> function);
>>           return -EINVAL;
>
> Please see the comment at the bottom.
>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> index 8d2b9d2..af9c72f 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -21,6 +21,56 @@
>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>   +/* Search and read element data size from the TPDM node in
>> + * the devicetree. Each input port of TPDA is connected to
>> + * a TPDM. Different TPDM supports different types of dataset,
>> + * and some may support more than one type of dataset.
>> + * Parameter "inport" is used to pass in the input port number
>> + * of TPDA, and it is set to 0 in the recursize call.
>> + * Parameter "parent" is used to pass in the original call.
>> + */
>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>> +               struct coresight_device *csdev, int inport, bool parent)
>> +{
>> +    static int nr_inport;
>> +    int i;
>> +    static bool tpdm_found;
>> +    struct coresight_device *in_csdev;
>> +
>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>> +        return -EINVAL;
>> +
>> +    if (parent) {
>> +        nr_inport = inport;
>> +        tpdm_found = false;
>> +    }
>> +
>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>> +        in_csdev = csdev->pdata->in_conns[i]->src_dev;
>> +        if (!in_csdev)
>> +            break;
>> +
>> +        if (parent)
>> +            if (csdev->pdata->in_conns[i]->dest_port != inport)
>> +                continue;
>> +
>> +        if (in_csdev->subtype.source_subtype
>
> We must match the in_csdev->type to be SOURCE && the subtype.
Sure, I will update it in the next patch series.
>
>> +                   == CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM) {
>> + of_property_read_u8(in_csdev->dev.parent->of_node,
>> +                    "qcom,dsb-element-size", 
>> &drvdata->dsb_esize[nr_inport]);
>> +            if (!tpdm_found)
>> +                tpdm_found = true;
>> +            else
>> +                dev_warn(drvdata->dev,
>> +                    "More than one TPDM is mapped to the TPDA input 
>> port %d.\n",
>> +                    nr_inport);
>
> When we know, we have found a source device, we don't need to recurse
> down and could simply 'continue' to the next one in the list and skip
> the call below.

Actually, one input port on TPDA only can connect to one TPDM. In the 
current design, it will

find out all the TPDMs on one input port and warn the users all the 
TPDMs it found. If we

replace 'recurse down' as 'continue' here, it may not find some TPDMs 
that might be connected

incorrectly.

>
>> +        }
>> +        tpda_set_element_size(drvdata, in_csdev, 0, false);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   /* Settings pre enabling port control register */
>>   static void tpda_enable_pre_port(struct tpda_drvdata *drvdata)
>>   {
>> @@ -32,26 +82,43 @@ static void tpda_enable_pre_port(struct 
>> tpda_drvdata *drvdata)
>>       writel_relaxed(val, drvdata->base + TPDA_CR);
>>   }
>>   -static void tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>> +static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>>   {
>>       u32 val;
>>         val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>> +    /*
>> +     * Configure aggregator port n DSB data set element size
>> +     * Set the bit to 0 if the size is 32
>> +     * Set the bit to 1 if the size is 64
>> +     */
>> +    if (drvdata->dsb_esize[port] == 32)
>> +        val &= ~TPDA_Pn_CR_DSBSIZE;
>> +    else if (drvdata->dsb_esize[port] == 64)
>> +        val |= TPDA_Pn_CR_DSBSIZE;
>> +    else
>> +        return -EINVAL;
>> +
>>       /* Enable the port */
>>       val |= TPDA_Pn_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +
>> +    return 0;
>>   }
>>   -static void __tpda_enable(struct tpda_drvdata *drvdata, int port)
>> +static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
>>   {
>> +    int ret;
>> +
>>       CS_UNLOCK(drvdata->base);
>>         if (!drvdata->csdev->enable)
>>           tpda_enable_pre_port(drvdata);
>>   -    tpda_enable_port(drvdata, port);
>> -
>> +    ret = tpda_enable_port(drvdata, port);
>>       CS_LOCK(drvdata->base);
>> +
>> +    return ret;
>>   }
>>     static int tpda_enable(struct coresight_device *csdev,
>> @@ -59,16 +126,23 @@ static int tpda_enable(struct coresight_device 
>> *csdev,
>>                  struct coresight_connection *out)
>>   {
>>       struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +    int ret;
>> +
>> +    ret = tpda_set_element_size(drvdata, csdev, in->dest_port, true);
>> +    if (ret)
>> +        return ret;
>>         spin_lock(&drvdata->spinlock);
>> -    if (atomic_read(&in->dest_refcnt) == 0)
>> +    if (atomic_read(&in->dest_refcnt) == 0) {
>>           __tpda_enable(drvdata, in->dest_port);
>
> ret = ... ?
Sure, I will update it in the next patch series.
>
>> +        if (!ret) {
>
>
>
>> + atomic_inc(&in->dest_refcnt);
>> +            dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", 
>> in->dest_port);
>> +        }
>> +    }
>
>>   - atomic_inc(&in->dest_refcnt);
>
> This seems wrong, as we may fail to hold additional refcounts for the
> additional sessions ?

In the current design, if the TPDA is enabled successfully, it will run 
"atomic_inc(&in->dest_refcnt);"

Otherwise, it will not run "atomic_inc(&in->dest_refcnt);" to avoid 
additional refcounts. Is it right?

>
>> spin_unlock(&drvdata->spinlock);
>> -
>> -    dev_dbg(drvdata->dev, "TPDA inport %d enabled.\n", in->dest_port);
>> -    return 0;
>> +    return ret;
>>   }
>>     static void __tpda_disable(struct tpda_drvdata *drvdata, int port)
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h 
>> b/drivers/hwtracing/coresight/coresight-tpda.h
>> index 0399678..7332e9c 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>> @@ -10,6 +10,8 @@
>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>   /* Aggregator port enable bit */
>>   #define TPDA_Pn_CR_ENA        BIT(0)
>> +/* Aggregator port DSB data set element size bit */
>> +#define TPDA_Pn_CR_DSBSIZE        BIT(8)
>>     #define TPDA_MAX_INPORTS    32
>>   @@ -23,6 +25,7 @@
>>    * @csdev:      component vitals needed by the framework.
>>    * @spinlock:   lock for the drvdata value.
>>    * @enable:     enable status of the component.
>> + * @dsb_esize:  DSB element size, it must be 32 or 64.
>
> minor nit:
>
> DSB element size for each inport, it must be 32 or 64
Sure, I will update it in the next patch series.
>
>>    */
>>   struct tpda_drvdata {
>>       void __iomem        *base;
>> @@ -30,6 +33,7 @@ struct tpda_drvdata {
>>       struct coresight_device    *csdev;
>>       spinlock_t        spinlock;
>>       u8            atid;
>> +    u8            dsb_esize[TPDA_MAX_INPORTS];
>>   };
>>     #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index f4854af..ba1867f 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -205,7 +205,7 @@ static int tpdm_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>       if (!desc.name)
>>           return -ENOMEM;
>>       desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>> -    desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
>> +    desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM;
>>       desc.ops = &tpdm_cs_ops;
>>       desc.pdata = adev->dev.platform_data;
>>       desc.dev = &adev->dev;
>
> Please could you split this change, i.e., introduction of
> SUBTYPE_SOURCE_TPDM and using this in TPDM driver,
>  in a separate patch before this change.

Sure, I will update it in the next patch series.


Best,

Tao

>
>> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
>> index 225a5fa..6563896 100644
>> --- a/include/linux/coresight.h
>> +++ b/include/linux/coresight.h
>> @@ -60,6 +60,7 @@ enum coresight_dev_subtype_source {
>>       CORESIGHT_DEV_SUBTYPE_SOURCE_PROC,
>>       CORESIGHT_DEV_SUBTYPE_SOURCE_BUS,
>>       CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE,
>> +    CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM,
>>       CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS,
>>   };
>
