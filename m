Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CBEC68767C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 08:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBBHk2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Feb 2023 02:40:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjBBHk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 02:40:27 -0500
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9826E43A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 23:40:25 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id w3so1018736qts.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 23:40:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/dOyD+nKydNQSqaR3rqEtJ2OYtDR0EOri4dn+km/NnM=;
        b=GN3w0nQfqofmD5GlLuqzLpnabc+B+Tl6eqyke/yi40Ys/YspOHcHqmpOuV+tzWEUFw
         wN98XsBpqx1awwc6PLHZTr+aOmrT119s400SuPqEXoIQmI+Bf7oFxOSlilQNgDWX40eq
         hxA9EoqpxK8p5CAK6ZrDrm7mhiVDdWOw9zD1oei0PSo7xbQMMuTuuugPySTRAWuODLvi
         mL6z585PmxP+XlwcIFe9Uj/UMZS+iHLOchY77cz+oDSCfOH2tohv2CL5PGtTB9sU6DWN
         Z1UEaPKGBmlGscbJLg6yTIz8hrn15bN6DApJyIuT9OtNWIbrfLFBq3QkPR/imz+lHe5o
         4j4w==
X-Gm-Message-State: AO0yUKWY+TQNwW0tMp/AI04dd4XEmUoYxJ+D3ROuSYpXFMtF2mIs3+EU
        juDF6TXBZ0eidP5UagnTWWzIPDEFm/uEwg==
X-Google-Smtp-Source: AK7set/gIJg+gaUCD9rQJ2mook9FCKaJOhrmJi3xm1KVU+3TDH6jfMczyGUdaaCJagnCzspxBqfaTA==
X-Received: by 2002:ac8:57d6:0:b0:3b8:6cd5:eda with SMTP id w22-20020ac857d6000000b003b86cd50edamr10789905qta.47.1675323624786;
        Wed, 01 Feb 2023 23:40:24 -0800 (PST)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id w21-20020a05620a129500b0071d3e432c9bsm9003837qki.28.2023.02.01.23.40.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 23:40:24 -0800 (PST)
Received: by mail-yb1-f178.google.com with SMTP id g2so1109815ybk.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 23:40:24 -0800 (PST)
X-Received: by 2002:a25:820a:0:b0:7d5:b884:3617 with SMTP id
 q10-20020a25820a000000b007d5b8843617mr613199ybk.380.1675323623815; Wed, 01
 Feb 2023 23:40:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
 <20221101170015.GA1314742@roeck-us.net> <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
 <20221101183717.GB1328619@roeck-us.net>
In-Reply-To: <20221101183717.GB1328619@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Feb 2023 08:40:12 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVGDmRQvb2FSC5SxjxyuUhZCBkVN5Z2QU6FN2P49c-3aQ@mail.gmail.com>
Message-ID: <CAMuHMdVGDmRQvb2FSC5SxjxyuUhZCBkVN5Z2QU6FN2P49c-3aQ@mail.gmail.com>
Subject: Re: Linux 6.1-rc3
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Günter,

On Tue, Nov 1, 2022 at 8:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
> On Tue, Nov 01, 2022 at 10:29:01AM -0700, Linus Torvalds wrote:
> > [ Adding Arnd and Masahiro in case they remember what the secret sauce
> > for finding those cases was ]
> >
> > On Tue, Nov 1, 2022 at 10:00 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > >
> > > There is one spurious build error. It does not happen all the time,
> > > and even on the same SHA it is not easy to reproduce. If I see it,
> > > I may see it on one server reliably but not at all on another with
> > > almost the same hardware configuration.
> > >
> > > Building powerpc:allnoconfig ... failed
> > > --------------
> > > Error log:
> > > Inconsistent kallsyms data
> > > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> >
> > The random "Inconsistent kallsyms data" issue is something that we've
> > had for over a decade.
>
> I know. Difference this time around, at least for me, is that the
> table is oscillating and never converges. Another difference is that

Yeah, I remember the number of retries was increased to "help"
with this...

> it looks like the problem was introduced by a change in how the table
> is created, not by a change in the code or the compiler/linker.
> I do have a patch that lets me run as many extra passes as I want,
> but that doesn't help if the table never converges.

Kisskb has been reporting this on-and-off for sun3_defconfig/m68k-gcc11
since Jan 25th:
http://kisskb.ellerman.id.au/kisskb/target/192141/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
