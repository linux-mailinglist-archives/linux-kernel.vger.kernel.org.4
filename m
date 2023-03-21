Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB066C3CDD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 22:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCUVjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 17:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCUVjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 17:39:43 -0400
Received: from vulcan.kevinlocke.name (vulcan.kevinlocke.name [107.191.43.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F50F13504;
        Tue, 21 Mar 2023 14:39:41 -0700 (PDT)
Received: from kevinolos.kevinlocke.name (2600-6c67-5000-0a52-0183-7c34-952d-b30a.res6.spectrum.com [IPv6:2600:6c67:5000:a52:183:7c34:952d:b30a])
        (Authenticated sender: kevin@kevinlocke.name)
        by vulcan.kevinlocke.name (Postfix) with ESMTPSA id 5D97537D9B56;
        Tue, 21 Mar 2023 21:39:37 +0000 (UTC)
Received: by kevinolos.kevinlocke.name (Postfix, from userid 1000)
        id EDD221300353; Tue, 21 Mar 2023 15:39:35 -0600 (MDT)
From:   Kevin Locke <kevin@kevinlocke.name>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kbuild: deb-pkg: set version for linux-headers paths
Date:   Tue, 21 Mar 2023 15:39:22 -0600
Message-Id: <3351f907cfd0b5d8372e858a8ec9065cc2bd91df.1679434718.git.kevin@kevinlocke.name>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <4a55805c694cff4cc9281961f2d457262bea48e6.1679423785.git.kevin@kevinlocke.name>
References: <4a55805c694cff4cc9281961f2d457262bea48e6.1679423785.git.kevin@kevinlocke.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
dh_listpackages, pass $version from $package as the second argument
of install_kernel_headers().

Fixes: 36862e14e316 ("kbuild: deb-pkg: use dh_listpackages to know enabled packages")
Signed-off-by: Kevin Locke <kevin@kevinlocke.name>
---
Good idea!  Thanks for the quick review and feedback.  Here's an updated
version.

Changes since v1:
 * Pass version as the second argument to install_kernel_headers(),
   rather than as a global variable, as suggested by Masahiro Yamada.

 scripts/package/builddeb | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/package/builddeb b/scripts/package/builddeb
index c5ae57167d7c..7b23f52c70c5 100755
--- a/scripts/package/builddeb
+++ b/scripts/package/builddeb
@@ -162,6 +162,7 @@ install_linux_image_dbg () {
 
 install_kernel_headers () {
 	pdir=$1
+	version=$2
 
 	rm -rf $pdir
 
@@ -229,7 +230,7 @@ do
 	linux-libc-dev)
 		install_libc_headers debian/linux-libc-dev;;
 	linux-headers-*)
-		install_kernel_headers debian/linux-headers;;
+		install_kernel_headers debian/linux-headers ${package#linux-headers-};;
 	esac
 done
 
-- 
2.39.2

