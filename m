Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9413F6DCBC8
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 21:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjDJTo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 15:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDJToz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 15:44:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975DD1BD9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681155847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=S7DwxFRRO+N9t4iCO4EwBINDyFHIhmYzbeXLYYi5MfE=;
        b=esNq3viRFPlHBMMgZzsB037c8cZUBG8qVNMUvuJ6Ma0QQj/QaOIjoGJ1AFNgFZ1YM7dtkB
        RKCMBLASRfFhMRsjqZFnXwzuopt64WKyaszOaS4uau7hOcaNNExbnbx2So/Lr9Sd89vAew
        Pbt9FI1/hkAbxz6TaAIkja3uWiPZdak=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-wvo24dzfO7S89xQzOnnWkA-1; Mon, 10 Apr 2023 15:44:06 -0400
X-MC-Unique: wvo24dzfO7S89xQzOnnWkA-1
Received: by mail-wm1-f72.google.com with SMTP id j14-20020a05600c1c0e00b003f066d2638aso4288215wms.8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 12:44:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681155845;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7DwxFRRO+N9t4iCO4EwBINDyFHIhmYzbeXLYYi5MfE=;
        b=Pk3OGtVxTLVEF5W6VfrMV90+Uv39Q4zWCzNyuu/0KL21lbf4EOpaFtVRgjoMsGuGf7
         g9lHsmKtsDOJwRwKZNg87+rPrm0H7MVuqMLOrlPSddDQ7GGzCst10ssxLrhB6++/hTn8
         CEYIL2djsYqfwEyvsAHcmZ0/Vwr08ZhjC2to6KvUry6iU4LSnpqQCpGcpKwqqvPtwRZL
         uzoSB7Tatx1t0Szw4EZw5FW56qBJjiIlVVVOc0gsSwq8fjjS8w2/jMqAsONcLQl4Iea7
         yM3KNefLYzTh4XsI06gGGmg6Fu/getHaooNzQe/8HboNnUjVDdZArAx1hjCvLg0uQ07E
         G2XA==
X-Gm-Message-State: AAQBX9elgMeArpp9272rnpeBOLQZUogRjpk8jB8YTUq166wbENrWInzG
        4xonYY7+VITW0ZxM4X50ld0BNNQGr9Lay9NdYKdf6rlPpNhcgDHzsjLpKZnYeXWp5DXUsJDQ+9v
        gfyCzU1GKso4RzbR4qVVfp9Zu
X-Received: by 2002:a5d:6b45:0:b0:2d9:eb77:90d2 with SMTP id x5-20020a5d6b45000000b002d9eb7790d2mr7201234wrw.70.1681155845220;
        Mon, 10 Apr 2023 12:44:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350blHNuy+UJSBM/NhrqzKW2ktWbHKUdAfus2M3moACxyrbqG/jq+3UEjLAf9q3Um9GQ7CVrVEw==
X-Received: by 2002:a5d:6b45:0:b0:2d9:eb77:90d2 with SMTP id x5-20020a5d6b45000000b002d9eb7790d2mr7201229wrw.70.1681155844915;
        Mon, 10 Apr 2023 12:44:04 -0700 (PDT)
Received: from redhat.com ([2.52.10.80])
        by smtp.gmail.com with ESMTPSA id u5-20020adff885000000b002c70851fdd8sm12508607wrp.75.2023.04.10.12.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 12:44:04 -0700 (PDT)
Date:   Mon, 10 Apr 2023 15:44:00 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
Message-ID: <20230410154035-mutt-send-email-mst@kernel.org>
References: <20230410112845.337212-1-mie@igel.co.jp>
 <20230410112845.337212-2-mie@igel.co.jp>
 <20230410080014-mutt-send-email-mst@kernel.org>
 <2023041055-provided-antiquely-bbdb@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023041055-provided-antiquely-bbdb@gregkh>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 08:40:34PM +0200, Greg Kroah-Hartman wrote:
> On Mon, Apr 10, 2023 at 08:00:33AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Apr 10, 2023 at 08:28:45PM +0900, Shunsuke Mie wrote:
> > > Fix the build dependency for virtio_test. The virtio_ring that is used from
> > > the test requires container_of_const(). Change to use container_of.h kernel
> > > header directly and adapt related codes.
> > > 
> > > Signed-off-by: Shunsuke Mie <mie@igel.co.jp>
> > 
> > This is only for next right? That's where container_of_const
> > things are I think ...
> 
> container_of_const() is in 6.2.


Absolutely but the patch switching virtio to that is not there.


> 
> > 
> > > ---
> > >  tools/include/linux/types.h   |  1 -
> > >  tools/virtio/linux/compiler.h |  2 ++
> > >  tools/virtio/linux/kernel.h   |  5 +----
> > >  tools/virtio/linux/module.h   |  1 -
> > >  tools/virtio/linux/uaccess.h  | 11 ++---------
> > >  5 files changed, 5 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/tools/include/linux/types.h b/tools/include/linux/types.h
> > > index 051fdeaf2670..f1896b70a8e5 100644
> > > --- a/tools/include/linux/types.h
> > > +++ b/tools/include/linux/types.h
> > > @@ -49,7 +49,6 @@ typedef __s8  s8;
> > >  #endif
> > >  
> > >  #define __force
> > > -#define __user
> 
> Why is this needed?
> 
> > >  #define __must_check
> > >  #define __cold
> > >  
> > > diff --git a/tools/virtio/linux/compiler.h b/tools/virtio/linux/compiler.h
> > > index 2c51bccb97bb..1f3a15b954b9 100644
> > > --- a/tools/virtio/linux/compiler.h
> > > +++ b/tools/virtio/linux/compiler.h
> > > @@ -2,6 +2,8 @@
> > >  #ifndef LINUX_COMPILER_H
> > >  #define LINUX_COMPILER_H
> > >  
> > > +#include "../../../include/linux/compiler_types.h"
> 
> While I understand your need to not want to duplicate code, what in the
> world is this doing?  Why not use the in-kernel compiler.h instead?  Why
> are you copying loads of .h files into tools/virtio/?  What is this for
> and why not just use the real files so you don't have to even attempt to
> try to keep things in sync (hint, they will always be out of sync.)

Because it's doing a very weird hack: building some kernel
code into a userspace binary, used for just for testing.
This is all not part of kernel build intentionally, no
one is supposed to use this binary in production, but
it was helpful in finding bugs in virtio core in the past
so I keep it around.

-- 
MST

