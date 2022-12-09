Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C46D64839B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiLIOSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiLIOSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:18:01 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EE861903E
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:17:43 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB18C23A;
        Fri,  9 Dec 2022 06:17:49 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.41.252])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B5D453F73D;
        Fri,  9 Dec 2022 06:17:41 -0800 (PST)
Date:   Fri, 9 Dec 2022 14:17:34 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Xander <xandermoerkerken@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Xander Moerkerken <xander.moerkerken@omron.com>
Subject: Re: [PATCH] Added ability to vmalloc executable memory
Message-ID: <Y5NDfq+ktpKIZXE1@FVFF77S0Q05N>
References: <20221209131052.64235-1-xander.moerkerken@omron.com>
 <Y5M1UowMyucPOqAl@FVFF77S0Q05N>
 <CAGkG8RF0QNrC=UQ3uwurYQRS-kajYr3=g1qa6d7x=RC55z7ymg@mail.gmail.com>
 <ed1c32c0-e882-e7f8-3acf-0c0204fb96ae@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed1c32c0-e882-e7f8-3acf-0c0204fb96ae@csgroup.eu>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 01:46:05PM +0000, Christophe Leroy wrote:
> 
> 
> Le 09/12/2022 à 14:38, Xander a écrit :
> > 	
> > The pgprot parameter got removed because, according to the commit log, 
> > for no other apparent reason than it being called with 'PAGE_KERNEL' as 
> > an argument in the whole kernel. Therefore it got removed.
> > This removed the ability to allocate virtual memory with executing rights.
> > My use case comes from ioremap().
> > I think this is useful for others too.
> > 
> > I don't see why this pgprot parameter got removed but this is the 
> > alternative to reverting it to the older 5.7 function.
> 
> Please avoid top-posting, and use only plain text.
> 
> I think you don't answer to Mark's question.
> 
> You are adding a new function that no driver uses apparently. If you are 
> working on some piece of code that needs this new fonction, you can send 
> this patch as part of a patch series including that code.

Yup, that was what I was getting at. Thanks for stating that much more clearly
than I did. :)

> By the way, when you need executable memory, the fonction to use is 
> module_alloc(), that's the only function that garanties real executable 
> memory on all platforms. For instance, on some powerpc, setting the X 
> bit is not enough to get executable memory in vmalloc space.

Yup, and likewise on arm64 there are other constraints to consider, e.g. branch
ranges, whether or not to set PROT_BTI and/or other prot bits in future.

Further, I'm very wary of exporting a generic interface to make some code
executable without an understanding and documenting the precise constraints on
its use, and I'm generally wary of doing that for some arbitrary code given
that could violate other expectations that affect the kernel generally (e.g.
gadgets for ROP/JOP/speculation, RELIABLE_STACKTRACE expectations, and general
things like whether the code will play with CPU control bits or flags in an
unexpected way).

Mark.

> Christophe
> 
> > 
> > On Fri, 9 Dec 2022 at 14:17, Mark Rutland <mark.rutland@arm.com 
> > <mailto:mark.rutland@arm.com>> wrote:
> > 
> >     On Fri, Dec 09, 2022 at 02:10:52PM +0100, Xander Moerkerken wrote:
> >      > From: Xander Moerkerken <xander.moerkerken@gmail.com
> >     <mailto:xander.moerkerken@gmail.com>>
> >      >
> >      > Since release 5.8-rc1 the pgprot got removed from __vmalloc
> >      > because the only usage was PAGE_KERNEL as argument.
> >      > However, this removes the ability to input other arguments
> >      > such as 'PAGE_KERNEL_EXEC', which can be used to allocate
> >      > memory in which you can execute. For this reason a new
> >      > function is introduced called '__vmalloc_exec'.
> >      >
> >      > Signed-off-by: Xander Moerkerken <xander.moerkerken@omron.com
> >     <mailto:xander.moerkerken@omron.com>>
> > 
> >     What is this going to be used for? There's no user from this patch
> >     alone, as a
> >     module or otherwise.
> > 
> >     Mark.
> > 
> >      > ---
> >      >  include/linux/vmalloc.h | 1 +
> >      >  mm/vmalloc.c            | 8 ++++++++
> >      >  2 files changed, 9 insertions(+)
> >      >
> >      > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> >      > index 096d48aa3437..10c46513b6b2 100644
> >      > --- a/include/linux/vmalloc.h
> >      > +++ b/include/linux/vmalloc.h
> >      > @@ -147,6 +147,7 @@ extern void *vzalloc_node(unsigned long size,
> >     int node) __alloc_size(1);
> >      >  extern void *vmalloc_32(unsigned long size) __alloc_size(1);
> >      >  extern void *vmalloc_32_user(unsigned long size) __alloc_size(1);
> >      >  extern void *__vmalloc(unsigned long size, gfp_t gfp_mask)
> >     __alloc_size(1);
> >      > +extern void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> >     __alloc_size(1);
> >      >  extern void *__vmalloc_node_range(unsigned long size, unsigned
> >     long align,
> >      >                       unsigned long start, unsigned long end,
> >     gfp_t gfp_mask,
> >      >                       pgprot_t prot, unsigned long vm_flags, int
> >     node,
> >      > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> >      > index ccaa461998f3..8fd01ed7082b 100644
> >      > --- a/mm/vmalloc.c
> >      > +++ b/mm/vmalloc.c
> >      > @@ -3294,6 +3294,14 @@ void *__vmalloc(unsigned long size, gfp_t
> >     gfp_mask)
> >      >  }
> >      >  EXPORT_SYMBOL(__vmalloc);
> >      >
> >      > +
> >      > +void *__vmalloc_exec(unsigned long size, gfp_t gfp_mask)
> >      > +{
> >      > +     return __vmalloc_node_prot(size, 1, gfp_mask, PAGE_KERNEL_EXEC,
> >      > +                               NUMA_NO_NODE,
> >     __builtin_return_address(0));
> >      > +}
> >      > +EXPORT_SYMBOL(__vmalloc_exec);
> >      > +
> >      >  /**
> >      >   * vmalloc - allocate virtually contiguous memory
> >      >   * @size:    allocation size
> >      > --
> >      > 2.37.2
> >      >
> > 
