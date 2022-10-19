Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545A5604ABB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiJSPK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiJSPJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:09:34 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D72041981;
        Wed, 19 Oct 2022 08:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666191784; x=1697727784;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M5avbZVzN3hkB86Ed3UZwrL75aggqypPsv/GEymhqa0=;
  b=BMRGLnU3DFO3j9EEawe3vJecObozbMcIOlK2ZNLPGhmBrgHku4Kw8UdE
   rV4FH5oMVXkrTS4Q/RkuLFNoihUs20pqenvQ6ErB+FWM6j58qbHQr/ZiJ
   1MQrLapNPtJIWNAgeYBvOfJeMGEoGg5tGq5WQgp17DrX7nTwjHBOxnotW
   8pCvleKDigHqi9H+SvC7dxMvFSU56HJXLtNRhbDk7ZjFXrREa7zqIoKWN
   SOhPaHywuANWEaJSpjpiUTHKShKT/hUrIaEsG5aBtCxIrjHv9wjSpXNZ1
   n8SoPmtx0E8lJ96jVGiHAMkfuax6eV0u+04YKuCal2L48jtlGKTsg8gB+
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="286826908"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="286826908"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 08:02:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="771825861"
X-IronPort-AV: E=Sophos;i="5.95,196,1661842800"; 
   d="scan'208";a="771825861"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 19 Oct 2022 08:02:45 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 19 Oct 2022 18:02:44 +0300
Date:   Wed, 19 Oct 2022 18:02:44 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] thunderbolt: ACPI: Use the helper fwnode_find_reference()
Message-ID: <Y1ARlOfUYW7OpczT@kuha.fi.intel.com>
References: <20221019142854.27364-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019142854.27364-1-heikki.krogerus@linux.intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:28:54PM +0300, Heikki Krogerus wrote:
> Replacing the direct fwnode_property_get_reference_args()
> call will this wrapper function.
> 
> No functional changes intended.
> 
> Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> ---
>  drivers/thunderbolt/acpi.c | 15 ++++-----------
>  1 file changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
> index 7a8adf5ad5a09..48ac227e6d8a0 100644
> --- a/drivers/thunderbolt/acpi.c
> +++ b/drivers/thunderbolt/acpi.c
> @@ -15,24 +15,17 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
>  				    void **return_value)
>  {
>  	struct acpi_device *adev = acpi_fetch_acpi_dev(handle);
> -	struct fwnode_reference_args args;
>  	struct fwnode_handle *fwnode;
>  	struct tb_nhi *nhi = data;
>  	struct pci_dev *pdev;
>  	struct device *dev;
> -	int ret;
> -
> -	if (!adev)
> -		return AE_OK;

Oh, I'm sorry, I did not mean to remove that check. I'll resend.

> -	fwnode = acpi_fwnode_handle(adev);
> -	ret = fwnode_property_get_reference_args(fwnode, "usb4-host-interface",
> -						 NULL, 0, 0, &args);
> -	if (ret)
> +	fwnode = fwnode_find_reference(acpi_fwnode_handle(adev), "usb4-host-interface", 0);
> +	if (IS_ERR(fwnode))
>  		return AE_OK;
>  
>  	/* It needs to reference this NHI */
> -	if (dev_fwnode(&nhi->pdev->dev) != args.fwnode)
> +	if (dev_fwnode(&nhi->pdev->dev) != fwnode)
>  		goto out_put;
>  
>  	/*
> @@ -100,7 +93,7 @@ static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
>  	}
>  
>  out_put:
> -	fwnode_handle_put(args.fwnode);
> +	fwnode_handle_put(fwnode);
>  	return AE_OK;
>  }
>  

thanks,

-- 
heikki
