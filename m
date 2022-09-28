Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7AD5EDB3F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbiI1LI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiI1LH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:07:56 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF14101962;
        Wed, 28 Sep 2022 04:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1F0AECE1E0E;
        Wed, 28 Sep 2022 11:05:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A9AC433C1;
        Wed, 28 Sep 2022 11:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664363123;
        bh=hjJNq8fnvzNa+xcgY2fbdv63qk0sriuoXr4L9LoZTA4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jts7knNVMGAXXpFgv3N/rNxUiA7KZtNei74t90zWvg9uR+501l/R99wtdQ5qLxyBp
         VWWTnwwfGGar9eaUmoHGjgKMy0+zubfVu884PtbNVzPsfUJ7+pw0SBBpgcnGie9xBw
         +Fsjp4iOt8VzLrLJumsVOitjdom4jx4GpJto38j0=
Date:   Wed, 28 Sep 2022 13:05:20 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Daniel Scally <djrscally@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/5] device property: Keep dev_fwnode() and
 dev_fwnode_const() separate
Message-ID: <YzQqcFZtJn90URrJ@kroah.com>
References: <20220928105746.51208-1-andriy.shevchenko@linux.intel.com>
 <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928105746.51208-2-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 01:57:42PM +0300, Andy Shevchenko wrote:
> It's not fully correct to take a const parameter pointer to a struct
> and return a non-const pointer to a member of that struct.
> 
> Instead, introduce a const version of the dev_fwnode() API which takes
> and returns const pointers and use it where it's applicable.
> 
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Fixes: aade55c86033 ("device property: Add const qualifier to device_get_match_data() parameter")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
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

Ick, no, this is a mess.

Either always return a const pointer, or don't.  Ideally always return a
const pointer, so all we really need is:

const struct fwnode_handle *dev_fwnode(const struct device *dev);

right?

Yes, it will take some unwinding backwards to get there, but please do
that instead of having 2 different functions where the parameter type is
part of the function name.  This isn't the 1980's...

thanks,

greg k-h
