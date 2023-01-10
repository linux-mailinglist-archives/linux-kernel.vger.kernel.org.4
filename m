Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86A06664C21
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239828AbjAJTOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239882AbjAJTOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:14:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4325005F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:14:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C317EB81919
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 19:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9449DC433F0;
        Tue, 10 Jan 2023 19:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673378047;
        bh=8VMuRmtRqaT8lihotNAGlk0VuE/uM8wsvkJVXbs+qyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SxX7gxrmfhhNSyGrUh6MgcHXLhiGruyrglGCL5nlkEZ0FSvBTx824IxrIxDLEsja9
         Uv/KaAy9BvUmsDUK9+uP0vOpt69qmT+Ka9vRTK3TJGuNMjWUMO6e/TJhlMgcCTapaE
         yM6FA2PP9twC/+a8FQoMc667Nt6CchI7/JuKjK+HLOudy7TLvYb4qBDXklbYi4AHAU
         z8ykaCtl3XnFl5uaecBM9TBAIbDFp9y52iwY8AxVaRbvI2lo+5bjL5hkDhuw52CEdL
         UQ6dkui5hxMEG/HJswZZ48/Up9kbwQzqVQu8dySbmdU5yI6l9XbSty8FPTU61SDQf2
         OOL8mDv4JoxbQ==
From:   SeongJae Park <sj@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: Linux 6.2-rc2
Date:   Tue, 10 Jan 2023 19:14:04 +0000
Message-Id: <20230110191404.132594-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAK7LNAR7dfv=---C15S3ohTEWsoyRNTrasY9ysD1ahZxLZAXow@mail.gmail.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masahiro,

On Wed, 11 Jan 2023 03:39:58 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:

> On Tue, Jan 10, 2023 at 9:32 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > On Tue, 3 Jan 2023 11:58:48 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > > On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > >
> > [...]
> > > --- a/include/asm-generic/vmlinux.lds.h
> > > +++ b/include/asm-generic/vmlinux.lds.h
> > > @@ -896,7 +896,7 @@
> > >   * Otherwise, the type of .notes section would become PROGBITS
> > > instead of NOTES.
> > >   */
> > >  #define NOTES                                                          \
> > > -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> > > +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
> > >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
> > >                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
> > >         } NOTES_HEADERS                                                 \
> > >
> > > The .note.GNU-stack has zero size, so the result should be the same.
> > >
> >
> > This also fixes ARCH=um build error on my system.
> >
> > Tested-by: SeongJae Park <sj@kernel.org>
> 
> 
> 
> I am able to build ARCH=um defconfig at least.
> 
> Can you provide the steps to reproduce the build error?

I do the build for kunit test, like below.

    mkdir ../kunit.out
    echo "
    	CONFIG_KUNIT=y
    
    	CONFIG_DAMON=y
    	CONFIG_DAMON_KUNIT_TEST=y
    
    	CONFIG_DAMON_VADDR=y
    	CONFIG_DAMON_VADDR_KUNIT_TEST=y
    
    	CONFIG_DEBUG_FS=y
    	CONFIG_DAMON_DBGFS=y
    	CONFIG_DAMON_DBGFS_KUNIT_TEST=y
    CONFIG_DAMON_PADDR=y" > ../kunit.out/.kunitconfig
    ./tools/testsing/kunit/kunit.py run --build_dir ../kunit.out
    [19:12:37] Configuring KUnit Kernel ...
    [19:12:37] Building KUnit Kernel ...
    Populating config with:
    $ make ARCH=um O=../kunit.out/ olddefconfig
    Building with:
    $ make ARCH=um O=../kunit.out/ --jobs=36
    ERROR:root:`.exit.text' referenced in section `.uml.exitcall.exit' of arch/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/um/drivers/virtio_uml.o
    collect2: error: ld returned 1 exit status
    make[2]: *** [/home/sjpark/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1
    make[1]: *** [/home/sjpark/linux/Makefile:1252: vmlinux] Error 2
    make: *** [Makefile:242: __sub-make] Error 2


Thanks,
SJ

> 
> 
> 
> 
> --
> Best Regards
> Masahiro Yamada
