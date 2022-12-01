Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1104D63FAF5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiLAWv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbiLAWu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:50:56 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AB8CA783
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669935009; x=1701471009;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UeIy8pAdmrZ3lUzO5VL6SSZX6v4M9UmNVytJ9UmGaPM=;
  b=YlguOzN7yotgQRHkqfL2w3G704+5m9S2qAH5SfNh+P7K+L+TJI9ikvyX
   s0l8uiRtpyxV9UmmyGj0t/5m4snp36J819SMuWC5fQS7m8/vJhqyGLZPd
   Hb5RgKXnNJEUFio/aWjOHTUTkB6aksKRWDDwdxhivIC3WSyAj9hd3B6uP
   NIua1V6SBHcAoClGlcWRzHtbMmd4oHQCB/IlHtSXFPpnpFQHI87bOMm1U
   aHmFyH1D9eEpwi/Ni606Cn8DF8C+2cH0w7Sz55qldDIQKBzTPzgTnSvBC
   IGEv/TN1pWIL/y9HzT/0zN8hWy2GwE4xVJEZFEJ5/CU44dwVMzRb60m5G
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="377974544"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="377974544"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 14:50:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="819222654"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="scan'208";a="819222654"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 01 Dec 2022 14:50:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p0sNZ-0036pP-1N;
        Fri, 02 Dec 2022 00:50:05 +0200
Date:   Fri, 2 Dec 2022 00:50:05 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4kvne/Vv+H5pjzW@smile.fi.intel.com>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> container_of does not preserve the const-ness of a pointer that is
> passed into it, which can cause C code that passes in a const pointer to
> get a pointer back that is not const and then scribble all over the data
> in it.  To prevent this, container_of_const() will preserve the const
> status of the pointer passed into it using the newly available _Generic()
> method.
> 
> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>

I believe this tag requires SoB of the co-develper.
The code looks good to me, thanks!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  include/linux/container_of.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> index 2008e9f4058c..3c290e865151 100644
> --- a/include/linux/container_of.h
> +++ b/include/linux/container_of.h
> @@ -22,4 +22,18 @@
>  		      "pointer type mismatch in container_of()");	\
>  	((type *)(__mptr - offsetof(type, member))); })
>  
> +/**
> + * container_of_const - cast a member of a structure out to the containing
> + *			structure and preserve the const-ness of the pointer
> + * @ptr_type:		the type of the pointer @ptr
> + * @ptr:		the pointer to the member
> + * @member_type:	the type of the container struct this is embedded in.
> + * @member:		the name of the member within the struct.
> + */
> +#define container_of_const(ptr_type, ptr, member_type, member)		\
> +	_Generic(ptr,							\
> +		const ptr_type *: ((const member_type *)container_of(ptr, member_type, member)),\
> +		ptr_type *: ((member_type *)container_of(ptr, member_type, member))	\
> +	)
> +
>  #endif	/* _LINUX_CONTAINER_OF_H */
> -- 
> 2.38.1
> 

-- 
With Best Regards,
Andy Shevchenko


