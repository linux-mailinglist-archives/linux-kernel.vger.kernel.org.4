Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E71C6631C5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235040AbjAIUqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbjAIUqC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:46:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62038687A1;
        Mon,  9 Jan 2023 12:46:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27C936136C;
        Mon,  9 Jan 2023 20:46:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F42AC433D2;
        Mon,  9 Jan 2023 20:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673297159;
        bh=+4zz4idSaVuP74R5VBf82uZ0IOSqSMwHAWJZxvct/Dk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pcpNnYrYbId9bog3bv+J9Rh4LGvuYAcglUACV1lIg+8GRND1nayRRbowRjfQ3GpzQ
         +zOkim+iT26EYBITxs3imrZb9XTwcFPMWfOhYf4noT0oLelYtT0ZDTzuO7aEzqh4NQ
         YSCizcO1OwEGO/0SQ5bJ07Z1WMGAQrQqxj6Sql0C+bth7Lyu0+vQDmoVqiEJv4r00s
         lBZZvzF6om4TBinuPFGp0y6/q8mYIBTlcm3epoFPeqiEbL7eqv2xwR8LRfXrA9AjDY
         +sFUM8av4TGSSeEsYIADOdAY8z/sea/YEVg2WT3I+mAbchJFa6Qmu2ldomoBerqdet
         EUdi1PwK0wmMA==
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
Subject: [PATCH 4/6] kbuild: rust_is_available: check if the script was invoked from Kbuild
Date:   Mon,  9 Jan 2023 21:45:18 +0100
Message-Id: <20230109204520.539080-4-ojeda@kernel.org>
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

Sometimes [1] users may attempt to setup the Rust support by
checking what Kbuild does and they end up finding out about
`scripts/rust_is_available.sh`. Inevitably, they run the script
directly, but unless they setup the required variables,
the result of the script is not meaningful.

We could add some defaults to the variables, but that could be
confusing for those that may override the defaults (compared
to their kernel builds), and `$CC` would not be a simple default
in any case.

Therefore, instead, print a warning when the script detects
the user may be invoking it, by testing `$MAKEFLAGS`.

Link: https://lore.kernel.org/oe-kbuild-all/Y6r4mXz5NS0+HVXo@zn.tnic/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index cd87729ca3bf..0c082a248f15 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -35,6 +35,16 @@ print_docs_reference()
 warning=0
 trap 'if [ $? -ne 0 ] || [ $warning -ne 0 ]; then print_docs_reference; fi' EXIT
 
+# Check whether the script was invoked from Kbuild.
+if [ -z "${MAKEFLAGS+x}" ]; then
+	echo >&2 "***"
+	echo >&2 "*** This script is intended to be called from Kbuild."
+	echo >&2 "*** Please use the 'rustavailable' target to call it instead."
+	echo >&2 "*** Otherwise, the results may not be meaningful."
+	echo >&2 "***"
+	warning=1
+fi
+
 # Check that the Rust compiler exists.
 if ! command -v "$RUSTC" >/dev/null; then
 	echo >&2 "***"
-- 
2.39.0

