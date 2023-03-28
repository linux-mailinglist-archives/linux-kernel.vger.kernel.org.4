Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB916CC1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjC1OOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjC1OOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:14:19 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E1D11712
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:13:36 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id i7so15258152ybt.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 07:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680012815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jzWLbAObXvnp3yLVMyDVLp9e3kaBgXUsN1mJJacdlX8=;
        b=ZxRNUzUxLB9REoDREOixbz4eFEWuyEqwmhgyBF6WmbsF00RDZFKU5uzC2pdcoOfRPK
         QBanYwehL+UDx9Pvcs5Nei1iZHw7D1OwTezMUMs4SAk8OKgL4d26BIa9q30tXs1nymei
         7qtkgJ19TKcEHmuQ5LgIxxcOvUrf364zTTlDDt35fFK8HnN3WIJaqu3YkoFpdASeB5x+
         zW/6L7mkZ/nQcroYwbW3JZc9x78AtLtB6+h/7OCWHr/F5NfBQx7W5DytnmcAYgfoZuyZ
         wam0ugMe4jX6adpjoJdzkCrbVoSl1YsUzVqNCDAM9K44qNAdJ6x8pQtsV21EopaDBvPz
         IEog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680012815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzWLbAObXvnp3yLVMyDVLp9e3kaBgXUsN1mJJacdlX8=;
        b=p8EYqk3N/XKhG3JNmTsD3rZR4GqLAtlQj9pR8rEOC03NIe45ZuWg6ePupEAySPh6N4
         di1/n5Yl5l93UUkbHk7XRC6AeZYikKfec8dTvHESibn9Uh02QjnbY8DPTCz8foIzLPqU
         oq3Z79SBexaAqmD/fkYkI5KsH9VK7xBuZ2IGVol11ys5837VXbIm9Bd+C+vZzuDLJx3i
         cy22Bx/gAAcmnxv0FA8qcllKMq4L0NPF+kaMrWJ8HgYkW0UAfpw+kcQnczG1tzDZlOhZ
         fSFW4BAGTADgCc4fnHKtVexm569zq9rRZhhiyrhKlg9rtbK79tOOSc8qB8Stlj46UD9Y
         EcKA==
X-Gm-Message-State: AAQBX9d17ZtPmx9cJ8iHV3V7gjY4SR9sUIvbTq3skfI3TWZU0r5NcDnD
        QZ/8O58wB/H5DTXB8TcNYhHMggmmBlueOY8W6LvEcg==
X-Google-Smtp-Source: AKy350Yel3s2ZrfmqC5v9KmHoPxUi+CMV8z/smBb5noBYFwid1ZitraBvLeD9d7uUR0i6sboB64GES0/JGWIFMA/1DQ=
X-Received: by 2002:a25:1fc2:0:b0:b59:172a:eafa with SMTP id
 f185-20020a251fc2000000b00b59172aeafamr12664636ybf.17.1680012815308; Tue, 28
 Mar 2023 07:13:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230328095807.7014-1-songmuchun@bytedance.com>
 <20230328095807.7014-6-songmuchun@bytedance.com> <CANpmjNPZxDYPYzEjr55ONydwH1FZF_Eh_gu7XKg=4-+HK6vL9Q@mail.gmail.com>
 <291FB0BF-F824-4ED9-B836-DA7773BFDA48@linux.dev>
In-Reply-To: <291FB0BF-F824-4ED9-B836-DA7773BFDA48@linux.dev>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Mar 2023 16:12:58 +0200
Message-ID: <CANpmjNOkf66ORysVrSZRXbRxoDQSg7kky6o0W+p0Jj_g10bJKQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] mm: kfence: change kfence pool page layout
To:     Muchun Song <muchun.song@linux.dev>
Cc:     Muchun Song <songmuchun@bytedance.com>, glider@google.com,
        dvyukov@google.com, akpm@linux-foundation.org, jannh@google.com,
        sjpark@amazon.de, kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2023 at 15:33, Muchun Song <muchun.song@linux.dev> wrote:
>
>
>
> > On Mar 28, 2023, at 20:59, Marco Elver <elver@google.com> wrote:
> >
> > On Tue, 28 Mar 2023 at 11:58, 'Muchun Song' via kasan-dev
> > <kasan-dev@googlegroups.com> wrote:
> >>
> >> The original kfence pool layout (Given a layout with 2 objects):
> >>
> >> +------------+------------+------------+------------+------------+------------+
> >> | guard page | guard page |   object   | guard page |   object   | guard page |
> >> +------------+------------+------------+------------+------------+------------+
> >>                           |                         | |
> >>                           +----kfence_metadata[0]---+----kfence_metadata[1]---+
> >>
> >> The comment says "the additional page in the beginning gives us an even
> >> number of pages, which simplifies the mapping of address to metadata index".
> >>
> >> However, removing the additional page does not complicate any mapping
> >> calculations. So changing it to the new layout to save a page. And remmove
> >> the KFENCE_ERROR_INVALID test since we cannot test this case easily.
> >>
> >> The new kfence pool layout (Given a layout with 2 objects):
> >>
> >> +------------+------------+------------+------------+------------+
> >> | guard page |   object   | guard page |   object   | guard page |
> >> +------------+------------+------------+------------+------------+
> >> |                         |                         |
> >> +----kfence_metadata[0]---+----kfence_metadata[1]---+
> >>
> >> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> >> ---
> >> include/linux/kfence.h  |  8 ++------
> >> mm/kfence/core.c        | 40 ++++++++--------------------------------
> >> mm/kfence/kfence.h      |  2 +-
> >> mm/kfence/kfence_test.c | 14 --------------
> >> 4 files changed, 11 insertions(+), 53 deletions(-)
> >>
> >> diff --git a/include/linux/kfence.h b/include/linux/kfence.h
> >> index 726857a4b680..25b13a892717 100644
> >> --- a/include/linux/kfence.h
> >> +++ b/include/linux/kfence.h
> >> @@ -19,12 +19,8 @@
> >>
> >> extern unsigned long kfence_sample_interval;
> >>
> >> -/*
> >> - * We allocate an even number of pages, as it simplifies calculations to map
> >> - * address to metadata indices; effectively, the very first page serves as an
> >> - * extended guard page, but otherwise has no special purpose.
> >> - */
> >> -#define KFENCE_POOL_SIZE ((CONFIG_KFENCE_NUM_OBJECTS + 1) * 2 * PAGE_SIZE)
> >> +/* The last page serves as an extended guard page. */
> >
> > The last page is just a normal guard page? I.e. the last 2 pages are:
> > <object page> | <guard page>
>
> Right.
>
> The new kfence pool layout (Given a layout with 2 objects):
>
> +------------+------------+------------+------------+------------+
> | guard page |   object   | guard page |   object   | guard page |
> +------------+------------+------------+------------+------------+
> |                         |                         |     ^
> +----kfence_metadata[0]---+----kfence_metadata[1]---+     |
>                                                           |
>                                                           |
>                                                      the last page
>
> >
> > Or did I misunderstand?
> >
> >> +#define KFENCE_POOL_SIZE       ((CONFIG_KFENCE_NUM_OBJECTS * 2 + 1) * PAGE_SIZE)
> >> extern char *__kfence_pool;
> >>
> >> DECLARE_STATIC_KEY_FALSE(kfence_allocation_key);
> >> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> >> index 41befcb3b069..f205b860f460 100644
> >> --- a/mm/kfence/core.c
> >> +++ b/mm/kfence/core.c
> >> @@ -240,24 +240,7 @@ static inline void kfence_unprotect(unsigned long addr)
> >>
> >> static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
> >> {
> >> -       unsigned long offset = (meta - kfence_metadata + 1) * PAGE_SIZE * 2;
> >> -       unsigned long pageaddr = (unsigned long)&__kfence_pool[offset];
> >> -
> >> -       /* The checks do not affect performance; only called from slow-paths. */
> >> -
> >> -       /* Only call with a pointer into kfence_metadata. */
> >> -       if (KFENCE_WARN_ON(meta < kfence_metadata ||
> >> -                          meta >= kfence_metadata + CONFIG_KFENCE_NUM_OBJECTS))
> >> -               return 0;
> >
> > Could we retain this WARN_ON? Or just get rid of
> > metadata_to_pageaddr() altogether, because there's only 1 use left and
> > the function would now just be a simple ALIGN_DOWN() anyway.
>
> I'll inline this function to its caller since the warning is unlikely.
>
> >
> >> -       /*
> >> -        * This metadata object only ever maps to 1 page; verify that the stored
> >> -        * address is in the expected range.
> >> -        */
> >> -       if (KFENCE_WARN_ON(ALIGN_DOWN(meta->addr, PAGE_SIZE) != pageaddr))
> >> -               return 0;
> >> -
> >> -       return pageaddr;
> >> +       return ALIGN_DOWN(meta->addr, PAGE_SIZE);
> >> }
> >>
> >> /*
> >> @@ -535,34 +518,27 @@ static void kfence_init_pool(void)
> >>        unsigned long addr = (unsigned long)__kfence_pool;
> >>        int i;
> >>
> >> -       /*
> >> -        * Protect the first 2 pages. The first page is mostly unnecessary, and
> >> -        * merely serves as an extended guard page. However, adding one
> >> -        * additional page in the beginning gives us an even number of pages,
> >> -        * which simplifies the mapping of address to metadata index.
> >> -        */
> >> -       for (i = 0; i < 2; i++, addr += PAGE_SIZE)
> >> -               kfence_protect(addr);
> >> -
> >>        for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++, addr += 2 * PAGE_SIZE) {
> >>                struct kfence_metadata *meta = &kfence_metadata[i];
> >> -               struct slab *slab = page_slab(virt_to_page(addr));
> >> +               struct slab *slab = page_slab(virt_to_page(addr + PAGE_SIZE));
> >>
> >>                /* Initialize metadata. */
> >>                INIT_LIST_HEAD(&meta->list);
> >>                raw_spin_lock_init(&meta->lock);
> >>                meta->state = KFENCE_OBJECT_UNUSED;
> >> -               meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
> >> +               meta->addr = addr + PAGE_SIZE;
> >>                list_add_tail(&meta->list, &kfence_freelist);
> >>
> >> -               /* Protect the right redzone. */
> >> -               kfence_protect(addr + PAGE_SIZE);
> >> +               /* Protect the left redzone. */
> >> +               kfence_protect(addr);
> >>
> >>                __folio_set_slab(slab_folio(slab));
> >> #ifdef CONFIG_MEMCG
> >>                slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
> >> #endif
> >>        }
> >> +
> >> +       kfence_protect(addr);
> >> }
> >>
> >> static bool __init kfence_init_pool_early(void)
> >> @@ -1043,7 +1019,7 @@ bool kfence_handle_page_fault(unsigned long addr, bool is_write, struct pt_regs
> >>
> >>        atomic_long_inc(&counters[KFENCE_COUNTER_BUGS]);
> >>
> >> -       if (page_index % 2) {
> >> +       if (page_index % 2 == 0) {
> >>                /* This is a redzone, report a buffer overflow. */
> >>                struct kfence_metadata *meta;
> >>                int distance = 0;
> >> diff --git a/mm/kfence/kfence.h b/mm/kfence/kfence.h
> >> index 600f2e2431d6..249d420100a7 100644
> >> --- a/mm/kfence/kfence.h
> >> +++ b/mm/kfence/kfence.h
> >> @@ -110,7 +110,7 @@ static inline struct kfence_metadata *addr_to_metadata(unsigned long addr)
> >>         * __kfence_pool, in which case we would report an "invalid access"
> >>         * error.
> >>         */
> >> -       index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2) - 1;
> >> +       index = (addr - (unsigned long)__kfence_pool) / (PAGE_SIZE * 2);
> >>        if (index < 0 || index >= CONFIG_KFENCE_NUM_OBJECTS)
> >>                return NULL;
> >
> > Assume there is a right OOB that hit the last guard page. In this case
> >
> >  addr >= __kfence_pool + (NUM_OBJECTS * 2 * PAGE_SIZE) && addr <
> > __kfence_pool + POOL_SIZE
> >
> > therefore
> >
> >  index >= (NUM_OBJECTS * 2 * PAGE_SIZE) / (PAGE_SIZE * 2) && index <
> > POOL_SIZE / (PAGE_SIZE * 2)
> >  index == NUM_OBJECTS
> >
> > And according to the above comparison, this will return NULL and
> > report KFENCE_ERROR_INVALID, which is wrong.
>
> Look at kfence_handle_page_fault(), which first look up "addr - PAGE_SIZE" (passed
> to addr_to_metadata()) and then look up "addr + PAGE_SIZE", the former will not
> return NULL, the latter will return NULL. So kfence will report KFENCE_ERROR_OOB
> in this case, right? Or what I missed here?

Yes, you're right.

Thanks,
-- Marco
