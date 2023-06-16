Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC39732435
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240742AbjFPAS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239209AbjFPASW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8442030DB;
        Thu, 15 Jun 2023 17:17:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 384A361CF2;
        Fri, 16 Jun 2023 00:17:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829CCC433C0;
        Fri, 16 Jun 2023 00:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686874659;
        bh=ZOoiskACd1/vXGOYvayiPERAILLvpXavPq6Glrg++uA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GP+1tsVwBh5mcRHiNI5An8ChLve9xO1BdD2bzyC/23Ch3DVUUiG1JKhE8HYRKvSCg
         YV2dlGjlO/VmOUaUPV1E7Rc8PsHNnO/Fgy7Ca+YPGmlJ2QbdtcgLwkTi54uEVaj3kV
         rqNjgVp1TlxkqbbrpFYSkuxXT7446WpwD01ShZJrOKd28OyPRPmjfZaNSJQXHKchnr
         MQDMaaHpqJcnBfX89ysrwQ+iSTZGvbyzZkRoeBJI1kYOfjzmykglvpW+v7Iw0hXKMP
         7N1QLfSrvN2FbLhuD5uwUfYutqSV71NWWLpQe4klVWglHxLU4bAq34k+1pVKOv6AXv
         DI7ok7tmxavmw==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: [PATCH v2 10/11] kbuild: rust_is_available: check that output looks as expected
Date:   Fri, 16 Jun 2023 02:16:30 +0200
Message-ID: <20230616001631.463536-11-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-1-ojeda@kernel.org>
References: <20230616001631.463536-1-ojeda@kernel.org>
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

The script already checks for `$RUSTC` and `$BINDGEN` existing
and exiting without failure. However, one may still pass an
unexpected binary that does not output what the later parsing
expects. The script still successfully reports a failure as
expected, but the error is confusing. For instance:

    $ RUSTC=true BINDGEN=bindgen CC=clang scripts/rust_is_available.sh
    scripts/rust_is_available.sh: 19: arithmetic expression: expecting primary: "100000 *  + 100 *  + "
    ***
    *** Please see Documentation/rust/quick-start.rst for details
    *** on how to set up the Rust support.
    ***

Thus add an explicit check and a proper message for unexpected
output from the called command.

Similarly, do so for the `libclang` version parsing, too.

Link: https://lore.kernel.org/rust-for-linux/CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index da8296cd9b8d..117018946b57 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -97,6 +97,15 @@ rust_compiler_version=$( \
 	echo "$rust_compiler_output" \
 		| sed -nE '1s:.*rustc ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
+if [ -z "$rust_compiler_version" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$RUSTC' to check the Rust compiler version did not return"
+	echo >&2 "*** an expected output. See output and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$rust_compiler_output"
+	echo >&2 "***"
+	exit 1
+fi
 rust_compiler_min_version=$($min_tool_version rustc)
 rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)
 rust_compiler_min_cversion=$(get_canonical_version $rust_compiler_min_version)
@@ -136,6 +145,15 @@ rust_bindings_generator_version=$( \
 	echo "$rust_bindings_generator_output" \
 		| sed -nE '1s:.*bindgen ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
+if [ -z "$rust_bindings_generator_version" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$BINDGEN' to check the bindings generator version did not return"
+	echo >&2 "*** an expected output. See output and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$rust_bindings_generator_output"
+	echo >&2 "***"
+	exit 1
+fi
 rust_bindings_generator_min_version=$($min_tool_version bindgen)
 rust_bindings_generator_cversion=$(get_canonical_version $rust_bindings_generator_version)
 rust_bindings_generator_min_cversion=$(get_canonical_version $rust_bindings_generator_min_version)
@@ -184,6 +202,16 @@ bindgen_libclang_version=$( \
 	echo "$bindgen_libclang_output" \
 		| sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
+if [ -z "$bindgen_libclang_version" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$BINDGEN' to check the libclang version (used by the Rust"
+	echo >&2 "*** bindings generator) did not return an expected output. See output"
+	echo >&2 "*** and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$bindgen_libclang_output"
+	echo >&2 "***"
+	exit 1
+fi
 bindgen_libclang_min_version=$($min_tool_version llvm)
 bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
 bindgen_libclang_min_cversion=$(get_canonical_version $bindgen_libclang_min_version)
-- 
2.41.0

