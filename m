Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906DB63D12D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 09:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbiK3I4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 03:56:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiK3I4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 03:56:21 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF922D1C0;
        Wed, 30 Nov 2022 00:56:20 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id v8so11740098qkg.12;
        Wed, 30 Nov 2022 00:56:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BJTF4kLOKsfF/dL9+8uFkzScHFlje+C5R7BmCYFvyJ0=;
        b=Bggi85dANmGplLHI8d34Dgfj18FvcTCEPCA8t9mCCMQutMdcBg93Y0mGIVOa+07OVf
         7jmlqXXMxDkIqF6lwz+8r9yrMymuI62TeuriLD4mjemGsWj/XvGyBiEaZtNyGfOLBx/k
         S8v4rZN9+Q/i93ZrIZTSb7rIInqdySJeJ1PhC+I51+d3UJ/bcoSWXU6K4zN56snU4rZ6
         ltE7OGdWrvK/67N9MSCeuW0vuPXNGFOkvXimLg0bPhU1sDN2mhbCoC5XKDgdApPCQNnt
         7YjeE8zAaC4dbVEGuIajXvFHcZykqmIWUQwsSiK4sFwEZhvAoCUqJrccALfCoEADis/M
         ktmA==
X-Gm-Message-State: ANoB5pkussaMlzLnF6W6m4El1GsL4hWVokw3sy936SGXUi/n5Hq0yYv4
        zk5+7w1HlvYtfhxpfM5R+B0kAfPLlZZq3g==
X-Google-Smtp-Source: AA0mqf5Vw2o9JEDz0NHR4Yom+ogiWhFov/5cANqq844D4rmQcI9tco9eHauzv/IjHGvMN5X2wd4CkQ==
X-Received: by 2002:a05:620a:1292:b0:6fa:2b24:4456 with SMTP id w18-20020a05620a129200b006fa2b244456mr52818019qki.513.1669798579508;
        Wed, 30 Nov 2022 00:56:19 -0800 (PST)
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com. [209.85.128.171])
        by smtp.gmail.com with ESMTPSA id bi6-20020a05620a318600b006fa16fe93bbsm728110qkb.15.2022.11.30.00.56.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 00:56:18 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-3c090251d59so108761627b3.4;
        Wed, 30 Nov 2022 00:56:17 -0800 (PST)
X-Received: by 2002:a81:f80f:0:b0:38e:e541:d8ca with SMTP id
 z15-20020a81f80f000000b0038ee541d8camr54658604ywm.283.1669798577394; Wed, 30
 Nov 2022 00:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20221129210639.42233-1-Jason@zx2c4.com> <20221129210639.42233-3-Jason@zx2c4.com>
In-Reply-To: <20221129210639.42233-3-Jason@zx2c4.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Nov 2022 09:56:06 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUGkhFu7X8eUMU1qqTOLKC=xsXWG2obPUeTwzyMGD8grw@mail.gmail.com>
Message-ID: <CAMuHMdUGkhFu7X8eUMU1qqTOLKC=xsXWG2obPUeTwzyMGD8grw@mail.gmail.com>
Subject: Re: [PATCH v10 2/4] arch: allocate vgetrandom_alloc() syscall number
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Tue, Nov 29, 2022 at 10:09 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Add vgetrandom_alloc() as syscall 451 (or 561 on alpha) by adding it to
> all of the various syscall.tbl and unistd.h files.
>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

Thanks for your patch!

What's the policy regarding adding syscall numbers for VDSO-related
syscalls on architectures that do not support VDSOs yet?

>  arch/m68k/kernel/syscalls/syscall.tbl               | 1 +

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
