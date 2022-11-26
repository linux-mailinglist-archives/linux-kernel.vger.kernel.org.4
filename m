Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D30639753
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiKZREz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKZREx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:04:53 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD32165BD;
        Sat, 26 Nov 2022 09:04:51 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id r18so6306089pgr.12;
        Sat, 26 Nov 2022 09:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uKmnIaloULHriFcopQa51nxjENCmgGQKjpIIPfSTFtA=;
        b=cUl3qd8uHgMRnh/jnbftDT5GuOqOGJykCT0pya8ESdkiNfooRYdYuiSOuFbi6w33q0
         z54HxlT4PtUYM/1qhIPEZBiXQJ7WSuwNx2xlQgP6BKp21xw8RQoecof64jc7AaarEseG
         7ooKsL4oeFBlvE3/IBHNRYQ6aDhlmVNYVB4pnJnhZyGAHQFKx1MYNc/wsFicJ+hqf5aZ
         vruBYyyEKpuKKA5K53JKW+sitwUlXyLTjv5Z0OVBb/OOSxnU7i6Y//RxtAJYK4EYlaLO
         tTPxVFL1iOHrADsTKZrnRNjFIOGluQkFeHLIsV05MxwKLlZcaJztx8K6uK1d/Zb/5RWM
         FvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uKmnIaloULHriFcopQa51nxjENCmgGQKjpIIPfSTFtA=;
        b=tl5pp97gLbb9vdR3u9tUxW+mBU/13bWZ/OOc5ZfnxiZGIstl/t1XXxnxwWMFc1eGxS
         uE2l+ZpVM1ppaQB6r44D3D94jsYJOX/FH9ChVnSXrywIvBnlnLKs2P4+aBP8qMDjHly9
         m+UFKA1Ws+iowoJ+JcihdwGO2EBUJkkQIGubn2xyxs4Q9Gb6j8YXuiFqxLbiNyu6XWJF
         Nv3s4lJOnp37AyYfBnr9RUhQh3MCi2GHdMbKKhQ1gFXEcmf97JBuNUd9Vcj/GhaOOMGv
         5if6PLUQaWz97y5tvkpXE05oA5EnrBtTjXwQZ5X6jbQjKrNeQ9NkqMmHFETXxf4o/jGf
         cKwA==
X-Gm-Message-State: ANoB5pl4xZs77uHZX9OD67Y/sASWKPpMnmEIkUVsmDdpUNyqKV1YREuT
        i4h85vgQae/Oz2hOipbd7VcrOQUiJGogDIauf6lJDvEBTm0=
X-Google-Smtp-Source: AA0mqf7LcR92cxqWYPsjOyXeEfk+DWYLmX6aavVi7/wkWWex0aMbJRaW7PDJ8WhIgUqw7J233DDg7osc4GCEU+Cq+WU=
X-Received: by 2002:a63:1659:0:b0:477:98cc:3cfe with SMTP id
 25-20020a631659000000b0047798cc3cfemr20169345pgw.508.1669482290899; Sat, 26
 Nov 2022 09:04:50 -0800 (PST)
MIME-Version: 1.0
References: <20221118035656.gonna.698-kees@kernel.org>
In-Reply-To: <20221118035656.gonna.698-kees@kernel.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 26 Nov 2022 18:04:39 +0100
Message-ID: <CA+fCnZfVZLLmipRBBMn1ju=U6wZL+zqf7S2jpUURPJmH3vPLNw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Make ksize() a reporting-only function
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-mm@kvack.org, kasan-dev@googlegroups.com,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
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

On Fri, Nov 18, 2022 at 4:57 AM Kees Cook <keescook@chromium.org> wrote:
>
> With all "silently resizing" callers of ksize() refactored, remove the
> logic in ksize() that would allow it to be used to effectively change
> the size of an allocation (bypassing __alloc_size hints, etc). Users
> wanting this feature need to either use kmalloc_size_roundup() before an
> allocation, or use krealloc() directly.
>
> For kfree_sensitive(), move the unpoisoning logic inline. Replace the
> some of the partially open-coded ksize() in __do_krealloc with ksize()
> now that it doesn't perform unpoisoning.
>
> Adjust the KUnit tests to match the new ksize() behavior.
>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Pekka Enberg <penberg@kernel.org>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: linux-mm@kvack.org
> Cc: kasan-dev@googlegroups.com
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v2:
> - improve kunit test precision (andreyknvl)
> - add Ack (vbabka)
> v1: https://lore.kernel.org/all/20221022180455.never.023-kees@kernel.org
> ---
>  mm/kasan/kasan_test.c | 14 +++++++++-----
>  mm/slab_common.c      | 26 ++++++++++----------------
>  2 files changed, 19 insertions(+), 21 deletions(-)
>
> diff --git a/mm/kasan/kasan_test.c b/mm/kasan/kasan_test.c
> index 7502f03c807c..fc4b22916587 100644
> --- a/mm/kasan/kasan_test.c
> +++ b/mm/kasan/kasan_test.c
> @@ -821,7 +821,7 @@ static void kasan_global_oob_left(struct kunit *test)
>         KUNIT_EXPECT_KASAN_FAIL(test, *(volatile char *)p);
>  }
>
> -/* Check that ksize() makes the whole object accessible. */
> +/* Check that ksize() does NOT unpoison whole object. */
>  static void ksize_unpoisons_memory(struct kunit *test)
>  {
>         char *ptr;
> @@ -829,15 +829,19 @@ static void ksize_unpoisons_memory(struct kunit *test)
>
>         ptr = kmalloc(size, GFP_KERNEL);
>         KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ptr);
> +
>         real_size = ksize(ptr);
> +       KUNIT_EXPECT_GT(test, real_size, size);
>
>         OPTIMIZER_HIDE_VAR(ptr);
>
> -       /* This access shouldn't trigger a KASAN report. */
> -       ptr[size] = 'x';
> +       /* These accesses shouldn't trigger a KASAN report. */
> +       ptr[0] = 'x';
> +       ptr[size - 1] = 'x';
>
> -       /* This one must. */
> -       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size]);
> +       /* These must trigger a KASAN report. */
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[size]);
> +       KUNIT_EXPECT_KASAN_FAIL(test, ((volatile char *)ptr)[real_size - 1]);

Hi Kees,

I just realized there's an issue here with the tag-based modes, as
they align the unpoisoned area to 16 bytes.

One solution would be to change the allocation size to 128 -
KASAN_GRANULE_SIZE - 5, the same way kmalloc_oob_right test does it,
so that the last 16-byte granule won't get unpoisoned for the
tag-based modes. And then check that the ptr[size] access fails only
for the Generic mode.

Thanks!

>
>         kfree(ptr);
>  }
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index 8276022f0da4..27caa57af070 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1335,11 +1335,11 @@ __do_krealloc(const void *p, size_t new_size, gfp_t flags)
>         void *ret;
>         size_t ks;
>
> -       /* Don't use instrumented ksize to allow precise KASAN poisoning. */
> +       /* Check for double-free before calling ksize. */
>         if (likely(!ZERO_OR_NULL_PTR(p))) {
>                 if (!kasan_check_byte(p))
>                         return NULL;
> -               ks = kfence_ksize(p) ?: __ksize(p);
> +               ks = ksize(p);
>         } else
>                 ks = 0;
>
> @@ -1407,21 +1407,21 @@ void kfree_sensitive(const void *p)
>         void *mem = (void *)p;
>
>         ks = ksize(mem);
> -       if (ks)
> +       if (ks) {
> +               kasan_unpoison_range(mem, ks);
>                 memzero_explicit(mem, ks);
> +       }
>         kfree(mem);
>  }
>  EXPORT_SYMBOL(kfree_sensitive);
>
>  size_t ksize(const void *objp)
>  {
> -       size_t size;
> -
>         /*
> -        * We need to first check that the pointer to the object is valid, and
> -        * only then unpoison the memory. The report printed from ksize() is
> -        * more useful, then when it's printed later when the behaviour could
> -        * be undefined due to a potential use-after-free or double-free.
> +        * We need to first check that the pointer to the object is valid.
> +        * The KASAN report printed from ksize() is more useful, then when
> +        * it's printed later when the behaviour could be undefined due to
> +        * a potential use-after-free or double-free.
>          *
>          * We use kasan_check_byte(), which is supported for the hardware
>          * tag-based KASAN mode, unlike kasan_check_read/write().
> @@ -1435,13 +1435,7 @@ size_t ksize(const void *objp)
>         if (unlikely(ZERO_OR_NULL_PTR(objp)) || !kasan_check_byte(objp))
>                 return 0;
>
> -       size = kfence_ksize(objp) ?: __ksize(objp);
> -       /*
> -        * We assume that ksize callers could use whole allocated area,
> -        * so we need to unpoison this area.
> -        */
> -       kasan_unpoison_range(objp, size);
> -       return size;
> +       return kfence_ksize(objp) ?: __ksize(objp);
>  }
>  EXPORT_SYMBOL(ksize);
>
> --
> 2.34.1
>
