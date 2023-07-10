Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853AD74CFE3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbjGJIZl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 04:25:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbjGJIZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:25:36 -0400
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B20E2;
        Mon, 10 Jul 2023 01:25:35 -0700 (PDT)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-57712d00cc1so54467407b3.3;
        Mon, 10 Jul 2023 01:25:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977534; x=1691569534;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pH9fU93I+sCPyG6NQ4A6Nl6qz22cdcmPyX7o2EJSVqU=;
        b=FBaemoJVmtW98PSZCEciK1PxalnPbsyWyTEkfVdhk2+2HAs343cn1yfQD9gEiV3otS
         QZ1y9Q7KYpuzGZ9ZBUIoKASA3+l3z4vI4TlC63mEN4jGHEoRZZbChK4KHDmYsktIE/hp
         8QggJLQ5TAV2KAUQdBY+YSduVrDgxC5/3K1ybMtOdGkH/cz/tupVMtGRqnwYfqD/Na2g
         gatlqCYX0yNnTRvvbzKheaAPkH1moAtX4iRZOUeqouHso/cHEPrnBCPZKZ8FEjtF/xvK
         Sm5pwY0e2wxkmOa8yW3hbUz2FG7b6wf1cFAqvRfmOVboyMgQDQWYDt04eHxYFHRbLu+X
         T1uw==
X-Gm-Message-State: ABy/qLa3r6X6bwrrdj0YIXMs77B6rZqA9/XIdwNbsrfSvZEKGge+WSkU
        y3YUayKR5JGTTBehVuUgEtfbdsm8kAcMhQ==
X-Google-Smtp-Source: APBJJlEosf1BKAh3lP1vPIjwTEISnLWb8ncH2+tKdHyVpmsvZ37F4YEaEwq7hvqazFBSK05LOwfP8A==
X-Received: by 2002:a0d:ca55:0:b0:56d:5060:f91a with SMTP id m82-20020a0dca55000000b0056d5060f91amr12797425ywd.11.1688977534405;
        Mon, 10 Jul 2023 01:25:34 -0700 (PDT)
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com. [209.85.128.178])
        by smtp.gmail.com with ESMTPSA id a125-20020a818a83000000b0057a560a9832sm2582055ywg.1.2023.07.10.01.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 01:25:33 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-57712d00cc1so54467197b3.3;
        Mon, 10 Jul 2023 01:25:33 -0700 (PDT)
X-Received: by 2002:a0d:ea87:0:b0:57a:6bf0:2100 with SMTP id
 t129-20020a0dea87000000b0057a6bf02100mr6098699ywe.1.1688977533504; Mon, 10
 Jul 2023 01:25:33 -0700 (PDT)
MIME-Version: 1.0
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
 <6af51602-631a-dadc-2740-d1cfad0a2993@roeck-us.net> <CAMuHMdW=WDuqgXk_51T341vgXrcxYPO34ou=rKHZrZj8Yiw6Rw@mail.gmail.com>
 <f27872c8f374a42fb7ea313314c47cdba2473b06.camel@physik.fu-berlin.de>
 <CAMuHMdXg1FvMCSBCvs=aFah0NWdOzEX+XdF4af0kY3kNx2bPtg@mail.gmail.com>
 <e44bc98f41e0497a3f125a32a6e78fe14313c634.camel@physik.fu-berlin.de>
 <CAMuHMdUOOPvVM-evLptCnbNGpDtAxktY7QDuKQo7WmZ7RhrAFg@mail.gmail.com> <63a34d66698065724d8ff3455192a8f2814cf034.camel@physik.fu-berlin.de>
In-Reply-To: <63a34d66698065724d8ff3455192a8f2814cf034.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 10:25:19 +0200
X-Gmail-Original-Message-ID: <CAMuHMdV53tr3bmn0yJFB2-enUwBTtrieUvpH+qiQzmPtefUuTw@mail.gmail.com>
Message-ID: <CAMuHMdV53tr3bmn0yJFB2-enUwBTtrieUvpH+qiQzmPtefUuTw@mail.gmail.com>
Subject: Re: [PATCH] [RFT] sh: mach-r2d: Handle virq offset in cascaded IRL demux
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
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

Hi Adrian,

On Mon, Jul 10, 2023 at 10:20 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2023-07-10 at 10:18 +0200, Geert Uytterhoeven wrote:
> > > OK, so we're talking about two different regressions here?
> > https://lore.kernel.org/r/CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com
>
> Link doesn't work for me, unfortunately.

-EAGAIN ;-)

Lore-archiving is not instantaneous. Please retry.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
