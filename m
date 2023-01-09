Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDAA46631C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbjAIUqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237556AbjAIUqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:46:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C063D5D0;
        Mon,  9 Jan 2023 12:45:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5ACEDB80FE1;
        Mon,  9 Jan 2023 20:45:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D07C433F2;
        Mon,  9 Jan 2023 20:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673297156;
        bh=/mRvhEXfYmI5Ul0O7z4JhnCdPQzvBa89XuNNnjPrSOQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xu9XkvS2/GRUYf6ySXBmXi7SSOMyJmp6WOLOctFABGxpIVubOVckX8L6SYSrWSn4N
         7MyXNjiO1/ywsAsw98zUeh+3JBPlUlxbtx+Iv0wl0NFwsbrPNYBZ+VCqXqSoWMA1FO
         LlFggKuclGea/ZnE4ZkoXL+lRf2xl6H24GXw5Byv0KH2tIQQ8p+I+JMLIWoWmbQu2v
         WWSlSrQlCrfsAvyOnopxDa6qddozWas+Ki2iFQessU5RUvPKwyQvKurqtvK59HE9j7
         Ldrv83+dNi5sziZL6B/I8Tdy+cTSzQTat0lJl97wYUNpZ8O7vrpZxURqMcADGuX0N4
         5UQgwR4TQGE9w==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alexandru Radovici <msg4alex@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH 3/6] kbuild: rust_is_available: add check for `bindgen` invocation
Date:   Mon,  9 Jan 2023 21:45:17 +0100
Message-Id: <20230109204520.539080-3-ojeda@kernel.org>
In-Reply-To: <20230109204520.539080-1-ojeda@kernel.org>
References: <20230109204520.539080-1-ojeda@kernel.org>
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
Reported-by: fvalenduc (@fvalenduc)
Reported-by: Alexandru Radovici <msg4alex@gmail.com>
Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
Link: https://github.com/Rust-for-Linux/linux/issues/934
Link: https://github.com/Rust-for-Linux/linux/pull/921
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index c907cf881c2c..cd87729ca3bf 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -108,8 +108,29 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cvers
 fi
 
 # Check that the `libclang` used by the Rust bindings generator is suitable.
+#
+# In order to do that, first invoke `bindgen` to get the `libclang` version
+# found by `bindgen`. This step may already fail if, for instance, `libclang`
+# is not found, thus inform the user in such a case.
+set +e
+bindgen_libclang_output=$(LC_ALL=C "$BINDGEN" $(dirname $0)/rust_is_available_bindgen_libclang.h 2>&1 >/dev/null)
+bindgen_libclang_code=$?
+set -e
+if [ $bindgen_libclang_code -ne 0 ]; then
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
2.39.0

