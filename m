Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441F36F97C1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 10:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjEGIrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 04:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEGIrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 04:47:05 -0400
X-Greylist: delayed 332 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 07 May 2023 01:47:03 PDT
Received: from dexter.1e0.uk (dexter.1e0.uk [IPv6:2a01:7e00:e002:1401::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25DE5BAD
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 01:47:03 -0700 (PDT)
From:   Matthew Leach <dev@mattleach.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mattleach.net;
        s=mail; t=1683448881;
        bh=d7c0tHXtXZTYK41BLQMysbdl49fk0po3esW2L5nenJc=;
        h=From:To:Cc:Subject:Date;
        b=id+EAaopeckeYhTESRhnYsDGfAamiYmnb6M2L7D8d6aQ485fpPB63x3jk/T0m9tvG
         /+PE034VUCNgIvNh95VQJKqvrEdm8q7RMoDJ11ds/K7H38yohWurGvMxa0WADt3yWS
         Eg6tBqpdqmdLdls9wEW87rAwk3oKH3YPCEjlVkPY=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Leach <dev@mattleach.net>
Subject: [PATCH] scripts: rust_is_available: check for empty libclang version
Date:   Sun,  7 May 2023 09:41:16 +0100
Message-Id: <20230507084116.1099067-1-dev@mattleach.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bindgen can't find libclang, then bindgen will panic with the
following error:

thread 'main' panicked at 'Unable to find libclang: "couldn't find any
valid shared libraries matching: ['libclang.so', 'libclang-*.so',
'libclang.so.*', 'libclang-*.so.*'], set the `LIBCLANG_PATH` environment
variable to a path where one of these files can be found.

This is outputted to stderr, leaving stdout empty. The empty string is
then passed to get_canonical_version and the following is show to the
user:

$ make LLVM=1 rustavailable
./scripts/rust_is_available.sh: line 21: 100000 *  + 100 *  + : syntax error: operand expected (error token is "+ ")
make: *** [Makefile:1825: rustavailable] Error 1

Note: bindgen's bad exit code isn't caught by 'set -e' since it is ran
in a subshell.

Fix this by prnting out a more helpful error message if the output of
bindgen is empty.

Signed-off-by: Matthew Leach <dev@mattleach.net>
---
 scripts/rust_is_available.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index aebbf1913970..e5478429841c 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -107,6 +107,15 @@ bindgen_libclang_version=$( \
 		| head -n 1 \
 )
 bindgen_libclang_min_version=$($min_tool_version llvm)
+if [ -z "$bindgen_libclang_version" ]; then
+	if [ "$1" = -v ]; then
+		echo >&2 "***"
+		echo >&2 "*** libclang could not be found by bindgen.  Ensure that LIBCLANG_PATH"
+		echo >&2 "*** is set correctly."
+		echo >&2 "***"
+	fi
+	exit 1;
+fi
 bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
 bindgen_libclang_min_cversion=$(get_canonical_version $bindgen_libclang_min_version)
 if [ "$bindgen_libclang_cversion" -lt "$bindgen_libclang_min_cversion" ]; then
-- 
2.39.2

