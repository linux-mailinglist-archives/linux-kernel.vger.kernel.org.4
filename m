Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2F56CBE95
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 14:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjC1MGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 08:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjC1MGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 08:06:31 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF118A6A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:06:10 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id e65so14644119ybh.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680005169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3nAcSUy1w+Q3o4Q/OHStFI724GxYk97V8A1XUu2jF9g=;
        b=tZa3WmFVr6RJgCaIfgBSVSh5UJAade1I1QF6Y5qLZX+p5/0pOE+NyAqJb34ijpgvjd
         a6w/tekWdgzKPOFQrdoYaQh73r3k1rc4X9mt3Ao0AY0PHt72GMO8ZXDSSdUNefdX/+7k
         Kn+vfIc31GHU4gb0wXLaw/1UTW0uTLE34ZJzIa4WtXMcu67P4SdjX6mPOW+QGdEuMwsV
         DFZFOBBnZGM2/gfm25X5YqKAz/TPJ0zUmtMLaGRqkYdC5wIwXaUokpflDtQ+WzgP5L65
         Zd839NwdPk96D/HoVrbKoCgviUXxXuc58uifBzz4BLe8CLZu1r5+hJYIUK7NdBNjIYHx
         qqLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680005169;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nAcSUy1w+Q3o4Q/OHStFI724GxYk97V8A1XUu2jF9g=;
        b=nLixMIDySv78dJPStVJYwG47AN8TKfcL9EY+hzgXayXUWuWFvFF6qmCD1X7jGoXPlv
         ntraRJi66xNod9g3aqGky/B+uZVh6G7DA64dFU8woWqleY4cMQ9Hbk9SP35PRWrv5t96
         t+a2CSDs/QXdrwemSzLd1X9hHDqPqlID38zyWbnwUM4SBKQd9Ug4ym1NHjmdfvIpa7vF
         wS6oqb0v9EpGUV5IYOQ+gCeWYkrQ4i2eQLFGjzjsl+v9y8FMMYZfKdkF5Pprphw2aBG8
         WIPS2UOUZzF3pgMFtcqwTQ6jKa//WLyk/rz0r+CSlrzXf5UPobWxHTl8z6HpKV7dNCOL
         oNHw==
X-Gm-Message-State: AAQBX9c60cHHYWdIUXwfDdWBLq5SPBvzrwIQmfrR8bVO4b/m8ihpIqsI
        YDLc692zZ1HLmf3YuswTswHNM9I/USXzvN0OVwzcHg==
X-Google-Smtp-Source: AKy350aToJDCkqdHj4cvOy9j5YOCIDb5O0Wx7AGL45KuARN30ai2RSkBk4pWZ82+ReFD4c9+OqF0SoFAI0rKZsxtvQY=
X-Received: by 2002:a25:5d7:0:b0:b67:8ad6:7529 with SMTP id
 206-20020a2505d7000000b00b678ad67529mr14054216ybf.65.1680005168914; Tue, 28
 Mar 2023 05:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230328095807.7014-1-songmuchun@bytedance.com>
 <20230328095807.7014-2-songmuchun@bytedance.com> <CANpmjNP+nLfMKLj-4L4wXBfQpO5N0Y6q_TEkxjM+Z0WXxPvVxg@mail.gmail.com>
In-Reply-To: <CANpmjNP+nLfMKLj-4L4wXBfQpO5N0Y6q_TEkxjM+Z0WXxPvVxg@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Mar 2023 14:05:32 +0200
Message-ID: <CANpmjNNXDHZGr_r6aZi1bv5itc5KvGhRNnq_CSQRrmB6Wwx+Dg@mail.gmail.com>
Subject: Re: [PATCH 1/6] mm: kfence: simplify kfence pool initialization
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     glider@google.com, dvyukov@google.com, akpm@linux-foundation.org,
        jannh@google.com, sjpark@amazon.de, muchun.song@linux.dev,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
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

On Tue, 28 Mar 2023 at 13:55, Marco Elver <elver@google.com> wrote:
>
> On Tue, 28 Mar 2023 at 11:58, Muchun Song <songmuchun@bytedance.com> wrote:
> >
> > There are three similar loops to initialize kfence pool, we could merge
> > all of them into one loop to simplify the code and make code more
> > efficient.
> >
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>
> Reviewed-by: Marco Elver <elver@google.com>
>
> > ---
> >  mm/kfence/core.c | 47 ++++++-----------------------------------------
> >  1 file changed, 6 insertions(+), 41 deletions(-)
> >
> > diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> > index 7d01a2c76e80..de62a84d4830 100644
> > --- a/mm/kfence/core.c
> > +++ b/mm/kfence/core.c
> > @@ -539,35 +539,10 @@ static void rcu_guarded_free(struct rcu_head *h)
> >  static unsigned long kfence_init_pool(void)
> >  {
> >         unsigned long addr = (unsigned long)__kfence_pool;
> > -       struct page *pages;
> >         int i;
> >
> >         if (!arch_kfence_init_pool())
> >                 return addr;
> > -
> > -       pages = virt_to_page(__kfence_pool);
> > -
> > -       /*
> > -        * Set up object pages: they must have PG_slab set, to avoid freeing
> > -        * these as real pages.
> > -        *
> > -        * We also want to avoid inserting kfence_free() in the kfree()
> > -        * fast-path in SLUB, and therefore need to ensure kfree() correctly
> > -        * enters __slab_free() slow-path.
> > -        */

Actually: can you retain this comment somewhere?

> > -       for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> > -               struct slab *slab = page_slab(nth_page(pages, i));
> > -
> > -               if (!i || (i % 2))
> > -                       continue;
> > -
> > -               __folio_set_slab(slab_folio(slab));
> > -#ifdef CONFIG_MEMCG
> > -               slab->memcg_data = (unsigned long)&kfence_metadata[i / 2 - 1].objcg |
> > -                                  MEMCG_DATA_OBJCGS;
> > -#endif
> > -       }
> > -
> >         /*
> >          * Protect the first 2 pages. The first page is mostly unnecessary, and
> >          * merely serves as an extended guard page. However, adding one
> > @@ -581,8 +556,9 @@ static unsigned long kfence_init_pool(void)
> >                 addr += PAGE_SIZE;
> >         }
> >
> > -       for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
> > +       for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++, addr += 2 * PAGE_SIZE) {
> >                 struct kfence_metadata *meta = &kfence_metadata[i];
> > +               struct slab *slab = page_slab(virt_to_page(addr));
> >
> >                 /* Initialize metadata. */
> >                 INIT_LIST_HEAD(&meta->list);
> > @@ -593,26 +569,15 @@ static unsigned long kfence_init_pool(void)
> >
> >                 /* Protect the right redzone. */
> >                 if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
> > -                       goto reset_slab;
> > -
> > -               addr += 2 * PAGE_SIZE;
> > -       }
> > -
> > -       return 0;
> > -
> > -reset_slab:
> > -       for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> > -               struct slab *slab = page_slab(nth_page(pages, i));
> > +                       return addr;
> >
> > -               if (!i || (i % 2))
> > -                       continue;
> > +               __folio_set_slab(slab_folio(slab));
> >  #ifdef CONFIG_MEMCG
> > -               slab->memcg_data = 0;
> > +               slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
> >  #endif
> > -               __folio_clear_slab(slab_folio(slab));
> >         }
> >
> > -       return addr;
> > +       return 0;
> >  }
> >
> >  static bool __init kfence_init_pool_early(void)
> > --
> > 2.11.0
> >
