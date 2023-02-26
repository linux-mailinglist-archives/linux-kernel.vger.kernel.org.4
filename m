Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179106A3395
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBZTXR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:23:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBZTXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:23:15 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F15A24F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:23:13 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ck15so17723588edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 11:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbQyXtJLfRv0Q9GivC5bqVQS8/nMln8gSjbi3txdErA=;
        b=fm3vHIaWK9rL2C8TZFa5QqvhZR2O/3RhNA0r6oCs8csV7XGPLgSQFt9ibl3reauPWi
         SBqGiQJBNQeUlgwOnBve4SswW2VQ/NwEOPNQKlniv+12R6SmayFKy77HVX6Wx3YdRFat
         3hK2T4vfyyid+dJcWomQADp0YuMk5/b8goYjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JbQyXtJLfRv0Q9GivC5bqVQS8/nMln8gSjbi3txdErA=;
        b=PGlWFoO2VwHVl8/kuOuFlWwKKu7CbRp+wP6S2G4WoeueuuvLD4fcZUYbflJ8StOitw
         Z0kDODKzTpxe3tO5SXdKq6olDr2M3J5o3TS5Sc3hW4twyqyxIt25Psj+lI/sflbm5Mly
         zW+MMPWp+BCJq0l42d+SfZmHvJhflRZXkqpFOD48tOLholZ4i2zitfMCoibSiViBAE6i
         FCHipSKc17umG9E9HYpVGI1HdAnbzc0xd4NMINsU7mjhNnUYbs1tPk0Mmce+kLdoAM6o
         2uPGVWeb2PM9S9gaLtLp557GWEzlOMkJn9u4PvbuavedKMGQrrUNs3nDAGB0oKrIuNh1
         yk3A==
X-Gm-Message-State: AO0yUKUFT2su6SrMUgKCGICvs8VuXBQW2mUGTBshTQtDx6E+C9sgXc2c
        jQylDiMQ3Qr6mF4rgOGSULgymKF5hiZbjX1wPf+L8A==
X-Google-Smtp-Source: AK7set/RhwZg1mGnUrtO8vTDV+3E59Fa0S9rB6M6ZFt/xs7ANgfdvtdHveeXag1MaNbSvLSB7Vh/B6s4NuQCz3G3GlQ=
X-Received: by 2002:a17:907:bb89:b0:8b1:2916:9804 with SMTP id
 xo9-20020a170907bb8900b008b129169804mr13789290ejc.9.1677439392099; Sun, 26
 Feb 2023 11:23:12 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
 <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
 <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
 <Y/twXr2IOM4Dua8J@bill-the-cat> <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
In-Reply-To: <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Sun, 26 Feb 2023 12:23:00 -0700
Message-ID: <CAPnjgZ2hcKnzzAyy4m44L1hQ_wYbCq-3ZX0g57bvVdYjyPPL_g@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Sun, 26 Feb 2023 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sun, Feb 26, 2023 at 11:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wr=
ote:
> >
> > On Sun, Feb 26, 2023 at 11:32:03PM +0900, Masahiro Yamada wrote:
> > > On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chromium.or=
g> wrote:
> > > >
> > > > Hi Masahiro,
> > > >
> > > > On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kernel.org=
> wrote:
> > > > >
> > > > > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > >
> > > > > > +Masahiro Yamada
> > > > >
> > > > >
> > > > >
> > > > >
> > > > > I do not know.
> > > > > This seems a shorthand in Kconfig level.
> > > > >
> > > > >
> > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
> > > > >     540    1080   24872
> > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
> > > > >     163     326    7462
> > > > >
> > > > > If hundreds of duplications are not manageable,
> > > > > go for it, but kconfig will be out-of-sync from the
> > > > > upstream Kconfig.
> > > >
> > > > Yes that's right, it is a shorthand in Kconfig.
> > > >
> > > > The counts above understand the problem a little since quite a few
> > > > CONFIG options without an SPL prefix are used in SPL. We don't have
> > > > tools to estimate how many, and we sometimes add a new symbol to 'g=
ain
> > > > control' of a particular feature in a phase.
> > > >
> > > > My intent in sending this patch was to check whether this support f=
or
> > > > configuring multiple related builds (or something like it) could go
> > > > upstream, which for Kconfig is Linux, I believe. What do you think?
> > >
> > >
> > > This complexity is absolutely unneeded for Linux.
> > >
> > > So, the answer is no.
> >
> > Well, I think Simon summarized himself a bit shorter here than he did i=
n
> > the patch itself.  So, to what extent does the kernel want to consider
> > all of the other projects using the Kconfig language and their needs /
> > use cases?
> >
> > --
> > Tom
>
>
>
> In principle, only features that are useful for Linux.

I'm disappointed in this attitude. It is the same thing that we saw
from the DT bindings until recently.

>
> Kconfig has small piece of code that is useful for other projects,
> for example,
>
>     #ifndef CONFIG_
>     #define CONFIG_ "CONFIG_"
>     #endif
>
> which might be useful for Buildroot, but this is exceptionally small.

How about refactoring patches that would make a possible
implementation easier to maintain, like [1] ? Would they be
acceptable?

>
>
> The multi-phase is too cluttered, and that is not what Linux wants to hav=
e.

Clearly it is not useful to Linux, which only has one build.

Regards,
Simon

[1] https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.1134219=
-61-sjg@chromium.org/
