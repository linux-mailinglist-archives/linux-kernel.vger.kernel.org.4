Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5FC4732943
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 09:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241866AbjFPHvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 03:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbjFPHvI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 03:51:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025AC1FC3;
        Fri, 16 Jun 2023 00:51:03 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35G6Caw4029463;
        Fri, 16 Jun 2023 09:50:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=urauJacVUNG8muiUJtZCcVbTigmq8+/WZEuTP+wxZgY=;
 b=6eMf+wUEuj+XX/rTmLMoh/OyZlzek60fq9B3hoafxgLxYJf7EsC1Hv2CtiYxrYUk+AE2
 ZruXp6JHnRRrVSsXXATinvYNJjfVIvH39g3684afmJfAsj63Gih9a9gox+e2F384pUh4
 lE3hYokFSNEPDMHYzdszm6Lh2hTw0oIqImrvTzvUjG8xM8Wx3uHqHbg84FnkBfc5rtns
 hmeL9U/EvmAU6uWhMsC2RZnRzpW93IhRXQa55RMWF6dpqmbbqp43T1cBOIdet/sE32gF
 4GjIibbj5mgSCX6YMGeQNThWhgWD75SBKwCQJ6Qa3t/iXknTl/7654DdHzXoIAy4bP6i JA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r8j92gjrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 16 Jun 2023 09:50:31 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E94010002A;
        Fri, 16 Jun 2023 09:50:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 36590217B9C;
        Fri, 16 Jun 2023 09:50:26 +0200 (CEST)
Received: from [10.201.21.9] (10.201.21.9) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 16 Jun
 2023 09:50:25 +0200
Message-ID: <5db6f583-d906-d314-42ef-02f837b40310@foss.st.com>
Date:   Fri, 16 Jun 2023 09:50:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V7 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Sarannya S <quic_sarannya@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
References: <1682160127-18103-1-git-send-email-quic_sarannya@quicinc.com>
 <1682160127-18103-2-git-send-email-quic_sarannya@quicinc.com>
 <20230614155453.dywcrntfjddxojfv@ripper>
 <6e51d6d8-cd3a-b0f2-c044-6282749aae89@foss.st.com>
 <20230615145039.GA3256591@hu-bjorande-lv.qualcomm.com>
 <4d89950d-0376-e355-c70b-d054776e83d4@foss.st.com>
 <20230615164507.mu7fd22poamjth7p@ripper>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230615164507.mu7fd22poamjth7p@ripper>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.9]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-16_04,2023-06-15_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/15/23 18:45, Bjorn Andersson wrote:
> On Thu, Jun 15, 2023 at 06:19:37PM +0200, Arnaud POULIQUEN wrote:
>>
>>
>> On 6/15/23 16:50, Bjorn Andersson wrote:
>>> On Thu, Jun 15, 2023 at 11:01:14AM +0200, Arnaud POULIQUEN wrote:
>>>>
>>>>
>>>> On 6/14/23 17:54, Bjorn Andersson wrote:
>>>>> On Sat, Apr 22, 2023 at 04:12:05PM +0530, Sarannya S wrote:
>>>>>> From: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>>>>>
>>>>>> Some transports like Glink support the state notifications between
>>>>>> clients using flow control signals similar to serial protocol signals.
>>>>>> Local glink client drivers can send and receive flow control status
>>>>>> to glink clients running on remote processors.
>>>>>>
>>>>>> Add APIs to support sending and receiving of flow control status by
>>>>>> rpmsg clients.
>>>>>>
>>>>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>>>>> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
>>>>>> ---
>>>>>>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>>>>>>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>>>>>>  include/linux/rpmsg.h          | 15 +++++++++++++++
>>>>>>  3 files changed, 38 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>>>>> index a2207c0..e8bbe05 100644
>>>>>> --- a/drivers/rpmsg/rpmsg_core.c
>>>>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>>>>> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>>>>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>>>>  
>>>>>>  /**
>>>>>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>>>>>> + * @ept:	the rpmsg endpoint
>>>>>> + * @enable:	pause/resume incoming data flow	
>>>>>
>>>>> As shown in the discussion, it's still not clear what true/false means.
>>>>> Also, let's try to clarify that it's a request for the other side to do
>>>>> something:
>>>>>
>>>>> * rpmsg_set_flow_control() - request remote to pause/resume transmission
>>>>> * ...
>>>>> * @enable: flow restricted
>>>>> * ...
>>>>>
>>>>>
>>>>> PS. There's a stray space at the end of the line.
>>>>
>>>> The notion of flow restricted seems to me also ambiguous. It does
>>>> not specify if the stream is limited in term of bandwidth or stopped.
>>>>
>>>> What about using XON/XOFF as specified in software flow control[1]
>>>>
>>>> XOFF	Pause transmission
>>>> XON	Resume transmission
>>>>
>>>> or simply pause/resume definitions
>>>>
>>>
>>> I agree, that's still ambiguous.
>>>
>>> I was concerned about expressing it such that the reader would assume
>>> that calling this means there will be no more data coming, but there
>>> might be things in the queues etc. Expressing it in terms of the state
>>> of transmission is clearer.
>>>
>>>
>>> /*
>>>  * rpmsg_set_flow_control() - request remote to pause/resume transmission
>>>  ...
>>>  * @enable: Pause transmission
>>>  ...
>>>  */
>>>
>>> Does that sound okay and clear to you?
>>
>> Much better! I still have a nitpicking point :)
>> What about replacing @enable variable by @pause to align the variable with the
>> usage?
>>  /*
>>   * rpmsg_set_flow_control() - request remote to pause/resume transmission
>>   ...
>>   * @pause: set to 1 to pause transmission, to 0 to resume the transmission
> 
> It's a boolean, so I think with your name change suggestion, together
> with the function description, it should be clear enough what the two
> states (true/false) means.
> 
> * @pause: Pause transmission

Ok for me

Thanks,
Arnaud

> 
> Thanks,
> Bjorn
