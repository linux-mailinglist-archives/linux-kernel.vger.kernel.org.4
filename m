Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3181361436B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 03:50:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiKACuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 22:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKACuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 22:50:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52AAE17A88;
        Mon, 31 Oct 2022 19:50:07 -0700 (PDT)
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4N1ZCs592czpVyl;
        Tue,  1 Nov 2022 10:46:33 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 10:49:58 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 1 Nov 2022 10:49:57 +0800
Message-ID: <925f360d-e6b3-6004-de22-f39eaa86a750@huawei.com>
Date:   Tue, 1 Nov 2022 10:49:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <rafael.j.wysocki@intel.com>,
        <wanghuiqiang@huawei.com>, <huangdaode@huawei.com>,
        <tanxiaofei@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221027155323.7xmpjfrh7qmil6o3@bogus>
 <f0c408a6-cd94-4963-d4d7-e7d08b6150be@huawei.com>
 <20221031104036.bv6a7i6hxrmtpj23@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221031104036.bv6a7i6hxrmtpj23@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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


在 2022/10/31 18:40, Sudeep Holla 写道:
> On Fri, Oct 28, 2022 at 03:55:54PM +0800, lihuisong (C) wrote:
>> 在 2022/10/27 23:53, Sudeep Holla 写道:
>>> On Sun, Oct 16, 2022 at 11:40:43AM +0800, Huisong Li wrote:
>>>> As ACPI protocol descripted, if interrupts are level, a GSIV may
>>>> be shared by multiple subspaces, but each one must have unique
>>>> platform interrupt ack preserve and ack set masks. Therefore, need
>>>> set to shared interrupt for types that can distinguish interrupt
>>>> response channel if platform interrupt mode is level triggered.
>>>>
>>>> The distinguishing point isn't definitely command complete register.
>>>> Because the two status values of command complete indicate that
>>>> there is no interrupt in a subspace('1' means subspace is free for
>>>> use, and '0' means platform is processing the command). On the whole,
>>>> the platform interrupt ack register is more suitable for this role.
>>>> As ACPI protocol said, If the subspace does support interrupts, and
>>>> these are level, this register must be supplied. And is used to clear
>>>> the interrupt by using a read, modify, write sequence. This register
>>>> is a 'WR' register, the bit corresponding to the subspace is '1' when
>>>> the command is completed, or is '0'.
>>>>
>>>> Therefore, register shared interrupt for multiple subspaces if support
>>>> platform interrupt ack register and interrupts are level, and read the
>>>> ack register to ensure the idle or unfinished command channels to
>>>> quickly return IRQ_NONE.
>>>>
>>>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>>>> ---
>>>>    drivers/mailbox/pcc.c | 27 +++++++++++++++++++++++++--
>>>>    1 file changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>>>> index 3c2bc0ca454c..86c6cc44c73d 100644
>>>> --- a/drivers/mailbox/pcc.c
>>>> +++ b/drivers/mailbox/pcc.c
>>>> @@ -100,6 +100,7 @@ struct pcc_chan_info {
>>>>    	struct pcc_chan_reg cmd_update;
>>>>    	struct pcc_chan_reg error;
>>>>    	int plat_irq;
>>>> +	u8 plat_irq_trigger;
>>>>    };
>>>>    #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>>>> @@ -236,6 +237,15 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>>>    	int ret;
>>>>    	pchan = chan->con_priv;
>>>> +	ret = pcc_chan_reg_read(&pchan->plat_irq_ack, &val);
>>>> +	if (ret)
>>>> +		return IRQ_NONE;
>>>> +	/* Irq ack GAS exist and check if this interrupt has the channel. */
>>>> +	if (pchan->plat_irq_ack.gas) {
>>>> +		val &= pchan->plat_irq_ack.set_mask;
>>> I am not sure if the above is correct. The spec doesn't specify that the
>>> set_mask can be used to detect if the interrupt belongs to this channel.
>>> We need clarification to use those bits.
>> Yes, the spec only say that the interrupt ack register is used to clear the
>> interrupt by using a read, modify, write sequence. But the processing
>> of PCC driver is as follows:
>> Irq Ack Register = (Irq Ack Register & Preserve_mask) | Set_mask
>>
>> The set_mask is using to clear the interrupt of this channel by using OR
>> operation. And it should be write '1' to the corresponding bit of the
>> channel
>> to clear interrupt. So I think it is ok to use set_mask to detect if the
>> interrupt belongs to this channel.
> The problem is it can be write-only register and reads as always zero.
But it seems that it must be a read/write register according to the ACPI 
spec.
> I know a platform with such a behaviour.
Can you tell me which platform?
>
>>> This triggered be that I have a patch to address this. I will try to search
>>> and share, but IIRC I had a flag set when the doorbell was rung to track
>>> which channel or when to expect the irq. I will dig that up.
>> Looking forward to your patch.😁
> Please find below. I am not convinced yet to have extra flag for checking if
> the channel is in use. The other idea I had is to use the Generic Communications
> Channel Shared Memory Region Status Field in particular Command Complete
> field. I haven't tried it yet and hence the reason for not posting the patch.
> Let me know if the idea looks sane, so that I can try something and share
I don't think it is feasible. From the spec, the Command Complete field 
in the Generic
Communications Channel Shared Memory Region Status Field for type1/2 is 
similar to
the Command Complete Check Register in Master Slave Communications 
Channel Shared
Memory Region for type3/4.
> it. I may not have a setup handy to test and may need sometime to test though.
>
> Regards,
> Sudeep
>
> -->8
> >From 6dd9ad4f3a11dc9b97d308e70b544337c4169803 Mon Sep 17 00:00:00 2001
> From: Sudeep Holla <sudeep.holla@arm.com>
> Date: Thu, 27 Oct 2022 21:51:39 +0100
> Subject: [PATCH] ACPI: PCC: Support shared level triggered interrupt for
>   multiple subspaces
>
> If the platform acknowledge interrupt is level triggered, then it can
> be shared by multiple subspaces provided each one has a unique platform
> interrupt ack preserve and ack set masks.
>
> If it can be shared, then we can request the irq with IRQF_SHARED and
> IRQF_ONESHOT flags. The first one indicating it can be shared and the
> latter one to keep the interrupt disabled after the hardirq handler
> finished.
after --> until , right?
>
> Further, since there is no way to detect if the interrupt is for a given
> channel as the interrupt ack preserve and ack set masks are for clearing
> the interrupt and not for reading the status, we need a way to identify
> if the given channel is in use and expecting the interrupt.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/mailbox/pcc.c | 36 +++++++++++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 3c2bc0ca454c..a61528c874a2 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -91,6 +91,8 @@ struct pcc_chan_reg {
>    * @cmd_update: PCC register bundle for the command complete update register
>    * @error: PCC register bundle for the error status register
>    * @plat_irq: platform interrupt
> + * @plat_irq_flags: platform interrupt flags
> + * @chan_in_use: flag indicating whether the channel is in use or not
>    */
>   struct pcc_chan_info {
>   	struct pcc_mbox_chan chan;
> @@ -100,6 +102,8 @@ struct pcc_chan_info {
>   	struct pcc_chan_reg cmd_update;
>   	struct pcc_chan_reg error;
>   	int plat_irq;
> +	unsigned int plat_irq_flags;
> +	bool chan_in_use;
>   };
>
>   #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
> @@ -221,6 +225,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>   	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>   }
>
> +static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
> +{
> +	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
> +		ACPI_LEVEL_SENSITIVE;
> +}
> +
>   /**
>    * pcc_mbox_irq - PCC mailbox interrupt handler
>    * @irq:	interrupt number
> @@ -237,6 +247,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>
>   	pchan = chan->con_priv;
>
> +	if (!pchan->chan_in_use)
> +		return IRQ_NONE;
> +
>   	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>   	if (ret)
>   		return IRQ_NONE;
> @@ -262,6 +275,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>
>   	mbox_chan_received_data(chan, NULL);

This flag should be set to false when the Error status register 
indicates that the channel has an error.

what do you think?

>
> +	pchan->chan_in_use = false;

Maybe need add following logic?
if (pchan->plat_irq_ack.gas)
     pchan->chan_in_use = false;

> +
>   	return IRQ_HANDLED;
>   }
>
> @@ -310,9 +325,12 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>
>   	if (pchan->plat_irq > 0) {
>   		int rc;
> +		unsigned long irqflags;
>
> -		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
> -				      MBOX_IRQ_NAME, chan);
> +		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
> +			    IRQF_SHARED | IRQF_ONESHOT : 0;
> +		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
> +				      irqflags, MBOX_IRQ_NAME, chan);
>   		if (unlikely(rc)) {
>   			dev_err(dev, "failed to register PCC interrupt %d\n",
>   				pchan->plat_irq);
> @@ -374,7 +392,11 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>   	if (ret)
>   		return ret;
>
> -	return pcc_chan_reg_read_modify_write(&pchan->db);
> +	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> +	if (!ret)
> +		pchan->chan_in_use = true;
> +
> +	return ret;
>   }
>
>   static const struct mbox_chan_ops pcc_chan_ops = {
> @@ -458,6 +480,8 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
>   		return -EINVAL;
>   	}
>
> +	pchan->plat_irq_flags = pcct_ss->flags;
> +
>   	if (pcct_ss->header.type == ACPI_PCCT_TYPE_HW_REDUCED_SUBSPACE_TYPE2) {
>   		struct acpi_pcct_hw_reduced_type2 *pcct2_ss = (void *)pcct_ss;
>
> @@ -478,6 +502,12 @@ static int pcc_parse_subspace_irq(struct pcc_chan_info *pchan,
>   					"PLAT IRQ ACK");
>   	}
>
> +	if (pcc_chan_plat_irq_can_be_shared(pchan) &&
> +	    !pchan->plat_irq_ack.gas) {
> +		pr_err("PCC subspace has level IRQ with no ACK register\n");
> +		return -EINVAL;
> +	}
> +
>   	return ret;
>   }
>
> --
> 2.38.1

Hi Sudeep,

ACPI spec requested that the Irq Ack Register is a read/write register. 
 From this point,
only using this register supports for detecting if the interrupt is for 
a given channel
as my patch implemented. But If we need consider the platform whose Irq 
Ack Register is
write-only register, the chan_in_use flag in your patch looks good to me.

Regards,
Huisong
>
>
>
> .
