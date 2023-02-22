Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB9969EF96
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 08:50:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbjBVHuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 02:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBVHuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 02:50:13 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C0D34C35;
        Tue, 21 Feb 2023 23:50:12 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31M5hWS3030956;
        Wed, 22 Feb 2023 07:49:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=BcqR612iqCWvW3DvlGmYyi5ki20UIPw6xs/a6ed8V/k=;
 b=COoFBD8oB3i/p2+NTxejar+kgnRzdEFBwbyI5uxeRnm5z1qdFgyzGr/N2pMPbO5u7KK3
 /Ng1R08TGbUbLRDMv84ffjoU4kFw8FQWySUJfbfD0nulYgHACd7oeRguQHY9ayRSuNLO
 esMWWDa3VMeE4noHHlfZULWg/+q3gXOFHgvrkOyk6rBXD7PuLQ1mvS90uzs1TmjYEkUu
 ZAwnQPM31cf0HhwIobUKRsSWN7opo4RuVXKmIbiTj/3OMy71lfEpITUbMTUqC+Gsph/m
 aC4b5+mboMtvRT8YXId6TIf3ISfEF9MPce0zCCZx7PTeuoxa793E3V9Z+i4RGW0gNhDs 6g== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nvprguj01-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 07:49:52 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31M7npcM011037
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Feb 2023 07:49:51 GMT
Received: from [10.242.243.78] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 21 Feb
 2023 23:49:16 -0800
Message-ID: <90919327-650f-210d-ecdf-9f35827fe72f@quicinc.com>
Date:   Wed, 22 Feb 2023 13:19:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH V5 5/5] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <shawnguo@kernel.org>, <arnd@arndb.de>,
        <marcel.ziswiler@toradex.com>, <robimarko@gmail.com>,
        <dmitry.baryshkov@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <quic_gurus@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <quic_gokulsri@quicinc.com>, <quic_sjaganat@quicinc.com>,
        <quic_kathirav@quicinc.com>, <quic_arajkuma@quicinc.com>,
        <quic_anusha@quicinc.com>, <quic_devipriy@quicinc.com>
References: <20230216120012.28357-1-quic_poovendh@quicinc.com>
 <20230216120012.28357-6-quic_poovendh@quicinc.com>
 <51bd93be-f8d3-a33c-18ad-ba4a331f2bcf@quicinc.com>
 <38780d01-3e02-fd30-4c11-8cb307eeae4d@quicinc.com>
 <45ea27af-d4d3-48b4-236d-128a26552d6c@quicinc.com>
 <d290a4d7-885a-437f-028e-df04a117f983@quicinc.com>
 <cdb5b07f-6767-3162-532b-2c80178b8b92@quicinc.com>
From:   Sricharan Ramabadhran <quic_srichara@quicinc.com>
In-Reply-To: <cdb5b07f-6767-3162-532b-2c80178b8b92@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V2ARKtby_0kJJbsvSau7dx9O9aMpVRYe
X-Proofpoint-ORIG-GUID: V2ARKtby_0kJJbsvSau7dx9O9aMpVRYe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-22_02,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 mlxlogscore=825 lowpriorityscore=0 spamscore=0 priorityscore=1501
 impostorscore=0 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302220066
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<..>

>>>>>>       };
>>>>>> -    desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
>>>>>> +    desc.args[1] = enable ? val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
>>>>>> +                val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE);
>>>>>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>>>>>   }
>>>>>> @@ -426,15 +427,25 @@ static void qcom_scm_set_download_mode(bool 
>>>>>> enable)
>>>>>>   {
>>>>>>       bool avail;
>>>>>>       int ret = 0;
>>>>>> +    u32 dload_addr_val;
>>>>>>       avail = __qcom_scm_is_call_available(__scm->dev,
>>>>>>                            QCOM_SCM_SVC_BOOT,
>>>>>>                            QCOM_SCM_BOOT_SET_DLOAD_MODE);
>>>>>> +    ret = qcom_scm_io_readl(__scm->dload_mode_addr, 
>>>>>> &dload_addr_val);
>>>>>> +
>>>>>> +    if (ret) {
>>>>>> +        dev_err(__scm->dev,
>>>>>> +            "failed to read dload mode address value: %d\n", ret);
>>>>>> +        return;
>>>>>> +    }
>>>>>> +
>>>>>>       if (avail) {
>>>>>> -        ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>>>>>> +        ret = __qcom_scm_set_dload_mode(__scm->dev, 
>>>>>> dload_addr_val, enable);
>>>>>
>>>>> Did you test this on a target where it comes under this if 
>>>>> statement? does it really need to know dload_mode_addr for this 
>>>>> target ?
>>>>
>>>>
>>>> Can we do something like this? I would let other review as well.
>>>>
>>>> --------------------------------------->0------------------------------------------- 
>>>>
>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>>> index cdbfe54..26b7eda 100644
>>>> --- a/drivers/firmware/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom_scm.c
>>>> @@ -419,6 +419,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>>>  {
>>>>         bool avail;
>>>>         int ret = 0;
>>>> +       u32 dload_addr_val;
>>>>
>>>>         avail = __qcom_scm_is_call_available(__scm->dev,
>>>>                                              QCOM_SCM_SVC_BOOT,
>>>> @@ -426,8 +427,16 @@ static void qcom_scm_set_download_mode(bool 
>>>> enable)
>>>>         if (avail) {
>>>>                 ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>>>>         } else if (__scm->dload_mode_addr) {
>>>> -               ret = qcom_scm_io_writel(__scm->dload_mode_addr,
>>>> -                               enable ? 
>>>> QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
>>>> +               ret = qcom_scm_io_readl(__scm->dload_mode_addr, 
>>>> &dload_addr_val);
>>>> +               if (ret) {
>>>> +                       dev_err(__scm->dev,
>>>> +                               "failed to read dload mode address 
>>>> value: %d\n", ret);
>>>> +                       return;
>>>> +               }
>>>> +
>>>> +               ret = qcom_scm_io_writel(__scm->dload_mode_addr, 
>>>> enable ?
>>>> +                               dload_addr_val | 
>>>> QCOM_SCM_BOOT_SET_DLOAD_MODE :
>>>> +                               dload_addr_val & 
>>>> ~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
>>>>         } else {
>>>>                 dev_err(__scm->dev,
>>>>                         "No available mechanism for setting download 
>>>> mode\n");
>>>>
>>>> -Mukesh
>>>
>>> Okay sure..Agreed, will address this in the next patch.
>>
>>    Also, not sure, if its better to keep the old behavior working for
>>    targets that does not support 'READ' of this address. If one such
>>    thing exists, that will be broken now. In such a case, we should
>>    ignore if scm_io_readl fails, still write and dload_addr_val should
>>    be '0' initialised.
> 
> Why would a secure read of this register would fail, if one is allowed 
> to do secure write ?
> 
> Honestly, i was not understanding the purpose of this bitwise handling
> of this patch, i thought it is trying to fix existing issue for
> some target.
> 
> For some of the upstream target(e.g sm8450, i verified it myself), it is 
> not an issue.
> 
> arch/arm64/boot/dts/qcom/msm8916.dtsi:                  qcom,dload-mode 
> = <&tcsr 0x6100>;
> arch/arm64/boot/dts/qcom/msm8976.dtsi:                  qcom,dload-mode 
> = <&tcsr 0x6100>;
> arch/arm64/boot/dts/qcom/msm8996.dtsi:                  qcom,dload-mode 
> = <&tcsr_2 0x13000>;
> arch/arm64/boot/dts/qcom/sm8450.dtsi:                   qcom,dload-mode 
> = <&tcsr 0x13000>;
> 
> 
> However, it looks valid to handle only the effective bits. I have worked 
> on top of this patch and tested it and posted here.
> 
> https://lore.kernel.org/lkml/1676990381-18184-1-git-send-email-quic_mojha@quicinc.com/ 
> 
> 
> Do you have any example of any upstream target where this would fail ?

   Actually not sure. I was saying just based on the fact that,
   previously it was 'unconditional write' on all targets, now its a
   'conditional write'. If 'read' would never fail from secure,
   then your patch looks fine.

Regards,
  Sricharan
  y


