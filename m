Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1D86A3337
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 18:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbjBZRgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 12:36:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjBZRgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 12:36:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908CD7A89
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 09:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 291AA60C15
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 17:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927CCC433D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677433000;
        bh=n1a8rby1ahPl84c7Re/Zb3vpa+YhLOUunPlxlN/DBYU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZYUKmjesuWucukWzrADxNEGPptLaj87NwU5mMB5Ao5gKJvRt4CHpMsmDiJKXIIsTT
         RNbeqRsa1yROMyXfzXlCIWgkqEn0TWwcrsS0WdKzhYQAPQbpkdNQzOw82e3r5qGz5f
         nV0AgTCeja+O8K0AnYI1m2CvwU71SA9n8V+M2Amh8uCQKTCn3qOYV83iURK8gL0/85
         F/jf00/+D60xzXe0mfXnmBR6IOt62fDzCx0+exBBqVa/662vPJ36Hb7wxCfKqlgG5B
         fp4a/Jq0oQdYhir4/NDIcG83pgmIdkNXHYwPjVxBr9wybf+plZ5X99ALsQaSPeByoP
         YNRJDZFBvr80g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1729bdcca99so5254184fac.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 09:36:40 -0800 (PST)
X-Gm-Message-State: AO0yUKXM8gyNCPBz0GtAl7xJ9RmUu5cblXagQAx0cH6yVAfY19ZTG25e
        0tehRByI5X8AWslJqse8D/QWO7tOd0HrWnVuytk=
X-Google-Smtp-Source: AK7set8E2xuI1YQeo23avnbztAxsN6wpEPvMt7rOBIiSXShy7erVxe7kCcP8lnTzps/+PNigP9S5UiaTWDDBTwNJ8j0=
X-Received: by 2002:a05:6870:5302:b0:16e:8b45:1e0d with SMTP id
 j2-20020a056870530200b0016e8b451e0dmr2769595oan.8.1677432999881; Sun, 26 Feb
 2023 09:36:39 -0800 (PST)
MIME-Version: 1.0
References: <20230219145453.1.Idaaf79c3e768b85750d5a7eb732052576c5e07e5@changeid>
 <CAPnjgZ0BxS3CHKzofGE1SbAZouhMakAU_KUmfpy_OmJTkzyhSA@mail.gmail.com>
 <CAPnjgZ3xpoJ33fgSG589E+xoUk4-dVbhwadfo+sd=hxqF-z0Vg@mail.gmail.com>
 <CAK7LNAT=tmXdJahjdXBrj8ASmEDhdeeqbXfSdyXCzkJZgix+Hg@mail.gmail.com>
 <CAPnjgZ0r431WyRgZH=37_OQ_L9UgzYB+GmSk=a6g4UUe_5t0sw@mail.gmail.com>
 <CAK7LNARpzPqt76vGeu6c14cHaf2=UU0o8H4HrM-NKQYc-19qjQ@mail.gmail.com> <Y/twXr2IOM4Dua8J@bill-the-cat>
In-Reply-To: <Y/twXr2IOM4Dua8J@bill-the-cat>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Feb 2023 02:36:02 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
Message-ID: <CAK7LNAQyDnDiL4iY31Z82aWi-e-eiTdOqdsf3qzQ8f9dJTYwJQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: Proposed language extension for multiple builds
To:     Tom Rini <trini@konsulko.com>
Cc:     Simon Glass <sjg@chromium.org>,
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

On Sun, Feb 26, 2023 at 11:44=E2=80=AFPM Tom Rini <trini@konsulko.com> wrot=
e:
>
> On Sun, Feb 26, 2023 at 11:32:03PM +0900, Masahiro Yamada wrote:
> > On Sun, Feb 26, 2023 at 11:04=E2=80=AFPM Simon Glass <sjg@chromium.org>=
 wrote:
> > >
> > > Hi Masahiro,
> > >
> > > On Sat, 25 Feb 2023 at 20:31, Masahiro Yamada <masahiroy@kernel.org> =
wrote:
> > > >
> > > > On Sat, Feb 25, 2023 at 11:38=E2=80=AFAM Simon Glass <sjg@chromium.=
org> wrote:
> > > > >
> > > > > +Masahiro Yamada
> > > >
> > > >
> > > >
> > > >
> > > > I do not know.
> > > > This seems a shorthand in Kconfig level.
> > > >
> > > >
> > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config SPL_' | wc
> > > >     540    1080   24872
> > > > masahiro@zoe:~/ref/u-boot(master)$ rgrep '^config TPL_' | wc
> > > >     163     326    7462
> > > >
> > > > If hundreds of duplications are not manageable,
> > > > go for it, but kconfig will be out-of-sync from the
> > > > upstream Kconfig.
> > >
> > > Yes that's right, it is a shorthand in Kconfig.
> > >
> > > The counts above understand the problem a little since quite a few
> > > CONFIG options without an SPL prefix are used in SPL. We don't have
> > > tools to estimate how many, and we sometimes add a new symbol to 'gai=
n
> > > control' of a particular feature in a phase.
> > >
> > > My intent in sending this patch was to check whether this support for
> > > configuring multiple related builds (or something like it) could go
> > > upstream, which for Kconfig is Linux, I believe. What do you think?
> >
> >
> > This complexity is absolutely unneeded for Linux.
> >
> > So, the answer is no.
>
> Well, I think Simon summarized himself a bit shorter here than he did in
> the patch itself.  So, to what extent does the kernel want to consider
> all of the other projects using the Kconfig language and their needs /
> use cases?
>
> --
> Tom



In principle, only features that are useful for Linux.

Kconfig has small piece of code that is useful for other projects,
for example,

    #ifndef CONFIG_
    #define CONFIG_ "CONFIG_"
    #endif

which might be useful for Buildroot, but this is exceptionally small.


The multi-phase is too cluttered, and that is not what Linux wants to have.




--=20
Best Regards
Masahiro Yamada
