Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183886DC67D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 14:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjDJMBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 08:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDJMBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 08:01:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F62C5591
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681128040;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uYbUcWzmnC6xP9q2tfvKVDk2jXko1XUr34Hbcal4y6Q=;
        b=erqxKOgIxY/4UI3WE6CK+XJ97jF/4JUyod9UKsUQOB+k2nCCZS4IH8VijAzoCW6BROFJrN
        w++EXufUVpMTnsfAtwm0lC6WilfKCexp+5xWAfS0ndwOMxemny6y+QK3mdfZsmyK5mEu9v
        LlPIzECvSVt/lpwusSzrX9HY+Cu1de8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-YUw_HP1mOVieoqSt7H8u5g-1; Mon, 10 Apr 2023 08:00:38 -0400
X-MC-Unique: YUw_HP1mOVieoqSt7H8u5g-1
Received: by mail-wm1-f69.google.com with SMTP id gw11-20020a05600c850b00b003ee8db23ef9so3780256wmb.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 05:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681128037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYbUcWzmnC6xP9q2tfvKVDk2jXko1XUr34Hbcal4y6Q=;
        b=D3zNPTOYbrSiYjgRL9MdDoDzFbB8mkIIEWrp5ZCtHTl1+Dv6t4RQrfIBJsF2lPMkkL
         WyFe2FtYbxBShq5QnhfCbZeB3eZhaU0vVnltCB9YGMjAbd6P0kg+MlYRm4JUdyc9FTAY
         9Uwm7GfA1BnYN9otnQ86rUOH0YQLruDHjVLKk0WEFtnQnbTbQEXWS2q61Qc/LcSNIk4/
         +u4/PIShU2zeDET9wvGC1CsGjALAbLq+Cf90DxJqtMl0nhPenmahu/FsITgk+TE/yP76
         odX/y/tpKgLl3JNPlKR2pJQyTf8BA5/F7zgynUZ3S+ZPwiAunXLESCrZFzhLDwcedjVm
         a8ZA==
X-Gm-Message-State: AAQBX9cnwqAKTbHy24NJMHIx06fuFY6LtmUURjjMDjSkh8M6HZxTpS6V
        sA9L7qZ9hl8EKtn+qunLggo2qW+mSvNNMEC+u2U0htjWpufsu71HYrFFfbt0pZ4wprVyCRzmaN/
        YlA9CkxWd7T1q1bs/EvO/3l1I
X-Received: by 2002:a7b:cd87:0:b0:3ee:19b4:a2e6 with SMTP id y7-20020a7bcd87000000b003ee19b4a2e6mr7360852wmj.19.1681128037673;
        Mon, 10 Apr 2023 05:00:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350a/ArrmW82/z+jHxJ0CUCu9vS40m/5App8/Nk02/y7YrRf//bQIyH2736FsQOU3Nm36El47iQ==
X-Received: by 2002:a7b:cd87:0:b0:3ee:19b4:a2e6 with SMTP id y7-20020a7bcd87000000b003ee19b4a2e6mr7360831wmj.19.1681128037322;
        Mon, 10 Apr 2023 05:00:37 -0700 (PDT)
Received: from redhat.com ([2.52.31.213])
        by smtp.gmail.com with ESMTPSA id q5-20020a7bce85000000b003ede3e54ed7sm13521872wmj.6.2023.04.10.05.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 05:00:36 -0700 (PDT)
Date:   Mon, 10 Apr 2023 08:00:33 -0400
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
Subject: Re: [PATCH v2 2/2] tools/virtio: fix build caused by virtio_ring
 changes
Message-ID: <20230410080014-mutt-send-email-mst@kernel.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230410112845.337212-2-mie@igel.co.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
> Fix the build dependency for virtio_test. The virtio_ring that is used from
> the test requires container_of_const(). Change to use container_of.h kernel
> header directly and adapt related codes.
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

This is only for next right? That's where container_of_const
things are I think ...

> ---
>  tools/include/linux/types.h   |  1 -
>  tools/virtio/linux/compiler.h |  2 ++
>  tools/virtio/linux/kernel.h   |  5 +----
>  tools/virtio/linux/module.h   |  1 -
>  tools/virtio/linux/uaccess.h  | 11 ++---------
>  5 files changed, 5 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> index 051fdeaf2670..f1896b70a8e5 100644
> --- a/tools/include/linux/types.h
> +++ b/tools/include/linux/types.h
> @@ -49,7 +49,6 @@ typedef __s8  s8;
>  #endif
>  
>  #define __force
> -#define __user
>  #define __must_check
>  #define __cold
>  
> diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> index 2c51bccb97bb..1f3a15b954b9 100644
> --- a/tools/virtio/linux/compiler.h
> +++ b/tools/virtio/linux/compiler.h
> @@ -2,6 +2,8 @@
>  #ifndef LINUX_COMPILER_H
>  #define LINUX_COMPILER_H
>  
> +#include "../../../include/linux/compiler_types.h"
> +
>  #define WRITE_ONCE(var, val) \
>  	(*((volatile typeof(val) *)(&(var))) = (val))
>  
> diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> index 8b877167933d..6702008f7f5c 100644
> --- a/tools/virtio/linux/kernel.h
> +++ b/tools/virtio/linux/kernel.h
> @@ -10,6 +10,7 @@
>  #include <stdarg.h>
>  
>  #include <linux/compiler.h>
> +#include "../../../include/linux/container_of.h"
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
> index 9dfa96fea2b2..5cf39167d47a 100644
> --- a/tools/virtio/linux/module.h
> +++ b/tools/virtio/linux/module.h
> @@ -4,4 +4,3 @@
>  #define MODULE_LICENSE(__MODULE_LICENSE_value) \
>  	static __attribute__((unused)) const char *__MODULE_LICENSE_name = \
>  		__MODULE_LICENSE_value
> -
> diff --git a/tools/virtio/linux/uaccess.h b/tools/virtio/linux/uaccess.h
> index 991dfb263998..cde2c344b260 100644
> --- a/tools/virtio/linux/uaccess.h
> +++ b/tools/virtio/linux/uaccess.h
> @@ -6,15 +6,10 @@
>  
>  extern void *__user_addr_min, *__user_addr_max;
>  
> -static inline void __chk_user_ptr(const volatile void *p, size_t size)
> -{
> -	assert(p >= __user_addr_min && p + size <= __user_addr_max);
> -}
> -
>  #define put_user(x, ptr)					\
>  ({								\
>  	typeof(ptr) __pu_ptr = (ptr);				\
> -	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
> +	__chk_user_ptr(__pu_ptr);		\
>  	WRITE_ONCE(*(__pu_ptr), x);				\
>  	0;							\
>  })
> @@ -22,7 +17,7 @@ static inline void __chk_user_ptr(const volatile void *p, size_t size)
>  #define get_user(x, ptr)					\
>  ({								\
>  	typeof(ptr) __pu_ptr = (ptr);				\
> -	__chk_user_ptr(__pu_ptr, sizeof(*__pu_ptr));		\
> +	__chk_user_ptr(__pu_ptr);		\
>  	x = READ_ONCE(*(__pu_ptr));				\
>  	0;							\
>  })
> @@ -37,7 +32,6 @@ static void volatile_memcpy(volatile char *to, const volatile char *from,
>  static inline int copy_from_user(void *to, const void __user volatile *from,
>  				 unsigned long n)
>  {
> -	__chk_user_ptr(from, n);
>  	volatile_memcpy(to, from, n);
>  	return 0;
>  }
> @@ -45,7 +39,6 @@ static inline int copy_from_user(void *to, const void __user volatile *from,
>  static inline int copy_to_user(void __user volatile *to, const void *from,
>  			       unsigned long n)
>  {
> -	__chk_user_ptr(to, n);
>  	volatile_memcpy(to, from, n);
>  	return 0;
>  }
> -- 
> 2.25.1

