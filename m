Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C046968C736
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 21:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjBFUDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 15:03:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBFUDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 15:03:37 -0500
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AFB1EFED;
        Mon,  6 Feb 2023 12:03:35 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-4b718cab0e4so169892857b3.9;
        Mon, 06 Feb 2023 12:03:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u9SWi5xYTHrRjVguNFjjUy6U7YmMLQk0y/iYmmBjvHE=;
        b=IapmhMaiVS2Tnsg/VmAp3HiFJFQGBE0zkIAwmaWheGqbyUGZSQvisRaM9lfKTJMIX7
         NR2zKlkFyH8WQCZlWMzI16rVOwiDA/4bT46LzLvO6FXXpHW2PkLXVh+0dXdkuVBcKMwM
         3/9YuEwyRVroTFnhpFWSJnj/O/Bfmu/6bmyfXgXVlyHpR9p8C67IkwlrFwpZnx5Frxgp
         fkORN/uQq+zxUIeeptdZprUfREwWc3DKu4zwj8xRb0Gklphu7l7+s3XosLFH7R5IGvbE
         y9/UbWztLhDhO2EzHIUi/Tbj3pNML/z7NoUtLAsodjZ8F/9df+nRCAyaJIFQGMFg0ekk
         CE1A==
X-Gm-Message-State: AO0yUKV3fXwBQDQAXOme4OJgVGrldCRgWx/wcLSP7QSXWKEP0OhYmQGI
        wsuogzxXNMskK1bhX/ONLUvk8gpelrVurQ==
X-Google-Smtp-Source: AK7set9lhlmOh2oWsFNvI/1ZX2VopgHYoXoj88prztbjdObNM86GKe0Iyns304jbOcBSfjR4aNrfmQ==
X-Received: by 2002:a81:9aca:0:b0:529:8dd1:8c51 with SMTP id r193-20020a819aca000000b005298dd18c51mr179709ywg.43.1675713813834;
        Mon, 06 Feb 2023 12:03:33 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id de8-20020a05620a370800b0071d3e432c9bsm8271748qkb.28.2023.02.06.12.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 12:03:32 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-527979e8670so83253777b3.10;
        Mon, 06 Feb 2023 12:03:32 -0800 (PST)
X-Received: by 2002:a81:8285:0:b0:507:86ae:c733 with SMTP id
 s127-20020a818285000000b0050786aec733mr45244ywf.358.1675713811751; Mon, 06
 Feb 2023 12:03:31 -0800 (PST)
MIME-Version: 1.0
References: <20230203193523.never.667-kees@kernel.org> <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
In-Reply-To: <6c728dfc-d777-4beb-b463-649704c81a5e@app.fastmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 6 Feb 2023 21:03:19 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXSwYYoUMskhcgjF9SVjraZC-UsBT3sN+xkcUAYmJj4Q@mail.gmail.com>
Message-ID: <CAMuHMdXXSwYYoUMskhcgjF9SVjraZC-UsBT3sN+xkcUAYmJj4Q@mail.gmail.com>
Subject: Re: [PATCH] uaccess: Add minimum bounds check on kernel buffer size
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Christian Brauner <brauner@kernel.org>,
        Stafford Horne <shorne@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, Feb 3, 2023 at 10:23 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Feb 3, 2023, at 20:35, Kees Cook wrote:
> > --- a/include/linux/uaccess.h
> > +++ b/include/linux/uaccess.h
> > @@ -329,6 +329,10 @@ copy_struct_from_user(void *dst, size_t ksize,
> > const void __user *src,
> >       size_t size = min(ksize, usize);
> >       size_t rest = max(ksize, usize) - size;
> >
> > +     /* Double check if ksize is larger than a known object size. */
> > +     if (WARN_ON_ONCE(ksize > __builtin_object_size(dst, 1)))
> > +             return -E2BIG;
> > +
>
> WARN_ON_ONCE() may be a little expensive since that adds two
> comparisons and a static variable to each copy, but it's probably
> fine.

When seeing this, I was a bit worried about the size increase.
Hence I gave it a try on atari_defconfig and ran bloat-o-meter.
Surprisingly, there was no size increase at all, as all checks
were optimized away.

Hence perhaps this can become a compile-time check?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
