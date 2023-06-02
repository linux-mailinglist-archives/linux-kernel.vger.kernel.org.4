Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC0971F86D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 04:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbjFBCa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 22:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbjFBCa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 22:30:26 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DCF180;
        Thu,  1 Jun 2023 19:30:24 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35229dS6021413;
        Fri, 2 Jun 2023 02:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=z4PGhJicd64CLNRAi7yXlmeie/hBJ8KiRE5vR6dLI3Y=;
 b=T2gk7s76YivrQKBkE42kHbX1hXBSu4BZf4lz4nzRN1H9+76Ky8RmfH4DfSr0YKaUQ5nm
 bw5cbPEmCXTNFZBrlIbQ76L30rXIwBc11teMqdFVSjsei5W+kF7BG7hlFDesifPMY5Jc
 eFqNUf90GimokCeOAiZDgovy6FAqQV+idj7Z+eCH8OSNhNpNixzF8b2DmvNilMvzBsKD
 MoulHlXy7WSXojT8itrZhWo8WYzhqEWX5kJPcRJ1GJBulhVbQ/nyZl59kKSte0ue8uva
 hVpDpQ1cp+ys8q8pYH3wRNsYJd4nPa9OoG4f/wMEBfFB1u3tD8G7qLZ8+EIuDZAJOwx7 bA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qxqyda8hy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 02:29:59 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3522Tw2T019651
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 02:29:58 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 1 Jun 2023
 19:29:52 -0700
Message-ID: <e7909578-6538-b3bd-7bca-3e19015cfdef@quicinc.com>
Date:   Fri, 2 Jun 2023 10:29:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 05/11] coresight-tpdm: Add nodes to set trigger
 timestamp and type
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
 <1682586037-25973-6-git-send-email-quic_taozha@quicinc.com>
 <ccdc58ff-f86b-6ca8-cdf6-299cc454873c@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <ccdc58ff-f86b-6ca8-cdf6-299cc454873c@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4ewbk22m80blD3fl4BtDufLGKaIwIPuf
X-Proofpoint-GUID: 4ewbk22m80blD3fl4BtDufLGKaIwIPuf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-01_08,2023-05-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 bulkscore=0 spamscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2306020017
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/1/2023 5:05 PM, Suzuki K Poulose wrote:
> On 27/04/2023 10:00, Tao Zhang wrote:
>> The nodes are needed to set or show the trigger timestamp and
>> trigger type. This change is to add these nodes to achieve these
>> function.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 24 ++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 95 
>> ++++++++++++++++++++++
>>   2 files changed, 119 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 686bdde..77e67f2 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -21,3 +21,27 @@ Description:
>>             Accepts only one value -  1.
>>           1 : Reset the dataset of the tpdm
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_type
>> +Date:        March 2023
>> +KernelVersion    6.3
>
> This would need updating. We are not sure if this can make it to 6.5, 
> with dependency on James' series. Fix this with 6.5 here and we can take
> a shot.
Sure, I will update this in the next patch series.
>
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the trigger type of DSB tpdm. Read the trigger
>> +        type of DSB tpdm.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Set the DSB trigger type to false
>> +        1 : Set the DSB trigger type to true
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_ts
>> +Date:        March 2023
>> +KernelVersion    6.3
>
> Same here
Sure, I will update this in the next patch series.
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the trigger timestamp of DSB tpdm. Read the
>> +        trigger timestamp of DSB tpdm.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Set the DSB trigger type to false
>> +        1 : Set the DSB trigger type to true
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 2e64cfd..14f4352 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,6 +20,19 @@
>>     DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>   +static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>> +                                   struct attribute *attr, int n)
>
> minor nit: alignment ?
Sure, I will update this in the next patch series.
>
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    if (drvdata)
>> +        if (drvdata && (drvdata->datasets & TPDM_PIDR0_DS_DSB))
>> +            return attr->mode;
>
> Duplicate check for drvdata ?
>
>     if (drvdata && (drvdata->datasets & TPDM_PIDR0_DS_DSB))
>         return attr->mode;

Don't need double check here, I will change this in the next patch series.


Best,

Tao

>> +
>> +    return 0;
>> +}
>> +
>>   static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>>   {
>>       if (drvdata->datasets & TPDM_PIDR0_DS_DSB) {
>> @@ -239,8 +252,90 @@ static struct attribute_group tpdm_attr_grp = {
>>       .attrs = tpdm_attrs,
>>   };
>>   +static ssize_t dsb_trig_type_show(struct device *dev,
>> +                     struct device_attribute *attr, char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->trig_type);
>> +}
>> +
>> +/*
>> + * Trigger type (boolean):
>> + * false - Disable trigger type.
>> + * true  - Enable trigger type.
>> + */
>> +static ssize_t dsb_trig_type_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    if (val)
>> +        drvdata->dsb->trig_type = true;
>> +    else
>> +        drvdata->dsb->trig_type = false;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_trig_type);
>> +
>> +static ssize_t dsb_trig_ts_show(struct device *dev,
>> +                     struct device_attribute *attr, char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->trig_ts);
>> +}
>> +
>> +/*
>> + * Trigger timestamp (boolean):
>> + * false - Disable trigger timestamp.
>> + * true  - Enable trigger timestamp.
>> + */
>> +static ssize_t dsb_trig_ts_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    if (val)
>> +        drvdata->dsb->trig_ts = true;
>> +    else
>> +        drvdata->dsb->trig_ts = false;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_trig_ts);
>> +
>> +static struct attribute *tpdm_dsb_attrs[] = {
>> +    &dev_attr_dsb_trig_ts.attr,
>> +    &dev_attr_dsb_trig_type.attr,
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group tpdm_dsb_attr_grp = {
>> +    .attrs = tpdm_dsb_attrs,
>> +    .is_visible = tpdm_dsb_is_visible,
>> +};
>> +
>>   static const struct attribute_group *tpdm_attr_grps[] = {
>>       &tpdm_attr_grp,
>> +    &tpdm_dsb_attr_grp,
>>       NULL,
>>   };
>
> Rest looks fine to me
>
> Suzuki
>
