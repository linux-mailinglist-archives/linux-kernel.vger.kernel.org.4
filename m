Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB496DCAE1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDJSkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJSkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:40:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3F910CC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:40:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC18B614B3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 18:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A647C433D2;
        Mon, 10 Apr 2023 18:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681152038;
        bh=CEumz/eTP+jhMBEKqKdxMNZV4N36XqtpwtVfHVW/X10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D1v1HtL/Wi1mNHXkHrp00OaWyjInAa/gwzaylMhwUSREq64rDgN1HHTnRWYDNptBF
         1Neu/xkVQu6TPjERkV5ASRz/hraMMlcK62khJEPMvE7/i7USlsuCXbB8/ZDsET84My
         GQ8xPxhVBuEgBrFgwnjALPgYI1D8EAI4afo1SpTc=
Date:   Mon, 10 Apr 2023 20:40:34 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Shunsuke Mie <mie@igel.co.jp>, Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Message-ID: <2023041055-provided-antiquely-bbdb@gregkh>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410080014-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
> On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
> > Fix the build dependency for virtio_test. The virtio_ring that is used from
> > the test requires container_of_const(). Change to use container_of.h kernel
> > header directly and adapt related codes.
> > 
> > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> 
> This is only for next right? That's where container_of_const
> things are I think ...

container_of_const() is in 6.2.


> 
> > ---
> >  tools/include/linux/types.h   |  1 -
> >  tools/virtio/linux/compiler.h |  2 ++
> >  tools/virtio/linux/kernel.h   |  5 +----
> >  tools/virtio/linux/module.h   |  1 -
> >  tools/virtio/linux/uaccess.h  | 11 ++---------
> >  5 files changed, 5 insertions(+), 15 deletions(-)
> > 
> > diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> > index 051fdeaf2670..f1896b70a8e5 100644
> > --- a/tools/include/linux/types.h
> > +++ b/tools/include/linux/types.h
> > @@ -49,7 +49,6 @@ typedef __s8  s8;
> >  #endif
> >  
> >  #define __force
> > -#define __user

Why is this needed?

> >  #define __must_check
> >  #define __cold
> >  
> > diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> > index 2c51bccb97bb..1f3a15b954b9 100644
> > --- a/tools/virtio/linux/compiler.h
> > +++ b/tools/virtio/linux/compiler.h
> > @@ -2,6 +2,8 @@
> >  #ifndef LINUX_COMPILER_H
> >  #define LINUX_COMPILER_H
> >  
> > +#include "../../../include/linux/compiler_types.h"

While I understand your need to not want to duplicate code, what in the
world is this doing?  Why not use the in-kernel compiler.h instead?  Why
are you copying loads of .h files into tools/virtio/?  What is this for
and why not just use the real files so you don't have to even attempt to
try to keep things in sync (hint, they will always be out of sync.)

> > +
> >  #define WRITE_ONCE(var, val) \
> >  	(*((volatile typeof(val) *)(&(var))) = (val))
> >  
> > diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> > index 8b877167933d..6702008f7f5c 100644
> > --- a/tools/virtio/linux/kernel.h
> > +++ b/tools/virtio/linux/kernel.h
> > @@ -10,6 +10,7 @@
> >  #include <stdarg.h>
> >  
> >  #include <linux/compiler.h>
> > +#include "../../../include/linux/container_of.h"

Either do this for all .h files, or not, don't pick and choose.



> >  #include <linux/log2.h>
> >  #include <linux/types.h>
> >  #include <linux/overflow.h>
> > @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
> >  	free((void *)addr);
> >  }
> >  
> > -#define container_of(ptr, type, member) ({			\
> > -	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
> > -	(type *)( (char *)__mptr - offsetof(type,member) );})
> > -
> >  # ifndef likely
> >  #  define likely(x)	(__builtin_expect(!!(x), 1))
> >  # endif
> > diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
> > index 9dfa96fea2b2..5cf39167d47a 100644
> > --- a/tools/virtio/linux/module.h
> > +++ b/tools/virtio/linux/module.h
> > @@ -4,4 +4,3 @@
> >  #define MODULE_LICENSE(__MODULE_LICENSE_value) \
> >  	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
> >  		__MODULE_LICENSE_value
> > -

This change has nothing to do with what you said was happening in this
patch :(

Please be more careful.

> > diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
> > index 991dfb263998..cde2c344b260 100644
> > --- a/tools/virtio/linux/uaccess.h
> > +++ b/tools/virtio/linux/uaccess.h
> > @@ -6,15 +6,10 @@
> >  
> >  extern void *__user_addr_min, *__user_addr_max;
> >  
> > -static inline void __chk_user_ptr(const volatile void *p, size_t size)
> > -{
> > -	assert(p >= __user_addr_min && p + size <= __user_addr_max);
> > -}
> > -

What does this function have to do with container_of()?


> >  #define put_user(x, ptr)					\
> >  ({								\
> >  	typeof(ptr) __pu_ptr = (ptr);				\
> > -	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
> > +	__chk_user_ptr(__pu_ptr);		\

Why are you trying to duplicate in-kernel .h files?

This all doesn't look ok, sorry.

greg k-h
