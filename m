Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F075568F3F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 18:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjBHRCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 12:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjBHRCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 12:02:20 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50614E537
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 09:02:16 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id q4so18162444ybu.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 09:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J6GQ6k0SpXRf+NY/XuyN7DEx4advOeWO/TlcuNhkMx0=;
        b=qkdR5pkq6sV8hNH3YDKJ8++iTClWqw++RrBXApfqLOYQgMe4S7SF6Q5gm6WlcUFqAy
         EcDtnNS2/nJgxMlDyNNCpWyL4L3Y7dyQVuQycGPcFZk3C8t3IlY7aaV9uHzszL9FOrlS
         YVhdSnXGCHv3enJtHbWv6Hs5JMeWL4q2vi/c62FadmqIvBF+s6uDOs1h6ypjgyUks0yH
         dxiM7QbyvZdmqyphgiW8HEdHkt0+yTgSWPnjIIeT+4UTHy2iwuqQTQ2upvprvgDXufCh
         AgR72rVEXTs3X/7jqSTKT2qB1px+ihMQa7Izpe1ISycqiE4TCFxq+smYn5Ifli5ibYcv
         10mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6GQ6k0SpXRf+NY/XuyN7DEx4advOeWO/TlcuNhkMx0=;
        b=OflIo3tw8+OImEUJCH3Hsn6BSlqyLIWN7sS5if9fDYi2KcDqE3qONv870VeIJlYcoj
         gIhiaM4v8UvEFscT/nB/eaW7zHFOrXGz21u1sYo3B/l9UXly9zq9tZV06VlRWZ4izQ7D
         E6oV5uj1RrNeEOfekC4AK8kkmRnvy04Bueq7GXNXQWqaiVd88t6hYPMQb1+6knuP7XhK
         ebFM5RhERhhiQBhcjHhgWMciQPyzOfIAcJQMTL3ZbkG9UC9sBiV5TXQIjmT6TmsdAzfm
         2f8hgSRKmPJh7K6b+/KpqrHfhZfcDmbLAOeJf1xmQ3Ze7YaZQVTxQjuscyzku0B8KoDQ
         WsYA==
X-Gm-Message-State: AO0yUKVCL7jgCxQ61Az7lc6zsbozraPUquiXhuJzdKJz7/ZwaUn0dd5R
        Py6oCtWV6v9wEsJxu6lIzVl2qjHaRVpOxO7xI3NRXw==
X-Google-Smtp-Source: AK7set8Afj6wAQvyLOzq7FCZwVWe6hcVYmC9OxxsiADkYMOvQvPBxVg623zz/LBUOZi51jIrZeS2oVdFwi8z8nOy5/g=
X-Received: by 2002:a05:6902:6:b0:82b:1e20:3ae6 with SMTP id
 l6-20020a056902000600b0082b1e203ae6mr599159ybh.364.1675875735798; Wed, 08 Feb
 2023 09:02:15 -0800 (PST)
MIME-Version: 1.0
References: <20230208164011.2287122-1-arnd@kernel.org>
In-Reply-To: <20230208164011.2287122-1-arnd@kernel.org>
From:   Marco Elver <elver@google.com>
Date:   Wed, 8 Feb 2023 18:01:39 +0100
Message-ID: <CANpmjNP5fem=aueS1_--gxzFFOOqYTEOREMDZEhn0TMKwUP4qw@mail.gmail.com>
Subject: Re: [PATCH 1/4] kasan: mark addr_has_metadata __always_inline
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>, linux-mm@kvack.org,
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

On Wed, 8 Feb 2023 at 17:40, Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When the compiler decides not to inline this function, objdump
> complains about incorrect UACCESS state:
>
> mm/kasan/generic.o: warning: objtool: __asan_load2+0x11: call to addr_has_metadata() with UACCESS enabled
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Marco Elver <elver@google.com>

> ---
>  mm/kasan/kasan.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 3231314e071f..9377b0789edc 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -297,7 +297,7 @@ static inline const void *kasan_shadow_to_mem(const void *shadow_addr)
>                 << KASAN_SHADOW_SCALE_SHIFT);
>  }
>
> -static inline bool addr_has_metadata(const void *addr)
> +static __always_inline bool addr_has_metadata(const void *addr)
>  {
>         return (kasan_reset_tag(addr) >=
>                 kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> @@ -316,7 +316,7 @@ bool kasan_check_range(unsigned long addr, size_t size, bool write,
>
>  #else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
>
> -static inline bool addr_has_metadata(const void *addr)
> +static __always_inline bool addr_has_metadata(const void *addr)
>  {
>         return (is_vmalloc_addr(addr) || virt_addr_valid(addr));
>  }
> --
> 2.39.1
>
