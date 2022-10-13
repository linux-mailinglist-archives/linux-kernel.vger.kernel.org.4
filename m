Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515945FD2C4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 03:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiJMBke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 21:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiJMBk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 21:40:29 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C561B11878E;
        Wed, 12 Oct 2022 18:40:18 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29CNqHg7012270;
        Thu, 13 Oct 2022 01:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=/I5VSY/VfJ1Zt2lCBPDZy5GNtmylRuOdCc30WZBMSkU=;
 b=AVpb1x8lIqGs/OSqflHO52jszMdaDZL33gXSSn53oXEc3ZJnY9FH9mGDogW2lWlUBmly
 QRJ+okZckDsSif/wDiTZ1RKdYgkDZdzAq2RyeqBMw/OJv39oMZxVLuIcoWAp9IGTWb1m
 /eIJMUPizo1Lww7bZYUHGaNKfgQAg6cMrKMZzOYj3uII1BiVRe6bNjExf0uR8JCl4TBp
 7wmZCwwyLJ2vAGDEgv3nzNsozV+LPHUz3j+yEt6JvmmI3t6hRR+62uBzM7WRH3hGi4Os
 nfjntBdNjnh/qGcoykJHdFwss09HvUjUmzku7lv07e74PDJKQ8/VVlrjy+80Ar8BqRDV 9w== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k643h0tbg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 01:40:15 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29D1eEaF025474
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Oct 2022 01:40:14 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 12 Oct
 2022 18:40:12 -0700
Message-ID: <792f05fc-995e-9a87-ab7d-bee03f15bc79@quicinc.com>
Date:   Thu, 13 Oct 2022 09:40:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v4] remoteproc: core: do pm relax when in RPROC_OFFLINE
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
References: <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
 <1663312351-28476-1-git-send-email-quic_aiquny@quicinc.com>
 <20221012204344.GA1178915@p14s>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20221012204344.GA1178915@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Up-brqwYjGyTH4VqJznilO8Jv6gUfk3I
X-Proofpoint-ORIG-GUID: Up-brqwYjGyTH4VqJznilO8Jv6gUfk3I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-12_12,2022-10-12_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 clxscore=1011 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210130008
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 10/13/2022 4:43 AM, Mathieu Poirier wrote:
> Please add what has changed from one version to another, either in a cover
> letter or after the "Signed-off-by".  There are many examples on how to do that
> on the mailing list.
> 
Thx for the information, will take a note and benefit for next time.

> On Fri, Sep 16, 2022 at 03:12:31PM +0800, Maria Yu wrote:
>> RPROC_OFFLINE state indicate there is no recovery process
>> is in progress and no chance to do the pm_relax.
>> Because when recovering from crash, rproc->lock is held and
>> state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
>> and then unlock rproc->lock.
> 
> You are correct - because the lock is held rproc->state should be set to RPROC_RUNNING
> when rproc_trigger_recovery() returns.  If that is not the case then something
> went wrong.
> 
> Function rproc_stop() sets rproc->state to RPROC_OFFLINE just before returning,
> so we know the remote processor was stopped.  Therefore if rproc->state is set
> to RPROC_OFFLINE something went wrong in either request_firmware() or
> rproc_start().  Either way the remote processor is offline and the system probably
> in an unknown/unstable.  As such I don't see how calling pm_relax() can help
> things along.
> 
PROC_OFFLINE is possible that rproc_shutdown is triggered and 
successfully finished.
Even if it is multi crash rproc_crash_handler_work contention issue, and 
last rproc_trigger_recovery bailed out with only 
rproc->state==RPROC_OFFLINE, it is still worth to do pm_relax in pair.
Since the subsystem may still can be recovered with customer's next 
trigger of rproc_start, and we can make each error out path clean with 
pm resources.

> I suggest spending time understanding what leads to the failure when recovering
> from a crash and address that problem(s).
> 
In current case, the customer's information is that the issue happened 
when rproc_shutdown is triggered at similar time. So not an issue from 
error out of rproc_trigger_recovery.
> Thanks,
> Mathieu
> 
> 
>> When the state is in RPROC_OFFLINE it means separate request
>> of rproc_stop was done and no need to hold the wakeup source
>> in crash handler to recover any more.
>>
>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>> ---
>>   drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>> index e5279ed9a8d7..6bc7b8b7d01e 100644
>> --- a/drivers/remoteproc/remoteproc_core.c
>> +++ b/drivers/remoteproc/remoteproc_core.c
>> @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct work_struct *work)
>>   	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>>   		/* handle only the first crash detected */
>>   		mutex_unlock(&rproc->lock);
>> +		/*
>> +		 * RPROC_OFFLINE state indicate there is no recovery process
>> +		 * is in progress and no chance to have pm_relax in place.
>> +		 * Because when recovering from crash, rproc->lock is held and
>> +		 * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
>> +		 * and then unlock rproc->lock.
>> +		 * RPROC_OFFLINE is only an intermediate state in recovery
>> +		 * process.
>> +		 */
>> +		if (rproc->state == RPROC_OFFLINE)
>> +			pm_relax(rproc->dev.parent);
>>   		return;
>>   	}
>>   
>> -- 
>> 2.7.4
>>


-- 
Thx and BRs,
Aiqun(Maria) Yu
