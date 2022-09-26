Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F7CE5EB08E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 20:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiIZSxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiIZSxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 14:53:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924AE5A3F2;
        Mon, 26 Sep 2022 11:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 45D95B80C75;
        Mon, 26 Sep 2022 18:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88184C433D7;
        Mon, 26 Sep 2022 18:52:56 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="GHUYsDZj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1664218372;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pDXoUOQlmNgJmVAlYuuj5yi+ly/HlT4KdcY9eEm5eBQ=;
        b=GHUYsDZj+cm4D1n4dLRNKXHPhilooi8feGkJettGK5fiNcs+gvB/Bk72j7l0NqbSLBiqIE
        WGz+iPEKKUu5kvVQwesBPBXD0LCeILsbUkn6NfW3zsrfC0kr6qVa9YOG68L1MR6iNls7lN
        Sw9ikwYwNU+FwMx2Vt7HI62m0Cbm3SI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e118ec30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 26 Sep 2022 18:52:51 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id h5so3871624vkc.5;
        Mon, 26 Sep 2022 11:52:51 -0700 (PDT)
X-Gm-Message-State: ACrzQf1a8lLyEaWHqIZydOxPGjOAl2daulcUJbnJ9qZdn5xg1NCvzeIL
        OaOsUl/srNo65rV7l2fl+1k+PixaW4qSD9fEOR4=
X-Google-Smtp-Source: AMsMyM6MHWzeqHmsiYCOhngqPYdkAndT7nfSLKC6I8G4EtrXNPMgzKjp0w6ATQj2NfFo9A4t0o/eV9+hI7aFbrIf4rg=
X-Received: by 2002:a1f:1b45:0:b0:3a7:ba13:11ce with SMTP id
 b66-20020a1f1b45000000b003a7ba1311cemr3104747vkb.3.1664218370625; Mon, 26 Sep
 2022 11:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220926160332.1473462-1-Jason@zx2c4.com> <202209261105.9C6AEEEE1@keescook>
In-Reply-To: <202209261105.9C6AEEEE1@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 26 Sep 2022 20:52:39 +0200
X-Gmail-Original-Message-ID: <CAHmME9pFDzyKJd5ixyB9E05jkZvHShFimbiQsGTcdQO1E5R0QQ@mail.gmail.com>
Message-ID: <CAHmME9pFDzyKJd5ixyB9E05jkZvHShFimbiQsGTcdQO1E5R0QQ@mail.gmail.com>
Subject: Re: [PATCH] random: split initialization into early arch step and
 later non-arch step
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 8:22 PM Kees Cook <keescook@chromium.org> wrote:
> Can find a way to get efi_get_random_bytes() in here too? (As a separate
> patch.) I don't see where that actually happens anywhere currently,
> and we should have it available at this point in the boot, yes?

No, absolutely not. That is not how EFI works. EFI gets its seed to
random.c much earlier by way of add_bootloader_randomness().

> > -             entropy[0] = random_get_entropy();
> > -             _mix_pool_bytes(entropy, sizeof(*entropy));
> >               arch_bits -= sizeof(*entropy) * 8;
> >               ++i;
> >       }
> > -     _mix_pool_bytes(&now, sizeof(now));
> > -     _mix_pool_bytes(utsname(), sizeof(*(utsname())));
>
> Hm, can't we keep utsname in the early half by using init_utsname() ?

Yes, we could maybe *change* to using init_utsname if we wanted. That
seems kind of different though. So I'd prefer that to be a different
patch, which would require looking at the interaction with early
hostname setting and such. If you want to do that work, I'd certainly
welcome the patch.

> > @@ -976,6 +976,9 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> >               parse_args("Setting extra init args", extra_init_args,
> >                          NULL, 0, -1, -1, NULL, set_init_arg);
> >
> > +     /* Call before any memory or allocators are initialized */
>
> Maybe for greater clarity:
>
>         /* Pre-time-keeping entropy collection before allocator init. */

Will do.

>
> > +     random_init_early(command_line);
> > +
> >       /*
> >        * These use large bootmem allocations and must precede
> >        * kmem_cache_init()
> > @@ -1035,17 +1038,13 @@ asmlinkage __visible void __init __no_sanitize_address start_kernel(void)
> >       hrtimers_init();
> >       softirq_init();
> >       timekeeping_init();
> > -     kfence_init();
> >       time_init();
>
> Was there a reason kfence_init() was happening before time_init()?

Historically there was, I think, because random_init() used to make
weird allocations. But that's been gone for a while. At this point
it's a mistake, and removing it allows me to do this:

https://groups.google.com/g/kasan-dev/c/jhExcSv_Pj4

>
> >
> > -     /*
> > -      * For best initial stack canary entropy, prepare it after:
> > -      * - setup_arch() for any UEFI RNG entropy and boot cmdline access
> > -      * - timekeeping_init() for ktime entropy used in random_init()
> > -      * - time_init() for making random_get_entropy() work on some platforms
> > -      * - random_init() to initialize the RNG from from early entropy sources
> > -      */
> > -     random_init(command_line);
> > +     /* This must be after timekeeping is initialized */
> > +     random_init();
> > +
> > +     /* These make use of the initialized randomness */
>
> I'd clarify this more:
>
>         /* These make use of the fully initialized randomness entropy. */

Okay will do.

Jason
