Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A6F6E21DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjDNLPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjDNLO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:14:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156147D94;
        Fri, 14 Apr 2023 04:14:55 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EBEZXp014608;
        Fri, 14 Apr 2023 11:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fPy1TqO2tYq9zpkFuktROtjj+BsSkhdXM14XPK6zJaY=;
 b=l1p7TT2XTdYCqQYBMHsALsxwD5JiRBO0ez+BFEgmUevr+HQjP4yCt60xODwIMuVtFnc+
 fxRg1/TaURu/+YOCG1u9VUnC58WtCBdnrabXbhKzTURHqKWTQ/8iByxxVApTptgXAoVv
 iu4AyB32XoGJZGTaRK+XfXQ6dEMmoXkaaDaMUHN3TJxuvgmRWLPkqKJDr9jMBeyQYhB9
 +zzBlnwaiBQ9kW6E05/2j29myGJSBt+d9fn4QoOrcAwYDo9CwbNcgCC5B2vxn0Qcxz+o
 +6N1bHBYde+0Nyr19lzyXJyX2H+S5+zN/kqED7LhccNqEQM9fB68Fr/DWa7EOP6sjBmR 2g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pxe66jxa4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 11:14:34 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33EBEGdm029666
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 11:14:16 GMT
Received: from [10.216.56.7] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 14 Apr
 2023 04:14:07 -0700
Message-ID: <af23d650-3dec-9a51-566c-1eec2fa4b84b@quicinc.com>
Date:   Fri, 14 Apr 2023 16:44:02 +0530
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
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <6c01d2fc-3155-0dcd-f473-9cbd75dd69ec@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SwA_x-IY_04ZqvW12qKAk70gD3Qz7i5f
X-Proofpoint-ORIG-GUID: SwA_x-IY_04ZqvW12qKAk70gD3Qz7i5f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_05,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 clxscore=1015
 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304140102
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/2023 4:14 PM, Srinivas Kandagatla wrote:
> 
> 
> On 22/03/2023 13:30, Mukesh Ojha wrote:
>> qcom_minidump driver provides qcom_minidump_subsystem_desc()
>> exported API which other driver can use it query subsystem
>> descriptor. Refactor qcom_minidump() to use this symbol.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/remoteproc/qcom_common.c | 13 ++-----------
>>   1 file changed, 2 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/remoteproc/qcom_common.c 
>> b/drivers/remoteproc/qcom_common.c
>> index 88fc984..240e9f7 100644
>> --- a/drivers/remoteproc/qcom_common.c
>> +++ b/drivers/remoteproc/qcom_common.c
>> @@ -94,19 +94,10 @@ void qcom_minidump(struct rproc *rproc, unsigned 
>> int minidump_id,
>>   {
>>       int ret;
>>       struct minidump_subsystem *subsystem;
>> -    struct minidump_global_toc *toc;
>> -    /* Get Global minidump ToC*/
>> -    toc = qcom_smem_get(QCOM_SMEM_HOST_ANY, SBL_MINIDUMP_SMEM_ID, NULL);
>> -
>> -    /* check if global table pointer exists and init is set */
>> -    if (IS_ERR(toc) || !toc->status) {
>> -        dev_err(&rproc->dev, "Minidump TOC not found in SMEM\n");
>> +    subsystem = qcom_minidump_subsystem_desc(minidump_id);
>> +    if (IS_ERR(subsystem))
>>           return;
> 
> Sorry If I am missing something but I got lost looking at the below code 
> snippet in drivers/remoteproc/qcom_common.c
> 
> 
> -------------------->cut<-----------------------------
>      subsystem = qcom_minidump_subsystem_desc(minidump_id);
>      if (IS_ERR(subsystem))
>          return;
> 
>      /**
>       * Collect minidump if SS ToC is valid and segment table
>       * is initialized in memory and encryption status is set.
>       */
>      if (subsystem->regions_baseptr == 0 ||
>          le32_to_cpu(subsystem->status) != 1 ||
>          le32_to_cpu(subsystem->enabled) != MINIDUMP_SS_ENABLED ||
>          le32_to_cpu(subsystem->encryption_status) != 
> MINIDUMP_SS_ENCR_DONE) {
>          dev_err(&rproc->dev, "Minidump not ready, skipping\n");
>          return;
>      }
> -------------------->cut<-----------------------------
> 
> where does "subsystem->regions_baseptr" for this ADSP minidump 
> descriptor get set?

Other co-processor such as adsp/cdsp/Mpss has their own way of 
registering their region/segment (mostly they are static known
regions) with minidump global infra and which could be happening
from firmware side .


-Mukesh

> 
> 
> --srini
> 
>> -    }
>> -
>> -    /* Get subsystem table of contents using the minidump id */
>> -    subsystem = &toc->subsystems[minidump_id];
>>       /**
>>        * Collect minidump if SS ToC is valid and segment table
