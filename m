Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0060E6B6AE4
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 21:07:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbjCLUHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 16:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCLUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 16:07:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B892BEEE;
        Sun, 12 Mar 2023 13:07:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4FF7B80C63;
        Sun, 12 Mar 2023 20:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B51C433A0;
        Sun, 12 Mar 2023 20:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678651661;
        bh=eb6XlOAtcwsmZEKl2YAULQA72a4PFBl0XG4e86AOG7E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICqCjNzlG7BWQLdlKpX31emGfOIsOxMXT6zT8FxpAHcTHChHGk0bYhF7OmPqOuw2D
         2DyHUx7FZSQUNOUCXpCahhEGayoWM1xj87lExVQTn3tSkaGQSIH8Hn6aTG1F/fcWKq
         e7pE0cI5aErc9gg5AvEW6rBZ36cqmoc0dX7YvuBNp6T2YsOQyqyuYG31063hO2fqlS
         dgNPxn7QGynCuOUARe0F5qqKCChLundrYQ564n5WW+8112tkYIC7l+5pbcahPc7Bn7
         n7zjuBzgIP33jBSLtNR3MUeuF4auXvgn8sc2vhyHJ3DC7YASAdPxeKZNWQ0B0f28cV
         uAfScRKIPDnHQ==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/6] kbuild: deb-pkg: set CROSS_COMPILE only when undefined
Date:   Mon, 13 Mar 2023 05:07:28 +0900
Message-Id: <20230312200731.599706-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230312200731.599706-1-masahiroy@kernel.org>
References: <20230312200731.599706-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3ab18a625ce4 ("kbuild: deb-pkg: improve the usability of source
package") set needless CROSS_COMPILE.

For example, 'make allnoconfig bindeb-pkg' on a x86_64 system will set
CROSS_COMPILE=i686-linux-gnu-, where the biarch compiler 'gcc' should
work for building the i386 kernel.

  $ uname -m
  x86_64
  $ make allnoconfig bindeb-pkg >/dev/null
  dpkg-architecture: warning: specified GNU system type i686-linux-gnu does not match CC system type x86_64-linux-gnu, try setting a correct CC environment variable
   dpkg-source --before-build .
   debian/rules binary
  scripts/Kconfig.include:39: C compiler 'i686-linux-gnu-gcc' not found
  make[6]: *** [scripts/kconfig/Makefile:77: olddefconfig] Error 1
  make[5]: *** [Makefile:693: olddefconfig] Error 2
  make[4]: *** [Makefile:358: __build_one_by_one] Error 2
  make[3]: *** [debian/rules:7: build-arch] Error 2
  dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
  make[2]: *** [scripts/Makefile.package:127: bindeb-pkg] Error 2
  make[1]: *** [Makefile:1657: bindeb-pkg] Error 2
  make: *** [Makefile:358: __build_one_by_one] Error 2

Check whether CROSS_COMPILE is defined, instead of whether it is non-empty.

If you invoke debian/rules via Kbuild, CROSS_COMPILE is always defined
in the top Makefile.

Fixes: 3ab18a625ce4 ("kbuild: deb-pkg: improve the usability of source package")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/deb-build-option | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/package/deb-build-option b/scripts/package/deb-build-option
index bd53624318f2..7950eff01781 100755
--- a/scripts/package/deb-build-option
+++ b/scripts/package/deb-build-option
@@ -1,9 +1,8 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-only
 
-# Set up CROSS_COMPILE if we are cross-compiling, but not called from the
-# kernel toplevel Makefile
-if [ -z "${CROSS_COMPILE}${cross_compiling}" -a "${DEB_HOST_ARCH}" != "${DEB_BUILD_ARCH}" ]; then
+# Set up CROSS_COMPILE if not defined yet
+if [ "${CROSS_COMPILE+set}" != "set" -a "${DEB_HOST_ARCH}" != "${DEB_BUILD_ARCH}" ]; then
 	echo CROSS_COMPILE=${DEB_HOST_GNU_TYPE}-
 fi
 
-- 
2.34.1

