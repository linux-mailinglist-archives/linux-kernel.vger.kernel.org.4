Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87E064071F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbiLBMtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:49:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbiLBMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:49:05 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127D4A1A24
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669985343; x=1701521343;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4sAbozV5mhx+vj8Gj66ggwzof9OUnWSCONpcTJkrryQ=;
  b=X/5VFzUR4awaCc+/y8DkMCHmix3gqUIMwmIhIw1pW4coNxTOg4ew+Oxx
   BEQcnIASIJ64pw6AU8C2d+fvcpw7eiPmPWXI+DFZEs6DQfMT8LU+pNhGL
   btqNVTQ6LlzxUFLCIxBM2Nc+g7uTr6tXgzpCzFS7QJI+ywA7NHpNZ9Q7l
   HYdv/5y1p7rLHVqOB5xOTR6ORVy619oo2yVSlPHX/gcGNQUqo2/y8HUWI
   SWbEQNmiYVI5Zxp3OJTRozay59q5NQjleDFM5Y0T6UD7GimoagtjL/qwO
   n2fydw3UnBO3bVHriQ8ELEUzPU7eGGW+nTvy05vPII1j/IN2iPiOL8VTN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342882775"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="342882775"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 04:49:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="819425129"
X-IronPort-AV: E=Sophos;i="5.96,212,1665471600"; 
   d="scan'208";a="819425129"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 04:49:00 -0800
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 9AA8B20363;
        Fri,  2 Dec 2022 14:48:57 +0200 (EET)
Date:   Fri, 2 Dec 2022 12:48:57 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4n0OXlSgW3TUM2h@paasikivi.fi.intel.com>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> container_of does not preserve the const-ness of a pointer that is
> passed into it, which can cause C code that passes in a const pointer to
> get a pointer back that is not const and then scribble all over the data
> in it.  To prevent this, container_of_const() will preserve the const
> status of the pointer passed into it using the newly available _Generic()
> method.
> 
> Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
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

I missed earlier you had four arguments for the macro instead of three.

With default: this can be done with just three:

#define container_of_const(ptr, member_type, member)		\
	_Generic(ptr,							\
		 const typeof(*(ptr)) *: ((const member_type *)container_of(ptr, member_type, member)),\
		 default: ((member_type *)container_of(ptr, member_type, member))	\
	)

The const typeof(*(ptr)) * will match if ptr is const, otherwise default
matches. But you can't have typeof(*(ptr)) * instead of default as the two
types are still the same, hence default.

I've tested this on GCC 10.2.1 and clang 11.0.1.

This should also make it a bit easier for existing users to switch to the
new macro and hopefully eventual rename back to container_of() once all
users have been converted.

> +	_Generic(ptr,							\
> +		const ptr_type *: ((const member_type *)container_of(ptr, member_type, member)),\
> +		ptr_type *: ((member_type *)container_of(ptr, member_type, member))	\
> +	)
> +
>  #endif	/* _LINUX_CONTAINER_OF_H */

-- 
Kind regards,

Sakari Ailus
