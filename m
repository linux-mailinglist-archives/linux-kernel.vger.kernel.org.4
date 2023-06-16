Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62B0F73242B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240656AbjFPARb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjFPAR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:17:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E40A2D54;
        Thu, 15 Jun 2023 17:17:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1562E61C81;
        Fri, 16 Jun 2023 00:17:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC274C433C0;
        Fri, 16 Jun 2023 00:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686874636;
        bh=7JYfaB5YdtedAdhpVlS2QsZ4lLvtcfQUiWPkYmJeGc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MPhNZmP4ycgQtFC7ZZp2oX5p+P2KUHrheWE2WSgDrt/qV6o2HVQBMeL276GUbxQyW
         6XlDLgh9HcS9PXinRFmzZ7YftUzQc5Y08CkQf5dlz3UsYq4uzGrBR23rU1wm/k2Jk0
         ccW8SNDUF2HavEw23umrFV5YzKPGfASXl4OkUD/HRwMRONqPO+NOxDLj5exL1VU7H1
         D3XaorM2UgHs/tqdrrn32PwdKradxuGT72TS0WwwhcLvwfN3dAiIF/lt0aCLr36a3l
         WCvAgbDiOGVyfrZk+4K4RtHa3fb511xMzkpiHByRDfEiX+WG1JESi96AaGxDFOdpal
         bCX5sctGc8mdg==
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        =?UTF-8?q?Fran=C3=A7ois=20Valenduc?= <francoisvalenduc@gmail.com>,
        Alexandru Radovici <msg4alex@gmail.com>,
        Matthew Leach <dev@mattleach.net>
Subject: [PATCH v2 05/11] kbuild: rust_is_available: add check for `bindgen` invocation
Date:   Fri, 16 Jun 2023 02:16:25 +0200
Message-ID: <20230616001631.463536-6-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-1-ojeda@kernel.org>
References: <20230616001631.463536-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

`scripts/rust_is_available.sh` calls `bindgen` with a special
header in order to check whether the `libclang` version in use
is suitable.

However, the invocation itself may fail if, for instance, `bindgen`
cannot locate `libclang`. This is fine for Kconfig (since the
script will still fail and therefore disable Rust as it should),
but it is pretty confusing for users of the `rustavailable` target
given the error will be unrelated:

    ./scripts/rust_is_available.sh: 21: arithmetic expression: expecting primary: "100000 *  + 100 *  + "
    make: *** [Makefile:1816: rustavailable] Error 2

Instead, run the `bindgen` invocation independently in a previous
step, saving its output and return code. If it fails, then show
the user a proper error message. Otherwise, continue as usual
with the saved output.

Since the previous patch we show a reference to the docs, and
the docs now explain how `bindgen` looks for `libclang`,
thus the error message can leverage the documentation, avoiding
duplication here (and making users aware of the setup guide in
the documentation).

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
Reported-by: François Valenduc <francoisvalenduc@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/issues/934
Reported-by: Alexandru Radovici <msg4alex@gmail.com>
Closes: https://github.com/Rust-for-Linux/linux/pull/921
Reported-by: Matthew Leach <dev@mattleach.net>
Closes: https://lore.kernel.org/rust-for-linux/20230507084116.1099067-1-dev@mattleach.net/
Fixes: 78521f3399ab ("scripts: add `rust_is_available.sh`")
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 6b8131d5b547..1bdff4472cbe 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -106,8 +106,28 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cvers
 fi
 
 # Check that the `libclang` used by the Rust bindings generator is suitable.
+#
+# In order to do that, first invoke `bindgen` to get the `libclang` version
+# found by `bindgen`. This step may already fail if, for instance, `libclang`
+# is not found, thus inform the user in such a case.
+bindgen_libclang_output=$( \
+	LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null
+) || bindgen_libclang_code=$?
+if [ -n "$bindgen_libclang_code" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Running '$BINDGEN' to check the libclang version (used by the Rust"
+	echo >&2 "*** bindings generator) failed with code $bindgen_libclang_code. This may be caused by"
+	echo >&2 "*** a failure to locate libclang. See output and docs below for details:"
+	echo >&2 "***"
+	echo >&2 "$bindgen_libclang_output"
+	echo >&2 "***"
+	exit 1
+fi
+
+# `bindgen` returned successfully, thus use the output to check that the version
+# of the `libclang` found by the Rust bindings generator is suitable.
 bindgen_libclang_version=$( \
-	LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null \
+	echo "$bindgen_libclang_output" \
 		| grep -F 'clang version ' \
 		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
 		| head -n 1 \
-- 
2.41.0

