Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CD0692FC8
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 10:34:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBKJeI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 11 Feb 2023 04:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjBKJdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 04:33:22 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37E934F74
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 01:33:19 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id h24so8613245qtr.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 01:33:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PKCok/saWtwpL+hGwHFuOC72IH0WDl/d7SJf3JAfucA=;
        b=4mqQtM3ygfLWxioPYJIf7aFFH5QsDQ/wdLTZq61rRfCWTEfZZkjmQw5Oo024V5Td1L
         mwXXMh4x4QN26mIu4p8rU/lmDFImwv4xtq2Py1smPz1lejxqL2RsYja9UB9qw/nDGZew
         wgxbI0MCfQFrEKzx0diFP73ju9sdjolZyql0hQvsaiV20aAq1mN65jq4YGmdNQ5b7D25
         1JXwQaPS0B41OM3xCE9bjPBapKEErEbDXaG6nzm5nrAkp48yXj9fXUuNg/VlII1kDyxF
         0HLTy5SEeTRxKZnfx7DZ999WJ1RWBqRM+yCNTI257ttBqsxpRmifTofvuOUCblFZKpPJ
         ARrQ==
X-Gm-Message-State: AO0yUKWHDAjlhkInnCk8/pG6wdVv43Hp2uO8qlp3LZaFDH8P3cEdX1Vu
        IEKJsz/GeCIl/6XJWcyzFbtgXE+SAMdrJQ==
X-Google-Smtp-Source: AK7set+Pf2CKnCS4WaVCcaRupwA5Jfx+ceueKJN6hKf0zWw+Pn2IjQ4NOgBfzxoRqAa4OPYRErnI+A==
X-Received: by 2002:a05:622a:1756:b0:3ba:1ea6:d993 with SMTP id l22-20020a05622a175600b003ba1ea6d993mr28816164qtk.44.1676107998666;
        Sat, 11 Feb 2023 01:33:18 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id a191-20020ae9e8c8000000b0072396cb73cdsm5322368qkg.13.2023.02.11.01.33.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 01:33:17 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-52ee632329dso26242727b3.6
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 01:33:16 -0800 (PST)
X-Received: by 2002:a81:6ad7:0:b0:52e:ea5b:f6cb with SMTP id
 f206-20020a816ad7000000b0052eea5bf6cbmr146235ywc.237.1676107996575; Sat, 11
 Feb 2023 01:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20221103213420.1395507-1-j.neuschaefer@gmx.net>
 <CAMuHMdWo5vHCeE6BeSHrUy12uT7_wFhW-VbQmQ5u+4Q8c7-wYQ@mail.gmail.com> <Y+bpODkxY3FlCjPg@probook>
In-Reply-To: <Y+bpODkxY3FlCjPg@probook>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 11 Feb 2023 10:33:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVzbSvA=1fm1ArwsN0=vU4-Ke_J7=s=N0i9jc69=Xa0qg@mail.gmail.com>
Message-ID: <CAMuHMdVzbSvA=1fm1ArwsN0=vU4-Ke_J7=s=N0i9jc69=Xa0qg@mail.gmail.com>
Subject: Re: [PATCH v6] soc: nuvoton: Add SoC info driver for WPCM450
To:     =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     openbmc@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Hector Martin <marcan@marcan.st>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Brian Norris <briannorris@chromium.org>,
        Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sat, Feb 11, 2023 at 2:03 AM Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:
> On Fri, Feb 10, 2023 at 11:26:28AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Nov 3, 2022 at 10:37 PM Jonathan Neuschäfer
> > <j.neuschaefer@gmx.net> wrote:
> > > Add a SoC information driver for Nuvoton WPCM450 SoCs. It provides
> > > information such as the SoC revision.
> > >
> > > Usage example:
> > >
> > >   # grep . /sys/devices/soc0/*
> > >   /sys/devices/soc0/family:Nuvoton NPCM
> > >   /sys/devices/soc0/revision:A3
> > >   /sys/devices/soc0/soc_id:WPCM450
> > >
> > > Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> > > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > ---
> > > v6:
> > > - Select REGMAP
> > > - Rearrange Kconfig structure a bit
> >
> > Thanks for your patch!
> >
> > Unfortunately Joel seems to have sent v5 to Arnd instead of v6?
> > https://lore.kernel.org/all/20230201051717.1005938-1-joel@jms.id.au
> >
> > Which is now commit 7dbb4a38bff34493 ("soc:
> > nuvoton: Add SoC info driver for WPCM450") in soc/for-next...
> >
> > > --- /dev/null
> > > +++ b/drivers/soc/nuvoton/Kconfig
> > > @@ -0,0 +1,17 @@
> > > +# SPDX-License-Identifier: GPL-2.0
> > > +menu "Nuvoton SoC drivers"
> > > +       depends on ARCH_NPCM || COMPILE_TEST
> >
> > ... and lacks the above dependency, hence appearing on my radar.
> >
> > > +
> > > +config WPCM450_SOC
> > > +       tristate "Nuvoton WPCM450 SoC driver"
> > > +       default y if ARCH_WPCM450
> > > +       select SOC_BUS
> > > +       select REGMAP
> > > +       help
> > > +         Say Y here to compile the SoC information driver for Nuvoton
> > > +         WPCM450 SoCs.
> > > +
> > > +         This driver provides information such as the SoC model and
> > > +         revision.
> > > +
> > > +endmenu
> >
> > Do you plan to send a follow-up patch?
>
> Yes, hopefully I'll get around to it a few days after rc1, when the dust
> of the (upcoming) merge window has settled a bit.
>
> Or should I rather send it earlier?

I'd say sooner rather than later.
If I hadn't found your v6, I would have sent a patch myself to add the
dependency.

Does the "select REGMAP" fix a build issue? If yes, that's a very good
reason to send it now...

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
