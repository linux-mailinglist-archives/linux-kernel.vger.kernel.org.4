Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1A06631CA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:46:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237699AbjAIUq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjAIUqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:46:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FC6755D7;
        Mon,  9 Jan 2023 12:46:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88F6BB80FE9;
        Mon,  9 Jan 2023 20:46:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B2F0C433EF;
        Mon,  9 Jan 2023 20:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673297166;
        bh=UwE38YioG9dTqnBwoYpucHihCJ8r0LAOxRgPcDdHqlg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=md6E83gIPs0q+cIi9mPU6xAs1exMIZwpNLcjfKZj9ntwkm+sTaENDo6dkGPwVXN6U
         Xw/8oJ+EYwdci1GfgUC31xhejRtHJo4niR8nZRaLcU63lYtYHW2aPcchBBA+MiinxJ
         A4vteyRB/s7a8KGj0QknTLQlXG4ZzIfwj9M5Q2ojzSIy6b3QpJqSYhq/n4PdIKTRgy
         zx7ymJQbnBZb2e3VbPws2+xMh6/gQWxSkubLZcWkTk5GfZ80hQd9dIJeQpxzvS/q6q
         Xpg9ugardquGSdJlGp1qZTjLyy8kLpKTLvdHHON4ppoE29OE8szZZVBOPLcOeszj5N
         aV3yOENwkKJkQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>
Subject: [PATCH 6/6] kbuild: rust_is_available: normalize version matching
Date:   Mon,  9 Jan 2023 21:45:20 +0100
Message-Id: <20230109204520.539080-6-ojeda@kernel.org>
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

In order to match the version string, `sed` is used in a couple
cases, and `grep` and `head` in a couple others.

Make the script more consistent and easier to understand by
using the same method, `sed`, for all of them.

This makes the version matching also a bit more strict for
the changed cases, since the strings `rustc ` and `bindgen `
will now be required, which should be fine since `rustc`
complains if one attempts to call it with another program
name, and `bindgen` uses a hardcoded string.

In addition, clarify why one of the existing `sed` commands
does not provide an address like the others.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index a86659410e48..99811842b61f 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -66,8 +66,7 @@ fi
 # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
 rust_compiler_version=$( \
 	LC_ALL=C "$RUSTC" --version 2>/dev/null \
-		| head -n 1 \
-		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+		| sed -nE '1s:.*rustc ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
 rust_compiler_min_version=$($min_tool_version rustc)
 rust_compiler_cversion=$(get_canonical_version $rust_compiler_version)
@@ -94,8 +93,7 @@ fi
 # Non-stable and distributions' versions may have a version suffix, e.g. `-dev`.
 rust_bindings_generator_version=$( \
 	LC_ALL=C "$BINDGEN" --version 2>/dev/null \
-		| head -n 1 \
-		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
+		| sed -nE '1s:.*bindgen ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
 rust_bindings_generator_min_version=$($min_tool_version bindgen)
 rust_bindings_generator_cversion=$(get_canonical_version $rust_bindings_generator_version)
@@ -139,6 +137,9 @@ fi
 
 # `bindgen` returned successfully, thus use the output to check that the version
 # of the `libclang` found by the Rust bindings generator is suitable.
+#
+# Unlike other version checks, note that this one does not necessarily appear
+# in the first line of the output, thus no `sed` address is provided.
 bindgen_libclang_version=$( \
 	echo "$bindgen_libclang_output" \
 		| sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
-- 
2.39.0

