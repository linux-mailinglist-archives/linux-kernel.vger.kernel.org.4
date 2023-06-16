Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9979732427
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbjFPARQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240648AbjFPARN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:17:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08129295B;
        Thu, 15 Jun 2023 17:17:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5422C61C11;
        Fri, 16 Jun 2023 00:17:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE0AC433CD;
        Fri, 16 Jun 2023 00:17:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686874626;
        bh=i3yIt3pkJh1+yUPFZ2G1YGSS4ROB0KkdEUSk4yxp0Ss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sAANV7AatCJDD5oIOQhzC31TL4IJzbcwCNNtTfHTXGsc3Voolri0GhPM7HWCvwQry
         GQP8dhHnA592zxKc/Mw4DxvACL9NdTytHbD24ZCRu3HAXOvucHC2fFpW7xyPC8e7M7
         iksHH4m0blCrS0TicmOHejS6oghpsFXYr6DIWtuw6nu6BLqvkiyOAT7n+VHRMO21Ei
         TqqM1BRaYTvx9a13Lh57duNLrOOeuIkNbCSpWMyQbaRGWCuNLRVG0vRLdpPcVPv+QF
         qzYPXGfSoWL9l96/1MXpVS9f+PaW18l/tpp4EJnu0/sO25exf/ALSGcOM45pA4juWK
         9yHEVMxa8Ujhg==
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
Subject: [PATCH v2 03/11] docs: rust: add paragraph about finding a suitable `libclang`
Date:   Fri, 16 Jun 2023 02:16:23 +0200
Message-ID: <20230616001631.463536-4-ojeda@kernel.org>
In-Reply-To: <20230616001631.463536-1-ojeda@kernel.org>
References: <20230616001631.463536-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes users need to tweak the finding process of `libclang`
for `bindgen` via the `clang-sys`-provided environment variables.

Thus add a paragraph to the setting up guide, including a reference
to `clang-sys`'s relevant documentation.

Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 13b7744b1e27..a635be69e062 100644
--- a/Documentation/rust/quick-start.rst
+++ b/Documentation/rust/quick-start.rst
@@ -100,6 +100,23 @@ Install it via (note that this will download and build the tool from source)::
 
 	cargo install --locked --version $(scripts/min-tool-version.sh bindgen) bindgen
 
+``bindgen`` needs to find a suitable ``libclang`` in order to work. If it is
+not found (or a different ``libclang`` than the one found should be used),
+the process can be tweaked using the environment variables understood by
+``clang-sys`` (the Rust bindings crate that ``bindgen`` uses to access
+``libclang``):
+
+* ``LLVM_CONFIG_PATH`` can be pointed to an ``llvm-config`` executable.
+
+* Or ``LIBCLANG_PATH`` can be pointed to a ``libclang`` shared library
+  or to the directory containing it.
+
+* Or ``CLANG_PATH`` can be pointed to a ``clang`` executable.
+
+For details, please see ``clang-sys``'s documentation at:
+
+	https://github.com/KyleMayes/clang-sys#environment-variables
+
 
 Requirements: Developing
 ------------------------
-- 
2.41.0

