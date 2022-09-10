Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1918B5B4ACE
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 01:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbiIJXPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 19:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiIJXPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 19:15:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3279357CA
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:15:06 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h22so3866679qtu.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 16:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=w2iwfAfjmm20Z/nVGluOZ//otBXBhnUx+0kh6uIL9eU=;
        b=iSX3eG5Hl5kGjfusxIiWlcV4NhikAleW1R5zSBUe+WjlKp9VsK2uWUEaUsdt25nY/j
         LHR3Zd9NkjBKs8WBMRFvG33yi35iWNfpnh+G2LNdkL7rXtSqQ0rQt5Z7tD90eka6KC4X
         AwmaOvvuAT4pb7T4tz2Nv2sMbFvq5BZ6WBGUqsRSoCChKNRNK4pbNLT2OSvfisHi62F+
         oVhVvePn8EM1KVY78zjZGBx2q7WtJyRH2Dg9aDp4/nMu7+n9oVk5TzBuRSJini5LlOyJ
         1L+7B7D1q2ye/WXp9+GFF8X2IMWIAFhqLVqHxqM0eaDaCnVpA+NId0CnHm5+tJeEG/dm
         NIvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=w2iwfAfjmm20Z/nVGluOZ//otBXBhnUx+0kh6uIL9eU=;
        b=18n/wRUBuz+EBT4+r6uu0W/4NxRB2xCJi4hSJnbnZRz3eVoXf/MBGcYKqmjNnYCCdo
         YOTNxzWdGaz0XB3Sxirdf6ZvCEm0N+KTEdsH3a/jkocUevSntYwViKRNkuGiLFhYhU/c
         t5nUHPiqD6irZQbXbF0ax6pAf3dVxEXv9QbdtAQYC1ULCBpvEqNkssw+u2phvFr+Rem7
         XacWumfmeVzc6xJ4ybsMcUygzk7R9pvw3KmTYS/O30Wl2gWYLvQ8WL5H2hhNLrA3qAur
         t/dbYr27nBDLtkKA4pG4E0f8m99YXSLtHb8fLwrRJFl11t9TlKSAuxl54t8QBxpF5cO3
         8VNA==
X-Gm-Message-State: ACgBeo06SzVbcdaGNpfPlu/pzyjxNrkn/bU0yV+gh9FvtVavLG4x290Z
        EBJE9UnUVPuEn/RPIk6lvRwwtf+M1e+fuCX501A=
X-Google-Smtp-Source: AA6agR50c6VuB0iUAz7cjL6BCPfhd8Qxt1aoqMkHA4aCvJRxKKiv8jZ8eFphXQLzIzrSnzKHfA9pK8iS+wAUSlW8zzU=
X-Received: by 2002:a05:622a:14d1:b0:344:b14a:b22a with SMTP id
 u17-20020a05622a14d100b00344b14ab22amr17595430qtx.203.1662851706097; Sat, 10
 Sep 2022 16:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220907071023.3838692-1-feng.tang@intel.com> <20220907071023.3838692-4-feng.tang@intel.com>
In-Reply-To: <20220907071023.3838692-4-feng.tang@intel.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sun, 11 Sep 2022 01:14:55 +0200
Message-ID: <CA+fCnZeT_mYndXDYoi0LHCcDkOK4V1TR_omE6CKdbMf6iDwP+w@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] mm: kasan: Add free_meta size info in struct kasan_cache
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 7, 2022 at 9:11 AM Feng Tang <feng.tang@intel.com> wrote:
>
> When kasan is enabled for slab/slub, it may save kasan' free_meta
> data in the former part of slab object data area in slab object
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
> index b092277bf48d..293bdaa0ba09 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -100,6 +100,8 @@ static inline bool kasan_has_integrated_init(void)
>  struct kasan_cache {
>         int alloc_meta_offset;
>         int free_meta_offset;
> +       /* size of free_meta data saved in object's data area */
> +       int free_meta_size_in_object;

I thinks calling this field free_meta_size is clear enough. Thanks!

>         bool is_kmalloc;
>  };
>
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 69f583855c8b..762ae7a7793e 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -201,6 +201,8 @@ void __kasan_cache_create(struct kmem_cache *cache, unsigned int *size,
>                         cache->kasan_info.free_meta_offset = KASAN_NO_FREE_META;
>                         *size = ok_size;
>                 }
> +       } else {
> +               cache->kasan_info.free_meta_size_in_object = sizeof(struct kasan_free_meta);
>         }
>
>         /* Calculate size with optimal redzone. */
> --
> 2.34.1
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20220907071023.3838692-4-feng.tang%40intel.com.
