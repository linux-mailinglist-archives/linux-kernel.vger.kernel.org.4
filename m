Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A4C6536D3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 20:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234691AbiLUTIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 14:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiLUTI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 14:08:27 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD6B205D3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:08:25 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id b189so15616687vsc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Qn+t8qDtNQ9Zc5y1ZpPtqZOcEJkis56LzveCTgnEvi8=;
        b=VG2RhAC4GerNWJVwD5eJK2dJtjzxa5jl2ZE1QCuq5JVGE55Nw9FULecqOtzxRwYK6X
         6x1WsybFrqNdJhT41JDls6OTcVcDuZilELmRIQWqu4uWpTYScMFpjXEAVirA2mY2wWZC
         BFqQ0e6nDcmL/pH5o0U4mrpND+AVZUnqI15hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qn+t8qDtNQ9Zc5y1ZpPtqZOcEJkis56LzveCTgnEvi8=;
        b=cNBF7ErS/Na12mYRWPIbJPFItO4kX8eJxm3EgIAvohhGXg+GKz+kvoyXNYB+4V+TpS
         2o95mbpzwnZ8kGT1yqIKL31U8rq+cDE/C38U7GccduO9gA8GjR4eV/Hplg4TPatKQT6A
         jtDutPUBS5DDMpdZRwNdohhuzuUfPr3b/NibUWHWnKKzVIb2kJuxeZ7wHmscLzmn8zW1
         B1V1jUek3bPO1r1AkhVFQDhTtF8iTvHnwP43twBqU0DwmvffWa6YOiMmiJyzg2CUh/SD
         +sLe9eQ+alPyXzy6O9Ej84lQloJ2MAn9Y5nv78NoGm4UeJrRCkCavdarKN2sQIJBFx50
         xDeg==
X-Gm-Message-State: AFqh2krPHMNKqpu9xSHHe7/n34ugDRZKx5bKADyNSCwmUJ9sv1GOIcAn
        KWt7RoX/131uTLkxUqnPIWM6I1hNlPN5wH3E
X-Google-Smtp-Source: AMrXdXsUHCR0+EQm5z8jyxFxLM7XJ5rP1C6aDwwB6PI5uAUuCaJ/LuJeU9hBAcoLSj+2vbHrREBfbg==
X-Received: by 2002:a67:8cc4:0:b0:3b2:a92b:3b52 with SMTP id o187-20020a678cc4000000b003b2a92b3b52mr1301185vsd.8.1671649704706;
        Wed, 21 Dec 2022 11:08:24 -0800 (PST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com. [209.85.219.49])
        by smtp.gmail.com with ESMTPSA id bp43-20020a05620a45ab00b006fb7c42e73asm11475809qkb.21.2022.12.21.11.08.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 11:08:22 -0800 (PST)
Received: by mail-qv1-f49.google.com with SMTP id pp21so10946445qvb.5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 11:08:21 -0800 (PST)
X-Received: by 2002:a05:6214:1185:b0:4c6:608c:6b2c with SMTP id
 t5-20020a056214118500b004c6608c6b2cmr133347qvv.130.1671649701297; Wed, 21 Dec
 2022 11:08:21 -0800 (PST)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <20221221145332.GA2399037@roeck-us.net> <CAMuHMdUAaQSXq=4rO9soCGGnH8HZrSS0PjWELqGzXoym4dOqnQ@mail.gmail.com>
 <1a27385c-cca6-888b-1125-d6383e48c0f5@prevas.dk> <20221221155641.GB2468105@roeck-us.net>
 <CAHk-=wj7FMFLr9AOW9Aa9ZMt1-Lu01_X8vLiaKosPyF2H-+ujA@mail.gmail.com>
 <20221221171922.GA2470607@roeck-us.net> <CAHk-=wjOcqWxpUUrWKLKznRg-HXxRn1AXLW9B6SPq-ioLObdjw@mail.gmail.com>
In-Reply-To: <CAHk-=wjOcqWxpUUrWKLKznRg-HXxRn1AXLW9B6SPq-ioLObdjw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 21 Dec 2022 11:08:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiL2njz3b-_jY7iSJ15eu-9Drb4TOyPdd0cJ=kk_RQEvg@mail.gmail.com>
Message-ID: <CAHk-=wiL2njz3b-_jY7iSJ15eu-9Drb4TOyPdd0cJ=kk_RQEvg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-m68k@lists.linux-m68k.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2022 at 10:46 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But it looked very obvious indeed, and I hate having buggy code that
> is architecture-specific when we have generic code that isn't buggy.

Side note: we have an x86-64 implementation that looks fine (but not
really noticeably better than the generic one) that is based on the
'return subtraction' model. But it seems to get it right.

And we have a 32-bit x86 assembly thing that is based on 'rep scasb',
that then uses the carry bit to also get things right.

That 32-bit asm goes back to Linux 0.01 (with some changes since to
use "sbbl+or" instead of a conditional neg). I was playing around a
lot with the 'rep' instructions back when, since it was all part of
"learn the instruction set" for me.

Both of them should probably be removed as pointless too, but they
don't seem actively buggy.

               Linus
