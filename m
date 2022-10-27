Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0B260FC69
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbiJ0Pxe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235509AbiJ0Px2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:53:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D147B192987;
        Thu, 27 Oct 2022 08:53:27 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8093023A;
        Thu, 27 Oct 2022 08:53:33 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 085D63F7B4;
        Thu, 27 Oct 2022 08:53:25 -0700 (PDT)
Date:   Thu, 27 Oct 2022 16:53:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>, wanghuiqiang@huawei.com,
        huangdaode@huawei.com, tanxiaofei@huawei.com
Subject: Re: [RFC] ACPI: PCC: Support shared interrupt for multiple subspaces
Message-ID: <20221027155323.7xmpjfrh7qmil6o3@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016034043.52227-1-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 11:40:43AM +0800, Huisong Li wrote:
> As ACPI protocol descripted, if interrupts are level, a GSIV may
> be shared by multiple subspaces, but each one must have unique
> platform interrupt ack preserve and ack set masks. Therefore, need
> set to shared interrupt for types that can distinguish interrupt
> response channel if platform interrupt mode is level triggered.
> 
> The distinguishing point isn't definitely command complete register.
> Because the two status values of command complete indicate that
> there is no interrupt in a subspace('1' means subspace is free for
> use, and '0' means platform is processing the command). On the whole,
> the platform interrupt ack register is more suitable for this role.
> As ACPI protocol said, If the subspace does support interrupts, and
> these are level, this register must be supplied. And is used to clear
> the interrupt by using a read, modify, write sequence. This register
> is a 'WR' register, the bit corresponding to the subspace is '1' when
> the command is completed, or is '0'.
> 
> Therefore, register shared interrupt for multiple subspaces if support
> platform interrupt ack register and interrupts are level, and read the
> ack register to ensure the idle or unfinished command channels to
> quickly return IRQ_NONE.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/mailbox/pcc.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 3c2bc0ca454c..86c6cc44c73d 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -100,6 +100,7 @@ struct pcc_chan_info {
>  	struct pcc_chan_reg cmd_update;
>  	struct pcc_chan_reg error;
>  	int plat_irq;
> +	u8 plat_irq_trigger;
>  };
>  
>  #define to_pcc_chan_info(c) container_of(c, struct pcc_chan_info, chan)
> @@ -236,6 +237,15 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	int ret;
>  
>  	pchan = chan->con_priv;
> +	ret = pcc_chan_reg_read(&pchan->plat_irq_ack, &val);
> +	if (ret)
> +		return IRQ_NONE;
> +	/* Irq ack GAS exist and check if this interrupt has the channel. */
> +	if (pchan->plat_irq_ack.gas) {
> +		val &= pchan->plat_irq_ack.set_mask;

I am not sure if the above is correct. The spec doesn't specify that the
set_mask can be used to detect if the interrupt belongs to this channel.
We need clarification to use those bits.

This triggered be that I have a patch to address this. I will try to search
and share, but IIRC I had a flag set when the doorbell was rung to track
which channel or when to expect the irq. I will dig that up.

> +		if (val == 0)
> +			return IRQ_NONE;
> +	}
>  
>  	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>  	if (ret)
> @@ -309,10 +319,21 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>  	spin_unlock_irqrestore(&chan->lock, flags);
>  
>  	if (pchan->plat_irq > 0) {
> +		unsigned long irqflags;
>  		int rc;
>  
> -		rc = devm_request_irq(dev, pchan->plat_irq, pcc_mbox_irq, 0,
> -				      MBOX_IRQ_NAME, chan);
> +		/*
> +		 * As ACPI protocol descripted, if interrupts are level, a GSIV
> +		 * may be shared by multiple subspaces.
> +		 * Therefore, register shared interrupt for multiple subspaces
> +		 * if support platform interrupt ack register and interrupts
> +		 * are level.
> +		 */
> +		irqflags = (pchan->plat_irq_ack.gas &&
> +			    pchan->plat_irq_trigger == ACPI_LEVEL_SENSITIVE) ?
> +			    IRQF_SHARED : 0;

We can hide all the details in a macro or oneline function that returns if
the interrupt can be shared. Also since this is threaded interrupt, you may
need to keep it disabled until the thread handler is run.

-- 
Regards,
Sudeep
