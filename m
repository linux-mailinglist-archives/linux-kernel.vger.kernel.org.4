Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6845A676D7F
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjAVOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 09:14:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjAVOOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 09:14:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8D7610406;
        Sun, 22 Jan 2023 06:14:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 96ADAB80AE0;
        Sun, 22 Jan 2023 14:14:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6661BC433D2;
        Sun, 22 Jan 2023 14:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674396876;
        bh=SlZozu6ilR07Tjhnx/kZyFTMO+EN6Gn/UTedC9bFFfQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fJ0O049/CuHxs0De475Oabnp1r21608SN07nlFaFJlkyHVEzeMQ4/Z3E0P+a0z1jh
         NLX2aRwzUDqOP2P35CBFj7fbVuQl6mqGevmRlXVKernXyqTdyZfw12V+KoY0Moxq1Q
         1DtqvrMY7zDrmiAnPD/Y2fKSs3HT9GRXaHiZHcIDI2wM1se8CEje/TrLhVtdmSjsl+
         /gv789zFRyK86qCAamcAPM2sH6Afgo/Kz1VqhXY49zzC0FoIYU5HOOe8yHyTSHi+O8
         aGGk9ZYGVX//PKLoXvFoGoW+C892PNj+SfnEKKEz8Cc8JejPXcxEYcnTB91nGpXZ9Q
         Q4n2tYDf3gNUg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/7] setlocalversion: make indentation shallower
Date:   Sun, 22 Jan 2023 23:14:23 +0900
Message-Id: <20230122141428.115372-3-masahiroy@kernel.org>
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

Return earlier if we are not in the correct git repository. This makes
the code more readable.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/setlocalversion | 79 +++++++++++++++++++++--------------------
 1 file changed, 41 insertions(+), 38 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index 5cdf409204aa..b8e1018d611e 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -34,46 +34,49 @@ scm_version()
 		short=true
 	fi
 
-	# Check for git and a git repo.
-	if test -z "$(git rev-parse --show-cdup 2>/dev/null)" &&
-	   head=$(git rev-parse --verify HEAD 2>/dev/null); then
-
-		# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore
-		# it, because this version is defined in the top level Makefile.
-		if [ -z "$(git describe --exact-match 2>/dev/null)" ]; then
-
-			# If only the short version is requested, don't bother
-			# running further git commands
-			if $short; then
-				echo "+"
-				return
-			fi
-			# If we are past a tagged commit (like
-			# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
-			if atag="$(git describe 2>/dev/null)"; then
-				echo "$atag" | awk -F- '{printf("-%05d", $(NF-1))}'
-			fi
-
-			# Add -g and exactly 12 hex chars.
-			printf '%s%s' -g "$(echo $head | cut -c1-12)"
-		fi
+	if test -n "$(git rev-parse --show-cdup 2>/dev/null)"; then
+		return
+	fi
+
+	if ! head=$(git rev-parse --verify HEAD 2>/dev/null); then
+		return
+	fi
+
+	# If we are at a tagged commit (like "v2.6.30-rc6"), we ignore it
+	# because this version is defined in the top level Makefile.
+	if [ -z "$(git describe --exact-match 2>/dev/null)" ]; then
 
-		# Check for uncommitted changes.
-		# This script must avoid any write attempt to the source tree,
-		# which might be read-only.
-		# You cannot use 'git describe --dirty' because it tries to
-		# create .git/index.lock .
-		# First, with git-status, but --no-optional-locks is only
-		# supported in git >= 2.14, so fall back to git-diff-index if
-		# it fails. Note that git-diff-index does not refresh the
-		# index, so it may give misleading results. See
-		# git-update-index(1), git-diff-index(1), and git-status(1).
-		if {
-			git --no-optional-locks status -uno --porcelain 2>/dev/null ||
-			git diff-index --name-only HEAD
-		} | read dummy; then
-			printf '%s' -dirty
+		# If only the short version is requested, don't bother
+		# running further git commands
+		if $short; then
+			echo "+"
+			return
 		fi
+		# If we are past a tagged commit (like
+		# "v2.6.30-rc5-302-g72357d5"), we pretty print it.
+		if atag="$(git describe 2>/dev/null)"; then
+			echo "$atag" | awk -F- '{printf("-%05d", $(NF-1))}'
+		fi
+
+		# Add -g and exactly 12 hex chars.
+		printf '%s%s' -g "$(echo $head | cut -c1-12)"
+	fi
+
+	# Check for uncommitted changes.
+	# This script must avoid any write attempt to the source tree, which
+	# might be read-only.
+	# You cannot use 'git describe --dirty' because it tries to create
+	# .git/index.lock .
+	# First, with git-status, but --no-optional-locks is only supported in
+	# git >= 2.14, so fall back to git-diff-index if it fails. Note that
+	# git-diff-index does not refresh the index, so it may give misleading
+	# results.
+	# See git-update-index(1), git-diff-index(1), and git-status(1).
+	if {
+		git --no-optional-locks status -uno --porcelain 2>/dev/null ||
+		git diff-index --name-only HEAD
+	} | read dummy; then
+		printf '%s' -dirty
 	fi
 }
 
-- 
2.34.1

