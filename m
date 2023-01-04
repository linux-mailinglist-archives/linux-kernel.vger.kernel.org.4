Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE46065DC28
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjADScO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjADSbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:31:38 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91DF617888;
        Wed,  4 Jan 2023 10:31:33 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304FunMW032302;
        Wed, 4 Jan 2023 19:31:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=14pl7Fz3fhnDge/t0scKzfK+3uQtBNPe+M/i05b4Dws=;
 b=EFt7i5q6RrEWANthyrktQsdXBhEDZ5RdV1DeLQPAbr0vSTZswOLj4HsE3ecgTOYJScIz
 p4FijExQSAg3G8igwxcFoEG5io9S06HAULGyMQC8T4RiwXuHkRBkhUBFyTi6en7cDt39
 6ciW0ZAL5mgu8QSkDtW9BBeezmKThNPpMaMe1ZjhI4jiGIzQYz/vu7/zGX99c0XPlQQi
 etKbHlRvSS3M28N6HH7QHCjrSGZRxr0dfU3ZE8p6xwjXorBbpu6x/6QaFws9O/SX7JyK
 rJgI8TIhfBdvKZOzSBIL/fRlRcu/8dQv9S4OpeVrwwO8kAIHjuKT9uMUT5I/PPOJJugP lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mtcupw6v5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 04 Jan 2023 19:31:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EAB4110002A;
        Wed,  4 Jan 2023 19:31:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E29DA22441B;
        Wed,  4 Jan 2023 19:31:11 +0100 (CET)
Received: from [10.201.20.180] (10.201.20.180) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Wed, 4 Jan
 2023 19:31:11 +0100
Message-ID: <c88d5b70-4d3b-eb5b-a349-5c137134a45e@foss.st.com>
Date:   Wed, 4 Jan 2023 19:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V4 1/3] rpmsg: core: Add signal API support
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
CC:     Sarannya S <quic_sarannya@quicinc.com>,
        <quic_bjorande@quicinc.com>, <swboyd@chromium.org>,
        <quic_clew@quicinc.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        Deepak Kumar Singh <quic_deesin@quicinc.com>
References: <1670418258-11502-1-git-send-email-quic_sarannya@quicinc.com>
 <1670418258-11502-2-git-send-email-quic_sarannya@quicinc.com>
 <6ba10328-bc48-c953-49e7-29e079fb6406@foss.st.com>
 <20221227153252.ufenietw5wgsk7kj@builder.lan>
 <1cbcd57c-ba6d-390f-a28c-fa651d1d7262@foss.st.com>
 <20230104163000.hi6zehbbxpubeqfe@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Organization: STMicroelectronics
In-Reply-To: <20230104163000.hi6zehbbxpubeqfe@builder.lan>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.180]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/4/23 17:30, Bjorn Andersson wrote:
> On Tue, Jan 03, 2023 at 02:50:13PM +0100, Arnaud POULIQUEN wrote:
>> Hello,
>>
>> On 12/27/22 16:32, Bjorn Andersson wrote:
>>> On Wed, Dec 21, 2022 at 05:12:22PM +0100, Arnaud POULIQUEN wrote:
>>>> Hello,
>>>>
>>>> On 12/7/22 14:04, Sarannya S wrote:
>>>>> Some transports like Glink support the state notifications between
>>>>> clients using flow control signals similar to serial protocol signals.
>>>>> Local glink client drivers can send and receive flow control status
>>>>> to glink clients running on remote processors.
>>>>>
>>>>> Add APIs to support sending and receiving of flow control status by
>>>>> rpmsg clients.
>>>>>
>>>>> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
>>>>> Signed-off-by: Sarannya S <quic_sarannya@quicinc.com>
>>>>> ---
>>>>>  drivers/rpmsg/rpmsg_core.c     | 21 +++++++++++++++++++++
>>>>>  drivers/rpmsg/rpmsg_internal.h |  2 ++
>>>>>  include/linux/rpmsg.h          | 15 +++++++++++++++
>>>>>  3 files changed, 38 insertions(+)
>>>>>
>>>>> diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
>>>>> index d6dde00e..77aeba0 100644
>>>>> --- a/drivers/rpmsg/rpmsg_core.c
>>>>> +++ b/drivers/rpmsg/rpmsg_core.c
>>>>> @@ -331,6 +331,25 @@ int rpmsg_trysend_offchannel(struct rpmsg_endpoint *ept, u32 src, u32 dst,
>>>>>  EXPORT_SYMBOL(rpmsg_trysend_offchannel);
>>>>>  
>>>>>  /**
>>>>> + * rpmsg_set_flow_control() - sets/clears serial flow control signals
>>>>> + * @ept:	the rpmsg endpoint
>>>>> + * @enable:	enable or disable serial flow control
>>>>
>>>> What does it mean "enable and disable serial flow control"?
>>>> Do you speak about the flow control feature or the data flow itself?
>>>>
>>>
>>> Good point, the purpose of the boolean is to "request throttling of the
>>> incoming data flow".
>>>
>>>> I guess it is the activation/deactivation of the data stream
>>>> regarding Bjorn's comment in V1:
>>>>
>>>> "I therefore asked Deepak to change it so the rpmsg api would contain a
>>>> single "pause incoming data"/"resume incoming data" - given that this is
>>>> a wish that we've seen in a number of discussions."
>>>>
>>>> For me this is the software flow control:
>>>> https://en.wikipedia.org/wiki/Software_flow_control
>>>>
>>>> I would suggest not limiting the control only to activation/deactivation but to
>>>> offer more flexibility in terms of services. replace the boolean by a bitmap
>>>> would allow to extend it later.
>>>>
>>>> For instance by introducing 2 definitions:
>>>>
>>>> /* RPMSG pause transmission request:
>>>>  * sent to the remote endpoint to request to suspend its transmission */
>>>>  */
>>>> #define RPMSG_FC_PT_REQ  (1 << 0)
>>>
>>> enable = true
>>>
>>>>
>>>> /* RPMSG resume transmission request
>>>>  * sent to the remote endpoint to allow to resume its transmission
>>>>  */
>>>> #define RPMSG_FC_RT_REQ  (1 << 1)
>>>>
>>>
>>> enable = false
>>
>> Do you mean that it should be only one definition? If yes you are right
>> only one definition is sufficient for the pause/resume
>>
> 
> Yes, I envision this being used for cases such as rpmsg_char being able
> to send a "I already have 1MB of data in my sk_buf_head queue, please
> don't send me any more data for now".
> 
>>>
>>>> Then we could add (in a next step) some other flow controls such as
>>>> /* RPMSG pause transmission information
>>>>  * Sent to the remote endpoint to inform that no more data will be sent
>>>>  * until the reception of RPMSG_FC_RT_INFO
>>>>  */
>>>> #define RPMSG_FC_PT_INFO  (1 << 16)
>>>> #define RPMSG_FC_RT_INFO  (1 << 16)
>>>>
>>>
>>> I presume you're looking for a usage pattern where the client would send
>>> this to the remote and then the flow control mechanism would be used for
>>> the remote end to request more data.
>>>
>>> I find Deepak's (adjusted) proposal to be generic and to the point, and
>>> your proposal builds unnecessary "flexibility" into this same mechanism.
>>>
>>> If you have a rpmsg protocol where the client is expected to sit
>>> waiting, and upon a request from the remote side send another piece of
>>> data, why don't you just build this into the application protocol?  That
>>> way your application would work over both transports with and without
>>> flow control...
>>>
>>>
>>> Perhaps I'm misunderstanding what you're asking for?
>>
>> With the RPMSG_FC_PT_INFO example I had in mind the possibility to implement PM
>> runtime.
>>
> 
> Which device/part are you going to runtime PM suspend using this?

I have not concrete device yet to show. For now I more in the step of figuring
out what would be the use of flow control. I can see 2 use cases:
- management of the congestion in reception
- management of the transmission pause/resume

This implementation implements only the congestion or mix both in one.
And both seem to me flow control that have to be implemented at service level.

For instance, if we have a request-answer communication from the main processor
to the remoteproc processor with some delay constraint. The management of the
pause resume transmission ( on PM or system suspend) can be used to inform the
coprocessor that the main processor suspend the communication and will not send
request. This information can be used by the coprocessor for some power
management optimizations.


> 
>> But my main point here is to allow to extend the flow control in future.
>> or instance an comment in OpenAMP PR part [1] was:
>>
>> "ON/OFF info isn't enough in the advanced flow control since the additional info
>> is required(e.g. the slide window, round trip delay, congestion etc..)."
>>
>> [1]https://github.com/OpenAMP/open-amp/pull/394#discussion_r878363627
> 
> We don't have a way to apply back pressure today, so I have a hard time
> imagining the use cases and the implementation of such advanced flow
> control.
> 
> Reading your proposal again, I don't think that's flow control, that's a
> mechanism for requesting notifications. Either way, the mechanism seems
> orthogonal to rpmsg_set_flow_control() - even if they were implemented
> using the same mechanism in the underlying transport.
> 
>>
>> Using a @enable boolean would imply to create new ops if someone want to extend
>> the flow control (to keep legacy compatibility). Using a bit map for the
>> parameter could ease a future extension.
>>
> 
> This is a kernel-internal API, a boolean "flow or now flow" is
> sufficient for what Qualcomm is asking and the ioctl is the only new
> external mechanism introduced.
> 
> I have no concerns extending or altering this as the use cases appear.

Hoping that extension does not impact the IPC implemented for the signaling.

For the virtio rpmsg, (with an implementation based on a rpmsg channel or rpmsg
header flags) it will probably be more sustainable to not use boolean. But as
you mention it should be addressed in rpmsg_virtio backend.

So let's forget my suggestion.

Thanks,
Arnaud


> 
> Regards,
> Bjorn
