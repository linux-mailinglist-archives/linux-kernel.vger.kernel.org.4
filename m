Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32ACE6631C0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjAIUp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:45:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjAIUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:45:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D988240;
        Mon,  9 Jan 2023 12:45:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E633E613EA;
        Mon,  9 Jan 2023 20:45:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9624C433EF;
        Mon,  9 Jan 2023 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673297149;
        bh=7uir+fpWvzx/j9KVXbIqIv40RM5gM3COk4tThC15780=;
        h=From:To:Cc:Subject:Date:From;
        b=g6N3/ydSgf1ekjlEVVfHIsbM86g99kyRUChoRdZg9dF1V/YnyOisYY37+GmhiitC0
         Jdi2fKYCxTR6yF2oF3U/V0kkuRBNpAVyrGOiqqVN4JpG6eGFBVbNFBPsOHQSc17+Vh
         lNaZxi1Dt9tvPKNvDjwQJ/6lv0fPjQGtuA3lfiiPTgOB3RZLYuYpvrrMsjEILsl8qI
         QuDZ0h1vJ7mq97UjXtbliAoUDQc6j8sjYcuAkg/KbYgpKCbjPb1lBS2UTe6sN8SZZ+
         83WGp3wKWYw6yURHS1NMI9AG1KA78Jh38A6ktiB7Obi8hyEL74pZ22Jywp1NEdzJtS
         zQWuLBcrUi58A==
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
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 1/6] docs: rust: add paragraph about finding a suitable `libclang`
Date:   Mon,  9 Jan 2023 21:45:15 +0100
Message-Id: <20230109204520.539080-1-ojeda@kernel.org>
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

Sometimes users need to tweak the finding process of `libclang`
for `bindgen` via the `clang-sys`-provided environment variables.

Thus add a paragraph to the setting up guide, including a reference
to `clang-sys`'s relevant documentation.

Link: https://lore.kernel.org/rust-for-linux/CAKwvOdm5JT4wbdQQYuW+RT07rCi6whGBM2iUAyg8A1CmLXG6Nw@mail.gmail.com/
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/quick-start.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/rust/quick-start.rst b/Documentation/rust/quick-start.rst
index 13b7744b1e27..cae21ea7de41 100644
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
+  or to the directoy containing it.
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
2.39.0

