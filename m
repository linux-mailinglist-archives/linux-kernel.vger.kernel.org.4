Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C845C6715CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjARIDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjARIBQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:01:16 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD5751C7E
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:36:23 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id d30so45592282lfv.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tXJS6O96pqUrAn6JTjfwzdlxbTr5MxmXpgvppk1+ZUI=;
        b=Y1PYitAEZNLh0tMF269DyDhvK7SU90x/pZSKSUY1YcSH3Q6dxMtNI8y9Q6AN6MVyxY
         cn5Ye3GOhKXE+nTWj69viVf+zWfsKnvGe6xqqrgFpGLlGCyy8uyKFasmeGN8dSb1KTLJ
         uTn3z7L2Fi3f18OTfxJPfiPGQRrL04ekm6xNXWKL9NZsnsFrxC/Z1S5LqSI9bPH2p+W3
         lmRkmrIyJwD9dBWQgUU1cqe+YQcXSdCW4QFho72DRZ2iucpHpsiXUmFmB+FKdnM/7bZM
         t9mm3hEVPaskSJ+LwS35XMx0JGimed0EqmiCjGOCFNq6fy6Ea1iT55TyTPNLYakuXk7B
         B/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tXJS6O96pqUrAn6JTjfwzdlxbTr5MxmXpgvppk1+ZUI=;
        b=GPqan7BAGejBCriQkuIfmhUaruc9wcqV5vmvssisQsXSX3xbGOo3tn0oKR1fEPnpGI
         B2ZezjW0o9uxsXHCJe1FvXxaRgRspn9C9/doTcKY83bZ4iQPxYgnP3WlqC/n9gXwxUrd
         IpXDiNFM7LlX6NgyhedBAIVYeu+UbG72Y/FpQ15bdZbMCj9kIQ0TBeTvwr/Qfb3BrNV1
         V470kdqmofX56xFbu1LR+l/QPUFd2U0r3OlLATwDmqWEpTQ0JPZuJT/ltj7nMayr1j83
         glZP3sBP9rUdk6OE8iqUAQi3IaNkwGOz3Q9eauWKFZIkc2lXq4pSuxxp80ExV4jUUbao
         PsHQ==
X-Gm-Message-State: AFqh2kqpQc76yGBD1CVN4p0ATN9hV8VM5kqrY9OlkwTkiTiPE+CbHXMM
        02YswbPWbP7zEBZmnWVU3FdxbNs10tTtGid/xV5zjA==
X-Google-Smtp-Source: AMrXdXuj5bzcgQGLaz1JgVZv2c7juMWmB7EfCOepc1a7fDbsUWhqpEZ3Uj+TmWN0FE8M1AQbWRFpg+6i/hAV1CzefpU=
X-Received: by 2002:ac2:4bd0:0:b0:4c5:32a4:6f88 with SMTP id
 o16-20020ac24bd0000000b004c532a46f88mr410419lfq.6.1674027381894; Tue, 17 Jan
 2023 23:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20230117163543.1049025-1-jannh@google.com>
In-Reply-To: <20230117163543.1049025-1-jannh@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 18 Jan 2023 08:36:09 +0100
Message-ID: <CACT4Y+aQUeoWnWmbDG3O2_P75f=2u=VDRA1PjuTtbJsp5Xw2VA@mail.gmail.com>
Subject: Re: [PATCH] fork, vmalloc: KASAN-poison backing pages of vmapped stacks
To:     Jann Horn <jannh@google.com>
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

On Tue, 17 Jan 2023 at 17:35, Jann Horn <jannh@google.com> wrote:
>
> KASAN (except in HW_TAGS mode) tracks memory state based on virtual
> addresses. The mappings of kernel stack pages in the linear mapping are
> currently marked as fully accessible.

Hi Jann,

To confirm my understanding, this is not just KASAN (except in HW_TAGS
mode), but also CONFIG_VMAP_STACK is required, right?

> Since stack corruption issues can cause some very gnarly errors, let's be
> extra careful and tell KASAN to forbid accesses to stack memory through the
> linear mapping.
>
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I wrote this after seeing
> https://lore.kernel.org/all/Y8W5rjKdZ9erIF14@casper.infradead.org/
> and wondering about possible ways that this kind of stack corruption
> could be sneaking past KASAN.
> That's proooobably not the explanation, but still...

I think catching any silent corruptions is still very useful. Besides
confusing reports, sometimes they lead to an explosion of random
reports all over the kernel.

>  include/linux/vmalloc.h |  6 ++++++
>  kernel/fork.c           | 10 ++++++++++
>  mm/vmalloc.c            | 24 ++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
>
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index 096d48aa3437..bfb50178e5e3 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -297,4 +297,10 @@ bool vmalloc_dump_obj(void *object);
>  static inline bool vmalloc_dump_obj(void *object) { return false; }
>  #endif
>
> +#if defined(CONFIG_MMU) && (defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS))
> +void vmalloc_poison_backing_pages(const void *addr);
> +#else
> +static inline void vmalloc_poison_backing_pages(const void *addr) {}
> +#endif

I think this should be in kasan headers and prefixed with kasan_.
There are also kmsan/kcsan that may poison memory and hw poisoning
(MADV_HWPOISON), so it's a somewhat overloaded term on its own.

Can/should this be extended to all vmalloc-ed memory? Or some of it
can be accessed via both addresses?

Also, should we mprotect it instead while it's allocated as the stack?
If it works, it looks like a reasonable improvement for
CONFIG_VMAP_STACK in general. Would also catch non-instrumented
accesses.

>  #endif /* _LINUX_VMALLOC_H */
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 9f7fe3541897..5c8c103a3597 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -321,6 +321,16 @@ static int alloc_thread_stack_node(struct task_struct *tsk, int node)
>                 vfree(stack);
>                 return -ENOMEM;
>         }
> +
> +       /*
> +        * A virtually-allocated stack's memory should only be accessed through
> +        * the vmalloc area, not through the linear mapping.
> +        * Inform KASAN that all accesses through the linear mapping should be
> +        * reported (instead of permitting all accesses through the linear
> +        * mapping).
> +        */
> +       vmalloc_poison_backing_pages(stack);
> +
>         /*
>          * We can't call find_vm_area() in interrupt context, and
>          * free_thread_stack() can be called in interrupt context,
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index ca71de7c9d77..10c79c53cf5c 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -4042,6 +4042,30 @@ void pcpu_free_vm_areas(struct vm_struct **vms, int nr_vms)
>  }
>  #endif /* CONFIG_SMP */
>
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> +/*
> + * Poison the KASAN shadow for the linear mapping of the pages used as stack
> + * memory.
> + * NOTE: This makes no sense in HW_TAGS mode because HW_TAGS marks physical
> + * memory, not virtual memory.
> + */
> +void vmalloc_poison_backing_pages(const void *addr)
> +{
> +       struct vm_struct *area;
> +       int i;
> +
> +       if (WARN(!PAGE_ALIGNED(addr), "bad address (%p)\n", addr))
> +               return;
> +
> +       area = find_vm_area(addr);
> +       if (WARN(!area, "nonexistent vm area (%p)\n", addr))
> +               return;
> +
> +       for (i = 0; i < area->nr_pages; i++)
> +               kasan_poison_pages(area->pages[i], 0, false);
> +}
> +#endif
> +
>  #ifdef CONFIG_PRINTK
>  bool vmalloc_dump_obj(void *object)
>  {
>
> base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
> --
> 2.39.0.314.g84b9a713c41-goog
>
