Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AF76B107F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjCHR5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCHR5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:57:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5EA274A3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:57:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96A5AB8199F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 17:57:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE73C433D2;
        Wed,  8 Mar 2023 17:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678298236;
        bh=m3Ym7nyHjUGKGS9tPqHky6t9ZPwcNT8ulFBSAx6bJw8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P545LL947wyGuEZT18TXPzDdsSX2pg30D50TbdPui1lDPk6LMK5m39hr/2y5bgnOQ
         qf1zuRvmx19qf/iUmzsbqqWaHWESOB+OdpmzlWxLX02uPfJaQFpf86N2GBs0Z5FVan
         OGrDV2vg3mezszRD+aWjpUUfq50D7k8bgXhHqzb4=
Date:   Wed, 8 Mar 2023 18:57:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] container_of: add type safety
Message-ID: <ZAjMeVHI1r8jFW/X@kroah.com>
References: <c3611f95862a7f30d67d1c3cc56aaf7bb93d3b59.1678296892.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3611f95862a7f30d67d1c3cc56aaf7bb93d3b59.1678296892.git.mst@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 12:35:03PM -0500, Michael S. Tsirkin wrote:
> Using a wrong member in container_of will result in an error.
> No so for container_of_const - it is just a cast so will
> happily give you a wrong pointer.
> 
> Use logic from container_of to add safety.
> 
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Jason Gunthorpe <jgg@nvidia.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Rafael J. Wysocki <rafael@kernel.org>
> Link: https://lore.kernel.org/r/20221205121206.166576-1-gregkh@linuxfoundation.org

That's the wrong link, that's not this patch, that was an old patch.

> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

I did not sign off on this.  NEVER do that, you just made a legal
statement in my name, why?

Why did you not sign off on it?

totally confused...

> ---
>  include/linux/container_of.h | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 1d898f9158b4..5d87faf72e0a 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -29,10 +29,13 @@
>   * @type:		the type of the container struct this is embedded in.
>   * @member:		the name of the member within the struct.
>   */
> -#define container_of_const(ptr, type, member)				\
> +#define container_of_const(ptr, type, member) ({			\
> +	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
> +		      __same_type(*(ptr), void),			\
> +		      "pointer type mismatch in container_of()");	\

Why is this needed because:


>  	_Generic(ptr,							\
>  		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
>  		default: ((type *)container_of(ptr, type, member))	\

container_of() is used here, so shouldn't the assert trigger there if
you get things wrong?

So why is this change needed at all?

thanks,

greg k-h
