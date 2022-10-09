Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449975F88DD
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiJIC0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiJIC0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:26:14 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E941F3641E
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:26:12 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id s10so9775835ljp.5
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 19:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F4Ndqn8mcqwaJbQaI8C5dwRVGTyPE8l0jxeXirt3rHc=;
        b=GOy6ht1b3z6Nch5I+lxTYiokqV19xJ5XrFL7Mfhqc/yl19vQ+uscITbHA3XQblsySp
         iwA2YhzOQAM443abCWu7kffIfL9oJQJFlLtwFso0Hs9RqG7Rq3y3d4X2LYqQNB92WEhe
         Fm2Q431j5QjeI0SQ7tuxzeW0N+5CYFtpySDYq0UVWZuF5xF9qwdhmI6CCCJUMp2jNLYa
         fh2Ke5z4hPEIdsb6vZ0cCGDmFenxRxR0CXBXv5lZzJpWNdAp0B7y7wipEdth7p4wQbLh
         kXur6B5POLW2u/t+FCBQaexERlqfXNDiXwSUE8A+1wwgMJla3u3YCRDisz8kMWJCZoWh
         9OQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F4Ndqn8mcqwaJbQaI8C5dwRVGTyPE8l0jxeXirt3rHc=;
        b=ADoDVA6LBRiateQKXWPsXU+rH2q5uIHfYNDWHL6fy3YLBIm+pw0MXZk23fwy9B1i1p
         4DhCd1quGfwL/kw5xhM2gH0XeM93e9V7skeTAOPgI9je2oTiw7zgJ5EmBTTSzAYSzAPJ
         Y/38e550qyGY3B9onkBJvjPQmzGgVTofC+IpMAFc7HoIqIIdidZcqG/25se21RW/lOFq
         rI/mTYOckz+jgDY30Qeb9CPRQc38YjbvaBu3xxp4pcbRtPj6WsLBvj664ubcqm0ASR2Z
         pToyRG5gykuh1PkmOXm27mB2FV26e/BYn9/8gIzTWaNCbJViQIJ7ITcoXKDsmJ8CD221
         RZLQ==
X-Gm-Message-State: ACrzQf3CjfaPVwIvmMdENg7No/bnr+hWjdp8ChNDmX22e44eWrq0Yuei
        GPU/ALA+gDWe2F/DjKezKpWvFlJOpzeQpD/pm16/5Abh
X-Google-Smtp-Source: AMsMyM6JjeD9ChTGv/mp2MLb0Cib5y9fxexHwwynGKJXjBwMxjRXk9IF2L+0HUCgRg66Bpy8msUBITmU63rSxRb6QvQ=
X-Received: by 2002:a05:651c:222c:b0:26b:dec5:a4f0 with SMTP id
 y44-20020a05651c222c00b0026bdec5a4f0mr4652013ljq.359.1665282370836; Sat, 08
 Oct 2022 19:26:10 -0700 (PDT)
MIME-Version: 1.0
References: <1665026390-16096-1-git-send-email-zhaoyang.huang@unisoc.com> <cd103df8-d0da-ab15-5755-c20631055986@suse.cz>
In-Reply-To: <cd103df8-d0da-ab15-5755-c20631055986@suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sun, 9 Oct 2022 10:25:42 +0800
Message-ID: <CAGWkznHSyT59Ca57EnYu+zY+tkTE=p8LKaJqS0Y7TC4s+aZ8iA@mail.gmail.com>
Subject: Re: [PATCH] mm: add stackdepot information on page->private for tracking
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marco Elver <elver@google.com>,
        Imran Khan <imran.f.khan@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 7, 2022 at 6:08 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 10/6/22 05:19, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Private is vacant for most of Non-LRU pages while the user has explicitly
> > operation on page->private via set_page_private, I would like introduce
> > stackdepot information on page->private for a simplified tracking mechanism
> > which could be help for kernel driver's memory leak.
> >
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> This duplicates the existing page_owner functionality in a way that
> unconditionally adds overhead to all kernels that have CONFIG_STACKDEPOT
> enabled build-time (and also misses the need to initialize stackdepot properly).
Sure. This patch could be deemed as a light and complement of the page
owner which depends on proc fs in lived system for showing the result.
This patch could be mainly helpful on RAM dump as it is hard to find
page_ext for page owners. I also would like to make this optional via
defconfig item.
>
> Also wouldn't be suprised if some existing page->private users were actually
> confused by the field suddenly being non-zero without their own action.
IMO, the existing page->private users will cover this field directly
without distrubed by handle.

>
> > ---
> >  mm/page_alloc.c | 28 +++++++++++++++++++++++++++-
> >  1 file changed, 27 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index e5486d4..b79a503 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -75,6 +75,7 @@
> >  #include <linux/khugepaged.h>
> >  #include <linux/buffer_head.h>
> >  #include <linux/delayacct.h>
> > +#include <linux/stackdepot.h>
> >  #include <asm/sections.h>
> >  #include <asm/tlbflush.h>
> >  #include <asm/div64.h>
> > @@ -2464,6 +2465,25 @@ static inline bool should_skip_init(gfp_t flags)
> >       return (flags & __GFP_SKIP_ZERO);
> >  }
> >
> > +#ifdef CONFIG_STACKDEPOT
> > +static noinline depot_stack_handle_t set_track_prepare(void)
> > +{
> > +       depot_stack_handle_t trace_handle;
> > +       unsigned long entries[16];
> > +       unsigned int nr_entries;
> > +
> > +       nr_entries = stack_trace_save(entries, ARRAY_SIZE(entries), 3);
> > +       trace_handle = stack_depot_save(entries, nr_entries, GFP_NOWAIT);
> > +
> > +       return trace_handle;
> > +}
> > +#else
> > +static inline depot_stack_handle_t set_track_prepare(void)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  inline void post_alloc_hook(struct page *page, unsigned int order,
> >                               gfp_t gfp_flags)
> >  {
> > @@ -2471,8 +2491,14 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
> >                       !should_skip_init(gfp_flags);
> >       bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
> >       int i;
> > +     depot_stack_handle_t stack_handle = set_track_prepare();
> >
> > -     set_page_private(page, 0);
> > +     /*
> > +      * Don't worry, user will cover private directly without checking
> > +      * this field and has ability to trace the page. This also will not
> > +      * affect expected state when freeing
> > +      */
> > +     set_page_private(page, stack_handle);
> >       set_page_refcounted(page);
> >
> >       arch_alloc_page(page, order);
>
