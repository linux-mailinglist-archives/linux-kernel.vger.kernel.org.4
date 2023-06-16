Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC71D73242D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbjFPARm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239772AbjFPARk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:17:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CF72D68;
        Thu, 15 Jun 2023 17:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8806261C11;
        Fri, 16 Jun 2023 00:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E332BC433C8;
        Fri, 16 Jun 2023 00:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686874640;
        bh=aBzh/Fxzic0miW7yv3POPGW0A64Wwiniim+c1dkYLiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XFjIS/yatBcC0vfZLDmGR7QeKsj8ZbBxd2HTcqyKH23qvQNMdnvuB2gh+r4kUPNUk
         4/7k93BSX25IIwWtbQtq7AXQZMsXp86kDjEZqYXgO4QnCzgSossGvhPlCZS5rmfrC5
         GDqpOAAo8ueR03U93/O3j5mEiVDAZgkocmWWw5x+WDmgxa6te+mBI3A1l5f2iOSbIU
         b0TuST7+0xT8+kzNQ578ITVzRQg8qayrqXgmEOyItmjaSaPg2nLntH3uyV/mXLZsC6
         VOj9mzgHU1iT3MlVcgRkLobHnDjp+UDFN4+hlxcP3+7h88Y0PkdbYbWl9GbGkiK90y
         JsLznxCiKIGWw==
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
Subject: [PATCH v2 06/11] kbuild: rust_is_available: check that environment variables are set
Date:   Fri, 16 Jun 2023 02:16:26 +0200
Message-ID: <20230616001631.463536-7-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-1-ojeda@kernel.org>
References: <20230616001631.463536-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes [1] users may attempt to setup the Rust support by
checking what Kbuild does and they end up finding out about
`scripts/rust_is_available.sh`. Inevitably, they run the script
directly, but unless they setup the required variables,
the result of the script is not meaningful.

We could add some defaults to the variables, but that could be
confusing for those that may override the defaults (compared
to their kernel builds), and `$CC` would not be a simple default
in any case.

Therefore, instead, explicitly check whether the expected variables
are set (`$RUSTC`, `$BINDGEN` and `$CC`). If not, print an explanation
about the fact that the script is meant to be called from Kbuild,
since that is the most likely cause for the variables not being set.

Link: https://lore.kernel.org/oe-kbuild-all/Y6r4mXz5NS0+HVXo@zn.tnic/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 1bdff4472cbe..7e0368babe64 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -28,11 +28,40 @@ print_docs_reference()
 	echo >&2 "***"
 }
 
+# Print an explanation about the fact that the script is meant to be called from Kbuild.
+print_kbuild_explanation()
+{
+	echo >&2 "***"
+	echo >&2 "*** This script is intended to be called from Kbuild."
+	echo >&2 "*** Please use the 'rustavailable' target to call it instead."
+	echo >&2 "*** Otherwise, the results may not be meaningful."
+	exit 1
+}
+
 # If the script fails for any reason, or if there was any warning, then
 # print a reference to the documentation on exit.
 warning=0
 trap 'if [ $? -ne 0 ] || [ $warning -ne 0 ]; then print_docs_reference; fi' EXIT
 
+# Check that the expected environment variables are set.
+if [ -z "${RUSTC+x}" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Environment variable 'RUSTC' is not set."
+	print_kbuild_explanation
+fi
+
+if [ -z "${BINDGEN+x}" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Environment variable 'BINDGEN' is not set."
+	print_kbuild_explanation
+fi
+
+if [ -z "${CC+x}" ]; then
+	echo >&2 "***"
+	echo >&2 "*** Environment variable 'CC' is not set."
+	print_kbuild_explanation
+fi
+
 # Check that the Rust compiler exists.
 if ! command -v "$RUSTC" >/dev/null; then
 	echo >&2 "***"
-- 
2.41.0

