Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC78169B358
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 20:50:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBQTud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 14:50:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQTub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 14:50:31 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8644FCA2;
        Fri, 17 Feb 2023 11:50:29 -0800 (PST)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31HCcsIi011130;
        Fri, 17 Feb 2023 19:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=DDzxof5IcVzLldI7GDtr6orQv7jtauqlTg374hNf258=;
 b=J1I9wcoWsNoCHPUw/T99krE+vM9Yl0vUe6jdsO+5fbZzNu8YBkwIrPmZxXZgLCkbxtPp
 QmL7iLiLfClTNQPRYUvU9UJRmrdv9ECdJZXydIvCRFr1DTyNPVrFNvuXXL7E+1kigZS8
 sJzNTmjsdfbt9495/qUlvVXFg+OwoGzF1g2sRCzEwJFTauiTGMOIX0LE0kQk40VsEu3v
 FeZT9SC36sWmSVLS+AR1VxgYCxfI1XwFal37Krt2Q3sMwGD9iQDJ7LJ09cJqo53CXMdi
 +4fOS2h7RJVxX85Pxq9OjAIkCe4qGHyJEHSJA8mOCw5JX5hzbNF+CvYIWGDGptLAXWVE nw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nshe5mxvf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 19:50:08 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 31HJo7J9026503
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Feb 2023 19:50:07 GMT
Received: from [10.216.18.25] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Feb
 2023 11:49:57 -0800
Message-ID: <38780d01-3e02-fd30-4c11-8cb307eeae4d@quicinc.com>
Date:   Sat, 18 Feb 2023 01:19:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V5 5/5] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>,
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
References: <20230216120012.28357-1-quic_poovendh@quicinc.com>
 <20230216120012.28357-6-quic_poovendh@quicinc.com>
 <51bd93be-f8d3-a33c-18ad-ba4a331f2bcf@quicinc.com>
In-Reply-To: <51bd93be-f8d3-a33c-18ad-ba4a331f2bcf@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HEPiM6rO7lmKJJLLDWAeOiU3MwhP2ynR
X-Proofpoint-ORIG-GUID: HEPiM6rO7lmKJJLLDWAeOiU3MwhP2ynR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-17_14,2023-02-17_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302170173
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/16/2023 7:30 PM, Mukesh Ojha wrote:
> 
> 
> On 2/16/2023 5:30 PM, Poovendhan Selvaraj wrote:
>> CrashDump collection is based on the DLOAD bit of TCSR register.
>> To retain other bits, we read the register and modify only the DLOAD 
>> bit as
>> the other bits have their own significance.
>>
>> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
>> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
>> Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
>> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> ---
>>   Changes in V5:
>>     - checking the return value in qcom_scm_set_download_mode function as
>>       suggested by Srinivas Kandagatla
>>
>>   Changes in V4:
>>     - retain the orginal value of tcsr register when download mode
>>       is not set
>>
>>   drivers/firmware/qcom_scm.c | 21 ++++++++++++++++-----
>>   1 file changed, 16 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 468d4d5ab550..d88c5f14bd54 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -407,7 +407,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>>   }
>>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>> +static int __qcom_scm_set_dload_mode(struct device *dev, u32 val, 
>> bool enable)
>>   {
>>       struct qcom_scm_desc desc = {
>>           .svc = QCOM_SCM_SVC_BOOT,
>> @@ -417,7 +417,8 @@ static int __qcom_scm_set_dload_mode(struct device 
>> *dev, bool enable)
>>           .owner = ARM_SMCCC_OWNER_SIP,
>>       };
>> -    desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
>> +    desc.args[1] = enable ? val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
>> +                val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE);
>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>   }
>> @@ -426,15 +427,25 @@ static void qcom_scm_set_download_mode(bool enable)
>>   {
>>       bool avail;
>>       int ret = 0;
>> +    u32 dload_addr_val;
>>       avail = __qcom_scm_is_call_available(__scm->dev,
>>                            QCOM_SCM_SVC_BOOT,
>>                            QCOM_SCM_BOOT_SET_DLOAD_MODE);
>> +    ret = qcom_scm_io_readl(__scm->dload_mode_addr, &dload_addr_val);
>> +
>> +    if (ret) {
>> +        dev_err(__scm->dev,
>> +            "failed to read dload mode address value: %d\n", ret);
>> +        return;
>> +    }
>> +
>>       if (avail) {
>> -        ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>> +        ret = __qcom_scm_set_dload_mode(__scm->dev, dload_addr_val, 
>> enable);
> 
> Did you test this on a target where it comes under this if statement? 
> does it really need to know dload_mode_addr for this target ?


Can we do something like this? I would let other review as well.

--------------------------------------->0-------------------------------------------
diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index cdbfe54..26b7eda 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -419,6 +419,7 @@ static void qcom_scm_set_download_mode(bool enable)
  {
         bool avail;
         int ret = 0;
+       u32 dload_addr_val;

         avail = __qcom_scm_is_call_available(__scm->dev,
                                              QCOM_SCM_SVC_BOOT,
@@ -426,8 +427,16 @@ static void qcom_scm_set_download_mode(bool enable)
         if (avail) {
                 ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
         } else if (__scm->dload_mode_addr) {
-               ret = qcom_scm_io_writel(__scm->dload_mode_addr,
-                               enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
+               ret = qcom_scm_io_readl(__scm->dload_mode_addr, 
&dload_addr_val);
+               if (ret) {
+                       dev_err(__scm->dev,
+                               "failed to read dload mode address 
value: %d\n", ret);
+                       return;
+               }
+
+               ret = qcom_scm_io_writel(__scm->dload_mode_addr, enable ?
+                               dload_addr_val | 
QCOM_SCM_BOOT_SET_DLOAD_MODE :
+                               dload_addr_val & 
~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
         } else {
                 dev_err(__scm->dev,
                         "No available mechanism for setting download 
mode\n");

-Mukesh
> 
> -Mukesh
>>       } else if (__scm->dload_mode_addr) {
>> -        ret = qcom_scm_io_writel(__scm->dload_mode_addr,
>> -                enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
>> +        ret = qcom_scm_io_writel(__scm->dload_mode_addr, enable ?
>> +                dload_addr_val | QCOM_SCM_BOOT_SET_DLOAD_MODE :
>> +                dload_addr_val & ~(QCOM_SCM_BOOT_SET_DLOAD_MODE));
>>       } else {
>>           dev_err(__scm->dev,
>>               "No available mechanism for setting download mode\n");
