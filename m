Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DAC68CC78
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229686AbjBGCMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBGCMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:12:33 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CDC126C1;
        Mon,  6 Feb 2023 18:12:31 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3171GB0B012041;
        Tue, 7 Feb 2023 02:12:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=XTTWQtZoYmVoGEp5Gmczx1y7XWAsgOIeUt0psqpyjrQ=;
 b=h/faE0wUzozkVgslJmdm1jtotUCEJRRsyRl0y26MUJOC5BReC8DzJLCxx6OjOe6Yb2Lb
 rXFKrYV5KhV2cm8uVugCpYyb/qvBPWYceUu1ELKGzJ+ym7nuNaAIEF3/nr++LE4OObMv
 DIsUgNFH71RcqfxYioy+z8N2LJO8QF8BcU2aaiflnU5d0YhuF78gNLgIEVeoywtqy52z
 1nlLXYI6coWhl4FDgbQ5eW2+o5CsdeuMtDNX29XAwWlnKbqs7xb2J8G4GnT6QpeAzVYk
 ijvOXHU8dUu9ZU80vOCHj6wDBSeDaNTObn0EKX1byDtfbZTeKXOxSzGLehEUAYfjzZoB HA== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3nhg4rn1jc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Feb 2023 02:12:28 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3172CSRB017817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Feb 2023 02:12:28 GMT
Received: from [10.47.234.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 6 Feb 2023
 18:12:27 -0800
Subject: Re: [PATCH v2] remoteproc: sysfs/debugfs: fix race while updating
 recovery flag
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230201054609.14575-1-quic_satyap@quicinc.com>
 <22bcf613-5c0f-3043-f8ad-41bf45c5dc07@quicinc.com>
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Message-ID: <94e7154d-8c87-47e3-1f57-b84eb7522db6@quicinc.com>
Date:   Mon, 6 Feb 2023 18:12:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <22bcf613-5c0f-3043-f8ad-41bf45c5dc07@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4oVKKycegy2UlsRmvPcfl5fJjPRQqRss
X-Proofpoint-GUID: 4oVKKycegy2UlsRmvPcfl5fJjPRQqRss
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-06_07,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302070018
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/1/23 4:05 AM, Mukesh Ojha wrote:
>
>
> On 2/1/2023 11:16 AM, Satya Durga Srinivasu Prabhala wrote:
>> When multiple clients try to update the recovery flag, it is
>> possible that, race condition would lead to undesired results
>> as updates to recovery flag isn't protected by any mechanism
>> today. To avoid such issues, take remoteproc mutex lock before
>> updating recovery flag and release the lock once done.
>>
>> Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
>
> LGTM.
>
> Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

Thanks Mukesh.

Hi Bjorn,

Can you help cross check?

Best,
Satya

>
> -Mukesh
>> ---
>> v1 -> v2:
>> - addressed comments from Mukesh Ojha
>>    1. take & release lock only while updating recovery flag
>>    2. update debugfs
>>
>>   drivers/remoteproc/remoteproc_debugfs.c | 4 ++++
>>   drivers/remoteproc/remoteproc_sysfs.c   | 4 ++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_debugfs.c 
>> b/drivers/remoteproc/remoteproc_debugfs.c
>> index b86c1d09c70c..2c44d375024e 100644
>> --- a/drivers/remoteproc/remoteproc_debugfs.c
>> +++ b/drivers/remoteproc/remoteproc_debugfs.c
>> @@ -226,10 +226,14 @@ rproc_recovery_write(struct file *filp, const 
>> char __user *user_buf,
>>
>>       if (!strncmp(buf, "enabled", count)) {
>>           /* change the flag and begin the recovery process if needed */
>> +        mutex_lock(&rproc->lock);
>>           rproc->recovery_disabled = false;
>> +        mutex_unlock(&rproc->lock);
>>           rproc_trigger_recovery(rproc);
>>       } else if (!strncmp(buf, "disabled", count)) {
>> +        mutex_lock(&rproc->lock);
>>           rproc->recovery_disabled = true;
>> +        mutex_unlock(&rproc->lock);
>>       } else if (!strncmp(buf, "recover", count)) {
>>           /* begin the recovery process without changing the flag */
>>           rproc_trigger_recovery(rproc);
>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c 
>> b/drivers/remoteproc/remoteproc_sysfs.c
>> index 8c7ea8922638..628e0de9a132 100644
>> --- a/drivers/remoteproc/remoteproc_sysfs.c
>> +++ b/drivers/remoteproc/remoteproc_sysfs.c
>> @@ -50,10 +50,14 @@ static ssize_t recovery_store(struct device *dev,
>>
>>       if (sysfs_streq(buf, "enabled")) {
>>           /* change the flag and begin the recovery process if needed */
>> +        mutex_lock(&rproc->lock);
>>           rproc->recovery_disabled = false;
>> +        mutex_unlock(&rproc->lock);
>>           rproc_trigger_recovery(rproc);
>>       } else if (sysfs_streq(buf, "disabled")) {
>> +        mutex_lock(&rproc->lock);
>>           rproc->recovery_disabled = true;
>> +        mutex_unlock(&rproc->lock);
>>       } else if (sysfs_streq(buf, "recover")) {
>>           /* begin the recovery process without changing the flag */
>>           rproc_trigger_recovery(rproc);

