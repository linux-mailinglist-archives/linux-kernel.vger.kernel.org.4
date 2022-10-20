Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FD1605701
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiJTFwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiJTFwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:52:12 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF9418BE17;
        Wed, 19 Oct 2022 22:52:11 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K5LB4r026414;
        Thu, 20 Oct 2022 05:52:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=cxMTSJ1M/0+1dezEl7bVWk+2fYEaYNVoo4lIGMD+em4=;
 b=NCpd7VcpOZboTKgPH1SugRe8Gtg4eVkCp00MnDKJEHrgqRxeYLGmRy2hBp8Nqv0DxCtB
 C/AstQ1IG3EhxKsTETkSTqh/Nu96NqkK68P0K4JpSVaoWyRa7KSJhlfYVAYUdP8Hmq1q
 taOb+LlyUNRpjF7uWWEw0N9cSZi/H43OAbWLEqBnFcSYZVsL6e1AFmSGrchToIyp5kgR
 aERDGYO8360W+Llt6afPUuLRzA7/ih+hX5z48ku2D3a5Tv594F6l8S1gDwastvKspuAF
 gXaa0O4lXZ0/qiiuPRkmMzZNuFM38jaWhndiOLCJyBIT9QJC2SbZZOZMWXH6WAFchotk qg== 
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3k9yq1mh55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 05:52:10 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 29K5q9Ax022541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 05:52:09 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Wed, 19 Oct
 2022 22:52:08 -0700
Message-ID: <8807a9a6-d93d-aef5-15f4-88648a6ecbe2@quicinc.com>
Date:   Thu, 20 Oct 2022 13:52:05 +0800
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
 <792f05fc-995e-9a87-ab7d-bee03f15bc79@quicinc.com>
 <20221013173442.GA1279972@p14s> <20221013180334.GB1279972@p14s>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <20221013180334.GB1279972@p14s>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2XWe70GKDThT9CnMNlf_wqFez-JCI-fj
X-Proofpoint-GUID: 2XWe70GKDThT9CnMNlf_wqFez-JCI-fj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-20_01,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200033
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/2022 2:03 AM, Mathieu Poirier wrote:
> On Thu, Oct 13, 2022 at 11:34:42AM -0600, Mathieu Poirier wrote:
>> On Thu, Oct 13, 2022 at 09:40:09AM +0800, Aiqun(Maria) Yu wrote:
>>> Hi Mathieu,
>>>
>>> On 10/13/2022 4:43 AM, Mathieu Poirier wrote:
>>>> Please add what has changed from one version to another, either in a cover
>>>> letter or after the "Signed-off-by".  There are many examples on how to do that
>>>> on the mailing list.
>>>>
>>> Thx for the information, will take a note and benefit for next time.
>>>
>>>> On Fri, Sep 16, 2022 at 03:12:31PM +0800, Maria Yu wrote:
>>>>> RPROC_OFFLINE state indicate there is no recovery process
>>>>> is in progress and no chance to do the pm_relax.
>>>>> Because when recovering from crash, rproc->lock is held and
>>>>> state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
>>>>> and then unlock rproc->lock.
>>>>
>>>> You are correct - because the lock is held rproc->state should be set to RPROC_RUNNING
>>>> when rproc_trigger_recovery() returns.  If that is not the case then something
>>>> went wrong.
>>>>
>>>> Function rproc_stop() sets rproc->state to RPROC_OFFLINE just before returning,
>>>> so we know the remote processor was stopped.  Therefore if rproc->state is set
>>>> to RPROC_OFFLINE something went wrong in either request_firmware() or
>>>> rproc_start().  Either way the remote processor is offline and the system probably
>>>> in an unknown/unstable.  As such I don't see how calling pm_relax() can help
>>>> things along.
>>>>
>>> PROC_OFFLINE is possible that rproc_shutdown is triggered and successfully
>>> finished.
>>> Even if it is multi crash rproc_crash_handler_work contention issue, and
>>> last rproc_trigger_recovery bailed out with only
>>> rproc->state==RPROC_OFFLINE, it is still worth to do pm_relax in pair.
>>> Since the subsystem may still can be recovered with customer's next trigger
>>> of rproc_start, and we can make each error out path clean with pm resources.
>>>
>>>> I suggest spending time understanding what leads to the failure when recovering
>>>> from a crash and address that problem(s).
>>>>
>>> In current case, the customer's information is that the issue happened when
>>> rproc_shutdown is triggered at similar time. So not an issue from error out
>>> of rproc_trigger_recovery.
>>
>> That is a very important element to consider and should have been mentioned from
>> the beginning.  What I see happening is the following:
>>
>> rproc_report_crash()
>>          pm_stay_awake()
>>          queue_work() // current thread is suspended
>>
>> rproc_shutdown()
>>          rproc_stop()
>>                  rproc->state = RPROC_OFFLINE;
>>
>> rproc_crash_handler_work()
>>          if (rproc->state == RPROC_OFFLINE)
>>                  return // pm_relax() is not called
>>
>> The right way to fix this is to add a pm_relax() in rproc_shutdown() and
>> rproc_detach(), along with a very descriptive comment as to why it is needed.
> 
> Thinking about this further there are more ramifications to consider.  Please
> confirm the above scenario is what you are facing.  I will advise on how to move
> forward if that is the case.
> 
Not sure if the situation is clear or not. So resend the email again.

The above senario is what customer is facing. crash hanppened while at 
the same time shutdown is triggered.
And the device cannto goes to suspend state after that.
the subsystem can still be start normally after this.

>>
>>
>>>> Thanks,
>>>> Mathieu
>>>>
>>>>
>>>>> When the state is in RPROC_OFFLINE it means separate request
>>>>> of rproc_stop was done and no need to hold the wakeup source
>>>>> in crash handler to recover any more.
>>>>>
>>>>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>>>>> ---
>>>>>    drivers/remoteproc/remoteproc_core.c | 11 +++++++++++
>>>>>    1 file changed, 11 insertions(+)
>>>>>
>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>>>> index e5279ed9a8d7..6bc7b8b7d01e 100644
>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>> @@ -1956,6 +1956,17 @@ static void rproc_crash_handler_work(struct work_struct *work)
>>>>>    	if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>>>>>    		/* handle only the first crash detected */
>>>>>    		mutex_unlock(&rproc->lock);
>>>>> +		/*
>>>>> +		 * RPROC_OFFLINE state indicate there is no recovery process
>>>>> +		 * is in progress and no chance to have pm_relax in place.
>>>>> +		 * Because when recovering from crash, rproc->lock is held and
>>>>> +		 * state is RPROC_CRASHED -> RPROC_OFFLINE -> RPROC_RUNNING,
>>>>> +		 * and then unlock rproc->lock.
>>>>> +		 * RPROC_OFFLINE is only an intermediate state in recovery
>>>>> +		 * process.
>>>>> +		 */
>>>>> +		if (rproc->state == RPROC_OFFLINE)
>>>>> +			pm_relax(rproc->dev.parent);
>>>>>    		return;
>>>>>    	}
>>>>> -- 
>>>>> 2.7.4
>>>>>
>>>
>>>
>>> -- 
>>> Thx and BRs,
>>> Aiqun(Maria) Yu


-- 
Thx and BRs,
Aiqun(Maria) Yu
