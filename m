Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DFC2623FF8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiKJKg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:36:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKJKgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:36:24 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61BA666C81;
        Thu, 10 Nov 2022 02:36:23 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 551BA1FB;
        Thu, 10 Nov 2022 02:36:29 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 629A43F534;
        Thu, 10 Nov 2022 02:36:21 -0800 (PST)
Date:   Thu, 10 Nov 2022 10:36:18 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 2/3] ACPI: PCC: add check for platform interrupt
Message-ID: <20221110103618.3vuyfdhcebf7ewmo@bogus>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221110015034.7943-3-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110015034.7943-3-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:50:33AM +0800, Huisong Li wrote:
> PCC Operation Region driver senses the completion of command by interrupt
> way. If platform can not generate an interrupt when a command complete,
> the caller never gets the desired result. So let's reject the setup of the
> PCC address space on platform that do not support interrupt mode.
> 
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
>  	}
>

Your patch seems to be not based on the upstream.
Commit f890157e61b8 ("ACPI: PCC: Release resources on address space setup
failure path") has addressed it already.

>  	pcc_chan = data->pcc_chan;
> +	if (!pcc_chan->mchan->mbox->txdone_irq) {
> +		pr_err("This channel-%d does not support interrupt.\n",
> +		       ctx->subspace_id);
> +		ret = AE_SUPPORT;
> +		goto request_channel_fail;
> +	}

Indeed, I supported only interrupt case and this approach is better than
checking it in handler atleast until we add support for polling based
transfers in future(hope that never happens, but you never know)

-- 
Regards,
Sudeep
