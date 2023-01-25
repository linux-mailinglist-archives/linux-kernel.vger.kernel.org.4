Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C62E67ADCE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 10:28:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235245AbjAYJ2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 04:28:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235234AbjAYJ2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 04:28:03 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FD918AB4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:28:02 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id i17so8530035ila.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 01:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3vAoXdS/YoRTyt2xMAeJZRk1CWXWTFAex8XSq5QFxAI=;
        b=S24ranaz74YGGuc1OAnh94VOLMsmXsIZLcj8+scBUXH89LJHLuMjrTWBh0p6/v76tY
         88SOxVz5O1VxFq7CGGLduJHWVWXrsan3v+wmnVqudCskHR25NDnATl7XEhIxO/RYKqbj
         sJBRUFAQPX4CXb95M6G1bYcGuC9qC9i6xYDeoz5vETxL3Kpjv+eJ1nPzsTItAunGMclx
         6jhubgP+0FlGVJZzPWwy+1GRmjTyErdxqdkNfgoZvb07znINfh+aAjSi4ARRr8FOF7C/
         xseyzU0u4Thzb5GLUPFr741oGMQbebvwzcem/HaogSUNTnFOM119SyBF+of2dzbWbZQV
         EiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3vAoXdS/YoRTyt2xMAeJZRk1CWXWTFAex8XSq5QFxAI=;
        b=Nq0TAzRAIenihDkL56WtU3hZr+vkvD/6VogZo3A9CdUnMzcZ6wbdialDsOiV4KEE7x
         N/6gb0PP6VRiIx6t0NQaeu9LwTA+3yoH36oD11dCxaccaacLgnUS50PBeI+KzaJF3kDs
         QFxDhG0BhhhoDH1Xs9+0tJHaP5v2sdKFQWOPL7BBEqa08+3bu3Yp8VUzv06n3XNHMTYa
         vYmcrCtJCrBffV5DcKTNVb/NweIb5mgz8ZLYjoKs3sLvPL1xC2n4Uuub2Vn+SY4MMnpd
         6ANlNO78w3lnggs+hrXZRqFg8UqveY2NXxyiU7ch/eVZOIBr42Tl80Esyg0Y9WG+h51K
         cmsQ==
X-Gm-Message-State: AO0yUKWnlpziP24J0Ms+iTHHS+hQAd6RNfmKFuO7Spg6lPXdFyjAslC5
        YVDqafgAWpUMg0dGp4gTZEdnpIHmhtse6kFuYQ2Y0A==
X-Google-Smtp-Source: AK7set/bcEtGvKWUjj5g+XyVKGurJsF1MsHuI4LRXED0wzXVTUEYgHVVK6kVIc67YzuuYSiM20spifAd3Cryc3TTTtw=
X-Received: by 2002:a92:ca8d:0:b0:310:98bd:dbf0 with SMTP id
 t13-20020a92ca8d000000b0031098bddbf0mr583597ilo.128.1674638881876; Wed, 25
 Jan 2023 01:28:01 -0800 (PST)
MIME-Version: 1.0
References: <20230117163543.1049025-1-jannh@google.com> <CACT4Y+aQUeoWnWmbDG3O2_P75f=2u=VDRA1PjuTtbJsp5Xw2VA@mail.gmail.com>
In-Reply-To: <CACT4Y+aQUeoWnWmbDG3O2_P75f=2u=VDRA1PjuTtbJsp5Xw2VA@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 25 Jan 2023 10:27:25 +0100
Message-ID: <CAG48ez32X1WKryh5ueQ0=Mn=PMKc6zunOYsMHhwMMMxKKaMfqA@mail.gmail.com>
Subject: Re: [PATCH] fork, vmalloc: KASAN-poison backing pages of vmapped stacks
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 8:36 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> On Tue, 17 Jan 2023 at 17:35, Jann Horn <jannh@google.com> wrote:
> >
> > KASAN (except in HW_TAGS mode) tracks memory state based on virtual
> > addresses. The mappings of kernel stack pages in the linear mapping are
> > currently marked as fully accessible.
>
> Hi Jann,
>
> To confirm my understanding, this is not just KASAN (except in HW_TAGS
> mode), but also CONFIG_VMAP_STACK is required, right?

Yes.

> > Since stack corruption issues can cause some very gnarly errors, let's be
> > extra careful and tell KASAN to forbid accesses to stack memory through the
> > linear mapping.
> >
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I wrote this after seeing
> > https://lore.kernel.org/all/Y8W5rjKdZ9erIF14@casper.infradead.org/
> > and wondering about possible ways that this kind of stack corruption
> > could be sneaking past KASAN.
> > That's proooobably not the explanation, but still...
>
> I think catching any silent corruptions is still very useful. Besides
> confusing reports, sometimes they lead to an explosion of random
> reports all over the kernel.
>
> >  include/linux/vmalloc.h |  6 ++++++
> >  kernel/fork.c           | 10 ++++++++++
> >  mm/vmalloc.c            | 24 ++++++++++++++++++++++++
> >  3 files changed, 40 insertions(+)
> >
> > diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> > index 096d48aa3437..bfb50178e5e3 100644
> > --- a/include/linux/vmalloc.h
> > +++ b/include/linux/vmalloc.h
> > @@ -297,4 +297,10 @@ bool vmalloc_dump_obj(void *object);
> >  static inline bool vmalloc_dump_obj(void *object) { return false; }
> >  #endif
> >
> > +#if defined(CONFIG_MMU) && (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
> > +void vmalloc_poison_backing_pages(const void *addr);
> > +#else
> > +static inline void vmalloc_poison_backing_pages(const void *addr) {}
> > +#endif
>
> I think this should be in kasan headers and prefixed with kasan_.
> There are also kmsan/kcsan that may poison memory and hw poisoning
> (MADV_HWPOISON), so it's a somewhat overloaded term on its own.
>
> Can/should this be extended to all vmalloc-ed memory? Or some of it
> can be accessed via both addresses?

I think anything that does vmalloc_to_page() has a high chance of
doing accesses via both addresses, in particular anything involving
DMA.

Oooh, actually, there is some CIFS code that does vmalloc_to_page()
and talks about stack memory... I'll report that over on the other
thread re CIFS weirdness.

> Also, should we mprotect it instead while it's allocated as the stack?
> If it works, it looks like a reasonable improvement for
> CONFIG_VMAP_STACK in general. Would also catch non-instrumented
> accesses.

Well, we could also put it under CONFIG_DEBUG_PAGEALLOC and then use
the debug_pagealloc_map_pages() / debug_pagealloc_unmap_pages()
facilities to remove the page table entries. But I don't know if
anyone actually runs fuzzing with CONFIG_DEBUG_PAGEALLOC.
