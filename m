Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9686A39C0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 04:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjB0Dga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 22:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjB0Dg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 22:36:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AECD6580
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:36:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BDAEB80909
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:36:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22B4C4339B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 03:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677468960;
        bh=mCO52M1BKUtHu+e9+VdjQ0hDoz1OhWj4BY7WIzGCwHc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aF9vwasSKeMfp/CTLmOy/bucEyZ8Lfb8+C+bBFHidZhP5x1bkdiMzSdhW9PE3jSY6
         /JjHxFAPjZglsbdK5ZKUjMUy8pgIGMtXlV3Ua+iWCXKlarCp/l3e5ZhKXwz5zdAgFr
         XeajSQtGGfyg7ELZhoer9OLXRa7LGKrhWlPFCa/NSxaosCsFsE5fVylOe8foGwvY2V
         UdnEizteAsq63vjyFlGa7/wsny78aZ/vzc44vvkOUFUsB37gwDgDYFbgTaREZHbYEb
         IqEkSRSBJVFENrj4C6ZUxgMtUwWiMm9mZyEuDgVCmnqpbHSanLAJkowOGabCHnjVh7
         R8KPuYhb0j2Nw==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-172afa7bee2so6185938fac.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:36:00 -0800 (PST)
X-Gm-Message-State: AO0yUKVgB1fbV/sXLfpzuKI7gnCJvcQaRxttNjg8WT7iIP2w3mUv4ZcE
        aK4HMlhO2TK2mFvzuy4+Ustm0cINg1dzT6nogtA=
X-Google-Smtp-Source: AK7set9lO/dZCNyVbfXh+p3fraGimm+alF0Awgf59suzOqN6r0FVYbaP/GL2CQn5kmErOBTQRMtBQoFznP+wu1bK2Ak=
X-Received: by 2002:a05:6870:3a01:b0:171:8f59:3437 with SMTP id
 du1-20020a0568703a0100b001718f593437mr3144052oab.8.1677468959936; Sun, 26 Feb
 2023 19:35:59 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
 <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
 <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
 <Y/twXr2IOM4Dua8J@bill-the-cat> <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
 <CAPnjgZ2hcKnzzAyy4m44L1hQ_wYbCq-3ZX0g57bvVdYjyPPL_g@mail.gmail.com>
In-Reply-To: <CAPnjgZ2hcKnzzAyy4m44L1hQ_wYbCq-3ZX0g57bvVdYjyPPL_g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Feb 2023 12:35:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQpyjAVVES8dggiqcZNep1C0xkMob7HsBP4eS1jkOQbig@mail.gmail.com>
Message-ID: <CAK7LNAQpyjAVVES8dggiqcZNep1C0xkMob7HsBP4eS1jkOQbig@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
To:     Simon Glass <sjg@chromium.org>
Cc:     Tom Rini <trini@konsulko.com>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Simon,

On Mon, Feb 27, 2023 at 4:23=E2=80=AFAM Simon Glass <sjg@chromium.org> wrot=
e:
>
> Hi Masahiro,
>
> On Sun, 26 Feb 2023 at 10:36, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > On Sun, Feb 26, 2023 at 11:44=E2=80=AFPM Tom Rini <trini@konsulko.com> =
wrote:
> > >
> > > On Sun, Feb 26, 2023 at 11:32:03PM +0900, Masahiro Yamada wrote:
> > > > On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chromium.=
org> wrote:
> > > > >
> > > > > Hi Masahiro,
> > > > >
> > > > > On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
> > > > > >
> > > > > > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chrom=
ium.org> wrote:
> > > > > > >
> > > > > > > +Masahiro Yamada
> > > > > >
> > > > > >
> > > > > >
> > > > > >
> > > > > > I do not know.
> > > > > > This seems a shorthand in Kconfig level.
> > > > > >
> > > > > >
> > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
> > > > > >     540    1080   24872
> > > > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
> > > > > >     163     326    7462
> > > > > >
> > > > > > If hundreds of duplications are not manageable,
> > > > > > go for it, but kconfig will be out-of-sync from the
> > > > > > upstream Kconfig.
> > > > >
> > > > > Yes that's right, it is a shorthand in Kconfig.
> > > > >
> > > > > The counts above understand the problem a little since quite a fe=
w
> > > > > CONFIG options without an SPL prefix are used in SPL. We don't ha=
ve
> > > > > tools to estimate how many, and we sometimes add a new symbol to =
'gain
> > > > > control' of a particular feature in a phase.
> > > > >
> > > > > My intent in sending this patch was to check whether this support=
 for
> > > > > configuring multiple related builds (or something like it) could =
go
> > > > > upstream, which for Kconfig is Linux, I believe. What do you thin=
k?
> > > >
> > > >
> > > > This complexity is absolutely unneeded for Linux.
> > > >
> > > > So, the answer is no.
> > >
> > > Well, I think Simon summarized himself a bit shorter here than he did=
 in
> > > the patch itself.  So, to what extent does the kernel want to conside=
r
> > > all of the other projects using the Kconfig language and their needs =
/
> > > use cases?
> > >
> > > --
> > > Tom
> >
> >
> >
> > In principle, only features that are useful for Linux.
>
> I'm disappointed in this attitude. It is the same thing that we saw
> from the DT bindings until recently.


Sorry, but this is the maintainer's job.
Saying no is one of the most important jobs as a maintainer.

I must avoid Kconfig getting Frankenstein mechanisms.





> >
> > Kconfig has small piece of code that is useful for other projects,
> > for example,
> >
> >     #ifndef CONFIG_
> >     #define CONFIG_ "CONFIG_"
> >     #endif
> >
> > which might be useful for Buildroot, but this is exceptionally small.
>
> How about refactoring patches that would make a possible
> implementation easier to maintain, like [1] ? Would they be
> acceptable?


Code refactoring is welcome, but [1] is not applicable.
U-Boot kconfig is synced with Linux 4.20, way behind the mainline Linux.





> >
> >
> > The multi-phase is too cluttered, and that is not what Linux wants to h=
ave.
>
> Clearly it is not useful to Linux, which only has one build.
>
> Regards,
> Simon
>
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20230212231638.11342=
19-61-sjg@chromium.org/



--=20
Best Regards
Masahiro Yamada
