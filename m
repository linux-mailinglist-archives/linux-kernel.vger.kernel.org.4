Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA586E22A4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230135AbjDNLuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbjDNLuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:50:21 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603E230FA;
        Fri, 14 Apr 2023 04:50:19 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E8xq5L023005;
        Fri, 14 Apr 2023 11:49:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=lGGtG0ZL06RAk+9DnB1J6y3+oHd/FzVf4TXsIJzgcM0=;
 b=OBODqnqp7BrvjN73Cmv5z388VcXu9nuSSVSBhOgMVH9zlyBuV/souARnPUnNkceS2zmu
 W3hlhE1+hNAQ//dGZdtz4Y8not+uMPbk/xzcTHN8AV1hIlAKvWAd4ddamXBlEADBSJCQ
 vpHF1fVuDhYkm7CGOFjYOdHNT19AQKyX4o765dvaWaDiyOVzFuAxik3pu2/y+ZfFsita
 2IfY/8bfkz6u0/3iEItYeen4OuzK4K2PnbZfw1767JMD2Y687HxcDJBhmeXqubEcxRqb
 tl+o3gHbeLcIDt0HOKchmztuaWAOU0y5OiCgT/4M5Usoz1tkWzcfRxwoZ02nLqXzX2zo vg== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxqf99r9n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 11:49:56 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EBntgf021932
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 11:49:55 GMT
Received: from [10.216.56.7] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 04:49:40 -0700
Message-ID: <93f5dc05-a91b-0fe6-c7e2-d3457cba8a1f@quicinc.com>
Date:   Fri, 14 Apr 2023 17:19:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 6/6] remoterproc: qcom: refactor to leverage exported
 minidump symbol
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>, <will@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1679491817-2498-1-git-send-email-quic_mojha@quicinc.com>
 <1679491817-2498-7-git-send-email-quic_mojha@quicinc.com>
 <6c01d2fc-3155-0dcd-f473-9cbd75dd69ec@linaro.org>
 <af23d650-3dec-9a51-566c-1eec2fa4b84b@quicinc.com>
 <5a872001-dfcb-5c00-3b13-3c29e6be213b@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <5a872001-dfcb-5c00-3b13-3c29e6be213b@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3ntYelLKBQ7bxw53Kv7pIpZOL47Q7afW
X-Proofpoint-ORIG-GUID: 3ntYelLKBQ7bxw53Kv7pIpZOL47Q7afW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_06,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140106
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 5:10 PM, Srinivas Kandagatla wrote:
> 
> 
> On 14/04/2023 12:14, Mukesh Ojha wrote:
>>
>>
>> On 4/14/2023 4:14 PM, Srinivas Kandagatla wrote:
>>>
>>>
>>> On 22/03/2023 13:30, Mukesh Ojha wrote:
>>>> qcom_minidump driver provides qcom_minidump_subsystem_desc()
>>>> exported API which other driver can use it query subsystem
>>>> descriptor. Refactor qcom_minidump() to use this symbol.
>>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> ---
>>>>   drivers/remoteproc/qcom_common.c | 13 ++-----------
>>>>   1 file changed, 2 insertions(+), 11 deletions(-)
>>>>
>>>> diff --git a/drivers/remoteproc/qcom_common.c 
>>>> b/drivers/remoteproc/qcom_common.c
>>>> index 88fc984..240e9f7 100644
>>>> --- a/drivers/remoteproc/qcom_common.c
>>>> +++ b/drivers/remoteproc/qcom_common.c
>>>> @@ -94,19 +94,10 @@ void qcom_minidump(struct rproc *rproc, unsigned 
>>>> int minidump_id,
>>>>   {
>>>>       int ret;
>>>>       struct minidump_subsystem *subsystem;
>>>> -    struct minidump_global_toc *toc;
>>>> -    /* Get Global minidump ToC*/
>>>> -    toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, 
>>>> NULL);
>>>> -
>>>> -    /* check if global table pointer exists and init is set */
>>>> -    if (IS_ERR(toc) || !toc->status) {
>>>> -        dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
>>>> +    subsystem = qcom_minidump_subsystem_desc(minidump_id);
>>>> +    if (IS_ERR(subsystem))
>>>>           return;
>>>
>>> Sorry If I am missing something but I got lost looking at the below 
>>> code snippet in drivers/remoteproc/qcom_common.c
>>>
>>>
>>> -------------------->cut<-----------------------------
>>>      subsystem = qcom_minidump_subsystem_desc(minidump_id);
>>>      if (IS_ERR(subsystem))
>>>          return;
>>>
>>>      /**
>>>       * Collect minidump if SS ToC is valid and segment table
>>>       * is initialized in memory and encryption status is set.
>>>       */
>>>      if (subsystem->regions_baseptr == 0 ||
>>>          le32_to_cpu(subsystem->status) != 1 ||
>>>          le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
>>>          le32_to_cpu(subsystem->encryption_status) != 
>>> MINIDUMP_SS_ENCR_DONE) {
>>>          dev_err(&rproc->dev, "Minidump not ready, skipping\n");
>>>          return;
>>>      }
>>> -------------------->cut<-----------------------------
>>>
>>> where does "subsystem->regions_baseptr" for this ADSP minidump 
>>> descriptor get set?
>>
>> Other co-processor such as adsp/cdsp/Mpss has their own way of 
>> registering their region/segment (mostly they are static known
>> regions) with minidump global infra and which could be happening
>> from firmware side .
> If its happening from firmware side, then that ram phys address range 
> should be reserved from kernel usage I guess.
> 
> Do you have more details on where exactly is this reserved from within 
> linux kernel?

These regions are inside remoteproc memory carve-out.
like.

adsp_mem: memory@85e00000 {
	reg = <0x0 0x85e00000 0x0 0x2100000>;
	no-map;
};



remoteproc_adsp: remoteproc@30000000 {
	compatible = "qcom,sm8450-adsp-pas";
	reg = <0 0x30000000 0 0x100>;
            ...
            ...
	memory-region = <&adsp_mem>; <==

-Mukesh
	
> 
> 
> --srini
> 
>>
>>
>> -Mukesh
>>
>>>
>>>
>>> --srini
>>>
>>>> -    }
>>>> -
>>>> -    /* Get subsystem table of contents using the minidump id */
>>>> -    subsystem = &toc->subsystems[minidump_id];
>>>>       /**
>>>>        * Collect minidump if SS ToC is valid and segment table
