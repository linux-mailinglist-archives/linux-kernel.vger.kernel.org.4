Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20A886A7967
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 03:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbjCBCRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 21:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCBCRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 21:17:13 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D76C22A22;
        Wed,  1 Mar 2023 18:17:11 -0800 (PST)
Received: from kwepemm600004.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PRvn00kjdznWDY;
        Thu,  2 Mar 2023 10:14:28 +0800 (CST)
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 10:17:07 +0800
Message-ID: <2a165476-2e96-17b1-a50b-c8749462e8a1@huawei.com>
Date:   Thu, 2 Mar 2023 10:17:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/2] mailbox: pcc: Support shared interrupt for multiple
 subspaces
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <robbiek@xsightlabs.com>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <rafael@kernel.org>,
        <rafael.j.wysocki@intel.com>, <wanghuiqiang@huawei.com>,
        <zhangzekun11@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaofei@huawei.com>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <wangkefeng.wang@huawei.com>,
        <huangdaode@huawei.com>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
 <20230216063653.1995-3-lihuisong@huawei.com>
 <20230301133626.gchca3fdaqijxwzq@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20230301133626.gchca3fdaqijxwzq@bogus>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.103.231]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2023/3/1 21:36, Sudeep Holla 写道:
> On Thu, Feb 16, 2023 at 02:36:53PM +0800, Huisong Li wrote:
>> If the platform acknowledge interrupt is level triggered, then it can
>> be shared by multiple subspaces provided each one has a unique platform
>> interrupt ack preserve and ack set masks.
>>
>> If it can be shared, then we can request the irq with IRQF_SHARED and
>> IRQF_ONESHOT flags. The first one indicating it can be shared and the
>> latter one to keep the interrupt disabled until the hardirq handler
>> finished.
>>
>> Further, since there is no way to detect if the interrupt is for a given
>> channel as the interrupt ack preserve and ack set masks are for clearing
>> the interrupt and not for reading the status(in case Irq Ack register
>> may be write-only on some platforms), we need a way to identify if the
>> given channel is in use and expecting the interrupt.
>>
>> PCC type0, type1 and type5 do not support shared level triggered interrupt.
>> The methods of determining whether a given channel for remaining types
>> should respond to an interrupt are as follows:
>>   - type2: Whether the interrupt belongs to a given channel is only
>>            determined by the status field in Generic Communications Channel
>>            Shared Memory Region, which is done in rx_callback of PCC client.
>>   - type3: This channel checks chan_in_use flag first and then checks the
>>            command complete bit(value '1' indicates that the command has
>>            been completed).
>>   - type4: Platform ensure that the default value of the command complete
>>            bit corresponding to the type4 channel is '1'. This command
>>            complete bit is '0' when receive a platform notification.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> ---
>>   drivers/mailbox/pcc.c | 45 ++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 42 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index ecd54f049de3..04c2d73a0473 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -92,6 +92,10 @@ struct pcc_chan_reg {
>>    * @error: PCC register bundle for the error status register
>>    * @plat_irq: platform interrupt
>>    * @type: PCC subspace type
>> + * @plat_irq_flags: platform interrupt flags
>> + * @chan_in_use: flag indicating whether the channel is in use or not when use
>> + *		platform interrupt, and only use it for communication from OSPM
>> + *		to Platform, like type 3.
> Also add a node that since only one transfer can occur at a time and the
> mailbox takes care of locking, this flag needs no locking and is used just
> to check if the interrupt needs handling when it is shared.
Add a per-channel lock. Is this your mean?
>
>>    */
>>   struct pcc_chan_info {
>>   	struct pcc_mbox_chan chan;
>> @@ -102,6 +106,8 @@ struct pcc_chan_info {
>>   	struct pcc_chan_reg error;
>>   	int plat_irq;
>>   	u8 type;
>> +	unsigned int plat_irq_flags;
>> +	bool chan_in_use;
>>   };
>>   
>>   #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>> @@ -225,6 +231,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>>   	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>>   }
>>   
>> +static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
>> +{
>> +	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
>> +		ACPI_LEVEL_SENSITIVE;
>> +}
>> +
>>   static bool pcc_chan_command_complete(struct pcc_chan_info *pchan,
>>   				      u64 cmd_complete_reg_val)
>>   {
>> @@ -277,6 +289,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   	int ret;
>>   
>>   	pchan = chan->con_priv;
>> +	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
>> +	    !pchan->chan_in_use)
>> +		return IRQ_NONE;
>>   
>>   	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>>   	if (ret)
>> @@ -302,9 +317,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   	/*
>>   	 * The PCC slave subspace channel needs to set the command complete bit
>>   	 * and ring doorbell after processing message.
>> +	 *
>> +	 * The PCC master subspace channel clears chan_in_use to free channel.
>>   	 */
>>   	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>>   		pcc_send_data(chan, NULL);
>> +	else if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE)
>> +		pchan->chan_in_use = false;
> Just wondering if this has to be for type 3 only. I am trying to avoid
> conditional update of this flag, can we not do it for everything except type4 ?
> (I mean just in unconditional else part)
But type2 do not need this flag.
For types no need this flag, it is always hard to understand and 
redundant design.
If no this condition, we don't know what is the impact on the furture 
types.
>
>>   	return IRQ_HANDLED;
>>   }
>> @@ -353,10 +372,13 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>>   	spin_unlock_irqrestore(&chan->lock, flags);
>>   
>>   	if (pchan->plat_irq > 0) {
>> +		unsigned long irqflags;
>>   		int rc;
>>   
>> -		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
>> -				      MBOX_IRQ_NAME, chan);
>> +		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
>> +					IRQF_SHARED | IRQF_ONESHOT : 0;
>> +		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
>> +				      irqflags, MBOX_IRQ_NAME, chan);
>>   		if (unlikely(rc)) {
>>   			dev_err(dev, "failed to register PCC interrupt %d\n",
>>   				pchan->plat_irq);
>> @@ -418,7 +440,17 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>>   	if (ret)
>>   		return ret;
>>   
>> -	return pcc_chan_reg_read_modify_write(&pchan->db);
>> +	ret = pcc_chan_reg_read_modify_write(&pchan->db);
>> +	/*
>> +	 * For the master subspace channel, set chan_in_use flag to true after
>> +	 * ring doorbell, and clear this flag when the reply message is
>> +	 * processed.
>> +	 */
>> +	if (!ret && pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
>> +	    pchan->plat_irq > 0)
>> +		pchan->chan_in_use = true;
> Ditto here(for all type except type 4?)
Above is my concern.
>
