Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D489D682E05
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbjAaNdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjAaNdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:33:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF2F23C76;
        Tue, 31 Jan 2023 05:33:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B03EB81C95;
        Tue, 31 Jan 2023 13:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7705DC433EF;
        Tue, 31 Jan 2023 13:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675172020;
        bh=6Hx/Yl639gs12tAxrrRchm4lXuBjrnkbiP792+3ios0=;
        h=From:To:Cc:Subject:Date:From;
        b=gxAxcYeaUqyMFe6e/jBcqfq0uWYwq0vATyD9O3wKa13ubJc9WGsyrnKZdRiXI4VXI
         hgt9wqAogfJScOIsdtAksRFD4RA6jwT3aLkvF0mATVvUqfCfCK6PRjQB//ipGv8Tnr
         Wjt6HNH8V/XMAiA+tmiHUlP78dkRSgIbA5zgNO0U7PwARe8dmvMwh1Qm4U5BIgmomd
         KNpIUuUizU9hv2j+UnOU5Um3HJmSt2OyvOexEOAdIpdqIHpHRLyAKX9F+2ChTKABIf
         qojUpQblX5pD0vvGkDkCzmqRZiFsq9WdpjmlH5t1J0hfKF+u/JKl8nRg5fhNdZMtiZ
         8tR4sC/FknT0g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] setlocalversion: do not append git commit hash if localversion* exists
Date:   Tue, 31 Jan 2023 22:32:53 +0900
Message-Id: <20230131133253.1460560-1-masahiroy@kernel.org>
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

Since commit dcfbcb1033bb ("setlocalversion: use only the correct
release tag for git-describe"), KERNELRELEASE of linux-next is
annoyingly long:

  $ make kernelrelease
  6.2.0-rc6-next-20230131-09515-g80bd9028feca

The string '-09515-g80bd9028feca' is appended because git-describe now
uses the v6.2.0 tag instead of the next-20230113 tag.

In linux-next, the 'localversion-next' file well specifies the local
version, so the extra info from git is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/setlocalversion | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/scripts/setlocalversion b/scripts/setlocalversion
index e2b2d492ac13..4219a0ca1e62 100755
--- a/scripts/setlocalversion
+++ b/scripts/setlocalversion
@@ -113,22 +113,23 @@ if [ -z "${KERNELVERSION}" ]; then
 	exit 1
 fi
 
-res="${KERNELVERSION}"
-
 # localversion* files in the build and source directory
-res="${res}$(collect_files localversion*)"
+file_localversion="$(collect_files localversion*)"
 if test ! "$srctree" -ef .; then
-	res="$res$(collect_files "$srctree"/localversion*)"
+	file_localversion="${file_localversion}$(collect_files "$srctree"/localversion*)"
 fi
 
-# CONFIG_LOCALVERSION and LOCALVERSION (if set)
+# CONFIG_LOCALVERSION
 config_localversion=$(sed -n 's/^CONFIG_LOCALVERSION=\(.*\)$/\1/p' include/config/auto.conf)
-res="${res}${config_localversion}${LOCALVERSION}"
 
 # scm version string if not at the kernel version tag
-if grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
+if [ -n "${file_localversion}" ]; then
+	# If localversion* files exist (like in linux-next), the version is
+	# well specified. Do not append scm_version.
+	scm_version=
+elif grep -q "^CONFIG_LOCALVERSION_AUTO=y$" include/config/auto.conf; then
 	# full scm version string
-	res="$res$(scm_version)"
+	scm_version="$(scm_version)"
 elif [ "${LOCALVERSION+set}" != "set" ]; then
 	# If the variable LOCALVERSION is not set, append a plus
 	# sign if the repository is not in a clean annotated or
@@ -137,7 +138,7 @@ elif [ "${LOCALVERSION+set}" != "set" ]; then
 	#
 	# If the variable LOCALVERSION is set (including being set
 	# to an empty string), we don't want to append a plus sign.
-	res="$res$(scm_version --short)"
+	scm_version="$(scm_version --short)"
 fi
 
-echo "$res"
+echo "${KERNELVERSION}${file_localversion}${config_localversion}${LOCALVERSION}${scm_version}"
-- 
2.34.1

