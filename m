Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87806B138D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbjCHVHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:07:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHVHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:07:44 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC5D514E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 13:07:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 51798CE1FBE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 21:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2815FC433D2;
        Wed,  8 Mar 2023 21:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1678309656;
        bh=5sBw8YBMWuDsTbdbyhx6tx4mTGUCbOpZNEfsUaiN8/E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hE0xSCDWku5sQr6qlduKFf1GwZt4ZBDMUM3uyCf7WAbSYeYDfiycmTFVOtGYinABV
         aXQeB0zoYOeqzrlJRs2QonBG1I70ayGpj86gpHo8vLSlYWg9yKdRMhY+gQ3e6nmvJt
         6sYQhVCQucWgD8VeGFMYr7MkVPudVjXguKEFHt3c=
Date:   Wed, 8 Mar 2023 13:07:35 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Marco Elver <elver@google.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: ld.lld: error: undefined symbol: memcpy
Message-Id: <20230308130735.bbc4b21a3aff977bced451fa@linux-foundation.org>
In-Reply-To: <202303090422.ss2Hbm4f-lkp@intel.com>
References: <202303090422.ss2Hbm4f-lkp@intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Mar 2023 05:01:04 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   63355b9884b3d1677de6bd1517cd2b8a9bf53978
> commit: 36be5cba99f6f9984a9a9f0454f95a38f4184d3e kasan: treat meminstrinsic as builtins in uninstrumented files
> date:   6 days ago
> config: powerpc-randconfig-r036-20230305 (https://download.01.org/0day-ci/archive/20230309/202303090422.ss2Hbm4f-lkp@intel.com/config)
> compiler: clang version 17.0.0 (https://github.com/llvm/llvm-project 67409911353323ca5edf2049ef0df54132fa1ca7)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install powerpc cross compiling tool for clang build
>         # apt-get install binutils-powerpc-linux-gnu
>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=36be5cba99f6f9984a9a9f0454f95a38f4184d3e
>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>         git fetch --no-tags linus master
>         git checkout 36be5cba99f6f9984a9a9f0454f95a38f4184d3e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
> | Link: https://lore.kernel.org/oe-kbuild-all/202303090422.ss2Hbm4f-lkp@intel.com/
> 
> All errors (new ones prefixed by >>):
> 
> >> ld.lld: error: undefined symbol: memcpy
>    >>> referenced by xmon.c:1896 (arch/powerpc/xmon/xmon.c:1896)
>    >>>               arch/powerpc/xmon/xmon.o:(prregs) in archive vmlinux.a
>    >>> referenced by zstd_compress.c:4814 (lib/zstd/compress/zstd_compress.c:4814)
>    >>>               lib/zstd/compress/zstd_compress.o:(ZSTD_createCDict_advanced2) in archive vmlinux.a
>    >>> referenced by zstd_compress.c:4910 (lib/zstd/compress/zstd_compress.c:4910)
>    >>>               lib/zstd/compress/zstd_compress.o:(ZSTD_initStaticCDict) in archive vmlinux.a
>    >>> referenced 5 more times
> --
> >> ld.lld: error: undefined symbol: memset
>    >>> referenced by slab_common.c:579 (mm/slab_common.c:579)
>    >>>               mm/slab_common.o:(kmem_dump_obj) in archive vmlinux.a
>    >>> referenced by kasan_test.c:558 (mm/kasan/kasan_test.c:558)
>    >>>               mm/kasan/kasan_test.o:(kmalloc_oob_in_memset) in archive vmlinux.a
>    >>> referenced by kasan_test.c:505 (mm/kasan/kasan_test.c:505)
>    >>>               mm/kasan/kasan_test.o:(kmalloc_oob_memset_2) in archive vmlinux.a
>    >>> referenced 10 more times
> 

Will this fix?

From: Alexander Potapenko <glider@google.com>
Subject: x86: kmsan: don't rename memintrinsics in uninstrumented files
Date: Fri, 3 Mar 2023 15:14:30 +0100

clang -fsanitize=kernel-memory already replaces calls to
memset/memcpy/memmove and their __builtin_ versions with
__msan_memset/__msan_memcpy/__msan_memmove in instrumented files, so
there is no need to override them.

In non-instrumented versions we are now required to leave memset() and
friends intact, so we cannot replace them with __msan_XXX() functions.

Link: https://lkml.kernel.org/r/20230303141433.3422671-1-glider@google.com
Signed-off-by: Alexander Potapenko <glider@google.com>
Suggested-by: Marco Elver <elver@google.com>
Reviewed-by: Marco Elver <elver@google.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


--- a/arch/x86/include/asm/string_64.h~x86-kmsan-dont-rename-memintrinsics-in-uninstrumented-files
+++ a/arch/x86/include/asm/string_64.h
@@ -15,22 +15,11 @@
 #endif
 
 #define __HAVE_ARCH_MEMCPY 1
-#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
-#undef memcpy
-#define memcpy __msan_memcpy
-#else
 extern void *memcpy(void *to, const void *from, size_t len);
-#endif
 extern void *__memcpy(void *to, const void *from, size_t len);
 
 #define __HAVE_ARCH_MEMSET
-#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
-extern void *__msan_memset(void *s, int c, size_t n);
-#undef memset
-#define memset __msan_memset
-#else
 void *memset(void *s, int c, size_t n);
-#endif
 void *__memset(void *s, int c, size_t n);
 
 #define __HAVE_ARCH_MEMSET16
@@ -70,13 +59,7 @@ static inline void *memset64(uint64_t *s
 }
 
 #define __HAVE_ARCH_MEMMOVE
-#if defined(__SANITIZE_MEMORY__) && defined(__NO_FORTIFY)
-#undef memmove
-void *__msan_memmove(void *dest, const void *src, size_t len);
-#define memmove __msan_memmove
-#else
 void *memmove(void *dest, const void *src, size_t count);
-#endif
 void *__memmove(void *dest, const void *src, size_t count);
 
 int memcmp(const void *cs, const void *ct, size_t count);
_

