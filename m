Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E743864F84E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Dec 2022 09:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiLQImO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Dec 2022 03:42:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Dec 2022 03:42:12 -0500
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC6F17434
        for <linux-kernel@vger.kernel.org>; Sat, 17 Dec 2022 00:42:10 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>
To:     Dmitry Goldin <dgoldin+lkml@protonmail.ch>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Micha=C5=82=20G=C3=B3rny?= <mgorny@gentoo.org>,
        Sam James <sam@gentoo.org>
Subject: [PATCH] kheaders: prefer gtar over tar for better compatibility
Date:   Sat, 17 Dec 2022 09:41:55 +0100
Message-Id: <20221217084155.663235-1-mgorny@gentoo.org>
X-Mailer: git-send-email 2.39.0
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

To achieve better portability, try using `gtar` over `tar` if the former
is available.  This is the name frequently used on systems featuring
support for installing GNU tar alongside another tar implementation.
If `gtar` is not present, `tar` is used for compatibility with regular
systems.

Link: https://bugs.gentoo.org/884061
Reported-by: Sam James <sam@gentoo.org>
Tested-by: Sam James <sam@gentoo.org>
Signed-off-by: Michał Górny <mgorny@gentoo.org>
---
 kernel/gen_kheaders.sh | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 473036b43..d2445af7f 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -80,11 +80,20 @@ done | cpio --quiet -pdu $cpio_dir >/dev/null 2>&1
 find $cpio_dir -type f -print0 |
 	xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
 
+# The following tar invocations use options specific to GNU tar. On some
+# systems (e.g. Gentoo), `tar` can be a different tool (e.g. bsdtar), and GNU
+# tar can be found as `gtar`.
+if [ -x "$(command -v gtar)" ]; then
+	tar=gtar
+else
+	tar=tar
+fi
+
 # Create archive and try to normalize metadata for reproducibility.
 # For compatibility with older versions of tar, files are fed to tar
 # pre-sorted, as --sort=name might not be available.
 find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
-    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    $tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
     --owner=0 --group=0 --numeric-owner --no-recursion \
     -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
 
-- 
2.39.0

