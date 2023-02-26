Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50E676A2FF3
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 15:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBZOct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 09:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBZOcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 09:32:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61D5FF13
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:32:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 599EDB8068F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29ABC433EF
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 14:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677421960;
        bh=u8fZxYTy+TV5Tng+6oGHUX0OGGABJchb8xhFiO+9v3Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=fIUdk1Ms/oEUuBirrQeng1vv4JdlfTklrE+xQ0BiKMnp8vdAAQww1dKowrO25Hf6Q
         GpYiHEi8Ys37IaQ5CzNc/Oj8WC8aBfIL34v7DGrWExruz/D980SAdP1qBB9iwFHWB1
         Ziy8xDzDBK8Jy+9G2ZGFLEUhay655vQiRTvV/2C+A+0wS6IeDlf7tsTZJRR4MqhlUl
         7GFnRKP8uNfZAjJhGoT1Bj3q2lyHBKHdUdhY72Y0tnTiuikWPscIqoUPC152oFyuDp
         hwSKa/Z0fTWoTLFV7bf0a+W8lEzZ7nX+Qi40TxXsiHRlD4GNCJKtIk/8ABoIW0Lf+I
         F42cWrzyMiayg==
Received: by mail-ot1-f46.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso2234284ots.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 06:32:40 -0800 (PST)
X-Gm-Message-State: AO0yUKU7Tl5tErg+uifp3Id/bXBAG4wyGPXxk357KBaazIf3GpS+pFVz
        TLy1bmrcbjV9p+IVoVPNfgBEs7wSiCAr7pT3DAY=
X-Google-Smtp-Source: AK7set8QW2oShYele6YB+kR9ceyvZxC7FfiPFh/e1zxKIR6HUiKF6MLSuG1O5uzvFmOv/dRtY3wsuDApN8hR2XZzdMg=
X-Received: by 2002:a05:6830:39f4:b0:690:f4b3:2e30 with SMTP id
 bt52-20020a05683039f400b00690f4b32e30mr3597649otb.1.1677421960158; Sun, 26
 Feb 2023 06:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com> <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
In-Reply-To: <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 26 Feb 2023 23:32:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
Message-ID: <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
To:     Simon Glass <sjg@chromium.org>
Cc:     U-Boot Mailing List <u-boot@lists.denx.de>,
        lk <linux-kernel@vger.kernel.org>, Tom Rini <trini@konsulko.com>
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

On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
>
> Hi Masahiro,
>
> On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > +Masahiro Yamada
> >
> >
> >
> >
> > I do not know.
> > This seems a shorthand in Kconfig level.
> >
> >
> > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
> >     540    1080   24872
> > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
> >     163     326    7462
> >
> > If hundreds of duplications are not manageable,
> > go for it, but kconfig will be out-of-sync from the
> > upstream Kconfig.
>
> Yes that's right, it is a shorthand in Kconfig.
>
> The counts above understand the problem a little since quite a few
> CONFIG options without an SPL prefix are used in SPL. We don't have
> tools to estimate how many, and we sometimes add a new symbol to 'gain
> control' of a particular feature in a phase.
>
> My intent in sending this patch was to check whether this support for
> configuring multiple related builds (or something like it) could go
> upstream, which for Kconfig is Linux, I believe. What do you think?


This complexity is absolutely unneeded for Linux.

So, the answer is no.



--=20
Best Regards
Masahiro Yamada
