Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBD9C6817E3
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 18:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbjA3Rnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 12:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237855AbjA3Rnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 12:43:47 -0500
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C03412861;
        Mon, 30 Jan 2023 09:43:45 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30UDc0N1003605;
        Mon, 30 Jan 2023 17:43:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=SMg5fZWjmH7Mss820pAqb7ZUrjtwWWTAwGNzWfphj+U=;
 b=ZAZL35vHMZGVKqbsfViWruO5O8Qc73AyanoN1S4v+Cv59UKDG1CMK4x4GN6p4YgvRN9E
 +/OIBACsDAIfrDCGPPrMypyTPa+WdPBTMVPWOFataB9jW4xVQutVYWCblWKJowMIu06q
 SH519zU0HzzB53PNdVw//jk1qsIQzvS3o77u3thczrdL1qTeS19lGqIPOEOanDF/3X5+
 7U/asP8khvMyEBpw1f+WSH12qWQkTB0saPVp/PRWgrZIfBFmSQqFjgU58A8KqNxQhSkX
 lZ2KTnrex+wZnFUZhYl7bxWIH3PDP6iPyjrryMhussSVcR31heEPtBEU1vzEkg94Rokg kw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ncsdpvg7t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 17:43:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 30UHhbAM005333
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 Jan 2023 17:43:37 GMT
Received: from [10.47.234.156] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Mon, 30 Jan
 2023 09:43:37 -0800
Subject: Re: [PATCH] remoteproc: sysfs: fix race while updating recovery flag
To:     Mukesh Ojha <quic_mojha@quicinc.com>, <andersson@kernel.org>,
        <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20230129225106.10606-1-quic_satyap@quicinc.com>
 <d9708f4b-e533-e400-acbf-3d8e816f242e@quicinc.com>
From:   Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
Message-ID: <941b8600-9f7c-b646-9f8a-c30a2a332e37@quicinc.com>
Date:   Mon, 30 Jan 2023 09:43:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d9708f4b-e533-e400-acbf-3d8e816f242e@quicinc.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NwER8QJqwMNSBBQHF_SmcEdJJl8CW-KI
X-Proofpoint-ORIG-GUID: NwER8QJqwMNSBBQHF_SmcEdJJl8CW-KI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-30_16,2023-01-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0 mlxlogscore=914
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301300171
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/23 12:03 AM, Mukesh Ojha wrote:
>
> On 1/30/2023 4:21 AM, Satya Durga Srinivasu Prabhala wrote:
>> When multiple clients try to update the recovery flag, it is
>
> Multiple user-space clients ?
>
Yes, on SMP systems, it is possible that there can be multiple user 
space clients (can simply be fuzzing kind of scripts) which could be 
updating the recovery flag.
>> possible that, race condition would lead to undesired results
>> as updates to recovery flag isn't protected by any mechanism
>> today. To avoid such issues, take remoteproc mutex lock before
>> updating recovery flag and release the lock once done.
>
> But your patch also adds locks for the case which does not update
> recovery flag..
Yes, was trying to cover entire function, can be restricted to only when 
recovery flag is being updated as well.
>>
>> Signed-off-by: Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>
>> ---
>>   drivers/remoteproc/remoteproc_sysfs.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c 
>> b/drivers/remoteproc/remoteproc_sysfs.c
>> index 8c7ea8922638..ec37176e1589 100644
>> --- a/drivers/remoteproc/remoteproc_sysfs.c
>> +++ b/drivers/remoteproc/remoteproc_sysfs.c
>> @@ -48,16 +48,21 @@ static ssize_t recovery_store(struct device *dev,
>>   {
>>       struct rproc *rproc = to_rproc(dev);
>>
>> +    mutex_lock(&rproc->lock);
>>       if (sysfs_streq(buf, "enabled")) {
>>           /* change the flag and begin the recovery process if needed */
>>           rproc->recovery_disabled = false;
>> +        mutex_unlock(&rproc->lock);
>>           rproc_trigger_recovery(rproc);
>>       } else if (sysfs_streq(buf, "disabled")) {
>>           rproc->recovery_disabled = true;
>> +        mutex_unlock(&rproc->lock);
>>       } else if (sysfs_streq(buf, "recover")) {
>>           /* begin the recovery process without changing the flag */
>> +        mutex_unlock(&rproc->lock);
>
> is it really needed for this case?
As mentioned above, was trying to cover entire function. Not really 
needed in this case as such.
>
>>           rproc_trigger_recovery(rproc);
>>       } else {
>> +        mutex_unlock(&rproc->lock);
>
> same here..
>
>>           return -EINVAL;
>>       }
>>
>
> Do you also need to add lock for rproc_recovery_write in
> drivers/remoteproc/remoteproc_debugfs.c ?
>
Thanks, yes. Debug FS needs to be updated too.
> -Mukesh

