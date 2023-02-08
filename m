Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA00468E562
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 02:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjBHB2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 20:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBHB2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 20:28:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E25367F2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 17:28:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52E8561474
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6F6C433A4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 01:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675819699;
        bh=ySOBWABXHobqC6tRnhtPa2KHrAeWgESayYbL45Pftjs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bO4Irx193cWTyRgLU16dP06P29JBDU7XtDRJO5KCZr4nuqa6xVELJ2DelkyIIQwiI
         6WOkydpJaljuEaWkN7XolXNHmC3wU9wqn7gFEF0InDiYAG6k0h9zfDLdroaLeBFrN3
         sL3Bfk6Bq69cNzZxDMqZ8gsTtRu7KX+ksjfQWrAh7Fsnrszt3bloPBZUxg2Yb4R0Hb
         cVMNXwqVeE9FBCkp/nPt5HH26vXN25MKPOH2aZYOdz9kDYEGuH/GmEhIOdxdctQCqb
         gIAuXt22qhjhaknH+0YVkJJHLO4b+MezMlH1m+ary3CRv4xbHnjOWZGqgcuPldLupn
         S1+u9AmU9MGJw==
Received: by mail-ot1-f48.google.com with SMTP id p24-20020a056830131800b0068d4b30536aso4797614otq.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 17:28:19 -0800 (PST)
X-Gm-Message-State: AO0yUKW8KCn3+BR86cFKDDSrF9ocM2+7DWP01FqjyA1+O4BTOjvCppIQ
        loU+MuNwuyoU1WKUxap2TpN8wIoyx0dW3Lc+BIg=
X-Google-Smtp-Source: AK7set+QF1X+RgxWIMYVqSbWqb9Yl3uMNAx1fT31Ze7wwtZIwth9r6SG/KtQC/lax+jfsFuQdKlLlEvUkss4Ya2dVPs=
X-Received: by 2002:a9d:4e91:0:b0:686:6392:ed38 with SMTP id
 v17-20020a9d4e91000000b006866392ed38mr515879otk.22.1675819698888; Tue, 07 Feb
 2023 17:28:18 -0800 (PST)
MIME-Version: 1.0
References: <20230123182732.188863-1-sj@kernel.org> <20230206225652.89873-1-sj@kernel.org>
In-Reply-To: <20230206225652.89873-1-sj@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 8 Feb 2023 10:27:42 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQf=9NJWRAFkcA=GXHh2bmh8N22iTJHqL1wDbyiB2Kfow@mail.gmail.com>
Message-ID: <CAK7LNAQf=9NJWRAFkcA=GXHh2bmh8N22iTJHqL1wDbyiB2Kfow@mail.gmail.com>
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

On Tue, Feb 7, 2023 at 7:56 AM SeongJae Park <sj@kernel.org> wrote:
>
> On Mon, 23 Jan 2023 18:27:32 +0000 SeongJae Park <sj@kernel.org> wrote:
>
> > On Mon, 23 Jan 2023 18:09:27 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > > On Wed, Jan 11, 2023 at 4:14 AM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > Hi Masahiro,
> > > >
> > > > On Wed, 11 Jan 2023 03:39:58 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > > On Tue, Jan 10, 2023 at 9:32 AM SeongJae Park <sj@kernel.org> wrote:
> > > > > >
> > > > > > On Tue, 3 Jan 2023 11:58:48 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > > >
> > > > > > > On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> > > > > > > <torvalds@linux-foundation.org> wrote:
> > > > > > > >
> > > > > > > > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > > >
> > > > > > [...]
> > > > > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > > > > @@ -896,7 +896,7 @@
> > > > > > >   * Otherwise, the type of .notes section would become PROGBITS
> > > > > > > instead of NOTES.
> > > > > > >   */
> > > > > > >  #define NOTES                                                          \
> > > > > > > -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> > > > > > > +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
> > > > > > >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
> > > > > > >                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
> > > > > > >         } NOTES_HEADERS                                                 \
> > > > > > >
> > > > > > > The .note.GNU-stack has zero size, so the result should be the same.
> > > > > > >
> > > > > >
> > > > > > This also fixes ARCH=um build error on my system.
> > > > > >
> > > > > > Tested-by: SeongJae Park <sj@kernel.org>
> > > > >
> > > > >
> > > > >
> > > > > I am able to build ARCH=um defconfig at least.
> > > > >
> > > > > Can you provide the steps to reproduce the build error?
> > > >
> > > > I do the build for kunit test, like below.
> > > >
> > > >     mkdir ../kunit.out
> > > >     echo "
> > > >         CONFIG_KUNIT=y
> > > >
> > > >         CONFIG_DAMON=y
> > > >         CONFIG_DAMON_KUNIT_TEST=y
> > > >
> > > >         CONFIG_DAMON_VADDR=y
> > > >         CONFIG_DAMON_VADDR_KUNIT_TEST=y
> > > >
> > > >         CONFIG_DEBUG_FS=y
> > > >         CONFIG_DAMON_DBGFS=y
> > > >         CONFIG_DAMON_DBGFS_KUNIT_TEST=y
> > > >     CONFIG_DAMON_PADDR=y" > ../kunit.out/.kunitconfig
> > > >     ./tools/testsing/kunit/kunit.py run --build_dir ../kunit.out
> > > >     [19:12:37] Configuring KUnit Kernel ...
> > > >     [19:12:37] Building KUnit Kernel ...
> > > >     Populating config with:
> > > >     $ make ARCH=um O=../kunit.out/ olddefconfig
> > > >     Building with:
> > > >     $ make ARCH=um O=../kunit.out/ --jobs=36
> > > >     ERROR:root:`.exit.text' referenced in section `.uml.exitcall.exit' of arch/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/um/drivers/virtio_uml.o
> > > >     collect2: error: ld returned 1 exit status
> > > >     make[2]: *** [/home/sjpark/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > > >     make[1]: *** [/home/sjpark/linux/Makefile:1252: vmlinux] Error 2
> > > >     make: *** [Makefile:242: __sub-make] Error 2
> > > >
> [...]
> >
> > Thank you for sharing your results.  I think it may depend on the compiler
> > version, because I use a quite old compiler.
> >
> >     $ gcc --version
> >     gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0
>
> I'm still getting the failure on my setup with latest mainline.  Could we merge
> the fix for now?  Or, was there some updates that I was missing?
>
>
> Thanks,
> SJ
>
> [...]



Sorry for delay. I submitted a patch.

https://lore.kernel.org/all/20230207164156.537378-1-masahiroy@kernel.org/


-- 
Best Regards
Masahiro Yamada
