Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49606BECA7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCQPPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjCQPPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:15:16 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B5FEC50;
        Fri, 17 Mar 2023 08:15:14 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32H7YLSN022377;
        Fri, 17 Mar 2023 15:15:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ASuMh8UlwBivjkYHQuVyNXisNz0touMTfxFYoezEAn4=;
 b=plWjfswLn2uIsM8ZYKmRrsGk1lNaZGdCK+nL8yErQ/7t5aUTbK9eH8nj6UzVf1biw1To
 kp6oEhz5bPcsp7nUsv6QRRgR39WwFHMQS0zBUo9noP8Uf4kJ/EsrFqD2TpXaKfJIiw4I
 RNUNr5rCrNbah5RyLea3nk+pv0egfetOCc+fmS3pTX014yMGUdDNCSQIg5ds+mrr7Pzp
 0HDlYJemGx5IhJaW2Qag+mQK1/5rTi9heBAm2vtxj8iT7Io26iAdiGkZ+lbmlpCb/pw7
 1MnbR0M3YLzQnwvXDfGlyrVvHowurAGC9HU/I+mQCGfJYQNm8RhkYVNS5jtLPW5xY+3k Ww== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3pcem1a88e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 15:15:10 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 32HFF9ec032601
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 17 Mar 2023 15:15:09 GMT
Received: from [10.216.13.67] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 17 Mar
 2023 08:15:07 -0700
Message-ID: <b1a233b8-df0d-d3fd-7000-931e160ba1b0@quicinc.com>
Date:   Fri, 17 Mar 2023 20:45:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/4] firmware: qcom_scm: Refactor code to support
 multiple download mode
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
 <1677664555-30191-4-git-send-email-quic_mojha@quicinc.com>
 <469b4a3a-ea40-ad6b-2848-210325b8914c@linaro.org>
 <fe07806e-e77b-1198-1ffb-be8e2df53dd6@quicinc.com>
 <a0181586-817c-e093-990f-5f95c10aadbd@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <a0181586-817c-e093-990f-5f95c10aadbd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6akGz20wl32zi4HfFT2SkI58CP7pFk6_
X-Proofpoint-ORIG-GUID: 6akGz20wl32zi4HfFT2SkI58CP7pFk6_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-17_10,2023-03-16_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303150002 definitions=main-2303170104
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/16/2023 9:57 PM, Dmitry Baryshkov wrote:
> On 03/03/2023 09:46, Mukesh Ojha wrote:
>> Thanks for your time in checking this..
>>
>> On 3/1/2023 4:29 PM, Dmitry Baryshkov wrote:
>>> On 01/03/2023 11:55, Mukesh Ojha wrote:
>>>> Currently on Qualcomm SoC, download_mode is enabled if
>>>> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.
>>>>
>>>> Refactor the code such that it supports multiple download
>>>> modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
>>>> instead, give interface to set the download mode from
>>>> module parameter.
>>>>
>>>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>>>> ---
>>>> Changes in v2:
>>>>   - Passed download mode as parameter
>>>>   - Accept human accepatable download mode string.
>>>>   - enable = !!dload_mode
>>>>   - Shifted module param callback to somewhere down in
>>>>     the file so that it no longer need to know the
>>>>     prototype of qcom_scm_set_download_mode()
>>>>   - updated commit text.
>>>>
>>>>   drivers/firmware/Kconfig    | 11 --------
>>>>   drivers/firmware/qcom_scm.c | 65 
>>>> ++++++++++++++++++++++++++++++++++++++-------
>>>>   2 files changed, 56 insertions(+), 20 deletions(-)
>>>>
>>>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>>>> index b59e304..ff7e9f3 100644
>>>> --- a/drivers/firmware/Kconfig
>>>> +++ b/drivers/firmware/Kconfig
>>>> @@ -215,17 +215,6 @@ config MTK_ADSP_IPC
>>>>   config QCOM_SCM
>>>>       tristate
>>>> -config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>>>> -    bool "Qualcomm download mode enabled by default"
>>>> -    depends on QCOM_SCM
>>>> -    help
>>>> -      A device with "download mode" enabled will upon an unexpected
>>>> -      warm-restart enter a special debug mode that allows the user to
>>>> -      "download" memory content over USB for offline postmortem 
>>>> analysis.
>>>> -      The feature can be enabled/disabled on the kernel command line.
>>>> -
>>>> -      Say Y here to enable "download mode" by default.
>>>> -
>>>>   config SYSFB
>>>>       bool
>>>>       select BOOT_VESA_SUPPORT
>>>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>>>> index c9f1fad..ca07208 100644
>>>> --- a/drivers/firmware/qcom_scm.c
>>>> +++ b/drivers/firmware/qcom_scm.c
>>>> @@ -17,17 +17,22 @@
>>>>   #include <linux/clk.h>
>>>>   #include <linux/reset-controller.h>
>>>>   #include <linux/arm-smccc.h>
>>>> +#include <linux/kstrtox.h>
>>>>   #include "qcom_scm.h"
>>>> -static bool download_mode = 
>>>> IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>>>> -module_param(download_mode, bool, 0);
>>>> -
>>>>   #define SCM_HAS_CORE_CLK    BIT(0)
>>>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>>>   #define SCM_HAS_BUS_CLK        BIT(2)
>>>>   #define QCOM_DOWNLOAD_MODE_MASK 0x30
>>>> +#define QCOM_DOWNLOAD_FULLDUMP    0x10
>>>> +#define QCOM_DOWNLOAD_NODUMP    0x0
>>>> +
>>>> +#define MAX_DLOAD_LEN    8
>>>> +
>>>> +static char download_mode[] = "off";
>>>> +static u32 dload_mode;
>>>>   struct qcom_scm {
>>>>       struct device *dev;
>>>> @@ -417,8 +422,9 @@ static int __qcom_scm_set_dload_mode(struct 
>>>> device *dev, bool enable)
>>>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>>>   }
>>>> -static void qcom_scm_set_download_mode(bool enable)
>>>> +static void qcom_scm_set_download_mode(u32 dload_mode)
>>>>   {
>>>> +    bool enable = !!dload_mode;
>>>>       bool avail;
>>>>       int ret = 0;
>>>>       u32 val;
>>>> @@ -438,7 +444,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>>>           val &= ~QCOM_DOWNLOAD_MODE_MASK;
>>>>           if (enable)
>>>> -            val |= QCOM_SCM_BOOT_SET_DLOAD_MODE;
>>>> +            val |= dload_mode;
>>>>           ret = qcom_scm_io_writel(__scm->dload_mode_addr, val);
>>>>       } else {
>>>> @@ -1338,6 +1344,47 @@ bool qcom_scm_is_available(void)
>>>>   }
>>>>   EXPORT_SYMBOL(qcom_scm_is_available);
>>>> +static int set_dload_mode(const char *val, const struct 
>>>> kernel_param *kp)
>>>> +{
>>>> +    int ret;
>>>> +
>>>> +    if (!strncmp(val, "full", strlen("full"))) {
>>>> +        dload_mode = QCOM_DOWNLOAD_FULLDUMP;
>>>> +    } else if (!strncmp(val, "off", strlen("off"))) {
>>>> +        dload_mode = QCOM_DOWNLOAD_NODUMP;
>>>> +    } else {
>>>> +        if (kstrtouint(val, 0, &dload_mode) ||
>>>> +             !(dload_mode == 0 || dload_mode == 1)) {
>>>> +            pr_err("unknown download mode\n");
>>>> +            return -EINVAL;
>>>> +        }
>>>> +
>>>> +    }
>>>> +
>>>> +    ret = param_set_copystring(val, kp);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (__scm)
>>>> +        qcom_scm_set_download_mode(dload_mode);
>>>> +
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static const struct kernel_param_ops dload_mode_param_ops = {
>>>> +    .set = set_dload_mode,
>>>> +    .get = param_get_string,
>>>
>>> Please follow the param_get_bool approach and return sanitized data 
>>> here. In other words, "full" / "none" depending on the dload_mode 
>>> instead of storing the passed string and returning it later.
>>>
>>
>> This could be done.
>>
>>>> +};
>>>> +
>>>> +static struct kparam_string dload_mode_param = {
>>>> +    .string = download_mode,
>>>> +    .maxlen = MAX_DLOAD_LEN,
>>>
>>> I think writing "full" to this param might overwrite some kernel 
>>> data. "00000000" should be even worse.
>>
>> There is check in param_set_copystring() which would avoid that.
> 
> 
> No. The check will validate the value's length against MAX_DLOAD_LEN. 
> But it will not safeguard your code. download_mode's size is less than 
> MAX_DLOAD_LEN.

Oops !! you are right..,
Will fix it in v3.

-Mukesh

> 
