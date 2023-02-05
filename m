Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A0268AFA9
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 13:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjBEMKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 07:10:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBEMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 07:10:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03940DBE8;
        Sun,  5 Feb 2023 04:10:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE1AAB80B6B;
        Sun,  5 Feb 2023 12:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 789CEC4339C;
        Sun,  5 Feb 2023 12:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675599003;
        bh=9Lq+dA/X8Mk8nbh6bmpHI5Xt3zG/oryRxAEDv7XBe+A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MnBTB6c1gjPUaj7mhIPHDrYzmTeDCXPIMmex4OYyV+7H2V8TBBs9laXSYXESCKKDS
         auZRjdMhAwLSVtZQbHHgL2qCb7pqfUIWXQO4Je/EvrViIAL/Gu6rZ1jHT/8K3MRJQe
         d4iWfNKmLgKIlc5uOqLMa0fnmvxSGZ62nWe/DedTwPjXQ6cLgUj+SaoZijmo0s9V9n
         3ONNi17qgWIK5axwmVKdBsxtZOTUE0+BiITAjrWEevh7Pa1Vbracctir5QaL6Bdqm5
         B8g4pnISAmIQIvrtKcFOeH4xTzorY4pqn18k3k0R98GpQBRIn9t/A4SLSXnAGP/dj8
         SoH+4k0ojhGDA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/2] setlocalversion: use only the correct release tag for git-describe
Date:   Sun,  5 Feb 2023 21:09:57 +0900
Message-Id: <20230205120957.2461529-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230205120957.2461529-1-masahiroy@kernel.org>
References: <20230205120957.2461529-1-masahiroy@kernel.org>
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
  $ make -s defconfig kernelrelease
  6.1.0-14595-g292a089d78d3
  $ git tag -a foo -m foo
  $ make -s kernelrelease
  6.1.0

If a local tag 'foo' exists, it pretends to be a released version
'6.1.0', while there are many commits on top of it.

The output should be consistent irrespective of such a local tag.
Pass the correct release tag to --match option of git-describe.

In the mainline kernel, the SUBLEVEL is always '0', which is omitted
from the tag.

  KERNELVERSION      annotated tag
  6.1.0          ->  v6.1            (mainline)
  6.2.0-rc5      ->  v6.2-rc5        (mainline, release candidate)
  6.1.7          ->  v6.1.7          (stable)

To preserve the behavior in linux-next, use the tag derived from
localversion* files if exists. In linux-next, the local version is
specified by the localversion-next file.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/setlocalversion | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 7e2c83f5c50d..f26f082c7d6a 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -27,6 +27,7 @@ fi
 scm_version()
 {
 	local short
+	local tag
 	short=false
 
 	cd "$srctree"
@@ -42,9 +43,21 @@ scm_version()
 		return
 	fi
 
-	# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore it
-	# because this version is defined in the top level Makefile.
-	if [ -z "$(git describe --exact-match 2>/dev/null)" ]; then
+	# If a localversion*' file and the corresponding annotated tag exist,
+	# use it. This is the case for linux-next.
+	tag=${file_localversion#-}
+	tag=$(git describe --exact-match --match=$tag $tag 2>/dev/null)
+
+	# If not, default to the annotated tag derived from KERNELVERSION.
+	#   mainline kernel:  6.2.0-rc5  ->  v6.2-rc5
+	#   stable kernel:    6.1.7      ->  v6.1.7
+	if [ -z "${tag}" ]; then
+		tag=v$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0-9]+)\.0(.*)$/\1\2/')
+	fi
+
+	# If we are at a tagged commit and the tag matches the version defined
+	# in the top level Makefile, we ignore it.
+	if [ -z "$(git describe --exact-match --match=$tag 2>/dev/null)" ]; then
 
 		# If only the short version is requested, don't bother
 		# running further git commands
@@ -52,9 +65,9 @@ scm_version()
 			echo "+"
 			return
 		fi
-		# If we are past a tagged commit (like
-		# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
-		if atag="$(git describe 2>/dev/null)"; then
+		# If we are past the tagged commit, we pretty print it.
+		# (like 6.1.0-14595-g292a089d78d3)
+		if atag="$(git describe --match=$tag 2>/dev/null)"; then
 			echo "$atag" | awk -F- '{printf("-%05d", $(NF-1))}'
 		fi
 
@@ -116,7 +129,7 @@ fi
 # version string from CONFIG_LOCALVERSION
 config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf)
 
-# scm version string if not at a tagged commit
+# scm version string if not at the kernel version tag or at the file_localversion
 if grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
 	# full scm version string
 	scm_version="$(scm_version)"
-- 
2.34.1

