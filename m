Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC095BED85
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiITTVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiITTVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:21:11 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FF8286E7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:21:10 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id w4so2791271qvp.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 12:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=2fFnFfvF7l44JixGUwp4lrsIFX8DjQoBBv2Lr/mkNP0=;
        b=DaxAZMRn+z6gfdx54XhmmOabl6/upL90LxgL1FK8rbacRTFR0nR/b0jkn9rQuqcNHH
         VC03c8be4EAT+gxtRTYGpq/z445948cfhsxbH5A8EQJEZc/RTUad0n/6cbCtNUcq2JK7
         p6/35WU4J8P+6ntQuZc8Q2UR2Tk27B4azbT1QB1D6b42M2KtFfbYkwOrxqbSRCq0LzsJ
         OFHXCOX1WGRaga6kEXKt/Upm+J1AlLJvwAnEOmfB8NuKUUY9qT6PoL4kl3QRtfJaP+HF
         YMEprrDWix/vV1KLF1B3e/tWYv2KldXwXDMbVeS11Z9d9AjM2TKArxgE/2VhEyufhKbM
         JtWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=2fFnFfvF7l44JixGUwp4lrsIFX8DjQoBBv2Lr/mkNP0=;
        b=ogJ338S4idhssZR2aFfnz9iOwcZrnGPOXDimGdUfmt9ozj6x+6QnO3SSvh3V8qLCtD
         AFerOpiTeOl+ui3DC8rqf2mUzsSxHpnWwx/7F53GHWMYFaJDqmycMriiyFqrqnScTJJO
         DiVhaoIQofezBvZDBMg9nC8WMFYbmeL01RfNBxQkPdpxhXCiuneBeIhqeYrgdYlqAoUO
         XfMSz7kkOugVCBbffUzyCAw+ecejvecmTcPJjFwXE3VlDfhUWaurb2svTRIv8HnZviuC
         dQfoJs758H/jLwAVvDMTjdyJ7yhsz5zP/+zjcuSbqIA2bJTF2IDbLNjEVq9cmAYPFyl8
         K8Eg==
X-Gm-Message-State: ACrzQf1/LfyL4WkroqB/3CEbo/KBx5OTufmICMWqbD4k8wRNPSmgJxx3
        uHVUywAVaLx2oyk6QLS+DrvS6rQc4fO3jJpi/og=
X-Google-Smtp-Source: AMsMyM6nElpG8fYLz4yWt+NdcHYGKiIqfT0ZO7yO5Telew+swSrzQgXJVCjrR9Ry4q2bGmgXHWltSuDRcKorZaXIG5o=
X-Received: by 2002:a05:6214:c48:b0:4ac:b18d:c101 with SMTP id
 r8-20020a0562140c4800b004acb18dc101mr20513445qvj.107.1663701669341; Tue, 20
 Sep 2022 12:21:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220913065423.520159-1-feng.tang@intel.com> <20220913065423.520159-4-feng.tang@intel.com>
In-Reply-To: <20220913065423.520159-4-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Tue, 20 Sep 2022 21:20:58 +0200
Message-ID: <CA+fCnZdFi471MxQG9RduQcBZWR10GCqxyNkuaDXzX6y4zCaYAQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] mm: kasan: Add free_meta size info in struct kasan_cache
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        kernel test robot <oliver.sang@intel.com>
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

On Tue, Sep 13, 2022 at 8:54 AM Feng Tang <feng.tang@intel.com> wrote:
>
> When kasan is enabled for slab/slub, it may save kasan' free_meta
> data in the former part of slab object data area in slab object's
> free path, which works fine.
>
> There is ongoing effort to extend slub's debug function which will
> redzone the latter part of kmalloc object area, and when both of
> the debug are enabled, there is possible conflict, especially when
> the kmalloc object has small size, as caught by 0Day bot [1]
>
> For better information for slab/slub, add free_meta's data size
> into 'struct kasan_cache', so that its users can take right action
> to avoid data conflict.
>
> [1]. https://lore.kernel.org/lkml/YuYm3dWwpZwH58Hu@xsang-OptiPlex-9020/
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Signed-off-by: Feng Tang <feng.tang@intel.com>
> Acked-by: Dmitry Vyukov <dvyukov@google.com>
> ---
>  include/linux/kasan.h | 2 ++
>  mm/kasan/common.c     | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b092277bf48d..49af9513e8ed 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
>  struct kasan_cache {
>         int alloc_meta_offset;
>         int free_meta_offset;
> +       /* size of free_meta data saved in object's data area */
> +       int free_meta_size;
>         bool is_kmalloc;
>  };
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 69f583855c8b..0cb867e92524 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -201,6 +201,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                         cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
>                         *size = ok_size;
>                 }
> +       } else {
> +               cache->kasan_info.free_meta_size = sizeof(struct kasan_free_meta);

Hi Feng,

I just realized that we already have a function that exposes a similar
functionality: kasan_metadata_size. However, this function returns the
size of metadata that is stored in the redzone.

I think, instead of adding free_meta_size, a better approach would be to:

1. Rename kasan_metadata_size to kasan_metadata_size_in_redzone (or
something like that).
2. Add kasan_metadata_size_in_object with appropriate implementation
and use that in your patches.

This allows avoiding exposing KASAN-internal details such as what kind
of fields the kasan_cache struct has to the common code.

Sorry for nor realizing this straight away.

(Note that there's an upcoming patch that fixes a bug in
kasan_metadata_size' implementation [1].)

Thanks!

[1] https://lore.kernel.org/linux-mm/c7b316d30d90e5947eb8280f4dc78856a49298cf.1662411799.git.andreyknvl@google.com/



>         }
>
>         /* Calculate size with optimal redzone. */
> --
> 2.34.1
>
