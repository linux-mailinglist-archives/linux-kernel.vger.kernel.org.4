Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BA0634E64
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 04:36:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbiKWDgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 22:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiKWDg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 22:36:27 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D663E6346;
        Tue, 22 Nov 2022 19:36:26 -0800 (PST)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4NH6Gg0kC5zRpMB;
        Wed, 23 Nov 2022 11:35:55 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 11:36:24 +0800
Received: from [10.67.103.231] (10.67.103.231) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 23 Nov 2022 11:36:23 +0800
Message-ID: <b6346bbf-c851-1ae2-f9bb-062583361e41@huawei.com>
Date:   Wed, 23 Nov 2022 11:36:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [RFC V2] ACPI: PCC: Support shared interrupt for multiple
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
 <20221122033051.15507-1-lihuisong@huawei.com>
 <20221122134600.3cd44ssgamn362xz@bogus>
From:   "lihuisong (C)" <lihuisong@huawei.com>
In-Reply-To: <20221122134600.3cd44ssgamn362xz@bogus>
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


在 2022/11/22 21:46, Sudeep Holla 写道:
> On Tue, Nov 22, 2022 at 11:30:51AM +0800, Huisong Li wrote:
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
>> the interrupt and not for reading the status, we need a way to identify
>> if the given channel is in use and expecting the interrupt.
>>
>> The way and differences of identification interrupt of each types for a
>> given channel are as follows:
>> 1) type0, type1 and type5: do not support shared level triggered interrupt.
>> 2) type2: whether the interrupt belongs to a given channel is detected
>>            based on the status field in Generic Communications Channel
>>            Shared Memory Region during calling rx_callback in PCC client
>>            code.
>> 3) type3: use the command complete register and chan_in_use flag to control
>> 4) type4: use the command complete register and need to set the
>>            corresponding bit of salve subspace to 1 by default in platform.
>>
>> Signed-off-by: Huisong Li <lihuisong@huawei.com>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> While I am aware that there are parts of this patch that I have suggested or
> was part of the discussion, it doesn't mean you can add my sign-off without
> my consent. You have introduced new things here which I haven't seen or
> agreed to, so this sign-off is completely meaningless and wrong. Please
> don't do that in the future.
Sorry, I got it. I'll remove this sign-off. Thank you for reminding.
>
>> Signed-off-by: Robbie King <robbiek@xsightlabs.com>
>> ---
>>   -v2: don't use platform interrupt ack register to identify if the given
>>        channel should respond interrupt.
>>
>> ---
>>   drivers/mailbox/pcc.c | 130 +++++++++++++++++++++++++++++++++++++-----
>>   1 file changed, 116 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
>> index 3c2bc0ca454c..674e214d64d1 100644
>> --- a/drivers/mailbox/pcc.c
>> +++ b/drivers/mailbox/pcc.c
>> @@ -80,6 +80,13 @@ struct pcc_chan_reg {
>>   	u64 status_mask;
>>   };
>>   
>> +enum pcc_chan_mesg_dir {
>> +	PCC_ONLY_AP_TO_SCP,
>> +	PCC_ONLY_SCP_TO_AP,
> AP and SCP sounds very specific to your platform. The ACPI PCC spec doesn't
> talk about these or use these terminology IIUC. You need to refer AP as OSPM
> and SCP as platform.
ok
>
>> +	PCC_BIDIRECTIONAL,
> Again I need to check about this in the specification.
>
>> +	PCC_DIR_UNKNOWN,
>> +};
>> +
>>   /**
>>    * struct pcc_chan_info - PCC channel specific information
>>    *
>> @@ -91,6 +98,10 @@ struct pcc_chan_reg {
>>    * @cmd_update: PCC register bundle for the command complete update register
>>    * @error: PCC register bundle for the error status register
>>    * @plat_irq: platform interrupt
>> + * @plat_irq_flags: platform interrupt flags
>> + * @chan_in_use: flag indicating whether the channel is in use or not when use
>> + *               platform interrupt, and only use it for PCC_ONLY_AP_TO_SCP
>> + * @mesg_dir: direction of message transmission supported by the channel
>>    */
>>   struct pcc_chan_info {
>>   	struct pcc_mbox_chan chan;
>> @@ -100,12 +111,17 @@ struct pcc_chan_info {
>>   	struct pcc_chan_reg cmd_update;
>>   	struct pcc_chan_reg error;
>>   	int plat_irq;
>> +	unsigned int plat_irq_flags;
>> +	bool chan_in_use;
>> +	u8 mesg_dir;
>>   };
>>   
>>   #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>>   static struct pcc_chan_info *chan_info;
>>   static int pcc_chan_count;
>>   
>> +static int pcc_send_data(struct mbox_chan *chan, void *data);
>> +
>>   /*
>>    * PCC can be used with perf critical drivers such as CPPC
>>    * So it makes sense to locally cache the virtual address and
>> @@ -221,6 +237,47 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>>   	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>>   }
>>   
>> +static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
>> +{
>> +	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
>> +		ACPI_LEVEL_SENSITIVE;
>> +}
>> +
>> +static bool pcc_chan_need_rsp_irq(struct pcc_chan_info *pchan,
>> +				  u64 cmd_complete_reg_val)
>> +{
>> +	bool need_rsp;
>> +
>> +	if (!pchan->cmd_complete.gas)
>> +		return true;
>> +
>> +	cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
>> +
>> +	switch (pchan->mesg_dir) {
>> +	case PCC_ONLY_AP_TO_SCP:
>> +		/*
>> +		 * For the communication from AP to SCP, if this channel is in
>> +		 * use, command complete bit is 1 indicates that the command
>> +		 * being executed has been completed.
>> +		 */
>> +		need_rsp = cmd_complete_reg_val != 0;
>> +		break;
>> +	case PCC_ONLY_SCP_TO_AP:
>> +		/*
>> +		 * For the communication from SCP to AP， if this channel is in
>> +		 * use, command complete bit is 0 indicates that the bit has
>> +		 * been cleared and AP should response the interrupt.
>> +		 */
>> +		need_rsp = cmd_complete_reg_val == 0;
>> +		break;
>> +	default:
>> +		need_rsp = true;
>> +		break;
>> +	}
>> +
>> +	return need_rsp;
>> +}
>> +
>>   /**
>>    * pcc_mbox_irq - PCC mailbox interrupt handler
>>    * @irq:	interrupt number
>> @@ -232,37 +289,54 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>>   {
>>   	struct pcc_chan_info *pchan;
>>   	struct mbox_chan *chan = p;
>> +	static irqreturn_t rc;
>>   	u64 val;
>>   	int ret;
>>   
>>   	pchan = chan->con_priv;
>> +	if (pchan->mesg_dir == PCC_ONLY_AP_TO_SCP && !pchan->chan_in_use)
>> +		return IRQ_NONE;
>>   
>>   	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>>   	if (ret)
>>   		return IRQ_NONE;
>> +	if (!pcc_chan_need_rsp_irq(pchan, val))
>> +		return IRQ_NONE;
>>
> Not sure the login in pcc_chan_need_rsp_irq works for type1/2 channels
> or am I missing something.
First of all, type 1 subspaces do not support a level triggered platform 
interrupt
as no method is provided to clear the interrupt. Secondly, because there 
is no
command complete register, pcc_chan_need_rsp_irq return true for type2 
channels.
and the interrupt for type2 channels have to be identified in the 
rx_callback of
PCC client. Generally, the rx_callback of PCC client based on type2 
channel should
do it. I found that some drivers already do that, such as, 
xgene-slimpro-hwmon and
xgene-slimpro-i2c.
>
>> -	if (val) { /* Ensure GAS exists and value is non-zero */
>> -		val &= pchan->cmd_complete.status_mask;
>> -		if (!val)
>> -			return IRQ_NONE;
>> +	ret = pcc_chan_reg_read(&pchan->error, &val);
>> +	if (ret) {
>> +		rc = IRQ_NONE;
>> +		goto out;
>>   	}
>>   
>> -	ret = pcc_chan_reg_read(&pchan->error, &val);
>> -	if (ret)
>> -		return IRQ_NONE;
>>   	val &= pchan->error.status_mask;
>>   	if (val) {
>>   		val &= ~pchan->error.status_mask;
>>   		pcc_chan_reg_write(&pchan->error, val);
>> -		return IRQ_NONE;
>> +		rc = IRQ_NONE;
>> +		goto out;
>>   	}
>>   
>> -	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
>> -		return IRQ_NONE;
>> +	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack)) {
>> +		rc = IRQ_NONE;
>> +		goto out;
>> +	}
>>   
>>   	mbox_chan_received_data(chan, NULL);
>> +	/*
>> +	 * For slave subspace, need to set the command complete bit and ring
>> +	 * doorbell after processing message.
>> +	 */
>> +	if (pchan->mesg_dir == PCC_ONLY_SCP_TO_AP)
>> +		pcc_send_data(chan, NULL);
>> +
>> +	rc = IRQ_HANDLED;
>>
> Also I think it is better to split the support into 2 different patches.
> Add type 4 channel interrupt handling support and then handle interrupt
> sharing or vice-versa. I am struggling to follow this. I would also avoid
> goto in a interrupt handler unless absolutely necessary.
Yes. I will split it in next version.

I'm actually struggling with what value this interrupt handler should 
return when
fail to read/write register if a channel need to respond the interrupt 
and what to
do for the chan_in_use flag. What do you think?
>
