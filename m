Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B44A697F5B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 16:18:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBOPSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 10:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBOPR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 10:17:57 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C860D525;
        Wed, 15 Feb 2023 07:17:55 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31FFFfJh012986;
        Wed, 15 Feb 2023 15:17:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=LQbqG5X+j4Vp+Wg7GOPt2JqqS8g/df/JsnGY+AP7q3Q=;
 b=X9Lt0dxG96gkg89bBM/2r7HqfsyzjdVCdwUMoeA5kc5Qm+NN9d5AthlMAhU5tu2hLpwg
 qEargaL50VM0G0z54u83FEF+vBeiDI1oEQpw86SiMkWVuZnk9sh/FTd5r9dC/GsyMw5f
 aMijv5XaFrYkvX0y/eKP4xf1LlWXkePcQ86P0OLk6WIfdH0w1tIa/Yye/I5BmGK3SbUU
 bMB9hSr4iqoLip5SwCxxR6yRaeXiDnCzgSx6Y2UBAbUtt1GOWfREI9+93luEgE+t5gfw
 acXGGls2zrWm/BSV5iydd6B4LXRpw37f73ezADRL3Xs8n4JcIPcv/MSi20LaeJcOsVVh fw== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nrf7v2s18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 15:17:35 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31FFHYM0010005
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Feb 2023 15:17:34 GMT
Received: from [10.216.16.215] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 15 Feb
 2023 07:17:25 -0800
Message-ID: <eac46f7b-e1e3-12d8-9831-581ace0c3de3@quicinc.com>
Date:   Wed, 15 Feb 2023 20:47:21 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V4 5/5] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
From:   POOVENDHAN SELVARAJ <quic_poovendh@quicinc.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
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
CC:     <quic_srichara@quicinc.com>, <quic_gokulsri@quicinc.com>,
        <quic_sjaganat@quicinc.com>, <quic_kathirav@quicinc.com>,
        <quic_arajkuma@quicinc.com>, <quic_anusha@quicinc.com>,
        <quic_devipriy@quicinc.com>
References: <20230214051414.10740-1-quic_poovendh@quicinc.com>
 <20230214051414.10740-6-quic_poovendh@quicinc.com>
 <ffeff1f8-ebf6-3115-38d1-fa318549baa0@linaro.org>
 <b5135d69-3783-8147-bda5-8131cea726f7@quicinc.com>
In-Reply-To: <b5135d69-3783-8147-bda5-8131cea726f7@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: N3fJ1RGr6HnCtqkYKd1lNizkneZBVawd
X-Proofpoint-GUID: N3fJ1RGr6HnCtqkYKd1lNizkneZBVawd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-15_06,2023-02-15_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 spamscore=0 phishscore=0 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302150137
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/2023 4:25 PM, POOVENDHAN SELVARAJ wrote:
>
>
> On 2/14/2023 6:27 PM, Srinivas Kandagatla wrote:
>>
>>
>> On 14/02/2023 05:14, Poovendhan Selvaraj wrote:
>>> CrashDump collection is based on the DLOAD bit of TCSR register.
>>> To retain other bits, we read the register and modify only the DLOAD 
>>> bit as
>>> the other bits have their own significance.
>>>
>>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>>> Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>>> ---
>>>   Changes in V4:
>>>     - retain the orginal value of tcsr register when download mode
>>>       is not set
>>>
>>>   drivers/firmware/qcom_scm.c | 15 ++++++++++-----
>>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>> index 468d4d5ab550..8a34b386ac3a 100644
>>> --- a/drivers/firmware/qcom_scm.c
>>> +++ b/drivers/firmware/qcom_scm.c
>>> @@ -407,7 +407,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>>>   }
>>>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>>>   -static int __qcom_scm_set_dload_mode(struct device *dev, bool 
>>> enable)
>>> +static int __qcom_scm_set_dload_mode(struct device *dev, u32 val, 
>>> bool enable)
>>>   {
>>>       struct qcom_scm_desc desc = {
>>>           .svc = QCOM_SCM_SVC_BOOT,
>>> @@ -417,7 +417,8 @@ static int __qcom_scm_set_dload_mode(struct 
>>> device *dev, bool enable)
>>>           .owner = ARM_SMCCC_OWNER_SIP,
>>>       };
>>>   -    desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
>>> +    desc.args[1] = enable ? val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
>>> +                val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE);
>>
>> why not read the value here before setting the DLOAD Mode instead of 
>> doing it in qcom_scm_set_download_mode()?
>> that would make the code simple and readable.
dload_addr_val is used in both if and else if cases in 
qcom_scm_set_download_mode(),
so we read in qcom_scm_set_download_mode() function and pass to 
__qcom_scm_set_dload_mode().
>>
>>>         return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>>   }
>>> @@ -426,15 +427,19 @@ static void qcom_scm_set_download_mode(bool 
>>> enable)
>>>   {
>>>       bool avail;
>>>       int ret = 0;
>>> +    u32 dload_addr_val;
>>>         avail = __qcom_scm_is_call_available(__scm->dev,
>>>                            QCOM_SCM_SVC_BOOT,
>>>                            QCOM_SCM_BOOT_SET_DLOAD_MODE);
>>> +    ret = qcom_scm_io_readl(__scm->dload_mode_addr, &dload_addr_val);
>>> +
>> not checking ret value here before proceeding?
>>
Okay, sure..will address in next patch series.
>>>       if (avail) {
>>> -        ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>>> +        ret = __qcom_scm_set_dload_mode(__scm->dev, dload_addr_val, 
>>> enable);
>>>       } else if (__scm->dload_mode_addr) {
>>> -        ret = qcom_scm_io_writel(__scm->dload_mode_addr,
>>> -                enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
>>> +        ret = qcom_scm_io_writel(__scm->dload_mode_addr, enable ?
>>> +                dload_addr_val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
>>> +                dload_addr_val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
>>>       } else {
>>>           dev_err(__scm->dev,
>>>               "No available mechanism for setting download mode\n");


Please excuse the format in Previous mail response.
Had some issues in email client and now it's fixed.

Regards,
Poovendhan S



