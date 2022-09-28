Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E35505EDED9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiI1Odo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiI1Odh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:33:37 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E8AACA1D;
        Wed, 28 Sep 2022 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664375616; x=1695911616;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fiZwldPbRJfb8aqO9HcM3UTZxeIOmGbY4Qs5nLykbIM=;
  b=akrOH20mm8x4ru/nK1KN5Yi0j8Qf/3f15RERvGoCFuCSyjsopdi/lBDd
   ieeXrEe9VgLfzC+DJ6Fih1c5ZaiA0xkMbdPBxZ/3manCJyBXHr1Mg0H/c
   5xkCYGeXB75u7xr2FVwYTHY1TyWGzOB+ERRBqNKodaZmLy4e0yICDLyJV
   QRHxG0NgfSNZzcxlykxESk45p4UbTYMLxKCCXmwv8ToRIchb+Cc5vS8Il
   bypHcWnVUnZsnRLi+/P+AolcideHf//8RAqF8RS57jfmmMVHf7hOA28ya
   hCjPk4+uNL+8IqiIcbtsItQKfHlxpLLrc/PtsmiS/GKbbB76V4DSB/MPU
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="387898817"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="387898817"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 07:33:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="764308042"
X-IronPort-AV: E=Sophos;i="5.93,352,1654585200"; 
   d="scan'208";a="764308042"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Sep 2022 07:33:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 28 Sep 2022 17:33:27 +0300
Date:   Wed, 28 Sep 2022 17:33:27 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wayne Chang <waynec@nvidia.com>
Cc:     gregkh@linuxfoundation.org, Sanket.Goswami@amd.com,
        singhanc@nvidia.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] usb: typec: ucsi_ccg: Add OF support
Message-ID: <YzRbN5tS+epkOVfV@kuha.fi.intel.com>
References: <20220928125227.3045703-1-waynec@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928125227.3045703-1-waynec@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Sep 28, 2022 at 08:52:27PM +0800, Wayne Chang wrote:
> The change enables the device tree infrastructure support on Cypress
> cypd4226.
> 
> Signed-off-by: Wayne Chang <waynec@nvidia.com>
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index 5c0bf48be766..36442508bc37 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -631,7 +631,7 @@ static int ccg_request_irq(struct ucsi_ccg *uc)
>  {
>  	unsigned long flags = IRQF_ONESHOT;
>  
> -	if (!has_acpi_companion(uc->dev))
> +	if (!has_acpi_companion(uc->dev) && !uc->dev->of_node)

You can use:

        if (!dev_fwnode(uc->dev))

instead.

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

thanks,

-- 
heikki
