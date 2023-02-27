Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6156A39E9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 05:00:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbjB0EA3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 23:00:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjB0EAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 23:00:23 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64773C28
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:00:06 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id f13so20380974edz.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 20:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k042TZpiV0mUEyth+8oQRVm7/TrM+U8HuMuObFQW7cU=;
        b=UErAclWpLGr/+ZkvaaTssEcl5aJnobplw8PV6bkBLpL18hO+4U1fEsTeYoFe7F+xZo
         vkrYe222dn/tH/z6PdlLcktDxC2XiGgjhLaVRiI6VXyFOCOTMveicmkDmq8+gEb+tkFi
         KqsSWU+Zkn8Sr/oSeuPrYjH1Lq5TTEycfxqfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k042TZpiV0mUEyth+8oQRVm7/TrM+U8HuMuObFQW7cU=;
        b=MLfm5F4y59CC9w+uAjNJAq01CcdX/4aX70ojD8eu3VqoqyptmsuxPYIiu1vRx9AiFM
         ZXfhXLfNXfRlusx70dOE23T2NACrxJOc6YXjJJh30sD7VijulslFVR9aWwk/oCHaeQWI
         4I77WbBA1P4jq3T7PWGKr/mD3KotUI0rT4bugHLftnBj3SLFcdUYkTFqH/Zh3PXPcb8h
         FStUWYy9Xdeui8SL75hWk2uihNawxVzMJi7FFM3eNrnaI60PRn/cJ7BEpY02z49Iy/Yz
         I/0+jZ6AvBPWKYXr50nIA5sZae8x1osNHKIi6kqsNtF8CQME2lSwGfbNkF6yGpHYee3B
         G7lA==
X-Gm-Message-State: AO0yUKVeJBQiXAFsi1WmZuVeJy7R62abndDiVzCvbZZvayFeeexo4dl3
        LnNlbb33Y5FjOJSlclq9FryTVUoxTmN+GEU95oH+uT/mIMFMCYGo
X-Google-Smtp-Source: AK7set/MY6f8nNOnUSQPlSY7KNT1XrS5i7zRU79823ZCUo5ppRRZt+58eli0G7DWJddcTmqAxLll44oMU6XRDqD3Lew=
X-Received: by 2002:a50:9fa2:0:b0:4ad:7997:a739 with SMTP id
 c31-20020a509fa2000000b004ad7997a739mr11077494edf.4.1677470405077; Sun, 26
 Feb 2023 20:00:05 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
 <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
 <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
 <Y/twXr2IOM4Dua8J@bill-the-cat> <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
 <CAPnjgZ2hcKnzzAyy4m44L1hQ_wYbCq-3ZX0g57bvVdYjyPPL_g@mail.gmail.com> <CAK7LNAQpyjAVVES8dggiqcZNep1C0xkMob7HsBP4eS1jkOQbig@mail.gmail.com>
In-Reply-To: <CAK7LNAQpyjAVVES8dggiqcZNep1C0xkMob7HsBP4eS1jkOQbig@mail.gmail.com>
From:   Simon Glass <sjg@chromium.org>
Date:   Sun, 26 Feb 2023 20:59:53 -0700
Message-ID: <CAPnjgZ2aWXjKVJdx+vCX9=rROsSoXqQzxF25+DVv97bdR3zA9w@mail.gmail.com>
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

On Sun, 26 Feb 2023 at 20:36, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Hi Simon,
>
> On Mon, Feb 27, 2023 at 4:23=E2=80=AFAM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Masahiro,
> >
> > On Sun, 26 Feb 2023 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wr=
ote:
> > >
> > > On Sun, Feb 26, 2023 at 11:44=E2=80=AFPM Tom Rini <trini@konsulko.com=
> wrote:
> > > >
> > > > On Sun, Feb 26, 2023 at 11:32:03PM +0900, Masahiro Yamada wrote:
> > > > > On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chromiu=
m.org> wrote:
> > > > > >
> > > > > > Hi Masahiro,
> > > > > >
> > > > > > On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> > > > > > >
> > > > > > > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chr=
omium.org> wrote:
> > > > > > > >
> > > > > > > > +Masahiro Yamada
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > I do not know.
> > > > > > > This seems a shorthand in Kconfig level.
> > > > > > >
> > > > > > >
> > > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
> > > > > > >     540    1080   24872
> > > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
> > > > > > >     163     326    7462
> > > > > > >
> > > > > > > If hundreds of duplications are not manageable,
> > > > > > > go for it, but kconfig will be out-of-sync from the
> > > > > > > upstream Kconfig.
> > > > > >
> > > > > > Yes that's right, it is a shorthand in Kconfig.
> > > > > >
> > > > > > The counts above understand the problem a little since quite a =
few
> > > > > > CONFIG options without an SPL prefix are used in SPL. We don't =
have
> > > > > > tools to estimate how many, and we sometimes add a new symbol t=
o 'gain
> > > > > > control' of a particular feature in a phase.
> > > > > >
> > > > > > My intent in sending this patch was to check whether this suppo=
rt for
> > > > > > configuring multiple related builds (or something like it) coul=
d go
> > > > > > upstream, which for Kconfig is Linux, I believe. What do you th=
ink?
> > > > >
> > > > >
> > > > > This complexity is absolutely unneeded for Linux.
> > > > >
> > > > > So, the answer is no.
> > > >
> > > > Well, I think Simon summarized himself a bit shorter here than he d=
id in
> > > > the patch itself.  So, to what extent does the kernel want to consi=
der
> > > > all of the other projects using the Kconfig language and their need=
s /
> > > > use cases?
> > > >
> > > > --
> > > > Tom
> > >
> > >
> > >
> > > In principle, only features that are useful for Linux.
> >
> > I'm disappointed in this attitude. It is the same thing that we saw
> > from the DT bindings until recently.
>
>
> Sorry, but this is the maintainer's job.
> Saying no is one of the most important jobs as a maintainer.
>
> I must avoid Kconfig getting Frankenstein mechanisms.

Can you suggest a better approach?

> > >
> > > Kconfig has small piece of code that is useful for other projects,
> > > for example,
> > >
> > >     #ifndef CONFIG_
> > >     #define CONFIG_ "CONFIG_"
> > >     #endif
> > >
> > > which might be useful for Buildroot, but this is exceptionally small.
> >
> > How about refactoring patches that would make a possible
> > implementation easier to maintain, like [1] ? Would they be
> > acceptable?
>
>
> Code refactoring is welcome, but [1] is not applicable.
> U-Boot kconfig is synced with Linux 4.20, way behind the mainline Linux.

Sure, I wasn't suggesting that exact patch. It should be easy enough
to move to the latest version. It sounds like it may be possible to
make the Frankenstein patches easier to maintain out of tree, if we go
that way.

> > >
> > >
> > > The multi-phase is too cluttered, and that is not what Linux wants to=
 have.
> >
> > Clearly it is not useful to Linux, which only has one build.
> >
> > [1] https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.113=
4219-61-sjg@chromium.org/

Regards,
Simon
