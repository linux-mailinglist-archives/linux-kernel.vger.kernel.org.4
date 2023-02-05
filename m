Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87468AFA8
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Feb 2023 13:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBEMKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 07:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjBEMKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 07:10:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA46B5B93;
        Sun,  5 Feb 2023 04:10:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72E22B80B73;
        Sun,  5 Feb 2023 12:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EADBC433D2;
        Sun,  5 Feb 2023 12:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675599002;
        bh=uct15EL66AH47wSqG1AkK3QEEL42IAmhKkIX/8YWyAU=;
        h=From:To:Cc:Subject:Date:From;
        b=pFxAcQh4Lx+tsNpgk+3XUMkFgHATrB+Rr9nQnMnTEpdstbFX3tu/1g9hdtbEHYvE0
         PBeggdp42133KlN12ViLpFORd3q+7/wVmZoAN9sSxlqt463U5u/+5llakIf6geLNkE
         9QAXGfl/txf24+HG3i7tw3ib5xXEvuuD4ZSOviABsjur98xzcfNFdueL2NKtyYfArW
         zz70WZIiBchVJZOx8qG4FkQO8hM5OWGeDnKWDPWVR1451YvTmmpQXkkSxDkdL/ud9J
         gOMlLCOXLr4mjKc+9wbUcjUKuVRUVl5FlgjMqEGtdYJMMoVmDkuehrqVqgPWJd3RE5
         4XaFU1kyUmF6Q==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/2] setlocalversion: clean up the construction of version output
Date:   Sun,  5 Feb 2023 21:09:56 +0900
Message-Id: <20230205120957.2461529-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Concatenate all components in the last line instead of accumulating
them into the 'res' variable.

No functional change is intended. A preparation for the next change.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/setlocalversion | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index ad72ea2c8228..7e2c83f5c50d 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -108,19 +108,18 @@ if [ -z "${KERNELVERSION}" ]; then
 fi
 
 # localversion* files in the build and source directory
-res="$(collect_files localversion*)"
+file_localversion="$(collect_files localversion*)"
 if test ! "$srctree" -ef .; then
-	res="$res$(collect_files "$srctree"/localversion*)"
+	file_localversion="${file_localversion}$(collect_files "$srctree"/localversion*)"
 fi
 
-# CONFIG_LOCALVERSION and LOCALVERSION (if set)
+# version string from CONFIG_LOCALVERSION
 config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf)
-res="${res}${config_localversion}${LOCALVERSION}"
 
 # scm version string if not at a tagged commit
 if grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
 	# full scm version string
-	res="$res$(scm_version)"
+	scm_version="$(scm_version)"
 elif [ "${LOCALVERSION+set}" != "set" ]; then
 	# If the variable LOCALVERSION is not set, append a plus
 	# sign if the repository is not in a clean annotated or
@@ -129,7 +128,7 @@ elif [ "${LOCALVERSION+set}" != "set" ]; then
 	#
 	# If the variable LOCALVERSION is set (including being set
 	# to an empty string), we don't want to append a plus sign.
-	res="$res$(scm_version --short)"
+	scm_version="$(scm_version --short)"
 fi
 
-echo "${KERNELVERSION}${res}"
+echo "${KERNELVERSION}${file_localversion}${config_localversion}${LOCALVERSION}${scm_version}"
-- 
2.34.1

