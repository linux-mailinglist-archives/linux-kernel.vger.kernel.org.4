Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09745666B90
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjALH0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236639AbjALH0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:26:31 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90747659;
        Wed, 11 Jan 2023 23:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673508390; x=1705044390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FWSr51rrfHuS4baA2E9ohsMe/O/JvSLIOHSsJj8xzPo=;
  b=mstOiuy8yX/IlcavmFXYFaw7JGJ4vVv2fTo/8d/KVSYb9IEoQixG9BfH
   N3BNvdEMvbptD6Gf5qbJ23ikdfvgpDfUPQetMGnfbGelVvz1GMKHRYNW5
   FGtIgO0iXXGS2wR4mci/8aw2zt5FMcBcI2eRpl6t55I1GpsqU+G4kbu6N
   Is4a9ifIb80DER8ZtRNGHQDLRk6riMBwMSKLFiVtEQ0/uq2qxYdmhePgz
   r2oHse4oJrp3nY+NnaOwhIcaSVK2+hIDK1UMAAsNtqJVhqdg348tYIgOG
   tjHTbcT2nESMfiEKzxwFvjKr550qkUZ4oCOKYVDgXp16tsUIq/ukRp0SN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385948095"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="385948095"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:26:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="800104724"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="800104724"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 11 Jan 2023 23:26:25 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 12 Jan 2023 09:26:24 +0200
Date:   Thu, 12 Jan 2023 09:26:24 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Chanh Nguyen <chanh@os.amperecomputing.com>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frank Li <frank.li@nxp.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dan Vacura <w36195@motorola.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Vijayavardhan Vennapusa <vvreddy@codeaurora.org>,
        Rondreis <linhaoguo86@gmail.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Open Source Submission <patches@amperecomputing.com>
Subject: Re: [PATCH v3] USB: gadget: Add ID numbers to configfs-gadget driver
 names
Message-ID: <Y7+2ICAKlghDAem2@kuha.fi.intel.com>
References: <20230111065105.29205-1-chanh@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111065105.29205-1-chanh@os.amperecomputing.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 01:51:05PM +0700, Chanh Nguyen wrote:
> It is unable to use configfs to attach more than one gadget. When
> attaching the second gadget, it always fails and the kernel message
> prints out:
> 
> Error: Driver 'configfs-gadget' is already registered, aborting...
> UDC core: g1: driver registration failed: -16
> 
> This commit fixes the problem by using the gadget name as a suffix
> to each configfs_gadget's driver name, thus making the names
> distinct.
> 
> Fixes: fc274c1e9973 ("USB: gadget: Add a new bus for gadgets")
> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>

Tested-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

Thanks!

> ---
> Changes in v3:
>   - Use the gadget name as a unique suffix instead     [Andrzej]
>   - Remove the driver.name allocation by template        [Chanh]
>   - Update commit message                                [Chanh]
> 
> Changes in v2:
>   - Replace scnprintf() by kasprintf() to simplify the code [CJ]
>   - Move the clean up code from gadgets_drop() to
>     gadget_info_attr_release()                        [Frank Li]
>   - Correct the resource free up in gadges_make()   [Alan Stern]
>   - Remove the unnecessary variable in gadgets_make()    [Chanh]
>   - Fixes minor grammar issue in commit message          [Chanh]
> ---
>  drivers/usb/gadget/configfs.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
> index 96121d1c8df4..0853536cbf2e 100644
> --- a/drivers/usb/gadget/configfs.c
> +++ b/drivers/usb/gadget/configfs.c
> @@ -393,6 +393,7 @@ static void gadget_info_attr_release(struct config_item *item)
>  	WARN_ON(!list_empty(&gi->string_list));
>  	WARN_ON(!list_empty(&gi->available_func));
>  	kfree(gi->composite.gadget_driver.function);
> +	kfree(gi->composite.gadget_driver.driver.name);
>  	kfree(gi);
>  }
>  
> @@ -1572,7 +1573,6 @@ static const struct usb_gadget_driver configfs_driver_template = {
>  	.max_speed	= USB_SPEED_SUPER_PLUS,
>  	.driver = {
>  		.owner          = THIS_MODULE,
> -		.name		= "configfs-gadget",
>  	},
>  	.match_existing_only = 1,
>  };
> @@ -1623,13 +1623,21 @@ static struct config_group *gadgets_make(
>  
>  	gi->composite.gadget_driver = configfs_driver_template;
>  
> +	gi->composite.gadget_driver.driver.name = kasprintf(GFP_KERNEL,
> +							    "configfs-gadget.%s", name);
> +	if (!gi->composite.gadget_driver.driver.name)
> +		goto err;
> +
>  	gi->composite.gadget_driver.function = kstrdup(name, GFP_KERNEL);
>  	gi->composite.name = gi->composite.gadget_driver.function;
>  
>  	if (!gi->composite.gadget_driver.function)
> -		goto err;
> +		goto out_free_driver_name;
>  
>  	return &gi->group;
> +
> +out_free_driver_name:
> +	kfree(gi->composite.gadget_driver.driver.name);
>  err:
>  	kfree(gi);
>  	return ERR_PTR(-ENOMEM);
> -- 
> 2.17.1

-- 
heikki
