Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA346C3990
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:52:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjCUSwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCUSwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:52:07 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 11:52:06 PDT
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F3932138;
        Tue, 21 Mar 2023 11:52:05 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (2600-6c67-5000-0a52-c52e-ada9-d81f-68db.res6.spectrum.com [IPv6:2600:6c67:5000:a52:c52e:ada9:d81f:68db])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 07BE037D9498;
        Tue, 21 Mar 2023 18:36:38 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id 98152130075A; Tue, 21 Mar 2023 12:36:36 -0600 (MDT)
From:   Kevin Locke <kevin@kevinlocke.name>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: deb-pkg: set version for linux-headers paths
Date:   Tue, 21 Mar 2023 12:36:25 -0600
Message-Id: <4a55805c694cff4cc9281961f2d457262bea48e6.1679423785.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a result of the switch to dh_listpackages, $version is no longer set
when install_kernel_headers() is called.  This causes files in the
linux-headers deb package to be installed to a path with an empty
$version (e.g. /usr/src/linux-headers-/scripts/sign-file rather than
/usr/src/linux-headers-6.3.0-rc3/scripts/sign-file).

To avoid this, while continuing to use the version information from
dh_listpackages, set $version from $package.

Fixes: 36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know enabled packages")
Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
---
 scripts/package/builddeb | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index c5ae57167d7c..6fd590437f47 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -229,6 +229,7 @@ do
 	linux-libc-dev)
 		install_libc_headers debian/linux-libc-dev;;
 	linux-headers-*)
+		version=${package#linux-headers-}
 		install_kernel_headers debian/linux-headers;;
 	esac
 done
-- 
2.39.2

