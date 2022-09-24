Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CE65E8F21
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 20:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbiIXSFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 14:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiIXSFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 14:05:19 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CE225594
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:05:16 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id a20so1878590qtw.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 11:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cWXihzkts7fGQmkZ/lCAYDuSh40IJwfY6ZWwrmbTVGU=;
        b=TBDentZR5hlvdOO1MrCH3a3HoJKEOOi+SNv74AjgzM+YgLM7hrn2UFvEo9NJXP7sRA
         zlao1ay2DLAIlcQC/OC5bafSmNYyOo2JfT+Nn0Uedh8+feSJYg2AsU8QFQ0ZNR6rAXRH
         bao/I4+rzmerDSEif05d2jOlo3rOnt5NqWz9ox1LSwydrkSUMCZllpLykwMP1a3PY/CS
         IBksJOE54HZkqC4ryIXnKTEn/S5RNX+9Q6UOS4EvQddJn3GWBhxghp8NjEqQX3hO3TMI
         aSAOPJ7XO1x6VLFtDnhMLHouv3jEs7iKGFejX39SeGkPr04VdifFFScHvU3ufFiCPDzt
         qzqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cWXihzkts7fGQmkZ/lCAYDuSh40IJwfY6ZWwrmbTVGU=;
        b=unKD6rcbyWiMENBWs79vXJ2Z9lsSR0gCNClrq3/Z9u8U83WQ0Ydg6VH73TkqOBORD5
         z7MUspVYgxVq/tFN/h6xogaMESypOVag4WDbDnFl/nIn/xGdq1bYamoQuyvUSXd/ruva
         h9fHDM8CBWdsGSonfymXTLn7HD/ROb/BmUZI9QxFazIuL3FgykYQzODHTQjWOzcYlE1N
         xyUNgqq5W4SaVeMkJXAkDOfdMkhxIB/aHhpBi6oqBPBzKwAa97YnfN+Q4ZiQaCfHYfAW
         NAkZDg/Am9r6oVRZBIMGbB5r59cFsMSuW7uO669kGHT8YMp2cTtuBhWYmIBteDCAa1Af
         GbXA==
X-Gm-Message-State: ACrzQf00hvtC9zSpgJuRrkm0PBXYXCLD/i5yynRQqkACWo59/39cPPN5
        BwciugLI8SmUQ90kSGV0pnaJ8J6jmAPJuHc+usJblV+16ZQ=
X-Google-Smtp-Source: AMsMyM5k3hqUDD4Gox/vAgw2jUuAhGC+5vAF1+n1KNUIyak5S/zpuUgX2ZwFbDXeq/Dbm5Bjqo9pEtogDbaIgsx6iOA=
X-Received: by 2002:a05:622a:180d:b0:35b:d283:7e65 with SMTP id
 t13-20020a05622a180d00b0035bd2837e65mr12033167qtc.106.1664042715583; Sat, 24
 Sep 2022 11:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220913065423.520159-1-feng.tang@intel.com> <20220913065423.520159-4-feng.tang@intel.com>
 <CA+fCnZdFi471MxQG9RduQcBZWR10GCqxyNkuaDXzX6y4zCaYAQ@mail.gmail.com> <Yyr9ZZnVPgr4GHYQ@feng-clx>
In-Reply-To: <Yyr9ZZnVPgr4GHYQ@feng-clx>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 24 Sep 2022 20:05:04 +0200
Message-ID: <CA+fCnZdUF3YiNpy10=xOJmPVbftaJr76wB5E58v0W_946Uketw@mail.gmail.com>
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "Sang, Oliver" <oliver.sang@intel.com>
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

On Wed, Sep 21, 2022 at 2:03 PM Feng Tang <feng.tang@intel.com> wrote:
>
> Agree, it's better not touch the internal fields in slub code.
>
> How about the following patch, it merge the 2 functions with one flag
> indicating in meta data or object. (I'm fine with 2 separate functions)

The overall approach sounds good. See some comments below.

> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index b092277bf48d..0ad05a34e708 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -150,11 +150,12 @@ static __always_inline void kasan_cache_create_kmalloc(struct kmem_cache *cache)
>                 __kasan_cache_create_kmalloc(cache);
>  }
>
> -size_t __kasan_metadata_size(struct kmem_cache *cache);
> -static __always_inline size_t kasan_metadata_size(struct kmem_cache *cache)
> +size_t __kasan_meta_size(struct kmem_cache *cache, bool in_slab_object);
> +static __always_inline size_t kasan_meta_size(struct kmem_cache *cache,
> +                                                       bool in_slab_object)

I would keep the name as kasan_metadata_size as it's more clear to
external users but rename in_slab_object to in_object to make the
declaration shorter.

>  {
>         if (kasan_enabled())
> -               return __kasan_metadata_size(cache);
> +               return  __kasan_meta_size(cache, in_slab_object);
>         return 0;
>  }
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 69f583855c8b..2a8710461ebb 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -218,14 +218,21 @@ void __kasan_cache_create_kmalloc(struct kmem_cache *cache)
>         cache->kasan_info.is_kmalloc = true;
>  }
>
> -size_t __kasan_metadata_size(struct kmem_cache *cache)
> +size_t __kasan_meta_size(struct kmem_cache *cache, bool in_slab_object)
>  {
>         if (!kasan_stack_collection_enabled())
>                 return 0;
> -       return (cache->kasan_info.alloc_meta_offset ?
> -               sizeof(struct kasan_alloc_meta) : 0) +
> -               (cache->kasan_info.free_meta_offset ?
> -               sizeof(struct kasan_free_meta) : 0);
> +
> +       if (in_slab_object)
> +               return (cache->kasan_info.alloc_meta_offset == 0 ?
> +                       sizeof(struct kasan_alloc_meta) : 0) +
> +                       (cache->kasan_info.free_meta_offset ?
> +                       sizeof(struct kasan_free_meta) : 0);
> +       else
> +               return (cache->kasan_info.alloc_meta_offset == 0 ?
> +                       sizeof(struct kasan_alloc_meta) : 0) +
> +                       (cache->kasan_info.free_meta_offset ?
> +                       sizeof(struct kasan_free_meta) : 0);

Something weird here: both if and else cases are the same.

The change also needs to be rebased onto [1].

Thanks!

[1] https://lore.kernel.org/linux-mm/c7b316d30d90e5947eb8280f4dc78856a49298cf.1662411799.git.andreyknvl@google.com/
