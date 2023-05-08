Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 847E96FA0BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 09:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjEHHMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 03:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbjEHHMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 03:12:13 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3F31BD8;
        Mon,  8 May 2023 00:11:45 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3486w1X3004452;
        Mon, 8 May 2023 07:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=eqQdcuRedzay5X2IT8ljqmvzrxYWoEOLtlkOnyQEbn8=;
 b=oOzp4Ofbo4TOKtGMQ0ziEyv33UfjMQ5uzDpmN3QF+Ol++QbtfaqT9qAMr7zUbS8X7mEp
 iDEdgjFHDedXPmcDsj1Cw4YFtzVczyDSYLk3wdVxGvZOxuHTAnGAkk/IfDiNkQycJyjk
 rJXnk+8ZHKOnOCPda55jYONFJ6ACXRE4ncMJp5S4xdJewC/U4n2FWYij33vwgGe+6lbM
 tu6YLh1ZYRYfpNEyQiZSWmS7kQxgNgNC7GL2d5er8UgKln+iCgPIyd4dNd0p/Moyn7wW
 A98lD+pwNttY/kl3ZhLMvzH9hbKzn0c6iIQbh4GJNSduUqn6jaWigjbCXkpwYFts4/Sa tw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qev9a80wb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 07:11:01 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3487B004004938
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 07:11:00 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 8 May 2023
 00:10:54 -0700
Message-ID: <e714566e-39b7-d46b-13bd-3c0e20e9f944@quicinc.com>
Date:   Mon, 8 May 2023 12:40:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 04/18] soc: qcom: Add Qualcomm minidump kernel driver
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <corbet@lwn.net>,
        <keescook@chromium.org>, <tony.luck@intel.com>,
        <gpiccoli@igalia.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-doc@vger.kernel.org>
References: <1683133352-10046-1-git-send-email-quic_mojha@quicinc.com>
 <1683133352-10046-5-git-send-email-quic_mojha@quicinc.com>
 <c6f730b6-f702-91d4-4abd-71546e02f869@linaro.org>
 <23b493f4-1a01-8d03-fc12-d588b2c6fd74@quicinc.com>
 <575a422d-6224-06b7-628c-8487b47882e9@linaro.org>
 <500e5abc-fb71-8468-a6b0-3ced2676b57c@linaro.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <500e5abc-fb71-8468-a6b0-3ced2676b57c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: LFuGGy60Q1JKYaitJRm9wfIf6IdSzpwl
X-Proofpoint-ORIG-GUID: LFuGGy60Q1JKYaitJRm9wfIf6IdSzpwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2305080050
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2023 10:04 PM, Krzysztof Kozlowski wrote:
> On 04/05/2023 17:21, Krzysztof Kozlowski wrote:
>>>>
>>>>> +	ret = qcom_minidump_init_apss_subsystem(md);
>>>>> +	if (ret) {
>>>>> +		dev_err(&pdev->dev, "apss minidump initialization failed: %d\n", ret);
>>>>> +		goto unlock;
>>>>> +	}
>>>>> +
>>>>> +	__md = md;
>>>>
>>>> No. This is a platform device, so it can have multiple instances.
>>>
>>> It can have only one instance that is created from SMEM driver probe.
>>
>> Anyone can instantiate more of them.... how did you solve it?
> 
> To clarify - sprinkling more of singletons makes everything tightly
> coupled, difficult to debug and non-portable. You cannot have two
> instances, you have to control concurrent initialization by yourself in
> each of such singletons.
> 
> I understand sometimes they are unavoidable, for example when this does
> not map to hardware property. However here you have the parent - smem -
> which can return you valid instance. Thus you avoid entire problem of
> file-scope variables.

I get your point, why one's should avoid file scope variables.


This is infrastructure driver and will not have multiple instances and 
even if it happens could be avoided with with the help of global mutex 
and protect below function which i am already doing at the moment and 
fail the other probe if it is already initialized with proper logging..e.g

"already initialized..."


ret = qcom_minidump_init_apss_subsystem(md);


And this will be in-lined with

/* Pointer to the one and only smem handle */
static struct qcom_smem *__smem;

Let me know if you still disagree...and have some other way ?


-- Mukesh


> 
> Best regards,
> Krzysztof
> 
