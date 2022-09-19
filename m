Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E5F5BC0D4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 02:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiISAyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 20:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiISAyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 20:54:22 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ED412ACC;
        Sun, 18 Sep 2022 17:54:20 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J0M14b017491;
        Mon, 19 Sep 2022 00:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=vnV6IMZLKBro/DqI17szjIhnq2iyQsbNqY61XHaGap4=;
 b=ZC9Bf46Zr+kvH+A7098S6gD8CkhwV+h0W/yIoBl+1vRGMv1zOFxa/v73+cxcOqzHXgOs
 IXKocFHu+r5fMsuuvf7l7LSnNyCZk7UqfVnFX7XBCmGiXV/V+jJQTe0XNjSvTbW/ds0s
 ucfciaPe8j2Zzck5nYeI1ka2c2JN/81swo1p6MJh3rcaqLzBCc1XBBg+5PiQa5BUcM6r
 j6By0EiEWKO2i5qUhFeUykjFyjdEPAuRqeByl8sPtKF2qk9AM7dtJ9RnIqW4kmk5fuCJ
 p56dGq93iVY62K9BgFo6bDv/Pn3jVevDHlYciMZQkoSNi04q9DkomAVvC3fTdqavsgMl Mw== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3jn6by2h6t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 00:54:19 +0000
Received: from nasanex01a.na.qualcomm.com ([10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28J0sIEw020496
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Sep 2022 00:54:18 GMT
Received: from [10.239.133.73] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Sun, 18 Sep
 2022 17:54:17 -0700
Message-ID: <b19919ce-83f2-cb8e-7c85-3a24209f9a8c@quicinc.com>
Date:   Mon, 19 Sep 2022 08:54:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v1] remoteproc: core: do pm relax when not first crash
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_clew@quicinc.com>
References: <1662712413-38233-1-git-send-email-quic_aiquny@quicinc.com>
 <20220909192357.GA319190@p14s>
 <128dc161-8949-1146-bf8b-310aa33c06a8@quicinc.com>
 <CANLsYkx0fEyezax_bk50ORGb7vPY3sBegKJcfAmmu366MrQkYw@mail.gmail.com>
From:   "Aiqun(Maria) Yu" <quic_aiquny@quicinc.com>
In-Reply-To: <CANLsYkx0fEyezax_bk50ORGb7vPY3sBegKJcfAmmu366MrQkYw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J3x-ThrMqrMSCwJ2nrDwrY3tiiFEJXl6
X-Proofpoint-GUID: J3x-ThrMqrMSCwJ2nrDwrY3tiiFEJXl6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-18_11,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190004
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2022 1:05 AM, Mathieu Poirier wrote:
> On Tue, 13 Sept 2022 at 05:03, Aiqun(Maria) Yu <quic_aiquny@quicinc.com> wrote:
>>
>> Hi Mathieu,
>>
>> pm_awake and pm_relax needed to be used as a pair. There is chance that
>> pm_relax is not being called, and make the device always in cannot
>> suspend state.
>>
>> On 9/10/2022 3:23 AM, Mathieu Poirier wrote:
>>> Hi Maria,
>>>
>>> On Fri, Sep 09, 2022 at 04:33:33PM +0800, Maria Yu wrote:
>>>> Even if it is not first crash, need to relax the pm
>>>> wakelock otherwise the device will stay awake.
>>>>
>>>
>>> The goal is exactly to keep the device awake...
>>>
>>>> Signed-off-by: Maria Yu <quic_aiquny@quicinc.com>
>>>> ---
>>>>    drivers/remoteproc/remoteproc_core.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>>> index e5279ed9a8d7..30078043e939 100644
>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>> @@ -1956,6 +1956,7 @@ static void rproc_crash_handler_work(struct work_struct *work)
>>>>       if (rproc->state == RPROC_CRASHED || rproc->state == RPROC_OFFLINE) {
>>>>               /* handle only the first crash detected */
>>>>               mutex_unlock(&rproc->lock);
>>>> +            pm_relax(rproc->dev.parent);
>>>
>>> If we are here it means that rproc_crash_handler_work() has already been called
>>> _and_ that a recovery is in process.  When the first crash handler completes
>>> pm_relax() will be called and the device will go to sleep as expected.
>> If the rproc->state cannot be changed to running state, the device will
>> always be awake from this return.
>> Also APROC_OFFLINE state can be given in other path like an shutdown
>> request is issued.
>>
>> While this patch is not considering carefully as well, I think I need to
>> upload a new patchset with an ordered workqueue to make each work have
>> each pm_relax before return.
>> what do you think?
> 
> I was travelling this week and as such did not have the time to
> follow-up with this thread, something I will do next week.
> 
Thx for follow up. I have new patchset posted on this thread.
After reconsideration, extra action can be done only for RPROC_OFFLINE 
state. Pls check the newest v4 patchset on this thread.
>>
>>>
>>> Thanks,
>>> Mathieu
>>>
>>>>               return;
>>>>       }
>>>>
>>>> --
>>>> 2.7.4
>>>>
>>
>>
>> --
>> Thx and BRs,
>> Aiqun(Maria) Yu


-- 
Thx and BRs,
Aiqun(Maria) Yu
