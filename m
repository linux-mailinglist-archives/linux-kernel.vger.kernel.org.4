Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602D265A33B
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 09:28:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231356AbiLaI1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 03:27:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLaI1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 03:27:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5E565EF;
        Sat, 31 Dec 2022 00:27:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C522960187;
        Sat, 31 Dec 2022 08:27:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5162C433EF;
        Sat, 31 Dec 2022 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672475267;
        bh=iBc1fAUXSFsIQMuhYma5C4ygbhkz87Qy8UNKiWljms4=;
        h=From:To:Cc:Subject:Date:From;
        b=qmwyJtYd4iMHwutdnAzXAsUJB5k52lpIU6QVX3ZUFbLJO+BPzI9guqkTi0tgHbARO
         uUNlkptiQd65qB/hZlImV3GG4pMb18FLb7frnWMX1yxsE3hl4F5D1dKOEE5AYub9yY
         JAVnnrjHVp+C2MA9jOg00BsSbjaCOQ3iqt4wF2zs1FjJrj0Ft/REN69BFJ5vBh1cJ4
         bWdGxdPUdeiBqAwldT1LFiaS/Kp/KgEQUgQPjL7iqcjevY+SlujhNs8OvaQf4ITZW0
         TQYikGYCMn607q9aM7vxdGQUpLyHxmNo5KYvUJMVAhYMBniE4fkSGVNIvu+EI5qMfH
         hDZbo74sT3U+g==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        llvm@lists.linux.dev
Subject: [PATCH] kbuild: rust: remove -v option of scripts/rust_is_available.sh
Date:   Sat, 31 Dec 2022 17:27:39 +0900
Message-Id: <20221231082739.1629735-1-masahiroy@kernel.org>
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

The -v option is passed when this scripts is invoked from Makefile,
but not when invoked from Kconfig.

As you can see in scripts/Kconfig.include, the 'success' macro suppresses
stdout and stderr anyway, so this script does not need to be quiet.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile                     |  4 +-
 scripts/rust_is_available.sh | 94 +++++++++++++++---------------------
 2 files changed, 42 insertions(+), 56 deletions(-)

diff --git a/Makefile b/Makefile
index 8daf1be6a2e4..6b2a65f1aeaf 100644
--- a/Makefile
+++ b/Makefile
@@ -1280,7 +1280,7 @@ prepare0: archprepare
 # All the preparing..
 prepare: prepare0
 ifdef CONFIG_RUST
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh -v
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh
 	$(Q)$(MAKE) $(build)=rust
 endif
 
@@ -1806,7 +1806,7 @@ $(DOC_TARGETS):
 # "Is Rust available?" target
 PHONY += rustavailable
 rustavailable:
-	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh -v && echo "Rust is available!"
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/rust_is_available.sh && echo "Rust is available!"
 
 # Documentation target
 #
diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index aebbf1913970..eaeafebf8572 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -23,21 +23,17 @@ get_canonical_version()
 
 # Check that the Rust compiler exists.
 if ! command -v "$RUSTC" >/dev/null; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Rust compiler '$RUSTC' could not be found."
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Rust compiler '$RUSTC' could not be found."
+	echo >&2 "***"
 	exit 1
 fi
 
 # Check that the Rust bindings generator exists.
 if ! command -v "$BINDGEN" >/dev/null; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Rust bindings generator '$BINDGEN' could not be found."
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Rust bindings generator '$BINDGEN' could not be found."
+	echo >&2 "***"
 	exit 1
 fi
 
@@ -53,16 +49,14 @@ rust_compiler_min_version=$($min_tool_version rustc)
 rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)
 rust_compiler_min_cversion=$(get_canonical_version $rust_compiler_min_version)
 if [ "$rust_compiler_cversion" -lt "$rust_compiler_min_cversion" ]; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Rust compiler '$RUSTC' is too old."
-		echo >&2 "***   Your version:    $rust_compiler_version"
-		echo >&2 "***   Minimum version: $rust_compiler_min_version"
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Rust compiler '$RUSTC' is too old."
+	echo >&2 "***   Your version:    $rust_compiler_version"
+	echo >&2 "***   Minimum version: $rust_compiler_min_version"
+	echo >&2 "***"
 	exit 1
 fi
-if [ "$1" = -v ] && [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
+if [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
 	echo >&2 "***"
 	echo >&2 "*** Rust compiler '$RUSTC' is too new. This may or may not work."
 	echo >&2 "***   Your version:     $rust_compiler_version"
@@ -82,16 +76,14 @@ rust_bindings_generator_min_version=$($min_tool_version bindgen)
 rust_bindings_generator_cversion=$(get_canonical_version $rust_bindings_generator_version)
 rust_bindings_generator_min_cversion=$(get_canonical_version $rust_bindings_generator_min_version)
 if [ "$rust_bindings_generator_cversion" -lt "$rust_bindings_generator_min_cversion" ]; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Rust bindings generator '$BINDGEN' is too old."
-		echo >&2 "***   Your version:    $rust_bindings_generator_version"
-		echo >&2 "***   Minimum version: $rust_bindings_generator_min_version"
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Rust bindings generator '$BINDGEN' is too old."
+	echo >&2 "***   Your version:    $rust_bindings_generator_version"
+	echo >&2 "***   Minimum version: $rust_bindings_generator_min_version"
+	echo >&2 "***"
 	exit 1
 fi
-if [ "$1" = -v ] && [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cversion" ]; then
+if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cversion" ]; then
 	echo >&2 "***"
 	echo >&2 "*** Rust bindings generator '$BINDGEN' is too new. This may or may not work."
 	echo >&2 "***   Your version:     $rust_bindings_generator_version"
@@ -110,13 +102,11 @@ bindgen_libclang_min_version=$($min_tool_version llvm)
 bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
 bindgen_libclang_min_cversion=$(get_canonical_version $bindgen_libclang_min_version)
 if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN') is too old."
-		echo >&2 "***   Your version:    $bindgen_libclang_version"
-		echo >&2 "***   Minimum version: $bindgen_libclang_min_version"
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN') is too old."
+	echo >&2 "***   Your version:    $bindgen_libclang_version"
+	echo >&2 "***   Minimum version: $bindgen_libclang_min_version"
+	echo >&2 "***"
 	exit 1
 fi
 
@@ -125,21 +115,19 @@ fi
 #
 # In the future, we might be able to perform a full version check, see
 # https://github.com/rust-lang/rust-bindgen/issues/2138.
-if [ "$1" = -v ]; then
-	cc_name=$($(dirname $0)/cc-version.sh "$CC" | cut -f1 -d' ')
-	if [ "$cc_name" = Clang ]; then
-		clang_version=$( \
-			LC_ALL=C "$CC" --version 2>/dev/null \
-				| sed -nE '1s:.*version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
-		)
-		if [ "$clang_version" != "$bindgen_libclang_version" ]; then
-			echo >&2 "***"
-			echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN')"
-			echo >&2 "*** version does not match Clang's. This may be a problem."
-			echo >&2 "***   libclang version: $bindgen_libclang_version"
-			echo >&2 "***   Clang version:    $clang_version"
-			echo >&2 "***"
-		fi
+cc_name=$($(dirname $0)/cc-version.sh "$CC" | cut -f1 -d' ')
+if [ "$cc_name" = Clang ]; then
+	clang_version=$( \
+		LC_ALL=C "$CC" --version 2>/dev/null \
+			| sed -nE '1s:.*version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
+	)
+	if [ "$clang_version" != "$bindgen_libclang_version" ]; then
+		echo >&2 "***"
+		echo >&2 "*** libclang (used by the Rust bindings generator '$BINDGEN')"
+		echo >&2 "*** version does not match Clang's. This may be a problem."
+		echo >&2 "***   libclang version: $bindgen_libclang_version"
+		echo >&2 "***   Clang version:    $clang_version"
+		echo >&2 "***"
 	fi
 fi
 
@@ -150,11 +138,9 @@ rustc_sysroot=$("$RUSTC" $KRUSTFLAGS --print sysroot)
 rustc_src=${RUST_LIB_SRC:-"$rustc_sysroot/lib/rustlib/src/rust/library"}
 rustc_src_core="$rustc_src/core/src/lib.rs"
 if [ ! -e "$rustc_src_core" ]; then
-	if [ "$1" = -v ]; then
-		echo >&2 "***"
-		echo >&2 "*** Source code for the 'core' standard library could not be found"
-		echo >&2 "*** at '$rustc_src_core'."
-		echo >&2 "***"
-	fi
+	echo >&2 "***"
+	echo >&2 "*** Source code for the 'core' standard library could not be found"
+	echo >&2 "*** at '$rustc_src_core'."
+	echo >&2 "***"
 	exit 1
 fi
-- 
2.34.1

