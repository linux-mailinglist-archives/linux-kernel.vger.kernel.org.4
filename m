Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49AC15F3D77
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 09:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbiJDHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 03:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJDHtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 03:49:09 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77B994D244
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 00:49:07 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id 3so7935254qka.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:49:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fduZliTq+U+0wWmsFad0aB4OFMutcWYcqFT2IRwM4bw=;
        b=HE64Tr2x08IndZPPOI98pJSpyw6JGotWswojhfKG7Dnx99rhF+Pvt+rEFYNzSkiSrL
         lJr9NiKIUuvXQ87tBqafybhoZFHDrl2hKCGtZjvfWMtuzTawxgXieQI2YuB5S4HMdeGs
         RBq97h7l8Tc3YZu677PPslXZz62KtmLmWKp95GyCpwltHKDkfOahr8cTG4cVE66QIQ8U
         TGgVNN3xsVKo3j5kZ3rfrTzza88JrOWKahI/YKwizCkILPMYxPrF/cu1WyTYmKMAaU4a
         7XyZ8aGfgnKV1Pke9OkJnCA0AqrD/bgu48wExVYkE2HiKxzWRybInLrQohy6jZQzNQC9
         qGgg==
X-Gm-Message-State: ACrzQf10IlMENidcIEQahslgTsvnrjmITyFrRGV1SpaTW5bj/nYQNnsT
        p27HGwTS/ddcU3QpTX0yINt4bv/fiI6YtQ==
X-Google-Smtp-Source: AMsMyM79HoReUEERJ5dZXw8EiLuXVRb2crndbeo2kvnNlu5L7tQtgy+VlZWbV0Fv7x/PxvDCVrR51A==
X-Received: by 2002:a05:620a:4146:b0:6cf:837e:54a5 with SMTP id k6-20020a05620a414600b006cf837e54a5mr15960032qko.668.1664869745478;
        Tue, 04 Oct 2022 00:49:05 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id t7-20020a05622a01c700b00342fc6a8e25sm11989954qtw.50.2022.10.04.00.49.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Oct 2022 00:49:05 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id b145so563266yba.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 00:49:04 -0700 (PDT)
X-Received: by 2002:a25:3a02:0:b0:6bb:fce3:7b06 with SMTP id
 h2-20020a253a02000000b006bbfce37b06mr24158957yba.89.1664869744393; Tue, 04
 Oct 2022 00:49:04 -0700 (PDT)
MIME-Version: 1.0
References: <e8b573d81168c33ed4f3d5e5e2d3b951c323fc23.1664347239.git.geert+renesas@glider.be>
 <CACRpkdbLDi9vE-Y14j+Tk7Gm+Tbft+C+R4wtPe-Gr7jLeEe7Og@mail.gmail.com>
In-Reply-To: <CACRpkdbLDi9vE-Y14j+Tk7Gm+Tbft+C+R4wtPe-Gr7jLeEe7Og@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Oct 2022 09:48:53 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVwnJ-dG7eBY-BnH1aZQVxknnzr+zvoDr+53U8CE=NRiw@mail.gmail.com>
Message-ID: <CAMuHMdVwnJ-dG7eBY-BnH1aZQVxknnzr+zvoDr+53U8CE=NRiw@mail.gmail.com>
Subject: Re: [PATCH] ARM: remove check for CONFIG_DEBUG_LL_SER3
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Paul Bolle <pebolle@tiscali.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

Hi Linus,

On Tue, Oct 4, 2022 at 9:44 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 28, 2022 at 12:14 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > From: Paul Bolle <pebolle@tiscali.nl>
> >
> > A check for CONFIG_DEBUG_LL_SER3 was added in v2.5.43. But the related
> > symbol DEBUG_LL_SER3 was already removed in v2.5.8. This check has
> > always evaluated to false. Remove it.
> >
> > Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Still valid after 8 years...
> > Link: https://lore.kernel.org/r/1400055127.31197.1.camel@x220
>
> :D
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks!

> Please put this into Russell's patch tracker.

Arnd took it into soc/for-next as commit 4413794917ba3ff4 ("ARM:
remove check for CONFIG_DEBUG_LL_SER3").

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
