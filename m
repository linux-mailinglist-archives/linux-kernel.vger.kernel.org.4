Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18C564486E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:54:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiLFPyw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiLFPyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:54:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9912E28E
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:54:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24AED617BC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28839C433C1;
        Tue,  6 Dec 2022 15:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670342088;
        bh=QUAz2+vZ/4CFvdyhgvZ2R2gjyA3bbWFrLGeGScV3rgA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MT5aAAuoQpj401dpL9XAqx5U7QM19z4fJcJI661uyzwJfU/fJhiIDopfTFojVY7Cn
         CfXenlPqcVdsEADaoIXsg1H8G/fC8qqf4ZCMGMDhp6gRaOxK3CNU0B7+5dQGipaStE
         6e9dNB50K5L9aIeoP5zAcHjureFjXtXtI5ImgodQ=
Date:   Tue, 6 Dec 2022 16:54:45 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y49lxZMsKrXRciIg@kroah.com>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
 <Y49cGRDBVP3bHJuT@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y49cGRDBVP3bHJuT@casper.infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2022 at 03:13:29PM +0000, Matthew Wilcox wrote:
> On Mon, Dec 05, 2022 at 01:12:03PM +0100, Greg Kroah-Hartman wrote:
> > +/**
> > + * container_of_const - cast a member of a structure out to the containing
> > + *			structure and preserve the const-ness of the pointer
> > + * @ptr:		the pointer to the member
> > + * @type:		the type of the container struct this is embedded in.
> > + * @member:		the name of the member within the struct.
> > + */
> > +#define container_of_const(ptr, type, member)				\
> > +	_Generic(ptr,							\
> > +		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> > +		default: ((type *)container_of(ptr, type, member))	\
> > +	)
> > +
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> I tried doing this:
> 
> +++ b/include/linux/container_of.h
> @@ -15,11 +15,17 @@
>   *
>   * WARNING: any const qualifier of @ptr is lost.
>   */
> -#define container_of(ptr, type, member) ({                             \
> +#define _c_of(ptr, type, member) ({                                    \
>         void *__mptr = (void *)(ptr);                                   \
>         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
>                       __same_type(*(ptr), void),                        \
>                       "pointer type mismatch in container_of()");       \
>         ((type *)(__mptr - offsetof(type, member))); })
> 
> +#define container_of(ptr, type, m)                                     \
> +       _Generic(ptr,                                                   \
> +               const typeof(*(ptr)) *: (const type *)_c_of(ptr, type, m),\
> +               default: ((type *)_c_of(ptr, type, m))                  \
> +       )
> +
>  #endif /* _LINUX_CONTAINER_OF_H */
> 
> (whitespace damaged, yes the kernel-doc is now in the wrong place, etc)
> 
> It found a few problems; just building the mlx5 driver (I happened to be
> doing some work on it in that tree).  We're definitely not ready to do
> that yet, but I'll send a few patches to prepare for it.

Yeah, that's a good long-term goal to have here.  Once everything is
moved over, switching all container_of_const() to just container_of()
should be simple.

thanks,

greg k-h
