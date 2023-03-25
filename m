Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611616C8EC9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 15:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbjCYOTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 10:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjCYOTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 10:19:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA061114B;
        Sat, 25 Mar 2023 07:19:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 883AB60C6C;
        Sat, 25 Mar 2023 14:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A3D6C433D2;
        Sat, 25 Mar 2023 14:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679753956;
        bh=5QjzAdbwAc0VpltsXBqbvPGXjoKOMT/y6u/uaixI0GM=;
        h=From:To:Cc:Subject:Date:From;
        b=d6k+DhKOvruw0egjMdatWqCIm8t9wwp/hbNrSwBDGJ4zak4fS1/vrm+THCRoq0yXa
         JzShFpPIn2NLWRrsvNzSGAqgHiB3QrmoELVFGAVb28ImE/BECymAU8+6h8OK0pQDx/
         KIVuEqy0Pfq7rYbahhnvQSMuhywzmqgOh5eVIxT52rUaderVuj0oN25UdofXVNzSOz
         JBh8OAzQ1LLxRzN9FXMFmrQ8LEDCypDaJaqTOY0rq5mlHKNZVOUapCE+9COHqT4of5
         Qn27DKbzgn2WM7Hf08A4ixZkxZ3UnTvra4m+cLSkjGOgKvGfRXnLsx0y0THh6Fyi+g
         bEdDA5fIEHytg==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH] kbuild: fix package build error due to broken symlinks
Date:   Sat, 25 Mar 2023 23:19:09 +0900
Message-Id: <20230325141909.2512452-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'make deb-pkg' and 'make rpm-pkg' fail if a broken symlink exists in
a dirty source tree. Handle symlinks properly, and also, keep the
executable permission.

Fixes: 05e96e96a315 ("kbuild: use git-archive for source package creation")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/gen-diff-patch | 36 +++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/scripts/package/gen-diff-patch b/scripts/package/gen-diff-patch
index f842ab50a780..23551de92e1b 100755
--- a/scripts/package/gen-diff-patch
+++ b/scripts/package/gen-diff-patch
@@ -23,16 +23,34 @@ fi
 git -C ${srctree} status --porcelain --untracked-files=all |
 while read stat path
 do
-	if [ "${stat}" = '??' ]; then
-
-		if ! diff -u /dev/null "${srctree}/${path}" > .tmp_diff &&
-			! head -n1 .tmp_diff | grep -q "Binary files"; then
-			{
-				echo "--- /dev/null"
-				echo "+++ linux/$path"
-				cat .tmp_diff | tail -n +3
-			} >> ${untracked_patch}
+	if [ "${stat}" != '??' ]; then
+		continue
+	fi
+
+	if [ -L "${path}" ]; then
+		{
+			echo "diff --git a/${path} b/${path}"
+			echo "new file mode 120000"
+			echo "--- /dev/null"
+			echo "+++ b/$path"
+			echo "@@ -0,0 +1 @@"
+			printf "+"; readlink ${path}
+			echo '\ No newline at end of file'
+		} >> ${untracked_patch}
+	elif ! diff -u /dev/null "${srctree}/${path}" > .tmp_diff &&
+	     ! head -n1 .tmp_diff | grep -q "Binary files"; then
+		if [ -x ${path} ]; then
+			mode=100755
+		else
+			mode=100644
 		fi
+		{
+			echo "diff --git a/${path} b/${path}"
+			echo "new file mode ${mode}"
+			echo "--- /dev/null"
+			echo "+++ b/$path"
+			cat .tmp_diff | tail -n +3
+		} >> ${untracked_patch}
 	fi
 done
 
-- 
2.34.1

