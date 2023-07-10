Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE9BB74CFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 10:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjGJITO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 10 Jul 2023 04:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233090AbjGJISy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 04:18:54 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C50123;
        Mon, 10 Jul 2023 01:18:25 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-56fff21c2ebso51137647b3.3;
        Mon, 10 Jul 2023 01:18:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688977104; x=1691569104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g4+jAI+1GTCd84zI6N0h/1Lodtok5RA51aLjQEndjpI=;
        b=GRszJxY8Ur0n2AEadQftUTaL21YmS+/PBE+qi00DOigblUpfpuxYJ9BRXDoIETnRSO
         w8IubWzG8fGcxmZYy6J651/Z65odOl/eUj0cc2yuxBQhEjggmw2UcaiNnDRKyWOZ5aQ8
         uFtAm/9tgagP8arczKmfio4LdH1g0RIAAFDDZ6CyXBQyb1M6EGofKrumM5GO37NZcc2i
         5nsC8p7GUJkMMBPC/uxMiRcG3QI5GMSofd147iv7KMxlvRz5SZKS33RHcZgx3ANxCZ6g
         +6xLvn4bxX8b4a7ss28DfHF/8agdtCGgFsHCRi0pc0rGIBmpStnvF6fXJq2E3swYzfqU
         ZFeA==
X-Gm-Message-State: ABy/qLbO/CeV8pErrtEmv5/sRpGYqMoQQEYfkiJ+rEqlvdv69ReTTAew
        zHLe0oauWT3tjS/p8GKfMwjhGryNq/FM0A==
X-Google-Smtp-Source: APBJJlEmxr2B1/Ojr4gLrmif7s9rz5VlKR0Wk2qirCyvE9X64uEMtIu21SHlLR1c5GISKgl1mPY6og==
X-Received: by 2002:a81:6ad6:0:b0:56d:297e:7c8c with SMTP id f205-20020a816ad6000000b0056d297e7c8cmr11596679ywc.8.1688977104427;
        Mon, 10 Jul 2023 01:18:24 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id x142-20020a81a094000000b00565de196516sm2946126ywg.32.2023.07.10.01.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 01:18:23 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so5205505276.0;
        Mon, 10 Jul 2023 01:18:23 -0700 (PDT)
X-Received: by 2002:a5b:c82:0:b0:c1a:5904:fe8e with SMTP id
 i2-20020a5b0c82000000b00c1a5904fe8emr5592978ybq.34.1688977103757; Mon, 10 Jul
 2023 01:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <2c99d5df41c40691f6c407b7b6a040d406bc81ac.1688901306.git.geert+renesas@glider.be>
 <6af51602-631a-dadc-2740-d1cfad0a2993@roeck-us.net> <CAMuHMdW=WDuqgXk_51T341vgXrcxYPO34ou=rKHZrZj8Yiw6Rw@mail.gmail.com>
 <f27872c8f374a42fb7ea313314c47cdba2473b06.camel@physik.fu-berlin.de>
 <CAMuHMdXg1FvMCSBCvs=aFah0NWdOzEX+XdF4af0kY3kNx2bPtg@mail.gmail.com> <e44bc98f41e0497a3f125a32a6e78fe14313c634.camel@physik.fu-berlin.de>
In-Reply-To: <e44bc98f41e0497a3f125a32a6e78fe14313c634.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Jul 2023 10:18:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUOOPvVM-evLptCnbNGpDtAxktY7QDuKQo7WmZ7RhrAFg@mail.gmail.com>
Message-ID: <CAMuHMdUOOPvVM-evLptCnbNGpDtAxktY7QDuKQo7WmZ7RhrAFg@mail.gmail.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 9:57 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Mon, 2023-07-10 at 09:54 +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 10, 2023 at 9:44 AM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > On Mon, 2023-07-10 at 09:03 +0200, Geert Uytterhoeven wrote:
> > > > Indeed, I hadn't tested that.
> > > > My current tree isn't based on linux-next, but did have a build
> > > > failure in the cdrom code, for which I had found your fix (thanks!) in
> > > > linux-next...
> > >
> > > So, there is a patch for this already? Is it going to be included for 6.5?
> >
> > The cdrom fix is commit a587b046ce921cc1 ("cdrom/gdrom: Fix build
> > error") in v6.5-rc1, which builds dreamcast_defconfig fine.
> >
> > That config is still broken in linux-next, but the breakage hasn't\
> > entered v6.5-rc1 (yet?).
>
> OK, so we're talking about two different regressions here?

Yes.

https://lore.kernel.org/r/CAMuHMdWmv-Jdvi7a04JGXuA2QARj8c8mpUvY7TOcetPkG4pW7A@mail.gmail.com

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
