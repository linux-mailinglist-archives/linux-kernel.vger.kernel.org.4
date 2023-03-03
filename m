Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78ADE6A920B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 08:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjCCHzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 02:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjCCHzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 02:55:15 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC894393D;
        Thu,  2 Mar 2023 23:54:58 -0800 (PST)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32353UIO026473;
        Fri, 3 Mar 2023 07:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=OkHo+I+k+xVNMMYxG4UsUUvFkbNhuyIIhfLSBgA3Wio=;
 b=CBnzeFULU4WtKbHORBWyUksJGKxXzlmpgzmwztLpGCWTVuHiC+XAcjFVEFJIJpvswl6/
 VvD5TlYmdt/0rR9MmzzJm/0/QES3LoSc/sgphfMPAB2ZAWbbs8nsgb0u8c4oV8TClwx+
 GCGnBfYdYkP5AgoGBackQlWck+biNnYDqQzQXsf0DjnfhJEY5mGc3OQQ0cSa2SYnWil8
 ye0hrPvtjh764i3sz7p9aTq393za/lZ9/r9BZcK/7+gjpryBNTfI9Yke/oADkpMauDX5
 A0aomZBSWn/PGiMWfwm1G0uR95psoBsr4VwRXz5NIyZOr0EFLqoHeZon+yMQ9p7gqSeB zA== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3p2rbgb84e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 03 Mar 2023 07:54:55 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3237st05010983
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 07:54:55 GMT
Received: from [10.216.34.86] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 2 Mar 2023
 23:54:52 -0800
Message-ID: <85157e8e-750e-f994-ae51-3e58656b55bf@quicinc.com>
Date:   Fri, 3 Mar 2023 13:24:48 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 2/4] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1677664555-30191-1-git-send-email-quic_mojha@quicinc.com>
 <1677664555-30191-3-git-send-email-quic_mojha@quicinc.com>
 <c59cbc7b-baa8-ec57-ec33-0455edf34c29@linaro.org>
From:   Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <c59cbc7b-baa8-ec57-ec33-0455edf34c29@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Smctl5AJNc2MFueBwqjsJiJCsRMwAjBo
X-Proofpoint-ORIG-GUID: Smctl5AJNc2MFueBwqjsJiJCsRMwAjBo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-03_01,2023-03-02_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 spamscore=0 malwarescore=0 adultscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303030069
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/1/2023 4:09 PM, Dmitry Baryshkov wrote:
> On 01/03/2023 11:55, Mukesh Ojha wrote:
>> CrashDump collection is based on the DLOAD bit of TCSR register.
>> To retain other bits, we read the register and modify only the
>> DLOAD bit as the other bits have their own significance.
>>
>> Originally-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>> Changes in v2:
>>   - Addressed comment made by Bjorn.
>>   - Added download mask from patch 3 to this.
>>
>>   drivers/firmware/qcom_scm.c | 17 +++++++++++++++--
>>   1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index 51eb853..c9f1fad 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -27,6 +27,8 @@ module_param(download_mode, bool, 0);
>>   #define SCM_HAS_IFACE_CLK    BIT(1)
>>   #define SCM_HAS_BUS_CLK        BIT(2)
>> +#define QCOM_DOWNLOAD_MODE_MASK 0x30
>> +
>>   struct qcom_scm {
>>       struct device *dev;
>>       struct clk *core_clk;
>> @@ -419,6 +421,7 @@ static void qcom_scm_set_download_mode(bool enable)
>>   {
>>       bool avail;
>>       int ret = 0;
>> +    u32 val;
>>       avail = __qcom_scm_is_call_available(__scm->dev,
>>                            QCOM_SCM_SVC_BOOT,
>> @@ -426,8 +429,18 @@ static void qcom_scm_set_download_mode(bool enable)
>>       if (avail) {
>>           ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
>>       } else if (__scm->dload_mode_addr) {
>> -        ret = qcom_scm_io_writel(__scm->dload_mode_addr,
>> -                enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
>> +        ret = qcom_scm_io_readl(__scm->dload_mode_addr, &val);
>> +        if (ret) {
>> +            dev_err(__scm->dev,
>> +                "failed to read dload mode address value: %d\n", ret);
>> +            return;
>> +        }
>> +
>> +        val &= ~QCOM_DOWNLOAD_MODE_MASK;
>> +        if (enable)
>> +            val |= QCOM_SCM_BOOT_SET_DLOAD_MODE;
>> +
>> +        ret = qcom_scm_io_writel(__scm->dload_mode_addr, val);
> 
> Any locking for this RMW?

While you ask this, i thought about who all are the user of this 
function. Only, multiple calls to module param callback where
this race could be possible.

I am doubtful, if introducing global mutex lock will be allowed to 
handle this. Any comments.


-Mukesh
> 
>>       } else {
>>           dev_err(__scm->dev,
>>               "No available mechanism for setting download mode\n");
> 
