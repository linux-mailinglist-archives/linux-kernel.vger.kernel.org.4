Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1438270EDB4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239655AbjEXGPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239356AbjEXGPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:15:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E633D132;
        Tue, 23 May 2023 23:15:14 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-52c40be1417so576365a12.1;
        Tue, 23 May 2023 23:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684908914; x=1687500914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lt0lGIpQnbErHODNwQ3cDengEUbpWKePGFq6txNOIKs=;
        b=RAGhMbG8uOFFFCCrljvC4Hlt6lZKpOrXnJZBJuc+6CDr0+FBnbtd+sxDA+1SJpjzUC
         aLfsNKz+j1G5RmQ6J2/dkjVTt/VYdCaJhfZNVPmX1rYCvZXSY+/1KWBCMywqmy3add74
         L/V3gve/zC8GcldFhoOV29465IMljK6JFwkpGe2RUD0Rf/9KTy0gVmqcLMyRaSyhG015
         AKjnzVZ/rK3LBOate3PwROFVWdl4lgD91wCC45CiIO34JyJPNmrG8+oZH+jm+fUYAEpR
         oHGdWN/Y2mJpXswO8T/woskVa+kzsdptMlzC/R8POQdPMVBA1il1RXfkXQv/09c7PPRe
         3QGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684908914; x=1687500914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lt0lGIpQnbErHODNwQ3cDengEUbpWKePGFq6txNOIKs=;
        b=jGeJjHOkDIi560SLHr8oV/yaFkD+gR/MZ/xsRi1Koloi9KiR49NjK30FHNOqA+ffZM
         SAyYObdOugcvqQcpL4tv2A1OWTcA8RSy1j7l6XrZZrER/KHY+tVn4Cxk7rvRosFjQXAK
         iv05neef/wIICYPQA+HilhaLUF+ph6rqbRDbxwF5ecpqLWD3Sobq9wZrtDKsykdKiThG
         Qtiks0dxDMPp21vy7bthB0yCkoZbiYRq8IUjw3XbzW4ZUT45kH3tuCOjQa3TAFRKJlu4
         KPU/uDeqijSkF9UfMcGv+D65VbfBrWUEXVB6G/6W88iaPInUWVV3LuK4IHYnS87+sKoy
         AmrA==
X-Gm-Message-State: AC+VfDyjXvMrij/VbbF1xv5G7c+MWSdfN2SDnuo/JQ2ciXGwz++x0hDQ
        4r0wZ1xCdIaCeVlrI01SELE=
X-Google-Smtp-Source: ACHHUZ5xpGBbFd9LGPJJ1namXeHHXVm+E0C/DmK6xw6rAGu3//TbvfHJdMcm+i5Ilzbz16HusfjvCA==
X-Received: by 2002:a17:902:ecd0:b0:1af:d6fb:199c with SMTP id a16-20020a170902ecd000b001afd6fb199cmr2593761plh.16.1684908914137;
        Tue, 23 May 2023 23:15:14 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 ([211.216.218.61])
        by smtp.gmail.com with ESMTPSA id w9-20020a170902d3c900b001a6d08eb054sm7836077plb.78.2023.05.23.23.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 23:15:13 -0700 (PDT)
Date:   Wed, 24 May 2023 15:15:26 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     David Rientjes <rientjes@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
Message-ID: <ZG2rX4PN03Db8l4C@debian-BULLSEYE-live-builder-AMD64>
References: <20230523073136.4900-1-vbabka@suse.cz>
 <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local>
 <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz>
 <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local>
 <ca7860db-220f-ae77-93e6-2a38f6c1130a@redhat.com>
 <202305231001.08BC6058@keescook>
 <7a16b351-c7f6-b6a3-869b-5163c0d0793f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a16b351-c7f6-b6a3-869b-5163c0d0793f@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 05:31:47PM -0700, David Rientjes wrote:
> On Tue, 23 May 2023, Kees Cook wrote:
> 
> > On Tue, May 23, 2023 at 10:14:24AM +0200, David Hildenbrand wrote:
> > > On 23.05.23 09:56, Lorenzo Stoakes wrote:
> > > > On Tue, May 23, 2023 at 09:46:46AM +0200, Vlastimil Babka wrote:
> > > > > On 5/23/23 09:42, Lorenzo Stoakes wrote:
> > > > > > On Tue, May 23, 2023 at 09:31:36AM +0200, Vlastimil Babka wrote:
> > > > > > > With SLOB removed, both remaining allocators support hardened usercopy,
> > > > > > > so remove the config and associated #ifdef.
> > > > > > > 
> > > > > > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > > > ---
> > > > > > >   mm/Kconfig       | 2 --
> > > > > > >   mm/slab.h        | 9 ---------
> > > > > > >   security/Kconfig | 8 --------
> > > > > > >   3 files changed, 19 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > > > > > index 7672a22647b4..041f0da42f2b 100644
> > > > > > > --- a/mm/Kconfig
> > > > > > > +++ b/mm/Kconfig
> > > > > > > @@ -221,7 +221,6 @@ choice
> > > > > > >   config SLAB
> > > > > > >   	bool "SLAB"
> > > > > > >   	depends on !PREEMPT_RT
> > > > > > > -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > > > >   	help
> > > > > > >   	  The regular slab allocator that is established and known to work
> > > > > > >   	  well in all environments. It organizes cache hot objects in
> > > > > > > @@ -229,7 +228,6 @@ config SLAB
> > > > > > > 
> > > > > > >   config SLUB
> > > > > > >   	bool "SLUB (Unqueued Allocator)"
> > > > > > > -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > > > >   	help
> > > > > > >   	   SLUB is a slab allocator that minimizes cache line usage
> > > > > > >   	   instead of managing queues of cached objects (SLAB approach).
> > > > > > > diff --git a/mm/slab.h b/mm/slab.h
> > > > > > > index f01ac256a8f5..695ef96b4b5b 100644
> > > > > > > --- a/mm/slab.h
> > > > > > > +++ b/mm/slab.h
> > > > > > > @@ -832,17 +832,8 @@ struct kmem_obj_info {
> > > > > > >   void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
> > > > > > >   #endif
> > > > > > > 
> > > > > > > -#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > > > >   void __check_heap_object(const void *ptr, unsigned long n,
> > > > > > >   			 const struct slab *slab, bool to_user);
> > > > > > > -#else
> > > > > > > -static inline
> > > > > > > -void __check_heap_object(const void *ptr, unsigned long n,
> > > > > > > -			 const struct slab *slab, bool to_user)
> > > > > > > -{
> > > > > > > -}
> > > > > > > -#endif
> > > > > > 
> > > > > > Hm, this is still defined in slab.c/slub.c and invoked in usercopy.c, do we
> > > > > > not want the prototype?
> > > > > 
> > > > > Well I didn't delete the prototype, just the ifdef/else around, so now it's
> > > > > there unconditionally.
> > > > > 
> > > > > > Perhaps replacing with #ifdef
> > > > > > CONFIG_HARDENED_USERCOPY instead? I may be missing something here :)
> > > > > 
> > > > > Putting it under that #ifdef would work and match that the implementations
> > > > > of that function are under that same ifdef, but maybe it's unnecessary noise
> > > > > in the header?
> > > > > 
> > > > 
> > > > Yeah my brain inserted extra '-'s there, sorry!
> > > > 
> > > > Given we only define __check_heap_object() in sl[au]b.c if
> > > > CONFIG_HARDENED_USERCOPY wouldn't we need to keep the empty version around
> > > > if !CONFIG_HARDENED_USERCOPY since check_heap_object() appears to be called
> > > > unconditionally?
> > > > 
> > > 
> > > The file is only compiled with CONFIG_HARDENED_USERCOPY:
> > > 
> > > mm/Makefile:obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o
> > 
> > Right.
> > 
> > > Reviewed-by: David Hildenbrand <david@redhat.com>
> > 
> > Thanks!
> > 
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > 
> 
> Acked-by: David Rientjes <rientjes@google.com>

looks fine to me,

Acked-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

-- 
Hyeonggon Yoo

Doing kernel stuff as a hobby
Undergraduate | Chungnam National University
Dept. Computer Science & Engineering
