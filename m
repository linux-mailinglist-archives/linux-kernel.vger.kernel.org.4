Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290106B065E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjCHLxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:53:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbjCHLxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:53:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC419ED7;
        Wed,  8 Mar 2023 03:52:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 819206176B;
        Wed,  8 Mar 2023 11:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F03BC4339E;
        Wed,  8 Mar 2023 11:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678276378;
        bh=DuoivBb2Ni55n4AFx8endkrW+/Kl+HHtMvz18aW6xeQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgJsNJ9NGSDlsj5g3Jb9yWN/CmyktGdnhQLccuksOSSvVLHuF/Q9OmsQgSPK/9ZWa
         G5zOdxaSw4exdJAs4NaMs14+e40IZqK7M70W3Bu+peo7HGqVzCLZQh7mngJVHa0bYO
         2opFAp188IG94eJEzEzASwVaEDkf090H1QcIrskjSF88xTcRmyaKpJWDm28SrAjm3Y
         8OncH3KIp6MIOZ9/JQa23fWX9oYJEA4WrchQnO+CympTiPdsTEiNe4jtS22CBUHEce
         Xw0tH+/ZemKrJIkxKOQeYaEe+n9G5RF/L8ZRIalcgnOCZqUv2iVc+e/5cppw8meEDK
         garFmig1nkMtA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 3/8] scripts/mksysmap: use sed with in-line comments
Date:   Wed,  8 Mar 2023 20:52:38 +0900
Message-Id: <20230308115243.82592-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230308115243.82592-1-masahiroy@kernel.org>
References: <20230308115243.82592-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move comments close to the code.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mksysmap | 61 +++++++++++++++++++++++++++++-------------------
 1 file changed, 37 insertions(+), 24 deletions(-)

diff --git a/scripts/mksysmap b/scripts/mksysmap
index 697fc6653953..8ea1955e03c6 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -10,32 +10,45 @@
 #####
 # Generate System.map (actual filename passed as second argument)
 
-# For System.map filter away:
-#   a - local absolute symbols
-#   U - undefined global symbols
-#   N - debugging symbols
-#   w - local weak symbols
-
 # readprofile starts reading symbols when _stext is found, and
 # continue until it finds a symbol which is not either of 'T', 't',
 # 'W' or 'w'.
 #
-# Ignored prefixes:
-#  $                    - local symbols for ARM, MIPS, etc.
-#  .L                   - local labels, .LBB,.Ltmpxxx,.L__unnamed_xx,.LASANPC, etc.
-#  __crc_               - modversions
-#  __kstrtab_           - EXPORT_SYMBOL (symbol name)
-#  __kstrtabns_         - EXPORT_SYMBOL (namespace)
+
+${NM} -n ${1} | sed >${2} -e "
+# ---------------------------------------------------------------------------
+# Ignored symbol types
 #
-# Ignored symbols:
-#  L0                   - for LoongArch?
-
-$NM -n $1 | grep -v		\
-	-e ' [aNUw] '		\
-	-e ' \$'		\
-	-e ' \.L'		\
-	-e ' __crc_'		\
-	-e ' __kstrtab_'	\
-	-e ' __kstrtabns_'	\
-	-e ' L0$'		\
-> $2
+
+# a: local absolute symbols
+# N: debugging symbols
+# U: undefined global symbols
+# w: local weak symbols
+/ [aNUw] /d
+
+# ---------------------------------------------------------------------------
+# Ignored prefixes
+#  (do not forget a space before each pattern)
+
+# local symbols for ARM, MIPS, etc.
+/ \$/d
+
+# local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
+/ \.L/d
+
+# CRC from modversions
+/ __crc_/d
+
+# EXPORT_SYMBOL (symbol name)
+/ __kstrtab_/d
+
+# EXPORT_SYMBOL (namespace)
+/ __kstrtabns_/d
+
+# ---------------------------------------------------------------------------
+# Ignored symbols (exact match)
+#  (do not forget a space before and '$' after each pattern)
+
+# for LoongArch?
+/ L0$/d
+"
-- 
2.34.1

