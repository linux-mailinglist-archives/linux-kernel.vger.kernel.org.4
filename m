Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ADB6436C6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 22:25:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiLEVYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 16:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbiLEVYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 16:24:32 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A412CC9F
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 13:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670275461; x=1701811461;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JKW51AkPX6aovqq8UwYtair/CStxY2nC7HiEsg6lAUo=;
  b=dodniG/3sWa7pzG9TCcLxMHpy/BC+tnYIyRbo4zaj9nROFI2edWIVd+X
   AcSoFT/eDV6F0SC4R2Vo9R4P/0zvur0tAPDjtsfwiCPsPxNATxPVM8oHz
   LVpfyF6BdSu7JUmTajuCMUXIRifIpA//kTBoPye81iZ5lsWv+sniklsIK
   7/QpR3xNgpqMIvakcNGLYdIzuNLh/LNU50FgUGhzYImk14Lu7iBRp3qT3
   9WR8GK8T77650UUWpsb3EoSn/TrvWLm/zcaesITEKA7esofvmjs61UGIc
   YOzNt+ffMVo8aGJsXLl/MGuioyJabR0vcqin/OwGnSVu//CWMTCSYADgz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="318327682"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="318327682"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:24:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="623657701"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="623657701"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:24:16 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id EB94A20363;
        Mon,  5 Dec 2022 23:24:13 +0200 (EET)
Date:   Mon, 5 Dec 2022 21:24:13 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y45hfSpXkgU/YFr1@paasikivi.fi.intel.com>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205121206.166576-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Mon, Dec 05, 2022 at 01:12:03PM +0100, Greg Kroah-Hartman wrote:
> container_of does not preserve the const-ness of a pointer that is
> passed into it, which can cause C code that passes in a const pointer to
> get a pointer back that is not const and then scribble all over the data
> in it.  To prevent this, container_of_const() will preserve the const
> status of the pointer passed into it using the newly available _Generic()
> method.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Suggested-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: - removed one parameter, now matches container_of(), thanks to
>       suggestion from Sakari
>     - changed Jason's tag to suggested-by and reviewed-by
>     - added Andy's tag

Thanks for the update. For the set:

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>

> 
>  include/linux/container_of.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 2008e9f4058c..1d898f9158b4 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -22,4 +22,17 @@
>  		      "pointer type mismatch in container_of()");	\
>  	((type *)(__mptr - offsetof(type, member))); })
>  
> +/**
> + * container_of_const - cast a member of a structure out to the containing
> + *			structure and preserve the const-ness of the pointer
> + * @ptr:		the pointer to the member
> + * @type:		the type of the container struct this is embedded in.
> + * @member:		the name of the member within the struct.
> + */
> +#define container_of_const(ptr, type, member)				\
> +	_Generic(ptr,							\
> +		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> +		default: ((type *)container_of(ptr, type, member))	\
> +	)
> +
>  #endif	/* _LINUX_CONTAINER_OF_H */

-- 
Kind regards,

Sakari Ailus
