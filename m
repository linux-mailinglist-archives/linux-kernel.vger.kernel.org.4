Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFF970D675
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 10:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235934AbjEWIAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 04:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235930AbjEWH7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 03:59:36 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBD5E45;
        Tue, 23 May 2023 00:58:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3078a3f3b5fso6968122f8f.0;
        Tue, 23 May 2023 00:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684828600; x=1687420600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=db1Oh/K3TlZeQNYMxrvu45+eqvFJs0QWQptyQFlb8ew=;
        b=A7777Bmb9uoJs/GfMJjmfqzU9G6tTtrjDr0FhiFTnzl7AJl/OW8IhWF0867Vap6Tw0
         EAjOQ+sfSHW4FM6Sb4Ao5/eTYKR4366VO/ZN1QG0B1cxvnZ+3VF4htYnsZuWAzfm2Am+
         ZEqQMmq/z+G7Ky+sb/V/7rPKCXXEs7zM5vSdOGfU1HK52NmAXaLvQ3XZmF8QomICP1PP
         gGW2MkDbqQjcEOrVSIrdi6VInD2CoFn06/DRwXS7mtKyKyeEcQScfud0UvlDx/tGoQTB
         2WzJJEaKef8QhBGLsvskCi2fjQEQ3ZBoyTbb65JsTxOsQwRHJBvH5ASGdp1IPDdSX+v7
         QmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828600; x=1687420600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=db1Oh/K3TlZeQNYMxrvu45+eqvFJs0QWQptyQFlb8ew=;
        b=f04qP/gMzZXiNW/wC2kTddO++/9Otsu8YWKo/21PQy7YrNHbByzppG/PoW0zMEZfhx
         Zto594rbUUR70WWNtPFcyV/HfcDYqlLAP5wNix9MPFJR1HGchYg1h5KbJ0H8WMh9RJ2j
         OROd03S18u+NDsAoyyhpam6JDgrpLD7f/uP7qpR8nf5hr+rjaMPFkduKmLbLt9aujqBh
         a7NMmlfqqgiTL0ZwYiecXHo4YJCnAl/U6f95xzBaAPit8AYY5wfukpG+AX7xyEIWFqSH
         iovcDVqfDp/O3JCAM87lRg2+20Ae3uPJpNv/yeEyywAUGs0AC2Ye9Dk/HnBekqhoMfdn
         49Jw==
X-Gm-Message-State: AC+VfDzp1y9X+0RKiwfxJsmYR4iec+JwttgpiOcSYAULfZa85xmvPxNP
        XhJaYlLYbOUJwjdcO2NybJU=
X-Google-Smtp-Source: ACHHUZ7BT4pKK6f8Lsa/6InJ+p8hSNRQ8YQyxAfxI9oMAw25qxIh21BjBZOqHYkS8y+4HsKKSgPaNA==
X-Received: by 2002:a5d:4b89:0:b0:307:8879:6cc1 with SMTP id b9-20020a5d4b89000000b0030788796cc1mr8560591wrt.71.1684828600095;
        Tue, 23 May 2023 00:56:40 -0700 (PDT)
Received: from localhost (host81-154-179-160.range81-154.btcentralplus.com. [81.154.179.160])
        by smtp.gmail.com with ESMTPSA id n1-20020adfe781000000b002c54c9bd71fsm10192965wrm.93.2023.05.23.00.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 00:56:39 -0700 (PDT)
Date:   Tue, 23 May 2023 08:56:38 +0100
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab: remove HAVE_HARDENED_USERCOPY_ALLOCATOR
Message-ID: <ae3ff438-5e5a-4a75-b4e9-575324a584f7@lucifer.local>
References: <20230523073136.4900-1-vbabka@suse.cz>
 <310077ed-6f3f-41fe-afcf-36500a9408ec@lucifer.local>
 <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <623a87c6-c0d2-799a-c39e-0d14dcdfa6df@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 09:46:46AM +0200, Vlastimil Babka wrote:
> On 5/23/23 09:42, Lorenzo Stoakes wrote:
> > On Tue, May 23, 2023 at 09:31:36AM +0200, Vlastimil Babka wrote:
> >> With SLOB removed, both remaining allocators support hardened usercopy,
> >> so remove the config and associated #ifdef.
> >>
> >> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> >> ---
> >>  mm/Kconfig       | 2 --
> >>  mm/slab.h        | 9 ---------
> >>  security/Kconfig | 8 --------
> >>  3 files changed, 19 deletions(-)
> >>
> >> diff --git a/mm/Kconfig b/mm/Kconfig
> >> index 7672a22647b4..041f0da42f2b 100644
> >> --- a/mm/Kconfig
> >> +++ b/mm/Kconfig
> >> @@ -221,7 +221,6 @@ choice
> >>  config SLAB
> >>  	bool "SLAB"
> >>  	depends on !PREEMPT_RT
> >> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> >>  	help
> >>  	  The regular slab allocator that is established and known to work
> >>  	  well in all environments. It organizes cache hot objects in
> >> @@ -229,7 +228,6 @@ config SLAB
> >>
> >>  config SLUB
> >>  	bool "SLUB (Unqueued Allocator)"
> >> -	select HAVE_HARDENED_USERCOPY_ALLOCATOR
> >>  	help
> >>  	   SLUB is a slab allocator that minimizes cache line usage
> >>  	   instead of managing queues of cached objects (SLAB approach).
> >> diff --git a/mm/slab.h b/mm/slab.h
> >> index f01ac256a8f5..695ef96b4b5b 100644
> >> --- a/mm/slab.h
> >> +++ b/mm/slab.h
> >> @@ -832,17 +832,8 @@ struct kmem_obj_info {
> >>  void __kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab);
> >>  #endif
> >>
> >> -#ifdef CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR
> >>  void __check_heap_object(const void *ptr, unsigned long n,
> >>  			 const struct slab *slab, bool to_user);
> >> -#else
> >> -static inline
> >> -void __check_heap_object(const void *ptr, unsigned long n,
> >> -			 const struct slab *slab, bool to_user)
> >> -{
> >> -}
> >> -#endif
> >
> > Hm, this is still defined in slab.c/slub.c and invoked in usercopy.c, do we
> > not want the prototype?
>
> Well I didn't delete the prototype, just the ifdef/else around, so now it's
> there unconditionally.
>
> > Perhaps replacing with #ifdef
> > CONFIG_HARDENED_USERCOPY instead? I may be missing something here :)
>
> Putting it under that #ifdef would work and match that the implementations
> of that function are under that same ifdef, but maybe it's unnecessary noise
> in the header?
>

Yeah my brain inserted extra '-'s there, sorry!

Given we only define __check_heap_object() in sl[au]b.c if
CONFIG_HARDENED_USERCOPY wouldn't we need to keep the empty version around
if !CONFIG_HARDENED_USERCOPY since check_heap_object() appears to be called
unconditionally?
