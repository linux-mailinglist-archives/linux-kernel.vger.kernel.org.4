Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACCB68779B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 09:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjBBIfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 03:35:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjBBIfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 03:35:11 -0500
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48448A6F
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 00:34:30 -0800 (PST)
Received: by mail-qt1-f175.google.com with SMTP id h24so1079579qta.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:34:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kxFJxDCTHgycFS1o72xX3yPhA23a+hSu1qkujDwiqe8=;
        b=1Ayc6dbWCfYyTyMT97LFZLSkNk+JbJIKNVD6pU36fv+EC6ixxejWkcozKLcNiKZm/V
         xm6d0zAtitSSc9c37d/Zfb8+CDKssBK/fiLe2xvInIVrYrX0AyLEvxusG74znEHB5qoI
         RjZnJoDPQmS4w1HyZSV5CQGnJsaMcUQz9v77V0N1Un+PwQQt4zlkaMuMrELDq1NdgYaE
         4Y17Me4BMhQbMtBKcdRPCF/83TlJskCGgPnRvWKxd0+zwDwZJSHesxQPfJpZwFVVfYre
         Pw6r5nAudyMA7NO4YyIP7rauyZnTE77q6RAqx8W3DfRCsNaOySz1egHLVe6ffq6a9FTW
         JsMg==
X-Gm-Message-State: AO0yUKVBwzRzz9a7rKaOMre1o5T6skMCzPws5rbEmx5UMgCgIL4MUSMU
        90It36okgWH5lUhjswhCqc+8nyGfr1mDcQ==
X-Google-Smtp-Source: AK7set8weQI43rM3cTKEPdXg/CDLrpEUxso18RQZJOEA4GlwcUnch01edFqR3rHu8daeiypLKLlObA==
X-Received: by 2002:a05:622a:10d:b0:3b8:4325:7610 with SMTP id u13-20020a05622a010d00b003b843257610mr9678676qtw.67.1675326846420;
        Thu, 02 Feb 2023 00:34:06 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id 22-20020ac85616000000b003b86b5a07b3sm7170367qtr.90.2023.02.02.00.34.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 00:34:06 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-4ff1fa82bbbso16708327b3.10
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 00:34:05 -0800 (PST)
X-Received: by 2002:a81:ac17:0:b0:51d:f0a4:64dc with SMTP id
 k23-20020a81ac17000000b0051df0a464dcmr553379ywh.384.1675326845546; Thu, 02
 Feb 2023 00:34:05 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
 <20221101170015.GA1314742@roeck-us.net> <CAHk-=wi+5sRXL9fTHQRiR9zVEFDPhQceWACBG3QQ=9xoRVmR8g@mail.gmail.com>
 <20221101183717.GB1328619@roeck-us.net> <CAMuHMdVGDmRQvb2FSC5SxjxyuUhZCBkVN5Z2QU6FN2P49c-3aQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVGDmRQvb2FSC5SxjxyuUhZCBkVN5Z2QU6FN2P49c-3aQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 2 Feb 2023 09:33:54 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXfodc5UwKqe8U=xd3AxG2RFSU7st90uCLx3HwzRV6w8Q@mail.gmail.com>
Message-ID: <CAMuHMdXfodc5UwKqe8U=xd3AxG2RFSU7st90uCLx3HwzRV6w8Q@mail.gmail.com>
Subject: Re: Linux 6.1-rc3
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
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

On Thu, Feb 2, 2023 at 8:40 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Nov 1, 2022 at 8:11 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, Nov 01, 2022 at 10:29:01AM -0700, Linus Torvalds wrote:
> > > [ Adding Arnd and Masahiro in case they remember what the secret sauce
> > > for finding those cases was ]
> > >
> > > On Tue, Nov 1, 2022 at 10:00 AM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> > > > There is one spurious build error. It does not happen all the time,
> > > > and even on the same SHA it is not easy to reproduce. If I see it,
> > > > I may see it on one server reliably but not at all on another with
> > > > almost the same hardware configuration.
> > > >
> > > > Building powerpc:allnoconfig ... failed
> > > > --------------
> > > > Error log:
> > > > Inconsistent kallsyms data
> > > > Try make KALLSYMS_EXTRA_PASS=1 as a workaround
> > >
> > > The random "Inconsistent kallsyms data" issue is something that we've
> > > had for over a decade.
> >
> > I know. Difference this time around, at least for me, is that the
> > table is oscillating and never converges. Another difference is that
>
> Yeah, I remember the number of retries was increased to "help"
> with this...
>
> > it looks like the problem was introduced by a change in how the table
> > is created, not by a change in the code or the compiler/linker.
> > I do have a patch that lets me run as many extra passes as I want,
> > but that doesn't help if the table never converges.
>
> Kisskb has been reporting this on-and-off for sun3_defconfig/m68k-gcc11
> since Jan 25th:
> http://kisskb.ellerman.id.au/kisskb/target/192141/

And this is not yet detected by my scripts, hence not reported in my list
of build regressions for v6.2-rc6. Fixed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
