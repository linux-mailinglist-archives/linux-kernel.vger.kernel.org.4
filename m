Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208CB6C61A1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCWI2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjCWI2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:28:39 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96717E183
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:28:38 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id k17so13112604ybm.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679560118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OOYn20tiv4eFu0Zo7pcx9dFPpDzH/yyBBrbi1uHVeEQ=;
        b=kGBFE0OcsNVnZV308/d8pqLJw67m161QBjI+II3xw8adyZdwxXxS0p7W7LdC135V+v
         gVM+KzidBZmB68wArIHRWYEX4KO1T0uvxbe1nRLABZtcyksaDoWYjyaRd6KPedxAO+Xi
         6w6n2qb6GF0RuuY8foKjmT0j1oNIUJSB3IV/gjuMo4QAMluwtzCB3/mKDOWMg+sCRwmA
         O3cVWR9vgl8Woy5ZOPGry0KPPl57KWo+tcH8gLSugts046ym+Hi1LJdJnCdS06VVSP89
         OjRqpNEWGxjPKKk227RuxrLDCH2zr8mriw5xBYMfnAFNhw4JbDB5ULD5jzg/OASqaTC8
         3Jpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679560118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OOYn20tiv4eFu0Zo7pcx9dFPpDzH/yyBBrbi1uHVeEQ=;
        b=3Q7AFRN+xuptWmWWDW4sRn74oWEpYyRlEZ4sQ5XmI0LKtX/IIklWT9MdSraIzZvDID
         aoActRpRzoWfDWiH1s4TC0dcH5tlt56sz31guvjKXyra7uk56q0SQZ40j1P4JCDQzkUH
         iXLlz4foFaZhYXuqq2Q4mWfuCD97d48dmLitoZLKaNt6Cgf1K0zq2FOHcB09j8KjXch2
         I3/JQKTzSE7iKBCqWXfcuaAUcZw9jAjv8OMWUYQ8I16+ca3HWvYnOmO0xUFW5HhjBY1h
         61y+YMEXfGzh+n81uPiZ8vRcd1wm7GRqbuweQkSfOQEHAJzcWMBv+vF5QAzjEVFH5RNU
         NHlA==
X-Gm-Message-State: AAQBX9et7yXNXmUjbpOYOQeeB1fn1GhQGeNhTfOJJZpkm8b7xbHClHWd
        4kzn/pnli31UBpH/jr2rQeisrIL8XUWvV/Ja6X9fKg==
X-Google-Smtp-Source: AKy350YYHC7uwCbjENv3/g6/oHc8hZCRZS/al+XHOovK9BGvOXAjJkB87T26I+IR59hrCZyKA67OR/aCzqEFmxJM0aQ=
X-Received: by 2002:a25:6dc1:0:b0:b67:4774:7a3e with SMTP id
 i184-20020a256dc1000000b00b6747747a3emr2279910ybc.62.1679560117717; Thu, 23
 Mar 2023 01:28:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230323025003.94447-1-songmuchun@bytedance.com>
In-Reply-To: <20230323025003.94447-1-songmuchun@bytedance.com>
From:   Marco Elver <elver@google.com>
Date:   Thu, 23 Mar 2023 09:28:01 +0100
Message-ID: <CANpmjNP+WU4AjmNLMz317ipDKr2BQ-zJrNkJeqqAFiPwcYOs4g@mail.gmail.com>
Subject: Re: [PATCH] mm: kfence: fix handling discontiguous page
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

On Thu, 23 Mar 2023 at 03:50, 'Muchun Song' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> The struct pages could be discontiguous when the kfence pool is allocated
> via alloc_contig_pages() with CONFIG_SPARSEMEM and !CONFIG_SPARSEMEM_VMEMMAP.
> So, the iteration should use nth_page().
>
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kfence/core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index d66092dd187c..1065e0568d05 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -556,7 +556,7 @@ static unsigned long kfence_init_pool(void)
>          * enters __slab_free() slow-path.
>          */
>         for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> -               struct slab *slab = page_slab(&pages[i]);
> +               struct slab *slab = page_slab(nth_page(pages, i));
>
>                 if (!i || (i % 2))
>                         continue;
> @@ -602,7 +602,7 @@ static unsigned long kfence_init_pool(void)
>
>  reset_slab:
>         for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
> -               struct slab *slab = page_slab(&pages[i]);
> +               struct slab *slab = page_slab(nth_page(pages, i));
>
>                 if (!i || (i % 2))
>                         continue;
> --
> 2.11.0
>
> --
> You received this message because you are subscribed to the Google Groups "kasan-dev" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kasan-dev+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/kasan-dev/20230323025003.94447-1-songmuchun%40bytedance.com.
