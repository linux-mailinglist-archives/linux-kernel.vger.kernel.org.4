Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69AD6A6CFD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 14:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjCANYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 08:24:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCANYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 08:24:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FF371498A;
        Wed,  1 Mar 2023 05:24:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 542862F4;
        Wed,  1 Mar 2023 05:25:05 -0800 (PST)
Received: from bogus (unknown [10.57.16.230])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C68C3F587;
        Wed,  1 Mar 2023 05:24:18 -0800 (PST)
Date:   Wed, 1 Mar 2023 13:24:13 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 1/2] mailbox: pcc: Add processing platform notification
 for slave subspaces
Message-ID: <20230301132413.p6ssnkp76pv2bz5y@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230216063653.1995-1-lihuisong@huawei.com>
 <20230216063653.1995-2-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216063653.1995-2-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 02:36:52PM +0800, Huisong Li wrote:
> Currently, PCC driver doesn't support the processing of platform
> notification for slave PCC subspaces because of the incomplete
> communication flow.
> 
> According to ACPI specification, if platform sends a notification
> to OSPM, it must clear the command complete bit and trigger platform
> interrupt. OSPM needs to check whether the command complete bit is
> cleared, clear platform interrupt, process command, and then set the
> command complete and ring doorbell to Platform. But the current judgment
> on the command complete is not applicable to type4 in pcc_mbox_irq().
> 
> This patch determines whether the PCC driver needs to respond to the
> interrupt of the channel with the master or slave subspace based on
> the command complete register. And PCC driver needs to add the phase
> of setting the command complete and ring doorbell in pcc_mbox_irq()
> to complete type4 communication flow after processing command from
> Platform.
> 

I would prefer to reword this a little bit:

"
mailbox: pcc: Add support for platform notification handling

Currently, PCC driver doesn't support the processing of platform
notification for type 4 PCC subspaces.

According to ACPI specification, if platform sends a notification
to OSPM, it must clear the command complete bit and trigger platform
interrupt. OSPM needs to check whether the command complete bit is
cleared, clear platform interrupt, process command, and then set the
command complete and ring doorbell to the Platform.

Let us stash the value of the pcc type and use the same while processing
the interrupt of the channel. We also need to set the command complete
bit and ring doorbell in the interrupt handler for the type 4 channel to
complete the communication flow after processing the notification from
the Platform.
"

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/mailbox/pcc.c | 57 ++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 51 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 105d46c9801b..ecd54f049de3 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -91,6 +91,7 @@ struct pcc_chan_reg {
>   * @cmd_update: PCC register bundle for the command complete update register
>   * @error: PCC register bundle for the error status register
>   * @plat_irq: platform interrupt
> + * @type: PCC subspace type
>   */
>  struct pcc_chan_info {
>  	struct pcc_mbox_chan chan;
> @@ -100,12 +101,15 @@ struct pcc_chan_info {
>  	struct pcc_chan_reg cmd_update;
>  	struct pcc_chan_reg error;
>  	int plat_irq;
> +	u8 type;
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
> @@ -221,6 +225,43 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>  	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>  }
>  
> +static bool pcc_chan_command_complete(struct pcc_chan_info *pchan,
> +				      u64 cmd_complete_reg_val)
> +{
> +	bool complete;
> +
> +	if (!pchan->cmd_complete.gas)
> +		return true;
> +
> +	cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
> +
> +	switch (pchan->type) {
> +	case ACPI_PCCT_TYPE_EXT_PCC_MASTER_SUBSPACE:
> +		/*
> +		 * If this channel with the PCC master subspace is in use,
> +		 * the command complete bit is 1 indicates that the executing
> +		 * command has been completed by Platform and OSPM needs to
> +		 * process the response.
> +		 */
> +		complete = cmd_complete_reg_val != 0;
> +		break;
> +	case ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE:
> +		/*
> +		 * If this channel with the PCC slave subspace is in use,
> +		 * the command complete bit is 0 indicates that Platform is
> +		 * sending a notification and OSPM needs to response the
> +		 * interrupt to process this command.
> +		 */
> +		complete = cmd_complete_reg_val == 0;
> +		break;
> +	default:
> +		complete = true;
> +		break;
> +	}
> +
> +	return complete;
> +}
> +
>  /**
>   * pcc_mbox_irq - PCC mailbox interrupt handler
>   * @irq:	interrupt number
> @@ -240,12 +281,8 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)
>  	ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
>  	if (ret)
>  		return IRQ_NONE;
> -
> -	if (val) { /* Ensure GAS exists and value is non-zero */
> -		val &= pchan->cmd_complete.status_mask;
> -		if (!val)
> -			return IRQ_NONE;
> -	}
> +	if (!pcc_chan_command_complete(pchan, val))
> +		return IRQ_NONE;
>

Can we simplify the above 2 chunks like below ? Does that work for you ?
I see we already check for presence of complete complete check and update
registers for type3/4, we can avoid it I think. Let me know if you spot
any issue with this.

Regards,
Sudeep

--->8

@@ -221,6 +225,28 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
        return acpi_register_gsi(NULL, interrupt, trigger, polarity);
 }

+static bool pcc_mbox_cmd_complete_check(struct pcc_chan_info *pchan)
+{
+       u64 val;
+       int ret;
+
+       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
+       if (ret)
+               return false;
+
+       val &= pchan->cmd_complete.status_mask;
+
+       /*
+        * If this is PCC slave subspace channel, then the command complete
+        * bit 0 indicates that Platform is sending a notification and OSPM
+        * needs to respond this interrupt to process this command.
+        */
+       if (pchan->type == ACPI_PCCT_TYPE_EXT_PCC_SLAVE_SUBSPACE)
+               return !val;
+       else
+               return !!val;
+}
+
 /**
  * pcc_mbox_irq - PCC mailbox interrupt handler
  * @irq:       interrupt number
@@ -237,16 +263,9 @@ static irqreturn_t pcc_mbox_irq(int irq, void *p)

        pchan = chan->con_priv;

-       ret = pcc_chan_reg_read(&pchan->cmd_complete, &val);
-       if (ret)
+       if (!pcc_mbox_cmd_complete_check(pchan))
                return IRQ_NONE;

-       if (val) { /* Ensure GAS exists and value is non-zero */
-               val &= pchan->cmd_complete.status_mask;
-               if (!val)
-                       return IRQ_NONE;
-       }
-
        ret = pcc_chan_reg_read(&pchan->error, &val);
        if (ret)

