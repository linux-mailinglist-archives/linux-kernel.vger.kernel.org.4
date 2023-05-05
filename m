Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1646F7C39
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjEEFOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEEFOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:14:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB24D9005;
        Thu,  4 May 2023 22:14:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B21163AEB;
        Fri,  5 May 2023 05:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41D8C4339E;
        Fri,  5 May 2023 05:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683263657;
        bh=d0ANg4G4/eCsbU4DJVo5bdh0nxpbJnnl6hG/u6KVZE8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XQ0cZ8tnrBD4Io+lEeZX7y9NWe0Gev9ptiv5YaXI1N5SgGxiAm8xrzQVP6soJ5fR/
         +OJTHuK4oOzK3+xJuNodce0Glkn2wmp8aR04W/tZc2gBqhfnMISZkwDJQBzu4bOnr9
         uyv7mCbAVsF8DfdMK5uinqhY7UDVA51RRzXbpEu+OSSLO4peVh+exsD6PkXS+fLEDw
         B4dg4wsXOwWdSEGrP+bSUOG9ifTZ7GfNBPpvdwwbki1z0HhdRAyiXGtw4JN/lSJxNt
         jV/+C8yYQFHbY8l1Lo1o0mPFcg1StH8ytrz+cSFIiS68W84eFeU9nmn/COxQ20FZCf
         80x6pmEPrROcg==
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3908c252609so767089b6e.1;
        Thu, 04 May 2023 22:14:17 -0700 (PDT)
X-Gm-Message-State: AC+VfDzY5CCek4FDyPcj7qXDMVbht5yfiVni9D9wGji1cjcenc+3RR0h
        Y+4jCh1X2DbJpTy1Kzv++FxaKS4jcaikUr48JFI=
X-Google-Smtp-Source: ACHHUZ4+9/CYdDw3khEe1rSQpL8uT9KZw1Hz3fZWiUeebPNrHDI3kWFDM9gq2Ac5kBIOss6VirJ7VBFRci+RECGnTGk=
X-Received: by 2002:a05:6808:243:b0:38e:2d19:5144 with SMTP id
 m3-20020a056808024300b0038e2d195144mr2524044oie.53.1683263656915; Thu, 04 May
 2023 22:14:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230504201833.202494-1-darwi@linutronix.de> <20230504201833.202494-2-darwi@linutronix.de>
 <20230504213246.GB1666363@dev-arch.thelio-3990X> <ZFQrD3qKIMGjI9Zd@lx-t490>
In-Reply-To: <ZFQrD3qKIMGjI9Zd@lx-t490>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 5 May 2023 07:13:40 +0200
X-Gmail-Original-Message-ID: <CAK7LNAQO2dLL8G2BxK_NPD2YG35nh90_9VFeTi+OFHQrn0YHvg@mail.gmail.com>
Message-ID: <CAK7LNAQO2dLL8G2BxK_NPD2YG35nh90_9VFeTi+OFHQrn0YHvg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] scripts/tags.sh: Fix gtags generation for O=
 kernel builds
To:     "Ahmed S. Darwish" <darwi@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 5, 2023 at 12:00=E2=80=AFAM Ahmed S. Darwish <darwi@linutronix.=
de> wrote:
>
> Hi Nathan,
>
> On Thu, 04 May 2023, Nathan Chancellor wrote:
> >
> > On Thu, May 04, 2023 at 10:18:33PM +0200, Ahmed S. Darwish wrote:
> ...
> > > +   suffixparams=3D
> > > +   if [ -v O ]; then
> >
> > I think
> >
> >   if [ -n "$O" ]; then
> >
> > would match the style preferred by Kbuild (though that is usually for
> > portability sake, which probably does not matter here since bash is
> > explicitly requested). Perhaps not worth addressing if there is no othe=
r
> > reason for a v2.
> >
>
> Thanks, I'll do it. I've just discovered that a v2 is necessary anyway.
>
> If O=3D has a "~", for example as in:
>
>     make O=3D~/build/ gtags
>
> the snippet below:
>
> > > +           suffixparams=3D"-C $tree $O"
> > > +   fi
> > > +   all_target_sources | gtags -i -f - $suffixparams
>                                            ^
> will fail since the "~" in the O=3D directory path won't get dereferenced
> before getting passed to the gtags call (an eval is needed).
>
> I'll submit a v2 shortly.
>
> Kind regards,
>
> --
> Ahmed S. Darwish
> Linutronix GmbH



It is wrong to check whether you are building out of the
source tree.  See line 159 of the Makefile.

BTW, this patch does not work for me.
It spits a ton of "not found" warnings, then generates
empty tags.


$ make O=3Dbuild gtags
make[1]: Entering directory '/home/masahiro/ref/linux/build'
  GEN     gtags
Warning: '../arch/x86/include/asm/vmalloc.h' not found. ignored.
Warning: '../arch/x86/include/asm/pgtable-3level_types.h' not found. ignore=
d.
Warning: '../arch/x86/include/asm/paravirt.h' not found. ignored.
Warning: '../arch/x86/include/asm/text-patching.h' not found. ignored.
Warning: '../arch/x86/include/asm/softirq_stack.h' not found. ignored.
Warning: '../arch/x86/include/asm/intel_ds.h' not found. ignored.
Warning: '../arch/x86/include/asm/resctrl.h' not found. ignored.
Warning: '../arch/x86/include/asm/setup_arch.h' not found. ignored.
Warning: '../arch/x86/include/asm/simd.h' not found. ignored.
Warning: '../arch/x86/include/asm/mmconfig.h' not found. ignored.
Warning: '../arch/x86/include/asm/pgtable_types.h' not found. ignored.
Warning: '../arch/x86/include/asm/mem_encrypt.h' not found. ignored.
Warning: '../arch/x86/include/asm/dmi.h' not found. ignored.
Warning: '../arch/x86/include/asm/thermal.h' not found. ignored.

    ...













--=20
Best Regards
Masahiro Yamada
