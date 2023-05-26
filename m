Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33150711E87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjEZDqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZDqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:46:48 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832F312F;
        Thu, 25 May 2023 20:46:47 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34Q2ZSCs028258;
        Fri, 26 May 2023 03:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=f6J+d7eJP21vTNc+upTmQD2Haq9sSRRZZY0LHx9lV8w=;
 b=UY/6rA0lHLyP8j1QvZDD2d/YhQVZS1vW/xmDjECuwKAms/+rwWxEsD+IjwfpZYNymOFn
 wkgX53mJGYTfVq2r4HtMlKDhyOmS5cVArvPcEU2ceWu4HVlZf/OZCKn8CuiRoWafMdw0
 gEtCx9pRsxgX7PlnPTJhsuHHrsRCOpBZWF4FCT4BzGRFxNzBTi+1qcdp9Tthlq17g22W
 4s/2uhTWrprHchFo//R4N5IbWuCBotY+QO++MZI+nN8FPQ4BEwWd72mkT79bzC2tE1vB
 qi5RvUFEu4qlhVFlwC0W5cpXw2dW4HFTr5KgkSgErDnSpaxll/gwJmGBG6KI/JgtGQJZ Qw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qt47et3xb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 03:46:28 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34Q3kRXd017702
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 03:46:27 GMT
Received: from [10.253.77.32] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 20:46:23 -0700
Message-ID: <1e75872c-f80f-0d29-3be0-25dc19452cc5@quicinc.com>
Date:   Fri, 26 May 2023 11:46:20 +0800
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
 <92b73ba2-00c5-9f18-ed27-a302f4e79bb2@quicinc.com>
 <320ee3b4-63ed-ec50-03c6-906803e34571@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <320ee3b4-63ed-ec50-03c6-906803e34571@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 09K_vv3wA72R7_g98e7i0qGvmZKL53rQ
X-Proofpoint-ORIG-GUID: 09K_vv3wA72R7_g98e7i0qGvmZKL53rQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_01,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 suspectscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=976 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305260032
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/25/2023 5:09 PM, Suzuki K Poulose wrote:
> On 25/05/2023 09:12, Tao Zhang wrote:
>>
>> On 5/23/2023 9:42 PM, Suzuki K Poulose wrote:
>>> On 27/04/2023 10:00, Tao Zhang wrote:
>>>> DSB is used for monitoring “events”. Events are something that
>>>> occurs at some point in time. It could be a state decode, the
>>>> act of writing/reading a particular address, a FIFO being empty,
>>>> etc. This decoding of the event desired is done outside TPDM.
>>>> DSB subunit need to be configured in enablement and disablement.
>>>> A struct that specifics associated to dsb dataset is needed. It
>>>> saves the configuration and parameters of the dsb datasets. This
>>>> change is to add this struct and initialize the configuration of
>>>> DSB subunit.
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>
> ...
>
>>>> + * dataset types. It covers Basic Counts(BC), Tenure Counts(TC),
>>>> + * Continuous Multi-Bit(CMB), Multi-lane CMB(MCMB) and Discrete 
>>>> Single
>>>> + * Bit(DSB). This function will initialize the configuration 
>>>> according
>>>> + * to the dataset type supported by the TPDM.
>>>> + */
>>>>   static void __tpdm_enable(struct tpdm_drvdata *drvdata)
>>>>   {
>>>>       CS_UNLOCK(drvdata->base);
>>>> @@ -110,15 +144,24 @@ static const struct coresight_ops tpdm_cs_ops 
>>>> = {
>>>>       .source_ops    = &tpdm_source_ops,
>>>>   };
>>>>   -static void tpdm_init_default_data(struct tpdm_drvdata *drvdata)
>>>> +static int tpdm_datasets_setup(struct tpdm_drvdata *drvdata)
>>>>   {
>>>>       u32 pidr;
>>>>   -    CS_UNLOCK(drvdata->base);
>>>>       /*  Get the datasets present on the TPDM. */
>>>>       pidr = readl_relaxed(drvdata->base + CORESIGHT_PERIPHIDR0);
>>>>       drvdata->datasets |= pidr & GENMASK(TPDM_DATASETS - 1, 0);
>>>> -    CS_LOCK(drvdata->base);
>>>
>>> Why are we removing the CS_{UN,}LOCK here ?
>>
>> CS_UNLOCK is used before writing data to Coresight registers. Here 
>> this function
>>
>> doesn't need to write data to any registers, so I remove the 
>> CS_{UN,}LOCK here.
>
> Please make this a separate patch to avoid confusing and keep it at the
> beginning of the series.
Sure, I will update this in the next patch series.
>
> Suzuki
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
