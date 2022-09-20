Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D9A5BE750
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 15:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiITNlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 09:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiITNlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:41:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F22491C5;
        Tue, 20 Sep 2022 06:41:01 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28K7xe1h023557;
        Tue, 20 Sep 2022 13:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=rJaJEZUW1earkXTvStZSfCgkUX8TXYTBRPSJw6kmJGs=;
 b=C/5KfRhhHzEqvGEFQ5t0ZVELZK/4c3/yUBdmDfFuW2x1piK+Q313HTLOGGi9afBCAl6l
 zzv1W1bP3GIYl9toXt1IGi8h29q1xZx2839NGACrYh1zulMXnK41LLdOEsTidwEWVvfG
 WSA2OdoHa7qarnxP3N/utjXGSzTtdySs4ItM4UvSylTejX0sLhOZphYj6LIZ+Xvu5Z1B
 duNY1I0YyKHnR25vPINqLM33a+Jim9coN9a52pVBUqgWnhjs7SN2sRADCckutuvJmf4J
 DUt4aByEcuXNpx/iD5cHVNt4Pf9V131Q+uPhADHzrA2dmo9tmUODRstwivpSKq3PonSV Uw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jpxaek268-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:40:35 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28KDeY5U007552
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Sep 2022 13:40:34 GMT
Received: from [10.253.75.156] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Tue, 20 Sep
 2022 06:40:30 -0700
Message-ID: <0ab1bfcc-6662-d5f7-61a5-125b6639e467@quicinc.com>
Date:   Tue, 20 Sep 2022 21:40:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 2/9] coresight-tpda: Add DSB dataset support
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>
References: <1662626705-13097-1-git-send-email-quic_taozha@quicinc.com>
 <1662626705-13097-3-git-send-email-quic_taozha@quicinc.com>
 <c39b704a-ceae-9db8-7f4f-81d9cfee8495@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <c39b704a-ceae-9db8-7f4f-81d9cfee8495@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V3PYIwgc8M-QHhxtjO7DfqMz4HHQi1Yy
X-Proofpoint-ORIG-GUID: V3PYIwgc8M-QHhxtjO7DfqMz4HHQi1Yy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-20_04,2022-09-20_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0 impostorscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209200080
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,


Thanks a lot for your code review.

I will update the patch with your suggestions in the next release.

On 9/15/2022 6:14 PM, Suzuki K Poulose wrote:
> Hi Tao
>
> On 08/09/2022 09:44, Tao Zhang wrote:
>> Read the DSB element size from the device tree. Set the register
>> bit that controls the DSB element size of the corresponding port.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c | 62 
>> ++++++++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> index c8bbc75..76636a1 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -37,6 +37,15 @@ static void tpda_enable_port(struct tpda_drvdata 
>> *drvdata, int port)
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
>>       /* Enable the port */
>>       val |= TPDA_Pn_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> @@ -105,6 +114,55 @@ static const struct coresight_ops tpda_cs_ops = {
>>       .link_ops    = &tpda_link_ops,
>>   };
>>   +static int tpda_parse_dsb(struct tpda_drvdata *drvdata)
>> +{
>> +    int len, port, i;
>> +    const __be32 *prop;
>> +    struct device_node *node = drvdata->dev->of_node;
>> +
>> +    /* Read the size of DSB element */
>> +    prop = of_get_property(node, "qcom,dsb-elem-size", &len);
>> +    if (prop) {
>> +        len /= sizeof(__be32);
>> +        /*
>> +         * The read set of data is port and size, so the number of data
>> +         * is a multiple of two. And the number of data will not exceed
>> +         * two times that of the TPDA inpurts number.
>> +         */
>> +        if (len < 2 || len >= (2 * TPDA_MAX_INPORTS) || len % 2 != 0) {
>> +            dev_err(drvdata->dev,
>> +                "Dataset DSB width entries are wrong\n");
>> +            return -EINVAL;
>> +        }
>> +
>> +        for (i = 0; i < len; i++) {
>
> Please could we be explicit here that we are dealing with 2 entries
> in an iteration. i.e,
>
>         for (i = 0; i < len; i += 2) {
>> +            port = be32_to_cpu(prop[i++]);
>
>             port = be32_to_cpu(prop[i]);
>
>> +            if (port >= TPDA_MAX_INPORTS) {
>> +                dev_err(drvdata->dev,
>> +                    "Wrong port specified for DSB\n");
>> +                return -EINVAL;
>> +            }
>> +            /* Set DSB element size for corresponding port to 
>> dsb_esize*/
>> +            drvdata->dsb_esize[port] = be32_to_cpu(prop[i]);
>
>         drvdata->dsb_esize[port] = be32_to_cpu(prop[i + 1]);
>
Sure, I will update this part of the code in the next release.
>> +        }
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int tpda_parse_of_data(struct tpda_drvdata *drvdata)
>> +{
>> +    int ret;
>> +
>> +    ret = tpda_parse_dsb(drvdata);
>> +    if (ret) {
>> +        dev_err(drvdata->dev, "Fail to get DSB data set element 
>> size\n");
>> +        return -EINVAL;
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>>   static int tpda_init_default_data(struct tpda_drvdata *drvdata)
>>   {
>>       int atid;
>> @@ -148,6 +206,10 @@ static int tpda_probe(struct amba_device *adev, 
>> const struct amba_id *id)
>>         spin_lock_init(&drvdata->spinlock);
>>   +    ret = tpda_parse_of_data(drvdata);
>> +    if (ret)
>> +        return ret;
>> +
>>       ret = tpda_init_default_data(drvdata);
>>       if (ret)
>>           return ret;
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h 
>> b/drivers/hwtracing/coresight/coresight-tpda.h
>> index 4beb332..ecc7869 100644
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
>> + * @dsb_esize   DSB element size
>
> super minor nit: Missing ":", consistent with the other fields.
>
I will update in the next release.
>>    */
>>   struct tpda_drvdata {
>>       void __iomem        *base;
>> @@ -30,6 +33,7 @@ struct tpda_drvdata {
>>       struct coresight_device    *csdev;
>>       spinlock_t        spinlock;
>>       u8            atid;
>> +    u32            dsb_esize[TPDA_MAX_INPORTS];
>>   };
>>     #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
>
> Suzuki

Regards,

Tao

