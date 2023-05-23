Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609E570E349
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237933AbjEWRCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237938AbjEWRCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:02:23 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70A7132
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:02:19 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a516fb6523so69321725ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684861339; x=1687453339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LD/AHmnjp0NpxhS4p9Yvs385A6w+BDeBdMrso5+Dd0Q=;
        b=lzYLf2QhhI3UYhDz/x7zeHwaOXZjxjX8RJUlSR/iSQkPre1BbQqZhNaRDgEu4WxPpP
         WNcoECD735LmNk3jkktPP1QBpuInwgX0QeDE+Je8kuS96RaNEoN22PMzB0jQKtPJ45VK
         TC6KZnWUWzT8p80Ad1hgSWEZcepO1zypQ1sME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861339; x=1687453339;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LD/AHmnjp0NpxhS4p9Yvs385A6w+BDeBdMrso5+Dd0Q=;
        b=cBv1ngSYHVPvmLuoLUGjcFpu2nwUO4YYTg8h4Q4UrukhqHhDQSYp4pqPnGFcwd/4Ra
         gK8GRJT/zzvmg1wxijaXMlAzmcDjv/zixC/ZzbbX/U/0hN+Pr1GS5kGiBcWt0roijZst
         1dq5RKW0btkwY0CignJe4Jb4Pe7r9i5MJ50oMHISx5TQih3BMSZf3rGVMIONtx1f9eBJ
         lTK/O9MNgh1sIV8hpAcWfIAs/OZni6CxdFBKuj3k2HYn96CwjbFnrdaUrT6EIFjsUrwe
         ePhYVSZsU49vnjq1s/cyU1CpQFRxuicD4AoBcaLDBOJMVB1MztcgsGyUwngI5k/NFV+F
         oBCA==
X-Gm-Message-State: AC+VfDywoyJxADnh42Fs4c4ityFdLzsvp0S42q/UuY/x6Qufs1KUHEoV
        aWogIO64+iqLcJ7qa8yo8Q6aGw==
X-Google-Smtp-Source: ACHHUZ6rSNlwleoHAlvIMBQhyIFB+/d1nvXlfbHZz0sPioooGAVPueHOXiNnTfSN1iiCo/VNjK8bMQ==
X-Received: by 2002:a17:902:f815:b0:1ac:aaf6:ee3a with SMTP id ix21-20020a170902f81500b001acaaf6ee3amr13420526plb.32.1684861339266;
        Tue, 23 May 2023 10:02:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id r6-20020a170902be0600b001aafde15ff3sm6960489pls.293.2023.05.23.10.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:02:18 -0700 (PDT)
Date:   Tue, 23 May 2023 10:02:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
Message-ID: <202305231001.08BC6058@keescook>
References: <20230523073136.4900-1-vbabka@suse.cz>
 <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local>
 <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz>
 <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local>
 <ca7860db-220f-ae77-93e6-2a38f6c1130a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca7860db-220f-ae77-93e6-2a38f6c1130a@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 10:14:24AM +0200, David Hildenbrand wrote:
> On 23.05.23 09:56, Lorenzo Stoakes wrote:
> > On Tue, May 23, 2023 at 09:46:46AM +0200, Vlastimil Babka wrote:
> > > On 5/23/23 09:42, Lorenzo Stoakes wrote:
> > > > On Tue, May 23, 2023 at 09:31:36AM +0200, Vlastimil Babka wrote:
> > > > > With SLOB removed, both remaining allocators support hardened usercopy,
> > > > > so remove the config and associated #ifdef.
> > > > > 
> > > > > Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > ---
> > > > >   mm/Kconfig       | 2 --
> > > > >   mm/slab.h        | 9 ---------
> > > > >   security/Kconfig | 8 --------
> > > > >   3 files changed, 19 deletions(-)
> > > > > 
> > > > > diff --git a/mm/Kconfig b/mm/Kconfig
> > > > > index 7672a22647b4..041f0da42f2b 100644
> > > > > --- a/mm/Kconfig
> > > > > +++ b/mm/Kconfig
> > > > > @@ -221,7 +221,6 @@ choice
> > > > >   config SLAB
> > > > >   	bool "SLAB"
> > > > >   	depends on !PREEMPT_RT
> > > > > -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > >   	help
> > > > >   	  The regular slab allocator that is established and known to work
> > > > >   	  well in all environments. It organizes cache hot objects in
> > > > > @@ -229,7 +228,6 @@ config SLAB
> > > > > 
> > > > >   config SLUB
> > > > >   	bool "SLUB (Unqueued Allocator)"
> > > > > -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > >   	help
> > > > >   	   SLUB is a slab allocator that minimizes cache line usage
> > > > >   	   instead of managing queues of cached objects (SLAB approach).
> > > > > diff --git a/mm/slab.h b/mm/slab.h
> > > > > index f01ac256a8f5..695ef96b4b5b 100644
> > > > > --- a/mm/slab.h
> > > > > +++ b/mm/slab.h
> > > > > @@ -832,17 +832,8 @@ struct kmem_obj_info {
> > > > >   void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
> > > > >   #endif
> > > > > 
> > > > > -#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
> > > > >   void __check_heap_object(const void *ptr, unsigned long n,
> > > > >   			 const struct slab *slab, bool to_user);
> > > > > -#else
> > > > > -static inline
> > > > > -void __check_heap_object(const void *ptr, unsigned long n,
> > > > > -			 const struct slab *slab, bool to_user)
> > > > > -{
> > > > > -}
> > > > > -#endif
> > > > 
> > > > Hm, this is still defined in slab.c/slub.c and invoked in usercopy.c, do we
> > > > not want the prototype?
> > > 
> > > Well I didn't delete the prototype, just the ifdef/else around, so now it's
> > > there unconditionally.
> > > 
> > > > Perhaps replacing with #ifdef
> > > > CONFIG_HARDENED_USERCOPY instead? I may be missing something here :)
> > > 
> > > Putting it under that #ifdef would work and match that the implementations
> > > of that function are under that same ifdef, but maybe it's unnecessary noise
> > > in the header?
> > > 
> > 
> > Yeah my brain inserted extra '-'s there, sorry!
> > 
> > Given we only define __check_heap_object() in sl[au]b.c if
> > CONFIG_HARDENED_USERCOPY wouldn't we need to keep the empty version around
> > if !CONFIG_HARDENED_USERCOPY since check_heap_object() appears to be called
> > unconditionally?
> > 
> 
> The file is only compiled with CONFIG_HARDENED_USERCOPY:
> 
> mm/Makefile:obj-$(CONFIG_HARDENED_USERCOPY) += usercopy.o

Right.

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
