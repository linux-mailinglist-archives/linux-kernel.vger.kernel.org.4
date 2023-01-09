Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DAC6631C4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237588AbjAIUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237192AbjAIUpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:45:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF69F62FE;
        Mon,  9 Jan 2023 12:45:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52BCB61382;
        Mon,  9 Jan 2023 20:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9657BC43392;
        Mon,  9 Jan 2023 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673297152;
        bh=LCRoPeTwrC31kot3bkZJTgLAtW3tVrcvr9oxCjUlPug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=joIuxGrRRHxlz/LHzLfHL8vXgqxQ5d5ue785wVNfBHRyqPn+LRHjdIKEP/HFX11g7
         /aSF8I6k3f08NT1tgses8SiZIIMQGSXCfhDxlbQAIZqtOQINrG8wd5IiM6SPVu1mrY
         +hfesN/Di60BfYfFSuM2prNK6rRjIFadeTi2VfMk7j+BHaxsfbswTLTb/lbmOCisI9
         FcsnM6mPl7jp6AESLUgAuV6GoIeZMMMZ8P0WCyJxRYQP0kHtgbu8Z2IMqfpHdpASR9
         0lXi6CkryF3XQ41j4yLoxQMoYe3e56azmfKKpn7v2xNuDdfUBz8QrKn6mp4JCf52RQ
         pWqX0u2BBYZnA==
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
Subject: [PATCH 2/6] kbuild: rust_is_available: print docs reference
Date:   Mon,  9 Jan 2023 21:45:16 +0100
Message-Id: <20230109204520.539080-2-ojeda@kernel.org>
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

People trying out the Rust support in the kernel may get
warnings and errors from `scripts/rust_is_available.sh`
from the `rustavailable` target or the build step.

Some of those users may be following the Quick Start guide,
but others may not (likely those getting warnings from
the build step instead of the target).

While the messages are fairly clear on what the problem is,
it may not be clear how to solve the particular issue,
especially for those not aware of the documentation.

We could add all sorts of details on the script for each one,
but it is better to point users to the documentation instead,
where it is easily readable in different formats. It also
avoids duplication.

Thus add a reference to the documentation whenever the script
fails or there is at least a warning.

Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Note that is based on top of patch "kbuild: rust: remove -v
option of scripts/rust_is_available.sh" applied on v6.2-rc3:
https://lore.kernel.org/rust-for-linux/20230109061436.3146442-1-masahiroy@kernel.org/

 scripts/rust_is_available.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index eaeafebf8572..c907cf881c2c 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -21,6 +21,20 @@ get_canonical_version()
 	echo $((100000 * $1 + 100 * $2 + $3))
 }
 
+# Print a reference to the setup guide in the documentation.
+print_docs_reference()
+{
+	echo >&2 "***"
+	echo >&2 "*** Please see Documentation/rust/quick-start.rst for details"
+	echo >&2 "*** on how to setup Rust support."
+	echo >&2 "***"
+}
+
+# If the script fails for any reason, or if there was any warning, then
+# print a reference to the documentation on exit.
+warning=0
+trap 'if [ $? -ne 0 ] || [ $warning -ne 0 ]; then print_docs_reference; fi' EXIT
+
 # Check that the Rust compiler exists.
 if ! command -v "$RUSTC" >/dev/null; then
 	echo >&2 "***"
@@ -62,6 +76,7 @@ if [ "$rust_compiler_cversion" -gt "$rust_compiler_min_cversion" ]; then
 	echo >&2 "***   Your version:     $rust_compiler_version"
 	echo >&2 "***   Expected version: $rust_compiler_min_version"
 	echo >&2 "***"
+	warning=1
 fi
 
 # Check that the Rust bindings generator is suitable.
@@ -89,6 +104,7 @@ if [ "$rust_bindings_generator_cversion" -gt "$rust_bindings_generator_min_cvers
 	echo >&2 "***   Your version:     $rust_bindings_generator_version"
 	echo >&2 "***   Expected version: $rust_bindings_generator_min_version"
 	echo >&2 "***"
+	warning=1
 fi
 
 # Check that the `libclang` used by the Rust bindings generator is suitable.
@@ -128,6 +144,7 @@ if [ "$cc_name" = Clang ]; then
 		echo >&2 "***   libclang version: $bindgen_libclang_version"
 		echo >&2 "***   Clang version:    $clang_version"
 		echo >&2 "***"
+		warning=1
 	fi
 fi
 
-- 
2.39.0

