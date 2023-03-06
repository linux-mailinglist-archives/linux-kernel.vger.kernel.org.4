Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD7976ABA1E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 10:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCFJkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 04:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCFJki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 04:40:38 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE8D211C4;
        Mon,  6 Mar 2023 01:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678095634; x=1709631634;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rphgjThJSOFuhdwVeYanC8RljvKmVnf55cP66GTrCs4=;
  b=FVRoBHs8rBe1+b+pvGf30uyF9GqY/Kt0PEkWi7VCUYOghQ9ICNcRkGad
   KcTjJM32/Df2kb5R/InJmcHHXF96e622dCHD7zc4CJ8o89VtV/zAMTqFe
   upTR8eeUMlH280fK2/o7wl9yjcMRznt3A0faI9AVLQSv2BAwc7+4ly8VZ
   q1YXPfaHiWGOWMW8EXTl7BlhWPqN16O2vy0G7Tw6BjrAublqC20x5SsbO
   5MQQYzNLX29kaupnmYYghXe3dSl6GjxOQpsiA1G/XDN9IirTXL8CrpbOC
   lZLhXpw96nhLtgeayBuALp3rA3KbSDwqW83wyprl/SUw1GwRZ4MT1rJey
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="337029572"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="337029572"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2023 01:40:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10640"; a="819244668"
X-IronPort-AV: E=Sophos;i="5.98,236,1673942400"; 
   d="scan'208";a="819244668"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 06 Mar 2023 01:40:29 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 06 Mar 2023 11:40:28 +0200
Date:   Mon, 6 Mar 2023 11:40:28 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 4/4] driver core: Delete
 fw_devlink_purge_absent_suppliers()
Message-ID: <ZAW1DF76eULAzNvt@kuha.fi.intel.com>
References: <20230301214952.2190757-1-saravanak@google.com>
 <20230301214952.2190757-5-saravanak@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230301214952.2190757-5-saravanak@google.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 01, 2023 at 01:49:51PM -0800, Saravana Kannan wrote:
> After recent changes to fw_devlink that ended with commit 4a032827daa8
> ("of: property: Simplify of_link_to_phandle()"), fw_devlink no longer
> cares about the "compatible" property and figures out the correct struct
> device at runtime.
> 
> So, there's no need for any driver or framework to call
> fw_devlink_purge_absent_suppliers() anymore and we can delete it.
> 
> Signed-off-by: Saravana Kannan <saravanak@google.com>

FWIW:

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/base/core.c    | 16 ----------------
>  include/linux/fwnode.h |  1 -
>  2 files changed, 17 deletions(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 6878dfcbf0d6..46364c4d1983 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -186,22 +186,6 @@ void fwnode_links_purge(struct fwnode_handle *fwnode)
>  	fwnode_links_purge_consumers(fwnode);
>  }
>  
> -void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode)
> -{
> -	struct fwnode_handle *child;
> -
> -	/* Don't purge consumer links of an added child */
> -	if (fwnode->dev)
> -		return;
> -
> -	fwnode->flags |= FWNODE_FLAG_NOT_DEVICE;
> -	fwnode_links_purge_consumers(fwnode);
> -
> -	fwnode_for_each_available_child_node(fwnode, child)
> -		fw_devlink_purge_absent_suppliers(child);
> -}
> -EXPORT_SYMBOL_GPL(fw_devlink_purge_absent_suppliers);
> -
>  /**
>   * __fwnode_links_move_consumers - Move consumer from @from to @to fwnode_handle
>   * @from: move consumers away from this fwnode
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 5700451b300f..63972c863fcd 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -210,6 +210,5 @@ static inline void fwnode_dev_initialized(struct fwnode_handle *fwnode,
>  extern bool fw_devlink_is_strict(void);
>  int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup);
>  void fwnode_links_purge(struct fwnode_handle *fwnode);
> -void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
>  
>  #endif
> -- 
> 2.39.2.722.g9855ee24e9-goog

-- 
heikki
