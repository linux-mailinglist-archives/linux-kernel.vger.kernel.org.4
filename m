Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B215F5B62
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 23:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbiJEVGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 17:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiJEVGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 17:06:00 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2156E696F8;
        Wed,  5 Oct 2022 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665003960; x=1696539960;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XPc4iUrJQ2pmk/YLXD4nx2V2D8aelG5jLWY8aoFlCP0=;
  b=fBRKEWyX8rqP2X5GkYj/hNMNEoEtUDv5OsVYJdiY2SuxQPLe/5MeU433
   yJyYI6mhLa21jBZllbmXYgM6dlcgQVc1rYIUUuPeN7gq7uM3CawpA+YrU
   50STHtw2X7sNmwpt3sClHFp+E8rvWjQtgHxdAeMBkK85Cjn3NAhO5QQjM
   eD42qQSA5C/f0tcXAMdoxB/un6XiRn9tG3TwD1ZF5iVf+gBYeTXtQlmmk
   aFOXbg8haQNjyN37qBsgx1G6XoJx/O5lGnF0aYCX7mj0N+DezRmR6m7hy
   dPiit+Fu5pRQ9KU78NrdGCda3V58rT7d4Vmeez7gFtwbPYNwr0DIT6ok5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="304851277"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="304851277"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 14:05:59 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10491"; a="624475355"
X-IronPort-AV: E=Sophos;i="5.95,161,1661842800"; 
   d="scan'208";a="624475355"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2022 14:05:56 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 0E57520352;
        Thu,  6 Oct 2022 00:05:54 +0300 (EEST)
Date:   Wed, 5 Oct 2022 21:05:54 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v2 1/2] device property: Introduce
 fwnode_device_is_compatible() helper
Message-ID: <Yz3xsmy/3wlntStv@paasikivi.fi.intel.com>
References: <20221005152947.71696-1-andriy.shevchenko@linux.intel.com>
 <20221005152947.71696-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005152947.71696-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Wed, Oct 05, 2022 at 06:29:46PM +0300, Andy Shevchenko wrote:
> The fwnode_device_is_compatible() helper searches for the
> given string in the "compatible" string array property and,
> if found, returns true.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  include/linux/property.h | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 1c26d263d5e4..701570423943 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -55,7 +55,6 @@ int device_property_read_string(struct device *dev, const char *propname,
>  int device_property_match_string(struct device *dev,
>  				 const char *propname, const char *string);
>  
> -bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
>  bool fwnode_property_present(const struct fwnode_handle *fwnode,
>  			     const char *propname);
>  int fwnode_property_read_u8_array(const struct fwnode_handle *fwnode,
> @@ -77,6 +76,15 @@ int fwnode_property_read_string(const struct fwnode_handle *fwnode,
>  				const char *propname, const char **val);
>  int fwnode_property_match_string(const struct fwnode_handle *fwnode,
>  				 const char *propname, const char *string);
> +
> +bool fwnode_device_is_available(const struct fwnode_handle *fwnode);
> +
> +static inline
> +bool fwnode_device_is_compatible(const struct fwnode_handle *fwnode, const char *compat)
> +{
> +	return fwnode_property_match_string(fwnode, "compatible", compat) >= 0;

fwnode_property_match_string() returns zero on success, therefore >= 0 is
not needed. I'd just use !fwnode_property_match_string(...).

For both patches:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> +}
> +
>  int fwnode_property_get_reference_args(const struct fwnode_handle *fwnode,
>  				       const char *prop, const char *nargs_prop,
>  				       unsigned int nargs, unsigned int index,

-- 
Regards,

Sakari Ailus
