Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7156A3E9D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 10:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjB0Jvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 04:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjB0Jvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 04:51:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160201A97B;
        Mon, 27 Feb 2023 01:51:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50A7CB80C9C;
        Mon, 27 Feb 2023 09:51:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED0EAC433D2;
        Mon, 27 Feb 2023 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677491501;
        bh=k4bHK7yki50HbIimXeshzPEvSEmB8dsoyrVImtSRV0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RiQp3fHfoWK/3gmpuP/65ehrP0b19eaAupQNSqETjwDFEbbrBA/arddV50M5slupT
         uRxRQhPvgCHRxJq87bQju1c5jS5fS5zEEGN10bwlpQ/WlqJG4BBUuzsB24nURlgNdc
         aYeS1ryytqpLFb/G0aY6U9JfBtI5Qjtioa0jQUkvb3EXD1Vi/dD69UuXxjn0h8NtTk
         xdQDr77J6RPtJ8sgKAa0JqK6IlEWPGSR2QLXPUYGrObusTcug0GxKCmd+tSt7x9s1a
         EAxQ4/ZQrfjD6KH252f08hTcuniVIsKYXVebLU/O+gveD+6Qhw4S70BUiOOe4Ddh3X
         t02VlFH9h4xSQ==
Received: by mail-oi1-f175.google.com with SMTP id q15so4676024oiw.11;
        Mon, 27 Feb 2023 01:51:40 -0800 (PST)
X-Gm-Message-State: AO0yUKUENy4D0fvVdRuFfFx8A7pm2Cof5hsrgGLXDBoYFa5jLQjcciDs
        LDrvSQBeeKzI/sEZW6EWM5vKf5RCBPwGofa/Fbs=
X-Google-Smtp-Source: AK7set/TGd66AmNhZVsYfwjUXXGABhl4kd9zCcaF47EyfO66j/ih4UBNd9QTqd4VSsywtJwX8GfsEX5+VAlJIfewCdk=
X-Received: by 2002:aca:100c:0:b0:384:21e7:977c with SMTP id
 12-20020aca100c000000b0038421e7977cmr1211753oiq.8.1677491500238; Mon, 27 Feb
 2023 01:51:40 -0800 (PST)
MIME-Version: 1.0
References: <20230215012034.403356-1-masahiroy@kernel.org> <251124e4-64e1-385d-ea7f-c0cc31851307@prevas.dk>
In-Reply-To: <251124e4-64e1-385d-ea7f-c0cc31851307@prevas.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 27 Feb 2023 18:51:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR82ZgvKof9VMXRM4A_h22ZNCyoaKoHW-ONJ+4vctCu_A@mail.gmail.com>
Message-ID: <CAK7LNAR82ZgvKof9VMXRM4A_h22ZNCyoaKoHW-ONJ+4vctCu_A@mail.gmail.com>
Subject: Re: [PATCH v6 01/12] kbuild: add a tool to list files ignored by git
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Hutchings <ben@decadent.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 5:25=E2=80=AFPM Rasmus Villemoes
<rasmus.villemoes@prevas.dk> wrote:
>
> On 15/02/2023 02.20, Masahiro Yamada wrote:
> > In short, the motivation of this commit is to build a source package
> > without cleaning the source tree.
> >
> > The deb-pkg and (src)rpm-pkg targets first run 'make clean' before
> > creating a source tarball. Otherwise build artifacts such as *.o,
> > *.a, etc. would be included in the tarball. Yet, the tarball ends up
> > containing several garbage files since 'make clean' does not clean
> > everything.
> >
> > Cleaning the tree every time is annoying since it makes the incremental
> > build impossible. It is desirable to create a source tarball without
> > cleaning the tree.
> >
> > In fact, there are some ways to achieve this.
>
> > The easiest solution is 'git archive'.
>
> Eh, no, the easiest solution is to just don't build in-tree? Can you
> explain why 'make O=3D/over/there' isn't sufficient for whatever it is yo=
u
> really want to do here?
>
> Rasmus


Right.

If you have a strict rule "I never build the kernel in-tree",
your source tree is kept clean.
So, tar will never include generated files.

But, how would you know if the source tree is really clean?



--
Best Regards
Masahiro Yamada
