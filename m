Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4344E6784E1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231698AbjAWS24 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjAWS2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:28:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582432530
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:28:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E3A8DB80E69
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 18:27:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EEAC433EF;
        Mon, 23 Jan 2023 18:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674498454;
        bh=mh/07EAyt5o/j5dDg4UMKVY3kmQ7MRm/LYTxrDgU2Uk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jZC1H/Vss1UeUdvRwQbJpuOJf/LrZ0IBiMyKX3nTGjSyere/ujjTMZlYu/0i9k4gY
         TbYe8wiobWfaLNxqJ9UVbRG5KyyjOg5p9pw+Z6y6TR6eebVbXpDL7JoZjXZNFa+H/b
         Hh6h8zqa5W0Lc+dTlW1oE9RiB+83iLPZQSZ71rZh8hyBPOeNFzmq25OpDHpIe7o+R9
         vTpL7cf35GAEPlq7yj2aF5HhGTIpGj1wKHm4TGSyQ9R+CewxdXytigBheKGTRAz5cA
         uaJHgW3w17mANf6KQlrRbmj3UIOceOZnvrNsKnF4XUVKYMF8si0hS74gg83zOT9M3c
         jgBEus/P9twuA==
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
Date:   Mon, 23 Jan 2023 18:27:32 +0000
Message-Id: <20230123182732.188863-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CAK7LNATRpc3F6OKiRGsH0iLWRyykeoMy9EazPRPGWHH1T_2cUA@mail.gmail.com>
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

On Mon, 23 Jan 2023 18:09:27 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:

> On Wed, Jan 11, 2023 at 4:14 AM SeongJae Park <sj@kernel.org> wrote:
> >
> > Hi Masahiro,
> >
> > On Wed, 11 Jan 2023 03:39:58 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > > On Tue, Jan 10, 2023 at 9:32 AM SeongJae Park <sj@kernel.org> wrote:
> > > >
> > > > On Tue, 3 Jan 2023 11:58:48 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:
> > > >
> > > > > On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> > > > > <torvalds@linux-foundation.org> wrote:
> > > > > >
> > > > > > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > > >
> > > > [...]
> > > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > > @@ -896,7 +896,7 @@
> > > > >   * Otherwise, the type of .notes section would become PROGBITS
> > > > > instead of NOTES.
> > > > >   */
> > > > >  #define NOTES                                                          \
> > > > > -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> > > > > +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
> > > > >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
> > > > >                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
> > > > >         } NOTES_HEADERS                                                 \
> > > > >
> > > > > The .note.GNU-stack has zero size, so the result should be the same.
> > > > >
> > > >
> > > > This also fixes ARCH=um build error on my system.
> > > >
> > > > Tested-by: SeongJae Park <sj@kernel.org>
> > >
> > >
> > >
> > > I am able to build ARCH=um defconfig at least.
> > >
> > > Can you provide the steps to reproduce the build error?
> >
> > I do the build for kunit test, like below.
> >
> >     mkdir ../kunit.out
> >     echo "
> >         CONFIG_KUNIT=y
> >
> >         CONFIG_DAMON=y
> >         CONFIG_DAMON_KUNIT_TEST=y
> >
> >         CONFIG_DAMON_VADDR=y
> >         CONFIG_DAMON_VADDR_KUNIT_TEST=y
> >
> >         CONFIG_DEBUG_FS=y
> >         CONFIG_DAMON_DBGFS=y
> >         CONFIG_DAMON_DBGFS_KUNIT_TEST=y
> >     CONFIG_DAMON_PADDR=y" > ../kunit.out/.kunitconfig
> >     ./tools/testsing/kunit/kunit.py run --build_dir ../kunit.out
> >     [19:12:37] Configuring KUnit Kernel ...
> >     [19:12:37] Building KUnit Kernel ...
> >     Populating config with:
> >     $ make ARCH=um O=../kunit.out/ olddefconfig
> >     Building with:
> >     $ make ARCH=um O=../kunit.out/ --jobs=36
> >     ERROR:root:`.exit.text' referenced in section `.uml.exitcall.exit' of arch/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/um/drivers/virtio_uml.o
> >     collect2: error: ld returned 1 exit status
> >     make[2]: *** [/home/sjpark/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1
> >     make[1]: *** [/home/sjpark/linux/Makefile:1252: vmlinux] Error 2
> >     make: *** [Makefile:242: __sub-make] Error 2
> >
> >
> > Thanks,
> > SJ
> >
> 
> 
> I did not see the error, though.
> 
> The test seems to have succeeded.
> 
> 
> 
> 
> masahiro@zoe:~/ref/linux(master)$ cat ../kunit.out/.kunitconfig
> CONFIG_KUNIT=y
> 
> CONFIG_DAMON=y
> CONFIG_DAMON_KUNIT_TEST=y
> 
> CONFIG_DAMON_VADDR=y
> CONFIG_DAMON_VADDR_KUNIT_TEST=y
> 
> CONFIG_DEBUG_FS=y
> CONFIG_DAMON_DBGFS=y
> CONFIG_DAMON_DBGFS_KUNIT_TEST=y
> CONFIG_DAMON_PADDR=y
> masahiro@zoe:~/ref/linux(master)$ ./tools/testing/kunit/kunit.py run
> --build_dir ../kunit.out
> [18:05:19] Configuring KUnit Kernel ...
> Regenerating .config ...
> Populating config with:
> $ make ARCH=um O=../kunit.out olddefconfig
> [18:05:22] Building KUnit Kernel ...
> Populating config with:
> $ make ARCH=um O=../kunit.out olddefconfig
> Building with:
> $ make ARCH=um O=../kunit.out --jobs=16
> [18:05:47] Starting KUnit Kernel (1/1)...
> [18:05:47] ============================================================
> [18:05:47] ==================== damon (9 subtests) ====================
> [18:05:47] [PASSED] damon_test_target
> [18:05:47] [PASSED] damon_test_regions
> [18:05:47] [PASSED] damon_test_aggregate
> [18:05:47] [PASSED] damon_test_split_at
> [18:05:47] [PASSED] damon_test_merge_two
> [18:05:47] [PASSED] damon_test_merge_regions_of
> [18:05:47] [PASSED] damon_test_split_regions_of
> [18:05:47] [PASSED] damon_test_ops_registration
> [18:05:47] [PASSED] damon_test_set_regions
> [18:05:47] ====================== [PASSED] damon ======================
> [18:05:47] ============== damon-operations (6 subtests) ===============
> [18:05:47] [PASSED] damon_test_three_regions_in_vmas
> [18:05:47] [PASSED] damon_test_apply_three_regions1
> [18:05:47] [PASSED] damon_test_apply_three_regions2
> [18:05:47] [PASSED] damon_test_apply_three_regions3
> [18:05:47] [PASSED] damon_test_apply_three_regions4
> [18:05:47] [PASSED] damon_test_split_evenly
> [18:05:47] ================ [PASSED] damon-operations =================
> [18:05:47] ================= damon-dbgfs (3 subtests) =================
> [18:05:47] [PASSED] damon_dbgfs_test_str_to_ints
> [18:05:47] [PASSED] damon_dbgfs_test_set_targets
> [18:05:47] [PASSED] damon_dbgfs_test_set_init_regions
> [18:05:47] =================== [PASSED] damon-dbgfs ===================
> [18:05:47] ============================================================
> [18:05:47] Testing complete. Ran 18 tests: passed: 18
> [18:05:47] Elapsed time: 28.194s total, 3.017s configuring, 25.058s
> building, 0.086s running

Thank you for sharing your results.  I think it may depend on the compiler
version, because I use a quite old compiler.

    $ gcc --version
    gcc (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

Thanks,
SJ

[...]
