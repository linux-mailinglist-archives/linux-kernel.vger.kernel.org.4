Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC18A68930D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 10:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBCJGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 04:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjBCJF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 04:05:59 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C13188A64;
        Fri,  3 Feb 2023 01:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675415158; x=1706951158;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKUpJJPH3fK1ORnA1ojXGgFxj8Uhwn6AXZs91m1E7VQ=;
  b=XVI7KQQCm1QtbsT49yy4ZsK3HmXHW8LLi3E//EEmTISbMIm9+Rpkhoxo
   +6bw2yAS15pOeOs1CYUAO2MYR3rNrHxpsXqgLj0sILmn6rVfBTzSsyb+3
   bIaQNGKA83khDG6DoAa0983ahNySAEv8GgxGOIYjXg6PwX27b5jdB/PKD
   84+jDJfZEXWXAcx9YxZIYZLmDZMYXQxgxPHsmrp2CDwEKZiOVnVmc2NGm
   4t6yLLDt+Zj22/yjaor9htqMrTllP3p/jOZ3D3Exzz7lrxnWedyIMQGIb
   Y0g1Qc/PIn2+wta8cmsTqUcD5PKNT+GSjEX+VV2wF3UZSxXDYngqlE1ll
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="312355512"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="312355512"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2023 01:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="808308442"
X-IronPort-AV: E=Sophos;i="5.97,269,1669104000"; 
   d="scan'208";a="808308442"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 03 Feb 2023 01:05:56 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 03 Feb 2023 11:05:55 +0200
Date:   Fri, 3 Feb 2023 11:05:55 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/13] USB: ULPI: fix memory leak with using
 debugfs_lookup()
Message-ID: <Y9zOc+MeD+LbAdi8@kuha.fi.intel.com>
References: <20230202153235.2412790-1-gregkh@linuxfoundation.org>
 <20230202153235.2412790-2-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202153235.2412790-2-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 04:32:24PM +0100, Greg Kroah-Hartman wrote:
> When calling debugfs_lookup() the result must have dput() called on it,
> otherwise the memory will leak over time.  To make things simpler, just
> call debugfs_lookup_and_remove() instead which handles all of the logic
> at once.
> 
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: linux-usb@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/common/ulpi.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
> index 67b780b256a9..a98b2108376a 100644
> --- a/drivers/usb/common/ulpi.c
> +++ b/drivers/usb/common/ulpi.c
> @@ -271,7 +271,7 @@ static int ulpi_regs_show(struct seq_file *seq, void *data)
>  }
>  DEFINE_SHOW_ATTRIBUTE(ulpi_regs);
>  
> -#define ULPI_ROOT debugfs_lookup(KBUILD_MODNAME, NULL)
> +static struct dentry *ulpi_root;
>  
>  static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  {
> @@ -301,7 +301,7 @@ static int ulpi_register(struct device *dev, struct ulpi *ulpi)
>  		return ret;
>  	}
>  
> -	root = debugfs_create_dir(dev_name(dev), ULPI_ROOT);
> +	root = debugfs_create_dir(dev_name(dev), ulpi_root);
>  	debugfs_create_file("regs", 0444, root, ulpi, &ulpi_regs_fops);
>  
>  	dev_dbg(&ulpi->dev, "registered ULPI PHY: vendor %04x, product %04x\n",
> @@ -349,8 +349,7 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
>   */
>  void ulpi_unregister_interface(struct ulpi *ulpi)
>  {
> -	debugfs_remove_recursive(debugfs_lookup(dev_name(&ulpi->dev),
> -						ULPI_ROOT));
> +	debugfs_lookup_and_remove(dev_name(&ulpi->dev), ulpi_root);
>  	device_unregister(&ulpi->dev);
>  }
>  EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
> @@ -360,12 +359,11 @@ EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
>  static int __init ulpi_init(void)
>  {
>  	int ret;
> -	struct dentry *root;
>  
> -	root = debugfs_create_dir(KBUILD_MODNAME, NULL);
> +	ulpi_root = debugfs_create_dir(KBUILD_MODNAME, NULL);
>  	ret = bus_register(&ulpi_bus);
>  	if (ret)
> -		debugfs_remove(root);
> +		debugfs_remove(ulpi_root);
>  	return ret;
>  }
>  subsys_initcall(ulpi_init);
> @@ -373,7 +371,7 @@ subsys_initcall(ulpi_init);
>  static void __exit ulpi_exit(void)
>  {
>  	bus_unregister(&ulpi_bus);
> -	debugfs_remove_recursive(ULPI_ROOT);
> +	debugfs_remove(ulpi_root);
>  }
>  module_exit(ulpi_exit);
>  
> -- 
> 2.39.1

-- 
heikki
