Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5D76DC602
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 12:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjDJK7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 06:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjDJK7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 06:59:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61756210E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681124309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=glOAAMls6WC16IZVydxUU2GkS2QJLlWvNTuOfRiQfL8=;
        b=aXcycqtu4JK4OmP9vdbAduF3rcKyL1o0HNwcegLnB2mZoGmUuYDY/4XnlwfJ9WAj0B8yOP
        iebl5kkO+QC1u56S8AovrannVUInQqSltMQ9tHE06C6HVE/hADT/GcksnHAZxeeJ2NKAIU
        orr/O734MwUHy8wEge3AI7xGnKSEXII=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-dKKqB2lmPFGdGWt7iCsGBA-1; Mon, 10 Apr 2023 06:58:28 -0400
X-MC-Unique: dKKqB2lmPFGdGWt7iCsGBA-1
Received: by mail-wr1-f69.google.com with SMTP id i18-20020adfa512000000b002efac436771so866504wrb.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 03:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681124307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glOAAMls6WC16IZVydxUU2GkS2QJLlWvNTuOfRiQfL8=;
        b=66/xfFb+4Xg9/v9D3qL57S3wYM26oqfXgyUo4pb5VMR7BvkZwxEPB5k/Q8gGmGSQtC
         W4Mgtd9O0x7VdmPpMIGU3QnqPm9HUU8bH4RdRBf/QYQTjcE2ZuFsJI+WL625VHeOmk13
         htc9wldHaANTVazxb3LRDaBGNPsTTiWJdQR/KAtkHAvoxNt3sNZHEh2pnTZzpnczV6oA
         8zqt0SkjZgnFcB3r4Zzhvqnru6JrqiYh2TwKzPFTieVpkTEtmdJHYj38XpCDj51nKUou
         d99LIBo01/G4vtt+9d58yPJ5GuelpyfPIKouh2cIMyHXAPSVJFVwrP7hgXKRT/uUgcRm
         7wkg==
X-Gm-Message-State: AAQBX9fTSbxiX/z9kue5KINNgaA9dLyLAoOB2ipbS7Mkn9KLihkKotpw
        Z/O1fWRfhmSe4zMR90jlk3jSK7YTQ5shSxYedFdnzCvLuVRonTTsZdiXpfhdgnN5nHx8fsycFVq
        /Qolx8/HyqXuZWCrOi7dOsglJ+6KW7O3Sn1w=
X-Received: by 2002:a5d:464b:0:b0:2f2:4790:fccc with SMTP id j11-20020a5d464b000000b002f24790fcccmr1018186wrs.46.1681124306905;
        Mon, 10 Apr 2023 03:58:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350bd4fswTngv9D8LVrb2rgueB7iNvpSrMfQhv6Yla9+QGzfcDApE0HVt8YaNSvpM/0ua8VPkHg==
X-Received: by 2002:a5d:464b:0:b0:2f2:4790:fccc with SMTP id j11-20020a5d464b000000b002f24790fcccmr1018171wrs.46.1681124306593;
        Mon, 10 Apr 2023 03:58:26 -0700 (PDT)
Received: from redhat.com ([2.52.31.213])
        by smtp.gmail.com with ESMTPSA id n5-20020adfe345000000b002efb139ce72sm8423812wrj.36.2023.04.10.03.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 03:58:26 -0700 (PDT)
Date:   Mon, 10 Apr 2023 06:58:22 -0400
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
Message-ID: <20230410064435-mutt-send-email-mst@kernel.org>
References: <20230410092419.302932-1-mie@igel.co.jp>
 <20230410054259-mutt-send-email-mst@kernel.org>
 <cd2619b1-5d0b-1e7e-12bd-bcb9dcb5c533@igel.co.jp>
 <a7332e82-27f6-8acd-2ff2-498eb66ea6e7@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7332e82-27f6-8acd-2ff2-498eb66ea6e7@igel.co.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 07:56:13PM +0900, Shunsuke Mie wrote:
> 
> On 2023/04/10 19:00, Shunsuke Mie wrote:
> > 
> > On 2023/04/10 18:46, Michael S. Tsirkin wrote:
> > > On Mon, Apr 10, 2023 at 06:24:19PM +0900, Shunsuke Mie wrote:
> > > > Fix the build dependency for virtio_test. virtio_ring requires
> > > > container_of_const() and struce device.
> > > > 
> > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > > ---
> > > >   tools/include/linux/container_of.h | 36
> > > > ++++++++++++++++++++++++++++++
> > > >   tools/virtio/linux/compiler.h      |  3 +++
> > > >   tools/virtio/linux/kernel.h        |  5 +----
> > > >   tools/virtio/linux/module.h        |  1 +
> > > >   4 files changed, 41 insertions(+), 4 deletions(-)
> > > >   create mode 100644 tools/include/linux/container_of.h
> > > > 
> > > > diff --git a/tools/include/linux/container_of.h
> > > > b/tools/include/linux/container_of.h
> > > > new file mode 100644
> > > > index 000000000000..06e293b7cfda
> > > > --- /dev/null
> > > > +++ b/tools/include/linux/container_of.h
> > > > @@ -0,0 +1,36 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef _LINUX_CONTAINER_OF_H
> > > > +#define _LINUX_CONTAINER_OF_H
> > > > +
> > > > +#include <linux/build_bug.h>
> > > > +#include <linux/stddef.h>
> > > > +
> > > > +/**
> > > > + * container_of - cast a member of a structure out to the
> > > > containing structure
> > > > + * @ptr:    the pointer to the member.
> > > > + * @type:    the type of the container struct this is embedded in.
> > > > + * @member:    the name of the member within the struct.
> > > > + *
> > > > + * WARNING: any const qualifier of @ptr is lost.
> > > > + */
> > > > +#define container_of(ptr, type, member) ({                \
> > > > +    void *__mptr = (void *)(ptr);                    \
> > > > +    static_assert(__same_type(*(ptr), ((type *)0)->member) ||    \
> > > > +              __same_type(*(ptr), void),            \
> > > > +              "pointer type mismatch in container_of()"); \
> > > > +    ((type *)(__mptr - offsetof(type, member))); })
> > > > +
> > > > +/**
> > > > + * container_of_const - cast a member of a structure out to the
> > > > containing
> > > > + *            structure and preserve the const-ness of the pointer
> > > > + * @ptr:        the pointer to the member
> > > > + * @type:        the type of the container struct this is embedded in.
> > > > + * @member:        the name of the member within the struct.
> > > > + */
> > > > +#define container_of_const(ptr, type, member) \
> > > > +    _Generic(ptr,                            \
> > > > +        const typeof(*(ptr)) *: ((const type
> > > > *)container_of(ptr, type, member)),\
> > > > +        default: ((type *)container_of(ptr, type, member)) \
> > > > +    )
> > > > +
> > > > +#endif    /* _LINUX_CONTAINER_OF_H */
> > > 
> > > Please just do
> > > #include "../../../include/linux/container_of.h"
> > > instead.
> > Okey, I'll do that.
> > > 
> > > 
> > > > diff --git a/tools/virtio/linux/compiler.h
> > > > b/tools/virtio/linux/compiler.h
> > > > index 2c51bccb97bb..ac27b3ea6e67 100644
> > > > --- a/tools/virtio/linux/compiler.h
> > > > +++ b/tools/virtio/linux/compiler.h
> > > > @@ -8,4 +8,7 @@
> > > >   #define READ_ONCE(var) (*((volatile typeof(var) *)(&(var))))
> > > >     #define __aligned(x) __attribute((__aligned__(x)))
> > > > +
> > > > +#define __same_type(a, b)
> > > > __builtin_types_compatible_p(typeof(a), typeof(b))
> > > > +
> > > >   #endif
> > > #include "../../../include/linux/compiler_types.h" instead?
> > I'll try it.
> > > > diff --git a/tools/virtio/linux/kernel.h b/tools/virtio/linux/kernel.h
> > > > index 8b877167933d..3cd20cb92649 100644
> > > > --- a/tools/virtio/linux/kernel.h
> > > > +++ b/tools/virtio/linux/kernel.h
> > > > @@ -10,6 +10,7 @@
> > > >   #include <stdarg.h>
> > > >     #include <linux/compiler.h>
> > > > +#include <linux/container_of.h>
> > > >   #include <linux/log2.h>
> > > >   #include <linux/types.h>
> > > >   #include <linux/overflow.h>
> > > > @@ -107,10 +108,6 @@ static inline void free_page(unsigned long addr)
> > > >       free((void *)addr);
> > > >   }
> > > >   -#define container_of(ptr, type, member) ({            \
> > > > -    const typeof( ((type *)0)->member ) *__mptr = (ptr);    \
> > > > -    (type *)( (char *)__mptr - offsetof(type,member) );})
> > > > -
> > > >   # ifndef likely
> > > >   #  define likely(x)    (__builtin_expect(!!(x), 1))
> > > >   # endif
> > > > diff --git a/tools/virtio/linux/module.h b/tools/virtio/linux/module.h
> > > > index 9dfa96fea2b2..e2e791dbd104 100644
> > > > --- a/tools/virtio/linux/module.h
> > > > +++ b/tools/virtio/linux/module.h
> > > > @@ -5,3 +5,4 @@
> > > >       static __attribute__((unused)) const char
> > > > *__MODULE_LICENSE_name = \
> > > >           __MODULE_LICENSE_value
> > > >   +struct device;
> > > 
> > > It's not there in include/linux/module - pls put it in the
> > > same here where it is for linux.
> > I understood. I'll add some files that has the definition.
> 
> In vringh.c, 'struct device' is used in virtio_ring.h. Upon investigating
> the preprocessed file, it was
> 
> discovered that 'struct device' is defined in bitmap.h, which is included
> from architecture-specific headers.
> 
> On x86, the nesting includes
> 
> 'linux/module.h' -> ... -> 'arch/x86/include/asm/msr.h' ->
> 'arch/x86/include/asm/cpumask.h' -> 'linux/cpumask.h' -> 'linux/bitmap.h'.
> 
> Could you advise on the appropriate way to include this file?

Let's just add struct device; in virtio_ring.h, make it
self-sufficient.


> > > > -- 
> > > > 2.25.1
> > 
> > Best regards,
> > 
> > Shunsuke.
> > 

