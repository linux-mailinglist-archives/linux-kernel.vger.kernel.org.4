Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18ED6DD300
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDKGjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjDKGjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F8603A9F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681195082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKDcI1gvQ3K+wzH4N+4hPHJptgLgRNp4guou9vuTChs=;
        b=T3UgJh22Rhd7mBY5qk5fL+OyaXc6NDYG7aMg0aZr0qyAVPt9/T3hFJA7fELeRbIqYLDaEx
        1Wx5EdSIiBsXBqeAcbXzVHg09Nj+eNYOcfJJA5YLgZZ5KStxdIJeMYR1ub//qcQxrqtc1k
        zdIVuFKTuDdzr7s5oHQVW2Nj7LAZTSg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-QPJ4Iu04NSa667fMCbZqNQ-1; Tue, 11 Apr 2023 02:38:00 -0400
X-MC-Unique: QPJ4Iu04NSa667fMCbZqNQ-1
Received: by mail-wm1-f70.google.com with SMTP id h8-20020a05600c314800b003ef649aa8c7so984903wmo.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:38:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKDcI1gvQ3K+wzH4N+4hPHJptgLgRNp4guou9vuTChs=;
        b=SYjta6kZzShXreHIkX2Pf4pLBEv6MmrANFtEEoqZZcdaiivqQ1RtDG2ZOWPc2l2d0C
         Tf+OiPfDqAjalB6QJCMpjtMVpQw3uVrYp1V5c9fpFYvBjcrhp6HwuP6JQuVS3r1EwNrU
         ekvGjOCT4p8E+oaXx9I3M6dMs09I6A4XFGN8aikOQYdwOxLtIxo3EdJBv4IrAO/xDFSR
         vZT9NiR+s5dHOjAAYABue+QUQ1SAOEzDInaRw7p5cttCNE5ktz7QM6kJkCp0rMtl8rY8
         /T4lJAlqny9++j4UHObAjOcqpJfrXhcMw/WqTGS6ZwDBK/vQqY1Vra6U/AWZ08d8ioqt
         IIYg==
X-Gm-Message-State: AAQBX9fhL2egAgElxYlyFgYf6K7HCGnTEaAq8h+huJ3gzJnzTEqOiMP5
        ekAMfc32gA2U4dvfAh6q4uTIiqaxygAIzx71LMcVBSAZEQlglwTLvsdyvuab8pRmIjR4l6OzZUb
        fSUzYR6NV0cclLVIXt1IOU4OZ
X-Received: by 2002:a05:600c:21c8:b0:3ed:bc83:3745 with SMTP id x8-20020a05600c21c800b003edbc833745mr8213674wmj.25.1681195079744;
        Mon, 10 Apr 2023 23:37:59 -0700 (PDT)
X-Google-Smtp-Source: AKy350YXNewQyOu43+eG068hYZmpbH+ChoY9dkJCHQTitIMFv54+uzJLrVQF3Nod5Uvn4pUYmyhunw==
X-Received: by 2002:a05:600c:21c8:b0:3ed:bc83:3745 with SMTP id x8-20020a05600c21c800b003edbc833745mr8213650wmj.25.1681195079399;
        Mon, 10 Apr 2023 23:37:59 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id p15-20020a1c740f000000b003edc11c2ecbsm15990461wmc.4.2023.04.10.23.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 23:37:58 -0700 (PDT)
Date:   Tue, 11 Apr 2023 02:37:54 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Shunsuke Mie <mie@igel.co.jp>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Wang <jasowang@redhat.com>,
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
Message-ID: <20230411023026-mutt-send-email-mst@kernel.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
 <2023041055-provided-antiquely-bbdb@gregkh>
 <20230410154035-mutt-send-email-mst@kernel.org>
 <de392fbd-3ffd-466d-cc7f-32f55c03227f@igel.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de392fbd-3ffd-466d-cc7f-32f55c03227f@igel.co.jp>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 12:25:39PM +0900, Shunsuke Mie wrote:
> 
> On 2023/04/11 4:44, Michael S. Tsirkin wrote:
> > On Mon, Apr 10, 2023 at 08:40:34PM +0200, Greg Kroah-Hartman wrote:
> > > On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
> > > > On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
> > > > > Fix the build dependency for virtio_test. The virtio_ring that is used from
> > > > > the test requires container_of_const(). Change to use container_of.h kernel
> > > > > header directly and adapt related codes.
> > > > > 
> > > > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > > > This is only for next right? That's where container_of_const
> > > > things are I think ...
> > > container_of_const() is in 6.2.
> > 
> > Absolutely but the patch switching virtio to that is not there.
> > 
> > 
> > > > > ---
> > > > >   tools/include/linux/types.h   |  1 -
> > > > >   tools/virtio/linux/compiler.h |  2 ++
> > > > >   tools/virtio/linux/kernel.h   |  5 +----
> > > > >   tools/virtio/linux/module.h   |  1 -
> > > > >   tools/virtio/linux/uaccess.h  | 11 ++---------
> > > > >   5 files changed, 5 insertions(+), 15 deletions(-)
> > > > > 
> > > > > diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> > > > > index 051fdeaf2670..f1896b70a8e5 100644
> > > > > --- a/tools/include/linux/types.h
> > > > > +++ b/tools/include/linux/types.h
> > > > > @@ -49,7 +49,6 @@ typedef __s8  s8;
> > > > >   #endif
> > > > >   #define __force
> > > > > -#define __user
> > > Why is this needed?
> > > 
> > > > >   #define __must_check
> > > > >   #define __cold
> > > > > diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> > > > > index 2c51bccb97bb..1f3a15b954b9 100644
> > > > > --- a/tools/virtio/linux/compiler.h
> > > > > +++ b/tools/virtio/linux/compiler.h
> > > > > @@ -2,6 +2,8 @@
> > > > >   #ifndef LINUX_COMPILER_H
> > > > >   #define LINUX_COMPILER_H
> > > > > +#include "../../../include/linux/compiler_types.h"
> > > While I understand your need to not want to duplicate code, what in the
> > > world is this doing?  Why not use the in-kernel compiler.h instead?  Why
> > > are you copying loads of .h files into tools/virtio/?  What is this for
> > > and why not just use the real files so you don't have to even attempt to
> > > try to keep things in sync (hint, they will always be out of sync.)
> > Because it's doing a very weird hack: building some kernel
> > code into a userspace binary, used for just for testing.
> > This is all not part of kernel build intentionally, no
> > one is supposed to use this binary in production, but
> > it was helpful in finding bugs in virtio core in the past
> > so I keep it around.
> Would it be possible to switch to in-kernel tests, such as KUnit? If it's
> possible, we could use the kernel headers and implementations as they are,
> and we could address the concerns that Greg raised I think.
> 
> 
> Best regards,
> 
> Shunsuke

I think your patch is fine as is. Using kunit is certainly possible,
but won't be a small project. tools/virtio was always a quick
hack to help experiment quickly, so I'm not worried by it being
broken often - whoever wants to play with it next, fixes it up.

-- 
MST

