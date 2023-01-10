Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6948664B83
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbjAJSq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239695AbjAJSpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:45:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF0A75564A
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:40:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8045261866
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9C2DC43398
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 18:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673376036;
        bh=Wu94TpjHS4PdjmSSvyJUB+kEC6ZcC1vpSuD1JFFXQLY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tgPWauioJRIKRJLO7SpqYAE/B+xcXCdJgDZsdwn3N5plOFyilkXOR9vVzxACNEe6W
         SbURFhi8gFEFGUEFuHy9Nv0YCyTsvddtpHIymszLQ6g8Vm9z2s+NPymawAmVatLtZl
         qvPEBBRwqxKXiGGGuqzHEp0VD6GlGjwkGxBTnzPuX+a8yOZC+7O0Z307SvH46srlS/
         b0sprClpAdtHi/0dk/c21ddC4qI/nfon5N5e8DSZRM4RI6+D3nFKimbJmvTitPOu+s
         AT8ncoTbZJ2uRf4Qh7OO/5C5shqM/xEE2Ro7fIS0XZVvg3KCnLAmboZDHpUa0C8Qov
         VjHu1wVU3v/3g==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-12c8312131fso13076554fac.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 10:40:36 -0800 (PST)
X-Gm-Message-State: AFqh2kpGnzfK3wpsPdku4MqK7wmLeS0dou0Xg5AzkI6evOqHXDJlU02w
        5S47YoBkeuHPwR7DZtrfYzErKN2mSmdNIIE/LFg=
X-Google-Smtp-Source: AMrXdXtmN/a3hrmdRnmqZfS2gBSjsyo5hW56nFaomfX2tfII1c+mJG2dKikWaPv8adj3qGm07vKQl2Mxn/4qpXEyYpM=
X-Received: by 2002:a05:6870:50a:b0:15b:9941:ac30 with SMTP id
 j10-20020a056870050a00b0015b9941ac30mr565882oao.287.1673376036111; Tue, 10
 Jan 2023 10:40:36 -0800 (PST)
MIME-Version: 1.0
References: <CAMj1kXHqQoqoys83nEp=Q6oT68+-GpCuMjfnYK9pMy-X_+jjKw@mail.gmail.com>
 <20230110003215.139072-1-sj@kernel.org>
In-Reply-To: <20230110003215.139072-1-sj@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 11 Jan 2023 03:39:58 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR7dfv=---C15S3ohTEWsoyRNTrasY9ysD1ahZxLZAXow@mail.gmail.com>
Message-ID: <CAK7LNAR7dfv=---C15S3ohTEWsoyRNTrasY9ysD1ahZxLZAXow@mail.gmail.com>
Subject: Re: Linux 6.2-rc2
To:     SeongJae Park <sj@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 9:32 AM SeongJae Park <sj@kernel.org> wrote:
>
> On Tue, 3 Jan 2023 11:58:48 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:
>
> > On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> > <torvalds@linux-foundation.org> wrote:
> > >
> > > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > >
> [...]
> > --- a/include/asm-generic/vmlinux.lds.h
> > +++ b/include/asm-generic/vmlinux.lds.h
> > @@ -896,7 +896,7 @@
> >   * Otherwise, the type of .notes section would become PROGBITS
> > instead of NOTES.
> >   */
> >  #define NOTES                                                          \
> > -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> > +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
> >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
> >                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
> >         } NOTES_HEADERS                                                 \
> >
> > The .note.GNU-stack has zero size, so the result should be the same.
> >
>
> This also fixes ARCH=um build error on my system.
>
> Tested-by: SeongJae Park <sj@kernel.org>



I am able to build ARCH=um defconfig at least.

Can you provide the steps to reproduce the build error?




--
Best Regards
Masahiro Yamada
