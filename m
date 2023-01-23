Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB039677714
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 10:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjAWJKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 04:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjAWJKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 04:10:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA31DBBA
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:10:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 14E1160DF2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:10:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7938EC433D2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674465004;
        bh=rK4JZ4cVfDyOGYbr9iUGcdYMzFnOdSz84L2t3k0m7bU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pPhCh9EtJzFVEoVAO/58c4N5I91yZcWa/iRO40WAf2+6bk3THpyUjpoD3p+PLHefH
         kFLwTFeevsjbl7nxN2a1b5R9hYKL8wGlYvewwqsq3OnZ04hqynrK9ZCgip1/+0AlAB
         Q8sWL3FrQb4Nui/RcgrqRH7LNJ5MS+B+RE32hvj2XuNtGWLgbJ9Dh94GhdoRbbBnR9
         wtLIQawPej5TJgYran5KpY4WiSoxumFJSIlELhpr/fgLPVp2j8icaMlCtNz3bQmn0W
         ZUOJn4ucGeu0ZQAu7LHHQ3rtOhS7ImNRx6CKoQ69oBRztZO4DO799shwKDM40BH+05
         xYB7yy2knOHqQ==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-15f83e0fc63so13209383fac.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 01:10:04 -0800 (PST)
X-Gm-Message-State: AFqh2kpDIu1cq3c3PJafn2OktSqvcwtFaegrMrjau42L+uAU9xlPX/Lt
        OS5Qdd078mmsYTZXjkGOIw8KLgk3SygIMXq+mLs=
X-Google-Smtp-Source: AMrXdXt6y5VfXA8POc8fRPyhB/o5ILPMZVvXfMSOjB5XyBkimRY5LwKcl4IUP110qly3j3YsVnZjsU9BiNelsTJLu/c=
X-Received: by 2002:a05:6870:b0c:b0:15b:9941:ac30 with SMTP id
 lh12-20020a0568700b0c00b0015b9941ac30mr1815950oab.287.1674465003466; Mon, 23
 Jan 2023 01:10:03 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAR7dfv=---C15S3ohTEWsoyRNTrasY9ysD1ahZxLZAXow@mail.gmail.com>
 <20230110191404.132594-1-sj@kernel.org>
In-Reply-To: <20230110191404.132594-1-sj@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 23 Jan 2023 18:09:27 +0900
X-Gmail-Original-Message-ID: <CAK7LNATRpc3F6OKiRGsH0iLWRyykeoMy9EazPRPGWHH1T_2cUA@mail.gmail.com>
Message-ID: <CAK7LNATRpc3F6OKiRGsH0iLWRyykeoMy9EazPRPGWHH1T_2cUA@mail.gmail.com>
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

On Wed, Jan 11, 2023 at 4:14 AM SeongJae Park <sj@kernel.org> wrote:
>
> Hi Masahiro,
>
> On Wed, 11 Jan 2023 03:39:58 +0900 Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > On Tue, Jan 10, 2023 at 9:32 AM SeongJae Park <sj@kernel.org> wrote:
> > >
> > > On Tue, 3 Jan 2023 11:58:48 +0100 Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > > On Tue, 3 Jan 2023 at 03:13, Linus Torvalds
> > > > <torvalds@linux-foundation.org> wrote:
> > > > >
> > > > > On Mon, Jan 2, 2023 at 5:45 PM Guenter Roeck <linux@roeck-us.net> wrote:
> > > > > >
> > > [...]
> > > > --- a/include/asm-generic/vmlinux.lds.h
> > > > +++ b/include/asm-generic/vmlinux.lds.h
> > > > @@ -896,7 +896,7 @@
> > > >   * Otherwise, the type of .notes section would become PROGBITS
> > > > instead of NOTES.
> > > >   */
> > > >  #define NOTES                                                          \
> > > > -       /DISCARD/ : { *(.note.GNU-stack) }                              \
> > > > +       .note.GNU-stack : { *(.note.GNU-stack) }                        \
> > > >         .notes : AT(ADDR(.notes) - LOAD_OFFSET) {                       \
> > > >                 BOUNDED_SECTION_BY(.note.*, _notes)                     \
> > > >         } NOTES_HEADERS                                                 \
> > > >
> > > > The .note.GNU-stack has zero size, so the result should be the same.
> > > >
> > >
> > > This also fixes ARCH=um build error on my system.
> > >
> > > Tested-by: SeongJae Park <sj@kernel.org>
> >
> >
> >
> > I am able to build ARCH=um defconfig at least.
> >
> > Can you provide the steps to reproduce the build error?
>
> I do the build for kunit test, like below.
>
>     mkdir ../kunit.out
>     echo "
>         CONFIG_KUNIT=y
>
>         CONFIG_DAMON=y
>         CONFIG_DAMON_KUNIT_TEST=y
>
>         CONFIG_DAMON_VADDR=y
>         CONFIG_DAMON_VADDR_KUNIT_TEST=y
>
>         CONFIG_DEBUG_FS=y
>         CONFIG_DAMON_DBGFS=y
>         CONFIG_DAMON_DBGFS_KUNIT_TEST=y
>     CONFIG_DAMON_PADDR=y" > ../kunit.out/.kunitconfig
>     ./tools/testsing/kunit/kunit.py run --build_dir ../kunit.out
>     [19:12:37] Configuring KUnit Kernel ...
>     [19:12:37] Building KUnit Kernel ...
>     Populating config with:
>     $ make ARCH=um O=../kunit.out/ olddefconfig
>     Building with:
>     $ make ARCH=um O=../kunit.out/ --jobs=36
>     ERROR:root:`.exit.text' referenced in section `.uml.exitcall.exit' of arch/um/drivers/virtio_uml.o: defined in discarded section `.exit.text' of arch/um/drivers/virtio_uml.o
>     collect2: error: ld returned 1 exit status
>     make[2]: *** [/home/sjpark/linux/scripts/Makefile.vmlinux:34: vmlinux] Error 1
>     make[1]: *** [/home/sjpark/linux/Makefile:1252: vmlinux] Error 2
>     make: *** [Makefile:242: __sub-make] Error 2
>
>
> Thanks,
> SJ
>


I did not see the error, though.

The test seems to have succeeded.




masahiro@zoe:~/ref/linux(master)$ cat ../kunit.out/.kunitconfig
CONFIG_KUNIT=y

CONFIG_DAMON=y
CONFIG_DAMON_KUNIT_TEST=y

CONFIG_DAMON_VADDR=y
CONFIG_DAMON_VADDR_KUNIT_TEST=y

CONFIG_DEBUG_FS=y
CONFIG_DAMON_DBGFS=y
CONFIG_DAMON_DBGFS_KUNIT_TEST=y
CONFIG_DAMON_PADDR=y
masahiro@zoe:~/ref/linux(master)$ ./tools/testing/kunit/kunit.py run
--build_dir ../kunit.out
[18:05:19] Configuring KUnit Kernel ...
Regenerating .config ...
Populating config with:
$ make ARCH=um O=../kunit.out olddefconfig
[18:05:22] Building KUnit Kernel ...
Populating config with:
$ make ARCH=um O=../kunit.out olddefconfig
Building with:
$ make ARCH=um O=../kunit.out --jobs=16
[18:05:47] Starting KUnit Kernel (1/1)...
[18:05:47] ============================================================
[18:05:47] ==================== damon (9 subtests) ====================
[18:05:47] [PASSED] damon_test_target
[18:05:47] [PASSED] damon_test_regions
[18:05:47] [PASSED] damon_test_aggregate
[18:05:47] [PASSED] damon_test_split_at
[18:05:47] [PASSED] damon_test_merge_two
[18:05:47] [PASSED] damon_test_merge_regions_of
[18:05:47] [PASSED] damon_test_split_regions_of
[18:05:47] [PASSED] damon_test_ops_registration
[18:05:47] [PASSED] damon_test_set_regions
[18:05:47] ====================== [PASSED] damon ======================
[18:05:47] ============== damon-operations (6 subtests) ===============
[18:05:47] [PASSED] damon_test_three_regions_in_vmas
[18:05:47] [PASSED] damon_test_apply_three_regions1
[18:05:47] [PASSED] damon_test_apply_three_regions2
[18:05:47] [PASSED] damon_test_apply_three_regions3
[18:05:47] [PASSED] damon_test_apply_three_regions4
[18:05:47] [PASSED] damon_test_split_evenly
[18:05:47] ================ [PASSED] damon-operations =================
[18:05:47] ================= damon-dbgfs (3 subtests) =================
[18:05:47] [PASSED] damon_dbgfs_test_str_to_ints
[18:05:47] [PASSED] damon_dbgfs_test_set_targets
[18:05:47] [PASSED] damon_dbgfs_test_set_init_regions
[18:05:47] =================== [PASSED] damon-dbgfs ===================
[18:05:47] ============================================================
[18:05:47] Testing complete. Ran 18 tests: passed: 18
[18:05:47] Elapsed time: 28.194s total, 3.017s configuring, 25.058s
building, 0.086s running









-- 
Best Regards
Masahiro Yamada
