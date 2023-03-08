Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C6D6B0662
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:53:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCHLxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:53:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230367AbjCHLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:53:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FFF42BD8;
        Wed,  8 Mar 2023 03:53:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87BF2615EB;
        Wed,  8 Mar 2023 11:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBB95C43445;
        Wed,  8 Mar 2023 11:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678276385;
        bh=x4NdmLNpKer8WoqTYRuQhcNBJO8WGAf/8/P+yX6tpcM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WfwbJYJ9KCfJ0Rfwc4cxTT23fpofjgLd7dGmAbnlwFL5sbDjWD9DtaHM3/MyBbPwm
         wW4IV2zH9Gu0c37qm8pTkm2t5KQuPv+le3C5KwV/858ZUDIGaA3vUy3UQYYX38PUQ/
         4jkOQDwRzbZ7JGK8qzSNSZRSHz/z/sBdabOyvYAYZCD5JUchj/52jdNMY/OMlMcFVj
         i0tyfkHvc9R29p9a32IL0MaEYck1Fs/acwdU8KxrBTzltkcsyVlqrXv+Ml1mSAsenu
         EO/RUAdahhV1uTf4Ud89UTj7/5QcOF6zBJY6S8gYt+KkqT3LnGmAHXcrSuXfFPNELn
         ztJJJPV0e0V7A==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 5/8] scripts/kallsyms: move compiler-generated symbol patterns to mksysmap
Date:   Wed,  8 Mar 2023 20:52:40 +0900
Message-Id: <20230308115243.82592-5-masahiroy@kernel.org>
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

scripts/kallsyms.c maintains compiler-generated symbols, but we end up
with something similar in scripts/mksysmap to avoid the "Inconsistent
kallsyms data" error. For example, commit c17a2538704f ("mksysmap: Fix
the mismatch of 'L0' symbols in System.map").

They were separately maintained prior to commit 94ff2f63d6a3 ("kbuild:
reuse mksysmap output for kallsyms").

Now that scripts/kallsyms.c parses the output of scripts/mksysmap,
it makes more sense to collect all the ignored patterns to mksysmap.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kallsyms.c | 59 ----------------------------------------------
 scripts/mksysmap   | 43 +++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 59 deletions(-)

diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
index e572fda6fe42..97d514c0fc8f 100644
--- a/scripts/kallsyms.c
+++ b/scripts/kallsyms.c
@@ -102,65 +102,6 @@ static char *sym_name(const struct sym_entry *s)
 
 static bool is_ignored_symbol(const char *name, char type)
 {
-	/* Symbol names that exactly match to the following are ignored.*/
-	static const char * const ignored_symbols[] = {
-		"_SDA_BASE_",		/* ppc */
-		"_SDA2_BASE_",		/* ppc */
-		NULL
-	};
-
-	/* Symbol names that begin with the following are ignored.*/
-	static const char * const ignored_prefixes[] = {
-		"__efistub_",		/* arm64 EFI stub namespace */
-		"__kvm_nvhe_$",		/* arm64 local symbols in non-VHE KVM namespace */
-		"__kvm_nvhe_.L",	/* arm64 local symbols in non-VHE KVM namespace */
-		"__AArch64ADRPThunk_",	/* arm64 lld */
-		"__ARMV5PILongThunk_",	/* arm lld */
-		"__ARMV7PILongThunk_",
-		"__ThumbV7PILongThunk_",
-		"__LA25Thunk_",		/* mips lld */
-		"__microLA25Thunk_",
-		"__kcfi_typeid_",	/* CFI type identifiers */
-		NULL
-	};
-
-	/* Symbol names that end with the following are ignored.*/
-	static const char * const ignored_suffixes[] = {
-		"_from_arm",		/* arm */
-		"_from_thumb",		/* arm */
-		"_veneer",		/* arm */
-		NULL
-	};
-
-	/* Symbol names that contain the following are ignored.*/
-	static const char * const ignored_matches[] = {
-		".long_branch.",	/* ppc stub */
-		".plt_branch.",		/* ppc stub */
-		NULL
-	};
-
-	const char * const *p;
-
-	for (p = ignored_symbols; *p; p++)
-		if (!strcmp(name, *p))
-			return true;
-
-	for (p = ignored_prefixes; *p; p++)
-		if (!strncmp(name, *p, strlen(*p)))
-			return true;
-
-	for (p = ignored_suffixes; *p; p++) {
-		int l = strlen(name) - strlen(*p);
-
-		if (l >= 0 && !strcmp(name + l, *p))
-			return true;
-	}
-
-	for (p = ignored_matches; *p; p++) {
-		if (strstr(name, *p))
-			return true;
-	}
-
 	if (type == 'u' || type == 'n')
 		return true;
 
diff --git a/scripts/mksysmap b/scripts/mksysmap
index 1efd61ee0bac..d8ad6ff69320 100755
--- a/scripts/mksysmap
+++ b/scripts/mksysmap
@@ -36,6 +36,28 @@ ${NM} -n ${1} | sed >${2} -e "
 # local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
 / \.L/d
 
+# arm64 EFI stub namespace
+/ __efistub_/d
+
+# arm64 local symbols in non-VHE KVM namespace
+/ __kvm_nvhe_\$/d
+/ __kvm_nvhe_\.L/d
+
+# arm64 lld
+/ __AArch64ADRPThunk_/d
+
+# arm lld
+/ __ARMV5PILongThunk_/d
+/ __ARMV7PILongThunk_/d
+/ __ThumbV7PILongThunk_/d
+
+# mips lld
+/ __LA25Thunk_/d
+/ __microLA25Thunk_/d
+
+# CFI type identifiers
+/ __kcfi_typeid_/d
+
 # CRC from modversions
 / __crc_/d
 
@@ -45,6 +67,15 @@ ${NM} -n ${1} | sed >${2} -e "
 # EXPORT_SYMBOL (namespace)
 / __kstrtabns_/d
 
+# ---------------------------------------------------------------------------
+# Ignored suffixes
+#  (do not forget '$' after each pattern)
+
+# arm
+/_from_arm$/d
+/_from_thumb$/d
+/_veneer$/d
+
 # ---------------------------------------------------------------------------
 # Ignored symbols (exact match)
 #  (do not forget a space before and '$' after each pattern)
@@ -52,6 +83,18 @@ ${NM} -n ${1} | sed >${2} -e "
 # for LoongArch?
 / L0$/d
 
+# ppc
+/ _SDA_BASE_$/d
+/ _SDA2_BASE_$/d
+
+# ---------------------------------------------------------------------------
+# Ignored patterns
+#  (symbols that contain the pattern are ignored)
+
+# ppc stub
+/\.long_branch\./d
+/\.plt_branch\./d
+
 # ---------------------------------------------------------------------------
 # Ignored kallsyms symbols
 #
-- 
2.34.1

