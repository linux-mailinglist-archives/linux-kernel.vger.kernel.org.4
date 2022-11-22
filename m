Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF11463340E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 04:42:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbiKVDmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 22:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbiKVDmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 22:42:14 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF727CE8;
        Mon, 21 Nov 2022 19:42:12 -0800 (PST)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NGVMr3vBLzqSrS;
        Tue, 22 Nov 2022 11:38:16 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:42:10 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 22 Nov 2022 11:42:09 +0800
Message-ID: <d7593559-060e-e8e6-5746-6dc63c487027@huawei.com>
Date:   Tue, 22 Nov 2022 11:42:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
To:     Robbie King <robbiek@xsightlabs.com>,
        Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <huangdaode@huawei.com>,
        <tanxiaofei@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221027155323.7xmpjfrh7qmil6o3@bogus>
 <f0c408a6-cd94-4963-d4d7-e7d08b6150be@huawei.com>
 <20221031104036.bv6a7i6hxrmtpj23@bogus>
 <925f360d-e6b3-6004-de22-f39eaa86a750@huawei.com>
 <d0b178d3-a036-399f-fb0c-bb7f8c52995c@xsightlabs.com>
 <20221104151530.44sms3fnarqnvvsl@bogus>
 <ca35058d-1f40-3f85-9e2d-bfb29c8625cb@xsightlabs.com>
 <09e0a108-9f22-a9a0-2145-a81936745887@huawei.com>
 <3b28294a-1e2b-140a-8462-5014ba893cc5@xsightlabs.com>
 <1156ef89-20a4-7e7e-6205-c68e21a9bb36@huawei.com>
 <a7119a55-9e7a-b27f-4969-2c6bef764011@xsightlabs.com>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <a7119a55-9e7a-b27f-4969-2c6bef764011@xsightlabs.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/11/22 0:59, Robbie King 写道:
> On 11/19/2022 2:32 AM, lihuisong (C) wrote:
>> 在 2022/11/18 2:09, Robbie King 写道:
>>> On 11/7/2022 1:24 AM, lihuisong (C) wrote:
>>>> 在 2022/11/4 23:39, Robbie King 写道:
>>>>> On 11/4/2022 11:15 AM, Sudeep Holla wrote:
>>>>>> On Fri, Nov 04, 2022 at 11:04:22AM -0400, Robbie King wrote:
>>>>>>> Hello Huisong, your raising of the shared interrupt issue is very timely, I
>>>>>>> am working to implement "Extended PCC subspaces (types 3 and 4)" using PCC
>>>>>>> on the ARM RDN2 reference platform as a proof of concept, and encountered
>>>>>>> this issue as well.  FWIW, I am currently testing using Sudeep's patch with
>>>>>>> the "chan_in_use" flag removed, and so far have not encountered any issues.
>>>>>>>
>>>>>> Interesting, do you mean the patch I post in this thread but without the
>>>>>> whole chan_in_use flag ?
>>>>> That's right, diff I'm running with is attached to end of message.
>>>> Hello Robbie, In multiple subspaces scenario, there is a problem
>>>> that OS doesn't know which channel should respond to the interrupt
>>>> if no this chan_in_use flag. If you have not not encountered any
>>>> issues in this case, it may be related to your register settings.
>>>>
>>> Hi Huisong, apologies, I see your point now concerning multiple subspaces.
>>>
>>> I have started stress testing where I continuously generate both requests
>>> and notifications as quickly as possible, and unfortunately found an issue
>>> even with the original chan_in_use patch.  I first had to modify the patch
>>> to get the type 4 channel notifications to function at all, essentially
>>> ignoring the chan_in_use flag for that channel.  With that change, I still
>>> hit my original stress issue, where the pcc_mbox_irq function did not
>>> correctly ignore an interrupt for the type 3 channel.
>>>
>>> The issue occurs when a request from AP to SCP over the type 3 channel is
>>> outstanding, and simultaneously the SCP initiates a notification over the
>>> type 4 channel.  Since the two channels share an interrupt, both handlers
>>> are invoked.
>>>
>>> I've tried to draw out the state of the channel status "free" bits along
>>> with the AP and SCP function calls involved.
>>>
>>> type 3
>>> ------
>>>
>>>   (1)pcc.c:pcc_send_data()
>>>         |                         (5) mailbox.c:mbox_chan_receive_data()
>>> _______v                      (4)pcc.c:pcc_mbox_irq()
>>> free   \_________________________________________
>>>
>>>                                ^
>>> type 4                        ^
>>> ------                        ^
>>> _____________________
>>> free                 \_____________________________
>>>                       ^        ^
>>>                       |        |
>>> (2)mod_smt.c:smt_transmit()   |
>>>                                |
>>> (3)mod_mhu2.c:raise_interrupt()
>>>
>>> The sequence of events are:
>>>
>>> 1) OS initiates request to SCP by clearing FREE in status and ringing SCP doorbell
>>> 2) SCP initiates notification by filling shared memory and clearing FREE in status
>>> 3) SCP notifies OS by ringing OS doorbell
>>> 4) OS first invokes interrupt handler for type 3 channel
>>>
>>>     At this step, the issue is that "val" from reading status (i.e. CommandCompleteCheck)
>>>     is zero (SCP has not responded yet) so the code below falls through and continues
>>>     to processes the interrupt as if the request has been acknowledged by the SCP.
>>>
>>>      if (val) { /* Ensure GAS exists and value is non-zero */
>>>          val &= pchan->cmd_complete.status_mask;
>>>          if (!val)
>>>              return IRQ_NONE;
>>>      }
>>>
>>>     The chan_in_use flag does not address this because the channel is indeed in use.
>>>
>>> 5) ACPI:PCC client kernel module is incorrectly notified that response data is
>>>     available
>> Indeed, chan_in_use flag is invalid for type4.
> Thinking about this some more, I believe there is a need for the chan_in_use flag
> for the type 4 channels.  If there are multiple SCP to AP channels sharing an
> interrupt, and the PCC client code chooses to acknowledge the transfer from
> process level (i.e. call mbox_send outside of the mbox_chan_received_data callback),
> then I believe a window exists where the callback could be invoked twice for the
> same SCP to AP channel.  I've attached a diff.
I don't understand your concern. type4 need to set command complete bit and
ring doorbell after processing mbox_chan_received_data callback. I think it
is ok without chan_in_use flag.

Here's what I think:
For type4, set the command complete bit to 1 by default in platform.
Clear the command complete when do platform notification.
If a given channel detects the command complete bit is 0, it should respond
the interrupt, otherwise there is nothing to do.

I put all points we discussed into the RFC V2 patch. Let's go to V2 to 
discuss.
>
>>> I added the following fix (applied on top of Sudeep's original patch for clarity)
>>> for the issue above which solved the stress test issue.  I've changed the interrupt
>>> handler to explicitly verify that the status value matches the mask for type 3
>>> interrupts before acknowledging them.  Conversely, a type 4 channel verifies that
>>> the status value does *not* match the mask, since in this case we are functioning
>>> as the recipient, not the initiator.
>>>
>>> One concern is that since this fundamentally changes handling of the channel status,
>>> that existing platforms could be impacted.
>> [snip]
>>> +    /*
>>> +     * When we control data flow on the channel, we expect
>>> +     * to see the mask bit(s) set by the remote to indicate
>>> +     * the presence of a valid response.  When we do not
>>> +     * control the flow (i.e. type 4) the opposite is true.
>>> +     */
>>> +    if (pchan->is_controller)
>>> +        cmp = pchan->cmd_complete.status_mask;
>>> +    else
>>> +        cmp = 0;
>>> +
>>> +    val &= pchan->cmd_complete.status_mask;
>>> +    if (cmp != val)
>>> +        return IRQ_NONE;
>>>
>> We don't have to use the pchan->cmd_complete.status_mask as above.
>>
>> For the communication from AP to SCP, if this channel is in use, command
>> complete bit is 1 indicates that the command being executed has been
>> completed.
>> For the communication from SCP to AP, if this channel is in use, command
>> complete bit is 0 indicates that the bit has been cleared and OS should
>> response the interrupt.
>>
>> So you concern should be gone if we do as following approach:
>> "
>> val &= pchan->cmd_complete.status_mask;
>> need_rsp_irq = pchan->is_controller ? val != 0 : val == 0;
>> if (!need_rsp_irq)
>>      return IRQ_NONE
>> "
>>
>> This may depend on the default value of the command complete register
>> for each channel(must be 1, means that the channel is free for use).
>> It is ok for type3 because of chan_in_use flag, while something needs
>> to do in platform or OS for type4.
>>> ret = pcc_chan_reg_read(&pchan->error, &val);
>>>       if (ret)
>>> @@ -704,6 +717,9 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>>>           pcc_mbox_channels[i].con_priv = pchan;
>>>           pchan->chan.mchan = &pcc_mbox_channels[i];
>>>
>>> +        pchan->is_controller =
>>> +            (pcct_entry->type != ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE);
>>> +
>> This definition does not apply to all types because type1 and type2
>> support bidirectional communication.
>>
>>> if (pcct_entry->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE &&
>>>               !pcc_mbox_ctrl->txdone_irq) {
>>>               pr_err("Plaform Interrupt flag must be set to 1");
>>>
>> I put all points we discussed into the following modifcation.
>> Robbie, can you try it again for type 4 and see what else needs to be
>> done?
>>
>> Regards,
>> Huisong
>>
> Thanks Huisong, I ran my current stress test scenario against your diff
> with no issues (I did have to manually merge due to a tabs to spaces issue
> which may be totally on my end, still investigating).
>
> Here is the proposed change to support chan_in_use for type 4 (which I've
> also successfully tested with).  I think I have solved the tabs to spaces
> issue for my sent messages, apologies if that's not the case.
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 057e00ee83c8..d4fcc913a9a8 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -292,7 +292,7 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   	int ret;
>
>   	pchan = chan->con_priv;
> -	if (pchan->mesg_dir == PCC_ONLY_AP_TO_SCP && !pchan->chan_in_use)
> +	if (!pchan->chan_in_use)
>   		return IRQ_NONE;
>
>   	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
> @@ -320,8 +320,16 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>   		goto out;
>   	}
>
> +	/*
> +	 * Clearing in_use before RX callback allows calls to mbox_send
> +	 * (which sets in_use) within the callback so SCP to AP channels
> +	 * can acknowledge transfer within IRQ context
> +	 */
> +	if (pchan->cmd_complete.gas)
> +		pchan->chan_in_use = false;
> +
>   	mbox_chan_received_data(chan, NULL);
> -	rc = IRQ_HANDLED;
> +	return IRQ_HANDLED;
>
>   out:
>   	if (pchan->cmd_complete.gas)
> @@ -772,6 +780,8 @@ static int pcc_mbox_probe(struct platform_device *pdev)
>   			goto err;
>   		}
>   		pcc_set_chan_mesg_dir(pchan, pcct_entry->type);
> +		if (pchan->mesg_dir == PCC_ONLY_SCP_TO_AP)
> +			pchan->chan_in_use = true;
>
>   		if (pcc_mbox_ctrl->txdone_irq) {
>   			rc = pcc_parse_subspace_irq(pchan, pcct_entry);
>
> .
