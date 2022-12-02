Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EEA640A9D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiLBQZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233497AbiLBQZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:25:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1FD101CC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 08:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 84FBEB821E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 16:24:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C19B9C433D6;
        Fri,  2 Dec 2022 16:24:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669998285;
        bh=uqX5oHSQxePTMTDs8aLN1oxheczLbhv31aeoAxjDn7k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWL54NQ1XK/WH7crr7nzwjBZmAc4cSwOcqBWBGR4+xJlnc6jiBafNIFUa6gpRNGMR
         SLBFrXVXIsHcY549QNioHwVK8eEQ186GpWuEs2x5hTNxW2J3rm9s4RNlwyj8BENHIC
         k2NJO/IDo59awXns49NxumBySXb7cnJuIxqpkOY4=
Date:   Fri, 2 Dec 2022 17:24:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y4omyqfKeUJH83VR@kroah.com>
References: <20221201193057.1195255-1-gregkh@linuxfoundation.org>
 <Y4n0OXlSgW3TUM2h@paasikivi.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4n0OXlSgW3TUM2h@paasikivi.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 12:48:57PM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> On Thu, Dec 01, 2022 at 08:30:54PM +0100, Greg Kroah-Hartman wrote:
> > container_of does not preserve the const-ness of a pointer that is
> > passed into it, which can cause C code that passes in a const pointer to
> > get a pointer back that is not const and then scribble all over the data
> > in it.  To prevent this, container_of_const() will preserve the const
> > status of the pointer passed into it using the newly available _Generic()
> > method.
> > 
> > Co-developed-by: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  include/linux/container_of.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/linux/container_of.h b/include/linux/container_of.h
> > index 2008e9f4058c..3c290e865151 100644
> > --- a/include/linux/container_of.h
> > +++ b/include/linux/container_of.h
> > @@ -22,4 +22,18 @@
> >  		      "pointer type mismatch in container_of()");	\
> >  	((type *)(__mptr - offsetof(type, member))); })
> >  
> > +/**
> > + * container_of_const - cast a member of a structure out to the containing
> > + *			structure and preserve the const-ness of the pointer
> > + * @ptr_type:		the type of the pointer @ptr
> > + * @ptr:		the pointer to the member
> > + * @member_type:	the type of the container struct this is embedded in.
> > + * @member:		the name of the member within the struct.
> > + */
> > +#define container_of_const(ptr_type, ptr, member_type, member)		\
> 
> I missed earlier you had four arguments for the macro instead of three.
> 
> With default: this can be done with just three:
> 
> #define container_of_const(ptr, member_type, member)		\
> 	_Generic(ptr,							\
> 		 const typeof(*(ptr)) *: ((const member_type *)container_of(ptr, member_type, member)),\
> 		 default: ((member_type *)container_of(ptr, member_type, member))	\
> 	)
> 
> The const typeof(*(ptr)) * will match if ptr is const, otherwise default
> matches. 

I had tried to use typeof before, your way is easier, thanks, I couldn't
get it to work myself...

> But you can't have typeof(*(ptr)) * instead of default as the two
> types are still the same, hence default.

Ah.  Ok, I really didn't want to use default, and that's probably why it
wasn't working for me.

> I've tested this on GCC 10.2.1 and clang 11.0.1.
> 
> This should also make it a bit easier for existing users to switch to the
> new macro and hopefully eventual rename back to container_of() once all
> users have been converted.

True.  Ok, I'll try this later tomorrow and send out a new version if
all goes well, thanks!

greg k-h
