Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C9C6A6847
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 08:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjCAHkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 02:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjCAHkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 02:40:23 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49FFB5BB3;
        Tue, 28 Feb 2023 23:40:22 -0800 (PST)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3216cuTP018656;
        Wed, 1 Mar 2023 07:40:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=JXDj4ci6nJOzgGaxjG0R1teE2PCiX7mrOBd+AIFODYQ=;
 b=aNM7R/IcnHd/XQrfWGfSDCbHYTo1ysGL8eHoXRkZgCctsEWO9cYv2QQqrytKkYE6BPzI
 +Gl88PVFKi6re3ggOGQx3Ky6Vvzoz9zpvsR2GOJB30YKwqPb1XKNCcO7P6RfMxbS2jIi
 GHYMLYeiFqMpe6DxbFRAPnjvuMWw5JuN4bkUda6/eadbsAonTluspZi20oiozzT7gUGs
 x75JuWdX36uqhVnK4q+tAsncKuin2+I+ilkaa6zobAJjKejLBN/m3iv1RMFmRUfC1R+f
 DcmcHzNxut+o6z86evZRdovWZFymp+MXhwRbz5Krmqd5W4mvKFvDhHo/2ehu1F6auh7I RQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p1cq5upbn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 01 Mar 2023 07:40:07 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3217e6Hw017226
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Mar 2023 07:40:06 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 28 Feb
 2023 23:40:01 -0800
Message-ID: <95aa6280-cb8a-026a-b296-4f0c7ff128ce@quicinc.com>
Date:   Wed, 1 Mar 2023 15:39:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 5/9] coresight-tpdm: Add nodes to set trigger timestamp
 and type
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
 <1674114105-16651-6-git-send-email-quic_taozha@quicinc.com>
 <299199d6-458b-fa54-cde1-dc6730ac1c3d@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <299199d6-458b-fa54-cde1-dc6730ac1c3d@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: IVEpNt71aIrmMorRfi5JiJyotMLkBnBU
X-Proofpoint-ORIG-GUID: IVEpNt71aIrmMorRfi5JiJyotMLkBnBU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-01_04,2023-02-28_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303010061
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

在 2/28/2023 7:29 PM, Suzuki K Poulose 写道:
> On 19/01/2023 07:41, Tao Zhang wrote:
>> The nodes are needed to set or show the trigger timestamp and
>> trigger type. This change is to add these nodes to achieve these
>> function.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 97 
>> ++++++++++++++++++++++++++++
>>   1 file changed, 97 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index c29d667d..1dbb6c4 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -20,6 +20,22 @@
>>     DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>   +static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>> +                            struct attribute *attr, int n)
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    if (drvdata) {
>> +        if (drvdata->datasets & TPDM_PIDR0_DS_DSB)
>> +            return attr->mode;
>> +        else
>> +            return 0;
>> +    }
>
>     if (drvdata && drvdata->dsb)
>         return attr->mode;
>
>     return 0;
>
> ?
Sure, I will update this in the next version of patch.
>
>
>> +
>> +    return 0;
>> +}
>> +
>>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 val;
>> @@ -241,8 +257,89 @@ static struct attribute_group tpdm_attr_grp = {
>>       .attrs = tpdm_attrs,
>>   };
>>   +static ssize_t dsb_trig_type_show(struct device *dev,
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->trig_type);
>> +}
>> +
>> +/*
>> + * value 0: set trigger type as enablement
>> + * value 1: set trigger type as disablement
>> + */
>> +static ssize_t dsb_trig_type_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || val < 0 || val > 1)
>
> val < 0 check here doesn't help on an unsigned variable.
>
> may be (val & ~1UL) ?
Sure, I will update this in the next version of the patch.
>
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
>> +                     struct device_attribute *attr,
>> +                     char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->trig_ts);
>> +}
>> +
>> +/*
>> + * value 0: set trigger timestamp as enablement
>> + * value 1: set trigger timestamp as disablement
>> + */
>> +static ssize_t dsb_trig_ts_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || val < 0 || val > 1)
>
> same here.
>
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
>>
>
> Suzuki
>
Best,

Tao

