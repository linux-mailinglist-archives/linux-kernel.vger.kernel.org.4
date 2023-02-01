Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C85685D5B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 03:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjBAC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 21:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230433AbjBAC3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 21:29:11 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAB259E55
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:29:06 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id o4so3677837qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 18:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HfkJm0FYJosG42FnOanLfmkwIK+BW+AiL4ENGRclS8I=;
        b=HCp/m4brSjwYXq5U4avqlXNv90V/dRcJ5rb1WqZvLtVTaxEVDRtDooQpv03rZIN3F9
         HflgMs0paNw/2l88CwLWd4h8/PzMNvlNxR7xSgfx+7JRzeFQZbrHaW1GnUWRuDjnaK/r
         6pCit8maqsaIPxrkQ4AExY1plKRIeVq/FqUAXQycT1TL+7lE8OrZxmQIZ3u+oZHzGe7J
         rcGwMjnu3HzBxS4x714/h+TRfwob06HC/6MDxqRrAl2Tq+y6q0gdJCB6J52ZZBRbIQG9
         7z9gbZ+kU3g0Yx99WRy/CYtZ0wPFTnbZ2wW6siMRRbBSA4hgk4JOVZOvvoAi/c7ZJV98
         3isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HfkJm0FYJosG42FnOanLfmkwIK+BW+AiL4ENGRclS8I=;
        b=ul7J2L2suE+fp62q9xWQaIX14CrebXEcLq6wgAcLLqy0glOSztCz8LYzw1gtJb7nih
         XZPyAy4PDL9O66QfRarftWePZSMaBuTp7QB1JRPb8c/UqqVw3TpwVdvP6cp50Ph8HbSs
         vESPZP09fjHAMfPMtbUVd6bz6F0LogvkLFUsR9TqA2QHSOMJ0wyKG5fWvL+3JrnCO/G9
         IuQattJhlcZ6RqTkApxNNWIOtN5cG2u6HDS0rcid2LzQ6KJRonLN0MdAUHPdCGxH/Dds
         3kdMiSyOt8B9VX8MQ8UnBfFx0WbaGmJV8GOA1iCQX8zjCMFqQNsGn7G+q5GNT3UFPDmd
         L4Kw==
X-Gm-Message-State: AO0yUKUHLfDQ/ZIY1mybZRaeBI8ufUMhOmx+KZur/XOeY9YzXJXh6b1L
        J8tWOJ7p3eCpNYHPKQJDzE4YQQs03NN2jqJ4YvM=
X-Google-Smtp-Source: AK7set84QFYUpiuU6AhyzUU0UwGy6qg3XrCuPyrUuSpvs+esE8nb6FO799RgT1Oduu9QynrGXsqJRRrMvXqGMkAbenU=
X-Received: by 2002:a05:620a:a95:b0:725:1245:9cea with SMTP id
 v21-20020a05620a0a9500b0072512459ceamr80955qkg.233.1675218545522; Tue, 31 Jan
 2023 18:29:05 -0800 (PST)
MIME-Version: 1.0
References: <20230110231701.326724-1-nphamcs@gmail.com> <Y9nDXBt2OR3hg5X7@google.com>
In-Reply-To: <Y9nDXBt2OR3hg5X7@google.com>
From:   Nhat Pham <nphamcs@gmail.com>
Date:   Tue, 31 Jan 2023 18:28:54 -0800
Message-ID: <CAKEwX=My-B=KkocO0heMm=7e+Qxkg2RdRJ8pRHm9dBk+Cceyzw@mail.gmail.com>
Subject: Re: [PATCH] zsmalloc: fix a race with deferred_handles storing
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, minchan@kernel.org,
        ngupta@vflare.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, kernel-team@meta.com
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

On Tue, Jan 31, 2023 at 5:41 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/01/10 15:17), Nhat Pham wrote:
> [..]
> >  #ifdef CONFIG_ZPOOL
> > +static void restore_freelist(struct zs_pool *pool, struct size_class *class,
> > +             struct zspage *zspage)
> > +{
> > +     unsigned int obj_idx = 0;
> > +     unsigned long handle, off = 0; /* off is within-page offset */
> > +     struct page *page = get_first_page(zspage);
> > +     struct link_free *prev_free = NULL;
> > +     void *prev_page_vaddr = NULL;
> > +
> > +     /* in case no free object found */
> > +     set_freeobj(zspage, (unsigned int)(-1UL));
>
> I'm not following this. I see how -1UL works for link_free, but this
> cast of -1UL to 4 bytes looks suspicious.

(resending this since I forgot to forward this to other recipients)

It is a bit convoluted indeed. But the idea is that for the last object,
the last link is given by:

link->next = -1UL << OBJ_TAG_BITS

And at malloc time, we update freeobj as follows
set_freeobj(zspage, link->next >> OBJ_TAG_BITS);

Which means the freeobj value would be set to something like this:
(-1UL << OBJ_TAG_BITS) >> OBJ_TAG_BITS

I want to emulate this here (i.e in the case we have no free object).
As for the casting, I believe set_freeobj requires an unsigned int for
the second field.

Alternatively, to be 100% safe, we can do something like this:
(unsigned int)((-1UL << OBJ_TAG_BITS) >> OBJ_TAG_BITS)

But I think I got the same result as just (unsigned int)(-1UL)
when I printed out these two values - feel free to
fact check me on this of course.

Let me know what you think about this, or if you have a
cleaner/safer way to handle this edge case :)
>
> > +     while (page) {
> > +             void *vaddr = kmap_atomic(page);
> > +             struct page *next_page;
> > +
> > +             while (off < PAGE_SIZE) {
> > +                     void *obj_addr = vaddr + off;
> > +
> > +                     /* skip allocated object */
> > +                     if (obj_allocated(page, obj_addr, &handle)) {
> > +                             obj_idx++;
> > +                             off += class->size;
> > +                             continue;
> > +                     }
> > +
> > +                     /* free deferred handle from reclaim attempt */
> > +                     if (obj_stores_deferred_handle(page, obj_addr, &handle))
> > +                             cache_free_handle(pool, handle);
> > +
> > +                     if (prev_free)
> > +                             prev_free->next = obj_idx << OBJ_TAG_BITS;
> > +                     else /* first free object found */
> > +                             set_freeobj(zspage, obj_idx);
> > +
> > +                     prev_free = (struct link_free *)vaddr + off / sizeof(*prev_free);
> > +                     /* if last free object in a previous page, need to unmap */
> > +                     if (prev_page_vaddr) {
> > +                             kunmap_atomic(prev_page_vaddr);
> > +                             prev_page_vaddr = NULL;
> > +                     }
> > +
> > +                     obj_idx++;
> > +                     off += class->size;
> > +             }
> > +
> > +             /*
> > +              * Handle the last (full or partial) object on this page.
> > +              */
> > +             next_page = get_next_page(page);
> > +             if (next_page) {
> > +                     if (!prev_free || prev_page_vaddr) {
> > +                             /*
> > +                              * There is no free object in this page, so we can safely
> > +                              * unmap it.
> > +                              */
> > +                             kunmap_atomic(vaddr);
> > +                     } else {
> > +                             /* update prev_page_vaddr since prev_free is on this page */
> > +                             prev_page_vaddr = vaddr;
> > +                     }
>
> A polite and gentle nit: I'd appreciate it if we honored kernel coding
> styles in zsmalloc a little bit more. Comments, function declarations, etc.
> I'm personally very happy with https://github.com/vivien/vim-linux-coding-style
