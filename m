Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F79F6A38F1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 03:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjB0CnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 21:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjB0Cmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 21:42:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8966C1C307;
        Sun, 26 Feb 2023 18:42:30 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31R23t6O011457;
        Mon, 27 Feb 2023 02:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Kq+Lb1wDxc0gbhEvr/JhQGRxh2SaRG9wtEZhr5n7njY=;
 b=AaluKABq04Vsl9EeV+EJ0/zYb7HTym8L0NCYoCXlE0Hg1JaN9b5Pa9szqwnX4B3TStSo
 uphXsnR+jhZ0KyUnqXW6W28bcfBtrVM5R1/XbGbOiK1pNVcgHfHkd6o04JV2TFDG5mul
 q0NU35aiCrkk1+oa307Kg7jqU8aD8mv2HZnbmtbtWdgzXX6nDK7Jyq5PJ9I9RLntKVSo
 8fDpXqEAySO0mETv8p6bSfZcU8eJnn/4IMfr0ol6dUKIzqdIHpxMq0ReaNtjovC3ejsp
 XtaB0219JehHLKRYjzdsnszBMPeESUuZdUYw0iGLmAbML3hR46M2UUWnRoeyFoiNUPGA CQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nyb3qbbt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 02:41:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31R2ffJJ021355
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Feb 2023 02:41:41 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 26 Feb
 2023 18:41:36 -0800
Message-ID: <04ba2810-f9f0-631d-b4a6-0c99edb31701@quicinc.com>
Date:   Mon, 27 Feb 2023 10:41:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 2/9] coresight-tpda: Add DSB dataset support
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
 <1674114105-16651-3-git-send-email-quic_taozha@quicinc.com>
 <6072a788-74b9-6521-882c-c1637a68ccb2@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <6072a788-74b9-6521-882c-c1637a68ccb2@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Vd1KucQNxERtVm7IojT1ncFObhCaQ9l3
X-Proofpoint-GUID: Vd1KucQNxERtVm7IojT1ncFObhCaQ9l3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-26_22,2023-02-24_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 phishscore=0 spamscore=0
 suspectscore=0 adultscore=0 clxscore=1011 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2302270019
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

Currently if the dsb_esize is not set to 32 or 64, we will not set the 
DSBSIZE bit of the register here.

This design is really not good enough.

I will change this in the next version of patch to issue a warning if an 
unexpected value is obtained.

在 2/22/2023 8:46 PM, Suzuki K Poulose 写道:
> On 19/01/2023 07:41, Tao Zhang wrote:
>> Read the DSB element size from the device tree. Set the register
>> bit that controls the DSB element size of the corresponding port.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Tao Zhang <taozha@qti.qualcomm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c | 62 
>> ++++++++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>   2 files changed, 66 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> index 5989798..be13e08 100644
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
>
> What are the chances of having a value other than 32 or 64 ?
> What should we do in that case ? Should the driver at least
> give out a warning at least in the unhandled case rather than
> silently reusing the existing setting ?
>
> Suzuki
>
Best,

Tao

