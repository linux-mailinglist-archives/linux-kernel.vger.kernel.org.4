Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1E624032
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 11:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiKJKoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 05:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiKJKoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 05:44:20 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61FEE27DDC;
        Thu, 10 Nov 2022 02:44:19 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 572001FB;
        Thu, 10 Nov 2022 02:44:25 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 642DD3F534;
        Thu, 10 Nov 2022 02:44:17 -0800 (PST)
Date:   Thu, 10 Nov 2022 10:44:15 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, rafael.j.wysocki@intel.com,
        Sudeep Holla <sudeep.holla@arm.com>, wanghuiqiang@huawei.com,
        zhangzekun11@huawei.com, wangxiongfeng2@huawei.com,
        tanxiaofei@huawei.com, guohanjun@huawei.com, xiexiuqi@huawei.com,
        wangkefeng.wang@huawei.com, huangdaode@huawei.com
Subject: Re: [PATCH 3/3] mailbox: pcc: fix 'pcc_chan_count' when fail to
 initialize PCC
Message-ID: <20221110104415.gk3asb5yc26slcs7@bogus>
References: <20221110015034.7943-1-lihuisong@huawei.com>
 <20221110015034.7943-4-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110015034.7943-4-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:50:34AM +0800, Huisong Li wrote:
> Currently, 'pcc_chan_count' is a non-zero value if PCC subspaces are parsed
> successfully and subsequent processes is failure during initializing PCC
> process. This may cause that pcc_mbox_request_channel() can still be
> executed successfully , which will misleads the caller that this channel is
> available.
> 
> Fixes: ce028702ddbc ("mailbox: pcc: Move bulk of PCCT parsing into pcc_mbox_probe")
> Signed-off-by: Huisong Li <lihuisong@huawei.com>
> ---
>  drivers/mailbox/pcc.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mailbox/pcc.c b/drivers/mailbox/pcc.c
> index 7cee37dd3b73..47d70c5884e3 100644
> --- a/drivers/mailbox/pcc.c
> +++ b/drivers/mailbox/pcc.c
> @@ -294,6 +294,7 @@ pcc_mbox_request_channel(struct mbox_client *cl, int subspace_id)
>  		pr_err("Channel not found for idx: %d\n", subspace_id);
>  		return ERR_PTR(-EBUSY);
>  	}
> +

Spurious/not needed change ?

>  	dev = chan->mbox->dev;
>  
>  	spin_lock_irqsave(&chan->lock, flags);
> @@ -735,7 +736,8 @@ static int __init pcc_init(void)
>  
>  	if (ret) {
>  		pr_debug("ACPI PCC probe failed.\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto out;

Not needed, we don't set pcc_chan_count if the probe failed.

>  	}
>  
>  	pcc_pdev = platform_create_bundle(&pcc_mbox_driver,
> @@ -743,10 +745,13 @@ static int __init pcc_init(void)
>  
>  	if (IS_ERR(pcc_pdev)) {
>  		pr_debug("Err creating PCC platform bundle\n");
> -		return PTR_ERR(pcc_pdev);
> +		ret = PTR_ERR(pcc_pdev);

You just need to set pcc_chan_count to 0 here, so no need for goto.

-- 
Regards,
Sudeep
