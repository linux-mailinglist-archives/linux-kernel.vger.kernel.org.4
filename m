Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35EFE65955C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 07:20:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbiL3GT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 01:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiL3GTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 01:19:54 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731D1FAEB;
        Thu, 29 Dec 2022 22:19:53 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BU4lvbx025255;
        Fri, 30 Dec 2022 06:19:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=KqCkvHOhMEfSD3RZUYdVYhxpV07nENfdENVeyWy5fHc=;
 b=Mnm1yei3UVY2H9yl6I4og8oTFKSvCLWteW1WfD586tEqJoWTE/mg03dDv7sdpTDsirZt
 oJJp2waIbL9TyXoo4BOvXLej98rSi8IA+k7naR+VptzJbMHfeUAAR9cMTDJWvQCLRgmg
 RLTrmhLX9vgQA1ylmrJ1QtqqntG0AyBwn5Aa28Lo6GzrJypPlTX4Xc9K5SVDTDxWCWzR
 sZVdHFL9bJXSYhbsLbp3s4+4TYYfL7EAgschNrn1o0mgj18ImKQXBJCc+EEB6mKYj5HR
 Ubs1dSAyg8nkQkatMTrBCmcF6TbwOcpuDpwBXZxwQQl7f5xOwFPHUoePkhB/+yp0+3o6 JA== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3mratp4j0p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 06:19:42 +0000
Received: from nasanex01a.na.qualcomm.com (corens_vlan604_snip.qualcomm.com [10.53.140.1])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 2BU6Jf96019867
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Dec 2022 06:19:41 GMT
Received: from [10.253.38.225] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 29 Dec
 2022 22:19:38 -0800
Message-ID: <060c0d72-6ef8-9ae6-076d-40e4fb3b3c88@quicinc.com>
Date:   Fri, 30 Dec 2022 14:18:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v4] bus: mhi: host: Disable preemption while processing
 data events
Content-Language: en-US
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>
CC:     <loic.poulain@linaro.org>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <mrana@quicinc.com>
References: <1669023264-84125-1-git-send-email-quic_qianyu@quicinc.com>
 <35752702-1ae2-126f-9237-a2f24c3bc3de@quicinc.com>
 <20221228163526.GF30143@thinkpad>
From:   Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20221228163526.GF30143@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hylXXQk2IcPBG1ye4oEJHCJIIGTgHAwZ
X-Proofpoint-GUID: hylXXQk2IcPBG1ye4oEJHCJIIGTgHAwZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-30_03,2022-12-29_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2212300054
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/29/2022 12:35 AM, Manivannan Sadhasivam wrote:
> On Mon, Nov 21, 2022 at 10:48:54PM -0700, Jeffrey Hugo wrote:
>> On 11/21/2022 2:34 AM, Qiang Yu wrote:
>>> If data processing of an event is scheduled out because core
>>> is busy handling multiple irqs, this can starve the processing
>>> of MHI M0 state change event on another core. Fix this issue by
>>> disabling irq on the core processing data events.
>>>
>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>> I've been pondering this off and on since it's been proposed.
>>
>> This solution will break the described deadlock, but I don't like it.
>>
>> What I really don't like is that this is selfish.  We already preempt
>> anything else on the CPU that isn't a hard IRQ because we are using a
>> tasklet (which is deprecated, see include/linux/interrupt.h).  Now we are
>> going to essentially preempt IRQs as well by preventing them from being
>> serviced.  So, now the CPU is essentially dedicated to processing MHI
>> events.  It seems selfish to say that MHI is the most important thing on a
>> particular CPU.
>>
>> This can have a huge effect on system behavior.  If say the ssh IRQ is
>> assigned to the same CPU, and we block that CPU long enough, then it will
>> appear to the user as if the ssh connection has frozen.  I've witnessed this
>> occur with other drivers.
>>
>> How long can we block the CPU?  According to the code, pretty much for an
>> unlimited amount of time.  If the tasklet is processing
>> mhi_process_data_event_ring(), then we can process U32_MAX events before
>> throttling (which might as well be unlimited).  If the tasklet is processing
>> mhi_process_ctrl_ev_ring() then there is no throttling.
>>
>> I'm thinking it would be better of the IRQ handling was refactored to use
>> threaded interrupts.  The thread is an actual process, so it could move to
>> another CPU.  It is also FIFO priority, so it basically will preempt
>> everything but hard IRQs and soft IRQs (eg tasklets).  The downside of a
>> tasklet is that it is bound to the scheduling CPU, which in our case is the
>> CPU servicing the IRQ, and more than a few systems tend to load the majority
>> of the IRQs to CPU0.
>>
> This sounds like a plausible solution.
>
>> I'm not going to go refactor the IRQ code at this time.  This looks like an
>> issue that is actually observed based on how it was reported, so it likely
>> should be addressed.  I'm not happy with this solution, but I don't have an
>> alternative at this time.
>>
>> Mani, up to you if you want to pick this up.  I'm not nack'ing it.
>> Technically I've reviewed it, but I'd say I'm "on the fence" about if this
>> really should be accepted.  I can't say there is a flaw in the logic, but I
>> don't feel good about this.
>>
> I do agree with you.
>
> Qiang, can you please look into Jeff's suggestion on fixing this performance
> issue?
>
> Thanks,
> Mani

Jeff's suggestion is reasonable. I have no reasons to insist that the 
patch should be accepted.

Thanks,

Qiang

>>> ---
>>> v3->v4: modify the comment
>>> v2->v3: modify the comment
>>> v1->v2: add comments about why we disable local irq
>>>
>>>    drivers/bus/mhi/host/main.c | 10 ++++++++--
>>>    1 file changed, 8 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/bus/mhi/host/main.c b/drivers/bus/mhi/host/main.c
>>> index f3aef77a..6c804c3 100644
>>> --- a/drivers/bus/mhi/host/main.c
>>> +++ b/drivers/bus/mhi/host/main.c
>>> @@ -1029,11 +1029,17 @@ void mhi_ev_task(unsigned long data)
>>>    {
>>>    	struct mhi_event *mhi_event = (struct mhi_event *)data;
>>>    	struct mhi_controller *mhi_cntrl = mhi_event->mhi_cntrl;
>>> +	unsigned long flags;
>>> +	/*
>>> +	 * When multiple IRQs arrive, the tasklet will be scheduled out with event ring lock
>>> +	 * acquired, causing other high priority events like M0 state transition getting stuck
>>> +	 * while trying to acquire the same event ring lock. Thus, let's disable local IRQs here.
>>> +	 */
>>> +	spin_lock_irqsave(&mhi_event->lock, flags);
>>>    	/* process all pending events */
>>> -	spin_lock_bh(&mhi_event->lock);
>>>    	mhi_event->process_event(mhi_cntrl, mhi_event, U32_MAX);
>>> -	spin_unlock_bh(&mhi_event->lock);
>>> +	spin_unlock_irqrestore(&mhi_event->lock, flags);
>>>    }
>>>    void mhi_ctrl_ev_task(unsigned long data)
