Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D235689C42
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 15:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233080AbjBCOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 09:53:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233088AbjBCOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 09:53:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6EB10AA4;
        Fri,  3 Feb 2023 06:53:45 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3137L1Xf025282;
        Fri, 3 Feb 2023 14:53:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=UQsAHyssvOiCuN6Xbq3Jso/RMYaqE0J6daqCeklUyzo=;
 b=PkSfJOckts6pPcTIg4IgFNd9fR27l6NtQvP6tLQEvqn+98o0gLLiSRXveufgzX6hdNdS
 jUowYin7HaPfINRnMwsMuCXPh8CIG13LjvEDroR22Tr1t9HWiOg7VGn95m/QuxxvlOoN
 zrIox5118UHrbwN5ZnWtihYIqkQquOhWNPqosEOJe32MXMldgMsJFURs53p40Owm0mW+
 ds272fcNtYbn+v7mKQ+2TXOwUgWGSAouxsbbiLENUtok3X0ImKDtUgK+gMyDo4Vds0UB
 JAd16W2W4Fz1hYdksh/658I+uqozvZcfTqlcJug5Fe/5BgfQf25sTowjAi572rHC4Zg3 +g== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ngwt58vt4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Feb 2023 14:53:36 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 313ErZne021893
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Feb 2023 14:53:35 GMT
Received: from [10.216.62.140] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Fri, 3 Feb 2023
 06:53:32 -0800
Message-ID: <3ca6d220-447e-0578-b525-3fb470be7edf@quicinc.com>
Date:   Fri, 3 Feb 2023 20:23:29 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] firmware: qcom_scm: modify
 qcom_scm_set_download_mode()
Content-Language: en-US
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1675419435-30726-1-git-send-email-quic_mojha@quicinc.com>
 <1bca9111-1ad4-ad1d-b30a-9d2fbddf9e3a@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <1bca9111-1ad4-ad1d-b30a-9d2fbddf9e3a@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WLgnEKUTRThnoYkB_PJJWtOZfxXPzLvk
X-Proofpoint-ORIG-GUID: WLgnEKUTRThnoYkB_PJJWtOZfxXPzLvk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-03_13,2023-02-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 malwarescore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302030136
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/3/2023 8:21 PM, Srinivas Kandagatla wrote:
> 
> 
> On 03/02/2023 10:17, Mukesh Ojha wrote:
>> Modify qcom_scm_set_download_mode() such that it can support
>> multiple modes. There is no functional change with this change.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes in v2:
>>    - Stop changing legacy scm id for dload mode.
>>
>>   drivers/firmware/qcom_scm.c | 15 +++++++--------
>>   include/linux/qcom_scm.h    |  5 +++++
>>   2 files changed, 12 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index cdbfe54..6245b97 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -400,7 +400,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>>   }
>>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>> +static int __qcom_scm_set_dload_mode(struct device *dev, enum 
>> qcom_download_mode mode)
>>   {
>>       struct qcom_scm_desc desc = {
>>           .svc = QCOM_SCM_SVC_BOOT,
>> @@ -410,12 +410,12 @@ static int __qcom_scm_set_dload_mode(struct 
>> device *dev, bool enable)
>>           .owner = ARM_SMCCC_OWNER_SIP,
>>       };
>> -    desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
>> +    desc.args[1] = mode ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
> 
> I think this line should be:
> 
>      desc.args[1] = mode;
> 

Should be fine..for backward compatibility as we want to avoid what is 
passed to trust zone without check and since this is legacy code, i 
would like to avoid.

-Mukesh
> 
> --srini
> 
>>       return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>>   }
>> -static void qcom_scm_set_download_mode(bool enable)
>> +static void qcom_scm_set_download_mode(enum qcom_download_mode mode)
>>   {
>>       bool avail;
>>       int ret = 0;
>> @@ -424,10 +424,9 @@ static void qcom_scm_set_download_mode(bool enable)
>>                            QCOM_SCM_SVC_BOOT,
>>                            QCOM_SCM_BOOT_SET_DLOAD_MODE);
>>       if (avail) {
>> -        ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>> +        ret = __qcom_scm_set_dload_mode(__scm->dev, mode);
>>       } else if (__scm->dload_mode_addr) {
>> -        ret = qcom_scm_io_writel(__scm->dload_mode_addr,
>> -                enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
>> +        ret = qcom_scm_io_writel(__scm->dload_mode_addr, mode);
>>       } else {
>>           dev_err(__scm->dev,
>>               "No available mechanism for setting download mode\n");
>> @@ -1410,7 +1409,7 @@ static int qcom_scm_probe(struct platform_device 
>> *pdev)
>>        * disabled below by a clean shutdown/reboot.
>>        */
>>       if (download_mode)
>> -        qcom_scm_set_download_mode(true);
>> +        qcom_scm_set_download_mode(QCOM_DOWNLOAD_FULLDUMP);
>>       return 0;
>>   }
>> @@ -1419,7 +1418,7 @@ static void qcom_scm_shutdown(struct 
>> platform_device *pdev)
>>   {
>>       /* Clean shutdown, disable download mode to allow normal restart */
>>       if (download_mode)
>> -        qcom_scm_set_download_mode(false);
>> +        qcom_scm_set_download_mode(QCOM_DOWNLOAD_NODUMP);
>>   }
>>   static const struct of_device_id qcom_scm_dt_match[] = {
>> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
>> index f833564..f9bc84e 100644
>> --- a/include/linux/qcom_scm.h
>> +++ b/include/linux/qcom_scm.h
>> @@ -14,6 +14,11 @@
>>   #define QCOM_SCM_CPU_PWR_DOWN_L2_OFF    0x1
>>   #define QCOM_SCM_HDCP_MAX_REQ_CNT    5
>> +enum qcom_download_mode {
>> +    QCOM_DOWNLOAD_NODUMP    = 0x00,
>> +    QCOM_DOWNLOAD_FULLDUMP  = 0x10,
>> +};
>> +
>>   struct qcom_scm_hdcp_req {
>>       u32 addr;
>>       u32 val;
