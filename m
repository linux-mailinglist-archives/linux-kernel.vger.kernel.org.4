Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475DA60F0D5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbiJ0G5w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:57:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbiJ0G5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:57:20 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393D6EC507;
        Wed, 26 Oct 2022 23:55:51 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29R5SieN015481;
        Thu, 27 Oct 2022 06:55:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=PpZQMfpjzMlrgW/1xNHZ5Xi71euv9nJ5ni2b7f2XSSU=;
 b=jDU+xRvRq1u5oaGhAdWKSjBW/w75427mi2I5f/6CmBPKCuWAJXrWu4VQzkOzRcjuIr3J
 AUL1sisv7qHD+09qowFzFsudWHddVbG/ijXQrIAoBG89Aw6Vdw+x9gdgM7/v1F89KFJW
 EwG2xoU5jCBt89fuVZkvC9HgbO5iSPQciWYIYHc6rgbsMruI11NP8MaKk0usLKYFuwQ3
 HnJ1l82hUgBiu1qpcYOYwA2aJXaTs9L82uRIJQdIsW6iu5WmGH+ukvR+gn3hQ7rAzBMo
 Am/qhJlfnwHjf+XAw79erzCUdGEtpkHS/hDbBTxoP4/7zAs+MDg7BnzBmCxy8g3a4HGx lA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3kfah51qy6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 06:55:41 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29R6tePw005838
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Oct 2022 06:55:40 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 26 Oct
 2022 23:55:35 -0700
Message-ID: <2929167a-9feb-5a70-4537-f776205898a8@quicinc.com>
Date:   Thu, 27 Oct 2022 14:55:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH 6/9] coresight-tpdm: Add node to set dsb programming mode
Content-Language: en-US
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
 <1662626705-13097-7-git-send-email-quic_taozha@quicinc.com>
 <7302924e-21f9-8748-3d9e-854f4898d078@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <7302924e-21f9-8748-3d9e-854f4898d078@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: GbHX4zNibO3Je_eVseWWuYDdTRi3NXMW
X-Proofpoint-ORIG-GUID: GbHX4zNibO3Je_eVseWWuYDdTRi3NXMW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_03,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270038
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

在 10/24/2022 10:49 PM, Suzuki K Poulose 写道:
> On 08/09/2022 09:45, Tao Zhang wrote:
>> Add node to set and show programming mode for TPDM DSB subunit.
>> Once the DSB programming mode is set, it will be written to the
>> register DSB_CR. Bit[10:9] of the DSB_CR register is used to set
>> the DSB test mode.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 49 
>> +++++++++++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tpdm.h | 10 ++++++
>>   2 files changed, 58 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index fae9963..7265793 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -22,7 +22,7 @@ DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>     static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>> -    u32 val;
>> +    u32 val, mode;
>>         val = readl_relaxed(drvdata->base + TPDM_DSB_TIER);
>>       /* Set trigger timestamp */
>> @@ -42,6 +42,19 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>         /* Set the enable bit of DSB control register to 1 */
>>       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +    /* Set the cycle accurate mode */
>> +    mode = TPDM_DSB_MODE_CYCACC(drvdata->dsb->mode);
>> +    val = val & ~(0x7 << 9);
>> +    val = val | (mode << 9);
>
> Please do not hard code numbers like that above. Please could
> you define proper masks for the fields in DSB_CR and use
> FIELD_GET, FIELD_PREP for setting the values.
>
Sure, I will update this in the next patch series.
>> +    /* Set the byte lane for high-performance mode */
>> +    mode = TPDM_DSB_MODE_HPBYTESEL(drvdata->dsb->mode);
>> +    val = val & ~(0x1F << 2);
>> +    val = val | (mode << 2);
>> +    /* Set the performance mode */
>
> Same as above.
>
Sure, I will update this in the next patch series.
>> +    if (drvdata->dsb->mode & TPDM_DSB_MODE_PERF)
>> +        val |= TPDM_DSB_MODE;
>> +    else
>> +        val &= ~TPDM_DSB_MODE;
>>       val |= TPDM_DSB_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>   }
>> @@ -232,6 +245,39 @@ static struct attribute_group tpdm_attr_grp = {
>>       .attrs = tpdm_attrs,
>>   };
>>   +static ssize_t dsb_mode_show(struct device *dev,
>> +                  struct device_attribute *attr,
>> +                  char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
>> +        return -EPERM;
>
> As mentioned earlier, use is_visble() instead of hard coding this
> in every function.
>
Sure, I will update this in the next patch series.
>> +
>> +    return scnprintf(buf, PAGE_SIZE, "%lx\n",
>> +             (unsigned long)drvdata->dsb->mode);
>> +}
>> +
>> +static ssize_t dsb_mode_store(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   const char *buf,
>> +                   size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 16, &val)) || val < 0 || val > 3)
>
> Why not leave kstrtoul to detect the base instead of always forcing
> 16 ? Some other code had forced to base of 10. Please be flexible
> and avoid the inconsistencies.
>
Sure, I will update this in the next patch series.
>> +        return -EINVAL;
>> +    if (!(drvdata->datasets & TPDM_PIDR0_DS_DSB))
>> +        return -EPERM;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->dsb->mode = val & TPDM_MODE_ALL;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_mode);
>> +
>>   static ssize_t dsb_trig_type_show(struct device *dev,
>>                        struct device_attribute *attr,
>>                        char *buf)
>> @@ -312,6 +358,7 @@ static ssize_t dsb_trig_ts_store(struct device *dev,
>>   }
>>   static DEVICE_ATTR_RW(dsb_trig_ts);
>>   static struct attribute *tpdm_dsb_attrs[] = {
>> +    &dev_attr_dsb_mode.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>>       &dev_attr_dsb_trig_type.attr,
>>       NULL,
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index dd4a013..4d57488 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -19,6 +19,14 @@
>>   #define TPDM_DSB_XTRIG_TSENAB        BIT(1)
>>   /* Enable bit for DSB subunit trigger type */
>>   #define TPDM_DSB_TRIG_TYPE        BIT(12)
>> +/* Enable bit for DSB subunit perfmance mode */
>> +#define TPDM_DSB_MODE        BIT(1)
>> +
>> +/* DSB programming modes */
>> +#define TPDM_DSB_MODE_CYCACC(val)    BMVAL(val, 0, 2)
>> +#define TPDM_DSB_MODE_PERF        BIT(3)
>> +#define TPDM_DSB_MODE_HPBYTESEL(val)    BMVAL(val, 4, 8)
>
> Please could we use GENMASK to define the masks and
> use FIELD_GET/FILED_PREP macros for the dealing with
> the fields ?
>
> Similarly for the DSB_CR register please.
Sure, I will update this in the next patch series.
>
> Suzuki
Best Regards
Tao
