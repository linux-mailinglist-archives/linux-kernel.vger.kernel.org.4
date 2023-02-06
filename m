Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A6F68C218
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBFPql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjBFPqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:46:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C747F2914B;
        Mon,  6 Feb 2023 07:46:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD81713D5;
        Mon,  6 Feb 2023 07:40:26 -0800 (PST)
Received: from bogus (unknown [10.57.12.205])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5EF613F703;
        Mon,  6 Feb 2023 07:39:42 -0800 (PST)
Date:   Mon, 6 Feb 2023 15:39:40 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [RFC-V3 1/2] mailbox: pcc: Add processing platform notification
 for slave subspaces
Message-ID: <20230206153940.gcddy3b3znk72yqd@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20221203095150.45422-1-lihuisong@huawei.com>
 <20221203095150.45422-2-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221203095150.45422-2-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huisong,

Apologies for such a long delay.

Also I would like to hear from Robbie King who I know is playing around
with this these days 😄. At minimum if this logic works for him as well.

On Sat, Dec 03, 2022 at 05:51:49PM +0800, Huisong Li wrote:
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
> This patch introduces a communication flow direction field to detect
> whether the interrupt belongs to the master or slave subspace channel.
> And PCC driver needs to add the phase of setting the command complete
> and ring doorbell in pcc_mbox_irq() to complete type4 communication
> flow after processing command from Platform.
> 
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/mailbox/pcc.c | 77 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 71 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 105d46c9801b..ad6d0b7d50fc 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -80,6 +80,13 @@ struct pcc_chan_reg {
>  	u64 status_mask;
>  };
>  
> +enum pcc_chan_comm_flow_dir_type {
> +	PCC_ONLY_OSPM_TO_PLATFORM,
> +	PCC_ONLY_PLATFORM_TO_OSPM,
> +	PCC_BIDIRECTIONAL,
> +	PCC_DIR_UNKNOWN,
> +};
> +
>  /**
>   * struct pcc_chan_info - PCC channel specific information
>   *
> @@ -91,6 +98,7 @@ struct pcc_chan_reg {
>   * @cmd_update: PCC register bundle for the command complete update register
>   * @error: PCC register bundle for the error status register
>   * @plat_irq: platform interrupt
> + * @comm_flow_dir: direction of communication flow supported by the channel
>   */
>  struct pcc_chan_info {
>  	struct pcc_mbox_chan chan;
> @@ -100,12 +108,15 @@ struct pcc_chan_info {
>  	struct pcc_chan_reg cmd_update;
>  	struct pcc_chan_reg error;
>  	int plat_irq;
> +	u8 comm_flow_dir;

I would rather just save the 'type' as read from the PCCT. We don't know
what future types might be and just identifying them by the direction of
flow of the data, it restricts the usage of this.

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
> @@ -221,6 +232,43 @@ static int pcc_map_interrupt(u32 interrupt, u32 flags)
>  	return acpi_register_gsi(NULL, interrupt, trigger, polarity);
>  }
>  
> +static bool pcc_chan_need_rsp_irq(struct pcc_chan_info *pchan,
> +				  u64 cmd_complete_reg_val)

Probably rename this as pcc_chan_command_complete or something similar.

> +{
> +	bool need_rsp;
> +
> +	if (!pchan->cmd_complete.gas)
> +		return true;
> +
> +	cmd_complete_reg_val &= pchan->cmd_complete.status_mask;
> +
> +	switch (pchan->comm_flow_dir) {

Use the channel type instead here.

-- 
Regards,
Sudeep
