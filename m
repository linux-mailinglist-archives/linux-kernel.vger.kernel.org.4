Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B0163D164
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 10:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiK3JH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 04:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiK3JHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 04:07:23 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B811D48431
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:07:22 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id d128so20712684ybf.10
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 01:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJSr80xd14hM4bQ3tRuzX8E5Pgbji3RMWt3595HPw/M=;
        b=ZSOHFZhP0BNRp1bYpzYsOZCbn7yjIhSPeKFz/exhlVafB40IHkpKTZUxSoCunbKD5G
         jwPVJJMER2gJU0ZpoPKPmU2xMpunpkEbi0jcUonyQWFQAb0lgQYMgy9wfFWCvIk9dO8+
         XD6Gq4efZBd2IOKSmiXVt1CvJBhe91Sym3iVjHGTeZ4JmTKtH/Hcp3pIwTwu3OoNtiRI
         r4yUcM53ork5jlYSTREDUBm44J7OOe+XeT0jdgRlG+hTAJplcgouYCPUmhh+u0qNVxH4
         JIWn4aMFOjXduCjlm/SiN30OLwgLE/bSpnZTij5BRH8veCmtK58DEcpg4o/qgyNckbEm
         x1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJSr80xd14hM4bQ3tRuzX8E5Pgbji3RMWt3595HPw/M=;
        b=DPR4apHW0g9M+v+OjtAWe1yroIFMbCcorLyeknoZTHNR31Q9sSZ2iw9vQRJUKjwmTx
         /uyL9u/jvqg5FfRHB+dqCk54TF5CBGFzHsFZLm6H37hzlpbg/hA43frs62xxPIf2AChP
         rshkI+Ko3O0PskzIBKXVITm1uCvMBg/mbyrmuN8DsIMe5hleBuuub+Nyf+2rO9/TH4AR
         l8pxKf2nRRsKYXLQL+Q4rJW5tc/qkcAWN9nMT/dxLnpNCNaTbBROjdNNYBsGRllC/Tnh
         oU1iLx3AFlnWlIkVx4TMO5/kxsk9FOEWSI8875Yr0TcDDinZ++0PDROpt/ZoK3czt+EX
         WLrA==
X-Gm-Message-State: ANoB5pkml38E3W9ULxvq05XCPQPnpwscck9njrYmGx+xRDBbgaSkMMdg
        +v6xmFx8ru0qp6OJc3t+TQvYLfzGnt5ecpyIOfz2LQ==
X-Google-Smtp-Source: AA0mqf4u7IvscwvjWc6mp50qyMHqXDemV28o+bInv4IsCPPw0ZzMuci0LUCfr6h2SM1KaNPafp3I7FviAPMR5nEmlz4=
X-Received: by 2002:a25:918a:0:b0:6f7:9c34:67a7 with SMTP id
 w10-20020a25918a000000b006f79c3467a7mr10896480ybl.16.1669799241764; Wed, 30
 Nov 2022 01:07:21 -0800 (PST)
MIME-Version: 1.0
References: <20221130085451.3390992-1-feng.tang@intel.com>
In-Reply-To: <20221130085451.3390992-1-feng.tang@intel.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 30 Nov 2022 10:06:45 +0100
Message-ID: <CANpmjNM_sKe0D64y+hsX0gYa8d9aCRVMBZjCvgjKcHPeYsjjBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] mm/slub, kunit: add SLAB_SKIP_KFENCE flag for
 cache creation
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

On Wed, 30 Nov 2022 at 09:57, Feng Tang <feng.tang@intel.com> wrote:
>
> When kfence is enabled, the buffer allocated from the test case
> could be from a kfence pool, and the operation could be also
> caught and reported by kfence first, causing the case to fail.
>
> With default kfence setting, this is very difficult to be triggered.
> By changing CONFIG_KFENCE_NUM_OBJECTS from 255 to 16383, and
> CONFIG_KFENCE_SAMPLE_INTERVAL from 100 to 5, the allocation from
> kfence did hit 7 times in different slub_kunit cases out of 900
> times of boot test.
>
> To avoid this, initially we tried is_kfence_address() to check this
> and repeated allocation till finding a non-kfence address. Vlastimil
> Babka suggested SLAB_SKIP_KFENCE flag could be used to achieve this,
> and better add a wrapper function for simplifying cache creation.
>
> Signed-off-by: Feng Tang <feng.tang@intel.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
> Changelog:
>
>   since v2:
>     * Don't make SKIP_KFENCE an allowd flag for cache creation, and
>       solve a bug of failed cache creation issue (Marco Elver)
>     * Add a wrapper cache creation function to simplify code
>      including SKIP_KFENCE handling (Vlastimil Babka)
>
>  lib/slub_kunit.c | 35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
>
> diff --git a/lib/slub_kunit.c b/lib/slub_kunit.c
> index 7a0564d7cb7a..5b0c8e7eb6dc 100644
> --- a/lib/slub_kunit.c
> +++ b/lib/slub_kunit.c
> @@ -9,10 +9,25 @@
>  static struct kunit_resource resource;
>  static int slab_errors;
>
> +/*
> + * Wrapper function for kmem_cache_create(), which reduces 2 parameters:
> + * 'align' and 'ctor', and sets SLAB_SKIP_KFENCE flag to avoid getting an
> + * object from kfence pool, where the operation could be caught by both
> + * our test and kfence sanity check.
> + */
> +static struct kmem_cache *test_kmem_cache_create(const char *name,
> +                               unsigned int size, slab_flags_t flags)
> +{
> +       struct kmem_cache *s = kmem_cache_create(name, size, 0,
> +                                       (flags | SLAB_NO_USER_FLAGS), NULL);
> +       s->flags |= SLAB_SKIP_KFENCE;
> +       return s;
> +}
> +
>  static void test_clobber_zone(struct kunit *test)
>  {
> -       struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_alloc", 64, 0,
> -                               SLAB_RED_ZONE|SLAB_NO_USER_FLAGS, NULL);
> +       struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_alloc", 64,
> +                                                       SLAB_RED_ZONE);
>         u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>
>         kasan_disable_current();
> @@ -29,8 +44,8 @@ static void test_clobber_zone(struct kunit *test)
>  #ifndef CONFIG_KASAN
>  static void test_next_pointer(struct kunit *test)
>  {
> -       struct kmem_cache *s = kmem_cache_create("TestSlub_next_ptr_free", 64, 0,
> -                               SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
> +       struct kmem_cache *s = test_kmem_cache_create("TestSlub_next_ptr_free",
> +                                                       64, SLAB_POISON);
>         u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>         unsigned long tmp;
>         unsigned long *ptr_addr;
> @@ -74,8 +89,8 @@ static void test_next_pointer(struct kunit *test)
>
>  static void test_first_word(struct kunit *test)
>  {
> -       struct kmem_cache *s = kmem_cache_create("TestSlub_1th_word_free", 64, 0,
> -                               SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
> +       struct kmem_cache *s = test_kmem_cache_create("TestSlub_1th_word_free",
> +                                                       64, SLAB_POISON);
>         u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>
>         kmem_cache_free(s, p);
> @@ -89,8 +104,8 @@ static void test_first_word(struct kunit *test)
>
>  static void test_clobber_50th_byte(struct kunit *test)
>  {
> -       struct kmem_cache *s = kmem_cache_create("TestSlub_50th_word_free", 64, 0,
> -                               SLAB_POISON|SLAB_NO_USER_FLAGS, NULL);
> +       struct kmem_cache *s = test_kmem_cache_create("TestSlub_50th_word_free",
> +                                                       64, SLAB_POISON);
>         u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>
>         kmem_cache_free(s, p);
> @@ -105,8 +120,8 @@ static void test_clobber_50th_byte(struct kunit *test)
>
>  static void test_clobber_redzone_free(struct kunit *test)
>  {
> -       struct kmem_cache *s = kmem_cache_create("TestSlub_RZ_free", 64, 0,
> -                               SLAB_RED_ZONE|SLAB_NO_USER_FLAGS, NULL);
> +       struct kmem_cache *s = test_kmem_cache_create("TestSlub_RZ_free", 64,
> +                                                       SLAB_RED_ZONE);
>         u8 *p = kmem_cache_alloc(s, GFP_KERNEL);
>
>         kasan_disable_current();
> --
> 2.34.1
>
