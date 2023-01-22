Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A60676D80
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbjAVOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:14:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjAVOOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:14:39 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633911027D;
        Sun, 22 Jan 2023 06:14:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09F5860C27;
        Sun, 22 Jan 2023 14:14:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A678AC433EF;
        Sun, 22 Jan 2023 14:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674396877;
        bh=y+Ug4suYHYeIMApo2ZM/VY4lgUs7HsilGboGF3UyoLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S8M+/49bxCSUvlkbHHFeQYPCjAx0oTxw9MI29v3hNlenmYLHrCc8ueuI8kZW9C1b+
         Y8YhtCIJ+TQcdYKrpbp4AafnL51606dLNskej/AJKFXEe3YLU7JsloNheDIdJjDzxJ
         Rdzep00ey8GjRSuHWWskMiO1Jh1qi7H+ZESkNeHQIOX763R+cDXOBvwUCyI/CULCyi
         nlExDe4M8WHRDHxqAdin1ui8ewn3jYUYY8fLyEmwFp1WhPrVfRt0diF33CvSBr2dxN
         BhId8tgSSJPS3uX3RLtvdm+TKz/XJqS4L8PlWMEyenOc0HWCMjeAdQBHTOMFxg5F9N
         Pp+tjPJ3K0pIA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 4/7] setlocalversion: use only the correct release tag for git-describe
Date:   Sun, 22 Jan 2023 23:14:24 +0900
Message-Id: <20230122141428.115372-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230122141428.115372-1-masahiroy@kernel.org>
References: <20230122141428.115372-1-masahiroy@kernel.org>
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

Currently, setlocalversion uses any annotated tag for git-describe.
If we are at a tagged commit, it will not append the commit hash.

  $ git checkout v6.2-rc1^
  $ make -s defconfig prepare
  $ make kernelrelease
  6.1.0-14595-g292a089d78d3
  $ git tag -a foo -m foo
  $ make kernelrelease
  6.1.0

If a local tag 'foo' exists, it pretends to be a released version
'6.1.0', while there are many commits on top of it.

The output should be consistent irrespective of such a local tag.
Pass the correct release tag to --match option of git-describe.

In the mainline kernel, the SUBLEVEL is always '0' but it is omitted
from the tag.

  version         tag
  6.1.0      ->   v6.1        (mainline)
  6.2.0-rc5  ->   v6.2-rc5    (mainline, release candidate)
  6.1.7      ->   v6.1.7      (stable)

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/setlocalversion | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index b8e1018d611e..a4c9a61b0665 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -27,6 +27,7 @@ fi
 scm_version()
 {
 	local short
+	local tag
 	short=false
 
 	cd "$srctree"
@@ -42,9 +43,14 @@ scm_version()
 		return
 	fi
 
-	# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore it
-	# because this version is defined in the top level Makefile.
-	if [ -z "$(git describe --exact-match 2>/dev/null)" ]; then
+	# convert the version to a tag
+	#   mainline kernel:  6.2.0-rc5  ->  v6.2-rc5
+	#   stable kernel:    6.1.7      ->  v6.1.7
+	tag=v$(echo "${KERNELVERSION}" | sed 's/^\(.*\..*\)\.0\(.*\)$/\1\2/')
+
+	# If we are at a tagged commit and the tag matches the version defined
+	# in the top level Makefile, we ignore it.
+	if [ -z "$(git describe --exact-match --match=$tag 2>/dev/null)" ]; then
 
 		# If only the short version is requested, don't bother
 		# running further git commands
@@ -52,9 +58,9 @@ scm_version()
 			echo "+"
 			return
 		fi
-		# If we are past a tagged commit (like
-		# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
-		if atag="$(git describe 2>/dev/null)"; then
+		# If we are past the release tag, we pretty print it.
+		# (like 6.1.0-14595-g292a089d78d3)
+		if atag="$(git describe --match=$tag 2>/dev/null)"; then
 			echo "$atag" | awk -F- '{printf("-%05d", $(NF-1))}'
 		fi
 
@@ -102,6 +108,11 @@ if ! test -e include/config/auto.conf; then
 	exit 1
 fi
 
+if [ -z "${KERNELVERSION}" ]; then
+	echo "KERNELVERSION is not set" >&2
+	exit 1
+fi
+
 # localversion* files in the build and source directory
 res="$(collect_files localversion*)"
 if test ! "$srctree" -ef .; then
-- 
2.34.1

