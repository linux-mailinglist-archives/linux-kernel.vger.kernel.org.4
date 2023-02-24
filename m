Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA146A17BD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjBXIKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjBXIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:10:04 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A2E51FB3;
        Fri, 24 Feb 2023 00:10:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7EC654206F;
        Fri, 24 Feb 2023 08:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677226201;
        bh=Vvt7C/Qtdf+lSrPhP4SxMEJD9NARvhOFIMSePHVXMBM=;
        h=From:Date:Subject:To:Cc;
        b=jtmrute9igtKAUq7bOnesWb49I1rfuWEjjkwRxjJKybIblRkkQZTa4baPo4/fvE4x
         nOr7lLn7vcdN+NebByNfjf4n4jv41zIztIBZ2CuHQlIdg9oGyGCG1o7G6LfWVykDtw
         Hhs+/R3cdHhabErr0K0T8k3Kajv16ZRCv/+LIHPfCfvCvF4sP1VPUEUO9gwFXFDJCV
         bs0iq7zEPafqj6Fwhv/L07JXKzhym+OutxZo8RsGJ9LQQrDm4dUCbVOqqpPWwR0GG6
         IZcFTA8BKfZurnVLmd3BRC1nEkqMUvPSgDQOCOLhXYGRRpzM1nw3hJqH+RFb76Oiuh
         yWT8XXSvUq8Zg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 24 Feb 2023 17:09:47 +0900
Subject: [PATCH] rust: Enable the new_uninit feature for kernel and driver
 crates
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230224-rust-new_uninit-v1-1-c951443d9e26@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAMpw+GMC/x2N0Q6CMAxFf4X02UbcIKi/QowZo0JfKmmZmhD+3
 Y3Hc25O7gZGymRwrzZQ+rDxWzJcThXEOchEyGNmcLXztXMNarIVhb7PJCy8Ymi7dvTN7dpFD7k
 aghEOGiTOpZuWdD6S4su+KL34dzz2j33/A1OafPuBAAAA
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, asahi@lists.linux.dev,
        Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677226197; l=1846;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=Vvt7C/Qtdf+lSrPhP4SxMEJD9NARvhOFIMSePHVXMBM=;
 b=iGrkIuoxuSMO1QXhhx+sDziNY0zHKFDHhoq50D0J0m6VllqYs8TOIfVBtQZng2W9DYJJ975i8
 9KKIMpiGKLNAFu65pXllS/2i9f14R8c7WE4G+ZIbAAuZsBgTFFr2esW
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unstable new_uninit feature enables various library APIs to create
uninitialized containers, such as `Box::assume_init()`. This is
necessary to build abstractions that directly initialize memory at the
target location, instead of doing copies through the stack.

Will be used by the DRM scheduler abstraction in the kernel crate, and
by field-wise initialization (e.g. using `place!()` or a future
replacement macro which may itself live in `kernel`) in driver crates.

See [1] [2] [3] for background information.

[1] https://github.com/Rust-for-Linux/linux/issues/879
[2] https://github.com/Rust-for-Linux/linux/issues/2
[3] https://github.com/rust-lang/rust/issues/63291

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/lib.rs     | 1 +
 scripts/Makefile.build | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 223564f9f0cc..1118cd3e0b5f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -17,6 +17,7 @@
 #![feature(core_ffi_c)]
 #![feature(dispatch_from_dyn)]
 #![feature(generic_associated_types)]
+#![feature(new_uninit)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index a0d5c6cca76d..0f637e1ca8dc 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := core_ffi_c
+rust_allowed_features := core_ffi_c,new_uninit
 
 rust_common_cmd = \
 	RUST_MODFILE=$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \

---
base-commit: 83f978b63fa7ad474ca22d7e2772c5988101c9bd
change-id: 20230224-rust-new_uninit-a575d34987c3

Thank you,
~~ Lina

