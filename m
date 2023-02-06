Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770DD68C9DA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjBFW5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:57:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjBFW46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:56:58 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B606199C8
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:56:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BE5E2B8165B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F2DC433EF;
        Mon,  6 Feb 2023 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675724214;
        bh=GmSYy8SzwpAetwzZfZT+vfJS1g8bBXifQn3bcPn9tiE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nKpqeYTb5Rff8jA3hUyAP/tzoz9USsqt7Slc4XnnQixQbdBQ+ZSx/QScHvZfB7GA0
         Z8RBvfwySaUOrZSwMFRdaLwOVfwGWMiBOQoIrdrroFc6gyqcaR6eRy+mXboWDMo1JQ
         ynpXAMzn6F4tmykKPhQnuoUogbhHHzlNOYWyuHry0F6r8Cx+WvgHtsJu93224dYFl3
         m4KQIOGm07IYRWD0EZCoPySA4vd+GuV9J52a6vl9tWQPy3G+mRKn2zP3Pl2u7Eo19y
         1ijRIoD3xASOumbxx4y8LjaACx4jd04mMdBDO2YdfojTRbpVDCdWct4mFpt4Ap3ydY
         j9lXCB22mu6aA==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: Linux 6.2-rc2
Date:   Mon,  6 Feb 2023 22:56:52 +0000
Message-Id: <20230206225652.89873-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123182732.188863-1-sj@kernel.org>
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

On Mon, 23 Jan 2023 18:27:32 +0000 SeongJae Park <sj@kernel.org> wrote:

> On Mon, 23 Jan 2023 18:09:27 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
> 
> > On Wed, Jan 11, 2023 at 4:14 AM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > Hi Masahiro,
> > >
> > > On Wed, 11 Jan 2023 03:39:58 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > > On Tue, Jan 10, 2023 at 9:32 AM SeongJae Park <sj@kernel.org> wrote:
> > > > >
> > > > > On Tue, 3 Jan 2023 11:58:48 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:
> > > > >
> > > > > > On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> > > > > > <torvalds@linux-foundation.org> wrote:
> > > > > > >
> > > > > > > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > > >
> > > > > [...]
> > > > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > > > @@ -896,7 +896,7 @@
> > > > > >   * Otherwise, the type of .notes section would become PROGBITS
> > > > > > instead of NOTES.
> > > > > >   */
> > > > > >  #define NOTES                                                          \
> > > > > > -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> > > > > > +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
> > > > > >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
> > > > > >                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
> > > > > >         } NOTES_HEADERS                                                 \
> > > > > >
> > > > > > The .note.GNU-stack has zero size, so the result should be the same.
> > > > > >
> > > > >
> > > > > This also fixes ARCH=um build error on my system.
> > > > >
> > > > > Tested-by: SeongJae Park <sj@kernel.org>
> > > >
> > > >
> > > >
> > > > I am able to build ARCH=um defconfig at least.
> > > >
> > > > Can you provide the steps to reproduce the build error?
> > >
> > > I do the build for kunit test, like below.
> > >
> > >     mkdir ../kunit.out
> > >     echo "
> > >         CONFIG_KUNIT=y
> > >
> > >         CONFIG_DAMON=y
> > >         CONFIG_DAMON_KUNIT_TEST=y
> > >
> > >         CONFIG_DAMON_VADDR=y
> > >         CONFIG_DAMON_VADDR_KUNIT_TEST=y
> > >
> > >         CONFIG_DEBUG_FS=y
> > >         CONFIG_DAMON_DBGFS=y
> > >         CONFIG_DAMON_DBGFS_KUNIT_TEST=y
> > >     CONFIG_DAMON_PADDR=y" > ../kunit.out/.kunitconfig
> > >     ./tools/testsing/kunit/kunit.py run --build_dir ../kunit.out
> > >     [19:12:37] Configuring KUnit Kernel ...
> > >     [19:12:37] Building KUnit Kernel ...
> > >     Populating config with:
> > >     $ make ARCH=um O=../kunit.out/ olddefconfig
> > >     Building with:
> > >     $ make ARCH=um O=../kunit.out/ --jobs=36
> > >     ERROR:root:`.exit.text' referenced in section `.uml.exitcall.exit' of arch/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/um/drivers/virtio_uml.o
> > >     collect2: error: ld returned 1 exit status
> > >     make[2]: *** [/home/sjpark/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1
> > >     make[1]: *** [/home/sjpark/linux/Makefile:1252: vmlinux] Error 2
> > >     make: *** [Makefile:242: __sub-make] Error 2
> > >
[...]
> 
> Thank you for sharing your results.  I think it may depend on the compiler
> version, because I use a quite old compiler.
> 
>     $ gcc --version
>     gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

I'm still getting the failure on my setup with latest mainline.  Could we merge
the fix for now?  Or, was there some updates that I was missing?


Thanks,
SJ

[...]
