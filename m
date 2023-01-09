Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B906631C8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235313AbjAIUq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:46:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237666AbjAIUqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:46:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A06573E3A;
        Mon,  9 Jan 2023 12:46:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2979DB80FE1;
        Mon,  9 Jan 2023 20:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F207FC433F0;
        Mon,  9 Jan 2023 20:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673297162;
        bh=v6aIwGe42UpqRaNoSLoyuLZZtQ4F5eJRx+9gWWQ/eO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nU3KceGNxWBQHIw4s9cYt/+dB4mBbRCcVDxEWhD97wuWQx1pW1cuVmiFxvPG9ovqa
         LxqUYYF5JfpArpnr/OW8MnFdtsjss8Ty3NY+79and96nOyJw7ZDi0QG1HW99e1fvst
         Gywb+jPHB/nGT9VLU29DM6/QAjgWK7ILl8TDVMoxnPgBccHuG757H4SivxGK2bBnEa
         2WjPHnV4T1u27okoMT6T2s++THucuyYlW1KeKmoel2+tv4sTATR1t1zRIGjjBDDDAh
         Bzn8HdMYfZXbz6+btbSMvCHuYP3rH08v98r9FFecybgSZWb2IJU7KfqJ+0OynWfB7B
         ObscqPXnQLETw==
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
Subject: [PATCH 5/6] kbuild: rust_is_available: fix confusion when a version appears in the path
Date:   Mon,  9 Jan 2023 21:45:19 +0100
Message-Id: <20230109204520.539080-5-ojeda@kernel.org>
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

`bindgen`'s output for `libclang`'s version check contains paths, which
in turn may contain strings that look like version numbers [1]:

    .../6.1.0-dev/.../rust_is_available_bindgen_libclang.h:2:9: warning: clang version 11.1.0  [-W#pragma-messages], err: false

which the script will pick up as the version instead of the latter.

It is also the case that versions may appear after the actual version
(e.g. distribution's version text), which was the reason behind `head` [2]:

    .../rust-is-available-bindgen-libclang.h:2:9: warning: clang version 13.0.0 (Fedora 13.0.0-3.fc35) [-W#pragma-messages], err: false

Thus instead ask for a match after the `clang version` string.

Reported-by: Jordan (@jordanisaacs)
Link: https://github.com/Rust-for-Linux/linux/issues/942 [1]
Link: https://github.com/Rust-for-Linux/linux/pull/789 [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 scripts/rust_is_available.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/scripts/rust_is_available.sh b/scripts/rust_is_available.sh
index 0c082a248f15..a86659410e48 100755
--- a/scripts/rust_is_available.sh
+++ b/scripts/rust_is_available.sh
@@ -141,9 +141,7 @@ fi
 # of the `libclang` found by the Rust bindings generator is suitable.
 bindgen_libclang_version=$( \
 	echo "$bindgen_libclang_output" \
-		| grep -F 'clang version ' \
-		| grep -oE '[0-9]+\.[0-9]+\.[0-9]+' \
-		| head -n 1 \
+		| sed -nE 's:.*clang version ([0-9]+\.[0-9]+\.[0-9]+).*:\1:p'
 )
 bindgen_libclang_min_version=$($min_tool_version llvm)
 bindgen_libclang_cversion=$(get_canonical_version $bindgen_libclang_version)
-- 
2.39.0

