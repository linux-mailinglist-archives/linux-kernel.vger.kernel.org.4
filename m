Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 996A16F7C43
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 07:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjEEFSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 01:18:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjEEFSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 01:18:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0783B1FF2;
        Thu,  4 May 2023 22:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 991286306A;
        Fri,  5 May 2023 05:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03808C4339C;
        Fri,  5 May 2023 05:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683263892;
        bh=UAzL7DSODl4FqobVHMlVfbXXRF2I0C+oR1iyvhr3nnY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=s6IwPlfauVV9e6G12bEUgt+f/Xa1LmHlQTJ6dfaV9QsUzjZWJRQmtNV1OmmcE/KjF
         qPnJrcUY76e54ioWf44fBJ0EqAggp9/sOCYE01gM1AbHDbQd+aRFn2AaMe6yBemiKB
         u46ItNsMqlpaM83Siiexj0/nVlpuUVE0+RbwSf3QzpSDPeoPLTAX5A9WI1HMMvqIxC
         dwLK6sEcWygE5jf55RO6kpYijt6TrybTyx7Fcw6JYYAaeVYXQ3qPY+n8haiJEDHVph
         OF3HK2cm3/3nI1X++Raef2ZJ5G7to7sScmtXJcnCtkyp8H/Rdts0z5H8gHYCypejGN
         eGmXQWoypjNcg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-547299bf5d8so697240eaf.3;
        Thu, 04 May 2023 22:18:11 -0700 (PDT)
X-Gm-Message-State: AC+VfDykw7f44wiqJCo14bE4HlD01hEGiuF7RJjyA2SgGeNgYKndoqr5
        8V4D5zRJf36zm3KH1V62RYLbpeGRPtTY1CG2u88=
X-Google-Smtp-Source: ACHHUZ7wB160UBY4vnX1tC2cmpTgoO8cfxtYfPlSVSED/Mn5la82kMxICHfBMcd5/88pPmAB6PAqgsu5n71jKy4Md9o=
X-Received: by 2002:aca:220b:0:b0:38b:cea7:cd09 with SMTP id
 b11-20020aca220b000000b0038bcea7cd09mr37790oic.15.1683263891333; Thu, 04 May
 2023 22:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230504201833.202494-1-darwi@linutronix.de> <20230504201833.202494-2-darwi@linutronix.de>
 <20230504213246.GB1666363@dev-arch.thelio-3990X> <ZFQrD3qKIMGjI9Zd@lx-t490> <CAK7LNAQO2dLL8G2BxK_NPD2YG35nh90_9VFeTi+OFHQrn0YHvg@mail.gmail.com>
In-Reply-To: <CAK7LNAQO2dLL8G2BxK_NPD2YG35nh90_9VFeTi+OFHQrn0YHvg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 5 May 2023 07:17:35 +0200
X-Gmail-Original-Message-ID: <CAK7LNASBSawV+UdT7TDZ0G_RE536H8=b3rQkY_gKZT92JeyA_g@mail.gmail.com>
Message-ID: <CAK7LNASBSawV+UdT7TDZ0G_RE536H8=b3rQkY_gKZT92JeyA_g@mail.gmail.com>
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

On Fri, May 5, 2023 at 7:13=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> On Fri, May 5, 2023 at 12:00=E2=80=AFAM Ahmed S. Darwish <darwi@linutroni=
x.de> wrote:
> >
> > Hi Nathan,
> >
> > On Thu, 04 May 2023, Nathan Chancellor wrote:
> > >
> > > On Thu, May 04, 2023 at 10:18:33PM +0200, Ahmed S. Darwish wrote:
> > ...
> > > > +   suffixparams=3D
> > > > +   if [ -v O ]; then
> > >
> > > I think
> > >
> > >   if [ -n "$O" ]; then
> > >
> > > would match the style preferred by Kbuild (though that is usually for
> > > portability sake, which probably does not matter here since bash is
> > > explicitly requested). Perhaps not worth addressing if there is no ot=
her
> > > reason for a v2.
> > >
> >
> > Thanks, I'll do it. I've just discovered that a v2 is necessary anyway.
> >
> > If O=3D has a "~", for example as in:
> >
> >     make O=3D~/build/ gtags
> >
> > the snippet below:
> >
> > > > +           suffixparams=3D"-C $tree $O"
> > > > +   fi
> > > > +   all_target_sources | gtags -i -f - $suffixparams
> >                                            ^
> > will fail since the "~" in the O=3D directory path won't get dereferenc=
ed
> > before getting passed to the gtags call (an eval is needed).
> >
> > I'll submit a v2 shortly.
> >
> > Kind regards,
> >
> > --
> > Ahmed S. Darwish
> > Linutronix GmbH
>
>
>
> It is wrong to check whether you are building out of the
> source tree.  See line 159 of the Makefile.

Let me correct this sentense.


It is wrong to use 'O' to check whether you are building out of the
source tree.





--=20
Best Regards
Masahiro Yamada
