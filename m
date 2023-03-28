Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA68D6CBE37
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbjC1L40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232902AbjC1L4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:56:17 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1200586AA
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:56:16 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id k17so14609826ybm.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680004575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nc5W1lE9EjIhY3BF/8rAhRpdJPCQCh8hr/U0i6aHjsc=;
        b=hoLgsOkZ2x2vUsVYvB5E+SmxoYqNebP0ycxMynfyPa6K7RVfCwIH7l21ZbSc0/ESLu
         mY9snWPalWGPggsJ3pd7YwOuIDkDupgeBzOXX0WANs8Kp1rRK5FB//hyL2uAehTGM5To
         DspGUnxugzBT/BUr7IvG1rva6aQ3BGSKy/Medpctq8CC434cWDCNnJtm+d2uEVmPFmlv
         NtYmK9+np/DOgURzp9tj0W+BdfZEwjgX4kAj2eAPR6GOKRycla+g8eeV/Y998rSrwyu4
         DEL9Pf1/7lGBYxUWwEsz6Wd4wYS2TjUgqolw1pkX/1GqLzCB34tTLQlJqZfE7WWYvgJ/
         2Xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680004575;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nc5W1lE9EjIhY3BF/8rAhRpdJPCQCh8hr/U0i6aHjsc=;
        b=BfH7T3eozFRnUP9muAgFeEm1XfCTffoGoabAzm3Gpgj9lZkkU/zRrsmqfmi6RnDi06
         izvbH3MAnPo8VQ5n/o6/sExibf29gXyQT7zicYWDsGEh6NndEjXgTt2qLM/rhbnBPf+O
         pSNUnq8TJXkVl+NwQ1qvYOwfuHy2bzciVWk+0Z+miUNTU6NvVwnltqMOFRQdMlrUFMov
         pomhpJxPdB1KKh6sUvUL/oZk+CE//T4oTyQJFQv4o58qMKgVgb+18CsTf/PeaKESM3pa
         BtpmFjkT6oakQ2YSpJHStAZbV199zuchf4UoHq1sOa9y+hZDmEV7zPDP6Vz/oQ+uiuYz
         cyHQ==
X-Gm-Message-State: AAQBX9d/iZ/SBE5yckzeNrXJF0DoPfF55j+URhAs7+XfkYuClqBtkcHL
        EPawBYvyHS+3UjLkLQYjT0aCJV6jSKYDnzOZJsfDlg==
X-Google-Smtp-Source: AKy350YP6oV53+191HmhMOuB0nH+1b8IUYvwyKlcGo3d6EZ2MKveajdpBVN3VzunfqGw/L3jRxjgEIF2nHHslh/iN3Y=
X-Received: by 2002:a25:ab81:0:b0:b65:89bd:3c85 with SMTP id
 v1-20020a25ab81000000b00b6589bd3c85mr15082098ybi.4.1680004575191; Tue, 28 Mar
 2023 04:56:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230328095807.7014-1-songmuchun@bytedance.com> <20230328095807.7014-7-songmuchun@bytedance.com>
In-Reply-To: <20230328095807.7014-7-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Tue, 28 Mar 2023 13:55:38 +0200
Message-ID: <CANpmjNPeQBcV7qnpXJOoLYjonsjPnOW-cerYm=_U3ptNZrXu0Q@mail.gmail.com>
Subject: Re: [PATCH 6/6] mm: kfence: replace ALIGN_DOWN(x, PAGE_SIZE) with PAGE_ALIGN_DOWN(x)
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

On Tue, 28 Mar 2023 at 11:59, 'Muchun Song' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> Replace ALIGN_DOWN(x, PAGE_SIZE) with PAGE_ALIGN_DOWN(x) to simplify
> the code a bit.
>
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index f205b860f460..dbfb79a4d624 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -230,17 +230,17 @@ static bool alloc_covered_contains(u32 alloc_stack_hash)
>
>  static inline void kfence_protect(unsigned long addr)
>  {
> -       kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), true);
> +       kfence_protect_page(PAGE_ALIGN_DOWN(addr), true);
>  }
>
>  static inline void kfence_unprotect(unsigned long addr)
>  {
> -       kfence_protect_page(ALIGN_DOWN(addr, PAGE_SIZE), false);
> +       kfence_protect_page(PAGE_ALIGN_DOWN(addr), false);
>  }
>
>  static inline unsigned long metadata_to_pageaddr(const struct kfence_metadata *meta)
>  {
> -       return ALIGN_DOWN(meta->addr, PAGE_SIZE);
> +       return PAGE_ALIGN_DOWN(meta->addr);
>  }
>
>  /*
> @@ -308,7 +308,7 @@ static inline bool check_canary_byte(u8 *addr)
>  /* __always_inline this to ensure we won't do an indirect call to fn. */
>  static __always_inline void for_each_canary(const struct kfence_metadata *meta, bool (*fn)(u8 *))
>  {
> -       const unsigned long pageaddr = ALIGN_DOWN(meta->addr, PAGE_SIZE);
> +       const unsigned long pageaddr = PAGE_ALIGN_DOWN(meta->addr);
>         unsigned long addr;
>
>         /*
> @@ -455,7 +455,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
>         }
>
>         /* Detect racy use-after-free, or incorrect reallocation of this page by KFENCE. */
> -       kcsan_begin_scoped_access((void *)ALIGN_DOWN((unsigned long)addr, PAGE_SIZE), PAGE_SIZE,
> +       kcsan_begin_scoped_access((void *)PAGE_ALIGN_DOWN((unsigned long)addr), PAGE_SIZE,
>                                   KCSAN_ACCESS_SCOPED | KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT,
>                                   &assert_page_exclusive);
>
> @@ -464,7 +464,7 @@ static void kfence_guarded_free(void *addr, struct kfence_metadata *meta, bool z
>
>         /* Restore page protection if there was an OOB access. */
>         if (meta->unprotected_page) {
> -               memzero_explicit((void *)ALIGN_DOWN(meta->unprotected_page, PAGE_SIZE), PAGE_SIZE);
> +               memzero_explicit((void *)PAGE_ALIGN_DOWN(meta->unprotected_page), PAGE_SIZE);
>                 kfence_protect(meta->unprotected_page);
>                 meta->unprotected_page = 0;
>         }
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230328095807.7014-7-songmuchun%40bytedance.com.
