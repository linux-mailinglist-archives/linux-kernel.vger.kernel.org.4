Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA445F23FE
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 18:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiJBQId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 12:08:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiJBQIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 12:08:30 -0400
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40E4C27DEA;
        Sun,  2 Oct 2022 09:08:27 -0700 (PDT)
Received: by mail-qv1-f46.google.com with SMTP id f14so2096441qvo.3;
        Sun, 02 Oct 2022 09:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HriaR9SbJdHeOwl1T1L8SB1ypd9OI4wcQH5thMKc5u8=;
        b=yaqrzaR4/cFR1vLqWL0UCOEJgklObj4mpuwH+6VE4PDbZWGn4qfxeKp4mEJkBJWKEn
         HvvlDKIUdvljmtS2KeJY8RvHGsG6taF/yBXDj9RmuS11C0iWPBF4jh6j2Uf2bLnYCgB/
         KJiSNm1hh6jF1cAVlZRt/5qs0qYMER8/Q+0QHmqCgtNnZrCfcJ++7xnZ7H9BVJfqLpKv
         xo91zftReWuuwD0wlaOPRepjro1UtpMvtxgv9uxL1fF5cd3/VtpLl055yKzaCEzgr7mY
         ut9Dfom0H0LPBsC60+WeELrV0XnWZP7WFmFbcS5rw6smYyTytZU1ukJY8pNbKVgMW5cy
         tgTQ==
X-Gm-Message-State: ACrzQf1J5bKCuPaSDy1E307dXDDPE27mpVdB46xo23Du1P4owlYkGbSM
        tq1CrzuRTiXj7w/mXkD3OOP5aw4zKJy2Qg==
X-Google-Smtp-Source: AMsMyM7f8zSo9JUv06HwsNvLsGwnCVlMb7nFs7MrVzi7n/RGnniSkoAbDPK0C5cn62cQubzgtdYijg==
X-Received: by 2002:a05:6214:29e7:b0:4af:487d:c049 with SMTP id jv7-20020a05621429e700b004af487dc049mr14202773qvb.96.1664726906060;
        Sun, 02 Oct 2022 09:08:26 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id bl14-20020a05622a244e00b0034456277e3asm6947936qtb.89.2022.10.02.09.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 09:08:25 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-324ec5a9e97so86659187b3.7;
        Sun, 02 Oct 2022 09:08:24 -0700 (PDT)
X-Received: by 2002:a81:98d:0:b0:357:2422:13b4 with SMTP id
 135-20020a81098d000000b00357242213b4mr8099058ywj.316.1664726904607; Sun, 02
 Oct 2022 09:08:24 -0700 (PDT)
MIME-Version: 1.0
References: <aa876027-1038-3e4a-b16a-c144f674c0b0@leemhuis.info>
 <05d149a0-e3de-8b09-ecc0-3ea73e080be3@leemhuis.info> <9a2fdff8-d0d3-ebba-d344-3c1016237fe5@gmx.com>
 <YzgY9X/DM9t/ZuJe@kroah.com> <f8cbb12c-590b-28a3-e3e9-d3fb0d7e3c90@gmx.com>
 <d7798453-3105-7adf-a9a6-76e8cfe4d012@leemhuis.info> <83f6dd2b-784a-e6d3-ebaf-6ad9cfe4eefe@gmx.com>
 <a676e5cf-c67b-7946-ce73-8fb8d63a5a0a@leemhuis.info> <Yzg7pHspc72I7TAb@mit.edu>
 <e98597e8-9ddb-bbf0-7652-691327186a92@gmx.com> <YzmBjgXq9geMnL1B@mit.edu> <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
In-Reply-To: <79bb605a-dab8-972d-aa4a-a5e5ee49387c@gmx.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sun, 2 Oct 2022 18:08:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWLbS5jnOpdq0a6ie3eB5rmM6Rof3390t0u5FeO4Hmt5g@mail.gmail.com>
Message-ID: <CAMuHMdWLbS5jnOpdq0a6ie3eB5rmM6Rof3390t0u5FeO4Hmt5g@mail.gmail.com>
Subject: Re: Planned changes for bugzilla.kernel.org to reduce the "Bugzilla blues"
To:     "Artem S. Tashkinov" <aros@gmx.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Greg KH <gregkh@linuxfoundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        workflows@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        ksummit@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>
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

Hi Artem,

On Sun, Oct 2, 2022 at 2:49 PM Artem S. Tashkinov <aros@gmx.com> wrote:
> The current ill-maintained semi-functional bugzilla has proven to be a
> ton more useful than random mailing lists no sane person can keep track
> of. Bug "reports", i.e. random emails are neglected and forgotten. LKML
> is the worst of them probably.

Such a statement really needs to be backed by numbers...

> Let's operate with some examples:
>
> Bugzilla gets around two dozen bug reports weekly which encompass at
> most thirty emails, which equals to four emails daily on average.

This immediately debunks your statement above.

$ git log v5.19..linus/master | grep Fixes: | wc -l
2928

So that's 46 bugs fixed per _day_.  Most of them not reported
through bugzilla...

> LKML alone sees up to a hundred emails _daily_.
>
> Getting worked up about it? I'm dumbfounded to be honest.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
