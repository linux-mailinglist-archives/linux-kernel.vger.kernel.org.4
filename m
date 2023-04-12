Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5006DED91
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjDLI14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjDLI1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:27:54 -0400
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B7185FD5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:27:53 -0700 (PDT)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     Dmitry Goldin <dgoldin+lkml@protonmail.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>,
        Sam James <sam@gentoo.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] kheaders: make it possible to override TAR
Date:   Wed, 12 Apr 2023 10:27:43 +0200
Message-Id: <20230412082743.350699-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <CAK7LNATfrxu7BK0ZRq+qSjObiz6GpS3U5L=12vDys5_yy=Mdow@mail.gmail.com>
References: <CAK7LNATfrxu7BK0ZRq+qSjObiz6GpS3U5L=12vDys5_yy=Mdow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 86cdd2fdc4e39c388d39c7ba2396d1a9dfd66226 ("kheaders: make headers
archive reproducible") introduced a number of options specific to GNU
tar to the `tar` invocation in `gen_kheaders.sh` script.  This causes
the script to fail to work on systems where `tar` is not GNU tar.  This
can occur e.g. on recent Gentoo Linux installations that support using
bsdtar from libarchive instead.

Add a `TAR` make variable to make it possible to override the tar
executable used, e.g. by specifying:

  make TAR=gtar

Link: https://bugs.gentoo.org/884061
Reported-by: Sam James <sam@gentoo.org>
Tested-by: Sam James <sam@gentoo.org>
Co-developed-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 Makefile               | 3 ++-
 kernel/gen_kheaders.sh | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5aeea3d98..50045059c 100644
--- a/Makefile
+++ b/Makefile
@@ -520,6 +520,7 @@ LZMA		= lzma
 LZ4		= lz4c
 XZ		= xz
 ZSTD		= zstd
+TAR		= tar
 
 PAHOLE_FLAGS	= $(shell PAHOLE=$(PAHOLE) $(srctree)/scripts/pahole-flags.sh)
 
@@ -599,7 +600,7 @@ export RUSTC RUSTDOC RUSTFMT RUSTC_OR_CLIPPY_QUIET RUSTC_OR_CLIPPY BINDGEN CARGO
 export HOSTRUSTC KBUILD_HOSTRUSTFLAGS
 export CPP AR NM STRIP OBJCOPY OBJDUMP READELF PAHOLE RESOLVE_BTFIDS LEX YACC AWK INSTALLKERNEL
 export PERL PYTHON3 CHECK CHECKFLAGS MAKE UTS_MACHINE HOSTCXX
-export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD
+export KGZIP KBZIP2 KLZOP LZMA LZ4 XZ ZSTD TAR
 export KBUILD_HOSTCXXFLAGS KBUILD_HOSTLDFLAGS KBUILD_HOSTLDLIBS LDFLAGS_MODULE
 export KBUILD_USERCFLAGS KBUILD_USERLDFLAGS
 
diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 1ef9a8751..82d539648 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -86,7 +86,7 @@ find $cpio_dir -type f -print0 |
 # For compatibility with older versions of tar, files are fed to tar
 # pre-sorted, as --sort=name might not be available.
 find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
-    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    ${TAR:-tar} "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
     --owner=0 --group=0 --numeric-owner --no-recursion \
     -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
 
-- 
2.40.0

