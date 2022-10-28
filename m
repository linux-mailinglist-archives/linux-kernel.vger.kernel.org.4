Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 842D5610BAF
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiJ1H4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbiJ1Hz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:55:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00BA6F564;
        Fri, 28 Oct 2022 00:55:57 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MzFGP46znzHvYp;
        Fri, 28 Oct 2022 15:55:41 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 15:55:56 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 28 Oct 2022 15:55:55 +0800
Message-ID: <f0c408a6-cd94-4963-d4d7-e7d08b6150be@huawei.com>
Date:   Fri, 28 Oct 2022 15:55:54 +0800
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
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221027155323.7xmpjfrh7qmil6o3@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

在 2022/10/27 23:53, Sudeep Holla 写道:
> On Sun, Oct 16, 2022 at 11:40:43AM +0800, Huisong Li wrote:
>> As ACPI protocol descripted, if interrupts are level, a GSIV may
>> be shared by multiple subspaces, but each one must have unique
>> platform interrupt ack preserve and ack set masks. Therefore, need
>> set to shared interrupt for types that can distinguish interrupt
>> response channel if platform interrupt mode is level triggered.
>>
>> The distinguishing point isn't definitely command complete register.
>> Because the two status values of command complete indicate that
>> there is no interrupt in a subspace('1' means subspace is free for
>> use, and '0' means platform is processing the command). On the whole,
>> the platform interrupt ack register is more suitable for this role.
>> As ACPI protocol said, If the subspace does support interrupts, and
>> these are level, this register must be supplied. And is used to clear
>> the interrupt by using a read, modify, write sequence. This register
>> is a 'WR' register, the bit corresponding to the subspace is '1' when
>> the command is completed, or is '0'.
>>
>> Therefore, register shared interrupt for multiple subspaces if support
>> platform interrupt ack register and interrupts are level, and read the
>> ack register to ensure the idle or unfinished command channels to
>> quickly return IRQ_NONE.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/mailbox/pcc.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 3c2bc0ca454c..86c6cc44c73d 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -100,6 +100,7 @@ struct pcc_chan_info {
>>   	struct pcc_chan_reg cmd_update;
>>   	struct pcc_chan_reg error;
>>   	int plat_irq;
>> +	u8 plat_irq_trigger;
>>   };
>>   
>>   #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>> @@ -236,6 +237,15 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   	int ret;
>>   
>>   	pchan = chan->con_priv;
>> +	ret = pcc_chan_reg_read(&pchan->plat_irq_ack, &val);
>> +	if (ret)
>> +		return IRQ_NONE;
>> +	/* Irq ack GAS exist and check if this interrupt has the channel. */
>> +	if (pchan->plat_irq_ack.gas) {
>> +		val &= pchan->plat_irq_ack.set_mask;
> I am not sure if the above is correct. The spec doesn't specify that the
> set_mask can be used to detect if the interrupt belongs to this channel.
> We need clarification to use those bits.
Yes, the spec only say that the interrupt ack register is used to clear the
interrupt by using a read, modify, write sequence. But the processing
of PCC driver is as follows:
Irq Ack Register = (Irq Ack Register & Preserve_mask) | Set_mask

The set_mask is using to clear the interrupt of this channel by using OR
operation. And it should be write '1' to the corresponding bit of the 
channel
to clear interrupt. So I think it is ok to use set_mask to detect if the
interrupt belongs to this channel.
>
> This triggered be that I have a patch to address this. I will try to search
> and share, but IIRC I had a flag set when the doorbell was rung to track
> which channel or when to expect the irq. I will dig that up.
Looking forward to your patch.😁
>
>> +		if (val == 0)
>> +			return IRQ_NONE;
>> +	}
>>   
>>   	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>>   	if (ret)
>> @@ -309,10 +319,21 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>>   	spin_unlock_irqrestore(&chan->lock, flags);
>>   
>>   	if (pchan->plat_irq > 0) {
>> +		unsigned long irqflags;
>>   		int rc;
>>   
>> -		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
>> -				      MBOX_IRQ_NAME, chan);
>> +		/*
>> +		 * As ACPI protocol descripted, if interrupts are level, a GSIV
>> +		 * may be shared by multiple subspaces.
>> +		 * Therefore, register shared interrupt for multiple subspaces
>> +		 * if support platform interrupt ack register and interrupts
>> +		 * are level.
>> +		 */
>> +		irqflags = (pchan->plat_irq_ack.gas &&
>> +			    pchan->plat_irq_trigger == ACPI_LEVEL_SENSITIVE) ?
>> +			    IRQF_SHARED : 0;
> We can hide all the details in a macro or oneline function that returns if
Ack
> the interrupt can be shared. Also since this is threaded interrupt, you may
> need to keep it disabled until the thread handler is run.
'it' means 'interrupt', right? If it is, I don't understand why it needs to
be disabled. The irq handlers under this irq number are called serially when
the interrupt is triggered.
>
