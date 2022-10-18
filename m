Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 630E9602D63
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiJRNux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiJRNuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:50:51 -0400
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A17FBC61C
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:50:45 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id g11so9646676qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:50:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LKYnNweZgxwgNxf4yalBU36d5h/7Dl8cIFGnGJ7yPZM=;
        b=olvjzpejiAfeQgTLEvYRqg+mo24C7GjdH/StZDGcFIXCTFdsKIRXxVDclDT4XS658I
         dGmuodgSc8cUXq/2GgxSuUsaVSKoA5jCTFoPsUcS1EfKjTfARmrJEe7QI6tJwITkTrB8
         RvZb3dKzSWZyrbYf8PGDsnG+sGNbiC1zmSxlJYXsRW2Plt1ybdqOIBtodR2Ihfy0Ba+O
         Z/0D8dQEcQJoClkJWeOFVO1nsCUfMnWXjW6o93NzqRy5qvYfd/TybxpmPU7ppKCXiH/T
         l/OxwDNhq02571PVTM776St6MMrajaaYnzaoV/1EnLA4eImNkx3SciCzS5YeFQaDWlPm
         B08A==
X-Gm-Message-State: ACrzQf27KGGX7OA+xYMqwIBal6t0Wx0TduErnTnUvqWVu5gcge/QM9VT
        TUH1TWLb6uDledHBrhbuscocFIiRgCCg4j8C
X-Google-Smtp-Source: AMsMyM43Emcrb7acUwrv7edBwF5gEbisgJ1X4NoYUNyYXAHyPStc9gSPOzGHNtBa962YDSMY8Mjnxg==
X-Received: by 2002:a05:622a:490:b0:39c:c82d:557c with SMTP id p16-20020a05622a049000b0039cc82d557cmr2146018qtx.463.1666101044380;
        Tue, 18 Oct 2022 06:50:44 -0700 (PDT)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com. [209.85.219.180])
        by smtp.gmail.com with ESMTPSA id p7-20020a05620a132700b006b61b2cb1d2sm2396778qkj.46.2022.10.18.06.50.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:50:43 -0700 (PDT)
Received: by mail-yb1-f180.google.com with SMTP id 203so17014111ybc.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:50:43 -0700 (PDT)
X-Received: by 2002:a5b:104:0:b0:6b0:429:3fe9 with SMTP id 4-20020a5b0104000000b006b004293fe9mr2419104ybx.543.1666101042984;
 Tue, 18 Oct 2022 06:50:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230820.3295223-1-yury.norov@gmail.com>
 <20220905230820.3295223-6-yury.norov@gmail.com> <CAMuHMdUL0WxYjfRDxLWZG7Xu=2xTQkueathvpwWfLpqhG6NkFQ@mail.gmail.com>
 <CAMuHMdW2H4egcmv238Q_5LBeu9BE=H1fm=n4vZGCGYzhg2VN1A@mail.gmail.com> <mvmlepdb66h.fsf@suse.de>
In-Reply-To: <mvmlepdb66h.fsf@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 Oct 2022 15:50:31 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
Message-ID: <CAMuHMdVeHPR_JH0dJ+WSddjd8_hax70JRzd4pqHLNvgbh+-znw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] lib/cpumask: add FORCE_NR_CPUS config option
To:     Andreas Schwab <schwab@suse.de>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Dmitry Vyukov <dvyukov@google.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Sander Vanheule <sander@svanheule.net>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andreas,

On Tue, Oct 18, 2022 at 3:41 PM Andreas Schwab <schwab@suse.de> wrote:
> On Okt 18 2022, Geert Uytterhoeven wrote:
> > Moreover, this cannot be used on all systems.  E.g. on Icicle Kit with
> > Microchip PolarFire SoC, CONFIG_NR_CPUS needs to be larger than 4,
> > as the system has actually 5 CPU cores (1xE51 and 4xU54), but Linux
> > runs only on 4 of them.  So you cannot use FORCE_NR_CPUS=y.
>
> But does Linux acually see the E51 core?  On the Hifive boards it is
> disabled in the device tree, and the cpu probing just skips it,
> effectively resulting in only four cpus.

The E51 is indeed disabled in DT.
The CPU parts of arch/riscv/boot/dts/sifive/fu540-c000.dtsi and
arch/riscv/boot/dts/microchip/mpfs.dtsi arre very similar.
Do you get 4 CPUs on Hifive with CONFIG_NR_CPUS=4?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
