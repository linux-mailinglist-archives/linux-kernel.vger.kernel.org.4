Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803306CD35C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 09:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjC2HgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 03:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbjC2Hf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 03:35:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F8E85275;
        Wed, 29 Mar 2023 00:33:27 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32T3EUUq007380;
        Wed, 29 Mar 2023 07:33:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=fTWyDWDjyC7mqDBUK54ZxQ5Fy1/uDhWx6Ve7IdJ33Do=;
 b=EqkfybFfABlDkJwsmsBd7VZho0MhuVnXWXnrHrPDioIpfBohTOP1lz2bF6fO10pgWSmx
 1VnEqFP/yRJj2JR0+48Qv7SPp3Yry9zilo9qrwSuvCA9mAig2OHrHUzoj5kfImrPrGX3
 qnz0l0x8MBay3lnd6+Z8S2nqeRl1wWzKE0ZqNefCbjMsITAw8XGaEUs2EjlI4Ltgzfx3
 IwuRSl9JjKaige6HpubZRcGqDMjrhvq+GsLRG6LFoAvSaiOrZZxyIWSCECsy1pt5BfSH
 HOhrU+JXWyPDW6njQmXOmiMy1F0AJ33Mg2qBJP4RNVgbhKjqH1NgjX0Hva4Scf0GTFF3 cA== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pm7hch594-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 07:33:23 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32T7XM87000412
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Mar 2023 07:33:22 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Wed, 29 Mar
 2023 00:33:20 -0700
Message-ID: <65fb3eee-3d92-d6c8-a0c1-8f5bfc1a00b6@quicinc.com>
Date:   Wed, 29 Mar 2023 13:03:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v4 4/5] firmware: qcom_scm: Refactor code to support
 multiple download mode
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
CC:     <agross@kernel.org>, <konrad.dybcio@linaro.org>,
        <linus.walleij@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
References: <1679935281-18445-1-git-send-email-quic_mojha@quicinc.com>
 <1679935281-18445-5-git-send-email-quic_mojha@quicinc.com>
 <20230327182324.elrxciz5vqvryp7y@ripper>
 <e342044c-dcf9-e443-5244-0990dfc59443@quicinc.com>
 <2bff9246-dd42-1c21-930f-2da2fed588f2@linaro.org>
Content-Language: en-US
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <2bff9246-dd42-1c21-930f-2da2fed588f2@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BXrbAxiLhQvicdEI0JO4EKwKnST5PHF4
X-Proofpoint-GUID: BXrbAxiLhQvicdEI0JO4EKwKnST5PHF4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-29_02,2023-03-28_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2303290060
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/29/2023 3:44 AM, Dmitry Baryshkov wrote:
> On 28/03/2023 11:18, Mukesh Ojha wrote:
>>
>>
>> On 3/27/2023 11:53 PM, Bjorn Andersson wrote:
>>> On Mon, Mar 27, 2023 at 10:11:20PM +0530, Mukesh Ojha wrote:
>>> [..]
>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>>> index 3c6c5e7..0c94429 100644
>>>> --- a/drivers/firmware/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom_scm.c
>>>> @@ -20,11 +20,11 @@
>>>>   #include <linux/clk.h>
>>>>   #include <linux/reset-controller.h>
>>>>   #include <linux/arm-smccc.h>
>>>> +#include <linux/kstrtox.h>
>>>>   #include "qcom_scm.h"
>>>> -static bool download_mode = 
>>>> IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>>>> -module_param(download_mode, bool, 0);
>>>> +static u32 download_mode;
>>>>   #define SCM_HAS_CORE_CLK    BIT(0)
>>>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>>> @@ -32,6 +32,7 @@ module_param(download_mode, bool, 0);
>>>>   #define QCOM_DOWNLOAD_MODE_MASK 0x30
>>>>   #define QCOM_DOWNLOAD_FULLDUMP    0x1
>>>> +#define QCOM_DOWNLOAD_NODUMP    0x0
>>>>   struct qcom_scm {
>>>>       struct device *dev;
>>>> @@ -440,8 +441,9 @@ static int __qcom_scm_set_dload_mode(struct 
>>>> device *dev, bool enable)
>>>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>>>   }
>>>> -static void qcom_scm_set_download_mode(bool enable)
>>>> +static void qcom_scm_set_download_mode(u32 download_mode)
>>>>   {
>>>> +    bool enable = !!download_mode;
>>>>       bool avail;
>>>>       int ret = 0;
>>>> @@ -453,7 +455,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>>>       } else if (__scm->dload_mode_addr) {
>>>>           ret = qcom_scm_io_update_field(__scm->dload_mode_addr,
>>>>                   QCOM_DOWNLOAD_MODE_MASK,
>>>> -                enable ? QCOM_DOWNLOAD_FULLDUMP : 0);
>>>> +                enable ? download_mode : 0);
>>>
>>> Afaict, with QCOM_DOWNLOAD_NODUMP as 0, this says:
>>>
>>>    when download_mode is non-zero, write that value, otherwise write 0
>>>
>>> That should be the same as "write download_mode", so you should be able
>>> to drop the enable part.
>>>
>>>>       } else {
>>>>           dev_err(__scm->dev,
>>>>               "No available mechanism for setting download mode\n");
>>>> @@ -1419,6 +1421,49 @@ static irqreturn_t qcom_scm_irq_handler(int 
>>>> irq, void *data)
>>>>       return IRQ_HANDLED;
>>>>   }
>>>> +
>>>> +static int get_download_mode(char *buffer, const struct 
>>>> kernel_param *kp)
>>>> +{
>>>> +    int len = 0;
>>>> +
>>>> +    if (download_mode == QCOM_DOWNLOAD_FULLDUMP)
>>>> +        len = sysfs_emit(buffer, "full\n");
>>>> +    else if (download_mode == QCOM_DOWNLOAD_NODUMP)
>>>> +        len = sysfs_emit(buffer, "off\n");
>>>> +
>>>> +    return len;
>>>> +}
>>>> +
>>>> +static int set_download_mode(const char *val, const struct 
>>>> kernel_param *kp)
>>>> +{
>>>> +    u32 old = download_mode;
>>>> +
>>>> +    if (!strncmp(val, "full", strlen("full"))) {
>>>
>>> strcmp loops over the two string until they differ and/or both are
>>> '\0'.
>>>
>>> As such, the only thing you achieve by using strncmp(.., T, strlen(T))
>>> is that the code has to iterate over T twice - and you make the code
>>> harder to read.
>>
>>
>> If we use strcmp, i need to use "full\n" which we would not want to do.
>> I think, we need to take this hit.
> 
> There is a special helper for the sysfs files. See sysfs_streq().

You are awesome !!
Thanks.

Have applied the change.

-- Mukesh
> 
>>
>> -- Mukesh
>>>
>>>> +        download_mode = QCOM_DOWNLOAD_FULLDUMP;
>>>> +    } else if (!strncmp(val, "off", strlen("off"))) {
>>>> +        download_mode = QCOM_DOWNLOAD_NODUMP;
>>>> +    } else if (kstrtouint(val, 0, &download_mode) ||
>>>> +           !(download_mode == 0 || download_mode == 1)) {
>>>> +        download_mode = old;
>>>> +        pr_err("unknown download mode\n");
>>>
>>> This will result in a lone "unknown download mode" line somewhere in the
>>> kernel log, without association to any driver or any indication what the
>>> unknown value was.
>>>
>>>    pr_err("qcom_scm: unknown download mode: %s\n", val);
>>>
>>> Would give both context and let the reader know right there what value
>>> the code wasn't able to match.
>>>
>>> Regards,
>>> Bjorn
> 
