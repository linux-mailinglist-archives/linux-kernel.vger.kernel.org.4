Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEE25ED64E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbiI1Hhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbiI1Hg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:36:59 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E84A10B22D;
        Wed, 28 Sep 2022 00:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664350573; x=1695886573;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2mq9g0p0ey5aQ3uwN1EJXOqXSfkSPpw7+dExmRoAWc=;
  b=UnvHMP/hIdiSRAJAKoiUs8Oi314ZTepOeL3V5Z1fc1GQDOuXHr0qGEJf
   su7wc7ZbLQFuu7BlPj7uqH5Ihpm+a04uJu78aPJVC0nqXVJ2CWgjXqwEb
   93/fJHGR9Q65KA8dq6qyfqSnaOH5EDeoWx41eiE9H4aQcUDeeDkA/CEou
   MmhefW+Eab+kqB/EOVeCvCEH8K+z45W+oBF/D3T8fnXL1QST13j/RW0vd
   5bgwV71N24qq1VNBXX42SKL7SLuj0q9P6AoIo0EXOwntlV2cth1GC/CG0
   1d0A4T6mMo2UGukNm1z/UIYJrcEpesuTvoMWQLBs7u/N+JpmPJO2dosmm
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281903370"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="281903370"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 00:35:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="764186416"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="764186416"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 28 Sep 2022 00:35:47 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 28 Sep 2022 10:35:46 +0300
Date:   Wed, 28 Sep 2022 10:35:46 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Prashant Malani <pmalani@chromium.org>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <YzP5UkYKahQR7FtZ@kuha.fi.intel.com>
References: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927142822.4095-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 05:28:17PM +0300, Andy Shevchenko wrote:
> It's not fully correct to take a const parameter pointer to a struct
> and return a non-const pointer to a member of that struct.
> 
> Instead, introduce a const version of the dev_fwnode() API which takes
> and returns const pointers and use it where it's applicable.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For the whole series:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/property.c  | 11 +++++++++--
>  include/linux/property.h |  3 ++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index 4d6278a84868..699f1b115e0a 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -17,13 +17,20 @@
>  #include <linux/property.h>
>  #include <linux/phy.h>
>  
> -struct fwnode_handle *dev_fwnode(const struct device *dev)
> +struct fwnode_handle *dev_fwnode(struct device *dev)
>  {
>  	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
>  		of_fwnode_handle(dev->of_node) : dev->fwnode;
>  }
>  EXPORT_SYMBOL_GPL(dev_fwnode);
>  
> +const struct fwnode_handle *dev_fwnode_const(const struct device *dev)
> +{
> +	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
> +		of_fwnode_handle(dev->of_node) : dev->fwnode;
> +}
> +EXPORT_SYMBOL_GPL(dev_fwnode_const);
> +
>  /**
>   * device_property_present - check if a property of a device is present
>   * @dev: Device whose property is being checked
> @@ -1202,7 +1209,7 @@ EXPORT_SYMBOL(fwnode_graph_parse_endpoint);
>  
>  const void *device_get_match_data(const struct device *dev)
>  {
> -	return fwnode_call_ptr_op(dev_fwnode(dev), device_get_match_data, dev);
> +	return fwnode_call_ptr_op(dev_fwnode_const(dev), device_get_match_data, dev);
>  }
>  EXPORT_SYMBOL_GPL(device_get_match_data);
>  
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 117cc200c656..ae5d7f8eccf4 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -32,7 +32,8 @@ enum dev_dma_attr {
>  	DEV_DMA_COHERENT,
>  };
>  
> -struct fwnode_handle *dev_fwnode(const struct device *dev);
> +struct fwnode_handle *dev_fwnode(struct device *dev);
> +const struct fwnode_handle *dev_fwnode_const(const struct device *dev);
>  
>  bool device_property_present(struct device *dev, const char *propname);
>  int device_property_read_u8_array(struct device *dev, const char *propname,
> -- 
> 2.35.1

-- 
heikki
