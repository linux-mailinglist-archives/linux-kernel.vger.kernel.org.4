Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D2170AE3C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 15:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjEUNgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 09:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjEUN2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 09:28:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C9EAFA;
        Sun, 21 May 2023 06:24:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10B9360ACA;
        Sun, 21 May 2023 13:24:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C047C433D2;
        Sun, 21 May 2023 13:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684675482;
        bh=DGOor88cskTgt1c8gVoMlnt1QfpaP6hGJz8ZYo5w6lc=;
        h=From:To:Cc:Subject:Date:From;
        b=Tt7KZI5hZJV70VL4MLA/HN2UAQ7vEkWzOdPD2YxbpfObGzvWit2+MLsAeYDKqbLd1
         +WjaXjWoeKADF4PlC+R6tv9HwfzxAJAipac0HSmMtPO975XjRUfilLQdzhiW7iaPq0
         NK1wMT9rTvTpJ2NQjSNaEOlC18y6Zw3tZyUdUGz97nBoL6t+bOK0RunFNTSNaHoDud
         YiKr1CwOE37dsX8W0lf1ZbKzSWZ+ke1hqkLC82MlT/LYnLTDBJDBzTBXUrwDbwluvs
         akyX/913rsd53IW28t3/+IFPrTZBe4aRJhLC61SbNNiY/IMWoJqQHIL1tUkNTykeYF
         sj3giFPmlIo+g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] Revert "kheaders: substituting --sort in archive creation"
Date:   Sun, 21 May 2023 22:23:35 +0900
Message-Id: <20230521132336.1279523-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 700dea5a0bea9f64eba89fae7cb2540326fdfdc1.

The reason for that commit was --sort=ORDER introduced in
tar 1.28 (2014). More than 3 years have passed since then.

Requiring GNU tar 1.28 should be fine now because we require
GCC 5.1 (2015).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/gen_kheaders.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/gen_kheaders.sh b/kernel/gen_kheaders.sh
index 1ef9a87511f5..6d443ea22bb7 100755
--- a/kernel/gen_kheaders.sh
+++ b/kernel/gen_kheaders.sh
@@ -83,12 +83,9 @@ find $cpio_dir -type f -print0 |
 	xargs -0 -P8 -n1 perl -pi -e 'BEGIN {undef $/;}; s/\/\*((?!SPDX).)*?\*\///smg;'
 
 # Create archive and try to normalize metadata for reproducibility.
-# For compatibility with older versions of tar, files are fed to tar
-# pre-sorted, as --sort=name might not be available.
-find $cpio_dir -printf "./%P\n" | LC_ALL=C sort | \
-    tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
-    --owner=0 --group=0 --numeric-owner --no-recursion \
-    -I $XZ -cf $tarfile -C $cpio_dir/ -T - > /dev/null
+tar "${KBUILD_BUILD_TIMESTAMP:+--mtime=$KBUILD_BUILD_TIMESTAMP}" \
+    --owner=0 --group=0 --sort=name --numeric-owner \
+    -I $XZ -cf $tarfile -C $cpio_dir/ . > /dev/null
 
 echo $headers_md5 > kernel/kheaders.md5
 echo "$this_file_md5" >> kernel/kheaders.md5
-- 
2.39.2

