Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 447B9623068
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 17:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiKIQpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 11:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiKIQpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 11:45:52 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D5720192;
        Wed,  9 Nov 2022 08:45:50 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id g10so11264443qkl.6;
        Wed, 09 Nov 2022 08:45:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ews1zWN1f/PR7HGzfMn+lenNKSw7QezbzurfTC9dGEg=;
        b=apbFbK+ZvFrjpyNcG/vYCTOZt6lminw1qidkUzeyiP68XQaofoPRYlYFHHEyoEQfS6
         y0lLs1HkdjhUyrMLL5Hl/B8GppRpNxri00FEvHonXUhPu6aTPUJ8rnMwgJBtGwtsfIbh
         RygX2m2a9xCSVTXVF2AHwZQ4vwWcwPH4+U1gEy7FIrZJhIxtDm5fJlLdmN3oWCOde9x+
         jGTP2c/fFnYodPZpK7k3Ho9JtdjzNMe88MMUDX1GuRt9H53tgPCRTH1Yof7lnWMllndK
         jN3M1PASUyOmMcEteamHUnzKNga+7gmwdbAeSv7kNrHuzPN89HoP/b5oTa5zONV72zlQ
         VekQ==
X-Gm-Message-State: ACrzQf2flUe35U6flHzHmy7L66sut6u64sojxfDdIUoRXdzX4uh6G7TC
        MdCgmwlEEg0YT0xqZEaium+HyqNsdCC9jA==
X-Google-Smtp-Source: AMsMyM4QxDsCw1/qOPm33WtMZLh9CHhwxr+FjF3wLiaFkIs2IjoB4fqI4ZbOGyLB7X0MGzI8pJTuYA==
X-Received: by 2002:a37:e218:0:b0:6fa:28b1:6a84 with SMTP id g24-20020a37e218000000b006fa28b16a84mr26174203qki.536.1668012349140;
        Wed, 09 Nov 2022 08:45:49 -0800 (PST)
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com. [209.85.219.176])
        by smtp.gmail.com with ESMTPSA id ey26-20020a05622a4c1a00b003a4ec43f2b5sm9951181qtb.72.2022.11.09.08.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 08:45:46 -0800 (PST)
Received: by mail-yb1-f176.google.com with SMTP id 7so17112752ybp.13;
        Wed, 09 Nov 2022 08:45:44 -0800 (PST)
X-Received: by 2002:a05:6902:503:b0:6cf:c510:6a23 with SMTP id
 x3-20020a056902050300b006cfc5106a23mr40745720ybs.380.1668012343710; Wed, 09
 Nov 2022 08:45:43 -0800 (PST)
MIME-Version: 1.0
References: <b35c3f82-f67b-2103-7d82-7a7ba7521439@suse.cz> <CA+CK2bD-uVGJ0=9uc7Lt5zwY+2PM2RTcfOhxEd65S7TvTrJULA@mail.gmail.com>
 <87187c52-ae48-130b-6479-ae1023915bc1@suse.cz> <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
In-Reply-To: <20221109155008.GC307514@darkstar.musicnaut.iki.fi>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Nov 2022 17:45:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXY7z+BXjM1KNVF9AKw0n28Fe-8TDbRC=WKXZf09h6G+w@mail.gmail.com>
Message-ID: <CAMuHMdXY7z+BXjM1KNVF9AKw0n28Fe-8TDbRC=WKXZf09h6G+w@mail.gmail.com>
Subject: Re: Deprecating and removing SLOB
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rustam Kovhaev <rkovhaev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Shiyan <shc_work@mail.ru>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        openrisc@lists.librecores.org, linux-riscv@lists.infradead.org,
        linux-sh@vger.kernel.org
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

On Wed, Nov 9, 2022 at 4:53 PM Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> On Wed, Nov 09, 2022 at 10:00:25AM +0100, Vlastimil Babka wrote:
> > > On Tue, Nov 8, 2022 at 10:55 AM Vlastimil Babka <vbabka@suse.cz> wrote:
> > >> I believe SLOB can be removed because:
> > >>
> > >> - AFAIK nobody really uses it? It strives for minimal memory footprint
> > >> by putting all objects together, which has its CPU performance costs
> > >> (locking, lack of percpu caching, searching for free space...). I'm not
> > >> aware of any "tiny linux" deployment that opts for this. For example,
> > >> OpenWRT seems to use SLUB and the devices these days have e.g. 128MB
> > >> RAM, not up to 16 MB anymore. I've heard anecdotes that the performance
> > >> SLOB impact is too much for those who tried. Googling for
> > >> "CONFIG_SLOB=y" yielded nothing useful.
> > >
> > > I am all for removing SLOB.
> > >
> > > There are some devices with configs where SLOB is enabled by default.
> > > Perhaps, the owners/maintainers of those devices/configs should be
> > > included into this thread:
>
> [...]
>
> > > arch/arm/configs/omap1_defconfig:CONFIG_SLOB=y
>
> I have been using SLUB on my OMAP1 boards with 32 MB RAM, because of
> better debugging features and the memory footprint difference doesn't
> really matter for my use cases. Looking at history why SLOB was added
> there, it seems it came from 6cfce27c14aa ("omap1: Add omap1_defconfig")
> when separate boards configs were merged, and SX1 board happened to have
> SLOB in there. This board is nowadays only used in QEMU anyway.
>
> There are OMAP1 boards with only 16 MB, but support for those boards
> will be removed. So from OMAP1 side, I don't think there is any real
> need for SLOB anymore.

Interestingly, the m68k defconfigs use either SLAB, or the default (SLUB).
So the poor old m68k machines (many of which have less than 32 MiB)
seem to do fine without SLOB...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
