Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A545E8B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 12:06:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233727AbiIXKGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 06:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiIXKGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 06:06:44 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAC210651A;
        Sat, 24 Sep 2022 03:06:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h14so1288223ila.12;
        Sat, 24 Sep 2022 03:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=MQqRh07oJjG1uYoKSq/7+nFPqaB+kxM6u9sDxOCB0M0=;
        b=QCoQK9qSnmfljjIlBVXk3a5MpdhI98B0+Q73E21yMZk2xI5+58F2j1ye6RFpBl3kyY
         JtjIvZ5YYI7EdHFPoHyYJv3Ld4fMQHA7LdgiKW5+hK/BQswN+AIrDumwBxCX58oD+BYy
         n3Dso88TV738qeE0LgzxR2c7AVfJkMyR4QH6I9zhyeYgbeJ+HhA1pd6mHvgcCahyWUrT
         gPpXRA/wNGf45LXsgC6phWYVIxoR1L9H6VhmHQcHUaVYxKKMC+eZeQmgH6A+Fy3D/D3e
         vXpZLkgSuhyj0GSTRXjO5y7L6qJgisHtMPteGvOjMXPvLb5rGJJmS2wGvdI5yx2FSvl5
         t4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=MQqRh07oJjG1uYoKSq/7+nFPqaB+kxM6u9sDxOCB0M0=;
        b=bnBQrhGNcNQhjNCMTyhAGqaPzVkoHQcM4FJJsEBMZ6Da9h7rp5kNUW3Ji/v2zb8oEI
         iOdFzEtQKQJCBjlK6IfKGT74Y2tj0Z6Wt9Vhtv7ikTQvO1rtujcQo3bUlHJQKsv5fXuC
         IgKiC65HQiOogU1QtOuRw4FukUXmLJjp6PuDjk3fVjC/il7phNE7VWrns6NI0WumRlx6
         ob5Mlv/htAPAex5j1Gs8q8mg2ZHs3YHCwFYrXyE1WahM2+2rWeev4T1xKjvHJWoeRxHc
         CLxDOPzvzNOMzRMs7uZxYl5e04iHUSRdG9PrztNmc0UF/7AnFneVvGf6RsEwgq/zh7Qe
         qMag==
X-Gm-Message-State: ACrzQf2ECkeVQsAwEzoe6kEwdqQTFMCne/1eiIHaBF42fsXBIyGSBWxV
        98SC4JMykyR5dMTC2JsCKSL7DCQ8akpCNBFO7rY=
X-Google-Smtp-Source: AMsMyM7d8SPImL1plbQiUKnpTlSqFfa+5snuO0TI09jCSn4kOs4Ig3uLXOuQAA8tgLitR7Rt00k/WlwRl3obyU3TRNY=
X-Received: by 2002:a05:6e02:188f:b0:2f8:993:e7ba with SMTP id
 o15-20020a056e02188f00b002f80993e7bamr1421387ilu.321.1664014003032; Sat, 24
 Sep 2022 03:06:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220923235424.3303486-1-keescook@chromium.org>
In-Reply-To: <20220923235424.3303486-1-keescook@chromium.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 24 Sep 2022 12:06:31 +0200
Message-ID: <CANiq72n6zK=sXn2j71bAEUUYwRse2dT9f8kLrYzncnPjN1XTow@mail.gmail.com>
Subject: Re: [PATCH] Compiler Attributes: Introduce __access_*() function attribute
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Siddhesh Poyarekar <siddhesh@gotplt.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
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

On Sat, Sep 24, 2022 at 1:54 AM Kees Cook <keescook@chromium.org> wrote:
>
> are specified. While it is legal to provide only the pointer argument
> position and access type, design the kernel macros to require also the
> bounds (element count) argument position: if a function has no bounds
> argument, refactor the code to include one.

Should this bit be included in the comment of the attribute? (since it
is specific to the kernel)

> These can be used multiple times. For example:
>
> __access_wo(2, 3) __access_ro(4, 5)
> int copy_something(struct context *ctx, u32 *dst, size_t dst_count,
>                    u8 *src, int src_len);
>
> (And if "dst" will also be read, it could use __access_rw(2, 3) instead.)

Also maybe the example could be nice there too, since it uses the
syntax for the kernel and you took the time to write it :)

By the way, shouldn't `src` typically be `const u8 *`? Given it is an
example, I would qualify it.

> +#if __has_attribute(__access__)
> +#define __access_rw(ptr, count)        __attribute__((__access__(read_write, ptr, count)))
> +#define __access_ro(ptr, count)        __attribute__((__access__(read_only,  ptr, count)))
> +#define __access_wo(ptr, count)        __attribute__((__access__(write_only, ptr, count)))
> +#else
> +#define __access_rw(ptr, count)
> +#define __access_ro(ptr, count)
> +#define __access_wo(ptr, count)
> +#endif

If you do a v2 for the above, please take the chance to indent with a
single space after the `#` (like `# define`) for consistency.

Thanks!

Cheers,
Miguel
