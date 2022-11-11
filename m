Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDAC625CFA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 15:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234100AbiKKO0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 09:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234588AbiKKO0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 09:26:11 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 202EF1AD;
        Fri, 11 Nov 2022 06:26:08 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9AF51FB;
        Fri, 11 Nov 2022 06:26:14 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E55DD3F73D;
        Fri, 11 Nov 2022 06:26:06 -0800 (PST)
Date:   Fri, 11 Nov 2022 14:26:04 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, rafael@kernel.org,
        rafael.j.wysocki@intel.com, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH V2 1/2] ACPI: PCC: add check for platform interrupt
Message-ID: <20221111142604.qrk7bf2qf6ibfln3@bogus>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221111024448.25012-1-lihuisong@huawei.com>
 <20221111024448.25012-2-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111024448.25012-2-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change $subject to:
"ACPI: PCC: Setup PCC Opregion handler only if platform interrupt is available"

On Fri, Nov 11, 2022 at 10:44:47AM +0800, Huisong Li wrote:
> Currently, PCC Operation Region driver senses the completion of command by
> interrupt way. If platform can not generate an interrupt when a command
> complete, the caller never gets the desired result. So let's reject the
> setup of the PCC address space on platform that do not support interrupt
> mode.
>

Please reword something like below:

"Currently, PCC OpRegion handler depends on the availability of platform
interrupt to be functional currently. If it is not available, the OpRegion
can't be executed successfully or the desired outcome won't be possible.
So let's reject setting up the PCC OpRegion handler on the platform if
it doesn't support or have platform interrupt available"

> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/acpi/acpi_pcc.c | 47 +++++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/acpi_pcc.c b/drivers/acpi/acpi_pcc.c
> index 3e252be047b8..8efd08e469aa 100644
> --- a/drivers/acpi/acpi_pcc.c
> +++ b/drivers/acpi/acpi_pcc.c
> @@ -53,6 +53,7 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>  	struct pcc_data *data;
>  	struct acpi_pcc_info *ctx = handler_context;
>  	struct pcc_mbox_chan *pcc_chan;
> +	static acpi_status ret;
>  
>  	data = kzalloc(sizeof(*data), GFP_KERNEL);
>  	if (!data)
> @@ -69,23 +70,35 @@ acpi_pcc_address_space_setup(acpi_handle region_handle, u32 function,
>  	if (IS_ERR(data->pcc_chan)) {
>  		pr_err("Failed to find PCC channel for subspace %d\n",
>  		       ctx->subspace_id);
> -		kfree(data);
> -		return AE_NOT_FOUND;
> +		ret = AE_NOT_FOUND;
> +		goto request_channel_fail;

The labels are confusing IMO. I would do 's/request_channel_fail/err_free_data/'
to indicate what is exactly done there rather than just describing what
failed.

>  	}
>  
>  	pcc_chan = data->pcc_chan;
> +	if (!pcc_chan->mchan->mbox->txdone_irq) {
> +		pr_err("This channel-%d does not support interrupt.\n",
> +		       ctx->subspace_id);
> +		ret = AE_SUPPORT;
> +		goto request_channel_fail;

This is wrong, you must goto "ioremap_fail" as you have been successful in
opening the channel and now need to free the same.

> +	}
>  	data->pcc_comm_addr = acpi_os_ioremap(pcc_chan->shmem_base_addr,
>  					      pcc_chan->shmem_size);
>  	if (!data->pcc_comm_addr) {
>  		pr_err("Failed to ioremap PCC comm region mem for %d\n",
>  		       ctx->subspace_id);
> -		pcc_mbox_free_channel(data->pcc_chan);
> -		kfree(data);
> -		return AE_NO_MEMORY;
> +		ret = AE_NO_MEMORY;
> +		goto ioremap_fail;

Again I prefer 's/ioremap_fail/err_free_channel/' or something similar.

With all the above comments incorporated, you can add:
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
