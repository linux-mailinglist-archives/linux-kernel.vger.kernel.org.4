Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD706AAF13
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 11:32:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCEKcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 05:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjCEKcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 05:32:21 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E6BFF34;
        Sun,  5 Mar 2023 02:32:20 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id n8so2151024qkp.5;
        Sun, 05 Mar 2023 02:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678012339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HyWuCklZqeWHeAAvpRzvccua2zn3XmympaWs29aKNGQ=;
        b=RpxZlBFYj7ktpGFKb2LRVRIYWz3V9QosLteYaUkRcCR0QYNaGXzpYJ+UQ4bhGCZ87B
         aDBzGSpC+ANhYSGo/P7znGRLP+rYWE+n6PmbH9kUyhxZ12tRVMSA/UWn8pl0BnUctyvn
         7BRrx6rA2vTUlt5RkOyQ1PORtOE/O5cxF46RzmExF5u9X5Az7S7tovxjgUhNEUa1231q
         vj4I6uYo/Ar8gRN8usfsqgymfHEhi024MInhPTCJGSgVGBtwVoMKkkZ0WK/cXhYaaCVs
         buEvQRTFADyYBtFYlziJvx8jgvHSlTJodB2o0/KtyW8r4RzIm+j83bLf9zkDN3ltvhV0
         A6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678012339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HyWuCklZqeWHeAAvpRzvccua2zn3XmympaWs29aKNGQ=;
        b=O40U1+bMLHwW3fOprI27AKS4GnTDv9oxEVHBJ/9VY5h8qtoWOKhANL+EGXpOmH9H1Z
         HavG+DhhXxaKGpRB4IqGIvpEZxEVIqCjqz+XZ8GM3nt/OgxC8ueB6pUsofZJNEPf4IFt
         KZtnQfM8dOz642WeFtiIlLJM0pYX+OUBE/s5cEsnOQT+0Uc3wnAAcJpu2w9w4hqLFDIc
         /nu4qGIViFJIU9chwyyuSI40m1evZy5TF3+5JNdS6Mk7I7uQbLZwyCgxSQOz0/ehHXlI
         LvrVqgvrtHGnvFP1l1qvtL0WXXm1Xdfe1XzzfRAuXsTTVPhkthDxa3dzNDEbR/oT/q0L
         ztVw==
X-Gm-Message-State: AO0yUKVs6HGEmev4vru7/YNxIuJuuVCTTgJcjmDK/TVEGJ+PstdbKRyb
        Z8LHh8NTVKcS6UXGjVe/fCzttE0L13E84p6wzAA=
X-Google-Smtp-Source: AK7set+dbxiU9HKVUjdXSTLsWZhS1FzVFcfvLw7VRJXoIt9CBrIZUYxSyYPJNZN/bfB76VozAT8xvEIg2wXXSfhRKXg=
X-Received: by 2002:a37:64c1:0:b0:71f:b89c:5ac7 with SMTP id
 y184-20020a3764c1000000b0071fb89c5ac7mr1479076qkb.8.1678012339264; Sun, 05
 Mar 2023 02:32:19 -0800 (PST)
MIME-Version: 1.0
References: <20230219073318.366189-1-nphamcs@gmail.com> <20230219073318.366189-3-nphamcs@gmail.com>
 <Y/IUTiL03C9OOSFx@casper.infradead.org>
In-Reply-To: <Y/IUTiL03C9OOSFx@casper.infradead.org>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Sun, 5 Mar 2023 02:32:08 -0800
Message-ID: <CAKEwX=PTXLp7oe5HmmTpMuCbupuxsvw3gCwMqe=p4ck2byr7Zw@mail.gmail.com>
Subject: Re: [PATCH v10 2/3] cachestat: implement cachestat syscall
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bfoster@redhat.com, arnd@arndb.de,
        linux-api@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 19, 2023 at 4:21=E2=80=AFAM Matthew Wilcox <willy@infradead.org=
> wrote:
>
> On Sat, Feb 18, 2023 at 11:33:17PM -0800, Nhat Pham wrote:
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index e654435f1651..83300f1491e7 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -75,6 +75,7 @@ struct fs_context;
> >  struct fs_parameter_spec;
> >  struct fileattr;
> >  struct iomap_ops;
> > +struct cachestat;
> >
> >  extern void __init inode_init(void);
> >  extern void __init inode_init_early(void);
> > @@ -830,6 +831,8 @@ void filemap_invalidate_lock_two(struct address_spa=
ce *mapping1,
> >                                struct address_space *mapping2);
> >  void filemap_invalidate_unlock_two(struct address_space *mapping1,
> >                                  struct address_space *mapping2);
> > +void filemap_cachestat(struct address_space *mapping, pgoff_t first_in=
dex,
> > +             pgoff_t last_index, struct cachestat *cs);
>
> 1. Why is this in fs.h instead of pagemap.h?
>
> 2. Why is it not static, since it's only used by the syscall,
> which is also in filemap.c?

Actually, I think I can remove its occurrence in another header file
altogether. I think it was an artifact from a past iteration, which
has filemap_cachestat in filemap.c but the syscall in its own
file (cachestat.c).

And you're right - we only have one use case for it now
(for the syscall). I'll make it static.

>
> > @@ -55,6 +56,9 @@
> >  #include <linux/buffer_head.h> /* for try_to_free_buffers */
> >
> >  #include <asm/mman.h>
> > +#include <uapi/linux/mman.h>
>
> I think this hunk should be:
>
> -#include <asm/mman.h>
> +#include <linux/mman.h>

Will be fixed in the next version - thanks for letting me know!

>
> (linux/mman.h includes uapi/linux/mman.h, which includes asm/mman.h)
>
> > +/**
> > + * filemap_cachestat() - compute the page cache statistics of a mappin=
g
> > + * @mapping: The mapping to compute the statistics for.
> > + * @first_index:     The starting page cache index.
> > + * @last_index:      The final page index (inclusive).
> > + * @cs:      the cachestat struct to write the result to.
> > + *
> > + * This will query the page cache statistics of a mapping in the
> > + * page range of [first_index, last_index] (inclusive). The statistics
> > + * queried include: number of dirty pages, number of pages marked for
> > + * writeback, and the number of (recently) evicted pages.
> > + */
>
> Do we care that this isn't going to work for hugetlbfs?
>
> > +     rcu_read_lock();
> > +     xas_for_each(&xas, folio, last_index) {
> > +             unsigned long nr_pages;
> > +             pgoff_t folio_first_index, folio_last_index;
> > +
> > +             if (xas_retry(&xas, folio))
> > +                     continue;
> > +
> > +             nr_pages =3D folio_nr_pages(folio);
> > +             folio_first_index =3D folio_pgoff(folio);
> > +             folio_last_index =3D folio_first_index + nr_pages - 1;
> > +
> > +             /* Folios might straddle the range boundaries, only count=
 covered subpages */
>
> s/subpages/pages/

Yeah that comment is incorrect/confusing with the pages terminology.
It'll be fixed!
