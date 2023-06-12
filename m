Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F37372CFCD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbjFLTpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236652AbjFLTpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:45:03 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F69E62;
        Mon, 12 Jun 2023 12:45:02 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-652328c18d5so3689956b3a.1;
        Mon, 12 Jun 2023 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686599101; x=1689191101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SqkCjzH8EDX69emqqTnSLhV/oO1OorGxyiylgKOLPhs=;
        b=n8E45iNLNI5A1fK4mNvFfCMpoJC/UvMNT0d5QOE6Ze2+RTG6LcQvPX09TZRJQOmhiN
         N/lty5wFosqnDu07ERqOtzJ7OqYw/ap3bfACWKuzood41h/dPvdPZEV/ctUpMEJzIUFy
         UoKFt6etNeGazvvHMjES5ANqcxJh/W3CT2wqG9GciZE94nHmQST/wNRU+fhCV29wW3pu
         H7PpjvRLruvaMCSFmqcRqbtjEjPtAs9F4ipuszj0HlCpbmwOsrRMefvgqboizAqyl7ht
         rsIvYELUWjTLiehFy2km7hhQBjI27Qdfg/6lv4wTsPFWrR1gt8CUpKDVANGyPjR9ulhA
         nicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686599101; x=1689191101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SqkCjzH8EDX69emqqTnSLhV/oO1OorGxyiylgKOLPhs=;
        b=BiIreOxAOSlOCJCrOjkLomFA/Lem5+/Mj4u/q62uKpUfuJPWfKvpaieDxj9ufhU8nm
         eZuyLfj2gJCMhCk7fLfxBr3KfpvD4+mkcwJEghmR3o377Jwe07qAUHOZ49VpC+MD39AK
         kU74EAz1zW2oCyH+jtemF/iKzLn9bLU80KeDsymeQlBTMJMfrBv7q8PiTj2NzDSO384A
         IKMhJenTzsGxz1eOACnu/bZweJIgCx45DOzyy2XcvNFbX5RS4K6MOtBPAjeUmM3q4/GF
         g+G6h7D93WrFcdCtNgEuYTkZtjlupNX+uHcDH1Gyyq9crCWH5MinbQmGJJJ7knCs/iNB
         zp6w==
X-Gm-Message-State: AC+VfDxhTSz662Je3zPPmzo/jArlmfa+qy7eVCXtiIOTJcXBJPM9PI9k
        UoQQXo/VkiUxZyvED4s2W0k=
X-Google-Smtp-Source: ACHHUZ4m0aYpRl01maIeL2HiWz0Am9u27+hloUxmq+d5BC1fnWyP4A9YVICUOGvFTsxMDL+syl8Hlg==
X-Received: by 2002:a05:6a21:99aa:b0:114:6f3c:4332 with SMTP id ve42-20020a056a2199aa00b001146f3c4332mr12014892pzb.24.1686599101395;
        Mon, 12 Jun 2023 12:45:01 -0700 (PDT)
Received: from fedora.. ([2409:40e2:102b:b6d8:efc7:8b57:73a7:8d1])
        by smtp.gmail.com with ESMTPSA id c8-20020aa781c8000000b0063aa1763146sm7502869pfn.17.2023.06.12.12.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 12:45:00 -0700 (PDT)
From:   Aakash Sen Sharma <aakashsensharma@gmail.com>
To:     corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com,
        wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
        bjorn3_gh@protonmail.com, nathan@kernel.org,
        ndesaulniers@google.com, trix@redhat.com, masahiroy@kernel.org,
        me@kloenk.de, aakashsensharma@gmail.com, aliceryhl@google.com,
        benno.lossin@proton.me, dev@niklasmohrin.de, lina@asahilina.net,
        hca@linux.ibm.com, rust-for-linux@vger.kernel.org
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] rust: bindgen: upgrade to 0.65.1
Date:   Tue, 13 Jun 2023 01:13:11 +0530
Message-Id: <20230612194311.24826-1-aakashsensharma@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rationale:

Upgrades bindgen to code-generation for anonymous unions, structs, and enums [7]
for LLVM-16 based toolchains.

The following upgrade also incorporates `noreturn` support from bindgen
allowing us to remove useless `loop` calls which was placed as a
workaround.

* Truncated build logs on using bindgen `v0.56.0` prior to LLVM-16 toolchain:

```
$ make rustdoc LLVM=1 CLIPPY=1 -j$(nproc)
  RUSTC L rust/core.o
  BINDGEN rust/bindings/bindings_generated.rs
  BINDGEN rust/bindings/bindings_helpers_generated.rs
  BINDGEN rust/uapi/uapi_generated.rs
thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/include/linux/compiler_types_h_146_2)" is not a valid Ident', .../proc-macro2-1.0.24/src/fallback.rs:693:9
...
thread 'main' panicked at '"ftrace_branch_data_union_(anonymous_at__/_/include/linux/compiler_types_h_146_2)" is not a valid Ident', .../proc-macro2-1.0.24/src/fallback.rs:693:9
...
```

* LLVM-16 Changes:

API changes [1] were introduced such that libclang would emit names like
"(unnamed union at compiler_types.h:146:2)" for unnamed unions, structs, and
enums whereas it previously returned an empty string.

* Bindgen Changes:

Bindgen `v0.56.0` on LLVM-16 based toolchains hence was unable to process the
anonymous union in `include/linux/compiler_types` `struct ftrace_branch_data`
and caused subsequent panics as the new `libclang` API emitted name was not
being handled. The following issue was fixed in Bindgen `v0.62.0` [2].

Bindgen `v0.58.0` changed the flags `--whitelist-*` and `--blacklist-*`
to `--allowlist-*` and `--blocklist-*` respectively [3].

Bindgen `v0.61.0` added support for `_Noreturn`, `[[noreturn]]`, `__attribute__((noreturn))` [4],
hence the empty `loop`s used to circumvent bindgen returning `!` in place of `()`
for noreturn attributes have been removed completely.

Bindgen `v0.61.0` also changed default functionality to bind `size_t` to `usize` [5] and
added the `--no-size_t-is-usize` [5] flag to not bind `size_t` as `usize`.

Bindgen `v0.65.0` removed `--size_t-is-usize` flag [6].

Link: https://github.com/llvm/llvm-project/commit/19e984ef8f49bc3ccced15621989fa9703b2cd5b [1]
Link: https://github.com/rust-lang/rust-bindgen/pull/2319 [2]
Link: https://github.com/rust-lang/rust-bindgen/pull/1990 [3]
Link: https://github.com/rust-lang/rust-bindgen/issues/2094 [4]
Link: https://github.com/rust-lang/rust-bindgen/commit/cc78b6fdb6e829e5fb8fa1639f2182cb49333569 [5]
Link: https://github.com/rust-lang/rust-bindgen/pull/2408 [6]
Closes: https://github.com/Rust-for-Linux/linux/issues/1013 [7]
Signed-off-by: Aakash Sen Sharma <aakashsensharma@gmail.com>
---
 Documentation/process/changes.rst |  2 +-
 rust/Makefile                     |  6 +++---
 rust/helpers.c                    | 13 ++++++-------
 rust/kernel/lib.rs                |  3 ---
 scripts/min-tool-version.sh       |  2 +-
 5 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index ef540865ad22..5f21c4c6cf5c 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -32,7 +32,7 @@ you probably needn't concern yourself with pcmciautils.
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
 Rust (optional)        1.62.0           rustc --version
-bindgen (optional)     0.56.0           bindgen --version
+bindgen (optional)     0.65.1           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
 binutils               2.25             ld -v
diff --git a/rust/Makefile b/rust/Makefile
index f88d108fbef0..c187c6f3a384 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -279,7 +279,7 @@ quiet_cmd_bindgen = BINDGEN $@
 	$(BINDGEN) $< $(bindgen_target_flags) \
 		--use-core --with-derive-default --ctypes-prefix core::ffi --no-layout-tests \
 		--no-debug '.*' \
-		--size_t-is-usize -o $@ -- $(bindgen_c_flags_final) -DMODULE \
+		-o $@ -- $(bindgen_c_flags_final) -DMODULE \
 		$(bindgen_target_cflags) $(bindgen_target_extra)

 $(obj)/bindings/bindings_generated.rs: private bindgen_target_flags = \
@@ -293,8 +293,8 @@ $(obj)/bindings/bindings_generated.rs: $(src)/bindings/bindings_helper.h \
 # given it is `libclang`; but for consistency, future Clang changes and/or
 # a potential future GCC backend for `bindgen`, we disable it too.
 $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_flags = \
-    --blacklist-type '.*' --whitelist-var '' \
-    --whitelist-function 'rust_helper_.*'
+    --blocklist-type '.*' --allowlist-var '' \
+    --allowlist-function 'rust_helper_.*'
 $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_cflags = \
     -I$(objtree)/$(obj) -Wno-missing-prototypes -Wno-missing-declarations
 $(obj)/bindings/bindings_helpers_generated.rs: private bindgen_target_extra = ; \
diff --git a/rust/helpers.c b/rust/helpers.c
index 121583282976..98d9ef47225b 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -122,19 +122,18 @@ void rust_helper_put_task_struct(struct task_struct *t)
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);

 /*
- * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
- * as the Rust `usize` type, so we can use it in contexts where Rust
- * expects a `usize` like slice (array) indices. `usize` is defined to be
- * the same as C's `uintptr_t` type (can hold any pointer) but not
- * necessarily the same as `size_t` (can hold the size of any single
+ * `bindgen` binds the C `size_t` type the Rust `usize` type, so we can
+ * use it in contexts where Rust expects a `usize` like slice (array) indices.
+ * `usize` is defined to be the same as C's `uintptr_t` type (can hold any pointer)
+ * but not necessarily the same as `size_t` (can hold the size of any single
  * object). Most modern platforms use the same concrete integer type for
  * both of them, but in case we find ourselves on a platform where
  * that's not true, fail early instead of risking ABI or
  * integer-overflow issues.
  *
  * If your platform fails this assertion, it means that you are in
- * danger of integer-overflow bugs (even if you attempt to remove
- * `--size_t-is-usize`). It may be easiest to change the kernel ABI on
+ * danger of integer-overflow bugs (even if you attempt to add
+ * `--no-size_t-is-usize`). It may be easiest to change the kernel ABI on
  * your platform such that `size_t` matches `uintptr_t` (i.e., to increase
  * `size_t`, because `uintptr_t` has to be at least as big as `size_t`).
  */
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index ee27e10da479..1b0dcf03b9c2 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -95,7 +95,4 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
     pr_emerg!("{}\n", info);
     // SAFETY: FFI call.
     unsafe { bindings::BUG() };
-    // Bindgen currently does not recognize `__noreturn` so `BUG` returns `()`
-    // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/issues/2094>.
-    loop {}
 }
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 20d483ec6f5f..5b80c5d3a9f8 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -30,7 +30,7 @@ rustc)
 	echo 1.62.0
 	;;
 bindgen)
-	echo 0.56.0
+	echo 0.65.1
 	;;
 *)
 	echo "$1: unknown tool" >&2
--
2.40.1

