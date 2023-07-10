Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54A374CDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGJHDh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 03:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbjGJHDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:03:36 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC60EA;
        Mon, 10 Jul 2023 00:03:34 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-579de633419so46397967b3.3;
        Mon, 10 Jul 2023 00:03:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688972614; x=1691564614;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FUsj5MBXEgLiVC60bUrok+biC26UCfULbqssp91WdhI=;
        b=h1HucfQNPERns2DcWtcXvRo/VHvdm1maDpFqoOjHaFI59fpLL+Fqw3baBElaKeQtPj
         eDEBpq6YYpvnwR/zWCDsSsm0u5EwQxHLclXrTxJ1EN7I1ZvbQctqvEwAnBxL1PBITAtb
         DoC/960eaBQAx4QHqwD9dGnsDh0lzs9+zItK0ILwFefcF+pY1MPTuZ1Yvtdsv1gGNyUL
         aXQNnI+/yhpvashvlgahemz2bFHrFgGI9BMHUw5sb1VMswgvAnVdIlC7MJ7pc0zPGgGq
         EBjjauRWc2/AF+gO+npSrOMI/2hsUK+wk9v5GkaoYLhVmQZH3058RMdVq8CVTvPH12og
         PT4w==
X-Gm-Message-State: ABy/qLZFYTT4IfTGkCNAvhxyHqjQo4gEnJa06e3FxNEU4OREFPvO6LBs
        fba2soKwEShKQoEf+RciSNmxhxx7hhrcKQ==
X-Google-Smtp-Source: APBJJlEKvXsObR1B6Rqnf3S7EJaSIghwSd5gePaDe7kRBufMrNjDy+BCWQPgFwEBNmezZqz9MwPFhA==
X-Received: by 2002:a81:5294:0:b0:56d:244:ab13 with SMTP id g142-20020a815294000000b0056d0244ab13mr10921341ywb.28.1688972613799;
        Mon, 10 Jul 2023 00:03:33 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id v188-20020a8161c5000000b0056dfbc37d9fsm2921201ywb.50.2023.07.10.00.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 00:03:33 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-bd0a359ca35so3720058276.3;
        Mon, 10 Jul 2023 00:03:32 -0700 (PDT)
X-Received: by 2002:a25:e6c4:0:b0:bc7:d27:ddb6 with SMTP id
 d187-20020a25e6c4000000b00bc70d27ddb6mr9310391ybh.64.1688972612601; Mon, 10
 Jul 2023 00:03:32 -0700 (PDT)
MIME-Version: 1.0
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
 <6af51602-631a-dadc-2740-d1cfad0a2993@roeck-us.net>
In-Reply-To: <6af51602-631a-dadc-2740-d1cfad0a2993@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 09:03:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW=WDuqgXk_51T341vgXrcxYPO34ou=rKHZrZj8Yiw6Rw@mail.gmail.com>
Message-ID: <CAMuHMdW=WDuqgXk_51T341vgXrcxYPO34ou=rKHZrZj8Yiw6Rw@mail.gmail.com>
Subject: Re: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL demux
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Sergey Shtylyov <s.shtylyov@omp.ru>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Mon, Jul 10, 2023 at 3:13 AM Guenter Roeck <linux@roeck-us.net> wrote:
> On 7/9/23 04:15, Geert Uytterhoeven wrote:
> > When booting rts7751r2dplus_defconfig on QEMU, the system hangs due to
> > an interrupt storm on IRQ 20.  IRQ 20 aka event 0x280 is a cascaded IRL
> > interrupt, which maps to IRQ_VOYAGER, the interrupt used by the Silicon
> > Motion SM501 multimedia companion chip.  As rts7751r2d_irq_demux() does
> > not take into account the new virq offset, the interrupt is no longer
> > translated, leading to an unhandled interrupt.
> >
> > Fix this by taking into account the virq offset when translating
> > cascaded IRL interrupts.
> >
> > Fixes: a8ac2961148e8c72 ("sh: Avoid using IRQ0 on SH3 and SH4")
> > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > Closes: https://lore.kernel.org/r/fbfea3ad-d327-4ad5-ac9c-648c7ca3fe1f@roeck-us.net
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Highlander and Dreamcast probably have the same issue.
> > I'll send patches for these later...
>
> dreamcast doesn't build in linux-next, just in case you didn't notice.

Indeed, I hadn't tested that.
My current tree isn't based on linux-next, but did have a build
failure in the cdrom code, for which I had found your fix (thanks!) in
linux-next...

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
