Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A1B732431
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240813AbjFPASb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbjFPASR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:18:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B8D2962;
        Thu, 15 Jun 2023 17:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A3F09628A3;
        Fri, 16 Jun 2023 00:17:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09FCCC433C8;
        Fri, 16 Jun 2023 00:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686874655;
        bh=iTX/Tcy5uIzvUJfO9A3D/AYRTPs+VCsc4/kXRmaB9Ro=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ES+EVWrnknZ8OqSaMlle32nh0KsO+2uIP/IbiHmnD26SD+GiR3e+Wdj8GR4bpY6qo
         73zdhxQnNdXZQ5c0LP+uNPrmmtzvdv4WaMSm8JDgtvADsd25Oti6RG/snw/jsZWgvt
         GKBMINCiQejkb45HlZOx8nJWAtu9DtYuORZtGmw39ucs4n36oBViwy3LSif1dorT/S
         36R5eSs77I38dH5TDQB8sWljzsUuii/2PNGIET5KwWaVnhQ6aWM+BscB8gKAyaMKIb
         1/oKQvA4oUyaiYl1UT/KdrhqXp4NNWriCZfdx4iQbudYn4av2t4TJEwMeZuy1GxTk/
         lJhZK59GaknWw==
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
Subject: [PATCH v2 09/11] kbuild: rust_is_available: handle failures calling `$RUSTC`/`$BINDGEN`
Date:   Fri, 16 Jun 2023 02:16:29 +0200
Message-ID: <20230616001631.463536-10-ojeda@kernel.org>
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

The script already checks if `$RUSTC` and `$BINDGEN` exists via
`command`, but the environment variables may point to a
non-executable file, or the programs may fail for some other reason.
While the script successfully exits with a failure as it should,
the error given can be quite confusing depending on the shell and
the behavior of its `command`. For instance, with `dash`:

    $ RUSTC=./mm BINDGEN=bindgen CC=clang scripts/rust_is_available.sh
    scripts/rust_is_available.sh: 19: arithmetic expression: expecting primary: "100000 *  + 100 *  + "

Thus detect failure exit codes when calling `$RUSTC` and `$BINDGEN` and
print a better message, in a similar way to what we do when extracting
the `libclang` version found by `bindgen`.

Link: https://lore.kernel.org/rust-for-linux/CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index b7e0781fdea9..da8296cd9b8d 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -81,8 +81,20 @@ fi
 # Check that the Rust compiler version is suitable.
 #
 # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
+rust_compiler_output=$( \
+	LC_ALL=C "$RUSTC" --version 2>/dev/null
+) || rust_compiler_code=$?
+if [ -n "$rust_compiler_code" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$RUSTC' to check the Rust compiler version failed with"
+	echo >&2 "*** code $rust_compiler_code. See output and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$rust_compiler_output"
+	echo >&2 "***"
+	exit 1
+fi
 rust_compiler_version=$( \
-	LC_ALL=C "$RUSTC" --version 2>/dev/null \
+	echo "$rust_compiler_output" \
 		| sed -nE '1s:.*rustc ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
 rust_compiler_min_version=$($min_tool_version rustc)
@@ -108,8 +120,20 @@ fi
 # Check that the Rust bindings generator is suitable.
 #
 # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
+rust_bindings_generator_output=$( \
+	LC_ALL=C "$BINDGEN" --version 2>/dev/null
+) || rust_bindings_generator_code=$?
+if [ -n "$rust_bindings_generator_code" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$BINDGEN' to check the Rust bindings generator version failed with"
+	echo >&2 "*** code $rust_bindings_generator_code. See output and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$rust_bindings_generator_output"
+	echo >&2 "***"
+	exit 1
+fi
 rust_bindings_generator_version=$( \
-	LC_ALL=C "$BINDGEN" --version 2>/dev/null \
+	echo "$rust_bindings_generator_output" \
 		| sed -nE '1s:.*bindgen ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
 rust_bindings_generator_min_version=$($min_tool_version bindgen)
-- 
2.41.0

