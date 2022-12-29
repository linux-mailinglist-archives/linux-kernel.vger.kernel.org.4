Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39943658A10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 08:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbiL2HoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 02:44:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbiL2Hnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 02:43:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D89FD3;
        Wed, 28 Dec 2022 23:43:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E65386170C;
        Thu, 29 Dec 2022 07:43:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3E0C433D2;
        Thu, 29 Dec 2022 07:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672299810;
        bh=/mTmrBpGVR4tHpil4FIqdwtv6srLo9Xnga3QkS7c6QQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FlqslimJZoIeBn+FrqTdBOBuFMPmaZN6s2NfM7h++iksFK0Zp4luuvQTCKa6Zwosm
         ShF07zAQsN11sK8jNuRVcc7h73IWcywsc3r0QfCpQmqoXyNQuz9ilOMyZGozbcPJkY
         3XGLTedCy75KtsFWb1/GOLhjRLPR1OlmoHNy0FInREsa9z6RBDn9roy3lSCtl8NnZs
         63M28ALmLFceylC+ruLSsaWEwAjZMLUnA14zDMIMjHrcthe4z+FvLOz/UKrSmhn29s
         hUoiHRZHZSIudNBpW4zDT9eFyU0LPMvuRpRAjS8Aba92jtdlbDU0T+lomB0OrpxGcm
         D2GkXunoyzudg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v3 2/2] kbuild: make W=1 warn files that are tracked but ignored by git
Date:   Thu, 29 Dec 2022 16:43:10 +0900
Message-Id: <20221229074310.906556-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221229074310.906556-1-masahiroy@kernel.org>
References: <20221229074310.906556-1-masahiroy@kernel.org>
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

The top .gitignore comments about how to detect files breaking
.gitignore rules, but people rarely care about it.

Add a new W=1 warning to detect files that are tracked but ignored by
git. If git is not installed or the source tree is not tracked by git
at all, this script does not print anything.

Running it on v6.2-rc1 detected the following:

  $ make W=1 misc-check
  Documentation/devicetree/bindings/.yamllint: warning: ignored by one of the .gitignore files
  drivers/clk/.kunitconfig: warning: ignored by one of the .gitignore files
  drivers/gpu/drm/tests/.kunitconfig: warning: ignored by one of the .gitignore files
  drivers/hid/.kunitconfig: warning: ignored by one of the .gitignore files
  fs/ext4/.kunitconfig: warning: ignored by one of the .gitignore files
  fs/fat/.kunitconfig: warning: ignored by one of the .gitignore files
  kernel/kcsan/.kunitconfig: warning: ignored by one of the .gitignore files
  lib/kunit/.kunitconfig: warning: ignored by one of the .gitignore files
  mm/kfence/.kunitconfig: warning: ignored by one of the .gitignore files
  tools/testing/selftests/arm64/tags/.gitignore: warning: ignored by one of the .gitignore files
  tools/testing/selftests/arm64/tags/Makefile: warning: ignored by one of the .gitignore files
  tools/testing/selftests/arm64/tags/run_tags_test.sh: warning: ignored by one of the .gitignore files
  tools/testing/selftests/arm64/tags/tags_test.c: warning: ignored by one of the .gitignore files

These are ignored by the '.*' or 'tags' in the top .gitignore, but
there is no rule to negate it.

You might be tempted to do 'git add -f' but I want to have the real
issue fixed (by fixing a .gitignore, or by renaming files, etc.).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---

Changes in v3:
  - change working directory to srctree (Nicolas)

Changes in v2:
  - Add $(srctree)/ to make it work with O=

 Makefile           |  6 ++++++
 scripts/misc-check | 19 +++++++++++++++++++
 2 files changed, 25 insertions(+)
 create mode 100755 scripts/misc-check

diff --git a/Makefile b/Makefile
index acce5ec514f6..c0d7c75d8f14 100644
--- a/Makefile
+++ b/Makefile
@@ -1848,6 +1848,12 @@ rust-analyzer:
 # Misc
 # ---------------------------------------------------------------------------
 
+PHONY += misc-check
+misc-check:
+	$(Q)$(srctree)/scripts/misc-check
+
+all: misc-check
+
 PHONY += scripts_gdb
 scripts_gdb: prepare0
 	$(Q)$(MAKE) $(build)=scripts/gdb
diff --git a/scripts/misc-check b/scripts/misc-check
new file mode 100755
index 000000000000..d40d5484e0c5
--- /dev/null
+++ b/scripts/misc-check
@@ -0,0 +1,19 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-only
+
+set -e
+
+# Detect files that are tracked but ignored by git. This is checked only when
+# ${KBUILD_EXTRA_WARN} contains 1, git is installed, and the source tree is
+# tracked by git.
+check_tracked_ignored_files () {
+	case "${KBUILD_EXTRA_WARN}" in
+	*1*) ;;
+	*) return;;
+	esac
+
+	git -C ${srctree:-.} ls-files -i -c --exclude-per-directory=.gitignore 2>/dev/null |
+		sed 's/$/: warning: ignored by one of the .gitignore files/' >&2
+}
+
+check_tracked_ignored_files
-- 
2.34.1

