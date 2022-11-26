Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C7063975F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 18:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiKZRIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 12:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKZRIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 12:08:02 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8E0A9FE8
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:08:00 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id g10so6530248plo.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 09:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7x63YXZnelPyg/pT1Bm48iuMcv64hm1Pn46j5qsjmRE=;
        b=P0DneLpTr8m3xc/aP/YyA4J5Zn/p5VpvitpDP7dxD+Tzz2iXphc4hQ6tA2XJZPxNpY
         pULAbDJh6LEeayNUSqClKfZ68PGFL82MrI5nmZ2sgXGKIumouWOAXBF89i6ZXr4GwXeh
         LgS5vdUG0XzOFSNTfagpgxHWE5eBIDFsL4ZtFgwHLBO6K5WlwpUHYsqhFSKKTPvqpbZT
         vFEpysESUsr9t8oQvCzd3+fMB3uztn2d5q1c+xcGqPDUCHYf67JhbCcqkEgwAoKG6yRg
         nv7BbiCrniYVhEsAf6Xhox4N8pLIEpLVshXPFH5zuqLRoKruthSy4Srw1+ZTPut6wf3Z
         0e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7x63YXZnelPyg/pT1Bm48iuMcv64hm1Pn46j5qsjmRE=;
        b=dZCYRSIDn4rIpfU4j6Wkxm9boNdaqnL/SiMIVjlEgAZmQ9NqDTO/GLS4aM1YUmjM+3
         QiSsgqn2muXnE3cUysBHNGXWjcAK/Lik/ioEUIX/FGV6SVWu6iOkKeGii/sphYlP7bjt
         w1Bf947OV6fMjj7J4KXTJgfLZp3NGKfKFTrBu4y/uU3ZTQS5aa9UK1y98f/aT0kTkB27
         1hP0SR+6GLNCgpzDwHixeBN93csIX+Grq8NH04PL/TeYhXeCyMMNqJ4fozo3Vfl8E+Dr
         0QsuxvQdAdnDH6M6Fk+kTEn1yJQdjauNDaoH6HTOb/FVFDChSzhp34sMCUr9CT1YQNnh
         qONw==
X-Gm-Message-State: ANoB5plVisQerZ69x/Ly6hzvFOOjk18j6r5KQv/pRonUq1be5NjSjvPt
        BjKtS7FZKz3wPAbC+8ltq8tRPzF8gLWNA3R93MM=
X-Google-Smtp-Source: AA0mqf7Py9i5umDsf67TX9FGbFG5GEEDlUpu6zAXRxIdr5YqmKGM3yKGzgpQuN0DoBvdXqnLH+kge95UMYV0r6jVjq4=
X-Received: by 2002:a17:90b:888:b0:219:1a88:727b with SMTP id
 bj8-20020a17090b088800b002191a88727bmr4234546pjb.47.1669482480360; Sat, 26
 Nov 2022 09:08:00 -0800 (PST)
MIME-Version: 1.0
References: <20221114114344.18650-1-jirislaby@kernel.org> <20221114114344.18650-46-jirislaby@kernel.org>
In-Reply-To: <20221114114344.18650-46-jirislaby@kernel.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 26 Nov 2022 18:07:49 +0100
Message-ID: <CA+fCnZfBa+MBiAYPOh_djkEcoDY652pViznDQnqX708VaxuTOg@mail.gmail.com>
Subject: Re: [PATCH 45/46] kasan, lto: remove extra BUILD_BUG() in memory_is_poisoned
To:     "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Martin Liska <mliska@suse.cz>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Jiri Slaby <jslaby@suse.cz>
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

On Mon, Nov 14, 2022 at 12:45 PM Jiri Slaby (SUSE) <jirislaby@kernel.org> wrote:
>
> From: Martin Liska <mliska@suse.cz>
>
> The function memory_is_poisoned() can handle any size which can be
> propagated by LTO later on. So we can end up with a constant that is not
> handled in the switch. Thus just break and call memory_is_poisoned_n()
> which handles arbitrary size to avoid build errors with gcc LTO.
>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Alexander Potapenko <glider@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Vincenzo Frascino <vincenzo.frascino@arm.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: kasan-dev@googlegroups.com
> Cc: linux-mm@kvack.org
> Signed-off-by: Martin Liska <mliska@suse.cz>
> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
> ---
>  mm/kasan/generic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index d8b5590f9484..d261f83c6687 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -152,7 +152,7 @@ static __always_inline bool memory_is_poisoned(unsigned long addr, size_t size)
>                 case 16:
>                         return memory_is_poisoned_16(addr);
>                 default:
> -                       BUILD_BUG();
> +                       break;
>                 }
>         }
>
> --
> 2.38.1
>

Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
