Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA86691331
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 23:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjBIWWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 17:22:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjBIWV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 17:21:58 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87B193CB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 14:21:56 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id gj9-20020a17090b108900b0023114156d36so7366571pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 14:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HBgooxc0T8xR3a6LCddpzQrYzp6lIglbhu4rq7s0u6g=;
        b=G66azLLsnTGcPff6dZ1UZZ+l6WItPKuuCA63rRDwBGGG286NbanTz7nS2sZyhkGFxa
         RuXPkGIsymiNyAWKgcNo8RbtOHohyX3kMlAxKyy93fxILNt+SuJhoSmjxN/nlTmHCdbr
         fUIg6nbBvmTjIcReqiqmmMljzQddn8PFmwHiuPWhpQutH6p67/3g0CHc8XjEa8cD7f1j
         08qP74TSw0MId7RvhzbxNMVoWiPDszIkD+6OjDAwl+qU3kyS6mjG9yQWP4wz/p2iiLcV
         ZWjWGUGEfldnXQUQXPsgNUnKcpEqwVXmHXjmthlBs6J1smjJbgbrwucYOuvqZxwH1aZz
         GvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HBgooxc0T8xR3a6LCddpzQrYzp6lIglbhu4rq7s0u6g=;
        b=qmzX+HIP/JQxJlhmRTNgfE0nfIRr9xMFm3rqiLQ8H+mfDKf6wv2IE7v2r8T4czozao
         oR2zT4MQtvkQclwz7vV5lWDcE20veHZMj2rHa2FLmg07mYaUNrUunV+axJyw4pc/xnss
         rLPyKWGhM+K9osoEn76Pc1vwqKje1gLiPAFH1h/Yp0HEiVPeEPtcTJ4bqQO37uUxnOOA
         /SW2Qifun+jqpq9r81iVBkXZA3iiOXdhPo50c3U3jFMRWQIRmWzTTOJ0PkBitxf/PZn+
         mrMvZjTZS7wHzvu/HRZSTF8HlDJk4F7R1TiKPWjtSfrHyS5WrZHqgHS43YlX1WZVe/mq
         OOMQ==
X-Gm-Message-State: AO0yUKX4WxW1OdhMvpkKvRypB41oDHdsy7SzIkChCMt/NHXjEsbcTtLR
        oo8bLcAsperQui2mWdhmKkkZGIS/eTnpaijjZsc=
X-Google-Smtp-Source: AK7set9b+dVUyCJB6vApvDHFGz5DxEUMKinwWM9x06h3G8+Iy6tr5nZNJoGvTj4ukeUpCcN0mwC8IVuFE8KPomfixtI=
X-Received: by 2002:a17:903:22c1:b0:196:6319:a029 with SMTP id
 y1-20020a17090322c100b001966319a029mr3284169plg.12.1675981316316; Thu, 09 Feb
 2023 14:21:56 -0800 (PST)
MIME-Version: 1.0
References: <20230208164011.2287122-1-arnd@kernel.org>
In-Reply-To: <20230208164011.2287122-1-arnd@kernel.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 9 Feb 2023 23:21:45 +0100
Message-ID: <CA+fCnZe_BYgXff6OnU+L4SJC1kbzse9VtdwUS7tQinudL7n=Jg@mail.gmail.com>
Subject: Re: [PATCH 1/4] kasan: mark addr_has_metadata __always_inline
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Feb 8, 2023 at 5:40 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When the compiler decides not to inline this function, objdump
> complains about incorrect UACCESS state:
>
> mm/kasan/generic.o: warning: objtool: __asan_load2+0x11: call to addr_has_metadata() with UACCESS enabled
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>

Thanks!
