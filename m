Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2C26DC554
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 11:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbjDJJr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 05:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbjDJJr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 05:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C667199
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681120005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rUKnqMQGG9884/VZ+x9wYRorx2PFxtJF40gE4kS2CUs=;
        b=Sn0CmEcdhGzyqrQ484nODuMtJwQVfdELeMpkwDOiodo59vEcYY598d9S+q9Z3kh6/EtFni
        pnPa25/7jIVClivlXnW7YeBWj3hNrIGrGPWcFyxaRGMhVQ9QzkfNxLJD4F8aoxyLxmfvRv
        Slvx+cjPP3+jlCxtfqS5pXRNXDzSZaY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-s1OvYzLiMy-Q2XoXKzRo3w-1; Mon, 10 Apr 2023 05:46:44 -0400
X-MC-Unique: s1OvYzLiMy-Q2XoXKzRo3w-1
Received: by mail-wm1-f72.google.com with SMTP id h8-20020a05600c314800b003ef649aa8c7so408399wmo.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 02:46:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681120003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUKnqMQGG9884/VZ+x9wYRorx2PFxtJF40gE4kS2CUs=;
        b=S4OXuL5fPqCJyC1NqDVv0cdXOA03snebyFSfchteQU9tmTBrwlFlgB+Sc9RQXGgEiM
         9qRhEkr1iPq+zviz6phvG4Y5sI2h/f3bu5c3TnSkhWYIohymk/uAjtgUsxI0sRB6MtDN
         KH//08NszU8yS7OyOQFUbjrIRmcYymfA/Z85rGdx0DEvmmZRGs0RjgKYwoLLrErUkWSn
         w7uINN3z9hIr2UwNAq33YhO9x3s2QBtNaqACP8zn+MidGjZ5cCleBvK4NoqzlWwZmT1m
         yLcbLw3px4UDKbwVxQ4zKyrJnorFKQRy4+JMfU4YCsWsw6IqsXD5uSqaT9eIXEe9t4zS
         613w==
X-Gm-Message-State: AAQBX9fVdvBJ+MsGIMyjZ6R2obTaQHGAO5gYrINyBhpjauuozWL9a8aG
        ntOuKfoEJw8iUbAzbycnoijNN7350PtG/pqyPL8oNH5oKoAP/e8ReK87AvhDyT/uOEOjmmBuIXo
        8B5qT0BLn4fmUR6B3Tb38DrI4
X-Received: by 2002:a1c:4c09:0:b0:3eb:2de8:b739 with SMTP id z9-20020a1c4c09000000b003eb2de8b739mr6936528wmf.37.1681120002997;
        Mon, 10 Apr 2023 02:46:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350Yz2fT9NWgRbXeQa18dRGnweg6kZuzRjdxbvB//hO+uRDL3F6E5geHe+Z0GWDjCUgmQjPJsZQ==
X-Received: by 2002:a1c:4c09:0:b0:3eb:2de8:b739 with SMTP id z9-20020a1c4c09000000b003eb2de8b739mr6936511wmf.37.1681120002685;
        Mon, 10 Apr 2023 02:46:42 -0700 (PDT)
Received: from redhat.com ([2.52.31.213])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b003ef7058ea02sm17043791wmq.29.2023.04.10.02.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 02:46:42 -0700 (PDT)
Date:   Mon, 10 Apr 2023 05:46:38 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Jason Wang <jasowang@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] tools/virtio: fix build caused by virtio_ring changes
Message-ID: <20230410054259-mutt-send-email-mst@kernel.org>
References: <20230410092419.302932-1-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410092419.302932-1-mie@igel.co.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 06:24:19PM +0900, Shunsuke Mie wrote:
> Fix the build dependency for virtio_test. virtio_ring requires
> container_of_const() and struce device.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> ---
>  tools/include/linux/container_of.h | 36 ++++++++++++++++++++++++++++++
>  tools/virtio/linux/compiler.h      |  3 +++
>  tools/virtio/linux/kernel.h        |  5 +----
>  tools/virtio/linux/module.h        |  1 +
>  4 files changed, 41 insertions(+), 4 deletions(-)
>  create mode 100644 tools/include/linux/container_of.h
> 
> diff --git a/tools/include/linux/container_of.h b/tools/include/linux/container_of.h
> new file mode 100644
> index 000000000000..06e293b7cfda
> --- /dev/null
> +++ b/tools/include/linux/container_of.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_CONTAINER_OF_H
> +#define _LINUX_CONTAINER_OF_H
> +
> +#include <linux/build_bug.h>
> +#include <linux/stddef.h>
> +
> +/**
> + * container_of - cast a member of a structure out to the containing structure
> + * @ptr:	the pointer to the member.
> + * @type:	the type of the container struct this is embedded in.
> + * @member:	the name of the member within the struct.
> + *
> + * WARNING: any const qualifier of @ptr is lost.
> + */
> +#define container_of(ptr, type, member) ({				\
> +	void *__mptr = (void *)(ptr);					\
> +	static_assert(__same_type(*(ptr), ((type *)0)->member) ||	\
> +		      __same_type(*(ptr), void),			\
> +		      "pointer type mismatch in container_of()");	\
> +	((type *)(__mptr - offsetof(type, member))); })
> +
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
> +#endif	/* _LINUX_CONTAINER_OF_H */


Please just do
#include "../../../include/linux/container_of.h"
instead.


> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> index 2c51bccb97bb..ac27b3ea6e67 100644
> --- a/tools/virtio/linux/compiler.h
> +++ b/tools/virtio/linux/compiler.h
> @@ -8,4 +8,7 @@
>  #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
>  
>  #define __aligned(x) __attribute((__aligned__(x)))
> +
> +#define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
> +
>  #endif

#include "../../../include/linux/compiler_types.h" instead?

> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 8b877167933d..3cd20cb92649 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -10,6 +10,7 @@
>  #include <stdarg.h>
>  
>  #include <linux/compiler.h>
> +#include <linux/container_of.h>
>  #include <linux/log2.h>
>  #include <linux/types.h>
>  #include <linux/overflow.h>
> @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
>  	free((void *)addr);
>  }
>  
> -#define container_of(ptr, type, member) ({			\
> -	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
> -	(type *)( (char *)__mptr - offsetof(type,member) );})
> -
>  # ifndef likely
>  #  define likely(x)	(__builtin_expect(!!(x), 1))
>  # endif
> diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
> index 9dfa96fea2b2..e2e791dbd104 100644
> --- a/tools/virtio/linux/module.h
> +++ b/tools/virtio/linux/module.h
> @@ -5,3 +5,4 @@
>  	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
>  		__MODULE_LICENSE_value
>  
> +struct device;


It's not there in include/linux/module - pls put it in the
same here where it is for linux.

> -- 
> 2.25.1

