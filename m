Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA1F36A6D1C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjCANgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjCANgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:36:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED9B73B875;
        Wed,  1 Mar 2023 05:36:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E85492F4;
        Wed,  1 Mar 2023 05:37:18 -0800 (PST)
Received: from bogus (unknown [10.57.16.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6E8F3F587;
        Wed,  1 Mar 2023 05:36:32 -0800 (PST)
Date:   Wed, 1 Mar 2023 13:36:26 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 2/2] mailbox: pcc: Support shared interrupt for multiple
 subspaces
Message-ID: <20230301133626.gchca3fdaqijxwzq@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
 <20230216063653.1995-3-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216063653.1995-3-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 02:36:53PM +0800, Huisong Li wrote:
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
> the interrupt and not for reading the status(in case Irq Ack register
> may be write-only on some platforms), we need a way to identify if the
> given channel is in use and expecting the interrupt.
> 
> PCC type0, type1 and type5 do not support shared level triggered interrupt.
> The methods of determining whether a given channel for remaining types
> should respond to an interrupt are as follows:
>  - type2: Whether the interrupt belongs to a given channel is only
>           determined by the status field in Generic Communications Channel
>           Shared Memory Region, which is done in rx_callback of PCC client.
>  - type3: This channel checks chan_in_use flag first and then checks the
>           command complete bit(value '1' indicates that the command has
>           been completed).
>  - type4: Platform ensure that the default value of the command complete
>           bit corresponding to the type4 channel is '1'. This command
>           complete bit is '0' when receive a platform notification.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/mailbox/pcc.c | 45 ++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index ecd54f049de3..04c2d73a0473 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -92,6 +92,10 @@ struct pcc_chan_reg {
>   * @error: PCC register bundle for the error status register
>   * @plat_irq: platform interrupt
>   * @type: PCC subspace type
> + * @plat_irq_flags: platform interrupt flags
> + * @chan_in_use: flag indicating whether the channel is in use or not when use
> + *		platform interrupt, and only use it for communication from OSPM
> + *		to Platform, like type 3.

Also add a node that since only one transfer can occur at a time and the
mailbox takes care of locking, this flag needs no locking and is used just
to check if the interrupt needs handling when it is shared.

>   */
>  struct pcc_chan_info {
>  	struct pcc_mbox_chan chan;
> @@ -102,6 +106,8 @@ struct pcc_chan_info {
>  	struct pcc_chan_reg error;
>  	int plat_irq;
>  	u8 type;
> +	unsigned int plat_irq_flags;
> +	bool chan_in_use;
>  };
>  
>  #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
> @@ -225,6 +231,12 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>  	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>  }
>  
> +static bool pcc_chan_plat_irq_can_be_shared(struct pcc_chan_info *pchan)
> +{
> +	return (pchan->plat_irq_flags & ACPI_PCCT_INTERRUPT_MODE) ==
> +		ACPI_LEVEL_SENSITIVE;
> +}
> +
>  static bool pcc_chan_command_complete(struct pcc_chan_info *pchan,
>  				      u64 cmd_complete_reg_val)
>  {
> @@ -277,6 +289,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	int ret;
>  
>  	pchan = chan->con_priv;
> +	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
> +	    !pchan->chan_in_use)
> +		return IRQ_NONE;
>  
>  	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>  	if (ret)
> @@ -302,9 +317,13 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	/*
>  	 * The PCC slave subspace channel needs to set the command complete bit
>  	 * and ring doorbell after processing message.
> +	 *
> +	 * The PCC master subspace channel clears chan_in_use to free channel.
>  	 */
>  	if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
>  		pcc_send_data(chan, NULL);
> +	else if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE)
> +		pchan->chan_in_use = false;

Just wondering if this has to be for type 3 only. I am trying to avoid
conditional update of this flag, can we not do it for everything except type4 ?
(I mean just in unconditional else part)

>
>  	return IRQ_HANDLED;
>  }
> @@ -353,10 +372,13 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>  	spin_unlock_irqrestore(&chan->lock, flags);
>  
>  	if (pchan->plat_irq > 0) {
> +		unsigned long irqflags;
>  		int rc;
>  
> -		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
> -				      MBOX_IRQ_NAME, chan);
> +		irqflags = pcc_chan_plat_irq_can_be_shared(pchan) ?
> +					IRQF_SHARED | IRQF_ONESHOT : 0;
> +		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq,
> +				      irqflags, MBOX_IRQ_NAME, chan);
>  		if (unlikely(rc)) {
>  			dev_err(dev, "failed to register PCC interrupt %d\n",
>  				pchan->plat_irq);
> @@ -418,7 +440,17 @@ static int pcc_send_data(struct mbox_chan *chan, void *data)
>  	if (ret)
>  		return ret;
>  
> -	return pcc_chan_reg_read_modify_write(&pchan->db);
> +	ret = pcc_chan_reg_read_modify_write(&pchan->db);
> +	/*
> +	 * For the master subspace channel, set chan_in_use flag to true after
> +	 * ring doorbell, and clear this flag when the reply message is
> +	 * processed.
> +	 */
> +	if (!ret && pchan->type == ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE &&
> +	    pchan->plat_irq > 0)
> +		pchan->chan_in_use = true;

Ditto here(for all type except type 4?)

-- 
Regards,
Sudeep
