Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB0C5F2CBB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbiJCJD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiJCJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:03:35 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5969B2B625;
        Mon,  3 Oct 2022 01:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664787331; x=1696323331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pSl0MkGo2r/PP1CMdkpNUWcYCATxqv9uYztWtwkNJI8=;
  b=CmKZsGjhetfpcFjtYRcRAFRKQYNfEdI/c5cbjaEPgx+wFnrwfy0IhnqZ
   vqD0mJtiGFRnDpmTsXzSJXr0lA1b2mYMQDp/8yXZHnDpoPyQ4Lc10MxSm
   9TLv0wrlKQou/n6pehilNx1/og7tnnERs+cw0kfWGri14PYRwPY5+geAx
   QtJwbZLDk+z2HyCXC0oXNqZYefBlm9o6p4YhwMeBatZSgybSJLrVoslfi
   G0Qd1F3o4KctlPy53rrYtkWSluDd6WgtfZJEhupEvCNehZRkSZKKaMIqW
   bc8OGsRn3ROhHcMi/4Qw2lcpljtbG5jK5nykI+LVZu/RqZH0qzUyH2DZd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="282953122"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="282953122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2022 01:55:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10488"; a="765837999"
X-IronPort-AV: E=Sophos;i="5.93,365,1654585200"; 
   d="scan'208";a="765837999"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Oct 2022 01:55:28 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 03 Oct 2022 11:55:27 +0300
Date:   Mon, 3 Oct 2022 11:55:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     gregkh@linuxfoundation.org, Sanket.Goswami@amd.com,
        singhanc@nvidia.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] usb: typec: ucsi_ccg: Add OF support
Message-ID: <Yzqjf7aGeDL/z4lp@kuha.fi.intel.com>
References: <20220928154732.3806953-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928154732.3806953-1-waynec@nvidia.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 11:47:32PM +0800, Wayne Chang wrote:
> The change enables the device tree infrastructure support on Cypress
> cypd4226.

So does this patch depend on that other patch where you introduce
the quirk that disables alt modes based on the firmware version
(Disable UCSI ALT support on Tegra)?

thanks,

> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
> V1 -> V2: updated the change with dev_fwnode instead of device node
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 5c0bf48be766..7e034d765a0e 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -631,7 +631,7 @@ static int ccg_request_irq(struct ucsi_ccg *uc)
>  {
>  	unsigned long flags = IRQF_ONESHOT;
>  
> -	if (!has_acpi_companion(uc->dev))
> +	if (!dev_fwnode(uc->dev))
>  		flags |= IRQF_TRIGGER_HIGH;
>  
>  	return request_threaded_irq(uc->irq, NULL, ccg_irq_handler, flags, dev_name(uc->dev), uc);
> @@ -1417,6 +1417,12 @@ static int ucsi_ccg_remove(struct i2c_client *client)
>  	return 0;
>  }
>  
> +static const struct of_device_id ucsi_ccg_of_match_table[] = {
> +		{ .compatible = "cypress,cypd4226", },
> +		{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, ucsi_ccg_of_match_table);
> +
>  static const struct i2c_device_id ucsi_ccg_device_id[] = {
>  	{"ccgx-ucsi", 0},
>  	{}
> @@ -1471,6 +1477,7 @@ static struct i2c_driver ucsi_ccg_driver = {
>  		.pm = &ucsi_ccg_pm,
>  		.dev_groups = ucsi_ccg_groups,
>  		.acpi_match_table = amd_i2c_ucsi_match,
> +		.of_match_table = ucsi_ccg_of_match_table,
>  	},
>  	.probe = ucsi_ccg_probe,
>  	.remove = ucsi_ccg_remove,
> -- 
> 2.25.1

-- 
heikki
