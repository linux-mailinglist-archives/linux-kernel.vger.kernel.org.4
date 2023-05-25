Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A425C710626
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbjEYHV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234189AbjEYHV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:21:26 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D276F83;
        Thu, 25 May 2023 00:21:24 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34P6C3Xn020344;
        Thu, 25 May 2023 07:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=9lxy6iBtU5/k0RHXRlhcdMNyZIJ6KVrxrLG1krZWlAU=;
 b=JSHoUtRe0r2Lf90r3WWQVG42gdI+37ikmLBmdmoIXDNcHre8uJN50VLlDVl0INH7+1XT
 vqiKfB8eq9ybuh5UBEC1+KpofIdXc16u2CrTOQhqfceOcCtWCx9wHhTSZPVeQ7QSsIja
 UOuxOQbD4kvPdwsqf75n5dUxqPCPognwHQO7xCUHgL7+1zG5Jq4zLVDHxWfoLrW9biV5
 mv3XQ4LynNvynK0H8DlvddqzmBxqKJmlt9faxBLn0pYQRzZa3I0UFIvhAJn5rP7jo8dw
 LKJwFwX7GKVZVv1rVjPN5AtPG88bdZHXxrnurYAybZx+yybFvphseOtNFc891EsedQEq FQ== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsp509jjw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 07:21:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34P7L4i0030027
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 07:21:04 GMT
Received: from [10.253.35.57] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Thu, 25 May
 2023 00:21:00 -0700
Message-ID: <b5dd9d63-fb11-e343-a0a6-4aa8217fd7b3@quicinc.com>
Date:   Thu, 25 May 2023 15:20:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 02/11] coresight-tpda: Add DSB dataset support
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
 <1682586037-25973-3-git-send-email-quic_taozha@quicinc.com>
 <444bc278-a3e3-7d99-6020-7c3337371f66@arm.com>
 <e2e4b998-e6d8-59e9-fce7-0072954001dd@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <e2e4b998-e6d8-59e9-fce7-0072954001dd@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fdUvlDcfrRmfVoc5YJTxlOiZhTROTthe
X-Proofpoint-ORIG-GUID: fdUvlDcfrRmfVoc5YJTxlOiZhTROTthe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_03,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250059
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/23/2023 10:48 PM, Suzuki K Poulose wrote:
> On 23/05/2023 11:07, Suzuki K Poulose wrote:
>> On 27/04/2023 10:00, Tao Zhang wrote:
>>> Read the DSB element size from the device tree. Set the register
>>> bit that controls the DSB element size of the corresponding port.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-core.c |  1 +
>>>   drivers/hwtracing/coresight/coresight-tpda.c | 92 
>>> +++++++++++++++++++++++++---
>>>   drivers/hwtracing/coresight/coresight-tpda.h |  4 ++
>>>   drivers/hwtracing/coresight/coresight-tpdm.c |  2 +-
>>>   include/linux/coresight.h                    |  1 +
>>>   5 files changed, 90 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-core.c 
>>> b/drivers/hwtracing/coresight/coresight-core.c
>>> index 2af416b..f1eacbb 100644
>>> --- a/drivers/hwtracing/coresight/coresight-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-core.c
>>> @@ -1092,6 +1092,7 @@ static int coresight_validate_source(struct 
>>> coresight_device *csdev,
>>>       if (subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_PROC &&
>>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_SOFTWARE &&
>>> +        subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM &&
>>>           subtype != CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS) {
>>>           dev_err(&csdev->dev, "wrong device subtype in %s\n", 
>>> function);
>>>           return -EINVAL;
>>
>> Please see the comment at the bottom.
>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>> index 8d2b9d2..af9c72f 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>> @@ -21,6 +21,56 @@
>>>   DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>> +/* Search and read element data size from the TPDM node in
>>> + * the devicetree. Each input port of TPDA is connected to
>>> + * a TPDM. Different TPDM supports different types of dataset,
>>> + * and some may support more than one type of dataset.
>>> + * Parameter "inport" is used to pass in the input port number
>>> + * of TPDA, and it is set to 0 in the recursize call.
>>> + * Parameter "parent" is used to pass in the original call.
>>> + */
>>> +static int tpda_set_element_size(struct tpda_drvdata *drvdata,
>>> +               struct coresight_device *csdev, int inport, bool 
>>> parent)
>
> The name parent is a bit confusing. It could imply parent device ? That
> is kind of inverse ? because, parent = true, indicates the parent device
> of tpda, which is not true. Could we simply say
>
> bool match_inport => When true, the dest_port of the connection from the
> csdev must match the inport ? And ...
>
Sure, I will update this in the next patch series.
>>> +{
>>> +    static int nr_inport;
>>> +    int i;
>>> +    static bool tpdm_found;
>>> +    struct coresight_device *in_csdev;
>>> +
>>> +    if (inport > (TPDA_MAX_INPORTS - 1))
>>> +        return -EINVAL;
>>> +
>>> +    if (parent) {
>>> +        nr_inport = inport;
>>> +        tpdm_found = false;
>>> +    }
>>> +
>>> +    for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>>> +        in_csdev = csdev->pdata->in_conns[i]->src_dev;
>>> +        if (!in_csdev)
>>> +            break;
>>> +
>>> +        if (parent)
>>> +            if (csdev->pdata->in_conns[i]->dest_port != inport)
>>> +                continue;
>
> The above can become :
>
>         if (match_inport &&
>         csdev->pdata->in_conns[i]->dest_port != inport)
>         continue;

Sure, I will update this in the next patch series.


Best,

Tao

>
> Suzuki
>
