Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A347610154
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 21:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiJ0TPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiJ0TPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 15:15:25 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661B429825;
        Thu, 27 Oct 2022 12:15:22 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-13b23e29e36so3466808fac.8;
        Thu, 27 Oct 2022 12:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xmd8GXOVfbZSYxYq01AYUaxIegxLuQZMi2sQ8kS4z4o=;
        b=gSR6DQKBGvM3MOEzxUB5IKHBXxbtatGQxu1vnR+b5iXeLOGMg8DqWHvRy4izXyFPh/
         a2SHVkWyPaIGLJ8WcCglUU4x8iJXahoEFb59xIpfLy379bF//G4oWRnhrEDYlMXwKE/p
         NFjnqQOtnieWFUffLphIzwQgTDUFVi1iG9WzXvM+utoFgsGyS2/F6nhC8sMSqSDDW8Ed
         VcRN7Cu52XgjdRVeejlN2HsvX4VKashJZ5T42CfJFa1iHQJfEItE+bpjzRPrei2ms4xM
         hPRR2SIwSoc8+9IyLsMaddg6z4jobWqmsvdi9aJdVnP0YhnYbLHE4dIiHJeGMz4QWtOE
         NJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xmd8GXOVfbZSYxYq01AYUaxIegxLuQZMi2sQ8kS4z4o=;
        b=LFxNnjnNengDDSw9V0FGRhgwVRUKGUMy5EcVnVzrZrnUkKx2Cx8QYBqClzpLpGxl7f
         Dv9JE+B50vMRBuWM1ShkNMRmAYk6z0HsdREZ6sgsd4RQ26Tdgrc3cC9IyfoAiEcKVUdJ
         LLDmxYbB2FOFE70YUi3SOC96p2IHOUDxr5Y3Ijk/z15WiizWxIpOZynrqpiAVtPB4I2p
         GFG+7o6fkXVuBi/wSmjuDJzMdxfk9BswjQqxkhxXEoW4I5KtkjAlX7SFy30drZKZWbmv
         hWgz5KBY66yrhyugH1qpy/p9wg6nA1QeS2D+E0pfwFbTnr7/VWb+mSWS6VyDhCxeYNoX
         DWXA==
X-Gm-Message-State: ACrzQf17NQSeVksgxeFOJ5Kn7SL0FHNt1P+E2O0W5Lj3C/ADqQjQYv0P
        MVdwWoVL2DArSMTEG6DKwOiSDWSdPn7iO50VQps=
X-Google-Smtp-Source: AMsMyM4RnfjvpX2tSNs+QgqkzdKThEoIXWJYBuHJxHz2Llt16pfpt10u7Iy/8q7BZokoQKu0tRLxHlqnopAcbh2mDFg=
X-Received: by 2002:a05:6870:c182:b0:12a:e54e:c6e8 with SMTP id
 h2-20020a056870c18200b0012ae54ec6e8mr6421188oad.207.1666898121794; Thu, 27
 Oct 2022 12:15:21 -0700 (PDT)
MIME-Version: 1.0
References: <20221025233421.you.825-kees@kernel.org>
In-Reply-To: <20221025233421.you.825-kees@kernel.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 27 Oct 2022 21:15:10 +0200
Message-ID: <CA+fCnZe+GifXYxUCCuo7GHGssyPcT4tK7obpsCF5e8YU3v03Zg@mail.gmail.com>
Subject: Re: [PATCH v3] mempool: Do not use ksize() for poisoning
To:     Kees Cook <keescook@chromium.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Marco Elver <elver@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
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

On Wed, Oct 26, 2022 at 1:36 AM Kees Cook <keescook@chromium.org> wrote:
>
> Nothing appears to be using ksize() within the kmalloc-backed mempools
> except the mempool poisoning logic. Use the actual pool size instead
> of the ksize() to avoid needing any special handling of the memory as
> needed by KASAN, UBSAN_BOUNDS, nor FORTIFY_SOURCE.
>
> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> Link: https://lore.kernel.org/lkml/f4fc52c4-7c18-1d76-0c7a-4058ea2486b9@suse.cz/
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Marco Elver <elver@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> v3: remove ksize() calls instead of adding kmalloc_roundup_size() calls (vbabka)
> v2: https://lore.kernel.org/lkml/20221018090323.never.897-kees@kernel.org/
> v1: https://lore.kernel.org/lkml/20220923202822.2667581-14-keescook@chromium.org/
> ---
>  mm/mempool.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 96488b13a1ef..54204065037d 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -58,7 +58,7 @@ static void check_element(mempool_t *pool, void *element)
>  {
>         /* Mempools backed by slab allocator */
>         if (pool->free == mempool_free_slab || pool->free == mempool_kfree) {
> -               __check_element(pool, element, ksize(element));
> +               __check_element(pool, element, (size_t)pool->pool_data);
>         } else if (pool->free == mempool_free_pages) {
>                 /* Mempools backed by page allocator */
>                 int order = (int)(long)pool->pool_data;
> @@ -81,7 +81,7 @@ static void poison_element(mempool_t *pool, void *element)
>  {
>         /* Mempools backed by slab allocator */
>         if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc) {
> -               __poison_element(element, ksize(element));
> +               __poison_element(element, (size_t)pool->pool_data);
>         } else if (pool->alloc == mempool_alloc_pages) {
>                 /* Mempools backed by page allocator */
>                 int order = (int)(long)pool->pool_data;
> @@ -112,7 +112,7 @@ static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  static void kasan_unpoison_element(mempool_t *pool, void *element)
>  {
>         if (pool->alloc == mempool_alloc_slab || pool->alloc == mempool_kmalloc)
> -               kasan_unpoison_range(element, __ksize(element));
> +               kasan_unpoison_range(element, (size_t)pool->pool_data);
>         else if (pool->alloc == mempool_alloc_pages)
>                 kasan_unpoison_pages(element, (unsigned long)pool->pool_data,
>                                      false);
> --
> 2.34.1
>

For the KASAN change:

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
