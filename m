Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16AA063BCFC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbiK2Jcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbiK2Jce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:32:34 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD49207
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:32:32 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id j196so16711280ybj.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AYIdy/RYAfzcFTrw7/WTVi/Lx6QQB74ydKBftJOdtrA=;
        b=qvQ+QtukWl6Kk9VSamQNhFmiHSyCPTA+puKBPu7ffKeh19HI2jkHkmylfZpF6uFeXG
         0SzK8R3C3Dnbv2XlVD0Uh07Nf6yXb+fDzrVt92TuLk2eFFuaB+vZoo1HZx/QZWMLFvqd
         UZeXoJNU3007Mv3R4nApk5suKrpXnWlMSqaTGGfKlm1eH45/nYxDNFr7SCWIolXLRsel
         NgKa553g6LuyVmowhY0lauSJFy1UpIPVs74JmZ4UVChAgLdKetaC2KzYr/T4EpAAv0s3
         Fd4o8bcvyxmyTM0L6Dv2989Nioyv0tgzMegbOBdZsFWyFPytibIypqgs7oxNiJZ7RGFP
         zPcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYIdy/RYAfzcFTrw7/WTVi/Lx6QQB74ydKBftJOdtrA=;
        b=4VrVTRqp0bHmIjKiqoVhUrqU0/8bCnKXjZbrLGDSLjgt7kVpObWGsaGDSgp0gBcJrv
         96oSkTICXdu+Ez7COmLvTINlddGEmx9Xr1nQqrSddNZT3nQjptxyT4tc98/qG4MLwIiD
         BkW70OYEeLhRnDKiv6oR9A6yJIra90NM1CFYE7aVOBNYhRv1EaBU0FLJBkTZ/Io+NaYF
         2oIUhagGJKmvOwOY3eQnNz7unxJxtZ61oOeHEhxVBWUq3GofYLdoW5i9FbQ13+9TQ4ny
         zCkdjHLpKtbNOJgGsImp4DfN4s1DvnshDbIJ9gHqwaUagMgnkMJoCMXNSPRpmeMVN+oq
         pUFw==
X-Gm-Message-State: ANoB5pl24Ed9fGqlAuw2c0RJNHz3uxOhW6UuBtL2Z/1uhze54sVazG9h
        M+0e8U4GxUHR8c3caNtSEFT8UESKr9rKWnZTD01Mtg==
X-Google-Smtp-Source: AA0mqf7joEDlOeJDMEl6F1uWJdSxRY7OaY4zhHB63BnOBVQjtU7i9SZUm1WZFTvc18BEq0Y2DNzc1kF2EvlYSdzIETE=
X-Received: by 2002:a25:3851:0:b0:6f0:6175:2cc7 with SMTP id
 f78-20020a253851000000b006f061752cc7mr27731021yba.93.1669714351353; Tue, 29
 Nov 2022 01:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20221129063358.3012362-1-feng.tang@intel.com> <20221129063358.3012362-2-feng.tang@intel.com>
In-Reply-To: <20221129063358.3012362-2-feng.tang@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 29 Nov 2022 10:31:55 +0100
Message-ID: <CANpmjNNkLWvNYUf-bPPDBcqFWegp3_NpYdhygvYU1dtT52m29g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm/slub, kunit: Add a test case for kmalloc
 redzone check
To:     Feng Tang <feng.tang@intel.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oliver Glitta <glittao@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Tue, 29 Nov 2022 at 07:37, Feng Tang <feng.tang@intel.com> wrote:
>
> kmalloc redzone check for slub has been merged, and it's better to add
> a kunit case for it, which is inspired by a real-world case as described
> in commit 120ee599b5bf ("staging: octeon-usb: prevent memory corruption"):
>
> "
>   octeon-hcd will crash the kernel when SLOB is used. This usually happens
>   after the 18-byte control transfer when a device descriptor is read.
>   The DMA engine is always transferring full 32-bit words and if the
>   transfer is shorter, some random garbage appears after the buffer.
>   The problem is not visible with SLUB since it rounds up the allocations
>   to word boundary, and the extra bytes will go undetected.
> "
>
> To avoid interrupting the normal functioning of kmalloc caches, a
> kmem_cache mimicing kmalloc cache is created with similar and all
> necessary flags to have kmalloc-redzone enabled, and kmalloc_trace()
> is used to really test the orig_size and redzone setup.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> ---
> Changelog:
>
>   since v1:
>   * create a new cache mimicing kmalloc cache, reduce dependency
>     over global slub_debug setting (Vlastimil Babka)
>
>  lib/slub_kunit.c | 23 +++++++++++++++++++++++
>  mm/slab.h        |  3 ++-
>  2 files changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index a303adf8f11c..dbdd656624d0 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -122,6 +122,28 @@ static void test_clobber_redzone_free(struct kunit *test)
>         kmem_cache_destroy(s);
>  }
>
> +static void test_kmalloc_redzone_access(struct kunit *test)
> +{
> +       struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_kmalloc", 32, 0,
> +                               SLAB_KMALLOC|SLAB_STORE_USER|SLAB_RED_ZONE|DEFAULT_FLAGS,
> +                               NULL);
> +       u8 *p = kmalloc_trace(s, GFP_KERNEL, 18);
> +
> +       kasan_disable_current();
> +
> +       /* Suppress the -Warray-bounds warning */
> +       OPTIMIZER_HIDE_VAR(p);
> +       p[18] = 0xab;
> +       p[19] = 0xab;
> +
> +       kmem_cache_free(s, p);
> +       validate_slab_cache(s);
> +       KUNIT_EXPECT_EQ(test, 2, slab_errors);
> +
> +       kasan_enable_current();
> +       kmem_cache_destroy(s);
> +}
> +
>  static int test_init(struct kunit *test)
>  {
>         slab_errors = 0;
> @@ -141,6 +163,7 @@ static struct kunit_case test_cases[] = {
>  #endif
>
>         KUNIT_CASE(test_clobber_redzone_free),
> +       KUNIT_CASE(test_kmalloc_redzone_access),
>         {}
>  };
>
> diff --git a/mm/slab.h b/mm/slab.h
> index c71590f3a22b..b6cd98b16ba7 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -327,7 +327,8 @@ static inline slab_flags_t kmem_cache_flags(unsigned int object_size,
>  /* Legal flag mask for kmem_cache_create(), for various configurations */
>  #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
>                          SLAB_CACHE_DMA32 | SLAB_PANIC | \
> -                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS )
> +                        SLAB_KMALLOC | SLAB_SKIP_KFENCE | \
> +                        SLAB_TYPESAFE_BY_RCU | SLAB_DEBUG_OBJECTS)

Shouldn't this hunk be in the previous patch, otherwise that patch
alone will fail?

This will also make SLAB_SKIP_KFENCE generally available to be used
for cache creation. This is a significant change, and before it wasn't
possible. Perhaps add a brief note to the commit message (or have a
separate patch). We were trying to avoid making this possible, as it
might be abused - however, given it's required for tests like these, I
suppose there's no way around it.

Thanks,
-- Marco
