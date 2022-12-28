Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 597D065863F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 20:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiL1TKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 14:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiL1TKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 14:10:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C2314D2B;
        Wed, 28 Dec 2022 11:10:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92CF2615ED;
        Wed, 28 Dec 2022 19:10:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F2C6C433D2;
        Wed, 28 Dec 2022 19:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672254629;
        bh=NDaJHiYbI1eAcF8Qz6/6BoaxzjqK+j8AikgdtIirofo=;
        h=From:To:Cc:Subject:Date:From;
        b=YptHzzDmaVigBO+yhhTMg1gtUXHQ4eAYcGZp82FEDH4+2HHKwU5ot0I9TppGl+4lq
         UiKbytKGJL/J2WfCuECQdN6b7KbjwTG8AfuWXO08lsMY0ktQe/TgCmh1uBoHJXyReZ
         FmQysuNFOYEuUDh5Sm7Vfyx65ydxoU/BuHXDr1jNaf5xmtqX+fUQ12mRrRJz0VfRAx
         2UWS09DgMXBoC+855b7vhkq26FPlU8m2Zcv+iKk9ExdI2uMwPD3eAAqkFC8fk12w12
         271yV8gE/Hm4JtBwAlViPNv3g5uSCA0JJxbfcDgnL7LGgLRQ1VxRkqmxJdm8Y0XDqW
         /rchBx/pbsocw==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Ivan Vecera <ivecera@redhat.com>,
        Jonathan Toppins <jtoppins@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        =?UTF-8?q?=C3=8D=C3=B1igo=20Huguet?= <ihuguet@redhat.com>
Subject: [PATCH] kbuild: rpm-pkg: add libelf-devel as alternative for BuildRequires
Date:   Thu, 29 Dec 2022 04:10:14 +0900
Message-Id: <20221228191014.659746-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Guoqing Jiang reports that openSUSE cannot compile the kernel rpm due
to "BuildRequires: elfutils-libelf-devel" added by commit 8818039f959b
("kbuild: add ability to make source rpm buildable using koji").
The relevant package name in openSUSE is libelf-devel.

Add it an alternative package.

BTW, if it is impossible to solve the build requirement, the final
resort would be:

    $ make RPMOPTS=--nodeps rpm-pkg

This passes --nodeps to the rpmbuild command so it will not verify
build dependencies. This is useful to test rpm builds on non-rpm
system. On Debian/Ubuntu, for example, you can install rpmbuild by
'apt-get install rpm'.

NOTE1:
  Likewise, it is possible to bypass the build dependency check for
  debian package builds:

    $ make DPKG_FLAGS=-d deb-pkg

NOTE2:
  The 'or' operator is supported since RPM 4.13. So, old distros such
  as CentOS 7 will break. I suggest installing newer rpmbuild in such
  cases.

Link: https://lore.kernel.org/linux-kbuild/ee227d24-9c94-bfa3-166a-4ee6b5dfea09@linux.dev/T/#u
Fixes: 8818039f959b ("kbuild: add ability to make source rpm buildable using koji")
Reported-by: Guoqing Jiang <guoqing.jiang@linux.dev>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/mkspec | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/package/mkspec b/scripts/package/mkspec
index dda00a948a01..adab28fa7f89 100755
--- a/scripts/package/mkspec
+++ b/scripts/package/mkspec
@@ -51,7 +51,8 @@ sed -e '/^DEL/d' -e 's/^\t*//' <<EOF
 	URL: https://www.kernel.org
 $S	Source: kernel-$__KERNELRELEASE.tar.gz
 	Provides: $PROVIDES
-$S	BuildRequires: bc binutils bison dwarves elfutils-libelf-devel flex
+$S	BuildRequires: bc binutils bison dwarves
+$S	BuildRequires: (elfutils-libelf-devel or libelf-devel) flex
 $S	BuildRequires: gcc make openssl openssl-devel perl python3 rsync
 
 	# $UTS_MACHINE as a fallback of _arch in case
-- 
2.34.1

