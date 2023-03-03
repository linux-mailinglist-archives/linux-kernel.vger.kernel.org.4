Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0572E6A91E5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCCHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCCHq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:46:59 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852A4521EF;
        Thu,  2 Mar 2023 23:46:58 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32357uFJ011344;
        Fri, 3 Mar 2023 07:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=NIT8nTfoZl7k2Y7KV2J6qVcc307frlqqTymfIe0oI6w=;
 b=UoTOi4FigknZq+zCecWn+Wv/is2aP4fmLZvFxpo0lZuOvrFb6FMdUtbW+hHFrZR0yKcd
 vrJKqFj4dHG8fKipomeoUS3F+2nzDa4ppLtQURiaq6ecqZ2yrejfP0eGtsDlhMjNQzam
 diG8WW9VUGaSft3gaMycrYDlBXT4yGMTjln0Xwu0cT1LG/V5JaNvggxiDPVK1zZAIpEd
 oMdGmwsbun2Kij/4UxyoKbRsTpaci7o0wfdlSGyyQDebIDagzWQfBZkVqni8efT2S6/Q
 mjfrrj2wO6CBKfgGDE7Rrj+7O+5IP0bu7AG6880hetnlUXYHofczQqHehCX2hhvvThYl QQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2ar1572c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 07:46:48 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3237kmo7003991
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 07:46:48 GMT
Received: from [10.216.34.86] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 23:46:45 -0800
Message-ID: <fe07806e-e77b-1198-1ffb-be8e2df53dd6@quicinc.com>
Date:   Fri, 3 Mar 2023 13:16:41 +0530
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
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <469b4a3a-ea40-ad6b-2848-210325b8914c@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 4dfNWHSxzdhU401kYcwlHKg-SFsvvD7p
X-Proofpoint-ORIG-GUID: 4dfNWHSxzdhU401kYcwlHKg-SFsvvD7p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 bulkscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303030068
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your time in checking this..

On 3/1/2023 4:29 PM, Dmitry Baryshkov wrote:
> On 01/03/2023 11:55, Mukesh Ojha wrote:
>> Currently on Qualcomm SoC, download_mode is enabled if
>> CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT is selected.
>>
>> Refactor the code such that it supports multiple download
>> modes and drop CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT config
>> instead, give interface to set the download mode from
>> module parameter.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes in v2:
>>   - Passed download mode as parameter
>>   - Accept human accepatable download mode string.
>>   - enable = !!dload_mode
>>   - Shifted module param callback to somewhere down in
>>     the file so that it no longer need to know the
>>     prototype of qcom_scm_set_download_mode()
>>   - updated commit text.
>>
>>   drivers/firmware/Kconfig    | 11 --------
>>   drivers/firmware/qcom_scm.c | 65 
>> ++++++++++++++++++++++++++++++++++++++-------
>>   2 files changed, 56 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
>> index b59e304..ff7e9f3 100644
>> --- a/drivers/firmware/Kconfig
>> +++ b/drivers/firmware/Kconfig
>> @@ -215,17 +215,6 @@ config MTK_ADSP_IPC
>>   config QCOM_SCM
>>       tristate
>> -config QCOM_SCM_DOWNLOAD_MODE_DEFAULT
>> -    bool "Qualcomm download mode enabled by default"
>> -    depends on QCOM_SCM
>> -    help
>> -      A device with "download mode" enabled will upon an unexpected
>> -      warm-restart enter a special debug mode that allows the user to
>> -      "download" memory content over USB for offline postmortem 
>> analysis.
>> -      The feature can be enabled/disabled on the kernel command line.
>> -
>> -      Say Y here to enable "download mode" by default.
>> -
>>   config SYSFB
>>       bool
>>       select BOOT_VESA_SUPPORT
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index c9f1fad..ca07208 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -17,17 +17,22 @@
>>   #include <linux/clk.h>
>>   #include <linux/reset-controller.h>
>>   #include <linux/arm-smccc.h>
>> +#include <linux/kstrtox.h>
>>   #include "qcom_scm.h"
>> -static bool download_mode = 
>> IS_ENABLED(CONFIG_QCOM_SCM_DOWNLOAD_MODE_DEFAULT);
>> -module_param(download_mode, bool, 0);
>> -
>>   #define SCM_HAS_CORE_CLK    BIT(0)
>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>   #define SCM_HAS_BUS_CLK        BIT(2)
>>   #define QCOM_DOWNLOAD_MODE_MASK 0x30
>> +#define QCOM_DOWNLOAD_FULLDUMP    0x10
>> +#define QCOM_DOWNLOAD_NODUMP    0x0
>> +
>> +#define MAX_DLOAD_LEN    8
>> +
>> +static char download_mode[] = "off";
>> +static u32 dload_mode;
>>   struct qcom_scm {
>>       struct device *dev;
>> @@ -417,8 +422,9 @@ static int __qcom_scm_set_dload_mode(struct device 
>> *dev, bool enable)
>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>   }
>> -static void qcom_scm_set_download_mode(bool enable)
>> +static void qcom_scm_set_download_mode(u32 dload_mode)
>>   {
>> +    bool enable = !!dload_mode;
>>       bool avail;
>>       int ret = 0;
>>       u32 val;
>> @@ -438,7 +444,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>           val &= ~QCOM_DOWNLOAD_MODE_MASK;
>>           if (enable)
>> -            val |= QCOM_SCM_BOOT_SET_DLOAD_MODE;
>> +            val |= dload_mode;
>>           ret = qcom_scm_io_writel(__scm->dload_mode_addr, val);
>>       } else {
>> @@ -1338,6 +1344,47 @@ bool qcom_scm_is_available(void)
>>   }
>>   EXPORT_SYMBOL(qcom_scm_is_available);
>> +static int set_dload_mode(const char *val, const struct kernel_param 
>> *kp)
>> +{
>> +    int ret;
>> +
>> +    if (!strncmp(val, "full", strlen("full"))) {
>> +        dload_mode = QCOM_DOWNLOAD_FULLDUMP;
>> +    } else if (!strncmp(val, "off", strlen("off"))) {
>> +        dload_mode = QCOM_DOWNLOAD_NODUMP;
>> +    } else {
>> +        if (kstrtouint(val, 0, &dload_mode) ||
>> +             !(dload_mode == 0 || dload_mode == 1)) {
>> +            pr_err("unknown download mode\n");
>> +            return -EINVAL;
>> +        }
>> +
>> +    }
>> +
>> +    ret = param_set_copystring(val, kp);
>> +    if (ret)
>> +        return ret;
>> +
>> +    if (__scm)
>> +        qcom_scm_set_download_mode(dload_mode);
>> +
>> +    return 0;
>> +}
>> +
>> +static const struct kernel_param_ops dload_mode_param_ops = {
>> +    .set = set_dload_mode,
>> +    .get = param_get_string,
> 
> Please follow the param_get_bool approach and return sanitized data 
> here. In other words, "full" / "none" depending on the dload_mode 
> instead of storing the passed string and returning it later.
> 

This could be done.

>> +};
>> +
>> +static struct kparam_string dload_mode_param = {
>> +    .string = download_mode,
>> +    .maxlen = MAX_DLOAD_LEN,
> 
> I think writing "full" to this param might overwrite some kernel data. 
> "00000000" should be even worse.

There is check in param_set_copystring() which would avoid that.

> 
>> +};
>> +
>> +module_param_cb(download_mode, &dload_mode_param_ops, 
>> &dload_mode_param, 0644);
>> +MODULE_PARM_DESC(download_mode,
>> +         "Download mode: off/full or 0/1/off/on for existing users");
> 
> Nit: on is not supported even for existing users.

Agree. just 0/1 would do fine there.

-Mukesh
> 
>> +
>>   static int qcom_scm_probe(struct platform_device *pdev)
>>   {
>>       struct qcom_scm *scm;
>> @@ -1418,12 +1465,12 @@ static int qcom_scm_probe(struct 
>> platform_device *pdev)
>>       __get_convention();
>>       /*
>> -     * If requested enable "download mode", from this point on warmboot
>> +     * If download mode is requested, from this point on warmboot
>>        * will cause the boot stages to enter download mode, unless
>>        * disabled below by a clean shutdown/reboot.
>>        */
>> -    if (download_mode)
>> -        qcom_scm_set_download_mode(true);
>> +    if (dload_mode)
>> +        qcom_scm_set_download_mode(dload_mode);
>>       return 0;
>>   }
>> @@ -1431,7 +1478,7 @@ static int qcom_scm_probe(struct platform_device 
>> *pdev)
>>   static void qcom_scm_shutdown(struct platform_device *pdev)
>>   {
>>       /* Clean shutdown, disable download mode to allow normal restart */
>> -    qcom_scm_set_download_mode(false);
>> +    qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
>>   }
>>   static const struct of_device_id qcom_scm_dt_match[] = {
> 
