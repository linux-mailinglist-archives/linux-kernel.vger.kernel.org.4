Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E2D633E02
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 14:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbiKVNqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 08:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbiKVNqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 08:46:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A47DA5A6C0;
        Tue, 22 Nov 2022 05:46:04 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E14051FB;
        Tue, 22 Nov 2022 05:46:10 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8EE0C3F73D;
        Tue, 22 Nov 2022 05:46:02 -0800 (PST)
Date:   Tue, 22 Nov 2022 13:46:00 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [RFC V2] ACPI: PCC: Support shared interrupt for multiple
 subspaces
Message-ID: <20221122134600.3cd44ssgamn362xz@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221122033051.15507-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221122033051.15507-1-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:30:51AM +0800, Huisong Li wrote:
> If the platform acknowledge interrupt is level triggered, then it can
> be shared by multiple subspaces provided each one has a unique platform
> interrupt ack preserve and ack set masks.
> 
> If it can be shared, then we can request the irq with IRQF_SHARED and
> IRQF_ONESHOT flags. The first one indicating it can be shared and the
> latter one to keep the interrupt disabled until the hardirq handler
> finished.
> 
> Further, since there is no way to detect if the interrupt is for a given
> channel as the interrupt ack preserve and ack set masks are for clearing
> the interrupt and not for reading the status, we need a way to identify
> if the given channel is in use and expecting the interrupt.
> 
> The way and differences of identification interrupt of each types for a
> given channel are as follows:
> 1) type0, type1 and type5: do not support shared level triggered interrupt.
> 2) type2: whether the interrupt belongs to a given channel is detected
>           based on the status field in Generic Communications Channel
>           Shared Memory Region during calling rx_callback in PCC client
>           code.
> 3) type3: use the command complete register and chan_in_use flag to control
> 4) type4: use the command complete register and need to set the
>           corresponding bit of salve subspace to 1 by default in platform.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

While I am aware that there are parts of this patch that I have suggested or
was part of the discussion, it doesn't mean you can add my sign-off without
my consent. You have introduced new things here which I haven't seen or
agreed to, so this sign-off is completely meaningless and wrong. Please
don't do that in the future.

> Signed-off-by: Robbie King <robbiek@xsightlabs.com>
> ---
>  -v2: don't use platform interrupt ack register to identify if the given
>       channel should respond interrupt.
> 
> ---
>  drivers/mailbox/pcc.c | 130 +++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 116 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 3c2bc0ca454c..674e214d64d1 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -80,6 +80,13 @@ struct pcc_chan_reg {
>  	u64 status_mask;
>  };
>  
> +enum pcc_chan_mesg_dir {
> +	PCC_ONLY_AP_TO_SCP,
> +	PCC_ONLY_SCP_TO_AP,

AP and SCP sounds very specific to your platform. The ACPI PCC spec doesn't
talk about these or use these terminology IIUC. You need to refer AP as OSPM
and SCP as platform.

> +	PCC_BIDIRECTIONAL,

Again I need to check about this in the specification.

> +	PCC_DIR_UNKNOWN,
> +};
> +
>  /**
>   * struct pcc_chan_info - PCC channel specific information
>   *
> @@ -91,6 +98,10 @@ struct pcc_chan_reg {
>   * @cmd_update: PCC register bundle for the command complete update register
>   * @error: PCC register bundle for the error status register
>   * @plat_irq: platform interrupt
> + * @plat_irq_flags: platform interrupt flags
> + * @chan_in_use: flag indicating whether the channel is in use or not when use
> + *               platform interrupt, and only use it for PCC_ONLY_AP_TO_SCP
> + * @mesg_dir: direction of message transmission supported by the channel
>   */
>  struct pcc_chan_info {
>  	struct pcc_mbox_chan chan;
> @@ -100,12 +111,17 @@ struct pcc_chan_info {
>  	struct pcc_chan_reg cmd_update;
>  	struct pcc_chan_reg error;
>  	int plat_irq;
> +	unsigned int plat_irq_flags;
> +	bool chan_in_use;
> +	u8 mesg_dir;
>  };
>  
>  #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
>  static struct pcc_chan_info *chan_info;
>  static int pcc_chan_count;
>  
> +static int pcc_send_data(struct mbox_chan *chan, void *data);
> +
>  /*
>   * PCC can be used with perf critical drivers such as CPPC
>   * So it makes sense to locally cache the virtual address and
> @@ -221,6 +237,47 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>  	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>  }
>  
> +static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
> +{
> +	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
> +		ACPI_LEVEL_SENSITIVE;
> +}
> +
> +static bool pcc_chan_need_rsp_irq(struct pcc_chan_info *pchan,
> +				  u64 cmd_complete_reg_val)
> +{
> +	bool need_rsp;
> +
> +	if (!pchan->cmd_complete.gas)
> +		return true;
> +
> +	cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
> +
> +	switch (pchan->mesg_dir) {
> +	case PCC_ONLY_AP_TO_SCP:
> +		/*
> +		 * For the communication from AP to SCP, if this channel is in
> +		 * use, command complete bit is 1 indicates that the command
> +		 * being executed has been completed.
> +		 */
> +		need_rsp = cmd_complete_reg_val != 0;
> +		break;
> +	case PCC_ONLY_SCP_TO_AP:
> +		/*
> +		 * For the communication from SCP to AP， if this channel is in
> +		 * use, command complete bit is 0 indicates that the bit has
> +		 * been cleared and AP should response the interrupt.
> +		 */
> +		need_rsp = cmd_complete_reg_val == 0;
> +		break;
> +	default:
> +		need_rsp = true;
> +		break;
> +	}
> +
> +	return need_rsp;
> +}
> +
>  /**
>   * pcc_mbox_irq - PCC mailbox interrupt handler
>   * @irq:	interrupt number
> @@ -232,37 +289,54 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  {
>  	struct pcc_chan_info *pchan;
>  	struct mbox_chan *chan = p;
> +	static irqreturn_t rc;
>  	u64 val;
>  	int ret;
>  
>  	pchan = chan->con_priv;
> +	if (pchan->mesg_dir == PCC_ONLY_AP_TO_SCP && !pchan->chan_in_use)
> +		return IRQ_NONE;
>  
>  	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>  	if (ret)
>  		return IRQ_NONE;
> +	if (!pcc_chan_need_rsp_irq(pchan, val))
> +		return IRQ_NONE;
>

Not sure the login in pcc_chan_need_rsp_irq works for type1/2 channels
or am I missing something.

> -	if (val) { /* Ensure GAS exists and value is non-zero */
> -		val &= pchan->cmd_complete.status_mask;
> -		if (!val)
> -			return IRQ_NONE;
> +	ret = pcc_chan_reg_read(&pchan->error, &val);
> +	if (ret) {
> +		rc = IRQ_NONE;
> +		goto out;
>  	}
>  
> -	ret = pcc_chan_reg_read(&pchan->error, &val);
> -	if (ret)
> -		return IRQ_NONE;
>  	val &= pchan->error.status_mask;
>  	if (val) {
>  		val &= ~pchan->error.status_mask;
>  		pcc_chan_reg_write(&pchan->error, val);
> -		return IRQ_NONE;
> +		rc = IRQ_NONE;
> +		goto out;
>  	}
>  
> -	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack))
> -		return IRQ_NONE;
> +	if (pcc_chan_reg_read_modify_write(&pchan->plat_irq_ack)) {
> +		rc = IRQ_NONE;
> +		goto out;
> +	}
>  
>  	mbox_chan_received_data(chan, NULL);
> +	/*
> +	 * For slave subspace, need to set the command complete bit and ring
> +	 * doorbell after processing message.
> +	 */
> +	if (pchan->mesg_dir == PCC_ONLY_SCP_TO_AP)
> +		pcc_send_data(chan, NULL);
> +
> +	rc = IRQ_HANDLED;
>

Also I think it is better to split the support into 2 different patches.
Add type 4 channel interrupt handling support and then handle interrupt
sharing or vice-versa. I am struggling to follow this. I would also avoid
goto in a interrupt handler unless absolutely necessary.

-- 
Regards,
Sudeep
